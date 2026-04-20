Return-Path: <linux-wireless+bounces-35063-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGhdMDsx5ml6tAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35063-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:59:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D87742C803
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36C60321D4A5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01163EFD25;
	Mon, 20 Apr 2026 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYWGF2Di"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8E3EFD1B;
	Mon, 20 Apr 2026 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691528; cv=none; b=qGMnkk749ql+Ohm1Y4hAYbEk+qQWOzZaN4frjnhb/Y+w4sYfn78gJ1OoDTVhP6tF3WpHxIbcNOVlbvX6lGWq90zseaiVBuwSPqxl8nKPr3qic/P/Y+1Ps1cHYZbpmdZL9cgCNt11LYOEwefu3VQv9Udwh84d6GlvNnA6A9u1KGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691528; c=relaxed/simple;
	bh=xZeWLS00cNrQHhFhMdAB7QHipXmDGVVTsyHK/QHKDPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaIuCwcAecBg+q+L6LILw6gfdaztAYHdbUx44hNE7ERE8BpNq8qdelLaR2TYalBNWeY44DMvfUZkj/SEi7pGCxISg4RIVm0HbtkoBeeTz0vEcvTHEYc7+pB57Er0A2UEpQ8AJkyB8KUs3bAk1pyp9eZKvzX6VR57BnMuLol9rFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYWGF2Di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EAAC19425;
	Mon, 20 Apr 2026 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691528;
	bh=xZeWLS00cNrQHhFhMdAB7QHipXmDGVVTsyHK/QHKDPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYWGF2DiSwzbqPXxljc3soW7+uCbH5jZZ0OgRatpEiRYjmQXgpbrMkn0bwWEwfBnM
	 KZd9S7btFKmMFCY6s/AB9H6UUqTURQ4NQtAr6oBLIbk6MKtbIZ6A3TOsm2na4yZGLN
	 T1MHUjQG0+G34dy0CAY2C9WqJK4FEmoEn1zdyYQJcd5DOKN+W0KrqhmVAkWjpRF2N/
	 pm6L4A6hUdWvBByev+YkPbflDkM9bUOGnm2C0TKbXyBtBGylg1e3JeleLj9B04yrw2
	 +SPv0XDWFOSA/8cIv78mM//iibJbL6lyRtTEJGW2iEHMsgHX2nqmDqnH81SMzYNZ15
	 5433QwSpLLIoQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
	Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: ath12k: Set up MLO after SSR
Date: Mon, 20 Apr 2026 09:17:56 -0400
Message-ID: <20260420132314.1023554-82-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35063-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 6D87742C803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>

[ Upstream commit f33a8e41826831fc8ceb5f62833488cd9388ed59 ]

During recovery of an MLO setup from a core reset,
ATH12K_GROUP_FLAG_REGISTERED is set because ath12k_mac_unregister is not
called during core reset. So, when an MLO setup is recovering from a core
reset, ath12k_core_mlo_setup() is skipped. Hence, the firmware will not
have information about partner links. This makes MLO association fail
after recovery.

To resolve this, call ath12k_core_mlo_setup() during recovery, to set up
MLO. Also, if MLO setup fails during recovery, call
ath12k_mac_unregister() and ath12k_mac_destroy() to unregister mac and
then tear down the mac structures.

Also, initiate MLO teardown in the hardware group stop sequence to align
with the hardware group start sequence.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20260227041127.3265879-1-roopni.devanathan@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the data I need. Let me write the comprehensive analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: PARSE THE SUBJECT LINE
- **Subsystem**: wifi: ath12k (Qualcomm ath12k wireless driver)
- **Action verb**: "Set up" - implies ensuring required initialization
  happens
- **Summary**: Set up MLO (Multi-Link Operation) after SSR (Subsystem
  Restart/Recovery)
Record: [wifi: ath12k] [Set up] [Ensure MLO is configured after SSR
recovery to avoid association failure]

### Step 1.2: PARSE ALL COMMIT MESSAGE TAGS
- **Tested-on**: QCN9274 hw2.0 PCI
  WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
- **Signed-off-by**: Ramya Gnanasekar (co-author), Roopni Devanathan
  (author), Jeff Johnson (maintainer)
