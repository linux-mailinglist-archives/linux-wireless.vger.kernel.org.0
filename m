Return-Path: <linux-wireless+bounces-36699-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN/vA/aeDWqC0AUAu9opvQ
	(envelope-from <linux-wireless+bounces-36699-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:45:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A32E58CE08
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EFB4314FD8C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF883DD85C;
	Wed, 20 May 2026 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA5bs6+u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB253DCD8B;
	Wed, 20 May 2026 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276011; cv=none; b=s1tPzFAaTcOJUjbL1cX7/LBaDlEbNxymYdbTFACQznEE5MHKh4IXqYo/Z3hS7AZng7XTAoAhQxUviq1PESnlSd+RGczAkfsXYWZM9GYNEHsdbGhcxbgrzx0M1XtcikhkWLeGOE424Rb2ujF3I4+9xvkKL5W81pQD/gj1e+AUFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276011; c=relaxed/simple;
	bh=GECVds6PVy5qQArWNQudsG6SbMG1H5Ihikpk5pwJxCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAAwr+mOMXaQ1D/u3U6MFaWILnwM+C80q6fZMW4hAMOAW6Kb9QZYyhuvFR2tIrZfv2PNDlF+ByUS+Vlmm76hjhVGR7GstBuTSOcLsuOWmKDvv+tJHDatQglJ4Lr4/Lda1v2DqZJ7gW/bUIu/MBO6AX+m6kFpmj1DmnmPw4i0KjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA5bs6+u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98F91F000E9;
	Wed, 20 May 2026 11:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779276004;
	bh=cvo1+nCL2Yd6S+uRcIejVau9Fo6tytiTApwPR2MFRFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JA5bs6+us1RN0XbPsIdncUCrEeUtvfruN+7z0NJ1bWztVD+s8DDkudiNFS5y71pl3
	 dDewH6zC9LPsudUHr/3WwAR1kaGfJWBdExPPQLSx5sMykMFbcuF+SG7io2m9aEvIJV
	 4V16c3vWnjhjd+PG7+N7AFFXeq+Q2FfdHHff3WI/xd9S3gT+e7Sg9bwpiXPlt6DW2W
	 s6lOtrCmYr4qt2jVkt16WDRJS0mwgCnsnjX3QuYQNuFU9Zyu9XScT0p9rE54Aa3mgP
	 k/xPYlAEjz1aiAgeVib545RQUNwjnFcQbIu4FVvJL7ixNOCSnmJ3XjTNHyeVxhPVOu
	 jHilvQZv6HoOg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-5.15] wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump() continuation
Date: Wed, 20 May 2026 07:18:46 -0400
Message-ID: <20260520111944.3424570-14-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36699-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[p:url,intel.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ntu.edu.sg:email]
X-Rspamd-Queue-Id: 5A32E58CE08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

[ Upstream commit 79240f3f6d766b342b57c32397d643e1cfa26b81 ]

NL80211_CMD_GET_SCAN is implemented as a multi-call dumpit. The first
invocation of nl80211_prepare_wdev_dump() validates the requested wdev
against the caller's netns via __cfg80211_wdev_from_attrs(). Subsequent
invocations look up the same wiphy by its global index and do not check
that the wiphy is still in the caller's netns.

Add the same filter to the continuation path. If the wiphy's netns no
longer matches the caller's, return -ENODEV and the netlink dump
machinery terminates the walk cleanly.

Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Link: https://patch.msgid.link/20260506064854.2207105-3-maoyixie.tju@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Phase Walkthrough

**Phase 1: Commit Message Forensics**
- Step 1.1 Record: Subsystem `wifi: nl80211`; action verb `re-check`;
  intent is to revalidate the wiphy net namespace during
  `nl80211_prepare_wdev_dump()` continuation.
- Step 1.2 Record: Tags are `Signed-off-by: Maoyi Xie`, `Link: https://p
  atch.msgid.link/20260506064854.2207105-3-maoyixie.tju@gmail.com`,
  `Signed-off-by: Johannes Berg`. No `Fixes`, `Reported-by`, `Tested-
  by`, `Reviewed-by`, `Acked-by`, or `Cc: stable`.
- Step 1.3 Record: The committed message says first dump invocation
  validates via `__cfg80211_wdev_from_attrs()`, but later invocations
  recover the wiphy by global index and lacked a netns check. The v3
  mailing-list patch further states the failure mode: BSS scan data can
  continue being copied from a wiphy after it moved to another netns.
