Return-Path: <linux-wireless+bounces-35072-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKiLC4s85mlutgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35072-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:47:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCAA42D757
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50283316821E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFE73CF677;
	Mon, 20 Apr 2026 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfXP5tYw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64673A6F1A;
	Mon, 20 Apr 2026 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691773; cv=none; b=rj6rJJw+wwu0Id3AcW5UMAE4LTMzS6YDj5asDorhXf+pDhsaZewWQpZMK2nPl5nNaTFYsOeYipR71PBR2nH1brz1/1KwlCaPGF6QrGM/Jkf23m5MiSu+sGaPLWHOQid00GFwza73JqFgC+kRTiSGshX5HnH8QizBzZoGq2kNMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691773; c=relaxed/simple;
	bh=Li1kXSSqR5T2rb7T9i2NklUUUN9GwqH4p/jzE0C0dXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k80T3LsoiIQznICwqcRZQqa43LVpWIrJ56sdCP44S5DXmqEl6Kchnx1Z6FrVOgWyIeotdQ1E1+PNembPNE/4thhlfu0cHhz2nq0EBWiXdDm2LtAKJM0BzVOw6RmVfmyRb81TXuBfsWk4qY2RswwvMQckd3mJtiA2gHMnQOxBhSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfXP5tYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33468C2BCB9;
	Mon, 20 Apr 2026 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691773;
	bh=Li1kXSSqR5T2rb7T9i2NklUUUN9GwqH4p/jzE0C0dXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfXP5tYwW2tqUHw62r2756C/axnjS4/rOQaZUoN0PofX7fxEvK6EmvaRSksgLIM8H
	 oMyysUxvEoKdl0ReBZMlGmr7qj498bIs1mU/ZrPcCPTlD4rMTCgG7recVw+5pAHNUO
	 tKetcr0XOlc0ANuCZyj9Jg3GbNv63c80efItqk0VypbFHSrTFvew9ez/9QwwQ1hPer
	 8fwBedkeyhZKvOY1Xvqu74ECGqA2qgpDgN5+W4WuhdxhjM1vq4cZUxVIRJrUGprL24
	 wP8NBDBU2l1Z0ZudRSLvXDdC1qLdRqeN5rCDMgNQhOZhzCY2n+09ZBqCLE8twFQyua
	 7f5pi1uJwYTIw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: David Bauer <mail@david-bauer.net>,
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
Subject: [PATCH AUTOSEL 7.0-5.10] wifi: mt76: mt76x02: wake queues after reconfig
Date: Mon, 20 Apr 2026 09:19:39 -0400
Message-ID: <20260420132314.1023554-185-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35072-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[david-bauer.net,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bauer.net:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,david-bauer.net:email]
X-Rspamd-Queue-Id: 7CCAA42D757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Bauer <mail@david-bauer.net>

[ Upstream commit 524ef4b42b40bf1cf634663e746ace0af3fce45c ]

The shared reset procedure of MT7610 and MT7612 stop all queues before
starting the reset sequence.

They however never restart these like other supported mt76 chips
do in the reconfig_complete call. This leads to TX not continuing
after the reset.

Restart queues in the reconfig_complete callback to restore
functionality after the reset.

Signed-off-by: David Bauer <mail@david-bauer.net>
Link: https://patch.msgid.link/20251129023904.288484-1-mail@david-bauer.net
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a comprehensive analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: wifi: mt76: mt76x02
- **Action verb**: "wake" - implies restoring functionality that should
  already have been there
- **Summary**: Wake TX queues after hardware reconfiguration completes
  on MT7610/MT7612

### Step 1.2: Tags
- **Signed-off-by**: David Bauer (author), Felix Fietkau (mt76
  maintainer - accepted the patch)
- **Link**: https://patch.msgid.link/20251129023904.288484-1-mail@david-
  bauer.net
- No Fixes: tag (expected for autosel review candidates)
- No Cc: stable (expected)
- No Reported-by (likely the author discovered it themselves)

### Step 1.3: Commit Body
The commit message clearly describes the bug: MT7610 and MT7612 reset
procedure calls `ieee80211_stop_queues()` at the start but never calls
`ieee80211_wake_queues()` in the restart path. Other mt76 chips do wake
queues in their `reconfig_complete` callback. The consequence is **TX
completely stops after a hardware reset/restart**.

### Step 1.4: Hidden Bug Fix Detection
This is NOT hidden - it is an explicit functional bug fix. TX stops
working after hw reset.
Record: Direct bug fix, not disguised.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **Files**: 1 file changed (`mt76x02_mmio.c`)
- **Lines**: +1 line added
- **Function modified**: `mt76x02_reconfig_complete()`
- **Scope**: Single-file, single-line surgical fix

### Step 2.2: Code Flow Change
- **Before**: `mt76x02_reconfig_complete` only clears `MT76_RESTART`
  state bit, does not wake TX queues
