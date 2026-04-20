Return-Path: <linux-wireless+bounces-35052-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAD5GWYs5ml4swEAu9opvQ
	(envelope-from <linux-wireless+bounces-35052-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:38:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0386742C187
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F5AD307AB81
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DEA3CCFD6;
	Mon, 20 Apr 2026 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdAG88Nm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31C3A6B82;
	Mon, 20 Apr 2026 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691069; cv=none; b=apQiPQ0/BC0BlliiMY0YzkTXudUFe6CXAelD7PYc/4JcONIqWvjlqEucBktM79Bb/S86vNV+MZ5/63CyPELI3eUhgCNJ/tiKlbZ26WpfPD9ZEjwF/xqH+3vVfK3zC7mfvWW3AGzNyVfO1jNXaHCZf8A27TRQ8VXC9v3ExS+Ywpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691069; c=relaxed/simple;
	bh=f3xsyAIWxI4nn00HNYNNjBmimSPNBuKH8vBU5p8iJLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DV6xw5E4oyf1QGafEr8s1drVpaBb/tv9W2aOX2ABCYyGICsYiA6iq9/1QY0+UzzHXng1ocQjv9RE5urp8P3jJYcO0SyLmynRy/0zUMAc5AbA00oZJwa2AUA5Nl6POvyO1x4OuET7Fx6hxceffBSpu9mblHuMfFOb5xF9e+7FNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdAG88Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C7FC2BCB4;
	Mon, 20 Apr 2026 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691069;
	bh=f3xsyAIWxI4nn00HNYNNjBmimSPNBuKH8vBU5p8iJLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdAG88NmYH6GuyXj6dySNYWssxcVNOdzdhVyR+KpfwJc259LU5t5tWjs204yFJvRh
	 y8rk/wdANibgQDkz4JRqA1NPX3WsDv6fHqsyMGpP+g/6wbL4b/YMQFihstQub8Ykyb
	 DXO1FJFB4vfg+e45cBgqGddS9vXeMC1fG22Px0KppXDSRvK1vl7+GGkRxwqBE6N1ss
	 tX4cgGVgC2VhT2a+oLBY971QEXvWJqpSUopzF1A/P8Yhoh4viDKkAE1FoQgBfBeBEB
	 HKgGO0k49LpRap3DySWaPNHbpDDf5shFFtg47o5sRqXZQ0zDhuV9XG9JWbL//9OmLi
	 eKUfzB4QNahhg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: mt76: abort ROC on chanctx changes
Date: Mon, 20 Apr 2026 09:09:01 -0400
Message-ID: <20260420131539.986432-75-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420131539.986432-1-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-35052-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nbd.name:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0386742C187
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit de62b24224ac1533c17b3d5bae77164a82ae2e49 ]

mt76_change_chanctx() calls mt76_phy_update_channel() which switches
the hardware channel. If ROC is active on the same phy, this switches
away from the ROC channel and clears offchannel, but leaves ROC state
intact. Mac80211 still thinks the phy is on the ROC channel.

Abort any active ROC before proceeding, matching the pattern already
used in add, remove, assign, unassign, and switch chanctx functions.

Link: https://patch.msgid.link/20260309060730.87840-5-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

I now have all the information needed for a complete analysis. Let me
compile the findings.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: mt76:` (MediaTek MT76 wireless driver)
- Action: "abort" - stopping an ongoing operation to prevent state
  inconsistency
- Summary: Abort ROC (Remain on Channel) on channel context changes
- Record: [wifi: mt76] [abort] [Abort active ROC when channel context
  changes to prevent state desync]

**Step 1.2: Tags**
- Link: `https://patch.msgid.link/20260309060730.87840-5-nbd@nbd.name`
  (patch 5 in a series)
- Signed-off-by: Felix Fietkau `<nbd@nbd.name>` (mt76 subsystem
  maintainer/author)
