Return-Path: <linux-wireless+bounces-35053-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICk3JRcs5mliswEAu9opvQ
	(envelope-from <linux-wireless+bounces-35053-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:37:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 224C542C105
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8493C313D1BD
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E9C3CF676;
	Mon, 20 Apr 2026 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8jm3em9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30439BFEF;
	Mon, 20 Apr 2026 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691078; cv=none; b=pOFgbGnQxFmYwwy3kEPv/GAwg3SbG9LjGVhHXqFRhSyxBI8Vl5ppl09HEuNJsOsvdR3TZl1maclX3UrQDGaI07QaVketM5s814DKZa64Gt2yOrS7e4PqS1m/oK9gnglkr6+ZSV9ynwZ/3h+XiLt4Qr4EOZxSDp97ZLZRFALiKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691078; c=relaxed/simple;
	bh=4Ew+9P1AhCIc/hFMFZX1yd3SOp26GdjQC76CnuAw4eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjZQcNVL7v594Bv5fI1QLTFCBuNc37NzRhfL7eq4KIzk97CcqzirwKDwxxmzeaA6RxCYRENzy7rmGSRDD50i5TsHI6k1uV6CddfGPMHJpOGn26002tveHAZnljIC6E/UAmec8MCWpTnErH5kJ/aVFzhmdG1waExDWp1A5yyusAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8jm3em9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535FFC19425;
	Mon, 20 Apr 2026 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691077;
	bh=4Ew+9P1AhCIc/hFMFZX1yd3SOp26GdjQC76CnuAw4eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8jm3em9L/64DUUid4jCIeW6xsquCUKV36RHVC4ZcsJjAn0vJoSW4XOUu7o6zcpmk
	 KDg5vK+oeAlkedMomeT3jDhiqU80cZ1AohWwHEUQ729kpK5Ay2L5Oyz/989/mxKJET
	 VLqzyMoCmf1//YTNGKEldvBur8UkxDCcwdmCUVWPA1r5YUwORVgdBa2rzUjY2dwb3y
	 f0rMdUyPOjY7D92vjvYkkvc9CVFDyWzCRhavMRV1bdK322c8WY1D9oJBHBHNsR9bTn
	 75jLw6D1BQ9Mh/v7QHyFqxySKrIwHZU3h6IAYNF8JjXhrEald/DhuBEFq+gRVDMx5o
	 KC82pfwV1uAnA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
	Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@codeaurora.org,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: ath12k: Fix the assignment of logical link index
Date: Mon, 20 Apr 2026 09:09:06 -0400
Message-ID: <20260420131539.986432-80-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35053-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,infradead.org:email,msgid.link:url]
X-Rspamd-Queue-Id: 224C542C105
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>

[ Upstream commit aecb569d7fb689e3e5b0005ca7bd0a2ef28915e8 ]

Per-link logical index is assigned from the global counter,
ahsta->num_peer. This logical index is sent to firmware during peer
association. If there is a failure in creating a link station,
ath12k_mac_free_unassign_link_sta() clears the link, but does not decrement
the logical link index. This will result in a higher logical link index for
the next link station created. Also, if there is a leak in logical link
index as we assign the incremented num_peer, then the index can exceed the
maximum valid value of 15.

As an example, let's say we have a 2 GHz + 5 GHz + 6 GHz MLO setup. So the
logical link indices that they have are 0, 1 and 2, respectively. If the
5 GHz link is removed, logical link index 1 becomes available, and num_peer
is not reduced to 2 and still remains at 3. If a new 5 GHz link is added
later, it gets the index 3, instead of reusing link index 1. Also,
num_peer is increased to 4, though only 3 links are present.

To resolve these, create a bitmap, free_logical_link_idx, that tracks the
available logical link indices. When a link station is created, select the
first free logical index and when a link station is removed, mark its
logical link index as available by setting the bit.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20260226041911.2434999-1-roopni.devanathan@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information I need. Let me compile the final
analysis.