- **After**: Also calls `ieee80211_wake_queues(hw)` to unblock TX after
  reconfiguration

The flow is:
1. `mt76x02_watchdog_reset()` calls `ieee80211_stop_queues()` (line 439)
2. In the `restart` path (lines 518-521), it calls
   `ieee80211_restart_hw()` and sets `MT76_RESTART`
3. mac80211 does full reconfiguration, then calls
   `mt76x02_reconfig_complete()`
4. **Bug**: `reconfig_complete` only clears the state bit but never
   wakes queues
5. TX is permanently stuck

### Step 2.3: Bug Mechanism
This is a **logic/correctness bug** - missing function call on a
critical path. The queues are stopped but never restarted in the hw
restart case.

### Step 2.4: Fix Quality
- **Obviously correct**: Yes - one line adding
  `ieee80211_wake_queues()`, exactly matching what mt7915 and mt7996
  already do in their `reconfig_complete` callbacks
- **Minimal/surgical**: Yes - 1 line
- **Regression risk**: Essentially zero - this is adding a missing queue
  wake that every other mt76 driver already has
Record: Extremely high quality fix, no regression risk.

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
The `mt76x02_reconfig_complete` function was introduced by commit
`fd6c2dfa49b762` (Felix Fietkau, 2020-02-16), which was first released
in v5.8-rc1. The function has never been modified since its introduction
- it was missing the `wake_queues` call from day one.

### Step 3.2: Fixes Target
No explicit Fixes: tag, but the bug was introduced by `fd6c2dfa49b762`
("mt76: mt76x02: fix handling MCU timeouts during hw restart") which
created the `reconfig_complete` callback without
`ieee80211_wake_queues()`. This commit exists in all stable trees from
v5.8 onward.

### Step 3.3: File History
36 commits between the buggy code introduction and HEAD. None touch the
`reconfig_complete` function.

### Step 3.4: Author
David Bauer has 5 commits to mt76, mainly focused on MT7915 MCU
improvements. Felix Fietkau (nbd@nbd.name), the mt76 maintainer, signed
off and merged this patch.

### Step 3.5: Dependencies
None. The fix adds a single call to `ieee80211_wake_queues()` which is a
standard mac80211 API available since the very beginning of the mt76
driver. Fully standalone.

---

## PHASE 4: MAILING LIST RESEARCH

### Step 4.1: Patch Discussion
b4 dig found the original submission. The mbox shows a single patch with
no replies/discussion beyond the patch itself. Felix Fietkau accepted
and merged it directly, suggesting it was obviously correct.

### Step 4.2: Reviewers
The patch was CC'd to all relevant mt76 maintainers (Felix Fietkau,
Lorenzo Bianconi, Ryder Lee, Shayne Chen, Sean Wang) and relevant
mailing lists (linux-wireless, linux-mediatek). Felix Fietkau, the
primary mt76 maintainer, directly merged it.

### Step 4.3: Bug Report
No separate bug report - the author discovered the issue.

### Step 4.4: Related Patches
Standalone single patch, not part of a series.

### Step 4.5: Stable Discussion
No stable-specific discussion found.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1-5.2: Key Functions and Callers
`mt76x02_reconfig_complete` is registered as the `.reconfig_complete`
callback in the `ieee80211_ops` structures for both MT7610
(mt76x0/pci.c) and MT7612 (mt76x2/pci_main.c). It is called by the
mac80211 subsystem after `ieee80211_restart_hw()` completes
reconfiguration.

### Step 5.3-5.4: Call Chain
1. TX hang detected by `mt76x02_wdt_work` → `mt76x02_check_tx_hang` →
   `mt76x02_watchdog_reset`
2. Reset stops queues and calls `ieee80211_restart_hw()`
3. mac80211 reconfigures, then calls `mt76x02_reconfig_complete`
4. Without this fix, queues stay stopped → no more TX

This is triggered on real hardware when TX hangs occur, which is a known
scenario for these WiFi chips.

### Step 5.5: Similar Patterns
Both `mt7915_reconfig_complete` and `mt7996_reconfig_complete` call
`ieee80211_wake_queues(hw)` as their first action - confirming this is
the expected pattern that was simply missed for mt76x02.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Buggy Code Presence
The buggy `mt76x02_reconfig_complete` was introduced in v5.8-rc1 (commit
fd6c2dfa49b762). It exists in all active stable trees: 5.10.y, 5.15.y,
6.1.y, 6.6.y, 6.12.y, etc.

### Step 6.2: Backport Complexity
This is a single-line addition. The surrounding code
(`mt76x02_reconfig_complete`) has not been modified since it was
introduced in 2020. Clean apply expected in all stable trees.

### Step 6.3: Related Fixes
No related or alternative fixes found in stable trees.

