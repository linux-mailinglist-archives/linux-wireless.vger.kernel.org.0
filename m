Return-Path: <linux-wireless+bounces-35080-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOf8EcM55mlutgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35080-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:35:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52342D39E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A816305990F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B53248C3E4;
	Mon, 20 Apr 2026 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKVjP89x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5C48BD5D;
	Mon, 20 Apr 2026 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691928; cv=none; b=QJzxfpO3QO0B1oeA/6QdkQpW2i8MwjoU1+JyXJqJ5Oi4lXdgzG0gE061q0MLjShMGRSXJITFpMbWE7UWpLID2PvIRrsi0PYUT48BKvJd1taizoAwgg6VGV1y+liTeN0Vj6uRLEfibsOPpD4mMs85DRql48BjdLCVSaSVT4Aral8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691928; c=relaxed/simple;
	bh=SXDq7jTu5wSPdVSajHBdhavLJFyfzR8Zka0VyZuuoL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmRMMfDd4lHZfCgIX5rUgW6KImOpwlRpiI2mIn7EeAPrNLC9BSzCBHB6zGkP45TjskyOR0C8Zk8mRLmtlrkEP9Y2DesHjJoLuSy0aZmbHz3bVhRHOV2n6qAPNlZ++3EtW8meJxxdOB2vqS5cXMCxDKP9qudjdIEMiyQ9nCM9bJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKVjP89x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526D9C2BCB4;
	Mon, 20 Apr 2026 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691928;
	bh=SXDq7jTu5wSPdVSajHBdhavLJFyfzR8Zka0VyZuuoL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vKVjP89xhinnBP4y8RJ/EmSIZ/aRsw+GPU46QAbDRQyKEdsC9k5FNwTC4zUoQqGlD
	 131VlNtt9a6Vy7CN0EaWIkoB2DUETO6iVuZmLDAdVRu332FnSceZjncOoUKHF5pXl9
	 QpALayZuU05MIHorkj0LPHnNOWNHXljk/c8nGJI8TPx/ERGRMW9JDlaFtE+ippBeF8
	 rWKtFxlJD47nATqa6tN8WTLAht5zZOxfF64+8gmn7ilbwxJeGDm/MYpOD+bAIsREDE
	 rZtC7zDviAetO/VanzSItcV3OM7RJQzHxusRbmHmvFkV36WAIjgEcAdFR1neWtwj0m
	 e+1vFMXqFT+qw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-5.10] wifi: rtw88: TX QOS Null data the same way as Null data
Date: Mon, 20 Apr 2026 09:21:08 -0400
Message-ID: <20260420132314.1023554-274-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35080-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: CE52342D39E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 737e980e12983bb7420a2c00b981a1e607079a84 ]

When filling out the TX descriptor, Null data frames are treated like
management frames, but QOS Null data frames are treated like normal
data frames. Somehow this causes a problem for the firmware.

When connected to a network in the 2.4 GHz band, wpa_supplicant (or
NetworkManager?) triggers a scan every five minutes. During these scans
mac80211 transmits many QOS Null frames in quick succession. Because
these frames are marked with IEEE80211_TX_CTL_REQ_TX_STATUS, rtw88
asks the firmware to report the TX ACK status for each of these frames.
Sometimes the firmware can't process the TX status requests quickly
enough, they add up, it only processes some of them, and then marks
every subsequent TX status report with the wrong number.

The symptom is that after a while the warning "failed to get tx report
from firmware" appears every five minutes.

This problem apparently happens only with the older RTL8723D, RTL8821A,
RTL8812A, and probably RTL8703B chips.

Treat QOS Null data frames the same way as Null data frames. This seems
to avoid the problem.

Tested with RTL8821AU, RTL8723DU, RTL8811CU, and RTL8812BU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/2b53fb0d-b1ed-47b6-8caa-2bb9ae2acb80@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a thorough analysis. Let me
compile the complete assessment.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: rtw88:`
- Action: "TX QOS Null data the same way as Null data" — implies
  correcting inconsistent behavior, which is a bug fix
- Summary: QoS Null data frames should be treated like regular Null data
  frames during TX descriptor setup

**Step 1.2: Tags**
- `Signed-off-by: Bitterblue Smith` — author, active rtw88 contributor
- `Acked-by: Ping-Ke Shih` — rtw88 subsystem maintainer explicitly
  acknowledged
- `Signed-off-by: Ping-Ke Shih` — maintainer merged it
- `Link: https://patch.msgid.link/...` — patch submission link
- No Fixes: tag (expected for this review pipeline)
- No Cc: stable (expected)

**Step 1.3: Body Text**
The commit describes:
- **Bug**: QoS Null frames are treated as normal data frames, while
  plain Null frames go through the management path. This causes firmware
  misbehavior.
- **Trigger**: On 2.4 GHz, wpa_supplicant/NetworkManager triggers scans
  every 5 minutes. During scans, many QoS Null frames with
  `IEEE80211_TX_CTL_REQ_TX_STATUS` are sent. Firmware can't keep up with
  TX status reports.
