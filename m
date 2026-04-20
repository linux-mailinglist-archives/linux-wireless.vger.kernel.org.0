Return-Path: <linux-wireless+bounces-35048-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNY2BRAs5mkDswEAu9opvQ
	(envelope-from <linux-wireless+bounces-35048-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:37:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1371E42C0F6
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A43FE3054A8D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE023B7B6E;
	Mon, 20 Apr 2026 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lP00IDrf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535A3B776E;
	Mon, 20 Apr 2026 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691017; cv=none; b=UEk3utK0iuQcjLqU4hQJOplWcl/ACcJL7WYJYs7Sax7O6cgP931LWI4nKmQaQ2pgNPUTXSJUXQVeek1kqBft8bpQrbXzulRdlaRy+XjnRTBMiISQvCrGCzeUhLa5HxWyZImuwRDs1rS/OPrzGn5HNmS4sxdEYN5TxN9NgjluTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691017; c=relaxed/simple;
	bh=sq/AHL5XJEXcLjE6SfDsH3BFsBbp39abJbIoOQPCmXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNlCZ0HW6rdFuPV7Id81OHEhgayFv7jWM7HqI8fIy78urgItnN3P3KLTBDxnKhHrQkC5lsrtJVonqkotcmNA615mfIQKFgApMKH8oqFEuYjyLjb4K9CuNDccmLw25x2slMDqBWx3zb9ejC90cZOxpiJB6pRMi8urnLyL1GLBe3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lP00IDrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BB3C19425;
	Mon, 20 Apr 2026 13:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691017;
	bh=sq/AHL5XJEXcLjE6SfDsH3BFsBbp39abJbIoOQPCmXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lP00IDrfuIreh2zLiz7FuSfr3SHabDLd+/SCS9B9JyOD3ZZrdXBzeWDi02IwkVY8f
	 Xh6zLgqUcKXxSNenMFqx1xBtQIRaDSaAlFHHPDwNGOlQBNSn3+imWqXKD+BMJSyZRt
	 U4MaSJbbYM97c+YC0L+ZHPWHHluCpLN2tJVLTzScVOsEZJZK1C4nOyZyObQbCP82FY
	 KDQX/uHOQo9mbk/dGJlUegK05KqLud+bCMiHKknkLXFq5yl/+lyCg1wT2BaTGR+XmT
	 vmgfGp7Lg9kVAx5lIr3XhNfDr/GIM1sI+mFpUVcGSNoCRLW8ZSuB0n+gk79nhE33mw
	 rInT1nnxdCEPg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.1] wifi: iwlwifi: mvm: zero iwl_geo_tx_power_profiles_cmd before sending
Date: Mon, 20 Apr 2026 09:08:31 -0400
Message-ID: <20260420131539.986432-45-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35048-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 1371E42C0F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 5562b3bbeede8be25092064720e4a942e9fd3e3e ]

Otherwise we may send garbage.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260319204647.2d494b0f4692.I9afd0fa6b2ea5a27118144ac4e3bbbedc2089c10@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a thorough analysis. Let me
compile it.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: wifi: iwlwifi: mvm
- **Action verb**: "zero" (initialization fix)
- **Summary**: Zero-initialize `iwl_geo_tx_power_profiles_cmd` union
  before sending to firmware

### Step 1.2: Tags
- **Signed-off-by**: Emmanuel Grumbach (author, Intel iwlwifi core
  developer)
- **Reviewed-by**: Johannes Berg (iwlwifi/mac80211 subsystem maintainer
  - strong trust signal)
- **Signed-off-by**: Miri Korenblit (Intel wireless maintainer,
  committer)
- **Link**: patch.msgid.link for the original submission
- No Fixes: tag (expected for AUTOSEL candidates)
- No Cc: stable (expected)

### Step 1.3: Commit Body
- "Otherwise we may send garbage." - Clear and direct. The union is
  stack-allocated and not zero-initialized, so whatever stack data
  happens to be there gets sent to the firmware.

### Step 1.4: Hidden Bug Fix?
- YES. The word "zero" and "= {}" pattern is a classic **uninitialized
  data fix**. Sending uninitialized stack data to firmware hardware is a
  real bug: potential information leak and potential firmware
  misbehavior.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **1 file changed**: `drivers/net/wireless/intel/iwlwifi/mvm/fw.c`
- **2 lines changed** (2 additions, 2 removals)
- **Functions modified**: `iwl_mvm_get_sar_geo_profile()`,
  `iwl_mvm_sar_geo_init()`
- **Scope**: Extremely minimal, single-file surgical fix

### Step 2.2: Code Flow
Two identical changes:
- Line 910: `union iwl_geo_tx_power_profiles_cmd geo_tx_cmd;` → `...
  geo_tx_cmd = {};`
- Line 962: `union iwl_geo_tx_power_profiles_cmd cmd;` → `... cmd = {};`