- **Reviewed-by**: Baochen Qiang, Vasanthakumar Thiagarajan (both
  Qualcomm reviewers)
- **Link**: patch.msgid.link (original submission URL)
- **No Fixes: tag** (expected for autosel candidates)
- **No Cc: stable** (expected)
Record: Two Qualcomm reviewers reviewed the patch. Jeff Johnson (ath12k
maintainer) applied it. Tested on real hardware.

### Step 1.3: ANALYZE THE COMMIT BODY TEXT
The bug: During recovery from a core reset with MLO setup,
`ATH12K_GROUP_FLAG_REGISTERED` remains set because
`ath12k_mac_unregister()` is NOT called during core reset. Therefore,
when `ath12k_core_hw_group_start()` is called during recovery, it sees
the flag is set and jumps over the `ath12k_core_mlo_setup()` call. This
means the firmware doesn't receive partner link information, causing MLO
association to fail after recovery.

Record: [Bug: MLO association fails after firmware recovery] [Symptom:
WiFi MLO cannot associate after SSR] [Root cause:
ath12k_core_mlo_setup() skipped during recovery because
ATH12K_GROUP_FLAG_REGISTERED is still set]

### Step 1.4: DETECT HIDDEN BUG FIXES
This is a clear bug fix - MLO association fails after recovery. The
commit message explicitly describes a failure mode. Not hidden at all.
Record: [This is an explicit bug fix for recovery failure]

---

## PHASE 2: DIFF ANALYSIS - LINE BY LINE

### Step 2.1: INVENTORY THE CHANGES
- **File**: `drivers/net/wireless/ath/ath12k/core.c` only
- **Change 1**: `ath12k_core_hw_group_stop()` - 2 lines added (call to
  `ath12k_mac_mlo_teardown(ag)`)
- **Change 2**: `ath12k_core_hw_group_start()` - ~8 lines modified (add
  MLO setup in recovery path with error handling)
- **Total**: ~10 lines added/modified
- **Functions modified**: `ath12k_core_hw_group_stop()`,
  `ath12k_core_hw_group_start()`
Record: [Single file, ~10 lines changed, two functions modified,
surgical fix]

### Step 2.2: UNDERSTAND THE CODE FLOW CHANGE

**Hunk 1** (`ath12k_core_hw_group_stop`):
- Before: `ath12k_mac_unregister(ag)` then loop cleanup then
  `ath12k_mac_destroy(ag)` - no MLO teardown.
- After: `ath12k_mac_unregister(ag)` then `ath12k_mac_mlo_teardown(ag)`
  then loop cleanup then `ath12k_mac_destroy(ag)`.
- This aligns the stop sequence with the start sequence (MLO setup
  happens in start, so MLO teardown should happen in stop).

**Hunk 2** (`ath12k_core_hw_group_start`):
- Before: When `ATH12K_GROUP_FLAG_REGISTERED` is set, jumps directly to
  `core_pdev_create` - skipping all MLO setup.
- After: When the flag is set, calls `ath12k_core_mlo_setup(ag)` first,
  with error handling that calls `ath12k_mac_unregister()` and falls
  through to `err_mac_destroy` on failure. Then proceeds to
  `core_pdev_create` as before.

Record: [Fix adds MLO setup in recovery path and teardown in stop path
to match start/stop symmetry]

### Step 2.3: IDENTIFY THE BUG MECHANISM
- **Category**: Logic / correctness fix
- **Mechanism**: Missing initialization during recovery path. The MLO
  setup was only done on first-time start (when
  `ATH12K_GROUP_FLAG_REGISTERED` is not set), but needs to also be done
  on recovery (when the flag IS set but firmware state was lost).
Record: [Logic bug - MLO firmware setup skipped during recovery, causing
MLO association failure]

### Step 2.4: ASSESS THE FIX QUALITY
- The fix is obviously correct - adding `ath12k_core_mlo_setup()` to the
  recovery path is the logical fix.
- Error handling is properly added (if MLO setup fails during recovery,
  unregister and destroy).
