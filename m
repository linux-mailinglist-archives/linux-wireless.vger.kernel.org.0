Return-Path: <linux-wireless+bounces-35067-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EbrEl815mkGtgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35067-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:17:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6242CD70
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 357A4325C319
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0291402421;
	Mon, 20 Apr 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neXXSwAQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7D3C2774;
	Mon, 20 Apr 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691615; cv=none; b=N17zUaB0dHbkbioA0o2j79PsTAvtETtyBRSTiC9TCiUps2OM8yuH4+jmjItGPZixWAKA47u3ZtnlkCDP/Qv23O0sDr3SDauOhtg3wFuFPFwhN3euQJsGxn1ELJx5W6ZQZPm2rzHVWu6s2/cj9BO8GWaPrxGfOS8yvreF4bsenVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691615; c=relaxed/simple;
	bh=lvprfbB01I18sedYaWfCdlV6iPrbvpdfqaJ/v+yx68U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aa8uGVacBltdHvEU8g+HT1p+dWwWfniWHKGOqzhJclcN0hm9ecRhfQz0aXcCfZ6qLYmcRXt39k624OY+gUXxpX0hRbcpxNXcGzmfcWv8SQzMzIPthMmzsqDyP2d2UH9DTkmy/hgdUAJKkYsDFrQYZ0d6xTx8winnqsT/LSihSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neXXSwAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233C1C2BCB7;
	Mon, 20 Apr 2026 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691615;
	bh=lvprfbB01I18sedYaWfCdlV6iPrbvpdfqaJ/v+yx68U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=neXXSwAQg4h4qvYrAydskHN36qOlXIZS5rUWkx+BsV95/olQ621EjZDvooBl+Ct+P
	 F53zUUFC3ibKM4pP/HFW2MZfljGpDt71ncgsCXBq9HleAFUylSNc/FmATK5keyAOAR
	 d9uZdiEb5yPPF5y+D5Vi+l02iQ7v3C8s3p87VoG1tuxvzROzvETn0JBiS0293vH8vi
	 xcNRrzdl41MCx+Heqt2lJ7uiZ9x63v4piLlq2SmU2pMB5oi29yU1JZUEpRyBec7d1t
	 cbwhjpFj/m1YxRA2LRfOabpq5sfMG/fzl1b3ISXtQIjaSl+O43Wa2mC4AFqTMXixWe
	 hj8Oik1kJEoww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zac Bowling <zac@zacbowling.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 7.0-6.6] wifi: mt76: fix list corruption in mt76_wcid_cleanup
Date: Mon, 20 Apr 2026 09:18:47 -0400
Message-ID: <20260420132314.1023554-133-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35067-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zacbowling.com,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nbd.name:email,msgid.link:url]
X-Rspamd-Queue-Id: 91B6242CD70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zac Bowling <zac@zacbowling.com>

[ Upstream commit 34163942195410372fb138bea806c9b34e2f5257 ]

mt76_wcid_cleanup() was not removing wcid entries from sta_poll_list
before mt76_reset_device() reinitializes the master list. This leaves
stale pointers in wcid->poll_list, causing list corruption when
mt76_wcid_add_poll() later checks list_empty() and tries to add the
entry back.

The fix adds proper cleanup of poll_list in mt76_wcid_cleanup(),
matching how tx_list is already handled. This is similar to what
mt7996_mac_sta_deinit_link() already does correctly.

Fixes list corruption warnings like:
  list_add corruption. prev->next should be next (ffffffff...)

Signed-off-by: Zac Bowling <zac@zacbowling.com>
Link: https://patch.msgid.link/20260120201043.38225-3-zac@zacbowling.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

I now have all the information needed for the full analysis. Let me
compile the findings.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: wifi: mt76 (MediaTek WiFi driver)
- **Action verb**: "fix" - explicitly a bug fix
- **Summary**: Fix list corruption in `mt76_wcid_cleanup()`

Record: [wifi: mt76] [fix] [list corruption in mt76_wcid_cleanup causing
stale pointers after reset]

### Step 1.2: Tags
- **Signed-off-by**: Zac Bowling <zac@zacbowling.com> (author)
- **Link**:
  https://patch.msgid.link/20260120201043.38225-3-zac@zacbowling.com
  (original submission)
- **Signed-off-by**: Felix Fietkau <nbd@nbd.name> (mt76 subsystem
  maintainer - applied the patch)
- No Fixes: tag (expected for manual review candidates)
- No Cc: stable tag (expected)

