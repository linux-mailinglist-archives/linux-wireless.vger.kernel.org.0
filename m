Return-Path: <linux-wireless+bounces-35064-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDz7LhAz5mlqtQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35064-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:07:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4E42CA57
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 037C23084DCD
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE85D3BED47;
	Mon, 20 Apr 2026 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRqgWJpg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE763FA5E0;
	Mon, 20 Apr 2026 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691571; cv=none; b=HAvFmJoAA13/1nPzOwmJBx+XxWPNZh8/dMjQLQis0k6b92reWMx9mMcNxxmzLAlL089gL6aBZHQEzq11dm01EHKyg1wGQbHVn0G8jbDLr0k0L3y+XBwFFWMJeOVOdPzGpf8WOXrWollh2US+C2Pc8JFxYH5XCKQNgWla9vL/bJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691571; c=relaxed/simple;
	bh=WLQgOMFtCDW3oXcYgQSCIpO+YNH9wFtx5GdhAlLdSrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cfafx9d7QFWMBkZTQAQV367gaCid9z/IR3aq1oJfrRcQ0N15A4IuQM32xpbEzo/cNuQPejei5S8RstTcJpcOlpT3A0hxlNJLD7UKL9mSxjNFxiTbEqkQOgX2KzLNxCXyL3dpRiRwumH5K0Jxyypf1KWbv9YL8HIjvZ017MQQW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRqgWJpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAE6C2BCB4;
	Mon, 20 Apr 2026 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691571;
	bh=WLQgOMFtCDW3oXcYgQSCIpO+YNH9wFtx5GdhAlLdSrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRqgWJpgUzrZVoJ4J/DhJAyMewOVlcS5P6F+Ya383N7PnqM2JvA3u9B1ydfjLouY0
	 QsSqR8Wsa6luLGugLLOpgtBOHERV70MU9G2qa1Jx8Zx/jbjRXXIKXiGpQx4F2nVUN/
	 WVOfufLmxdbvEqQt9bHMpoPvDxEnz5igyBt/jhl5lm571y0I97+hes2RKFDrMh9sL3
	 CtkmmArGT9vk9SJrmlgb/2GaKfj02VeHhV8Xbuq2WEVExxSogDdnDTujas5GyXqciL
	 kLRM5z3OkF7BfQxRMqcHd3/xIQPoG3ze/XbBUk8wy7WTiI/a/yM57AG0ItzuBnG1VS
	 7ByWB13BkYigA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: iwlwifi: mld: always assign a fw id to a vif
Date: Mon, 20 Apr 2026 09:18:21 -0400
Message-ID: <20260420132314.1023554-107-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35064-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CE4E42CA57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 4f1da5cf31cf6345f145e914a0158c2e114bbe27 ]

We used to have a fw id assignment in iwl_mld_init_vif since all interface
types that were added to the driver was immediately added to the FW as
well.
Since NAN was introduced, this is no longer the case - the NAN interface
is not added to the fw until a local schedule is configured.

For this vif we don't assign a fw id so it is 0 by default.
But later, when the vif is removed from the driver, we think that it has
a valid fw id (0) and we point fw_id_to_vif[0] to NULL.
fw_id_to_vif[0] might actually point to another vif with a valid fw id
0. In this case, we end up messing fw_id_to_vif.

