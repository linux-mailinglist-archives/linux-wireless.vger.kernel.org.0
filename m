Return-Path: <linux-wireless+bounces-35055-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FluHLwu5mliswEAu9opvQ
	(envelope-from <linux-wireless+bounces-35055-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:48:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1646342C4D3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22419311561C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6788F3D3CED;
	Mon, 20 Apr 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/ww9Fxc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C343D3486;
	Mon, 20 Apr 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691416; cv=none; b=Jf2fuuS2ZP9jPgFCJrX5QWCWZvmGjZ3RQv79+bmm0320sZurQ3AjroQgnpg2WHvGpbNccG33p0WODcIekXXkr8u7L4Kr2LnmraK3ouvKv9u17j1lpHpRlcMgVa5y5PQha52HjSDuX+vZtkLNb8JbvbMY2NUIYtVOeX+xJs31mdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691416; c=relaxed/simple;
	bh=yQ1RewH9lw8beZGLPupAC42ESrO0ODROPpBzl9klZWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwp9Ptzp3276kjtO0uyIQecl+RgE1W6rCvEOyOzqnxYoI27O2iG+BKXHHoUz3V/DkzzYvi5D8bEBECTQ204cQml+adLbEZz99Egxl6mAurUpvOFhcQUaE7I3Z29iZyCfAoynwQXdtxD9/oR46slcgdqDA4eQflYut1ifpToKqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/ww9Fxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110C6C2BCB4;
	Mon, 20 Apr 2026 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691416;
	bh=yQ1RewH9lw8beZGLPupAC42ESrO0ODROPpBzl9klZWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/ww9FxcFsbz8WGtzCObYRybdyqaObFBRxzyJmxCOxYl5bzvcWsSzz8nw/idhHNxW
	 VD0CAidnQ8RY07NB0xkWjJm94fJ7kdpBtb7w/aLTN8PoX+gb3jVapnCd221weWICts
	 rSU6pVWuYAs3kTz4Zlyh1Kc9ownIxHxLuXhWk4pQSlC3mTekH2WbgiaiqPI2nJu8Qb
	 iU+yubK5k49qxxBHtkAp750/RZxUt/YVQjh+11RPqGWLctHEpVfunWGyu4sivFIszp
	 9Sy/bKE6XPuJdwoH87RzO8DEHTMMDfPRJPFtz22k3cap6GhDKSofoTWc4vHsP3WHsc
	 9WbGaokUSOdhg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.12] wifi: rtw89: ser: Wi-Fi 7 reset HALT C2H after reading it
Date: Mon, 20 Apr 2026 09:16:47 -0400
Message-ID: <20260420132314.1023554-13-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35055-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 1646342C4D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit 0cae26a78b14fe1292b0f50f28ebabe6801f3885 ]

When a SER (system error recovery) interrupt happens, driver reads HALT C2H
register to get the error status via MAC. For Wi-Fi 7 chipset, driver needs
to reset HALT C2H register after reading it to make FW aware that.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260213061552.29997-12-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a comprehensive understanding. Let me compile my analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: PARSE THE SUBJECT LINE
Record: [wifi: rtw89: ser] [reset] [Wi-Fi 7 reset HALT C2H register
after reading it during SER to notify FW]

### Step 1.2: PARSE ALL COMMIT MESSAGE TAGS
- **Signed-off-by**: Zong-Zhe Yang (author, Realtek engineer) and Ping-
  Ke Shih (maintainer, Realtek)
- **Link**:
  `https://patch.msgid.link/20260213061552.29997-12-pkshih@realtek.com`
  - patch 12 of a series
- No Fixes: tag (expected for candidate commits)
- No Reported-by: tag
- No Cc: stable

Record: Standard Realtek vendor team submission. No user reports or
explicit stable nomination.

### Step 1.3: ANALYZE THE COMMIT BODY TEXT
The body states: "When a SER (system error recovery) interrupt happens,
driver reads HALT C2H register to get the error status via MAC. For Wi-
Fi 7 chipset, driver needs to reset HALT C2H register after reading it
to make FW aware that."

Record: Bug is that Wi-Fi 7 firmware requires the HALT_C2H register to
be cleared after the driver reads it during error recovery, but the
driver was not doing this. Without the clear, FW doesn't know the driver
has acknowledged the error, potentially breaking the SER recovery flow.
No version info or stack trace provided.

