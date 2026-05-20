Return-Path: <linux-wireless+bounces-36701-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMTMNfCbDWoS0AUAu9opvQ
	(envelope-from <linux-wireless+bounces-36701-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:33:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A658C8D8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3FAB30A1345
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EC23EA960;
	Wed, 20 May 2026 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlibL9Ne"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF253E8C74;
	Wed, 20 May 2026 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276026; cv=none; b=BOsYzsAAlrYsWIESb3WKsvTCCtfLD9enDY6/WSs+tVTVNkwtPKs6yOQ/fK+wmwqsVSkYTuxhzjIkJetyxHLkfLJmQ053HaRuT1Mj79/8Cus597KVpsql6JLEo0cKrsmEQJQ2qGpkhIAGAzl8jf0m9US0pqkcAtJ2Qg9s2fc6318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276026; c=relaxed/simple;
	bh=HaYXk42WvCSIShW8FZ0bSZslAXirNKtycnqzXYI2XpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTJdM4LihslyhLcyq8mL5L+oDlilLZNnfPcY7MXsycK6auSi01MLAldAR37BDsO/+PsZE2+b+10vuy8cfAYhuakbMc0Xw6ZpA0seD5RCHr46Erfr9M0/qi3vKemeZUa0PefMRo7ixnLJ275Z3F7DCocBIyjVf4cE7Mjg4nBDiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlibL9Ne; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931601F000E9;
	Wed, 20 May 2026 11:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779276023;
	bh=0TscnOfn9uADddCIMK8c6D4QFb9H9T+ORf/YkZtdSlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SlibL9NePG197asJ4MAnkXf7NHKNhlu4sIuWJ0cRx1f3WPLKVtLdPLplAQ5WZ7eWu
	 8Eaw1b6pfCJLF0rRR7zxQQNowB4bKMG8GtUYCMTn0gokWHXaDyhq2NxowxwT4Yooop
	 ik/7Z9G2s12tjR/BuH0vPfTaW0er01UYZdoF8vvcIGxivEG0ez4ITzFRxS4yTYU25X
	 f5mV5Z3mkcfJbMidLP2pcWv2IAAbxxXLk3KecG/A8FI+46I5G6ZiD4iKAlB2ajQvv9
	 UwQGOam9/u0ml8PlYh3ffQ10MR0H31B8weQ+G+gFVbktBuKU0ZzzJL/d68O1f8femy
	 ISvavNkD867sQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-5.10] wifi: nl80211: require CAP_NET_ADMIN over the target netns in SET_WIPHY_NETNS
Date: Wed, 20 May 2026 07:18:59 -0400
Message-ID: <20260520111944.3424570-27-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520111944.3424570-1-sashal@kernel.org>
References: <20260520111944.3424570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36701-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,ntu.edu.sg:email,intel.com:email]
X-Rspamd-Queue-Id: D64A658C8D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

[ Upstream commit 15994bb0cbb8fc4879da7552ddd08c1896261c39 ]

NL80211_CMD_SET_WIPHY_NETNS dispatches with GENL_UNS_ADMIN_PERM, which
verifies that the caller has CAP_NET_ADMIN for the source netns. It
doesn't verify that the caller has CAP_NET_ADMIN over the target netns
selected by NL80211_ATTR_NETNS_FD or NL80211_ATTR_PID.

This diverges from the convention enforced in
net/core/rtnetlink.c::rtnl_get_net_ns_capable():

    /* For now, the caller is required to have CAP_NET_ADMIN in
     * the user namespace owning the target net ns.
     */
    if (!sk_ns_capable(sk, net->user_ns, CAP_NET_ADMIN))
        return ERR_PTR(-EACCES);

A user with CAP_NET_ADMIN in their own user namespace can therefore
push a wiphy into an arbitrary netns (including init_net) over which
they have no privilege.

Mirror the rtnetlink convention by requiring CAP_NET_ADMIN in the
target netns before calling cfg80211_switch_netns().

Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Link: https://patch.msgid.link/20260506064854.2207105-2-maoyixie.tju@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Phase Walkthrough

