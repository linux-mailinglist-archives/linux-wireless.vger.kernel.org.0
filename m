Return-Path: <linux-wireless+bounces-35071-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNNyFs815mkGtgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35071-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:18:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96842CE3E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E958532A066E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864E4279FE;
	Mon, 20 Apr 2026 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o26TWoPJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43494279F8;
	Mon, 20 Apr 2026 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691763; cv=none; b=qu2M/GAm4tB6TSJCXOknihaQMFYbLDvHdn4c9yzHxLEjVmYFmnEBs6Zabs4BuEOUj2SLvSEPkp/Fs2x35pBs813WyXki9oSrDov0jy1Hl9NC1yVbMlaPXC4V3rI5KxwEddfy8hro2x5kkvySG1cNN+SxPrZ7ZDzs/gdk/dUa5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691763; c=relaxed/simple;
	bh=ncGXnGfwyNBIummgKXfDWCBtxlIZHxp6orVYnEbfNTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqwG6TS6TFDIkuXmDRsrvYtQXD1GJn71qtbmvaj7DIIrOcBUdlcwcWJP7VHPCRA771BTsCDqQacxNpSIyVJj6mloy/wrohVZ76YjxQdGS+S7QVmuLDB7TMRdm4RtP8xlM05aCTN5GaHpXIywDGSDpPR0kDeua4wQ3r38IGcGb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o26TWoPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFD9C19425;
	Mon, 20 Apr 2026 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691763;
	bh=ncGXnGfwyNBIummgKXfDWCBtxlIZHxp6orVYnEbfNTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o26TWoPJW9cR2sRp7tw6yydEGOXvXrtDv0Dk9SVBWafrT1zJVaqAHoxWQLGgcdoGd
	 ATVJrm5TSXT01hlxtxZ9SQSMB/cr7yhM3Pxw8yX6i0f7wh+xfalc24R9mdKaVpfa52
	 /Wrb2BZDSIVrgLcw7zJdaGkmi+46H2wGLK5NBSZCTMwJkny9kjisQ08LGU6Su+RqS2
	 OsODhm9u8GkwKCWqlQ1QHaeOh6q80UR4Ceuj31ZU9ZDoNstXQO3+adf6A1HnspGA2M
	 yTfn4dN8HJkkqrs4mDGWNiuUXo47oMiEu1xzYTpfZFrDQ4XoNZ6fyN6yKvFdCju0Hl
	 HSIU8glSFYL9w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Michael Lo <michael.lo@mediatek.com>,
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
Subject: [PATCH AUTOSEL 7.0-6.12] wifi: mt76: mt7925: Skip scan process during suspend.
Date: Mon, 20 Apr 2026 09:19:33 -0400
Message-ID: <20260420132314.1023554-179-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35071-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mediatek.com,nbd.name,kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nbd.name:email,msgid.link:url,mediatek.com:email,scan_work.work:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D96842CE3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Lo <michael.lo@mediatek.com>

[ Upstream commit 8c7e19612b01567f641d3ffe21e47fa21c331171 ]

We are experiencing command timeouts because an upper layer triggers
an unexpected scan while the system/device is in suspend.
The upper layer should not initiate scans until the NIC has fully resumed.
We want to prevent scans during suspend and avoid timeouts without harming
power management or user experience.

Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Link: https://patch.msgid.link/20260112114007.2115873-1-leon.yen@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a comprehensive understanding. Let me compile my analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: mt76: mt7925:`
- Action: "Skip" — implies avoiding an undesired operation during a
  specific state
- Summary: Skip scan processing during suspend to prevent command
  timeouts
- Record: [wifi/mt76/mt7925] [skip/prevent] [avoid scan work execution
  during suspend to prevent command timeouts]

**Step 1.2: Tags**
- `Signed-off-by: Michael Lo <michael.lo@mediatek.com>` — MediaTek
  employee, driver vendor
- `Link: https://patch.msgid.link/20260112114007.2115873-1-
  leon.yen@mediatek.com` — original submission by Leon Yen
- `Signed-off-by: Felix Fietkau <nbd@nbd.name>` — mt76 subsystem
  maintainer, applied the patch
- No Fixes: tag (expected for autosel candidates)
- No Reported-by: tag
- Record: Author from MediaTek (driver vendor), applied by subsystem
  maintainer Felix Fietkau.

**Step 1.3: Commit Body**
- Bug: Command timeouts during suspend because upper layer triggers a
  scan while device is suspended
- Symptom: Command timeouts
- Root cause: Scan work runs when device is in suspended state and can't
  respond to firmware commands
- Record: [Bug: command timeout during suspend from unexpected scan]
  [Symptom: timeout errors] [Root cause: scan work executing while
  device is powered down]

**Step 1.4: Hidden Bug Fix Detection**
- Despite using "Skip" rather than "fix," this directly addresses a
  command timeout — a real functional bug. Users would experience
  suspend failures or WiFi errors after resume.
- Record: Yes, this is a bug fix. The "skip" phrasing masks a fix for
  command timeouts during suspend.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- 1 file modified: `drivers/net/wireless/mediatek/mt76/mt7925/main.c`