### Step 1.4: DETECT HIDDEN BUG FIXES
Record: Yes, this IS a bug fix. The language "driver needs to reset"
indicates a missing protocol step. The SER recovery on Wi-Fi 7 is broken
without this change because the firmware protocol requires the register
to be cleared after reading.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: INVENTORY THE CHANGES
- **File**: `drivers/net/wireless/realtek/rtw89/mac.c`
- **Function**: `rtw89_mac_get_err_status()`
- **Lines added**: ~5 (1 variable declaration, 1 goto, 1 label, 1
  conditional write, 1 empty line)
- **Lines removed**: 1 (`return err` replaced with `goto bottom`)
- **Scope**: Single-file, single-function surgical fix

Record: Very small, contained change to one function in one file.

### Step 2.2: UNDERSTAND THE CODE FLOW CHANGE
**Before**: When `rtw89_mac_suppress_log()` returns true, the function
immediately returns without clearing HALT_C2H. When it returns false,
the function dumps debug info and returns without clearing HALT_C2H.

**After**: Both paths converge at the `bottom:` label. For non-AX chips
(Wi-Fi 7/BE), `R_AX_HALT_C2H` is written to 0 before returning. AX chips
are unaffected.

Record: The change ensures HALT_C2H is always cleared for Wi-Fi 7 chips
regardless of which path is taken through the function.

### Step 2.3: IDENTIFY THE BUG MECHANISM
Record: This is a **hardware protocol fix** (category h). The Wi-Fi 7
firmware requires the HALT_C2H register to be reset after the driver
reads it, to acknowledge receipt of the error status. Without this, the
FW doesn't know the driver has read the error, potentially preventing
proper error recovery.

### Step 2.4: ASSESS THE FIX QUALITY
- **Obviously correct**: Yes - the register is already cleared to 0
  during initialization (line 4066). This just does the same during SER.
- **Minimal**: Yes - only 5 lines of actual change
- **Regression risk**: Very low - the new write only applies to non-AX
  chips, so existing Wi-Fi 6 behavior is completely unchanged
- **Red flags**: None

Record: High quality fix. Low regression risk. Only affects Wi-Fi 7
chips.

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: BLAME THE CHANGED LINES
The function `rtw89_mac_get_err_status()` was introduced in commit
`e3ec7017f6a20d` (2021-10-11, "rtw89: add Realtek 802.11ax driver"). The
function has been modified by:
- `198b6cf70146ca` (2022-03-14): Added error scenario parsing
- `f5d98831badb89` (2023-01-19): Added RXI300 error case
- `8130e94e888bf9` (2023-05-08): Added suppress_log functionality
- `6f8d36552bab7d` (2023-12-04): Switched to mac_gen_def for
  dump_err_status

Record: Function exists since driver inception. Has been incrementally
enhanced for new chips. Code is stable and well-understood.

### Step 3.2: FOLLOW THE FIXES TAG
Record: No Fixes: tag present (expected).

### Step 3.3: CHECK FILE HISTORY FOR RELATED CHANGES
Recent SER-related commits in the tree:
- `f4de946bdb379`: "wifi: rtw89: ser: enable error IMR after recovering
  from L1"
- `44ec302e029d8`: "wifi: rtw89: ser: L1 skip polling status if FW runs
  event mode"
- `6792fcf6a6912`: "wifi: rtw89: debug: tweak Wi-Fi 7 SER L0/L1
  simulation methods"

These are from a Dec 2025 series "refine MLO, MCC and SER functions".
The commit under review is from a later Feb 2026 series.

Record: Related SER improvements already in tree. This commit appears
standalone.

### Step 3.4: CHECK THE AUTHOR'S OTHER COMMITS
Zong-Zhe Yang is a regular Realtek contributor with many rtw89 commits
including SER-related work. Ping-Ke Shih is the primary rtw89
maintainer.

Record: Author is a regular subsystem contributor. Maintainer signed
off.

### Step 3.5: CHECK FOR DEPENDENT/PREREQUISITE COMMITS
The diff only uses existing types/macros: `rtw89_chip_info`, `chip_gen`,
`RTW89_CHIP_AX`, `R_AX_HALT_C2H`. All exist in the current tree.

Record: No dependencies. The patch applies standalone.

---

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

### Step 4.1: FIND THE ORIGINAL PATCH DISCUSSION
Using b4 dig on related commits, found the previous SER series (v3 from
Dec 2025). The commit under review is from a different, later series
(20260213061552.29997-12). Lore.kernel.org was blocked by Anubis
protection.

Record: Patch is from a series by Ping-Ke Shih. Could not access lore
directly due to bot protection. The previous SER series was titled
"refine MLO, MCC and SER functions" and went through v1-v3 before
merging.