Record: Patch was applied by subsystem maintainer Felix Fietkau, who is
the author of the surrounding code. This is a strong signal the fix is
correct.

### Step 1.3: Commit Body Analysis
The commit clearly explains the bug:
1. `mt76_wcid_cleanup()` does not remove wcid entries from
   `sta_poll_list`
2. `mt76_reset_device()` reinitializes the master `sta_poll_list` with
   `INIT_LIST_HEAD`
3. This leaves `wcid->poll_list` with stale prev/next pointers
4. When `mt76_wcid_add_poll()` later checks `list_empty()` and does
   `list_add_tail()`, list corruption occurs

**Symptom**: `list_add corruption. prev->next should be next
(ffffffff...)` - a kernel WARNING/BUG

Record: Clear list corruption bug during hardware restart. The failure
mode is a kernel list corruption warning, which indicates corrupted
linked list pointers. This can lead to crashes or undefined behavior.

### Step 1.4: Hidden Bug Fix Detection
This is NOT a hidden fix - it explicitly says "fix list corruption" and
describes the exact mechanism.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **Files changed**: 1 (`drivers/net/wireless/mediatek/mt76/mac80211.c`)
- **Lines added**: ~7 (5 lines of code + 4 lines of comment)
- **Lines removed**: 0
- **Functions modified**: `mt76_wcid_cleanup()`
- **Scope**: Single-file, single-function, surgical fix

Record: Very small, contained change. +10 lines (including comments),
single function.

### Step 2.2: Code Flow Change
**Before**: `mt76_wcid_cleanup()` cleaned up `tx_list`, `tx_pending`,
`tx_offchannel`, and `pktid` but NOT `poll_list`.

**After**: `mt76_wcid_cleanup()` also removes the wcid from
`sta_poll_list` using the proper `spin_lock_bh(&dev->sta_poll_lock)` /
`list_del_init()` pattern, matching how `tx_list` is handled (lines
1721-1722).

### Step 2.3: Bug Mechanism
This is a **list corruption / stale pointer bug**:
1. `mt76_reset_device()` calls `mt76_wcid_cleanup()` for each wcid (line
   848)
2. After the loop, it does `INIT_LIST_HEAD(&dev->sta_poll_list)` (line
   854) - reinitializes the list head
3. Any wcid still linked to `sta_poll_list` now has stale prev/next
   pointers
4. Later `mt76_wcid_add_poll()` (line 1747) checks `list_empty()` on the
   stale entry, gets a bogus result, and triggers list corruption when
   trying to add

The fix adds the missing cleanup. This matches the established pattern -
every other caller of `mt76_wcid_cleanup()` (mt7996, mt7915, mt792x,
mt7615, mt7603) removes the wcid from poll_list BEFORE calling
`mt76_wcid_cleanup()`. Only the `mt76_reset_device()` path was missing
this.

### Step 2.4: Fix Quality
- **Obviously correct**: Yes. It adds `list_del_init()` under the same
  lock, matching the exact pattern used by ALL individual driver callers
  and matching how `tx_list` is already handled in the same function.
- **Minimal**: Yes. 5 lines of code, 4 lines of comment.
- **Regression risk**: Very low. Adding a properly locked
  `list_del_init()` is safe. The `list_empty()` check prevents double-
  delete. The init ensures the poll_list is in a clean state.

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
- `mt76_wcid_cleanup()` was introduced by commit `0335c034e7265d` (Felix
  Fietkau, 2023-08-29)
- `poll_list` initialization in `mt76_wcid_init` was added by
  `cbf5e61da66028` (Felix Fietkau, 2025-01-02)
- `mt76_wcid_add_poll()` was added by `387ab042ace87` (Felix Fietkau,
  2024-12-30, in v6.14)
- `mt76_reset_device()` was added by `065c79df595af` (Felix Fietkau,
  2025-08-27, in v6.17)

The bug was introduced when `065c79df595af` added `mt76_reset_device()`
which calls `mt76_wcid_cleanup()` then reinitializes `sta_poll_list`
without first removing entries.

### Step 3.2: Fixes Tag
No Fixes: tag. Based on analysis, should reference `065c79df595af`
("wifi: mt76: mt7915: fix list corruption after hardware restart") which
introduced `mt76_reset_device()`.

### Step 3.3: Related Changes
- `065c79df595af` - mt7915 list corruption fix (introduced
  mt76_reset_device, paradoxically introducing THIS bug)