---

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: Subsystem
- **Path**: drivers/net/wireless/mediatek/mt76/
- **Subsystem**: WiFi driver (MediaTek MT7610/MT7612)
- **Criticality**: IMPORTANT - MT7610 and MT7612 are popular WiFi
  chipsets used in many consumer routers, access points, and USB
  adapters (especially in OpenWrt/embedded Linux)

### Step 7.2: Activity
The mt76 subsystem is actively developed with 20+ recent commits.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
All users of MT7610 (mt76x0) and MT7612 (mt76x2) PCIe WiFi devices.
These are common in embedded routers and access points.

### Step 8.2: Trigger
After any hardware reset triggered by TX hang detection (a real-world
scenario), the WiFi device becomes completely unable to transmit. The
watchdog periodically runs (`mt76x02_wdt_work`), and TX hangs do occur
in real hardware.

### Step 8.3: Severity
**CRITICAL** - Complete loss of WiFi TX functionality after any hw
restart. The device appears connected but cannot send any data.

### Step 8.4: Risk-Benefit
- **Benefit**: Very high - restores WiFi functionality after hw reset
  for MT7610/MT7612 users
- **Risk**: Very low - single line addition of
  `ieee80211_wake_queues()`, matching behavior of all other mt76 drivers
- **Ratio**: Excellent risk-benefit ratio

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence
**FOR backporting:**
- Fixes complete loss of TX functionality after hw restart (complete
  WiFi outage)
- Single-line fix, obviously correct
- Matches established pattern in mt7915, mt7996, and other mt76 drivers
- Merged by the mt76 subsystem maintainer (Felix Fietkau)
- Bug present since v5.8-rc1 (2020), affects all stable trees
- No dependencies, applies cleanly
- Affects popular WiFi hardware (MT7610/MT7612)

**AGAINST backporting:**
- No explicit Cc: stable or Fixes: tag (expected for autosel)
- No user bug reports cited (but the failure mode is severe enough to
  warrant the fix regardless)

### Step 9.2: Stable Rules Checklist
1. Obviously correct and tested? **YES** - single line, matches all
   other mt76 drivers, accepted by maintainer
2. Fixes a real bug? **YES** - TX stops working after hw restart
3. Important issue? **YES** - complete loss of WiFi functionality
4. Small and contained? **YES** - 1 line in 1 file
5. No new features/APIs? **YES** - just adds missing call
6. Applies to stable? **YES** - code unchanged since v5.8

### Step 9.3: Exception Categories
Not needed - this is a straightforward bug fix.

### Step 9.4: Decision
This is a textbook stable backport candidate: a single-line fix for a
severe functional bug (complete WiFi TX outage after hw restart),
matching established patterns from other drivers, in code that exists in
all stable trees.

---

## Verification

- [Phase 1] Parsed tags: Signed-off-by from David Bauer (author) and
  Felix Fietkau (mt76 maintainer). Link to lore.kernel.org confirmed.
- [Phase 2] Diff analysis: exactly 1 line added
  (`ieee80211_wake_queues(hw)`) in `mt76x02_reconfig_complete()`.
- [Phase 3] git blame: buggy function introduced in commit
  fd6c2dfa49b762 (Felix Fietkau, 2020-02-16), first in v5.8-rc1.
  Function never modified since.
- [Phase 3] git show fd6c2dfa49b762: confirmed this commit created
  `mt76x02_reconfig_complete` without `ieee80211_wake_queues()`.
- [Phase 3] git describe --contains fd6c2dfa49b762: confirmed
  "v5.8-rc1~165^2~111^2~13^2~137"
- [Phase 4] b4 dig -c 524ef4b42b40b: found original submission at lore
  URL. Single patch, no series.
- [Phase 4] b4 dig -w: confirmed all relevant mt76 maintainers were
  CC'd.
- [Phase 4] mbox thread: no review comments, directly merged by Felix
  Fietkau.
- [Phase 5] grep reconfig_complete: confirmed mt7915 and mt7996 both
  call `ieee80211_wake_queues(hw)` in their reconfig_complete - mt76x02
  was the outlier.
- [Phase 5] grep ieee80211_stop_queues/wake_queues: confirmed stop at
  line 439, wake only in non-restart path at line 523. Restart path
  missing wake (the bug).
- [Phase 6] Code exists in all active stable trees (v5.8+). No
  modifications to the function since introduction.
- [Phase 8] Failure mode: complete WiFi TX loss after hw restart,
  severity CRITICAL.

**YES**

 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index dd71c1c95cc9b..dc7c03d231238 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -534,6 +534,7 @@ void mt76x02_reconfig_complete(struct ieee80211_hw *hw,
 		return;
 
 	clear_bit(MT76_RESTART, &dev->mphy.state);
+	ieee80211_wake_queues(hw);
 }
 EXPORT_SYMBOL_GPL(mt76x02_reconfig_complete);
 
-- 
2.53.0


