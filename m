Return-Path: <linux-wireless+bounces-23653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF8EACD43F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB6F189ED8E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C77269898;
	Wed,  4 Jun 2025 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp3NSkTS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660920F079;
	Wed,  4 Jun 2025 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999040; cv=none; b=eWbPdKefE6ddhPkbzuFvYcNB+OxWiikP8+ZskDJGNYmT6/fW98kVuvOjZIU9NlN4nt7bWrpRs+CwtYavabTO8CXxcdO3dX+jV+S1w7iHnq297rmRB1XiOBwBw4r/ggjBd1Crknv0zjK7ZrUb7ww/K3rkOzgpau1uYL5Bk5E3yHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999040; c=relaxed/simple;
	bh=Hk1M88m9ulqr2UOUxPK5AyrP3Jw9ei/XLLUfhKJwLW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKxEkLTi8zNngUDO9Y3Tx+gNIH/jsscOw1Vj6w3Mpx3wla+QssrHNNKBbveSc4y0kcN2syw5Xr5NIgQ+D1Ki6kcWk9/k4ABn1LmR8HGyepwYJ9dqWx2YfeUZDZsn2aulp7DC2ocqF9sjB5SVGYo50+K+u4CjBo1/m6VPdImRyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp3NSkTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B89C4CEF1;
	Wed,  4 Jun 2025 01:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999040;
	bh=Hk1M88m9ulqr2UOUxPK5AyrP3Jw9ei/XLLUfhKJwLW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gp3NSkTSHNjRiADoa52S67UcdDXlUgYHc5nqxgjV5TAOyieqNbT3yTfNaEixK1rjH
	 V+/paxi+eGOdKa8nV00akgtl1K03jnNN+za88TPEQT4Noo/QHwmytEzpoMQyi+6B/u
	 KD7r/DI+Hx4T8n+95dPxIwxLPM80mybtzZjFcA1mskZ7YDV2TBgJOCHgkGSJO3LQc3
	 heSodenseU7Odv+PFtdKpO3y5fZb4VW29RGJCPZWqhJhQ3GPm6I1d6H44OxU0bIkwy
	 OO7COBYNtkyTBEw0qCc8G2xdTzhIK58YzGx4k+5Jp1l/alSHIFicn0WWvTod9jNdaZ
	 q2hBblim3TfGQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hari Chandrakanthan <quic_haric@quicinc.com>,
	Nicolas Escande <nico.escande@gmail.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 60/62] wifi: ath12k: fix link valid field initialization in the monitor Rx
Date: Tue,  3 Jun 2025 21:02:11 -0400
Message-Id: <20250604010213.3462-60-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010213.3462-1-sashal@kernel.org>
References: <20250604010213.3462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hari Chandrakanthan <quic_haric@quicinc.com>

[ Upstream commit 2826139f9295821fe2b049318a1cc057ec003131 ]

Currently, the link_valid field is not initialized in the monitor Rx path.
This can result in random values for the link_valid and link_id leads to
undefined behaviour in mac80211. Therefore, initialize the link_valid
field in the monitor Rx path.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Link: https://patch.msgid.link/20250324062518.2752822-2-quic_periyasa@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the code context, here is my
assessment: **YES** This commit should be backported to stable kernel
trees. Here's my extensive analysis: ## Technical Analysis **Code Change
Impact:** The commit adds a single line `status->link_valid = 0;` at the
beginning of the `ath12k_dp_mon_rx_deliver_msdu()` function in the
monitor Rx path. This initializes the `link_valid` field in the
`ieee80211_rx_status` structure before any subsequent processing. **Root
Cause and Problem:** 1. **Uninitialized Memory Issue**: The
`ieee80211_rx_status` structure contains the `link_valid` field (1 bit)
and `link_id` field (4 bits) that were not being initialized in the
monitor Rx path. 2. **Undefined Behavior**: Without initialization,
these fields contain random stack memory values, which can cause
unpredictable behavior in mac80211 when it processes received frames. 3.
**MLO Context**: The `link_valid` and `link_id` fields are specifically
used for Multi-Link Operation (MLO) in WiFi 7, where mac80211 needs to
know which link a frame was received on. ## Why This Should Be
Backported **1. Bug Fix Nature:** - This is clearly a bug fix that
addresses undefined behavior caused by uninitialized fields - The commit
message explicitly states this fixes "undefined behaviour in mac80211" -
Similar to reference commit #2 (which was backported) that fixed
uninitialized variables **2. User Impact:** - Uninitialized fields can
cause mac80211 to make incorrect decisions about packet processing - May
lead to packet drops, incorrect link handling, or other unpredictable
wireless behavior - Monitor mode is commonly used by network analysis
tools, making this user-facing **3. Risk Assessment:** - **Very Low
Risk**: The change is minimal (single line initialization) - **No Side
Effects**: Setting `link_valid = 0` is the correct default for monitor
mode - **Safe Change**: Only affects the monitor Rx path, doesn't change
core functionality **4. Code Pattern Consistency:** Looking at the
regular Rx path in `dp_rx.c`, I can see the same pattern: ```c if
(pubsta && pubsta->valid_links) { status->link_valid = 1;
status->link_id = peer->link_id; } ``` The monitor path was missing the
corresponding initialization, creating an inconsistency where: - Regular
Rx path: Properly sets `link_valid = 1` when appropriate - Monitor Rx
path: Left `link_valid` uninitialized (now fixed to `link_valid = 0`)
**5. Containment:** - Change is confined to a single function in the
monitor path - No architectural changes or new feature additions -
Follows established kernel practices for field initialization **6.
Stable Tree Criteria Match:** - ✅ Important bug fix (undefined behavior)
- ✅ Minimal risk of regression - ✅ Small, contained change - ✅ No new
features - ✅ Affects user-facing functionality (monitor mode) **7.
Reference Precedent:** This follows the same pattern as the backported
commit #2 which fixed uninitialized variables and commit #3 which fixed
incorrect field usage, both of which were deemed suitable for
backporting. The commit properly addresses a real bug that could affect
users of monitor mode with ath12k WiFi 7 devices, with virtually no risk
of introducing regressions.

 drivers/net/wireless/ath/ath12k/dp_mon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 35f22a4a16cf2..69bf75ebd7518 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1077,6 +1077,8 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 
+	status->link_valid = 0;
+
 	if ((status->encoding == RX_ENC_HE) && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
 	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
 		he = skb_push(msdu, sizeof(known));
-- 
2.39.5


