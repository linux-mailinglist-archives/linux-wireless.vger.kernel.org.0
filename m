Return-Path: <linux-wireless+bounces-35051-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK01L4Ir5mkDswEAu9opvQ
	(envelope-from <linux-wireless+bounces-35051-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:34:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6832642C054
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0843C305658A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD9B3C73F6;
	Mon, 20 Apr 2026 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu09rmNH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554983C73E5;
	Mon, 20 Apr 2026 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691058; cv=none; b=gmEbIxDRVMWObconAAP2zILqIzhu77vSV3yp1565PZ8xgF2AiijchSKvc6ujcmxSJTptrLYVv/6DS3+Zc+DFLJbtiCty17kUo0t6Iu3T5uKkxkd/owXsl07GL9zY+d3uR/pFmFDqcqTV2KzxisxKl8Hr71tuX0lkRNJYB+gAn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691058; c=relaxed/simple;
	bh=xmjZr7nBExOm6+5J6CaHMHy6GKPbrkGxB2IzEUlk5hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAVBkrOO4I6iQMQcJSE2iaeBvjhzfn3NfjxjeL/uvyStsgkTwlyZUwMkmRZ7oWaauniQPzDukzpWs1pYVgIA9MO2gcxhKQzyHILZKeNw2r7fUsDjCtHeI4JJJAtnvtAmoX01SOWzBeTMWKU1N6YkYQYduSm9JQIlrbIquDGTFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu09rmNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183DCC2BCB4;
	Mon, 20 Apr 2026 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691058;
	bh=xmjZr7nBExOm6+5J6CaHMHy6GKPbrkGxB2IzEUlk5hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fu09rmNHMUnOkBuanGYznE8TI54uH8QWFf+0DU9ltua3zvMeLwpaueIUW/yq8z4Hl
	 zzasN/marEAA62nyNRuBgCCMzTHVKTtFPlwPkmt/PAvQq2pOz4pJfCL5MZWaUtHevV
	 Z/sN/T33nwvItmNynOMkvDvVfI83555e0t0BcP1rN+HGKysX/hMcbnyxx/NoyCHWiA
	 TJQqSip/ST+r/aGdvnW2/X5BkQIZVi2P11rKo7z6w3Igjyv0sS8OEWpk1puEClJOPt
	 iK5BSfyMHSDwQTqoGoPOSo3r4ORfhwmvNY9RdnTwFHMmJvJe5mFZCnDUVilwxMrK3N
	 0hTg5anS87Bog==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: iwlwifi: pcie: don't dump on reset handshake in dump
Date: Mon, 20 Apr 2026 09:08:55 -0400
Message-ID: <20260420131539.986432-69-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35051-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6832642C054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 4a481720106d6bad1521d0e0322fd74fa2f6c464 ]

When a FW dump happens, possibly even because of a reset handshake
timeout, there's no point in attempting to dump again. Since all the
callers of the function outside the transport itself are from the FW
dump infrastructure, just split the internal function and make the
external one not dump on timeout.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260320100746.f36ba3893899.I063ccc3a037ae6dabcde61941acb162c4b33f127@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture of the call chain. Let me compile the full
analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: `wifi: iwlwifi: pcie:` (Intel WiFi PCIe transport
  layer)
- **Action verb**: "don't dump" - this is preventing incorrect behavior
  (a bug fix)
- **Summary**: Prevent triggering a firmware dump when a reset handshake
  timeout occurs during an already-in-progress firmware dump

Record: [wifi: iwlwifi: pcie] [prevent/avoid] [Don't recursively trigger
FW dump on reset handshake timeout during dump collection]

### Step 1.2: Tags
- **Signed-off-by**: Johannes Berg (author, iwlwifi maintainer)
- **Reviewed-by**: Emmanuel Grumbach (key iwlwifi developer)
- **Signed-off-by**: Miri Korenblit (iwlwifi submitter)
- **Link**: patch.msgid.link URL (lore-blocked by Anubis)
- No Fixes: tag (expected), no Reported-by, no Cc: stable

Record: Written by the iwlwifi maintainer, reviewed by another senior
iwlwifi developer. No explicit stable nomination.

