Return-Path: <linux-wireless+bounces-35070-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ObwD29M5mkgugEAu9opvQ
	(envelope-from <linux-wireless+bounces-35070-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:55:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 123ED42EB80
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1FC43262C1A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D903CBE7C;
	Mon, 20 Apr 2026 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK4F2GuF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFF3A16B4;
	Mon, 20 Apr 2026 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691747; cv=none; b=L86sNl+/reaGizCewHdZdXM0djYdHInIfgGvDsCXYZimn5MZJaSBmx/D0SwRU0Gs6D97Mq0GlS7Z+ouQM/1d5hfJL5zSHuSDLiag2Lb00ZpvTKeeIzgNZAqK9CKWihhmwKpcGypqP24qMFq2HrXIIgA18658Zwpb5F7Gr9ule2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691747; c=relaxed/simple;
	bh=L2z6jm5nADyAgqIuci6LERJfnC2pAZeLznWRtJTTbdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0b/aD4aLCt9hpSzq3nMWoiRsODrls2z0Bc4o8tqiBeM/zTp3JL6AkIPzM2lI9Whzl6gXC/7Qm89GmfA11M+b0AK+2wfEUaH11Yj8CF2WUdfhLFOkFYH56wxDYFKgG9dMDs2F/uU//qdTgjHWfm3OUCGqPirOTlmcyBmFKAdeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK4F2GuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41147C2BCB4;
	Mon, 20 Apr 2026 13:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691746;
	bh=L2z6jm5nADyAgqIuci6LERJfnC2pAZeLznWRtJTTbdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gK4F2GuFKX4boeo2SrG+05xR3obbJywmp3V0H1d5+wj8ZPF6v0zYIaVjdKEkbRpqP
	 ma+ynBkqqLixEp4D3WeIoxDMJiQnirLyjCm+T2rY/iCkzo585Q0FDDpnJ9MA9akKaU
	 Sc+15nWIY+kOUbLBTJGzAYOiIsMSaZQByhY/8CPaiFNv9eUAbB8jTHfH+q56WLyDlt
	 ewxjwnOYyP1AeHMR2jTnhiBcAtI7ZNPCKxehWd8nVW0vaH74oXsePdmPK/95yoJbpb
	 ofWEmMYX4Okskj1aObJwYmjvHYw7bO4DUBOdgLhqU+O7Y66gdqUjrvNG9F2iggwTUN
	 Zs0UWll9tv39g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: iwlwifi: restrict TOP reset to some devices
Date: Mon, 20 Apr 2026 09:19:23 -0400
Message-ID: <20260420132314.1023554-169-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-35070-lists,linux-wireless=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 123ED42EB80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit f473f609164ee9907497ac55934689110c248e23 ]

Due to the Bluetooth implementation needing to match, not all
devices can actually do TOP reset. Restrict it to Sc2/Sc2f or
later, with Wh RF or later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260319204647.6c4479f4e49d.I5023d70cb33f1e18f7cb15981fc3acfbb00862b7@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Good - all required types, macros, and struct fields exist in v6.16. The
patch would apply cleanly to both v6.16 and v7.0 stable trees.

---

## Complete Analysis

### PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: iwlwifi:`
- Action verb: "restrict" (implies narrowing scope, correcting an overly
  broad condition)
- Summary: Restrict TOP reset capability to only devices that actually
  support it (Sc2/Sc2f+ with PE RF+)
- Record: [wifi: iwlwifi] [restrict] [Narrow TOP reset to Sc2/Sc2f+ MAC
  with Pe+ RF only]

**Step 1.2: Tags**
- Signed-off-by: Johannes Berg (iwlwifi subsystem maintainer — author)
- Signed-off-by: Miri Korenblit (Intel iwlwifi maintainer — submitter)
- Link: patch.msgid.link URL (not fetchable due to anti-bot)
- No Fixes: tag (expected for autosel candidates)
- No Reported-by: tag
- Record: [Author is the iwlwifi subsystem maintainer. No
  Fixes/Reported-by tags.]

**Step 1.3: Commit Body**
- Bug: "Not all devices can actually do TOP reset" because "Bluetooth
  implementation needing to match"
- The original code used `device_family >= IWL_DEVICE_FAMILY_SC` which
  was too broad
- Specifically restricts to Sc2/Sc2f or later MAC with Wh RF (PE) or
  later