### Step 4.2: CHECK WHO REVIEWED THE PATCH
Record: Ping-Ke Shih (rtw89 maintainer) signed off. Submitted through
standard wireless-next pipeline.

### Step 4.3-4.5: External research
Record: Could not access lore.kernel.org due to Anubis protection. No
stable-specific discussion found.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1-5.2: FUNCTION ANALYSIS
`rtw89_mac_get_err_status()` is called from:
- `rtw89_pci_interrupt_threadfn()` (pci.c line 968) - the PCI interrupt
  handler threaded function

This is the primary SER entry point when a HALT_C2H interrupt fires. The
interrupt handler calls `rtw89_mac_get_err_status()` to read the error
code, then passes it to `rtw89_ser_notify()` which triggers the SER
state machine.

Record: Called from interrupt handler. Critical path for error recovery.
Called for every SER event.

### Step 5.3-5.4: CALL CHAIN
Interrupt -> `rtw89_pci_interrupt_threadfn()` ->
`rtw89_mac_get_err_status()` -> reads register, returns error code ->
`rtw89_ser_notify()` -> `ser_send_msg()` -> SER state machine

Record: Reachable from hardware interrupt. Not userspace-triggerable
directly, but occurs during hardware error conditions which are real-
world events.

### Step 5.5: SEARCH FOR SIMILAR PATTERNS
The initialization code at line 4066 already performs
`rtw89_write32(rtwdev, R_AX_HALT_C2H, 0)` - confirming the protocol
requires this register to be cleared.

Record: Consistent with existing initialization code pattern.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: DOES THE BUGGY CODE EXIST IN STABLE TREES?
Wi-Fi 7 (RTL8922A/BE) support was added in v6.8. The `chip_gen` check
means only Wi-Fi 7 chips are affected. The function
`rtw89_mac_get_err_status()` exists in all stable trees from v5.15+, but
the bug only matters for trees with Wi-Fi 7 support (v6.8+).

Record: Bug is relevant to stable trees v6.8+.

### Step 6.2: BACKPORT COMPLICATIONS
The patch is small and touches a simple function. The code around it
hasn't changed dramatically. Should apply cleanly to any tree that has
the `rtw89_mac_suppress_log()` call (added in 2023) and `chip_gen`
(added in 2023).

Record: Clean apply expected on v6.8+.

### Step 6.3: RELATED FIXES
No duplicate fix found in stable trees.

Record: No related fixes already in stable.

---

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: SUBSYSTEM CRITICALITY
**Subsystem**: drivers/net/wireless/realtek/rtw89 (Wi-Fi driver)
**Criticality**: IMPORTANT - RTL8922A is a popular Wi-Fi 7 chipset used
in laptops and desktop PCIe cards.

Record: IMPORTANT - popular wireless driver with growing user base.

### Step 7.2: SUBSYSTEM ACTIVITY
Very active - many commits per month. Actively developed for Wi-Fi 7
support.

Record: Highly active subsystem.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: AFFECTED USERS
Users with RTL8922A (Wi-Fi 7) hardware. This is a PCIe wireless card
found in recent laptops and desktops.

Record: Driver-specific (Wi-Fi 7 / RTL8922A users). Growing user
population.

### Step 8.2: TRIGGER CONDITIONS
Triggered when a SER (system error recovery) interrupt fires on Wi-Fi 7
hardware. This happens during firmware errors, which can occur due to:
- Firmware assertions
- DMA errors
- Watchdog timeouts
- Various hardware error conditions

Record: Trigger is hardware-dependent error condition. Not predictable
but real-world occurrence.

### Step 8.3: FAILURE MODE SEVERITY
Without this fix, when SER triggers on Wi-Fi 7:
- Firmware doesn't know driver acknowledged the error
- SER recovery flow may stall or not complete properly
- Wi-Fi device may become non-functional requiring manual intervention
  (module reload/reboot)

Record: **HIGH** severity - device recovery failure, Wi-Fi becomes
unusable until manual intervention.

### Step 8.4: RISK-BENEFIT RATIO
- **Benefit**: Ensures Wi-Fi 7 SER recovery works, preventing device
  failure during error conditions
- **Risk**: Very low - 5-line change, only affects non-AX chips,
  consistent with initialization code pattern
- **Ratio**: Very favorable - high benefit, very low risk

Record: Benefit HIGH, Risk VERY LOW. Strongly favorable ratio.

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: EVIDENCE COMPILATION

