NUMBERS = 10000000
calls = 0

rand = (n) -> ++calls; n * Math.random() | 0

getCandidate = (randBase, nSlots) ->
  cand = 0
  for i in [0..nSlots - 1]
    cand += rand(randBase) * Math.pow(randBase, i)
  cand

compute = (newBase, oldBase, nSlots) ->

  maxBound = Math.pow(oldBase, nSlots)

  computedRand = (oldBase, newBase) ->
    cand = getCandidate oldBase, nSlots
    tmp = bucketize newBase, cand, maxBound
    if not tmp
      return computedRand oldBase, newBase
    else
      res = []
      while tmp
        res.push tmp[0]
        tmp = bucketize newBase, tmp[1], tmp[2]
      return res

    
  bucketize = (newBase, num, bound) ->
    if bound < newBase then return null
    bucketSize = Math.floor(bound / newBase)
    if num >= bucketSize * newBase
      return null
    else
      return [Math.floor(num / bucketSize), num % bucketSize, bucketSize]

  distr = (0 for i in [0..newBase-1])
  i = 0
  while i < NUMBERS
    res = computedRand(oldBase, newBase)
    for num in res
      distr[num]++; i++

  console.log distr
  console.log calls/NUMBERS

compute 31, 17, 200