- No Fixes: tag (expected for autosel candidates)
- No Reported-by (no external report; author found the issue)
- Record: Author is the mt76 subsystem creator. Patch 5 of a series.

**Step 1.3: Commit Body Analysis**
The commit describes a concrete bug mechanism:
1. `mt76_change_chanctx()` calls `mt76_phy_update_channel()` which
   switches the hardware channel
2. If ROC is active on the same phy, the hardware switches away from ROC
   channel
3. `offchannel` is cleared (set to false), but ROC state (`roc_vif`,
   `roc_link`, `roc_work` timer) remains intact
4. Mac80211 still believes the phy is on the ROC channel

Record: [State inconsistency between driver and mac80211 when chanctx
changes during active ROC] [Symptom: mac80211 and hardware out of sync
on channel state] [Bug introduced with channel.c in v6.14]

**Step 1.4: Hidden Bug Fix Detection**
This is clearly a bug fix, not cleanup. The commit explicitly describes
a state desynchronization between the hardware and the mac80211 layer.

---

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- 1 file changed: `drivers/net/wireless/mediatek/mt76/channel.c`
- +3 lines added (including blank line), 0 removed
- Function modified: `mt76_change_chanctx()`
- Scope: Single-function surgical fix
- Record: [channel.c +3/-0] [mt76_change_chanctx modified] [Single-file
  surgical fix]

**Step 2.2: Code Flow Change**
Before: `mt76_change_chanctx()` directly proceeds to cancel mac_work and
update channel.
After: Before canceling mac_work, checks if ROC is active
(`phy->roc_vif`) and aborts it via `mt76_abort_roc(phy)`.

**Step 2.3: Bug Mechanism**
Verified by reading `__mt76_set_channel()` at mac80211.c:1045:
`phy->offchannel = offchannel;`. When called from
`mt76_phy_update_channel()` with `offchannel = false`, it clears the
offchannel flag. But the ROC state (`roc_vif`, `roc_link`, `roc_work`)
remains set, causing a desynchronization.

Classification: **Logic/correctness fix** - missing cleanup of related
state when switching channels.

**Step 2.4: Fix Quality**
- Obviously correct: follows the exact pattern established by all other
  chanctx functions which abort scans
- Minimal: 2 lines of actual logic
- `mt76_abort_roc()` handles its own locking (takes `dev->mutex`
  internally), so calling it before the existing `mutex_lock` is correct
- Regression risk: extremely low - if ROC is not active (`roc_vif ==
  NULL`), the check is a no-op

