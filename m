Return-Path: <linux-wireless+bounces-23641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2100ACD361
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D93179801
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BB4262FF8;
	Wed,  4 Jun 2025 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVCH36BM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D427726;
	Wed,  4 Jun 2025 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998923; cv=none; b=QrDnxYxtJRSuxvsU6/htFmNEd/xAmOsuVwsp0kxv6f+lO7q5wO3aKqXaKUdawB4mmepG3SL6YiwUmbqIMrAkNV27cPuJtIIOxiuzIKvlJNwkRDdwbB1JQzIig5r+XAdqtn0TBom2iuFwj2xZCOv4ozU/b+AhG+OBzdavQIc5dB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998923; c=relaxed/simple;
	bh=zW6ehYUThzTgGHATntbrFZmi/BBo5vdryCvXSmXyzIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cosngqddRUVrCJxkhgTkdMaIBYwtFFicVvorg+ZtLjw5aHtpftE8Thj3SBLbxbcnsC1dmXioQMNyViopU1exYvdcaoDcAQrQe9FubzAOlWuOEWpjTTtlkm2xUB4+/AdZVmV3L7j0U/I0f0UVkstPOjCPdQKGD/RiOOvcgdqLLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVCH36BM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940A6C4CEEF;
	Wed,  4 Jun 2025 01:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998922;
	bh=zW6ehYUThzTgGHATntbrFZmi/BBo5vdryCvXSmXyzIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVCH36BM6n4n62u/VwC074Tujspad7VydFIPua5ZbYSDQLV6MONCuX1ZZGmqrlWcs
	 wIP/HFRfNSI5RS2XblESEXnfIJldkwCLwcmvrEfK/dS6SpNBD7zsKE7Yvk2c83jDAx
	 8Bj1HH3u0aNK0Sw2SejidpDJ93kkHrIGj3F78CwWGk78qp5qYx8X7A7Ly/ekMiyFx9
	 WKCwfGLlB1M3glEjYOmDl9RWC56jYaP8pklvssW9hsoUlrrx1Lkug7t7VDnmwhKvOd
	 2DuIllaFkO1emSwT7TH7KLiVB3DT58nxQbUpgWCr19TCfYw8baiJ1AFntoarzeQr6H
	 OambrhGT+B01w==
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
Subject: [PATCH AUTOSEL 6.12 90/93] wifi: ath12k: fix link valid field initialization in the monitor Rx
Date: Tue,  3 Jun 2025 20:59:16 -0400
Message-Id: <20250604005919.4191884-90-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
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
index 6a88745369447..7bfd323cdf244 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1080,6 +1080,8 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 
+	status->link_valid = 0;
+
 	if ((status->encoding == RX_ENC_HE) && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
 	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
 		he = skb_push(msdu, sizeof(known));
-- 
2.39.5