Both change stack-allocated union variables from uninitialized to zero-
initialized.

### Step 2.3: Bug Mechanism
This is an **uninitialized data** bug (category e: initialization
fixes).

The union `iwl_geo_tx_power_profiles_cmd` contains 5 struct variants
(v1-v5) of different sizes. The union is the size of the largest (v5),
which contains `table[8][3]` of `iwl_per_chain_offset` structs plus ops
and table_revision. This is a substantial structure.

In `iwl_mvm_get_sar_geo_profile()`:
- Only `geo_tx_cmd.v1.ops` is explicitly set
- Then `len` bytes (up to `sizeof(geo_tx_cmd.v5)`) are sent to firmware
- All table and table_revision fields are **uninitialized stack
  garbage** being sent to firmware

In `iwl_mvm_sar_geo_init()`:
- `ops`, `table_revision`, and table contents are filled, but any
  padding within the structure or unused bytes remain uninitialized

### Step 2.4: Fix Quality
- **Obviously correct**: `= {}` is the standard C idiom for zero-
  initialization
- **Minimal/surgical**: 2 lines changed, only adding initialization
- **Regression risk**: Zero. Zero-initializing before populating fields
  cannot break anything.
- The newer `mld/regulatory.c` code already uses `= {}` initialization
  (line 76), confirming this is the correct pattern.

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
The uninitialized declarations were introduced in commit
`dd2a1256e6a8d8` ("iwlwifi: acpi: rename geo structs to contain
versioning") from **2020-09-28**, which restructured these commands into
a union. The bug has existed since then.

### Step 3.2: Fixes Tag
No Fixes: tag present (expected for AUTOSEL). The bug was introduced by
`dd2a1256e6a8d8` which is present in v5.10, v5.15, v6.1, v6.6, and all
later stable trees.

### Step 3.3: File History
The file has significant recent activity (196 commits since the buggy
commit). The newer `mld/regulatory.c` equivalent already uses zero-
initialization, confirming the pattern was eventually corrected in newer
code but the `mvm/fw.c` path was missed.

### Step 3.4: Author Context
Emmanuel Grumbach is a core Intel iwlwifi developer with many recent
commits. Johannes Berg (who reviewed this) is the iwlwifi/mac80211
maintainer. This is a fix from the subsystem's core team.

### Step 3.5: Dependencies
This patch is **fully standalone**. It only adds `= {}` to existing
variable declarations. No prerequisite commits needed.

---

## PHASE 4: MAILING LIST RESEARCH

### Step 4.1: Original Submission
b4 dig found the patch at: `https://patch.msgid.link/20260319204647.2d49
4b0f4692.I9afd0fa6b2ea5a27118144ac4e3bbbedc2089c10@changeid`

It was submitted as **[PATCH iwlwifi-next 03/15]** as part of a 15-patch
series. However, this patch is **completely independent** - it's just a
variable initialization change.

### Step 4.2: Reviewers
- Johannes Berg (iwlwifi maintainer) gave **Reviewed-by**
- linux-wireless@vger.kernel.org was CC'd

### Step 4.3-4.5: Bug Report / Related Patches / Stable Discussion
No explicit bug report or stable discussion found. The bug was found by
code inspection by an Intel developer.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1-5.2: Function Callers
- `iwl_mvm_get_sar_geo_profile()`: Called from `debugfs.c` (debugfs
  handler) and `nvm.c` (NVM/regulatory init)
- `iwl_mvm_sar_geo_init()`: Called from main firmware init path at line
  1735 during `iwl_mvm_up()` - this runs on **every iwlwifi device
  initialization**

### Step 5.4: Reachability
`iwl_mvm_sar_geo_init` runs during driver initialization for every Intel
WiFi device using the MVM firmware path. This is a **hot, commonly-
executed path** affecting every Intel WiFi user.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Buggy Code in Stable
The buggy commit `dd2a1256e6a8d8` is confirmed present in:
- v5.10 ✓
- v5.15 ✓
- v6.1 ✓
- v6.6 ✓

The bug affects **all active stable trees**.

### Step 6.2: Backport Complications
The fix is trivial (adding `= {}` to declarations). The only concern is
whether the variable declarations exist identically in stable trees.
Since these are the same variable names in the same functions and the
union type hasn't changed names, this should apply cleanly or with
trivial adjustment.

---

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Subsystem
- **Subsystem**: Wireless networking driver (iwlwifi) - Intel WiFi
- **Criticality**: IMPORTANT - iwlwifi is one of the most widely used
  WiFi drivers, found in most Intel-based laptops

### Step 7.2: Activity
Very actively developed (20+ recent commits shown in file history).

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Who Is Affected
All users with Intel WiFi hardware using iwlwifi MVM firmware (millions
of laptops and desktops).

### Step 8.2: Trigger Conditions
- `iwl_mvm_sar_geo_init`: Triggered on **every driver initialization**
  (boot, resume, WiFi toggle)
- `iwl_mvm_get_sar_geo_profile`: Triggered from debugfs and NVM init

### Step 8.3: Failure Mode Severity
- **Uninitialized kernel stack data sent to firmware**: This is a
  potential kernel info leak to firmware
- **Firmware misbehavior**: If firmware interprets garbage values in the
  table/revision fields, it could misapply TX power settings (regulatory
  compliance issue) or behave unpredictably
- **Severity**: MEDIUM-HIGH (info leak + potential incorrect radio
  behavior)

### Step 8.4: Risk-Benefit
- **Benefit**: HIGH - fixes uninitialized data being sent to firmware on
  every Intel WiFi init
- **Risk**: VERY LOW - 2 lines, `= {}` is the safest possible change
- **Ratio**: Strongly favorable for backport

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Compilation

**FOR backporting:**
- Fixes a real bug: uninitialized kernel stack data sent to WiFi
  firmware
- Extremely minimal fix (2 lines, `= {}` only)
- Obviously correct - zero-initialization is the standard pattern
- Reviewed by iwlwifi maintainer (Johannes Berg)
- Written by core Intel iwlwifi developer
- Bug present in all active stable trees (since v5.10)
- Affects all Intel WiFi users (common hardware)
- Triggered on every driver initialization
- No regression risk whatsoever
- Standalone fix with zero dependencies
- The newer MLD code path already uses this pattern

**AGAINST backporting:**
- No user-visible crash or panic reported (the firmware likely tolerates
  the garbage in many cases)
- No Fixes: tag, no syzbot report

### Step 9.2: Stable Rules Checklist
1. Obviously correct and tested? **YES** - `= {}` is trivially correct,
   reviewed by maintainer
2. Fixes a real bug? **YES** - uninitialized data sent to firmware
   hardware
3. Important issue? **YES** - info leak + potential firmware misbehavior
   on common hardware
4. Small and contained? **YES** - 2 lines in 1 file
5. No new features or APIs? **YES** - no new functionality
6. Can apply to stable? **YES** - trivial change to variable
   declarations

### Step 9.3: Exception Categories
Not an exception category; this is a standard initialization bug fix.

---

## Verification

- [Phase 1] Parsed all tags: Reviewed-by Johannes Berg (iwlwifi
  maintainer), author is Emmanuel Grumbach (Intel iwlwifi developer)
- [Phase 2] Diff analysis: exactly 2 lines changed - both add `= {}` to
  union variable declarations in `iwl_mvm_get_sar_geo_profile()` and
  `iwl_mvm_sar_geo_init()`
- [Phase 3] git blame: buggy code introduced in commit dd2a1256e6a8d8
  (2020-09-28), present since v5.10
- [Phase 3] git merge-base: confirmed dd2a1256e6a8d8 is in v5.10, v5.15,
  v6.1, v6.6
- [Phase 3] No prerequisite commits needed - fix is standalone
- [Phase 4] b4 dig -c: found original submission at lore, patch 3/15 of
  iwlwifi-next series
- [Phase 4] b4 dig -w: reviewed by Johannes Berg, CC'd to linux-wireless
- [Phase 5] Callers traced: `iwl_mvm_sar_geo_init` called from main init
  path (`iwl_mvm_up`); `iwl_mvm_get_sar_geo_profile` called from debugfs
  and NVM init
- [Phase 5] Confirmed newer `mld/regulatory.c` line 76 already uses `=
  {}` pattern for same union type
- [Phase 6] Buggy code exists in all active stable trees (v5.10+)
- [Phase 6] Fix should apply cleanly or with trivial adjustment
- [Phase 8] Impact: all Intel WiFi users; triggered on every driver
  init; severity MEDIUM-HIGH (info leak + potential firmware
  misbehavior)

The fix is a textbook example of an uninitialized data bug fix: minimal,
obviously correct, zero regression risk, affects widely-used hardware,
and has been reviewed by the subsystem maintainer.

**YES**

 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6cc78661116e5..cfe2bb6c1d90a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -907,7 +907,7 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 {
-	union iwl_geo_tx_power_profiles_cmd geo_tx_cmd;
+	union iwl_geo_tx_power_profiles_cmd geo_tx_cmd = {};
 	struct iwl_geo_tx_power_profiles_resp *resp;
 	u16 len;
 	int ret;
@@ -959,7 +959,7 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 {
 	u32 cmd_id = WIDE_ID(PHY_OPS_GROUP, PER_CHAIN_LIMIT_OFFSET_CMD);
-	union iwl_geo_tx_power_profiles_cmd cmd;
+	union iwl_geo_tx_power_profiles_cmd cmd = {};
 	u16 len;
 	u32 n_bands;
 	u32 n_profiles;
-- 
2.53.0