### Phase 1: Commit Message Forensics
Record: `wifi: nl80211` subsystem; action verb `require`; intent is to
require `CAP_NET_ADMIN` over the target network namespace before
`NL80211_CMD_SET_WIPHY_NETNS` moves a wiphy.

Record: Tags in the provided commit message:
`Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>`, `Link: https://patch.
msgid.link/20260506064854.2207105-2-maoyixie.tju@gmail.com`, `Signed-
off-by: Johannes Berg <johannes.berg@intel.com>`. No `Fixes:`,
`Reported-by:`, `Tested-by:`, `Reviewed-by:`, or `Cc: stable` tag was
present in the provided message.

Record: The described bug is an authorization gap. `GENL_UNS_ADMIN_PERM`
verifies `CAP_NET_ADMIN` for the netlink socket/source netns, but
`NL80211_ATTR_NETNS_FD` / `NL80211_ATTR_PID` selects a target netns that
was not separately checked. The b4-fetched cover letter includes a
concrete reproducer with `mac80211_hwsim`: a caller privileged only in
its own user namespace can move a delegated wiphy back into `init_net`.

Record: This is not a hidden cleanup fix; it is an explicit
security/permission bug fix.

### Phase 2: Diff Analysis
Record: One file changed, `net/wireless/nl80211.c`, with 13 insertions
in `nl80211_wiphy_netns()`. Scope is a single-function surgical fix.

Record: Before: after resolving the target netns and checking
`IS_ERR(net)`, the function directly called `cfg80211_switch_netns()` if
the wiphy was not already in that netns. After: it first checks
`ns_capable(net->user_ns, CAP_NET_ADMIN)`, drops the netns reference
with `put_net(net)`, and returns `-EPERM` on failure.

Record: Bug category is security authorization / logic correctness. The
missing check allowed a source-netns-capable caller to affect a
different target netns without privilege there.

Record: Fix quality is high: small, localized, follows the verified
rtnetlink convention in `rtnl_get_net_ns_capable()`, and preserves
reference cleanup. Regression risk is low and limited to denying
previously accepted unauthorized cross-netns moves.

### Phase 3: Git History Investigation
Record: `git blame` on the current stable checkout blamed the function
body to a repository snapshot-style commit, so it was not useful for
introduction history. `git log v2.6.29..v2.6.32 -S...` found the
command/function introduced by `463d018323851` (`cfg80211: make aware of
net namespaces`), first contained in `v2.6.32-rc1`.

Record: No `Fixes:` tag is present, so there was no tagged commit to
follow.

Record: Recent local `net/wireless/nl80211.c` history showed unrelated
wireless fixes/conversions and no existing equivalent target-netns
capability fix.

Record: No local prior `Maoyi Xie` commits were found under
`net/wireless`. `MAINTAINERS` verifies Johannes Berg as maintainer for
`802.11 (including CFG80211/NL80211)`, and the patch was addressed to
Johannes on linux-wireless.

Record: No code dependency was found for this patch. It is patch 1/2 in
the submitted series; patch 2 is related namespace hardening, but patch
1 is standalone for the direct permission bypass.

### Phase 4: Mailing List And External Research
Record: No commit hash was provided and the exact subject was not found
in local `master`, `wireless-next`, `net-next`, or `fixes-next`, so `b4
dig -c <commit>` was not applicable. I used the provided message-id with
`b4 am`/`b4 mbox`.

Record: `b4 am` found `[PATCH v3 0/2] wifi: nl80211: tighten netns
handling in SET_WIPHY_NETNS and dump continuation`, including this patch
as `v3 1/2`. `b4 am -c` did not report a newer revision. Attempts to
fetch v1/v2 directly with `b4 -v 1/-v 2` did not find those revisions,
but the v3 cover records that patch 1 was unchanged since v1.

Record: The full mbox contained three messages: cover, patch 1, patch 2.
It did not contain reviewer reply messages, but the cover records
Johannes review feedback about trailers/comment wording and says no code
changes since v2.

Record: Original recipients were Johannes Berg, `linux-
wireless@vger.kernel.org`, and `linux-kernel@vger.kernel.org`. No stable
nomination or NAK was found in the fetched mbox. Lore WebFetch searches
were blocked by Anubis, so stable-list discussion could not be
independently verified through WebFetch.