- `a3c99ef88a084` - do not add non-sta wcid entries to the poll list
- `ace5d3b6b49e8` - mt7996 hardware restart reliability (uses
  mt76_reset_device)
- `328e35c7bfc67` - mt7915 hardware restart reliability

### Step 3.4: Author
Zac Bowling is not a regular mt76 contributor (only 1 commit found).
However, the patch was accepted and signed by Felix Fietkau
(nbd@nbd.name), who is the mt76 subsystem maintainer and authored ALL
the surrounding code.

### Step 3.5: Dependencies
The fix is standalone. It only uses `dev->sta_poll_lock`,
`wcid->poll_list`, `list_empty()`, `list_del_init()`, and
`spin_lock_bh()/spin_unlock_bh()` - all of which exist in any kernel
that has `mt76_reset_device()` (v6.17+).

---

## PHASE 4: MAILING LIST RESEARCH

### Step 4.1-4.5
Lore was behind Anubis anti-bot protection and could not be directly
fetched. However, the commit has a Link: to
`patch.msgid.link/20260120201043.38225-3-zac@zacbowling.com`, and b4 dig
confirmed the related series context. The patch was applied by the
subsystem maintainer (Felix Fietkau), which is the strongest possible
endorsement for mt76 patches.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: Functions Modified
- `mt76_wcid_cleanup()` - the only function modified

### Step 5.2: Callers
`mt76_wcid_cleanup()` is called from:
1. `mt76_reset_device()` (mac80211.c:848) - the buggy path
2. `mt76_unregister_device()` (mac80211.c:807) - for global wcid
3. `mt76_sta_pre_rcu_remove()` (mac80211.c:1617) - normal station
   removal
4. Individual drivers: mt7996, mt7915, mt7925, mt792x, mt7615, mt7603 -
   in their sta_remove/bss_remove handlers

All the individual driver callers (items 4) already remove `poll_list`
BEFORE calling `mt76_wcid_cleanup()`. Only the `mt76_reset_device()`
path (item 1) was missing this cleanup.

### Step 5.3-5.5: Call Chain and Impact
`mt76_reset_device()` is called from:
- `mt7915_mac_full_reset()` - hardware restart path
- `mt7996` hardware restart path

This is triggered during hardware error recovery - a real, non-rare
event for WiFi users experiencing firmware crashes.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Buggy Code in Stable Trees
- `mt76_reset_device()` (the bug source) was introduced in
  `065c79df595af`, first in v6.17
- `mt76_wcid_add_poll()` (needed for the bug to manifest) in v6.14
- **Bug exists in**: v6.17, v6.18, v6.19, v7.0
- The surrounding code (`bdeac7815629c` offchannel cleanup) is also in
  v6.17+ so the context should match

### Step 6.2: Backport Complications
The fix should apply cleanly to v6.17+. The diff context lines
(idr_destroy, tx_list cleanup) have been stable since 2023.

---

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Subsystem
- **Subsystem**: WiFi driver (drivers/net/wireless/mediatek/mt76)
- **Criticality**: IMPORTANT - mt76 is one of the most popular open-
  source WiFi drivers, used in many routers (OpenWrt), embedded systems,
  and Linux laptops
- MediaTek WiFi chipsets (mt7915, mt7996, mt7921/mt7922) are extremely
  common

### Step 7.2: Activity Level
Very active - many commits in the v6.17-v7.0 window, actively maintained
by Felix Fietkau.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
All users of mt76-based WiFi hardware that experience hardware restarts
(firmware crashes). This is a broad category including:
- OpenWrt routers with mt7915/mt7996 chipsets
- Laptops with mt7921/mt7922 WiFi
- Any system using MediaTek WiFi that encounters a hardware error
  triggering restart

### Step 8.2: Trigger Conditions
Triggered during hardware restart/reset recovery - specifically when
`mt76_reset_device()` is called and then `mt76_wcid_add_poll()` is
called for a wcid that was on the old poll_list. Not extremely rare for
WiFi users since firmware crashes do happen.

### Step 8.3: Failure Mode Severity
- **List corruption** triggers kernel `BUG()`/`WARN()` from list debug
  code
- Without list debug: silent corruption can lead to kernel crashes, use-
  after-free, or infinite loops
- **Severity: CRITICAL** (kernel crash or corruption during WiFi
  recovery)

### Step 8.4: Risk-Benefit Ratio
- **Benefit**: HIGH - prevents kernel crashes during WiFi hardware
  restart, affects common hardware