- Adding teardown in stop path creates symmetry with start path.
- Low regression risk - only affects the recovery code path.
Record: [Fix is obviously correct, minimal, well-contained, proper error
handling added]

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: BLAME THE CHANGED LINES
- The buggy code was introduced by commit `b716a10d99a28` ("wifi:
  ath12k: enable MLO setup and teardown from core", Dec 2024) and
  `a343d97f27f514` ("wifi: ath12k: move struct ath12k_hw from per device
  to group", Dec 2024).
- Both first appeared in v6.14.
Record: [Buggy code introduced in v6.14 by b716a10d99a28 and
a343d97f27f514]

### Step 3.2: FOLLOW THE FIXES: TAG
No Fixes: tag present (expected for autosel candidates).
Record: [N/A - no Fixes tag]

### Step 3.3: CHECK FILE HISTORY
- `core.c` has had extensive recovery-related fixes between v6.15 and
  v6.16 (the "fix_reboot_issues_with_hw_grouping" series with 9 commits
  in v6.16).
- This current commit is a continuation of that series, fixing another
  aspect of recovery that was missed.
Record: [This is a standalone fix that addresses an issue not covered by
the previous v6.16 recovery series]

### Step 3.4: CHECK THE AUTHOR'S OTHER COMMITS
- Roopni Devanathan (author) has 7+ commits in ath12k, is a regular
  contributor from Qualcomm.
- Ramya Gnanasekar (co-author) has 13+ commits in ath12k.
- Both Reviewed-by are from Qualcomm engineers who know the codebase.
Record: [Author is a regular contributor, reviewed by knowledgeable team
members]

### Step 3.5: CHECK FOR DEPENDENT/PREREQUISITE COMMITS
- The functions used (`ath12k_core_mlo_setup`,
  `ath12k_mac_mlo_teardown`, `ath12k_mac_unregister`,
  `ath12k_mac_destroy`) all exist in the 7.0 tree.
- The recovery flow with `ath12k_core_reset()` and
  `ath12k_core_restart()` with hardware grouping exists in 7.0 (added in
  v6.16).
- The diff context matches the current 7.0 code exactly.
Record: [No additional dependencies needed - patch applies cleanly to
7.0]

---

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

### Step 4.1: FIND THE ORIGINAL PATCH DISCUSSION
- Retrieved via b4 mbox. The patch was submitted as "[PATCH ath-next]"
  (single patch, not a series).
- Jeff Johnson replied "Applied, thanks!" with commit hash
  `f33a8e41826831fc8ceb5f62833488cd9388ed59`.
- Two Reviewed-by tags from Baochen Qiang and Vasanthakumar Thiagarajan
  were present on the original submission.
Record: [Single patch, applied by ath12k maintainer Jeff Johnson,
reviewed by 2 Qualcomm engineers]

### Step 4.2: CHECK WHO REVIEWED THE PATCH
- Baochen Qiang (Qualcomm) - regular ath12k reviewer
- Vasanthakumar Thiagarajan (Qualcomm) - senior ath12k developer
Record: [Reviewed by experienced ath12k engineers]

### Step 4.3: SEARCH FOR THE BUG REPORT
No external bug report linked. The bug was found during internal testing
at Qualcomm.
Record: [Internal finding, tested on QCN9274 hardware]

### Step 4.4: CHECK FOR RELATED PATCHES AND SERIES
- This is a standalone patch, not part of a series.
- Related to the earlier v6.16 "fix_reboot_issues_with_hw_grouping"
  series but is an independent fix.
Record: [Standalone patch, no dependencies on other unmerged patches]

### Step 4.5: CHECK STABLE MAILING LIST HISTORY
- Could not verify due to lore.kernel.org Anubis protection.
Record: [Unable to check stable mailing list - lore blocked]

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: KEY FUNCTIONS
- `ath12k_core_hw_group_start()` - called during device bring-up and
  recovery
- `ath12k_core_hw_group_stop()` - called during device shutdown and
  error handling

### Step 5.2: TRACE CALLERS
- `ath12k_core_hw_group_start()` is called from
  `ath12k_core_qmi_firmware_ready()` (line 1319) during normal device
  bring-up AND from the recovery path.
- `ath12k_core_hw_group_stop()` is called from the error path of
  `ath12k_core_hw_group_start()` and from `ath12k_core_deinit()`.
Record: [Functions called during normal operation and recovery -
recovery path is common for QCN9274 users]

### Step 5.3-5.5: CALL CHAIN / SIMILAR PATTERNS
- The recovery path: firmware crash → `ath12k_core_reset()` →
  `ath12k_hif_power_up()` → firmware restarts → QMI ready →
  `ath12k_core_hw_group_start()` → (bug: skips MLO setup) → recovery
  fails
Record: [Bug is in a common recovery code path triggered by firmware
crashes]

---

## PHASE 6: CROSS-REFERENCING AND STABLE TREE ANALYSIS

### Step 6.1: DOES THE BUGGY CODE EXIST IN STABLE TREES?
- The buggy code was introduced in v6.14.
- The MLO hw_group code exists in: v6.14, v6.15, v6.16, v6.17, v6.18,
  7.0
- The recovery-with-grouping code was added in v6.16 (the series from
  6af396942bf13).
- **For the bug to be triggerable, BOTH the MLO setup code AND the
  recovery-with-grouping code must exist.**
- Both are present in v6.16+ and in 7.0.
Record: [Buggy code exists in v6.16+ stable trees and 7.0]

### Step 6.2: CHECK FOR BACKPORT COMPLICATIONS
- The diff context matches the current 7.0 code exactly - the patch
  should apply cleanly.
- All referenced functions exist in 7.0.
Record: [Clean apply expected for 7.0]

### Step 6.3: CHECK IF RELATED FIXES ARE ALREADY IN STABLE
- The v6.16 "fix_reboot_issues_with_hw_grouping" series is already in
  stable trees, but does NOT include the MLO setup fix that this commit
  provides.
Record: [No existing fix for this specific issue in stable]

---

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: IDENTIFY THE SUBSYSTEM
- **Subsystem**: WiFi driver (ath12k) - Qualcomm QCN9274/WCN7850
- **Criticality**: IMPORTANT - affects users of QCN9274 WiFi hardware
  using MLO
Record: [WiFi driver, IMPORTANT - affects MLO users of QCN9274]

### Step 7.2: ASSESS SUBSYSTEM ACTIVITY
- ath12k is one of the most actively developed kernel subsystems - 62+
  commits to core.c between v6.14 and v7.0.
Record: [Highly active subsystem]

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: DETERMINE WHO IS AFFECTED
- Users of QCN9274 WiFi hardware with MLO (Multi-Link Operation)
  enabled.
- This is WiFi 7 hardware that supports MLO for improved throughput and
  reliability.
Record: [Driver-specific - affects QCN9274 MLO users]

### Step 8.2: DETERMINE THE TRIGGER CONDITIONS
- Trigger: Firmware crash (not uncommon with WiFi firmware) followed by
  SSR recovery.
- After recovery, MLO association fails completely - WiFi connectivity
  is broken until manual restart.
Record: [Triggered by firmware crash recovery - moderately common
scenario]

### Step 8.3: DETERMINE THE FAILURE MODE SEVERITY
- **Failure mode**: Complete MLO association failure after recovery -
  WiFi becomes non-functional for MLO connections.
- **Severity**: HIGH - loss of WiFi connectivity after firmware
  recovery, defeating the purpose of SSR.
Record: [HIGH - WiFi MLO connectivity lost after firmware recovery]

### Step 8.4: CALCULATE RISK-BENEFIT RATIO
- **Benefit**: Fixes complete MLO failure after firmware recovery -
  restores WiFi functionality.
- **Risk**: Very low - ~10 lines, well-contained, only affects recovery
  path, proper error handling added.
- **Ratio**: High benefit / very low risk = FAVORABLE.
Record: [High benefit, very low risk]

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: COMPILE THE EVIDENCE
**FOR backporting:**
- Fixes a real bug (MLO association failure after SSR recovery)
- Small, surgical fix (~10 lines in one file)
- Tested on real hardware (QCN9274 hw2.0)
- Reviewed by 2 experienced engineers, applied by subsystem maintainer
- Obviously correct - adds missing initialization in recovery path
- All required functions exist in 7.0 tree
- Patch applies cleanly to current 7.0 code
- Proper error handling included

**AGAINST backporting:**
- Submitted to ath-next (not explicitly targeted for stable)
- No Fixes: tag (expected for autosel)
- No Cc: stable (expected for autosel)
- Affects only QCN9274 MLO users (limited user base, though growing with
  WiFi 7 adoption)
- The recovery infrastructure this depends on was introduced relatively
  recently (v6.16)

### Step 9.2: APPLY THE STABLE RULES CHECKLIST
1. **Obviously correct and tested?** YES - tested on QCN9274, reviewed
   by 2 engineers.
2. **Fixes a real bug that affects users?** YES - MLO connectivity fails
   after firmware recovery.
3. **Important issue?** MODERATE-HIGH - WiFi connectivity loss after
   recovery.
4. **Small and contained?** YES - ~10 lines in one file, single function
   scope.
5. **No new features or APIs?** CORRECT - no new features.
6. **Can apply to stable trees?** YES - verified code context matches
   7.0 exactly.

### Step 9.3: CHECK FOR EXCEPTION CATEGORIES
Not an exception category (not device ID, quirk, DT, or build fix).
Standard bug fix.

### Step 9.4: DECISION
The fix is small, obviously correct, tested, reviewed, and fixes a real
user-impacting bug (MLO WiFi connectivity failure after firmware crash
recovery). The risk is minimal and the patch applies cleanly. However,
this is a driver-specific issue affecting QCN9274 MLO users - a growing
but specific audience. The fix meets all stable kernel criteria.

---

## Verification:
- [Phase 1] Parsed tags: found Tested-on (QCN9274), 2 Reviewed-by
  (Baochen Qiang, Vasanthakumar Thiagarajan), SOBs from Qualcomm team
- [Phase 2] Diff analysis: ~10 lines added to two functions in core.c -
  adds ath12k_core_mlo_setup() call in recovery path and
  ath12k_mac_mlo_teardown() in stop path
- [Phase 3] git blame: buggy code introduced by b716a10d99a28 (v6.14)
  and a343d97f27f514 (v6.14)
- [Phase 3] git tag --contains: b716a10d99a28 first appears in v6.14
- [Phase 3] Recovery-with-grouping commits (6af396942bf13 through
  f5755c23ed8a4) first appear in v6.16
- [Phase 3] All required functions (ath12k_core_mlo_setup,
  ath12k_mac_mlo_teardown, etc.) verified present in 7.0 tree
- [Phase 3] File context at lines 1126-1127 verified: the exact buggy
  code (skipping MLO setup when REGISTERED flag set) exists in 7.0
- [Phase 4] b4 mbox: found 4 messages in thread, Jeff Johnson "Applied,
  thanks!" with commit f33a8e41826831fc8ceb5f62833488cd9388ed59
- [Phase 4] Patch submitted as "[PATCH ath-next]" - single standalone
  patch
- [Phase 5] ath12k_core_hw_group_start called from
  ath12k_core_qmi_firmware_ready (line 1319) - verified in code
- [Phase 6] Code exists in 7.0 tree - verified via grep and Read
- [Phase 6] Diff context matches current 7.0 code exactly - verified by
  reading lines 998-1020 and 1119-1184
- [Phase 8] Failure mode: WiFi MLO association failure after firmware
  recovery - severity HIGH

**YES**

 drivers/net/wireless/ath/ath12k/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 4ed608ba3c304..a1834985bb63b 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1006,6 +1006,8 @@ static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
 
 	ath12k_mac_unregister(ag);
 
+	ath12k_mac_mlo_teardown(ag);
+
 	for (i = ag->num_devices - 1; i >= 0; i--) {
 		ab = ag->ab[i];
 		if (!ab)
@@ -1123,8 +1125,14 @@ static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
 
 	lockdep_assert_held(&ag->mutex);
 
-	if (test_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags))
+	if (test_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags)) {
+		ret = ath12k_core_mlo_setup(ag);
+		if (WARN_ON(ret)) {
+			ath12k_mac_unregister(ag);
+			goto err_mac_destroy;
+		}
 		goto core_pdev_create;
+	}
 
 	ret = ath12k_mac_allocate(ag);
 	if (WARN_ON(ret))
-- 
2.53.0