### Phase 5: Code Semantic Analysis
Record: Modified function: `nl80211_wiphy_netns()`.

Record: Caller surface: the only direct reference is the generic-netlink
op for `NL80211_CMD_SET_WIPHY_NETNS`; `genl_family_rcv_msg()` checks
`GENL_UNS_ADMIN_PERM` against `net->user_ns`, then
`genl_family_rcv_msg_doit()` calls `ops->doit()`, reaching
`nl80211_wiphy_netns()` from userspace netlink.

Record: Key callees: `get_net_ns_by_pid()`, `get_net_ns_by_fd()`, new
`ns_capable(net->user_ns, CAP_NET_ADMIN)`, `cfg80211_switch_netns()`,
and `put_net()`. `cfg80211_switch_netns()` moves associated wireless
netdevs with `dev_change_net_namespace()` and updates `wiphy_net_set()`.

Record: Reachability is verified by the op table and by the b4 cover’s
PoC. A userspace caller can trigger the path by sending
`NL80211_CMD_SET_WIPHY_NETNS` with target PID or netns fd.

Record: Similar convention verified in `rtnl_get_net_ns_capable()`,
which checks target `net->user_ns` before using another netns.

### Phase 6: Stable Tree Analysis
Record: The vulnerable handler/op shape exists in `v5.4`, `v5.10`,
`v5.15`, `v6.1`, `v6.6`, `v6.12`, `v6.19`, and current `7.0.y`, with no
`ns_capable(net->user_ns, CAP_NET_ADMIN)` check in the handler.

Record: `v3.18` has `NL80211_CMD_SET_WIPHY_NETNS`, but uses
`GENL_ADMIN_PERM`, so the unprivileged-user-namespace aspect is not the
same there. For active modern stable trees, the issue is present.

Record: `git apply --check` of the fetched v3 mbox succeeds on the
current `7.0.y` checkout. Older stable trees have line offsets and minor
surrounding differences, but the same local hunk context exists at least
in `v5.4`; expected backport difficulty is clean or minor-context-only.

Record: No related local fix already present was found by subject/grep
searches.

### Phase 7: Subsystem Context
Record: Subsystem is cfg80211/nl80211 wireless configuration.
Criticality is IMPORTANT: it is not core-mm/VFS, but it is a userspace-
facing network configuration and permission boundary.

Record: The wireless subsystem is active in local history, with recent
cfg80211/nl80211-adjacent fixes.

### Phase 8: Impact And Risk
Record: Affected users are systems with cfg80211/nl80211, network
namespaces/user namespaces, and a `WIPHY_FLAG_NETNS_OK` wiphy. Verified
examples include `mac80211` and drivers setting the flag such as
`brcmfmac`, `mwifiex`, and `qtnfmac`.

Record: Trigger requires the caller to hold a movable wiphy in its own
netns and pass a target netns fd or pid. The b4 cover verifies this is
reachable from an unprivileged user namespace after legitimate admin
delegation using `mac80211_hwsim`.

Record: Failure mode is a security/namespace isolation violation:
unauthorized movement of a wiphy into a netns, including `init_net`,
where the caller lacks privilege. Severity is HIGH because it bypasses
kernel namespace permission boundaries.

Record: Benefit is high for stable users because it closes a concrete
privilege boundary bug. Risk is low: 13 lines, one function, no new API,
no data structure change, and only unauthorized operations change
behavior.

### Phase 9: Final Synthesis
Record: Evidence for backporting: real security/authorization bug,
concrete PoC in the submitted cover, reachable userspace netlink
command, vulnerable code present across modern stable trees, small
contained fix, and it mirrors an existing rtnetlink convention.

Record: Evidence against backporting: no `Fixes:`/stable tag, no fetched
reviewer reply carrying an explicit stable nomination, and the exact
applied commit hash was not present in local searched branches. These do
not outweigh the verified technical issue.

Record: Unresolved: I could not verify the final applied commit object
or run `b4 dig -c` because no commit hash was provided and local branch
searches did not find the subject. WebFetch to lore/stable was blocked
by Anubis. I did not run the runtime PoC or a kernel build.