---

## Complete Analysis

### PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1:**
- Subsystem: `wifi: ath12k`
- Action verb: "Fix"
- Summary: Fixes the assignment of logical link index for MLO (Multi-
  Link Operation) link stations.

**Step 1.2: Tags:**
- `Tested-on: QCN9274 hw2.0 PCI` — hardware tested
- `Signed-off-by: Manish Dharanenthiran` — original author
- `Signed-off-by: Roopni Devanathan` — submitter
- `Reviewed-by: Rameshkumar Sundaram`, `Baochen Qiang`, `Vasanthakumar
  Thiagarajan` — 3 Qualcomm reviewers
- `Link:` to patch.msgid.link — original submission
- `Signed-off-by: Jeff Johnson` — ath12k maintainer applied it
- No Fixes: tag, no Reported-by, no syzbot, no Cc: stable — expected for
  autoselection candidates.

**Step 1.3:** The commit message describes a clear bug: `num_peer` is a
monotonically incrementing counter used to assign logical link indices.
When links are removed, the counter is never decremented, causing
"leakage" of index values. Over time with link add/remove cycles, the
index exceeds the firmware's maximum valid value of 15.

**Step 1.4:** This is NOT a hidden bug fix — the subject explicitly says
"Fix".

### PHASE 2: DIFF ANALYSIS

**Step 2.1:**
- `core.h`: 1 line changed (`u8 num_peer` -> `u16
  free_logical_link_idx_map`)
- `mac.c`: ~20 lines changed across 3 functions
- Functions modified: `ath12k_mac_free_unassign_link_sta`,
  `ath12k_mac_assign_link_sta`, `ath12k_mac_op_sta_state`
- Scope: well-contained, single-subsystem fix

**Step 2.2:**
- In `ath12k_mac_free_unassign_link_sta`: adds
  `ahsta->free_logical_link_idx_map |= BIT(arsta->link_idx)` — returns
  the freed index to the pool
- In `ath12k_mac_assign_link_sta`: replaces `arsta->link_idx =
  ahsta->num_peer++` with bitmap-based allocation using `__ffs()` + adds
  `-ENOSPC` check
- In `ath12k_mac_op_sta_state`: initializes
  `ahsta->free_logical_link_idx_map = U16_MAX` when a new station is
  created (all bits set = all indices free)

**Step 2.3:** Bug category: Logic/correctness bug — resource index leak.
The old approach only increments, never reuses indices. The new bitmap
approach properly tracks available indices.

**Step 2.4:** Fix quality:
- The fix is correct — bitmap tracks available indices, `__ffs` gets the
  lowest free bit, removal sets the bit back
- It adds a proper `-ENOSPC` check for when all indices are exhausted
- Minimal regression risk — the logic is straightforward and only
  touches the specific allocation/deallocation paths
- The U16_MAX initialization means 16 indices (0-15), which matches the
  firmware's maximum

### PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1:** `git blame` confirms both the buggy code (`num_peer++` at
line 7124) and the incomplete cleanup function were introduced by the
same commit: `8e6f8bc286031` ("Add MLO station state change handling")
by Sriram R, dated 2024-11-21, first in v6.14-rc1.

**Step 3.2:** No Fixes: tag present. The bug was introduced by
8e6f8bc286031.

**Step 3.3:** No intermediate fixes for the same issue. No prerequisites
found — the patch modifies code that exists in the tree as-is.

**Step 3.4:** The author (Manish Dharanenthiran) is a regular ath12k
contributor with 9+ commits in the subsystem. Jeff Johnson (ath12k
maintainer) applied it.

**Step 3.5:** This is a standalone single-patch fix. No dependencies on
other commits.

### PHASE 4: MAILING LIST RESEARCH

Lore was not accessible due to anti-bot protection. b4 dig could not
find the exact commit (it hasn't landed in the main tree yet from the
perspective of this 7.0 tree). The patch was sent to
`ath12k@lists.infradead.org` and `linux-wireless@vger.kernel.org`. It
was reviewed by 3 Qualcomm engineers and applied by the ath12k
maintainer Jeff Johnson.

### PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1:** Modified functions: `ath12k_mac_free_unassign_link_sta`,
`ath12k_mac_assign_link_sta`, `ath12k_mac_op_sta_state`

**Step 5.2:** `arsta->link_idx` is used in `ath12k_peer_assoc_h_mlo()`
(line 3531) to populate `ml->logical_link_idx` which is sent to firmware
via `wmi.c` line 2348 as `ml_params->logical_link_idx`. This is a WMI
command parameter — an invalid value directly impacts firmware behavior.

**Step 5.4:** The path: `ath12k_mac_op_sta_state` ->
`ath12k_mac_assign_link_sta` -> sets `link_idx` -> later used in
`ath12k_peer_assoc_h_mlo` -> sent via WMI to firmware. This is a
standard MLO station association path triggered during Wi-Fi connection
setup.

### PHASE 6: STABLE TREE ANALYSIS

**Step 6.1:** The buggy code (`num_peer` field) was introduced in commit
`8e6f8bc286031`, first in v6.14-rc1. It is:
- **NOT in v6.13, v6.12, or any earlier LTS tree**
- Present in v6.14, v6.15, v6.16, v6.17, v6.18, v6.19, v7.0

For the 7.0.y stable tree specifically, the buggy code IS present.

**Step 6.2:** The code in v7.0 matches exactly what the patch expects
(verified by reading lines 7096-7137 and 6771-6798 of mac.c). The patch
should apply cleanly.

### PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1:** Subsystem: wireless driver (ath12k) — IMPORTANT for WiFi 7
users with Qualcomm QCN9274 and similar chipsets. MLO is a key WiFi 7
feature.

**Step 7.2:** ath12k is very actively developed (183 commits to mac.c
between v6.14 and v7.0).

### PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1:** Affected users: Users of Qualcomm ath12k WiFi 7 hardware
with MLO enabled (QCN9274, etc.).

**Step 8.2:** Trigger: Happens when MLO links are removed and re-added —
occurs during roaming, channel switching, or temporary link degradation.
In a typical MLO setup with frequent link changes, this can be triggered
relatively easily.

**Step 8.3:** Failure mode: Sending an invalid logical link index (>15)
to firmware can cause firmware malfunction, potential firmware crash, or
incorrect MLO behavior. Severity: **HIGH** — firmware receives invalid
commands.

**Step 8.4:**
- Benefit: Prevents firmware from receiving invalid index values during
  MLO operations, which could cause connection instability or firmware
  crashes
- Risk: LOW — the change is ~20 lines, well-contained, uses standard
  bitmap operations, reviewed by 3 engineers plus maintainer
- Ratio: Favorable

### PHASE 9: FINAL SYNTHESIS

**Evidence FOR backporting:**
- Fixes a real, clearly described bug (index leak leading to invalid
  firmware commands)
- Small, well-contained fix (~20 lines across 2 files)
- Obviously correct bitmap-based approach
- 3 Reviewed-by tags from Qualcomm engineers + maintainer sign-off
- Tested on hardware (QCN9274 hw2.0)
- The buggy code exists in v7.0 (target tree)
- Should apply cleanly

**Evidence AGAINST backporting:**
- No Fixes: tag, no syzbot/crash report, no user-reported symptom
- Replaces a data structure member (counter -> bitmap), slightly more
  than a trivial patch
- MLO is relatively new; impact limited to WiFi 7 MLO users
- No explicit Cc: stable nomination
- The bug requires specific MLO link add/remove cycles to manifest

**Stable rules checklist:**
1. Obviously correct and tested? **Yes** — bitmap approach is
   straightforward, hardware tested
2. Fixes a real bug? **Yes** — index leak causing invalid firmware
   commands
3. Important issue? **Medium-High** — can cause firmware malfunction in
   MLO
