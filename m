Return-Path: <linux-wireless+bounces-35082-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCJzHq1S5mmcuwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35082-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:22:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DB342F612
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FBBF318DB41
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5D3AD539;
	Mon, 20 Apr 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es6XmYlT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8F3A4501;
	Mon, 20 Apr 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691994; cv=none; b=DdaKArAECjiB5y39NK1cYxo1jHcfANcRk36/QFerNhsv3Bvc32Eo0YoMek1odtCFCVtuCAQ0DlYBFQJrCtshL+463GX/icRP2KPgIzzUwgMWVZXlkNfsycQyMElhLL74JCYBE4D7kD89wkgAcY7jiKQMgOQeopX4QFM9fbs2JrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691994; c=relaxed/simple;
	bh=LUDV08gzADyENRa5emx25syYugOXi3ly76AbdcLA3bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iG9GZLfxeznStsNZOOvOpR9fvp8lTVBr6eYfbryfyWpSHp3WFYsFprKL0UdXI2SxJhvWWHb1bEBPrcpFh7OFFh/t8OXfmd7mAkAlRkqE9H18CmJJYLTpi1GfRYjw6XHtMoo61nWgu6bNpruyhdf+OlXmrpvKnrGvxwGG1M50jAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es6XmYlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9297C2BCB4;
	Mon, 20 Apr 2026 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691994;
	bh=LUDV08gzADyENRa5emx25syYugOXi3ly76AbdcLA3bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Es6XmYlTqs3BBTnvqjJUpgRI7DueoTS6FtWmRKniI2T+SrrMcpmympzye5S/ilYRr
	 Hf9eEuBnRh/Hz77sWl+p7Xl+SfOg6Eo0YGggbGt1iIns5fxkeCXM+c72eYo+ZaaICy
	 QJ2xsE3GFn9eUvhpX5Hl6U/lmoHu9/2qyaPVcjvN0Gyfyn+IZWixKK4NC885ut/pE+
	 qtLQmoBFrvSRJaX7w43gn/FzxsHQLA8oOTsCLhtEl/vf+jCHCzmlCzVdUkbc8cuDYf
	 DzriRbUGQ4+BQOuUlyY/OQGlwsNGAwq/Vxq4WCNMq0HLjZhnyCme2EaEY1dWRS7wt/
	 78YA1QtVDN4ng==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Avula Sri Charan <quic_asrichar@quicinc.com>,
	Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: ath12k: Skip adding inactive partner vdev info
Date: Mon, 20 Apr 2026 09:21:45 -0400
Message-ID: <20260420132314.1023554-311-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35082-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,qualcomm.com:email]
X-Rspamd-Queue-Id: B0DB342F612
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avula Sri Charan <quic_asrichar@quicinc.com>

[ Upstream commit 7d7dc26f72abb7a76abb4a68ebad75d5ab7b375e ]

Currently, a vdev that is created is considered active for partner link
population. In case of an MLD station, non-associated link vdevs can be
created but not started. Yet, they are added as partner links. This leads
to the creation of stale FW partner entries which accumulate and cause
assertions.

To resolve this issue, check if the vdev is started and operating on a
chosen frequency, i.e., arvif->is_started, instead of checking if the vdev
is created, i.e., arvif->is_created. This determines if the vdev is active
or not and skips adding it as a partner link if it's inactive.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1

Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Link: https://patch.msgid.link/20260330040732.1847263-1-roopni.devanathan@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have sufficient information. Let me compile the full analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1:** Subsystem: `wifi: ath12k:`. Action verb: "Skip" (which
implies avoiding incorrect behavior). Summary: Skip adding inactive
partner vdev info to prevent firmware assertions.

**Step 1.2:** Tags:
- Tested-on: QCN9274 hw2.0 PCI (hardware-tested)
- Signed-off-by: Avula Sri Charan (author), Roopni Devanathan
  (submitter), Jeff Johnson (ath12k maintainer)
- Reviewed-by: Rameshkumar Sundaram, Baochen Qiang (both active ath12k
  contributors)
- Link: patch.msgid.link URL for the submission
- No Fixes: tag (expected for review candidates)
- No Cc: stable (expected for review candidates)