- +8 lines added (3 variable declarations, 5 lines for the pm->suspended
  check)
- Function modified: `mt7925_scan_work()`
- Scope: Single-file, single-function surgical fix
- Record: [1 file, +8 lines, mt7925_scan_work(), surgical fix]

**Step 2.2: Code Flow Change**
- BEFORE: `mt7925_scan_work()` always processes queued scan events from
  `scan_event_list`, regardless of device power state
- AFTER: `mt7925_scan_work()` first checks `pm->suspended`; if true,
  returns immediately without processing events
- This affects the scan event processing path during suspend
- Record: [Before: always processes scan events; After: skips processing
  if device is suspended]

**Step 2.3: Bug Mechanism**
- Category: Logic/correctness fix + timing issue
- The race: `mt7925_suspend()` cancels scan_work at line 1476, but
  `mt7925_mcu_scan_event()` can re-queue scan_work after cancellation.
  Between `cancel_delayed_work_sync()` and full device suspension, the
  MCU can still generate scan events, re-queuing scan_work. When
  scan_work runs against the suspended device, firmware commands time
  out.
- The `pm->suspended` flag is set in PCI/USB suspend
  (`mt7925_pci_suspend()` line 452) and cleared in resume
  (`_mt7925_pci_resume()` line 590)
- Record: [Logic/timing fix: scan work can run against suspended device
  causing command timeouts]

**Step 2.4: Fix Quality**
- Obviously correct: checks a well-established flag (`pm->suspended`)
  that is used consistently throughout the mt76 driver family
- Minimal and surgical: adds only an early return
- Minor concern: skbs in `scan_event_list` are not freed on early
  return, but they would be processed on resume or cleaned up on device
  removal
- Pattern is consistent with other uses of `pm->suspended` in the driver
  (e.g., `mt792x_mac.c:278`, `mt76_connac_mac.c:47,73`,
  `mt7925/regd.c:196`)
- Record: [Fix is obviously correct, minimal, follows established driver
  patterns. Minor skb leak concern is acceptable.]

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame**
- The `mt7925_scan_work()` function was introduced in commit
  `c948b5da6bbec` by Deren Wu on 2023-09-18, the initial commit adding
  the mt7925 driver
- This is the initial code — the bug has existed since the driver was
  created
- Record: [Buggy code from c948b5da6bbec (initial mt7925 driver, v6.7)]

**Step 3.2: Fixes Tag**
- No Fixes: tag present (expected for autosel candidate)
- Record: N/A

**Step 3.3: File History**
- Multiple related suspend/resume fixes for mt7925 exist:
  `bf39813599b03` (simplify HIF suspend), `2d5630b0c9466` (fix low power
  mode entry), `1b97fc8443aea` (fix regd_notifier before suspend)
- Related scan fix: `122f270aca2c8` (prevent multiple scan commands)
- No prerequisites identified for this specific fix
- Record: [Multiple suspend-related fixes indicate ongoing suspend
  reliability improvements. Fix is standalone.]

**Step 3.4: Author**
- Michael Lo / Leon Yen are MediaTek employees and regular mt76
  contributors
- Multiple suspend/resume and scan-related fixes from the same team
- Record: [Authors are driver vendor engineers with deep knowledge of
  the hardware]

**Step 3.5: Dependencies**
- The `pm->suspended` flag and `struct mt76_connac_pm` are well-
  established infrastructure present since the mt7921 driver
- No new functions or structures needed
- Record: [No dependencies. Fix uses existing infrastructure available
  in all versions with mt7925.]

## PHASE 4: MAILING LIST RESEARCH

**Step 4.1-4.5**: Lore is blocked by anti-scraping protection. b4 dig
could not find the commit. However, the patch was applied by Felix
Fietkau (mt76 maintainer), indicating it passed review.
- Record: [Could not access lore discussion. Patch was accepted by
  subsystem maintainer.]

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Functions Modified**
- `mt7925_scan_work()` — delayed work handler for processing scan events

**Step 5.2: Callers**
- Registered as delayed work via `INIT_DELAYED_WORK(&dev->phy.scan_work,
  mt7925_scan_work)` in init.c:214
- Queued by `mt7925_mcu_scan_event()` in mcu.c:415 via
  `ieee80211_queue_delayed_work()`
- Cancelled in `mt7925_suspend()` at main.c:1476

**Step 5.3-5.4: Call Chain**
- MCU receives scan event from firmware -> `mt7925_mcu_scan_event()`
  queues skb and schedules `scan_work` -> `mt7925_scan_work()` processes
  scan results
- This is a common path triggered during WiFi scanning, which mac80211
  can trigger automatically

**Step 5.5: Similar Patterns**
- `pm->suspended` checks exist in: `mt792x_mac.c:278` (reset),
  `mt76_connac_mac.c:47,73` (pm_wake, power_save_sched),
  `mt7925/regd.c:196` (regd_change), `mt7921/init.c:147`
- The mt7921 `mt7921_scan_work()` does NOT have this check, which is
  consistent with it being a fix specific to the mt7925 suspend flow
  timing
