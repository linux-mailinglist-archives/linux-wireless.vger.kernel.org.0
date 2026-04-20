Return-Path: <linux-wireless+bounces-35059-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAxQLpo25mkmtgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35059-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:22:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB7342CF1B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99642311E59D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F7D3DA5C1;
	Mon, 20 Apr 2026 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxmVUNc9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F91E3DA5BB;
	Mon, 20 Apr 2026 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691441; cv=none; b=cfaGGsR1wUhkR8cEplIqEBeX7UA1vnd/m0nCUil12au4xOtVw30jyESkYaOmF9zXjFczzAwxC16J5TrXCKG6Q8VUjGtYyAAvgSM0t4xAS9rzatN/zDZJeCx19X9hXIw2ECWLpwajs7i1ZZS7h6gN9BuQ3kFpTrt3mTSwtycYScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691441; c=relaxed/simple;
	bh=7zvufrhHYV6ds7spDOco84VdhgcOR1nJgg0J/89FE9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nD0DHLMGOE2d5e3gm8Z/GX/GM2YUqi2H106jTBVhLJCJUvzqCbP/4dtx2NupeOHp5jVqTHWJg50yvo71Zql8ALxXV/ppSkMkMlRD1Xr2n6uC6s1D98JjIvv1uvD6eu/f6+nu1f9BcDCp3KNsmlp82zC5k14s/w6n89joZJvverw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxmVUNc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A44C19425;
	Mon, 20 Apr 2026 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691440;
	bh=7zvufrhHYV6ds7spDOco84VdhgcOR1nJgg0J/89FE9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WxmVUNc9LMDXO1yjAnv5Rxur/S/4YXAAQzQwFvikOWL/T3b6GsjYY8Zb6Jqn5M2Wk
	 7m35jwp8sfJ2Ux7Yojjadq+sUH50oQMZdZvUDv0aSHejJrblVydLOWNOhFDMkTdpnp
	 n7Ry3Zf9tE7cOZJG6H9Z9T7JM+aJMzuCJrU8b0yDRUXAXImsZHX+nNjLe9VjImfIKq
	 7YYFce6NZIACCOJykul7oTpzx2axiCg8D+OLUd6nZ2BxwwbXUTFCQ3kvDnoo92fD4Z
	 E/tLXrrh/OCFe14RT4GG4goNJpz8+UnPGGMVY8mE/cgCzpBa4hiWUuKXDdHg3k5w8O
	 2RFk0ffOfwM9Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.6] wifi: mac80211: set band information only for non-MLD when probing stations using NULL frame
Date: Mon, 20 Apr 2026 09:17:03 -0400
Message-ID: <20260420132314.1023554-29-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35059-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 1BB7342CF1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>

[ Upstream commit 73e7df69edb6f1271ea0fa876794761e6c73e76a ]

Currently, when sending a NULL frame to probe a station, the band
information is derived from the chanctx_conf in the mac80211 vif's
bss_conf. However, for AP MLD, chanctx_conf is not assigned to the
vif's bss_conf; instead it is assigned on a per-link basis. As a result,
for AP MLD, sending a NULL packet to probe will trigger a warning.

WARNING: net/mac80211/cfg.c:4635 at ieee80211_probe_client+0x1a8/0x1d8 [mac80211], CPU#2: hostapd/244
Call trace:
 ieee80211_probe_client+0x1a8/0x1d8 [mac80211] (P)
 nl80211_probe_client+0xac/0x170 [cfg80211]
 genl_family_rcv_msg_doit+0xc8/0x134
 genl_rcv_msg+0x200/0x280
 netlink_rcv_skb+0x38/0xf0
 genl_rcv+0x34/0x48
 netlink_unicast+0x314/0x3a0
 netlink_sendmsg+0x150/0x390
 ____sys_sendmsg+0x1f4/0x21c
 ___sys_sendmsg+0x98/0xc0
 __sys_sendmsg+0x74/0xcc
 __arm64_sys_sendmsg+0x20/0x34
 invoke_syscall.constprop.0+0x4c/0xd0
 do_el0_svc+0x3c/0xd0
 el0_svc+0x28/0xc0
 el0t_64_sync_handler+0x98/0xdc
 el0t_64_sync+0x154/0x158
---[ end trace 0000000000000000 ]---

For NULL packets sent to probe stations, set the band information only
for non-MLD, since MLD transmissions does not rely on band.