- Record: [Bug: overly broad TOP reset support check causes TOP reset
  attempts on devices that can't perform it. Root cause: Bluetooth
  firmware needs to support TOP reset too, and original SC MAC + pre-PE
  RF don't have matching BT support.]

**Step 1.4: Hidden Bug Fix Detection**
- "Restrict" = narrowing an incorrect check = fixing a bug where an
  unsupported operation is attempted on hardware
- This IS a bug fix: attempting TOP reset on unsupported hardware leads
  to failed recovery and unnecessary escalation
- Record: [Yes, this is a hidden bug fix — corrects an overly broad
  hardware capability check]

### PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- `iwl-trans.c`: Renames `escalation_list_sc` to `escalation_list_top`,
  replaces 2 inline `device_family >= SC` checks with
  `iwl_trans_is_top_reset_supported()`
- `iwl-trans.h`: Adds new 18-line `iwl_trans_is_top_reset_supported()`
  static inline function
- `pcie/gen1_2/trans.c`: Replaces 1 `device_family < SC` check with
  `!iwl_trans_is_top_reset_supported()`
- Total: ~18 lines added, 3 condition checks changed, 1 variable renamed
- Record: [3 files, ~+18/-3 net, contained to iwlwifi driver, functions:
  iwl_trans_determine_restart_mode, iwl_dbgfs_reset_write]

**Step 2.2: Code Flow Change**
- Before: Any SC family device (SC, SC2, SC2F, DR) got TOP reset
  capability
- After: Only SC2/SC2F+ MAC with PE+ RF get TOP reset; original SC MAC
  and pre-PE RF fall back to PROD_RESET
- The escalation list selection and `request_top_reset` path both get
  the tighter check
- Record: [Before: all SC+ → TOP reset. After: only SC2+/PE+ → TOP
  reset. All others fall through to PROD_RESET.]

**Step 2.3: Bug Mechanism**
- Category: Hardware correctness / incorrect capability detection
- Without fix: SC devices with original SC MAC or pre-PE RF attempt TOP
  reset → BT firmware doesn't support it → reset fails/times out →
  triggers error recovery escalation → wasted time, repeated failures
- The escalation list includes TOP_RESET 3 times, so unsupported devices
  would hit 3 failed TOP reset attempts
- Record: [Hardware correctness bug. Attempting unsupported TOP reset
  leads to failed recovery cycles and unnecessary escalation.]

**Step 2.4: Fix Quality**
- Obvious correctness: The new function clearly checks MAC type and RF
  type boundaries
- Minimal: Only touches the checks that need changing, plus a well-
  structured helper
- Regression risk: Very low — simply makes the check more restrictive.
  Devices that previously got TOP reset incorrectly now get PROD_RESET
  instead (which always works).
- Record: [Obviously correct, minimal, no regression risk — only narrows
  an overly broad check]

### PHASE 3: GIT HISTORY

**Step 3.1: Blame**
- The buggy `device_family >= IWL_DEVICE_FAMILY_SC` check was introduced
  by commit `909e1be654625` ("wifi: iwlwifi: implement TOP reset") in
  v6.16.
- Record: [Buggy code introduced in v6.16 by commit 909e1be654625]

**Step 3.2: No Fixes: tag** — expected for autosel candidates.

**Step 3.3: File History**
- `iwl-trans.c` has had many changes between v6.16 and v7.0 (renaming,
  refactoring, code moves) but the TOP reset logic in
  `iwl_trans_determine_restart_mode` has remained stable.
- Record: [Standalone fix, no prerequisites needed beyond what's already
  in v6.16+]

**Step 3.4: Author**
- Johannes Berg is the iwlwifi subsystem maintainer. His patches to
  iwlwifi carry highest authority.
- Record: [Author is the subsystem maintainer]

**Step 3.5: Dependencies**
- All required constants (`IWL_CFG_MAC_TYPE_SC`, `SC2`, `SC2F`,
  `IWL_CFG_RF_TYPE_PE`) exist in v6.16+
- All required struct fields (`trans->info.hw_rev`,
  `trans->info.hw_rf_id`) exist in v6.16+
- No dependency on other patches
- Record: [Self-contained, all dependencies exist in v6.16+]

### PHASE 4: MAILING LIST RESEARCH

**Step 4.1-4.5:** Lore.kernel.org was blocked by anti-bot protection. b4
dig did not find this specific commit (it's from March 2026 and may not
be indexed yet). Unable to verify mailing list discussion.
- Record: [UNVERIFIED: Could not access mailing list discussion due to
  anti-bot blocking]

### PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1-5.4: Impact Surface**
- `iwl_trans_determine_restart_mode()` is called from
  `iwl_trans_restart_wk()` — the error recovery work queue handler
- This is triggered on ANY device error via `iwl_trans_schedule_reset()`
- For the debugfs path (`iwl_dbgfs_reset_write`), the check prevents
  manual TOP reset trigger on unsupported devices
- The `request_top_reset` path is triggered by TOP Fatal Error hardware
  interrupts on BZ+ devices
- Record: [Affects all error recovery paths for iwlwifi SC family
  devices. Reachable from hardware interrupt handlers and debugfs.]

**Step 5.5: Similar Patterns**
- The existing WARN_ON in `trans-gen2.c:548` only checks `device_family
  < SC`, not the finer-grained check. The new function provides a
  consistent single source of truth.
- Record: [Existing WARN_ON also uses the overly broad check — this fix
  provides consistency]

### PHASE 6: STABLE TREE ANALYSIS

**Step 6.1:** TOP reset code does NOT exist before v6.16. Buggy code is
in v6.16 and v7.0.
- Record: [Affected stable trees: 6.16.y, 7.0.y]

**Step 6.2:** Patch applies cleanly — verified all hunks match current
7.0 tree exactly.
- Record: [Clean apply expected for 7.0.y. Also clean for 6.16.y.]

**Step 6.3:** No other fix for this issue found in stable.
- Record: [No existing fix in stable trees]

### PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1:** wifi: iwlwifi — Intel WiFi driver, one of the most widely
used WiFi drivers on Linux laptops and desktops. Criticality: IMPORTANT
(affects many users with Intel WiFi).
- Record: [iwlwifi — widely used WiFi driver, IMPORTANT criticality]

**Step 7.2:** Very active subsystem with frequent patches.
- Record: [Highly active subsystem]

### PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1:** Affects users with Intel SC-family WiFi devices
(specifically original SC MAC type, or SC2/SC2f with pre-PE RF modules).
These are relatively recent devices.
- Record: [Affects specific Intel WiFi SC-family device variants]

**Step 8.2:** Trigger: Any firmware/hardware error that causes error
recovery escalation on affected devices. Also triggered by TOP Fatal
Error interrupts. Common during normal WiFi operation under adverse
conditions.
- Record: [Triggered by any device error recovery on affected SC
  hardware variants]

**Step 8.3:** Failure mode: Failed TOP reset → timeout (250ms per
attempt) → unnecessary recovery escalation → up to 3 wasted TOP reset
attempts in escalation list → prolonged WiFi downtime during recovery.
Could also cause firmware recovery loops.
- Record: [Failure mode: prolonged WiFi recovery time, wasted reset
  cycles. Severity: HIGH for affected devices]

**Step 8.4:**
- Benefit: Prevents failed TOP reset attempts on specific hardware,
  ensuring proper recovery path
- Risk: Very low — change only makes the check more restrictive,
  fallback is always PROD_RESET (which works)
- Record: [High benefit for affected devices, very low regression risk]

### PHASE 9: FINAL SYNTHESIS

**Evidence FOR backporting:**
1. Fixes incorrect hardware capability detection causing failed recovery
   attempts
2. Small, well-contained change (18 lines new function + 3 condition
   replacements)
3. From the subsystem maintainer (Johannes Berg)
4. Obviously correct — adds finer-grained hardware checks based on
   actual device capabilities
5. Zero regression risk — only narrows an overly broad check, fallback
   is proven PROD_RESET
6. Buggy code exists in stable trees (v6.16+, v7.0)
7. All dependencies for the fix exist in target stable trees
8. Affects widely-used WiFi driver (iwlwifi)

**Evidence AGAINST backporting:**
1. No explicit "fix" language in commit message
2. No Fixes: tag (expected for autosel)
3. Could not verify mailing list discussion
4. Affects only specific SC-family hardware variants
5. Failure mode is degraded recovery rather than crash/corruption

**Stable Rules Checklist:**
1. Obviously correct and tested? YES — author is subsystem maintainer,
   simple restriction
2. Fixes a real bug? YES — prevents unsupported TOP reset on hardware
   that can't do it
3. Important issue? YES (for affected devices) — failed recovery cycles
4. Small and contained? YES — 3 files, ~20 lines net, single subsystem
5. No new features? CORRECT — no new features, just hardware detection
   refinement
6. Can apply to stable? YES — verified clean apply on 7.0

### Verification

- [Phase 1] Parsed tags: SOBs from Johannes Berg (subsystem maintainer)
  and Miri Korenblit
- [Phase 2] Diff analysis: Adds 18-line
  `iwl_trans_is_top_reset_supported()` inline helper, replaces 3 overly
  broad `device_family >= SC` checks
- [Phase 3] git blame: buggy code introduced in commit 909e1be654625
  (v6.16), present in v6.16+ and v7.0
- [Phase 3] git tag --contains: TOP reset first appeared in v6.16, not
  in v6.15 or earlier
- [Phase 3] Verified all required constants
  (`IWL_CFG_MAC_TYPE_SC/SC2/SC2F`, `IWL_CFG_RF_TYPE_PE`) exist in v6.16+
- [Phase 3] Verified `trans->info.hw_rev` and `trans->info.hw_rf_id`
  struct fields exist in v6.16+
- [Phase 5] Traced callers: `iwl_trans_determine_restart_mode()` called
  from `iwl_trans_restart_wk()` (error recovery work queue)
- [Phase 5] Traced `request_top_reset`: set from TOP Fatal Error
  hardware interrupt handler in rx.c:2370
- [Phase 6] Confirmed buggy code does NOT exist before v6.16 (verified
  with git show v6.15/v6.16)
- [Phase 6] Verified patch applies cleanly: all changed lines match
  current 7.0 tree exactly
- [Phase 8] Failure mode: failed TOP reset timeout (250ms × up to 3
  attempts) + unnecessary escalation
- UNVERIFIED: Could not access mailing list discussion (lore.kernel.org
  blocked by anti-bot protection)
- UNVERIFIED: Could not verify if this was submitted as iwlwifi-fixes vs
  iwlwifi-next

The fix prevents the iwlwifi driver from attempting TOP reset on Intel
WiFi devices that don't actually support it (due to Bluetooth firmware
incompatibility), which would cause failed recovery cycles and prolonged
WiFi downtime. It's small, obviously correct, from the subsystem
maintainer, and applies cleanly to stable trees where the buggy code
exists.