- Step 1.4 Record: This is a hidden security/correctness fix, not a
  cleanup. It fixes a namespace isolation race in a multi-call netlink
  dump.

**Phase 2: Diff Analysis**
- Step 2.1 Record: One file changed, `net/wireless/nl80211.c`; commit
  stat is 12 insertions. One function changed:
  `nl80211_prepare_wdev_dump()`. Scope is single-file surgical.
- Step 2.2 Record: Before, continuation path did
  `wiphy_idx_to_wiphy(cb->args[0] - 1)`, accepted the wiphy, then
  searched `wdev_list`. After, it returns `-ENODEV` if
  `!net_eq(wiphy_net(wiphy), sock_net(cb->skb->sk))`.
- Step 2.3 Record: Bug category is race / namespace isolation /
  information disclosure. A wiphy can move netns between dumpit calls
  via `NL80211_CMD_SET_WIPHY_NETNS`.
- Step 2.4 Record: Fix quality is high: one predicate and clean error
  return before taking `wiphy.mtx`. Regression risk is low; it only
  rejects a continuation whose object no longer belongs to the caller’s
  netns.

**Phase 3: Git History**
- Step 3.1 Record: Current checkout is shallow; `git blame` attributed
  the region to a shallow boundary, so that blame is not reliable.
  Pickaxe history found the continuation-by-global-wiphy-index pattern
  in old history, including `c319d50bfcf67` (`nl80211: fix another
  nl80211_fam.attrbuf race`), contained by `v3.11-rc6`. Netns support
  for cfg80211/nl80211 was introduced by `463d018323851`, contained by
  `v2.6.32-rc1`.
- Step 3.2 Record: No `Fixes:` tag, so no tagged introducer to follow.
- Step 3.3 Record: Fetched wireless history shows the candidate
  immediately follows companion commit `15994bb0cbb8f` (`wifi: nl80211:
  require CAP_NET_ADMIN over the target netns in SET_WIPHY_NETNS`). No
  intermediate commit between them.
- Step 3.4 Record: Author has only these two fetched wireless commits.
  Committer is Johannes Berg, the nl80211/cfg80211 maintainer.
- Step 3.5 Record: No compile dependency on the companion commit, but
  logical/security context is stronger if `15994bb0cbb8f` is backported
  too.

**Phase 4: Mailing List / External Research**
- Step 4.1 Record: `b4 dig -c 79240f3f6d766...` found the v3 patch at
  the provided `patch.msgid.link` URL. `b4 dig -a` found v1 and v3; `b4
  am` showed v1, v2, v3. v3 cover says no code changes since v2 and that
  Johannes review caused comment/trailer cleanup.
- Step 4.2 Record: `b4 dig -w` shows Johannes Berg, `linux-wireless`,
  and `linux-kernel` were included.
- Step 4.3 Record: No syzbot/bugzilla report. The series cover and patch
  body provide the bug explanation and patch 1 includes a mac80211_hwsim
  reproducer for the related `SET_WIPHY_NETNS` privilege path.
- Step 4.4 Record: This is patch 2/2 in a series. Patch 1 hardens
  target-netns capability checks; patch 2 fixes dump continuation
  filtering.
- Step 4.5 Record: Lore WebFetch was blocked by Anubis; WebSearch did
  not find stable-specific discussion.

**Phase 5: Code Semantic Analysis**
- Step 5.1 Record: Modified function is `nl80211_prepare_wdev_dump()`.
- Step 5.2 Record: Exact callers are `nl80211_dump_station()`,
  `nl80211_dump_mpath()`, `nl80211_dump_mpp()`, `nl80211_dump_scan()`,
  and `nl80211_dump_survey()`.
- Step 5.3 Record: Key callees are `__cfg80211_wdev_from_attrs()`,
  `wiphy_idx_to_wiphy()`, `wiphy_net()`, `sock_net()`, `net_eq()`,
  `wiphy_to_rdev()`, and list walk over `wiphy.wdev_list`.
- Step 5.4 Record: `NL80211_CMD_GET_SCAN` maps to `nl80211_dump_scan()`
  and has no admin flag in the ops entry; `NL80211_CMD_SET_WIPHY_NETNS`
  maps to `nl80211_wiphy_netns()` with `GENL_UNS_ADMIN_PERM`.