### Step 1.3: Commit Body Analysis
The message explains: When a FW dump happens (possibly due to a reset
handshake timeout), there's no point in attempting to dump again.
External callers of `iwl_trans_pcie_fw_reset_handshake()` are all from
the FW dump infrastructure, so the fix splits the internal function and
makes the external one not trigger a dump on timeout.

Record: Bug = recursive dump attempt when reset handshake times out
during dump. Symptom = attempting to dump from within dump context
(potential hang/deadlock). Root cause = all external callers are from
dump infrastructure but the function unconditionally triggers a new dump
on timeout.

### Step 1.4: Hidden Bug Fix Detection
This is explicitly described as preventing incorrect behavior. The
"don't dump" phrasing directly describes fixing a problematic code path.
Not hidden.

Record: This is a clear bug fix - preventing recursive dumps that can
cause system instability.

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **Files changed**: 1
  (`drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c`)
- **Lines changed**: ~10 added, ~3 removed (net ~7 lines)
- **Functions modified**: `iwl_trans_pcie_fw_reset_handshake()`
  refactored into `_iwl_trans_pcie_fw_reset_handshake()` + wrapper;
  `_iwl_trans_pcie_gen2_stop_device()` updated to call internal version
- **Scope**: Single-file surgical fix

### Step 2.2: Code Flow Change
- **Before**: `iwl_trans_pcie_fw_reset_handshake()` always calls
  `iwl_op_mode_dump_error()` on timeout with `!reset_done`. All callers
  (both from dump infrastructure and from stop_device) get the same
  behavior.
- **After**: Internal `_iwl_trans_pcie_fw_reset_handshake(trans,
  dump_on_timeout)` takes a parameter. External callers (from dump
  infrastructure via `iwl_trans_pcie_fw_reset_handshake()`) get
  `dump_on_timeout=false`. Internal caller
  (`_iwl_trans_pcie_gen2_stop_device`) passes `dump_on_timeout=true`.

### Step 2.3: Bug Mechanism
The call chain for the bug:
1. FW dump starts via `iwl_fw_dbg_collect_sync()` →
   `iwl_fw_error_ini_dump()` → `iwl_dump_ini_file_gen()` →
   `iwl_dump_ini_trigger()` → calls
   `iwl_trans_pcie_fw_reset_handshake()`
2. If handshake times out, old code calls `iwl_op_mode_nic_error()` and
   `iwl_op_mode_dump_error()`
3. `iwl_op_mode_dump_error()` → `iwl_mvm_dump_error()` →
   `iwl_fw_error_collect()` → triggers another dump
4. This is a **recursive dump attempt from within dump context** - at
   minimum wasteful, potentially causing deadlocks or hangs

Record: [Logic/correctness fix] [Recursive dump trigger: the function
triggers a new dump on timeout even when already called from within the
dump infrastructure]

### Step 2.4: Fix Quality
- Obviously correct: the parameter cleanly separates the two behaviors
- Minimal and surgical: only changes the necessary function and its
  callers
- No regression risk: internal caller preserves original behavior
  (dump_on_timeout=true), external callers gain new safe behavior
  (dump_on_timeout=false)
- No API changes: external function signature is unchanged

Record: High quality fix. Minimal regression risk. Obviously correct.

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
- The function was originally introduced in commit `906d4eb84408a4` (Dec
  2020) as a static function
- It was made public (non-static, exported) in `85ccbdc4d3930f` (Feb
  2025, v6.15)
- The dump-triggering code on timeout was added in `7391b2a4f7dbb7` (Dec
  2024, "rework firmware error handling")
- Additional external callers added in `bb6d4dc9d3f624` (Apr 2025,
  v6.16)

Record: Bug introduced when `85ccbdc4d3930f` (v6.15) made the function
public and called it from the dump infrastructure. The dump-on-timeout
behavior was present from `7391b2a4f7dbb7` but harmless when function
was static (only called from stop_device, not from dump context).

### Step 3.2: Fixes Tag
No Fixes: tag present (expected).

### Step 3.3: File History
Recent commits to this file include several fixes: `43049a3c00c8c` (fix
non-MSIX handshake register), `eda36f5195d6c` (reinit device properly
during TOP reset), `e5d110fec068c` (fix locking on invalid TOP reset).
This area is actively being fixed.

Record: Active area with multiple recent fixes. Standalone fix - no
series dependencies.

