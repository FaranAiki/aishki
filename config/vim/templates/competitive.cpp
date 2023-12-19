/*
 * Created using vim's template
 *
 * Template written by Muhammad Faran Aiki
 */

#include <iostream>
#include <iomanip>

#include <bits/stdc++.h>
/*
#include <regex>
*/

typedef long long ll;
typedef unsigned long long ull;

#define loop(u) for (int i = 0; i < u; i++)
#define loopv(v, u) for (int v = 0; v < u; v++)

#define fst first
#define snd second

#define pa make_pair
#define pb push_back

#define ub upper_bound
#define lb lower_bound
#define be(x) x.begin(), x.end()

template <typename A, typename B> std::ostream& operator<<(std::ostream &os, const std::pair<A, B> &pair) { std::cout << '{' << pair.first << ", " << pair.second << '}';  return os;}
template <typename T> std::ostream& operator<<(std::ostream &os, const std::vector<T> &vec) { for (auto k : vec) std::cout << k << " "; return os;}

using namespace std;

// matrix traversal
const int dir_x[8] = {0, 1, 0, -1, 1, -1, -1, 1};
const int dir_y[8] = {-1, 0, 1, 0, 1, -1, 1, -1};

const int mod = 1000000007;

// LL SUPREMACY!!
ll a[100001];

void solve(void) {
	
}

int main() {
	ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);

	int q = 1;
	cin >> q;

	while(q--) solve();

	return 0;
}
