/** @suppress{duplicate} */
var mylib = mylib || require('./mylib');

describe('mylib', function() {
  it('adds six', function() {
    expect(mylib.publicAddSix(5)).toBe(11);
  });
});