- **Symptom**: "failed to get tx report from firmware" warning every 5
  minutes.
- **Affected chips**: RTL8723D, RTL8821A, RTL8812A, RTL8703B (older
  chips).
- **Tested with**: RTL8821AU, RTL8723DU, RTL8811CU, RTL8812BU.

**Step 1.4: Hidden Bug Fix?**
This is clearly a bug fix, not disguised. The commit explicitly explains
the incorrect behavior and the symptom.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- Single file: `drivers/net/wireless/realtek/rtw88/tx.c`
- 1 line changed: `ieee80211_is_nullfunc(fc)` →
  `ieee80211_is_any_nullfunc(fc)`
- Function modified: `rtw_tx_pkt_info_update()`
- Scope: absolute minimal — single token change

**Step 2.2: Code Flow Change**
Before: QoS Null frames (subtype `IEEE80211_STYPE_QOS_NULLFUNC`) don't
match `ieee80211_is_nullfunc()` but DO match `ieee80211_is_data()`, so
they go through `rtw_tx_data_pkt_info_update()` which sets MCS rates,
software sequencing, and potential AMPDU.

After: QoS Null frames match `ieee80211_is_any_nullfunc()`, so they go
through `rtw_tx_mgmt_pkt_info_update()` which sets basic rates, hardware
sequencing, and `dis_qselseq = true`.

**Step 2.3: Bug Mechanism**
Category: **Logic/correctness fix**. QoS Null frames are
control/management-like frames that should not be treated as normal data
traffic. Being processed as data frames causes the firmware to choke on
rapid TX status report requests.

**Step 2.4: Fix Quality**
- Obviously correct: `ieee80211_is_any_nullfunc()` is the standard
  helper for this exact pattern (introduced in commit 30b2f0be23fb
  precisely for cases where both Null and QoS Null need matching)
- Minimal: 1 token change
- Regression risk: very low — QoS Null frames will now use basic rates
  and hardware sequencing, same as plain Null frames, which is the
  expected behavior

## PHASE 3: GIT HISTORY