- **Risk**: VERY LOW - 5 lines of code, uses established patterns,
  accepted by subsystem maintainer
- **Ratio**: Strongly favorable

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Summary

**FOR backporting:**
- Fixes a real, demonstrable list corruption bug that causes kernel
  crashes
- Small, surgical fix (5 lines of code + comments)
- Follows the exact established pattern used by ALL other callers
- Applied by the subsystem maintainer (Felix Fietkau) who wrote the
  surrounding code
- Affects widely-used WiFi hardware (MediaTek mt76 chipsets)
- Bug triggers during hardware restart - a real-world scenario

**AGAINST backporting:**
- No Fixes: tag (but the fix implicitly targets `065c79df595af`)
- Author is not a regular contributor (but maintainer accepted it)
- Bug only exists in v6.17+ (limited to recent stable trees)

### Step 9.2: Stable Rules Checklist
1. **Obviously correct and tested?** YES - follows existing pattern,
   accepted by maintainer
2. **Fixes a real bug?** YES - list corruption during hardware restart
3. **Important issue?** YES - kernel BUG/crash severity
4. **Small and contained?** YES - 5 lines of code, single function
5. **No new features or APIs?** Correct - pure bug fix
6. **Can apply to stable?** YES - should apply cleanly to v6.17+

### Step 9.3: Exception Categories
Not applicable - this is a straightforward bug fix, not an exception
category.

### Step 9.4: Decision
Strong YES. This is a textbook stable backport candidate: small,
obviously correct, fixes a real kernel crash (list corruption), affects
popular hardware, accepted by the subsystem maintainer.

---

## Verification

- [Phase 1] Parsed tags: Link to patch.msgid.link, applied by Felix
  Fietkau (mt76 maintainer)
- [Phase 2] Diff analysis: +5 lines of code in `mt76_wcid_cleanup()`,
  adds `list_del_init(&wcid->poll_list)` under `sta_poll_lock`
- [Phase 2] Pattern match: Verified ALL other callers (mt7996, mt7915,
  mt792x, mt7615, mt7603) remove poll_list before calling
  mt76_wcid_cleanup - this fix makes the function self-contained
- [Phase 3] git blame: `mt76_wcid_cleanup()` introduced in
  0335c034e7265d (2023-08-29), `mt76_reset_device()` introduced in
  065c79df595af (2025-08-27)
- [Phase 3] git merge-base: `mt76_reset_device()` (065c79df595af) is in
  v6.17 but NOT v6.16, confirming bug exists in v6.17+
- [Phase 3] Related fix: 065c79df595af introduced `mt76_reset_device()`
  which paradoxically introduced this bug by calling
  `mt76_wcid_cleanup()` without poll_list cleanup then doing
  `INIT_LIST_HEAD(&dev->sta_poll_list)`
- [Phase 4] Lore: blocked by Anubis, but commit was applied by the
  subsystem maintainer which confirms review
- [Phase 5] Callers of `mt76_wcid_cleanup`: 7 call sites found;
  `mt76_reset_device()` is the only one that doesn't remove poll_list
  beforehand
- [Phase 5] `mt76_reset_device()` called from mt7915_mac_full_reset and
  mt7996 restart - real hardware restart paths
- [Phase 6] Bug exists in v6.17, v6.18, v6.19, v7.0 (confirmed with git
  merge-base)
- [Phase 6] Context code (offchannel bdeac7815629c) confirmed in v6.17+,
  so patch should apply cleanly
- [Phase 8] Failure mode: list_add corruption BUG/WARN → kernel crash,
  severity CRITICAL
- UNVERIFIED: Could not access lore discussion due to Anubis protection;
  maintainer sign-off is sufficient evidence of review

**YES**

 drivers/net/wireless/mediatek/mt76/mac80211.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 75772979f438e..d0c522909e980 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1716,6 +1716,16 @@ void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 
 	idr_destroy(&wcid->pktid);
 
+	/* Remove from sta_poll_list to prevent list corruption after reset.
+	 * Without this, mt76_reset_device() reinitializes sta_poll_list but
+	 * leaves wcid->poll_list with stale pointers, causing list corruption
+	 * when mt76_wcid_add_poll() checks list_empty().
+	 */
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&wcid->poll_list))
+		list_del_init(&wcid->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
 	spin_lock_bh(&phy->tx_lock);
 
 	if (!list_empty(&wcid->tx_list))
-- 
2.53.0