### Step 3.4: Author
Johannes Berg is THE iwlwifi maintainer - the primary author and
maintainer of the entire iwlwifi subsystem.

Record: Author is the subsystem maintainer. Maximum authority.

### Step 3.5: Dependencies
The fix requires `85ccbdc4d3930f` (makes function public) and
`7391b2a4f7dbb7` (adds dump-on-timeout logic) to be present. Both are in
v6.15+.

Record: Depends on code from v6.15+. Can apply standalone within that
constraint.

## PHASE 4: MAILING LIST RESEARCH

### Step 4.1-4.5
Lore.kernel.org is protected by Anubis anti-bot measures. The Link: in
the commit message points to the patch discussion. The patch was
submitted as part of a series through the iwlwifi maintainer tree. It
was reviewed by Emmanuel Grumbach (Reviewed-by tag), a senior iwlwifi
developer.

Record: Could not access lore directly. Patch was reviewed and approved
through normal iwlwifi workflow.

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1-5.4: Function Call Tracing

The external function `iwl_trans_pcie_fw_reset_handshake()` is called
from:
1. `fw/dbg.c:2714` - during split dump
   (IWL_FW_INI_APPLY_POLICY_SPLIT_DUMP_RESET)
2. `fw/dbg.c:2722` - during non-split dump with RESET_DURING_ASSERT
   capability

Both callers are deep inside the dump collection path:
`iwl_fw_dbg_collect_sync()` → `iwl_fw_error_ini_dump()` →
`iwl_dump_ini_file_gen()` → `iwl_dump_ini_trigger()` →
`iwl_trans_pcie_fw_reset_handshake()`

If timeout triggers `iwl_op_mode_dump_error()`, it calls back into
`iwl_mvm_dump_error()` → `iwl_fw_error_collect()`, creating a recursive
dump situation.

Record: The buggy path is reachable during any FW error dump on Intel
WiFi hardware. This affects all Intel WiFi users with modern firmware.

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Buggy Code Existence
- `85ccbdc4d3930f` (prerequisite) is in v6.15+ (verified with `git
  merge-base --is-ancestor`)
- NOT in v6.14 or earlier
- File was moved to `gen1_2/` in `c8a00a6e89ff` (v6.19)

Record: Bug exists in v6.15+. Only relevant for stable trees 6.15.y
through 7.0.y (and beyond).

### Step 6.2: Backport Complications
For 7.0.y: Should apply cleanly (file path matches current tree). For
6.15-6.18: file was at `pcie/trans-gen2.c`, would need path adjustment.

Record: Clean apply for 7.0.y. Minor path conflict for older trees.

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Subsystem Criticality
WiFi driver (iwlwifi) - used by vast majority of Intel WiFi laptops and
desktops. **IMPORTANT** criticality level.

### Step 7.2: Activity
Very active subsystem with frequent fixes and updates.

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
All users of Intel WiFi hardware with firmware that supports reset
handshake during dumps (modern Intel WiFi devices).

### Step 8.2: Trigger Conditions
- Firmware crash occurs (not uncommon on Intel WiFi)
- FW dump collection starts
- Reset handshake during dump times out
- System is in a state where `!reset_done` is true

### Step 8.3: Failure Mode Severity
When triggered, the system attempts a recursive dump from within dump
context. This can cause:
- Deadlock if dump-related locks are already held (the `mvm->mutex`
  locking in `iwl_mvm_dump_error` with `IWL_ERR_CONTEXT_FROM_OPMODE`
  asserts the lock is held, and re-entering dump collection with it held
  could deadlock)
- At minimum: wasted resources, confusing error logs, delayed recovery
- **Severity**: HIGH (potential deadlock/hang during error recovery)

### Step 8.4: Risk-Benefit
- **Benefit**: HIGH - prevents recursive dumps that can hang the system
  during WiFi FW error recovery
- **Risk**: VERY LOW - single-file, ~10 line change, obviously correct
  parameter addition, preserves existing behavior for internal caller
- **Ratio**: Strongly favorable

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Summary

**FOR backporting:**
- Fixes a real bug: recursive dump attempt from within dump context
- Potential for deadlocks/hangs during FW error recovery
- Affects widely-used Intel WiFi hardware
- Written by THE iwlwifi maintainer (Johannes Berg)
- Reviewed by senior iwlwifi developer (Emmanuel Grumbach)
- Small, surgical, single-file fix (~10 lines net)
- Obviously correct - parameter addition with clear semantics
- No API changes, no new features