**Step 3.1: Blame**
The buggy line was introduced in `e3037485c68ec1` ("rtw88: new Realtek
802.11ac driver") from v5.2-rc1 (April 2019). The bug has existed since
the driver was first written.

**Step 3.2: Fixes target**
No Fixes: tag, but the root cause is in `e3037485c68ec1` — the initial
driver commit. This means ALL stable trees that contain rtw88 have the
bug.

**Step 3.3: Related commits**
The same author has addressed this "failed to get tx report from
firmware" issue from multiple angles:
- `57289d30cd2ae3` — beacon loss detection (v6.13) — works around the
  symptom
- `28818b4d871bc9` — USB disconnection fix after beacon loss (v6.11) —
  separate but related bug
- `c7706b1173c77` — data rate fallback for older chips — same set of
  affected chips
This commit appears to be the **root cause fix** rather than a
workaround.

**Step 3.4: Author**
Bitterblue Smith is a prolific rtw88 contributor with 20+ commits to the
driver. Not the subsystem maintainer but a trusted regular contributor,
especially for USB variants of Realtek chips.

**Step 3.5: Dependencies**
None. `ieee80211_is_any_nullfunc()` was added in v5.7-rc1 (commit
30b2f0be23fb40). Verified it exists in v5.10, v5.15, v6.1, and v6.6
trees. The patch applies cleanly to all stable trees.

## PHASE 4: MAILING LIST

Lore.kernel.org was not accessible due to bot protection. However:
- The commit has `Acked-by: Ping-Ke Shih` (subsystem maintainer)
- The commit was merged by Ping-Ke Shih
- Testing was done on 4 different devices

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Modified function**
`rtw_tx_pkt_info_update()` — the central TX path function.

**Step 5.2: Callers**
- `rtw_tx()` (line 556) — main TX entry point from mac80211
- `rtw_txq_push_skb()` (line 613) — TX queue push path
Both are hot paths executed for every transmitted frame.

**Step 5.3-5.4: Call chain**
This is directly reachable from mac80211's TX path — every WiFi frame
goes through this function. The QoS Null frames are triggered
automatically by mac80211 during scans.

**Step 5.5: Similar patterns**
The `ieee80211_is_any_nullfunc()` helper was specifically created
because multiple places in mac80211 had the same bug of only checking
for non-QoS nullfunc. Other drivers (iwlwifi, ath, rtw89) already use
`ieee80211_is_any_nullfunc()` correctly.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Buggy code in stable trees?**
YES. Verified the exact buggy line `ieee80211_is_nullfunc(fc)` exists in
v5.10, v5.15, v6.1, and v6.6 trees.

**Step 6.2: Backport complications**
None. The patch applies with zero context conflicts. The surrounding
code is identical across all stable trees.

**Step 6.3: Related fixes in stable**
No. This specific fix has not been applied to any stable tree.

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1: Subsystem**
WiFi driver (rtw88) — IMPORTANT category. RTL8723D, RTL8821A, RTL8812A
are common consumer WiFi chips used in USB dongles and embedded systems.

**Step 7.2: Activity**
Actively developed with regular fixes from multiple contributors.

## PHASE 8: IMPACT AND RISK

**Step 8.1: Affected users**
Users of RTL8723D, RTL8821A, RTL8812A, RTL8703B WiFi chips connected to
2.4 GHz networks. These are popular budget WiFi chips.

**Step 8.2: Trigger**
Automatic — triggered every 5 minutes during background scans by
wpa_supplicant/NetworkManager. No user action required.

**Step 8.3: Severity**
MEDIUM — the "failed to get tx report from firmware" warning floods logs
periodically. While not a crash, it indicates firmware state
desynchronization that can lead to further issues. The related commits
show this same symptom can escalate to disconnections.

**Step 8.4: Risk-Benefit**
- **Benefit**: HIGH — fixes a recurring warning every 5 minutes for
  users of popular hardware, prevents potential firmware state
  corruption
- **Risk**: VERY LOW — single token change using a well-established
  kernel helper, tested on 4 devices, acked by maintainer

## PHASE 9: SYNTHESIS

**Evidence FOR:**
- Fixes a real, user-visible bug (recurring firmware warnings every 5
  minutes)
- Affects popular WiFi hardware (RTL8723D/RTL8821A/RTL8812A/RTL8703B)
- Trivial one-line change — absolute minimal scope
- Uses standard kernel helper (`ieee80211_is_any_nullfunc`) available in
  all stable trees
- Bug exists since the driver was created (v5.2) — all stable trees
  affected
- Acked by subsystem maintainer
- Tested on 4 different hardware variants
- No dependencies, clean apply to all stable trees
- Same class of bug (missing QoS Null check) was fixed in mac80211 core
  via the same helper

**Evidence AGAINST:**
- No Fixes: tag (expected for review pipeline)
- Symptom is a warning, not a crash (but related to firmware state
  desync that can escalate)

**Stable Rules Checklist:**
1. Obviously correct? YES — standard helper for this exact pattern
2. Fixes a real bug? YES — recurring firmware desync warning
3. Important issue? YES (firmware interaction bug, periodic warning,
   potential escalation)
4. Small and contained? YES — 1 line in 1 file
5. No new features? Correct — pure bug fix
6. Can apply to stable? YES — verified helper exists in all stable trees

## Verification

- [Phase 1] Parsed tags: Acked-by Ping-Ke Shih (maintainer), tested with
  4 devices
- [Phase 2] Diff: 1 token change in `rtw_tx_pkt_info_update()`:
  `ieee80211_is_nullfunc` → `ieee80211_is_any_nullfunc`
- [Phase 3] git blame: buggy code from `e3037485c68ec1` (v5.2-rc1, rtw88
  driver creation), present in all stable trees
- [Phase 3] git describe: `v5.2-rc1~133^2~37^2~8` confirmed for original
  commit
- [Phase 3] git show v6.6/v6.1/v5.15: verified identical buggy line
  exists
- [Phase 3] git log author: Bitterblue Smith has 20+ rtw88 commits,
  trusted contributor
- [Phase 3] Related commits: `57289d30cd2ae3` (beacon loss workaround)
  and `28818b4d871bc9` (USB disconnection fix) address same symptom
  family
- [Phase 4] Lore inaccessible due to bot protection; maintainer ack
  verified in commit tags
- [Phase 5] `rtw_tx_pkt_info_update()` called from `rtw_tx()` and
  `rtw_txq_push_skb()` — main TX paths
- [Phase 5] `ieee80211_is_any_nullfunc()` already used by iwlwifi, ath,
  rtw89 for same purpose
- [Phase 6] `ieee80211_is_any_nullfunc()` verified present in v5.10
  (line 735), v5.15 (line 732), v6.1 (line 769)
- [Phase 6] Patch applies cleanly — surrounding code identical across
  stable trees
- [Phase 8] Trigger: automatic every 5 minutes on 2.4 GHz; severity
  MEDIUM (firmware desync)

**YES**

 drivers/net/wireless/realtek/rtw88/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 2ab440cb2d67b..3106edb84fb47 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -421,7 +421,7 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 		pkt_info->mac_id = rtwvif->mac_id;
 	}
 
-	if (ieee80211_is_mgmt(fc) || ieee80211_is_nullfunc(fc))
+	if (ieee80211_is_mgmt(fc) || ieee80211_is_any_nullfunc(fc))
 		rtw_tx_mgmt_pkt_info_update(rtwdev, pkt_info, sta, skb);
 	else if (ieee80211_is_data(fc))
 		rtw_tx_data_pkt_info_update(rtwdev, pkt_info, sta, skb);
-- 
2.53.0