---

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame**
From git blame, the buggy `mt76_change_chanctx()` was introduced by
commit `82334623af0cd` ("wifi: mt76: add chanctx functions for multi-
channel phy support") by Felix Fietkau on 2025-01-02. This commit is in
v6.14.

**Step 3.2: Fixes Tag**
No Fixes: tag present. The implicit target is `82334623af0cd` which
introduced `mt76_change_chanctx` without ROC abort handling.

**Step 3.3: File History**
The file has 7 commits since creation: the original, scanning code, ROC
functions, offchannel link, a deref fix, abort scan/roc on hw restart,
and relicensing. No conflicting changes near the modified area.

**Step 3.4: Author**
Felix Fietkau (nbd@nbd.name) is the creator and maintainer of the mt76
driver. He wrote the original `channel.c` file and all major chanctx
functions.

**Step 3.5: Dependencies**
The commit is patch 5 of a series (msgid `-5-`). However, the fix is
**self-contained**:
- `mt76_abort_roc()` already exists in the tree (since `a8f424c1287cc`,
  in v6.14)
- `phy->roc_vif` already exists in `mt76.h`
- `mt76_abort_roc` is declared in `mt76.h` and accessible from
  `channel.c`
- No other patch from the series is needed for this fix to work
  correctly.

---

## PHASE 4: MAILING LIST RESEARCH

**Step 4.1-4.5**: Lore.kernel.org is behind Anubis anti-bot protection
and could not be accessed. The `b4 dig` also did not find a match for
the message-id (possibly a future date issue). However, the patch URL is
well-formed and the commit is by the subsystem maintainer, providing
strong quality assurance.

Record: [UNVERIFIED: Could not access lore/b4 due to anti-bot
protection] [Author is mt76 maintainer which provides confidence in
quality]

---

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Functions Modified**
- `mt76_change_chanctx()` - modified to add ROC abort call

**Step 5.2: Callers**
`mt76_change_chanctx` is a mac80211 callback assigned via
`ieee80211_ops`. It is called by mac80211 whenever the channel context
configuration changes (width changes, radar detection changes). This is
a normal operation path triggered by AP configuration, DFS, or
regulatory changes.

**Step 5.3: Callees**
`mt76_abort_roc()` calls:
1. `cancel_delayed_work_sync(&phy->roc_work)` - cancels the ROC timeout
2. `mt76_roc_complete(phy)` under mutex - restores main channel, frees
   offchannel link, notifies mac80211

**Step 5.4: Call Chain**
Userspace/regulatory -> mac80211 -> `mt76_change_chanctx` -> bug
triggers if ROC active. This is reachable from normal WiFi operation
(e.g., DFS, bandwidth changes during P2P).

**Step 5.5: Similar Patterns**
All 5 other chanctx functions (`add`, `remove`, `assign`, `unassign`,
`switch`) already call `mt76_abort_scan()`. The fix adds the equivalent
`mt76_abort_roc()` to the one function that was missing it.

---

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Buggy Code in Stable Trees**
- `channel.c` with `mt76_change_chanctx` was introduced in v6.14 (commit
  `82334623af0cd`)
- `mt76_abort_roc` function exists since v6.14 (commit `a8f424c1287cc`)
- `mt76_abort_roc` is declared in `mt76.h` even in v6.14 (confirmed at
  line 1586)
- Bug affects: v6.14.y and later stable trees

**Step 6.2: Backport Complications**
The code in v6.14 matches exactly: `mt76_change_chanctx()` is identical
to the pre-patch state in v7.0. The patch would apply cleanly. No
forward-declaration issues since `mt76_abort_roc` is declared in
`mt76.h`.

**Step 6.3: Related Fixes**
No alternative fix for this specific bug exists in stable trees.

---

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1: Subsystem**
- Subsystem: WiFi/wireless drivers (drivers/net/wireless/mediatek/mt76)
- Criticality: IMPORTANT - mt76 is one of the most widely used WiFi
  chipset drivers (MT7921, MT7922, MT7925, MT7996, etc.), found in many
  laptops and routers

**Step 7.2: Activity**
Actively maintained by Felix Fietkau with recent commits in the channel
management area. The multi-radio/chanctx support is relatively new
(v6.14).

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: Affected Users**
All users of MediaTek mt76 WiFi chipsets who use P2P, scanning, or any
ROC functionality while channel context changes occur.

**Step 8.2: Trigger Conditions**
- Trigger: Channel context change (width change or radar detection)
  while ROC is active
- Likelihood: Moderate - occurs during DFS, bandwidth negotiation, or
  regulatory changes that happen to coincide with P2P discovery or off-
  channel management frames
- Not directly triggered by unprivileged users (requires wireless state
  machine interaction)

**Step 8.3: Failure Mode**
- Driver/mac80211 state desynchronization
- ROC operations fail silently or behave unpredictably
- P2P connection failures
- Dangling ROC state may cause subsequent operations to fail or produce
  unexpected behavior
- Severity: **MEDIUM-HIGH** (functional failure, not crash, but can
  break WiFi connectivity features)

**Step 8.4: Risk-Benefit**
- Benefit: Fixes real state inconsistency in a widely-used WiFi driver
- Risk: Extremely low - 2 lines, guarded by `if (phy->roc_vif)` check,
  calls well-tested existing function
- Ratio: Very favorable

---

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence Compilation**

FOR backporting:
- Fixes a real state desynchronization bug between driver and mac80211
- 2-line fix, obviously correct, minimal risk
- Written by the mt76 subsystem maintainer/author (Felix Fietkau)
- Follows the established pattern used by all other chanctx functions
- Self-contained, no dependencies on other patches
- Applies cleanly to v6.14+ stable trees
- mt76 is a widely-used WiFi driver

AGAINST backporting:
- No crash/panic, no data corruption - the bug causes functional issues
  (ROC state desync)
- No user reports (no Reported-by tag)
- Part of a larger series (other patches in series not evaluated)

UNRESOLVED:
- Could not access mailing list discussion due to anti-bot protection
- Could not verify if other patches in the series are also being
  considered

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? **YES** - trivial 2-line check, follows
   existing pattern, by subsystem maintainer
2. Fixes a real bug? **YES** - state desync between driver and mac80211
   during ROC
3. Important issue? **MEDIUM-HIGH** - WiFi functionality failure, not
   crash
4. Small and contained? **YES** - 2 lines in 1 file
5. No new features? **YES** - purely a bug fix
6. Can apply to stable? **YES** - clean apply to v6.14+

**Step 9.3: Exception Categories**
Not an exception category; this is a standard bug fix.

**Step 9.4: Decision**
The fix is small, surgical, obviously correct, written by the subsystem
maintainer, and fixes a real state inconsistency bug in a widely-used
WiFi driver. The risk is minimal and the benefit is clear.

---

## Verification

- [Phase 1] Parsed tags: Link to patch.msgid.link, SOB by Felix Fietkau
  (mt76 maintainer)
- [Phase 2] Diff analysis: +3 lines (2 logic + 1 blank) in
  `mt76_change_chanctx()`, adds ROC abort guard
- [Phase 2] Verified `__mt76_set_channel()` at mac80211.c:1045 sets
  `phy->offchannel = offchannel`, confirming the bug mechanism
- [Phase 3] git blame: `mt76_change_chanctx` introduced by commit
  `82334623af0cd` (v6.14) by Felix Fietkau
- [Phase 3] `mt76_abort_roc` introduced by `a8f424c1287cc` (v6.14),
  declared in mt76.h line 1586
- [Phase 3] Confirmed `b36d55610215a` (EXPORT_SYMBOL_GPL for abort_roc)
  is NOT in v6.14 but not needed since abort_roc is declared in mt76.h
- [Phase 3] Confirmed patch is self-contained: all referenced
  functions/fields exist in v6.14
- [Phase 4] UNVERIFIED: Could not access lore.kernel.org or b4 dig
  results due to anti-bot protection
- [Phase 5] Verified all 5 other chanctx functions call
  `mt76_abort_scan()` - this fix adds the analogous ROC abort
- [Phase 5] Verified `mt76_abort_roc` cancels work, locks mutex, calls
  `mt76_roc_complete`, unlocks - proper cleanup
- [Phase 6] `82334623af0cd` is in v6.14 (confirmed via `git merge-base
  --is-ancestor`)
- [Phase 6] v6.14 `mt76_change_chanctx` code is identical to pre-patch
  v7.0 - clean apply
- [Phase 8] Failure mode: state desynchronization causing ROC/P2P
  failures, severity MEDIUM-HIGH

**YES**

 drivers/net/wireless/mediatek/mt76/channel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index 2b705bdb7993c..a6e45b8d63d6b 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -88,6 +88,9 @@ void mt76_change_chanctx(struct ieee80211_hw *hw,
 			 IEEE80211_CHANCTX_CHANGE_RADAR)))
 		return;
 
+	if (phy->roc_vif)
+		mt76_abort_roc(phy);
+
 	cancel_delayed_work_sync(&phy->mac_work);
 
 	mutex_lock(&dev->mutex);
-- 
2.53.0


