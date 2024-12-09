Return-Path: <linux-wireless+bounces-16064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB19E9A8F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67D02820CE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCA1E9B3E;
	Mon,  9 Dec 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDJVIT2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73891E9B38;
	Mon,  9 Dec 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758241; cv=none; b=nlp+Sc//cNp2otmW/8Fs3wKItkQinzOTdeVV/W9m9UVpvDVTf58e3DEHYshWyghvik3evMCOwTWVPkHw7WZfIMgjAB/Aazul+CjUrbirNThzFcKzsqPtxiaxD7XNC8uxPoDrJ30AX3vX/wKtRl0joKqeFfKmWlfTMvLiWtfDZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758241; c=relaxed/simple;
	bh=ovfxJKKuAKObm63Zu7VlrOl+EmqKnRC/02p0uoNmAPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWsaWrqYHmCqTpTVHyjkF3HMZfIWGt6A2g2FhiPR3/kc2IBqKzWeaqCrHz/S7teA6f1LHEL5u36UUvcsIOOkN2wWAdvQa+CerLzTTg52KUe6qGEsL6wcD8WpLER30Ie3k0NYAcUsWVa6UgljrR8pDIPvEjrkvszdICg0IUifN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDJVIT2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76890C4CED1;
	Mon,  9 Dec 2024 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733758241;
	bh=ovfxJKKuAKObm63Zu7VlrOl+EmqKnRC/02p0uoNmAPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDJVIT2hM6iHd3U5strAI5Jp6MrDoAUV77xeAPOC1VwVQ3Xf9mlmB+JrrLmzYa4aN
	 VQIZwQIG7G9wrIqq2U1y6t9JgqRCj7A8gUXluY2uOn3lE9rVfqwaF4b1Tw9WL6KrrE
	 j9wavSFJzP6kiW3ousPdDcOJtiumt4dSis0gacY6dRdPzx7UwR8+m8U8C3463AX4lq
	 aCfMZbJ3vtTmiVHc32YJmJIi1IrDLI79peYcyJF13C2epBk599NQ06z2cJGfklFA4C
	 6jS2FfNlVEwGJlO8HkNaWMIqeNwLkO3vJRiKLlCL2fOVpA/LAzhSSZRRzxgrRSvzXL
	 qop5S+2cHs8dA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 3/8] wifi: ath12k: send partner device details in QMI MLO capability
Date: Mon,  9 Dec 2024 17:30:29 +0200
Message-Id: <20241209153034.50558-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209153034.50558-1-kvalo@kernel.org>
References: <20241209153034.50558-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, QMI MLO host capability is sent with the details of local links and
hw_link id only for particular device. But in the case of multi device group
abstraction, it has to include the details of hw_link_id, num_local_links of
every partner device that is involved in the group during QMI MLO capability
exchange. Add changes to send partner device details to the firmware in QMI MLO
capability exchange.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 88 ++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index ba3cd2342465..2f10c83ef54a 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2016,17 +2016,19 @@ static const struct qmi_elem_info qmi_wlanfw_wlan_ini_resp_msg_v01_ei[] = {
 	},
 };
 
-static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
-				      struct qmi_wlanfw_host_cap_req_msg_v01 *req)
+static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
+				     struct qmi_wlanfw_host_cap_req_msg_v01 *req)
 {
 	struct wlfw_host_mlo_chip_info_s_v01 *info;
+	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_base *partner_ab;
 	u8 hw_link_id = 0;
-	int i;
+	int i, j, ret;
 
-	if (!ab->ag->mlo_capable) {
+	if (!ag->mlo_capable) {
 		ath12k_dbg(ab, ATH12K_DBG_QMI,
 			   "MLO is disabled hence skip QMI MLO cap");
-		return;
+		return 0;
 	}
 
 	if (!ab->qmi.num_radios || ab->qmi.num_radios == U8_MAX) {
@@ -2035,7 +2037,12 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 		ath12k_dbg(ab, ATH12K_DBG_QMI,
 			   "skip QMI MLO cap due to invalid num_radio %d\n",
 			   ab->qmi.num_radios);
-		return;
+		return 0;
+	}
+
+	if (ab->device_id == ATH12K_INVALID_DEVICE_ID) {
+		ath12k_err(ab, "failed to send MLO cap due to invalid device id\n");
+		return -EINVAL;
 	}
 
 	req->mlo_capable_valid = 1;
@@ -2043,27 +2050,74 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_chip_id_valid = 1;
 	req->mlo_chip_id = ab->device_id;
 	req->mlo_group_id_valid = 1;
-	req->mlo_group_id = 0;
+	req->mlo_group_id = ag->id;
 	req->max_mlo_peer_valid = 1;
 	/* Max peer number generally won't change for the same device
 	 * but needs to be synced with host driver.
 	 */
 	req->max_mlo_peer = ab->hw_params->max_mlo_peer;
 	req->mlo_num_chips_valid = 1;
-	req->mlo_num_chips = 1;
+	req->mlo_num_chips = ag->num_devices;
 
-	info = &req->mlo_chip_info[0];
-	info->chip_id = ab->device_id;
-	info->num_local_links = ab->qmi.num_radios;
+	mutex_lock(&ag->mutex);
 
-	for (i = 0; i < info->num_local_links; i++) {
-		info->hw_link_id[i] = hw_link_id;
-		info->valid_mlo_link_id[i] = 1;
+	for (i = 0; i < ag->num_devices; i++) {
+		info = &req->mlo_chip_info[i];
+		partner_ab = ag->ab[i];
 
-		hw_link_id++;
+		if (partner_ab->device_id == ATH12K_INVALID_DEVICE_ID) {
+			ath12k_err(ab, "failed to send MLO cap due to invalid partner device id\n");
+			ret = -EINVAL;
+			goto device_cleanup;
+		}
+
+		info->chip_id = partner_ab->device_id;
+		info->num_local_links = partner_ab->qmi.num_radios;
+
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "mlo device id %d num_link %d\n",
+			   info->chip_id, info->num_local_links);
+
+		for (j = 0; j < info->num_local_links; j++) {
+			info->hw_link_id[j] = hw_link_id;
+			info->valid_mlo_link_id[j] = 1;
+
+			hw_link_id++;
+		}
 	}
 
+	if (hw_link_id <= 0)
+		ag->mlo_capable = false;
+
 	req->mlo_chip_info_valid = 1;
+
+	mutex_unlock(&ag->mutex);
+
+	return 0;
+
+device_cleanup:
+	for (i = i - 1; i >= 0; i--) {
+		info = &req->mlo_chip_info[i];
+
+		memset(info, 0, sizeof(*info));
+	}
+
+	req->mlo_num_chips = 0;
+	req->mlo_num_chips_valid = 0;
+
+	req->max_mlo_peer = 0;
+	req->max_mlo_peer_valid = 0;
+	req->mlo_group_id = 0;
+	req->mlo_group_id_valid = 0;
+	req->mlo_chip_id = 0;
+	req->mlo_chip_id_valid = 0;
+	req->mlo_capable = 0;
+	req->mlo_capable_valid = 0;
+
+	ag->mlo_capable = false;
+
+	mutex_unlock(&ag->mutex);
+
+	return ret;
 }
 
 /* clang stack usage explodes if this is inlined */
@@ -2113,7 +2167,9 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 		req.nm_modem |= PLATFORM_CAP_PCIE_GLOBAL_RESET;
 	}
 
-	ath12k_host_cap_parse_mlo(ab, &req);
+	ret = ath12k_host_cap_parse_mlo(ab, &req);
+	if (ret < 0)
+		goto out;
 
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
-- 
2.39.5