- Step 5.5 Record: Similar dump paths `nl80211_dump_wiphy()` and
  `nl80211_dump_interface()` already filter by `net_eq(wiphy_net(...),
  sock_net(skb->sk))` each iteration.

**Phase 6: Stable Tree Analysis**
- Step 6.1 Record: The affected continuation code exists in checked tags
  `v6.19`, `v6.18`, `v6.12`, `v6.6`, `v6.1`, `v5.15`, `v5.10`, `v5.4`,
  `v4.19`, and `v4.14`.
- Step 6.2 Record: Modern stable trees have the same helper shape. Older
  trees such as `v5.4` and `v4.14` have different function
  signatures/locking, so they may need small backport adjustment.
- Step 6.3 Record: Searches in checked stable tags did not find this
  candidate or the companion commit already present.

**Phase 7: Subsystem Context**
- Step 7.1 Record: Subsystem is wireless cfg80211/nl80211, an important
  networking control-plane subsystem.
- Step 7.2 Record: `net/wireless/nl80211.c` is actively maintained;
  fetched wireless history shows this series was taken through Johannes
  Berg’s wireless tree.

**Phase 8: Impact / Risk**
- Step 8.1 Record: Affected users are systems using wireless devices
  with nl80211 netns movement support, including delegated/container
  wireless setups and mac80211_hwsim.
- Step 8.2 Record: Trigger requires a multi-call dump and a wiphy netns
  move between invocations. The related series verifies an unprivileged
  userns path when the caller has a delegated `WIPHY_FLAG_NETNS_OK`
  wiphy.
- Step 8.3 Record: Failure mode is namespace isolation breach / cross-
  netns scan-result exposure, not a crash. Severity: HIGH due
  security/isolation impact.
- Step 8.4 Record: Benefit is high for isolation correctness; risk is
  very low because the patch adds one local validation and returns an
  existing error code.

**Phase 9: Final Synthesis**
- Step 9.1 Record: Evidence for backporting: real namespace isolation
  bug, old code present across stable trees, small surgical fix,
  maintainer-applied, aligns with existing dump filtering. Evidence
  against: companion patch should also be considered, and older trees
  may require minor backport edits. Unresolved: no independent `Tested-
  by`; stable-specific lore discussion could not be fetched.
- Step 9.2 Record: Stable rules: obviously correct yes; fixes real bug
  yes; important issue yes due namespace isolation/security; small and
  contained yes; no new API/feature yes; applies cleanly or with minor
  adjustment depending on tree.
- Step 9.3 Record: No exception category applies.
- Step 9.4 Record: Backport is warranted, preferably together with
  `15994bb0cbb8f` for the complete netns hardening series.

## Verification
- Phase 1: Parsed `git show 79240f3f6d766...` and b4 v3 patch text;
  verified tags and commit body.
- Phase 2: Verified diff is one hunk in `nl80211_prepare_wdev_dump()`
  with 12 insertions.
- Phase 3: Ran `git blame`, pickaxe history, `git show` for
  `c319d50bfcf67`, `463d018323851`, companion `15994bb0cbb8f`, and
  fetched wireless history.
- Phase 4: Ran `b4 dig`, `b4 dig -a`, `b4 dig -w`, `b4 am` for v1/v2/v3,
  saved/read mbox; WebFetch to lore was blocked by Anubis.
- Phase 5: Verified callers and relevant ops entries in
  `net/wireless/nl80211.c`.
- Phase 6: Used `git grep` across stable tags to confirm affected code
  exists and checked stable logs for absence of the candidate.
- Phase 8: Severity is based on verified patch text plus code paths; no
  build or runtime test was run.

**YES**

 net/wireless/nl80211.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b94231c8441c4..ce3121b1c3319 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1146,6 +1146,18 @@ static int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
 			rtnl_unlock();
 			return -ENODEV;
 		}
+
+		/*
+		 * The first invocation validated the wdev's netns against
+		 * the caller via __cfg80211_wdev_from_attrs(). The wiphy
+		 * may have moved netns between dumpit invocations (via
+		 * NL80211_CMD_SET_WIPHY_NETNS), so re-check here.
+		 */
+		if (!net_eq(wiphy_net(wiphy), sock_net(cb->skb->sk))) {
+			rtnl_unlock();
+			return -ENODEV;
+		}
+
 		*rdev = wiphy_to_rdev(wiphy);
 		*wdev = NULL;
 
-- 
2.53.0