Fix this by initializing a vif with a special invalid fw id, and by
exiting iwl_mld_rm_vif early for NAN interfaces.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260321192637.f3b5cc59098f.I3d1dbe66bd224cbb786c2b0ab3d1c9f7ec9003e4@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Good. Now I have a complete picture. Let me compile the full analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: iwlwifi: mld:` (Intel wireless driver, MLD sub-
  driver)
- Action verb: "always assign" - implies fixing missing initialization
- Summary: Ensure every vif gets a proper fw_id (even NAN interfaces
  that don't get a real one)

Record: [wifi: iwlwifi: mld] [fix/ensure] [Initialize fw_id for NAN vifs
to prevent fw_id_to_vif table corruption]

**Step 1.2: Tags**
- Reviewed-by: Emmanuel Grumbach (Intel wifi subsystem co-maintainer)
- Signed-off-by: Miri Korenblit (Intel wifi maintainer)
- Link: patch.msgid.link URL
- No Fixes: tag (expected for candidates)
- No Cc: stable (expected for candidates)

Record: Reviewed by a subsystem co-maintainer. No syzbot, no external
reporters.

**Step 1.3: Commit Body Analysis**
The message clearly describes:
- The bug: NAN interfaces don't get a fw_id, so fw_id defaults to 0
- The symptom: On NAN vif removal, `fw_id_to_vif[0]` is set to NULL,
  which may belong to a *different* valid vif with fw_id 0
- The consequence: Corrupts the fw_id_to_vif mapping table
- The fix: Initialize fw_id to `IWL_MLD_INVALID_FW_ID` and skip rm_vif
  for NAN

Record: This is a data corruption bug in the vif-to-firmware-id mapping
table.

**Step 1.4: Hidden Bug Fix?**
This is clearly described as a bug fix. The commit message explains the
exact corruption mechanism.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- 1 file changed: `drivers/net/wireless/intel/iwlwifi/mld/iface.c`
- 2 hunks: one in `iwl_mld_init_vif()` (+1 line), one in
  `iwl_mld_rm_vif()` (+3 lines)
- Net: +4 lines. Extremely small, surgical fix.

**Step 2.2: Code Flow Change**

Hunk 1 (`iwl_mld_init_vif`): Adds `mld_vif->fw_id =
IWL_MLD_INVALID_FW_ID;` (0xff). Before: fw_id is 0 (zeroed struct).
After: fw_id is 0xff (invalid sentinel).

Hunk 2 (`iwl_mld_rm_vif`): Adds early return for NAN interfaces. Before:
NAN vif removal proceeds to NULL out `fw_id_to_vif[0]`. After: NAN
removal returns immediately without touching the table.

**Step 2.3: Bug Mechanism**
This is a **logic/correctness bug** leading to **data corruption** in
the fw_id_to_vif mapping:
1. NAN vif is created - fw_id stays at default 0 (no allocation)
2. NAN vif is removed - `fw_id_to_vif[0]` is set to NULL
3. If another vif legitimately holds fw_id 0, its mapping is destroyed

The existing WARN_ON check (`mld_vif->fw_id >=
ARRAY_SIZE(mld->fw_id_to_vif)`) doesn't catch this because 0 is a valid
index. But with the fix, IWL_MLD_INVALID_FW_ID (0xff) would trigger the
WARN_ON as a safety net.

**Step 2.4: Fix Quality**
- Obviously correct: IWL_MLD_INVALID_FW_ID already exists and is used
  elsewhere in the codebase (scan.c)
- Minimal: only 4 lines added
- No regression risk: NAN interfaces should never touch fw_id_to_vif,
  and the early return prevents any interaction
- Double defense: Both the sentinel value AND the early return prevent
  the corruption

## PHASE 3: GIT HISTORY

**Step 3.1: Blame Results**
- `iwl_mld_init_vif` was introduced by `d1e879ec600f9` (add iwlmld sub-
  driver, 2025-02-16), first in v6.15
- The NAN support that introduced the bug was `9e978d8ebbe96`
  (2025-11-10), first in v7.0
- The `iwl_mld_rm_vif` function has been unchanged since the mld driver
  introduction, with only the void return refactor in `0755db9f2605e`

Record: Bug introduced by commit 9e978d8ebbe96 in v7.0-rc1. Only v7.0+
stable trees are affected.

**Step 3.2: Fixes tag** - No Fixes: tag present (expected).

**Step 3.3: File History**
Post-v7.0 commits touching iface.c are only recent tree-wide changes and
the wifi generation fix. The file is stable.

**Step 3.4: Author**
Miri Korenblit is the primary maintainer of iwlwifi. Emmanuel Grumbach
reviewed the patch.

**Step 3.5: Dependencies**
- `IWL_MLD_INVALID_FW_ID` (0xff) already exists in v7.0 at `mld.h:530`
- NAN support already exists in v7.0
- No other prerequisites needed. This is standalone.

## PHASE 4: MAILING LIST RESEARCH

Lore was inaccessible due to anti-bot protection. b4 dig found the
submission URL: `https://patch.msgid.link/20260324093333.2953495-1-
miriam.rachel.korenblit@intel.com`. This was part of a batch submission
by Miri Korenblit. The patch was reviewed by Emmanuel Grumbach, the
iwlwifi co-maintainer.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1-5.4: Key Functions**
- `iwl_mld_init_vif()`: Called from `iwl_mld_add_vif()` during interface
  creation - standard mac80211 callback path
- `iwl_mld_rm_vif()`: Called during interface removal
- `fw_id_to_vif[]` is accessed from many places: notification handlers,
  low_latency, scan code - corruption of this table has wide-reaching
  effects

**Step 5.5: Similar Patterns**
`IWL_MLD_INVALID_FW_ID` is already used as a sentinel value for
`fw_link_id` in scan.c, so this pattern is established in the codebase.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Buggy Code in Stable**
- NAN support (`9e978d8ebbe96`) first appeared in v7.0-rc1
- Not present in v6.19, v6.16, or v6.15
- Bug exists ONLY in v7.0 stable tree
- Current HEAD is v7.0, and we confirmed the v7.0 code has the bug

**Step 6.2: Backport Complications**
The diff between v7.0 and HEAD for this file is empty (HEAD IS v7.0).
The patch applies cleanly with no conflicts whatsoever.

**Step 6.3: No related fixes already in stable.**

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

**Step 7.1:** wifi: iwlwifi is an IMPORTANT subsystem - Intel WiFi is
among the most widely used WiFi hardware on Linux (laptops, desktops).
Criticality: IMPORTANT.

**Step 7.2:** The iwlwifi mld driver is actively developed with NAN and
EMLSR features being added in the v7.0 cycle.

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: Affected Users**
Users of Intel WiFi hardware using the iwlmld driver with NAN
functionality. As NAN is a new feature in v7.0, this primarily affects
users of newer WiFi 7 hardware.

**Step 8.2: Trigger Conditions**
- Create a NAN interface, then remove it. This will corrupt
  fw_id_to_vif[0].
- If another vif with fw_id 0 exists, it becomes invisible to the
  driver.
- Trigger: normal NAN usage lifecycle (create/destroy NAN interface)

**Step 8.3: Failure Mode**
- The fw_id_to_vif table corruption means the driver loses track of
  active interfaces
- This can cause: wrong vif returned from firmware notifications, NULL
  pointer dereferences when accessing the corrupted entry, incorrect
  driver behavior
- Severity: HIGH (data corruption of internal mapping, potential for
  subsequent crashes)

**Step 8.4: Risk-Benefit**
- BENEFIT: High - prevents corruption of critical internal data
  structure
- RISK: Very low - 4 lines, obviously correct, uses existing sentinel
  value, reviewed by co-maintainer
- Ratio: Strongly favorable

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence Summary**

FOR backporting:
- Fixes real data corruption bug in fw_id_to_vif mapping table
- Extremely small (4 lines), surgical, obviously correct
- Uses existing infrastructure (IWL_MLD_INVALID_FW_ID)
- Reviewed by subsystem co-maintainer Emmanuel Grumbach
- Applies cleanly to v7.0 (zero diff between HEAD and v7.0)
- No dependencies needed
- Bug is triggered by normal NAN usage lifecycle

AGAINST backporting:
- NAN is a new feature, so the user population is still growing
- No Fixes: tag or explicit stable nomination (but this is expected for
  all candidates)

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? YES - trivial fix, reviewed by co-
   maintainer
2. Fixes a real bug? YES - fw_id_to_vif corruption on NAN vif removal
3. Important issue? YES - data corruption of internal driver state
4. Small and contained? YES - 4 lines in 1 file
5. No new features? Correct - pure bug fix
6. Can apply to stable? YES - applies cleanly to v7.0

**Step 9.3: Exception Categories** - Not applicable; this is a
straightforward bug fix.

## Verification

- [Phase 1] Parsed tags: Reviewed-by Emmanuel Grumbach (Intel co-
  maintainer), Signed-off-by Miri Korenblit (maintainer)
- [Phase 2] Diff: +1 line in iwl_mld_init_vif (sentinel init), +3 lines
  in iwl_mld_rm_vif (NAN early return)
- [Phase 3] git blame: NAN support introduced in 9e978d8ebbe96
  (v7.0-rc1), confirmed via `git tag --contains`
- [Phase 3] git show 9e978d8ebbe96: confirmed it moved fw_id allocation
  out of init_vif without initializing to invalid for NAN
- [Phase 3] Verified `d1e879ec600f9b` (mld driver) first appeared in
  v6.15, NAN support only in v7.0
- [Phase 4] b4 dig found submission URL; lore inaccessible due to bot
  protection
- [Phase 5] IWL_MLD_INVALID_FW_ID (0xff) already exists in v7.0
  mld.h:530 and is used in scan.c
- [Phase 5] fw_id_to_vif[] accessed from iface.c, low_latency.c,
  notification handlers - wide impact surface
- [Phase 6] NAN not in v6.19, v6.16, or v6.15 (confirmed via `git show
  v6.19:...nan.c`). Bug only in v7.0
- [Phase 6] git diff v7.0..HEAD is empty for iface.c - patch applies
  cleanly
- [Phase 6] v7.0 code verified: iwl_mld_init_vif lacks fw_id init,
  iwl_mld_rm_vif lacks NAN check
- [Phase 7] fw_id is u8 inside zeroed_on_hw_restart struct_group,
  confirmed default is 0 (valid index)
- [Phase 8] Corruption path verified: NAN vif removed -> fw_id=0 ->
  fw_id_to_vif[0]=NULL -> corrupts valid mapping

This is a small, surgical, obviously correct fix for a real data
corruption bug in the iwlwifi mld driver's NAN handling. It meets all
stable kernel criteria and applies cleanly to v7.0.

**YES**

 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 9215fc7e2eca7..fb56e59894726 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -434,6 +434,7 @@ iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 	lockdep_assert_wiphy(mld->wiphy);
 
 	mld_vif->mld = mld;
+	mld_vif->fw_id = IWL_MLD_INVALID_FW_ID;
 	mld_vif->roc_activity = ROC_NUM_ACTIVITIES;
 
 	if (!mld->fw_status.in_hw_restart) {
@@ -481,6 +482,10 @@ void iwl_mld_rm_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 
 	lockdep_assert_wiphy(mld->wiphy);
 
+	/* NAN interface type is not known to FW */
+	if (vif->type == NL80211_IFTYPE_NAN)
+		return;
+
 	iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_REMOVE);
 
 	if (WARN_ON(mld_vif->fw_id >= ARRAY_SIZE(mld->fw_id_to_vif)))
-- 
2.53.0