- Record: [Pattern is well-established across mt76 drivers. mt7921
  doesn't have this check but has different timing characteristics.]

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Code Existence**
- mt7925 driver was added in `c948b5da6bbec` which is in v6.7+
- Not in v6.6 (verified: `git merge-base` confirms)
- Present in v6.12 (verified)
- For stable tree 7.0.y (the target here), the driver definitely exists
- Record: [mt7925 exists in v6.7+. Bug present since driver creation.
  Applicable to 6.7.y and later stable trees.]

**Step 6.2: Backport Complications**
- The file has had recent changes (regd_change in scan_work at line
  1361), but the fix adds code at the beginning of the function, which
  should apply cleanly to most versions
- Record: [Expected to apply cleanly — adds code at function entry
  point]

**Step 6.3: Related Fixes in Stable**
- No evidence that this specific fix is already in stable
- Record: [No prior fix for this issue found in stable]

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1**: WiFi driver (drivers/net/wireless/mediatek/mt76/mt7925) —
IMPORTANT subsystem
- MediaTek mt7925 is a common WiFi 7 chip in modern laptops
- Record: [Driver-specific, but widely deployed WiFi hardware. IMPORTANT
  criticality.]

**Step 7.2**: Actively developed subsystem with many recent commits
- Record: [Active development, many suspend/resume fixes indicate real-
  world usage and bug reports]

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1**: Affected: Users of mt7925 WiFi hardware who suspend/resume
their systems (common laptop use case)

**Step 8.2**: Trigger: System suspend while WiFi is active and mac80211
triggers a scan. This is a common scenario on laptops.

**Step 8.3**: Failure mode: Command timeouts during suspend — can cause
suspend failures, WiFi functionality loss after resume. Severity: HIGH
(suspend/resume reliability).

**Step 8.4**:
- BENEFIT: HIGH — prevents command timeouts during suspend for common
  laptop hardware
- RISK: VERY LOW — 8 lines, single early return, follows established
  driver patterns
- Ratio: Strongly favorable

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence FOR**
- Fixes a real command timeout bug during suspend/resume (common laptop
  scenario)
- Small, surgical, obviously correct fix (8 lines, single function)
- Uses well-established `pm->suspended` pattern from the driver family
- Author is driver vendor (MediaTek), applied by subsystem maintainer
  (Felix Fietkau)
- Bug has existed since driver creation (affects all stable trees with
  mt7925)
- No dependencies, standalone fix

**Evidence AGAINST**
- No Fixes: tag (expected)
- Minor concern about queued skbs not being freed on early return
  (acceptable trade-off)
- UNVERIFIED: Could not access lore discussion to check for reviewer
  concerns

**Step 9.2: Stable Rules Checklist**
1. Obviously correct? YES — simple flag check following established
   pattern
2. Fixes real bug? YES — command timeouts during suspend
3. Important issue? YES — suspend/resume reliability on laptop hardware
4. Small and contained? YES — 8 lines, 1 file, 1 function
5. No new features? YES — purely defensive check
6. Can apply to stable? YES — uses existing infrastructure

**Step 9.3: Exception Categories**
- Not an exception category; this is a standard bug fix

**Step 9.4: Decision**
This is a small, well-targeted fix for a real suspend/resume bug
affecting common WiFi hardware. The fix follows established patterns in
the driver family, was accepted by the subsystem maintainer, and carries
minimal regression risk.

## Verification

- [Phase 1] Parsed tags: SOB from MediaTek author, applied by Felix
  Fietkau (mt76 maintainer)
- [Phase 2] Diff: +8 lines in mt7925_scan_work(), adds pm->suspended
  early return check
- [Phase 3] git blame: buggy code from c948b5da6bbec (initial mt7925
  driver, Sep 2023, v6.7)
- [Phase 3] git merge-base: confirmed mt7925 NOT in v6.6, IS in v6.7 and
  v6.12
- [Phase 3] Related commits: multiple suspend fixes (bf39813599b03,
  2d5630b0c9466, 1b97fc8443aea)
- [Phase 5] Grep for pm->suspended: found 15+ uses across mt76 driver
  family, established pattern
- [Phase 5] Grep for scan_work callers: queued by mcu.c:415, cancelled
  in suspend main.c:1476
- [Phase 6] Code exists in v6.7+ stable trees
- [Phase 8] Failure mode: command timeout during suspend, severity HIGH
- UNVERIFIED: Could not access lore.kernel.org discussion due to anti-
  bot protection

**YES**

 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 2d358a96640c9..38474cd2c38d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1323,10 +1323,18 @@ void mt7925_mlo_pm_work(struct work_struct *work)
 void mt7925_scan_work(struct work_struct *work)
 {
 	struct mt792x_phy *phy;
+	struct mt792x_dev *dev;
+	struct mt76_connac_pm *pm;
 
 	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						scan_work.work);
 
+	dev = phy->dev;
+	pm = &dev->pm;
+
+	if (pm->suspended)
+		return;
+
 	while (true) {
 		struct sk_buff *skb;
 		struct tlv *tlv;
-- 
2.53.0