**AGAINST backporting:**
- No Fixes: tag or Cc: stable (expected - that's why it needs review)
- No explicit user reports of the hang/deadlock
- Only affects relatively recent kernels (v6.15+)
- Theoretical trigger (but realistic - FW crashes do happen)

### Step 9.2: Stable Rules Checklist
1. Obviously correct and tested? **YES** - trivial function split,
   reviewed by subsystem experts
2. Fixes a real bug? **YES** - recursive dump can deadlock/hang
3. Important issue? **YES** - potential system hang during WiFi error
   recovery
4. Small and contained? **YES** - single file, ~10 lines
5. No new features or APIs? **YES** - no changes
6. Can apply to stable? **YES** - cleanly for 7.0.y

### Step 9.3: Exception Categories
Not applicable - this is a standard bug fix.

### Step 9.4: Decision
This is a well-crafted fix by the subsystem maintainer that prevents
recursive firmware dumps which could cause deadlocks or hangs on Intel
WiFi hardware during error recovery. The fix is small, obviously
correct, and carries very low regression risk.

## Verification

- [Phase 1] Parsed tags: Signed-off-by Johannes Berg, Reviewed-by
  Emmanuel Grumbach, Link to patch.msgid.link
- [Phase 2] Diff analysis: Single file, ~10 lines net change. Function
  split with `dump_on_timeout` parameter. External callers get `false`,
  internal caller gets `true`.
- [Phase 3] git blame: Function made public in `85ccbdc4d3930f` (v6.15).
  Dump-on-timeout added in `7391b2a4f7dbb7`.
- [Phase 3] `git merge-base --is-ancestor`: Confirmed `85ccbdc4d3930f`
  is in v6.15 but NOT in v6.14 or v6.13
- [Phase 3] Author check: Johannes Berg is the iwlwifi subsystem
  maintainer
- [Phase 4] Lore access blocked by Anubis; b4 dig confirmed related
  commits
- [Phase 5] Traced callers: `iwl_trans_pcie_fw_reset_handshake()` called
  from `fw/dbg.c:2714` and `fw/dbg.c:2722`, both within dump collection
  path
- [Phase 5] Traced dump recursion path: `iwl_op_mode_dump_error()` →
  `iwl_mvm_dump_error()` → `iwl_fw_error_collect()` → triggers new dump
- [Phase 6] Bug exists in v6.15+ (verified). File at `gen1_2/` path
  since v6.19 (verified)
- [Phase 8] Failure mode: Potential deadlock/hang during FW error
  recovery, severity HIGH
- UNVERIFIED: Could not verify mailing list discussion due to lore being
  bot-protected
- UNVERIFIED: No direct evidence of users hitting this recursive dump
  scenario in practice, but the code path is clearly reachable during
  any FW crash

**YES**

 .../wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index b15c5d4865277..a50e845cea421 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -95,7 +95,9 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 			      CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 }
 
-void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
+static void
+_iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans,
+				   bool dump_on_timeout)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int ret;
@@ -133,7 +135,7 @@ void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 			"timeout waiting for FW reset ACK (inta_hw=0x%x, reset_done %d)\n",
 			inta_hw, reset_done);
 
-		if (!reset_done) {
+		if (!reset_done && dump_on_timeout) {
 			struct iwl_fw_error_dump_mode mode = {
 				.type = IWL_ERR_TYPE_RESET_HS_TIMEOUT,
 				.context = IWL_ERR_CONTEXT_FROM_OPMODE,
@@ -147,6 +149,11 @@ void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 	trans_pcie->fw_reset_state = FW_RESET_IDLE;
 }
 
+void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
+{
+	_iwl_trans_pcie_fw_reset_handshake(trans, false);
+}
+
 static void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -163,7 +170,7 @@ static void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 		 * should assume that the firmware is already dead.
 		 */
 		trans->state = IWL_TRANS_NO_FW;
-		iwl_trans_pcie_fw_reset_handshake(trans);
+		_iwl_trans_pcie_fw_reset_handshake(trans, true);
 	}
 
 	trans_pcie->is_down = true;
-- 
2.53.0