Signed-off-by: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
Link: https://patch.msgid.link/20260213100126.1414398-2-suraj.kizhakkethil@oss.qualcomm.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

I now have all the information needed for a complete analysis. Let me
compile the full report.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: mac80211`
- Action verb: "set" (conditionalize behavior)
- Summary: Set band information only for non-MLD interfaces when probing
  stations using NULL frames.

Record: [wifi: mac80211] [set/conditionalize] [Fix probe_client to
handle AP MLD correctly by skipping band derivation from vif bss_conf
chanctx_conf]

**Step 1.2: Tags**
- `Signed-off-by: Suraj P Kizhakkethil
  <suraj.kizhakkethil@oss.qualcomm.com>` — author from Qualcomm
- `Link: https://patch.msgid.link/20260213100126.1414398-2-
  suraj.kizhakkethil@oss.qualcomm.com` — mailing list patch link
- `Signed-off-by: Johannes Berg <johannes.berg@intel.com>` — mac80211
  subsystem maintainer merged this
- No Fixes: tag, no Cc: stable (expected for manual review candidates)
- No Reported-by: tag (author likely discovered it internally)

Record: Merged by Johannes Berg (mac80211 maintainer). No explicit
Fixes: tag. Qualcomm contributor.

**Step 1.3: Commit Body**
- Bug: For AP MLD, `chanctx_conf` is not assigned to the vif's
  `bss_conf` but per-link. Accessing it from
  `sdata->vif.bss_conf.chanctx_conf` returns NULL.
- Symptom: WARN_ON fires at `cfg.c:4635`, function returns -EINVAL,
  probe client functionality is completely broken for AP MLD.
- Stack trace provided: triggered via `nl80211_probe_client` ->
  `ieee80211_probe_client`, reachable from userspace hostapd.
- Root cause: The chanctx_conf architecture changed for MLD (per-link
  instead of per-vif), but this function was never updated.

Record: [WARN_ON trigger + -EINVAL return breaking probe_client for AP
MLD] [Stack trace confirms userspace reachability] [Root cause: MLD per-
link chanctx_conf not assigned at vif level]

**Step 1.4: Hidden Bug Fix Detection**
This is NOT hidden — the commit message clearly describes a warning
trigger and broken functionality. The subject says "set band information
only for non-MLD" which is effectively "fix broken AP MLD probe_client."

Record: [Direct bug fix, not disguised]

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- 1 file modified: `net/mac80211/cfg.c`
- Lines changed: +10/-5 (net +5 lines)
- Function modified: `ieee80211_probe_client()`
- Scope: single-function surgical fix

**Step 2.2: Code Flow Change**
BEFORE: Unconditionally dereferences `sdata->vif.bss_conf.chanctx_conf`
to get band. For AP MLD, chanctx_conf is NULL, triggers WARN_ON, returns
-EINVAL.

AFTER: Checks `ieee80211_vif_is_mld()` first. If MLD, sets `band = 0`
(MLD transmissions don't rely on band). If not MLD, uses the original
chanctx_conf path unchanged.

**Step 2.3: Bug Mechanism**
Category: Logic/correctness fix — missing MLD case handling.
Mechanism: The function assumed chanctx_conf is always assigned at the
vif's bss_conf level. After MLD introduction, this is only true for non-
MLD interfaces. For MLD, chanctx_conf lives per-link.

**Step 2.4: Fix Quality**
- Obviously correct: the conditional is clean and the MLD path avoids
  the NULL dereference.
- Minimal: only touches the necessary code path.
- Regression risk: Very low. Non-MLD path is completely unchanged. MLD
  path now gets `band = 0` instead of crashing.
- Merged by Johannes Berg (mac80211 maintainer), who deeply understands
  MLD architecture.

Record: [High quality, surgical fix] [Very low regression risk]

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame**
- `chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf)`
  introduced by commit `d0a9123ef548de` (2022-05-10) — "wifi: mac80211:
  move some future per-link data to bss_conf"
- This was a mechanical rename moving `chanctx_conf` from `vif` to
  `vif.bss_conf` as prep for MLD
- The probe_client function itself dates back to `06500736c5d26b`
  (2011-11-04) by Johannes Berg

Record: [chanctx_conf access moved to bss_conf in d0a9123ef548de (2022)]
[Function dates to 2011]

**Step 3.2: Fixes Tag**
No Fixes: tag present. The bug was introduced when MLD AP support was
completed, making chanctx_conf per-link but not updating this function.

**Step 3.3: File History**
Recent changes to `net/mac80211/cfg.c` are mostly unrelated (key
handling, UHR support, kmalloc changes). No related prerequisite
refactoring needed.

Record: [Standalone fix, no dependencies]

**Step 3.4: Author**
- Author: Suraj P Kizhakkethil (Qualcomm) — first commit to
  net/mac80211/
- Merged by: Johannes Berg — mac80211 maintainer/creator

Record: [Author is Qualcomm WiFi engineer; maintainer reviewed and
merged]

**Step 3.5: Prerequisites**
- Requires `ieee80211_vif_is_mld()` which exists since v6.5 (commit
  `f1871abd27641`, June 2023)
- Verified present in v6.6 and v6.12

Record: [Self-contained fix; prerequisite function exists in 6.5+]

## PHASE 4: MAILING LIST RESEARCH

**Step 4.1-4.2: Patch Discussion**
- Lore was not directly accessible (anti-bot protection)
- b4 dig could not match the message-id directly
- The patch was merged by Johannes Berg, indicating it passed his review
- The Link tag confirms it went through the standard wireless review
  process

Record: [Maintainer-reviewed and merged; lore inaccessible for detailed
discussion]

**Step 4.3: Bug Report**
No explicit Reported-by. The stack trace with hostapd suggests the
author encountered this in Qualcomm AP MLD testing.

**Step 4.4-4.5: Related Patches/Stable Discussion**
The patch message-id suggests this is patch 2 of a series, but it is
self-contained — the fix only touches `ieee80211_probe_client()` and has
no code dependencies on other patches in the series.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Functions Modified**
- `ieee80211_probe_client()` — the only function modified

**Step 5.2: Callers**
- Called via `.probe_client` in `cfg80211_ops` (line 5632 of cfg.c)
- Called from `nl80211_probe_client()` in `net/wireless/nl80211.c`
- Triggered from userspace via netlink (hostapd uses this for station
  monitoring)

Record: [Reachable from userspace via netlink; called during normal AP
operation]

**Step 5.3-5.4: Call Chain**
Userspace (hostapd) -> netlink -> `genl_rcv_msg` ->
`nl80211_probe_client` -> `ieee80211_probe_client` -> WARN_ON + return
-EINVAL

This is a HOT path for AP MLD operation — hostapd regularly probes
stations to check if they're still connected.

**Step 5.5: Similar Patterns**
Other places in mac80211 access `sdata->vif.bss_conf.chanctx_conf` (28
occurrences across mac80211). This fix addresses only the probe_client
path.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Buggy Code in Stable Trees**
- v6.6: YES — verified. The exact same buggy code exists at line 4150 in
  v6.6's cfg.c. `ieee80211_vif_is_mld()` also exists in v6.6's
  mac80211.h.
- v6.12: YES — verified. Same buggy code at line 4226. Same
  `ieee80211_vif_is_mld()`.
- v6.1: NO — `ieee80211_vif_is_mld()` does not exist in v6.1 (not an
  ancestor of v6.1). MLD was not mature enough in 6.1 to have this
  issue.

Record: [Bug affects v6.5+ stable trees, including v6.6.y and v6.12.y]

**Step 6.2: Backport Complications**
- v6.6: Minor conflict — uses `mutex_lock(&local->mtx)` instead of
  `lockdep_assert_wiphy()`. Fix code itself applies cleanly since it
  only touches the chanctx_conf logic.
- v6.12: Should apply cleanly — uses the same `lockdep_assert_wiphy()`.

Record: [v6.12: clean apply; v6.6: minor context difference in locking,
fix itself applies]

**Step 6.3: Related Fixes**
No related fixes for this specific bug already in stable.

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1: Subsystem Criticality**
- Subsystem: WiFi/mac80211 — IMPORTANT
- Used by AP/router deployments (hostapd), all WiFi-enabled devices
- AP MLD (WiFi 7) is increasingly deployed

**Step 7.2: Subsystem Activity**
Actively developed subsystem with continuous changes. MLD support is
actively being improved.

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: Affected Users**
Anyone running an AP MLD (WiFi 7 multi-link) configuration using
hostapd.

**Step 8.2: Trigger Conditions**
- Triggered during normal operation when hostapd probes client stations
- Happens automatically via hostapd's station monitoring
- Any AP MLD with connected stations will trigger this repeatedly
- Reachable from userspace (hostapd)

**Step 8.3: Failure Mode Severity**
- WARN_ON fires every time a station is probed — spams kernel log
- Function returns -EINVAL — station probing is completely non-
  functional for AP MLD
- Without probe_client, hostapd cannot determine if stations are still
  alive
- Severity: HIGH (functionality completely broken + WARN_ON spam)

**Step 8.4: Risk-Benefit Ratio**
- BENEFIT: HIGH — fixes broken AP MLD functionality, eliminates WARN_ON
  spam
- RISK: VERY LOW — 5-line net change, self-contained, maintainer-
  reviewed, non-MLD path completely unchanged

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence Summary**

FOR backporting:
- Fixes a clear, reproducible WARN_ON trigger during normal AP MLD
  operation
- Fixes broken probe_client functionality for AP MLD (returns -EINVAL)
- Small, surgical fix (+10/-5 lines)
- Merged by Johannes Berg (mac80211 maintainer/creator)
- Affects v6.6 and v6.12 stable trees (verified)
- Stack trace in commit message proves real-world trigger
- Reachable from userspace (hostapd normal operation)
- No dependencies on other patches

AGAINST backporting:
- No explicit Fixes: tag (expected for review candidates)
- No explicit Cc: stable (expected)
- Author's first mac80211 commit (but maintainer-reviewed)

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? YES — clear conditional check, stack
   trace shows testing
2. Fixes a real bug? YES — WARN_ON + broken functionality
3. Important issue? YES — breaks AP MLD station probing entirely
4. Small and contained? YES — 5 net lines, single function
5. No new features? CORRECT — only fixes existing broken path
6. Can apply to stable? YES — verified code exists in v6.6 and v6.12

**Step 9.3: Exception Categories**
Not an exception category — this is a straightforward bug fix.

**Step 9.4: Decision**
Clear YES. This fixes a real, reproducible bug that completely breaks AP
MLD probe_client functionality. The fix is small, obvious, self-
contained, and maintainer-reviewed.

## Verification

- [Phase 1] Parsed tags: Link to patch.msgid.link, merged by Johannes
  Berg (mac80211 maintainer)
- [Phase 2] Diff analysis: +10/-5 lines in single function
  `ieee80211_probe_client()`, adds MLD conditional check
- [Phase 3] git blame: chanctx_conf access introduced by d0a9123ef548de
  (2022-05-10)
- [Phase 3] git show b4487c2d0edaf: unrelated older fix (2011) for
  different warning in same function
- [Phase 3] git log --author="Suraj": no prior mac80211 commits (first
  contribution, but maintainer-reviewed)
- [Phase 4] b4 dig: unable to match exact message-id, but patch link
  confirms standard review process
- [Phase 5] Grep: `ieee80211_probe_client` called via cfg80211_ops
  `.probe_client` callback from nl80211
- [Phase 5] Stack trace: confirms userspace reachability via
  nl80211_probe_client -> hostapd
- [Phase 6] git show v6.6:net/mac80211/cfg.c: confirmed same buggy code
  at line 4150
- [Phase 6] git show v6.12:net/mac80211/cfg.c: confirmed same buggy code
  at line 4226
- [Phase 6] git show v6.6:include/net/mac80211.h: confirmed
  `ieee80211_vif_is_mld()` exists
- [Phase 6] git merge-base --is-ancestor: `ieee80211_vif_is_mld` in v6.5
  and v6.6, NOT in v6.1
- [Phase 8] Failure mode: WARN_ON trigger + -EINVAL return = broken
  functionality, severity HIGH
- UNVERIFIED: Exact mailing list discussion content (lore blocked by
  anti-bot protection)

**YES**

 net/mac80211/cfg.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b85375ceb575d..85b18f59a7821 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4629,12 +4629,17 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 
 	qos = sta->sta.wme;
 
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-	if (WARN_ON(!chanctx_conf)) {
-		ret = -EINVAL;
-		goto unlock;
+	if (ieee80211_vif_is_mld(&sdata->vif)) {
+		/* MLD transmissions must not rely on the band */
+		band = 0;
+	} else {
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+		if (WARN_ON(!chanctx_conf)) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+		band = chanctx_conf->def.chan->band;
 	}
-	band = chanctx_conf->def.chan->band;
 
 	if (qos) {
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-- 
2.53.0