**Step 1.3:** Bug: When MLD station mode has non-associated link vdevs
that are created but not started, they are incorrectly added as partner
links. This leads to stale FW partner entries that accumulate and
**cause firmware assertions** (FW crash). Root cause: the check used
`is_created` but should use `is_started` to ensure only active vdevs are
added.

**Step 1.4:** This is clearly a bug fix despite not using the word "fix"
prominently. "Skip adding" = avoiding incorrect behavior that causes
firmware crashes.

## PHASE 2: DIFF ANALYSIS

**Step 2.1:** Single file changed:
`drivers/net/wireless/ath/ath12k/mac.c`. Change is 1 line: `is_created`
-> `is_started`. Minimal scope.

**Step 2.2:** In `ath12k_mac_mlo_get_vdev_args()`, when iterating
partner link vdevs:
- BEFORE: Check `arvif_p->is_created` (vdev allocated in firmware)
- AFTER: Check `arvif_p->is_started` (vdev started and operating on
  frequency)
- This is a more restrictive check that filters out vdevs that exist but
  are not active.

**Step 2.3:** Bug category: Logic/correctness fix. A created-but-not-
started vdev should not be treated as an active partner, because it has
no channel context yet. Adding it causes stale FW partner entries ->
firmware assertion.

**Step 2.4:** Fix quality: Obviously correct. `is_started` is a subset
of `is_created` (a vdev must be created before it can be started), so
this is strictly more restrictive. The fix cannot introduce regressions
because any vdev that is started is also created. The fix is reviewed by
two ath12k developers and tested on real hardware.

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1:** Blame shows the buggy line (`is_created` check) was
introduced by commit `315d80be304ac1` ("wifi: ath12k: allocate new links
in change_vif_links()") by Aditya Kumar Singh. This commit appeared at
v6.13-rc6, landing in v6.15.

**Step 3.2:** The original function `ath12k_mac_mlo_get_vdev_args()` was
introduced by `1ea0cdee6fb3a4` ("wifi: ath12k: MLO vdev bringup
changes") at v6.12-rc4, landing in v6.14. The `is_created` check was an
addition on top in v6.15.

**Step 3.3:** The fix is standalone. No other patches are needed as
prerequisites.

**Step 3.4:** Avula Sri Charan has one other commit in ath12k (napi
fix). Roopni Devanathan has multiple ath12k contributions. Reviewers
(Rameshkumar Sundaram, Baochen Qiang) are active ath12k contributors.

**Step 3.5:** No dependent commits needed. The fix only changes one
condition.

## PHASE 4: MAILING LIST RESEARCH

**Step 4.1:** b4 dig could not find the commit (it's not yet merged).
The submission URL is `https://patch.msgid.link/20260330040732.1847263-
1-roopni.devanathan@oss.qualcomm.com`. Lore is behind Anubis protection,
but we can confirm from the commit tags that it was reviewed by two
developers and accepted by the subsystem maintainer Jeff Johnson.

**Step 4.2:** Two reviewers (Rameshkumar Sundaram, Baochen Qiang)
reviewed the patch. Jeff Johnson (ath12k maintainer) signed off.

**Step 4.3-4.5:** Bug report details not available via web due to Anubis
protection. The commit message itself describes the bug mechanism
clearly.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1:** Modified function: `ath12k_mac_mlo_get_vdev_args()`

**Step 5.2:** Called from `ath12k_mac_vdev_start_restart()` (line
11210), which is a key function in the vdev start path. This is called
during channel context assignment (common MLO WiFi operation).

**Step 5.3-5.4:** The function populates partner link info that gets
sent to firmware via `ath12k_wmi_vdev_start()`. Incorrect partner
entries lead to firmware state corruption and assertion failures.

**Step 5.5:** The `is_started` flag is well-established in the codebase
with clear semantics: set when vdev starts operating, cleared when it
stops.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1:** The buggy code (`is_created` check in
`ath12k_mac_mlo_get_vdev_args()`) was introduced in v6.15 (commit
`315d80be304ac1`). It exists in:
- v7.0 (confirmed: `git merge-base --is-ancestor` = IN v7.0)
- v6.15+ (confirmed)
- NOT in v6.14 or earlier (MLO function is different or doesn't have the
  check)

**Step 6.2:** The fix is a single-line change. It will apply cleanly to
the 7.0 stable tree since the surrounding code is identical.

**Step 6.3:** No related fixes already in stable for this specific
issue.

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1:** Subsystem: WiFi/ath12k (wireless driver). Criticality:
IMPORTANT - ath12k supports Qualcomm WiFi 7 hardware (QCN9274, WCN7850)
used in modern systems.

**Step 7.2:** Very active subsystem - 232 commits to this file since the
MLO function was introduced.

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1:** Affected users: ath12k WiFi users in MLD/MLO station mode.
This is a growing user base as WiFi 7 hardware becomes more common.

**Step 8.2:** Trigger: MLD station connects with multiple links, non-
associated link vdevs are created but not started, then a vdev start
occurs. This is a normal MLO operation path, not an edge case.

**Step 8.3:** Failure mode: Firmware assertion (crash). Severity:
**CRITICAL** - the WiFi firmware crashes, requiring recovery.

**Step 8.4:**
- Benefit: HIGH - prevents firmware crashes during normal MLO operation
- Risk: VERY LOW - 1 line change, strictly more restrictive condition,
  cannot regress
- Ratio: Strongly favorable

## PHASE 9: FINAL SYNTHESIS

**Evidence FOR backporting:**
- Fixes firmware assertion (crash) - critical severity
- Single-line change, obviously correct
- `is_started` is a strict subset of `is_created` - no regression
  possible
- Reviewed by 2 developers, tested on real hardware
- Affects normal MLO WiFi operation path
- Clean apply to 7.0 stable

**Evidence AGAINST backporting:**
- Affects only MLO (WiFi 7) users with ath12k hardware (limited
  audience)
- Relatively new code (v6.15+)
- No explicit Fixes: tag or Cc: stable

**Stable rules checklist:**
1. Obviously correct and tested? **YES** - 1-line change, more
   restrictive check, HW-tested
2. Fixes a real bug? **YES** - firmware assertions/crashes
3. Important issue? **YES** - firmware crash
4. Small and contained? **YES** - 1 line in 1 file
5. No new features? **YES** - purely a fix
6. Can apply to stable? **YES** - clean apply

## Verification

- [Phase 1] Parsed tags: Tested-on: QCN9274, Reviewed-by: 2 developers,
  Signed-off-by: Jeff Johnson (maintainer)
- [Phase 2] Diff analysis: 1 line changed in
  `ath12k_mac_mlo_get_vdev_args()`, `is_created` -> `is_started`
- [Phase 3] git blame: buggy `is_created` check introduced in
  315d80be304ac1 (v6.15), added by Aditya Kumar Singh
- [Phase 3] git describe: 315d80be304ac1 = v6.13-rc6-1322, landed in
  v6.15
- [Phase 3] git merge-base: 315d80be304ac1 IS in v7.0, NOT in v6.14
- [Phase 3] git merge-base: 1ea0cdee6fb3a4 (original function) IS in
  v6.14, NOT in v6.13
- [Phase 5] Grep callers: `ath12k_mac_mlo_get_vdev_args()` called from
  `ath12k_mac_vdev_start_restart()` at line 11210
- [Phase 5] Grep `is_started`: set to true in vdev start path (lines
  11637, 12106, 12118), false in unassign path (lines 12168, 12179)
- [Phase 6] Buggy code exists in v6.15+ and v7.0 stable trees only
- [Phase 7] Active subsystem: 232 commits since MLO function
  introduction
- [Phase 8] Failure mode: firmware assertion = CRITICAL
- UNVERIFIED: Could not access lore.kernel.org discussion due to Anubis
  protection

The fix is a minimal, obviously correct, single-line change that
prevents firmware crashes during normal MLO WiFi operation. It meets all
stable kernel criteria.

**YES**

 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 769d240e3ae24..6fca4418ab0bd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11122,7 +11122,7 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
 		if (arvif == arvif_p)
 			continue;
 
-		if (!arvif_p->is_created)
+		if (!arvif_p->is_started)
 			continue;
 
 		link_conf = wiphy_dereference(ahvif->ah->hw->wiphy,
-- 
2.53.0


