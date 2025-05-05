Return-Path: <linux-wireless+bounces-22519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 109C1AAA68C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67F21886BE7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91A328A77;
	Mon,  5 May 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWdcQAIW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4D328A6E;
	Mon,  5 May 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484488; cv=none; b=b1ro862LEbsiBhjdSSqXb4Fgj6b5qZ4lF4nftV7GzX3i1Jybg7wcYCxfLO/NM1Ic3CRUhjPUl6iZh6dpbRYJloWzLOoeXT4pAL5hNnhvs+1mG09z4yrjXCp4t7RhleKRUr5gu0NQ7QaoToTyguR1APEdp8i8h33EGtEIoNNQ+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484488; c=relaxed/simple;
	bh=EwfqFg3EwFZx330B41x1ZTYk/bj84beCfNQcZgeJaiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlxgPEHSC+p/pNznXxxy4Ax4u84WbG+TrDCdKyPrK8L9lm8VWFxngYSHCApc9+IQDFENdmsduS2X+/zcG69nTWcpXkW2voksGYwrB+1iYxX1jwjbTC7aTjvGGTOk/tDUg7o+xgG8ZVvjqSIuNRu2Aj3EDghUYQYl72mdGNqkNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWdcQAIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841AEC4CEEF;
	Mon,  5 May 2025 22:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484488;
	bh=EwfqFg3EwFZx330B41x1ZTYk/bj84beCfNQcZgeJaiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWdcQAIWC+bqgguFsbQ0fQe1EHp/04omDrWrNqC8SrTdhC0DcmrE3TXLu7bgAFz/i
	 et8+uj/IuNvrIClO1adJZYbhnxjZasQ/BM43Ek+17X5PYLg27B7RevugvHM9vMMPXx
	 Xje/84LTDIIbbyFbN+zTgJbVrNjzg1GarTiQU37fnRgvJxL07+Hz790ksPnCwsXGtV
	 HnRj1X2L7R48ZOZdSvnXX1NuDLxcQNXIvChPDtxFpmHrDIWUbepOjfqE14797jXHb7
	 AdRpvQAzOWoPMng+ZwByszMezZnuDuSK3ckJGD1O1qVVK1aVlb9R7oXTEXYFLCA+Ez
	 4VXBU8NS2QVLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: P Praneesh <quic_ppranees@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 496/642] wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV
Date: Mon,  5 May 2025 18:11:52 -0400
Message-Id: <20250505221419.2672473-496-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit dff4f278ee1ef12d822b7ed2a1048d27037209bb ]

Currently, ampdu id is update with peer id mask which is incorrect.
Therefore, update the ampdu id with PPDU id mask value. Also move
the ampdu_id field inside the user stats since it is a user id based
statistics.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Link: https://patch.msgid.link/20250206013854.174765-7-quic_periyasa@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 16 ++++++++++------
 drivers/net/wireless/ath/ath12k/hal_rx.h |  3 ++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index b952e79179d01..f23fee7055abc 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "dp_mon.h"
@@ -655,6 +655,11 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		if (userid < HAL_MAX_UL_MU_USERS) {
 			struct hal_rx_user_status *rxuser_stats =
 				&ppdu_info->userstats[userid];
+
+			if (ppdu_info->num_mpdu_fcs_ok > 1 ||
+			    ppdu_info->num_mpdu_fcs_err > 1)
+				ppdu_info->userstats[userid].ampdu_present = true;
+
 			ppdu_info->num_users += 1;
 
 			ath12k_dp_mon_rx_handle_ofdma_info(eu_stats, rxuser_stats);
@@ -755,8 +760,8 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		if (userid < HAL_MAX_UL_MU_USERS) {
 			info[0] = __le32_to_cpu(mpdu_start->info0);
 			ppdu_info->userid = userid;
-			ppdu_info->ampdu_id[userid] =
-				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO1_PEERID);
+			ppdu_info->userstats[userid].ampdu_id =
+				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO0_PPDU_ID);
 		}
 
 		break;
@@ -956,15 +961,14 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 {
 	struct ieee80211_supported_band *sband;
 	u8 *ptr = NULL;
-	u16 ampdu_id = ppduinfo->ampdu_id[ppduinfo->userid];
 
 	rxs->flag |= RX_FLAG_MACTIME_START;
 	rxs->signal = ppduinfo->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
 	rxs->nss = ppduinfo->nss + 1;
 
-	if (ampdu_id) {
+	if (ppduinfo->userstats[ppduinfo->userid].ampdu_present) {
 		rxs->flag |= RX_FLAG_AMPDU_DETAILS;
-		rxs->ampdu_reference = ampdu_id;
+		rxs->ampdu_reference = ppduinfo->userstats[ppduinfo->userid].ampdu_id;
 	}
 
 	if (ppduinfo->he_mu_flags) {
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 54f3eaeca8bb9..55b2dd5b76f6b 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -146,6 +146,8 @@ struct hal_rx_user_status {
 	u32 mpdu_fcs_ok_bitmap[HAL_RX_NUM_WORDS_PER_PPDU_BITMAP];
 	u32 mpdu_ok_byte_count;
 	u32 mpdu_err_byte_count;
+	bool ampdu_present;
+	u16 ampdu_id;
 };
 
 #define HAL_MAX_UL_MU_USERS	37
@@ -230,7 +232,6 @@ struct hal_rx_mon_ppdu_info {
 	u8 addr4[ETH_ALEN];
 	struct hal_rx_user_status userstats[HAL_MAX_UL_MU_USERS];
 	u8 userid;
-	u16 ampdu_id[HAL_MAX_UL_MU_USERS];
 	bool first_msdu_in_mpdu;
 	bool is_ampdu;
 	u8 medium_prot_type;
-- 
2.39.5