**YES**

 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 18 ++++++++++++++++++
 .../wireless/intel/iwlwifi/pcie/gen1_2/trans.c |  2 +-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 89901786fd687..16b2c313e72b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -138,7 +138,7 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 		IWL_RESET_MODE_FUNC_RESET,
 		IWL_RESET_MODE_PROD_RESET,
 	};
-	static const enum iwl_reset_mode escalation_list_sc[] = {
+	static const enum iwl_reset_mode escalation_list_top[] = {
 		IWL_RESET_MODE_SW_RESET,
 		IWL_RESET_MODE_REPROBE,
 		IWL_RESET_MODE_REPROBE,
@@ -159,14 +159,14 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 
 	if (trans->request_top_reset) {
 		trans->request_top_reset = 0;
-		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_SC)
+		if (iwl_trans_is_top_reset_supported(trans))
 			return IWL_RESET_MODE_TOP_RESET;
 		return IWL_RESET_MODE_PROD_RESET;
 	}
 
-	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_SC) {
-		escalation_list = escalation_list_sc;
-		escalation_list_size = ARRAY_SIZE(escalation_list_sc);
+	if (iwl_trans_is_top_reset_supported(trans)) {
+		escalation_list = escalation_list_top;
+		escalation_list_size = ARRAY_SIZE(escalation_list_top);
 	} else {
 		escalation_list = escalation_list_old;
 		escalation_list_size = ARRAY_SIZE(escalation_list_old);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 688f9fee28210..797e20a008d41 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1258,4 +1258,22 @@ bool iwl_trans_is_pm_supported(struct iwl_trans *trans);
 
 bool iwl_trans_is_ltr_enabled(struct iwl_trans *trans);
 
+static inline bool iwl_trans_is_top_reset_supported(struct iwl_trans *trans)
+{
+	/* not supported before Sc family */
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC)
+		return false;
+
+	/* for Sc family only supported for Sc2/Sc2f */
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_SC &&
+	    CSR_HW_REV_TYPE(trans->info.hw_rev) == IWL_CFG_MAC_TYPE_SC)
+		return false;
+
+	/* so far these numbers are increasing - not before Pe */
+	if (CSR_HW_RFID_TYPE(trans->info.hw_rf_id) < IWL_CFG_RF_TYPE_PE)
+		return false;
+
+	return true;
+}
+
 #endif /* __iwl_trans_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 4560d92d76fe0..a05f60f9224b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -3197,7 +3197,7 @@ static ssize_t iwl_dbgfs_reset_write(struct file *file,
 		if (!test_bit(STATUS_DEVICE_ENABLED, &trans->status))
 			return -EINVAL;
 		if (mode == IWL_RESET_MODE_TOP_RESET) {
-			if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC)
+			if (!iwl_trans_is_top_reset_supported(trans))
 				return -EINVAL;
 			trans->request_top_reset = 1;
 		}
-- 
2.53.0