Stable rules checklist:
1. Obviously correct and tested: yes by inspection; PoC result described
   in b4 cover, though not locally rerun.
2. Fixes a real bug affecting users: yes, verified missing target-netns
   authorization.
3. Important issue: yes, security/namespace permission bypass.
4. Small and contained: yes, one function, 13 added lines.
5. No new features or APIs: yes.
6. Can apply to stable: yes for current `7.0.y`; older active stable
   trees likely clean/minor context based on matching code.

Exception category: none. This is not a device ID/quirk/build/doc fix;
it is a security permission fix.

## Verification
- [Phase 1] Parsed provided subject/tags and b4-fetched patch/cover;
  found no `Fixes:`, `Reported-by:`, `Tested-by:`, `Reviewed-by:`, or
  stable tag.
- [Phase 2] Compared provided diff and b4 mbox patch; confirmed 13 lines
  added to `nl80211_wiphy_netns()`.
- [Phase 3] `git blame -L` was not useful due snapshot-style history;
  `git log v2.6.29..v2.6.32 -S...` found `463d018323851`, first
  contained in `v2.6.32-rc1`.
- [Phase 3] `git log --author='Maoyi Xie' -- net/wireless` found no
  local prior commits.
- [Phase 3] `MAINTAINERS` confirms Johannes Berg maintains `802.11
  (including CFG80211/NL80211)`.
- [Phase 4] `b4 am` found v3 2-patch series and the supplied patch
  message-id.
- [Phase 4] `b4 am -c` found no newer revision.
- [Phase 4] `b4 mbox` saved the full 3-message thread; no stable
  nomination or NAK was present there.
- [Phase 5] `rg` confirmed `nl80211_wiphy_netns()` is reached via the
  `NL80211_CMD_SET_WIPHY_NETNS` generic-netlink op.
- [Phase 5] Read `genetlink.c`; confirmed `GENL_UNS_ADMIN_PERM` checks
  `net->user_ns` before calling `ops->doit()`.
- [Phase 5] Read `cfg80211_switch_netns()`; confirmed it moves wireless
  netdevs and changes the wiphy netns.
- [Phase 6] Checked `v5.4`, `v5.10`, `v5.15`, `v6.1`, `v6.6`, `v6.12`,
  `v6.19`, and current `7.0.y`; all have the handler/op without the
  target `ns_capable()` check.
- [Phase 6] `git apply --check` of the b4 mbox succeeded on current
  `7.0.y`.
- [Phase 8] `rg WIPHY_FLAG_NETNS_OK` verified affected mac80211 and
  several wireless drivers expose movable wiphys.
- UNVERIFIED: exact final commit SHA and final applied-object metadata,
  because the subject was not found in local searched branches.
- UNVERIFIED: stable-list discussion via WebFetch, because lore WebFetch
  returned Anubis anti-bot pages.
- UNVERIFIED: local runtime PoC/build; not performed.

This should be backported to stable kernel trees that contain the
`GENL_UNS_ADMIN_PERM` version of `NL80211_CMD_SET_WIPHY_NETNS`,
especially active v5.4+ stable/LTS trees.

**YES**

 net/wireless/nl80211.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ce3121b1c3319..13c2943ad3e4b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13568,6 +13568,19 @@ static int nl80211_wiphy_netns(struct sk_buff *skb, struct genl_info *info)
 	if (IS_ERR(net))
 		return PTR_ERR(net);
 
+	/*
+	 * The caller already has CAP_NET_ADMIN over the source netns
+	 * (enforced by GENL_UNS_ADMIN_PERM on the genl op). Mirror the
+	 * convention used by net/core/rtnetlink.c::rtnl_get_net_ns_capable()
+	 * and require CAP_NET_ADMIN over the target netns as well, so that
+	 * a caller that is privileged in their own user namespace cannot
+	 * push a wiphy into a netns where they have no privilege.
+	 */
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+		put_net(net);
+		return -EPERM;
+	}
+
 	err = 0;
 
 	/* check if anything to do */
-- 
2.53.0