4. Small and contained? **Yes** — ~20 lines in 2 files, single subsystem
5. No new features? **Correct** — pure bug fix
6. Can apply to stable? **Yes** — code matches cleanly

**Verification:**
- [Phase 1] Parsed tags: 3 Reviewed-by, tested-on, Link, maintainer SOB
- [Phase 2] Diff analysis: replaces `num_peer` counter with
  `free_logical_link_idx_map` bitmap across 3 functions
- [Phase 3] git blame: buggy code introduced in 8e6f8bc286031
  (v6.14-rc1), confirmed by `git merge-base --is-ancestor` checks
- [Phase 3] `git merge-base --is-ancestor 8e6f8bc286031 v6.13` → Not in
  v6.13; `v6.14` → Yes
- [Phase 3] Author has 9+ ath12k commits, is a regular contributor
- [Phase 4] b4 dig could not find the commit (not merged in this tree);
  lore blocked by anti-bot
- [Phase 5] Traced `link_idx` usage: set in `ath12k_mac_assign_link_sta`
  → used in `ath12k_peer_assoc_h_mlo` (line 3531) → sent to firmware via
  WMI (wmi.c line 2348)
- [Phase 6] Buggy code confirmed present in v7.0 tree; code at lines
  7096-7137 matches patch context exactly
- [Phase 6] NOT in v6.13 or earlier LTS trees (v6.12.y, v6.6.y, etc.)
- [Phase 8] Invalid logical_link_idx sent to firmware can cause firmware
  malfunction
- UNVERIFIED: Could not access lore discussion to check for reviewer
  stable nominations or concerns

This is a real bug fix for a resource index leak in WiFi 7 MLO handling
that can lead to invalid firmware commands. The fix is small, self-
contained, well-reviewed, and hardware-tested. The buggy code exists in
the target 7.0.y tree.

**YES**

 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 990934ec92fca..5498ff285102b 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -522,7 +522,7 @@ struct ath12k_sta {
 	u16 links_map;
 	u8 assoc_link_id;
 	u16 ml_peer_id;
-	u8 num_peer;
+	u16 free_logical_link_idx_map;
 
 	enum ieee80211_sta_state state;
 };
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b253d1e3f4052..769d240e3ae24 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6784,6 +6784,8 @@ static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
 		return;
 
 	ahsta->links_map &= ~BIT(link_id);
+	ahsta->free_logical_link_idx_map |= BIT(arsta->link_idx);
+
 	rcu_assign_pointer(ahsta->link[link_id], NULL);
 	synchronize_rcu();
 
@@ -7102,6 +7104,7 @@ static int ath12k_mac_assign_link_sta(struct ath12k_hw *ah,
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
 	struct ieee80211_link_sta *link_sta;
 	struct ath12k_link_vif *arvif;
+	int link_idx;
 
 	lockdep_assert_wiphy(ah->hw->wiphy);
 
@@ -7120,8 +7123,16 @@ static int ath12k_mac_assign_link_sta(struct ath12k_hw *ah,
 
 	ether_addr_copy(arsta->addr, link_sta->addr);
 
-	/* logical index of the link sta in order of creation */
-	arsta->link_idx = ahsta->num_peer++;
+	if (!ahsta->free_logical_link_idx_map)
+		return -ENOSPC;
+
+	/*
+	 * Allocate a logical link index by selecting the first available bit
+	 * from the free logical index map
+	 */
+	link_idx = __ffs(ahsta->free_logical_link_idx_map);
+	ahsta->free_logical_link_idx_map &= ~BIT(link_idx);
+	arsta->link_idx = link_idx;
 
 	arsta->link_id = link_id;
 	ahsta->links_map |= BIT(arsta->link_id);
@@ -7630,6 +7641,7 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE) {
 		memset(ahsta, 0, sizeof(*ahsta));
+		ahsta->free_logical_link_idx_map = U16_MAX;
 
 		arsta = &ahsta->deflink;
 
-- 
2.53.0