**FOR backporting:**
- Fixes broken SER recovery on Wi-Fi 7 chips (real functional bug)
- Small, surgical fix (5 lines meaningful change)
- Self-contained, no dependencies on other patches
- Only affects Wi-Fi 7 chips (no regression risk for existing hardware)
- Consistent with existing initialization pattern (line 4066)
- From vendor driver team (Realtek) with maintainer sign-off
- Critical error recovery path

**AGAINST backporting:**
- No explicit user bug reports or crash reports
- No Fixes: tag
- Part of a "rtw-next" development series
- Only affects Wi-Fi 7 users (relatively new hardware)
- Commit message doesn't describe explicit user-visible failure

**UNRESOLVED:**
- Could not verify lore.kernel.org discussion due to bot protection
- Exact failure behavior without this fix is inferred (not explicitly
  documented)

### Step 9.2: STABLE RULES CHECKLIST
1. **Obviously correct and tested?** YES - writes 0 to same register
   cleared at init, gated by chip_gen check
2. **Fixes a real bug?** YES - incomplete Wi-Fi 7 SER protocol
   implementation
3. **Important issue?** YES - device recovery failure leads to non-
   functional Wi-Fi
4. **Small and contained?** YES - 5 lines in one function
5. **No new features or APIs?** CORRECT - no new features
6. **Can apply to stable trees?** YES - applicable to v6.8+ (when Wi-Fi
   7 support was added)

### Step 9.3: EXCEPTION CATEGORIES
This is a hardware workaround/fix category - it fixes the SER protocol
for Wi-Fi 7 chipsets.

### Step 9.4: DECISION
The fix is small, obviously correct, self-contained, and addresses a
real functional bug in Wi-Fi 7 error recovery. The risk is very low
(only affects Wi-Fi 7 chips, consistent with existing patterns). The
benefit is significant (broken SER means device can't recover from
errors).

---

## Verification

- [Phase 1] Parsed tags: Signed-off-by from Zong-Zhe Yang and Ping-Ke
  Shih; Link to patch series
- [Phase 2] Diff analysis: 5 lines added to
  `rtw89_mac_get_err_status()`, adds HALT_C2H register clear for non-AX
  chips
- [Phase 3] git blame: function introduced in e3ec7017f6a20d
  (2021-10-11), present since driver inception
- [Phase 3] git log: confirmed related SER commits (f4de946bdb379,
  44ec302e029d8) already in tree
- [Phase 3] git merge-base: RTL8922A (Wi-Fi 7) support added in v6.8
  (commit c0a04552e36e1, 2023-11-17)
- [Phase 4] b4 dig -c f4de946bdb379 -a: found series went through v1-v3
  before merging
- [Phase 4] lore.kernel.org: blocked by Anubis protection, could not
  access discussions
- [Phase 5] grep callers: `rtw89_mac_get_err_status` called from PCI
  interrupt handler threadfn (pci.c:968)
- [Phase 5] grep: `R_AX_HALT_C2H` already cleared to 0 at init time
  (mac.c:4066), confirming protocol requirement
- [Phase 6] chip_gen RTW89_CHIP_BE exists since v6.8;
  `rtw89_mac_suppress_log` since v6.5
- [Phase 6] Patch applies standalone - no dependencies on other patches
  from series
- [Phase 8] Failure mode: device recovery failure on Wi-Fi 7, severity
  HIGH
- UNVERIFIED: Exact FW behavior when HALT_C2H not cleared (inferred from
  commit message and protocol)
- UNVERIFIED: Could not access lore discussion for reviewer comments

**YES**

 drivers/net/wireless/realtek/rtw89/mac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8472f1a63951b..fa60f8e8bb3d4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -814,6 +814,7 @@ static bool rtw89_mac_suppress_log(struct rtw89_dev *rtwdev, u32 err)
 u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 err, err_scnr;
 	int ret;
 
@@ -836,11 +837,15 @@ u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 		err = MAC_AX_ERR_RXI300;
 
 	if (rtw89_mac_suppress_log(rtwdev, err))
-		return err;
+		goto bottom;
 
 	rtw89_fw_st_dbg_dump(rtwdev);
 	mac->dump_err_status(rtwdev, err);
 
+bottom:
+	if (chip->chip_gen != RTW89_CHIP_AX)
+		rtw89_write32(rtwdev, R_AX_HALT_C2H, 0);
+
 	return err;
 }
 EXPORT_SYMBOL(rtw89_mac_get_err_status);
-- 
2.53.0


