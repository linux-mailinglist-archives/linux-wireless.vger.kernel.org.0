Return-Path: <linux-wireless+bounces-16261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF319ED028
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F482812C9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3C41DAC80;
	Wed, 11 Dec 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIFDGkSa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CE1DE3A8
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931847; cv=none; b=PTRWdh80OozGr6C+23Uu3CSuGTRbsoio72ddP2ePJ5z4te2/ueK0Lo1SejXcnREqkLYEUJSJTrYvAvvYxT4sE/lI8xZ0IFu6Tre4mpccvvXEtL7dV+zwutkV6Si3p+B5PjvxxsUyADnJgIBn2HJSI8LsKrM3ow6oTwyFJNLzk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931847; c=relaxed/simple;
	bh=Hfyh1P1T8PnNyeOa9NdDUZS6hQpbgTvD+7AaZSzOHqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kS6JHcx+kwZoKVguF33C//7McvPRa41F8yWFN2m8pdlQCx9BAbTu8X/eA/2xK9NrDRFO3ZxYdSIepYJP5zF+kn/b3fg+sYWBGBw2QPGVPA/GpSlUPMc9NLtYUV6EYGfLxWjk0Gc5ahuWM1FA/7KxtI1OZyAeIgeuPz/JcKzJH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIFDGkSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0F0C4CED2;
	Wed, 11 Dec 2024 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931847;
	bh=Hfyh1P1T8PnNyeOa9NdDUZS6hQpbgTvD+7AaZSzOHqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIFDGkSax7ODMOIuFeVzzjYgYR9Rds7BDNJqnCo0jtGlfoJubxt2L/20T3DgU2tJi
	 C0Ev9IJZf3pUa2UPpxTD8VhSxp3u+Lyve2wEmr0L2kDTVmEyI1XjSHg9OSc88eGSx9
	 vlNT3vGAAT7X8PGPTgPUZtJ/ggZJJBkYDD7f2xvfwmBsIF1XKBs0/kRpIbBSeRk9h2
	 1ei7wuipOB22M7xb+7r/6CPN/z09zw4jaStru7zOgeFu0yf6SoHggrOyHguA/AFeCx
	 H/IpjGOMXydft5f2zeE9f1yszTxyCIFIo/Pe3d2ImAeLfUAwqaa2IB8qzcjvTE3w6T
	 GYgrUTZ2yoKuQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 6/7] wifi: ath12k: assign unique hardware link IDs during QMI host cap
Date: Wed, 11 Dec 2024 17:43:57 +0200
Message-Id: <20241211154358.776279-7-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211154358.776279-1-kvalo@kernel.org>
References: <20241211154358.776279-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

Currently, in the QMI host capability, the device index, the number of local
links, and the corresponding hardware link IDs are sent. The hardware link ID
assignment is based on the local variable `hw_link_id`, which starts from 0 and
ranges up to `num_local_links` in the device.  Starting from 0 is not ideal
because it can result in the same link ID being assigned to different devices
in certain scenarios (e.g., split MAC).  Additionally, for multi link
operations the firmware expects the hardware link IDs in the same order as the
Wireless Serial Interface (WSI) connection.

Hence, for MLO to function seamlessly, the hardware link IDs across devices
need to be unique and should follow the order of the WSI connection. To address
this, a previous change read the WSI index from the Device Tree (DT) and stored
it. Use this WSI index to determine the starting hardware link IDs for each
device, ensuring uniqueness and correct order across all devices.

While at it, add debug prints to clearly show the MLO capability advertisement
sent during QMI host capability exchange.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/qmi.c  | 35 +++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 9aed24597548..d07b54f441c3 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -863,11 +863,13 @@ struct ath12k_hw_group {
 	struct device_node *wsi_node[ATH12K_MAX_SOCS];
 	struct ath12k_mlo_memory mlo_mem;
 	struct ath12k_hw_link hw_links[ATH12K_GROUP_MAX_RADIO];
+	bool hw_link_id_init_done;
 };
 
 /* Holds WSI info specific to each device, excluding WSI group info */
 struct ath12k_wsi_info {
 	u32 index;
+	u32 hw_link_id_base;
 };
 
 /* Master structure to hold the hw data which may be used in core module */
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 964d350be748..a8ed86a294c3 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2016,6 +2016,30 @@ static const struct qmi_elem_info qmi_wlanfw_wlan_ini_resp_msg_v01_ei[] = {
 	},
 };
 
+static void ath12k_host_cap_hw_link_id_init(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab, *partner_ab;
+	int i, j, hw_id_base;
+
+	for (i = 0; i < ag->num_devices; i++) {
+		hw_id_base = 0;
+		ab = ag->ab[i];
+
+		for (j = 0; j < ag->num_devices; j++) {
+			partner_ab = ag->ab[j];
+
+			if (partner_ab->wsi_info.index >= ab->wsi_info.index)
+				continue;
+
+			hw_id_base += partner_ab->qmi.num_radios;
+		}
+
+		ab->wsi_info.hw_link_id_base = hw_id_base;
+	}
+
+	ag->hw_link_id_init_done = true;
+}
+
 static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 				     struct qmi_wlanfw_host_cap_req_msg_v01 *req)
 {
@@ -2059,8 +2083,14 @@ static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_num_chips_valid = 1;
 	req->mlo_num_chips = ag->num_devices;
 
+	ath12k_dbg(ab, ATH12K_DBG_QMI, "mlo capability advertisement device_id %d group_id %d num_devices %d",
+		   req->mlo_chip_id, req->mlo_group_id, req->mlo_num_chips);
+
 	mutex_lock(&ag->mutex);
 
+	if (!ag->hw_link_id_init_done)
+		ath12k_host_cap_hw_link_id_init(ag);
+
 	for (i = 0; i < ag->num_devices; i++) {
 		info = &req->mlo_chip_info[i];
 		partner_ab = ag->ab[i];
@@ -2078,9 +2108,12 @@ static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 			   info->chip_id, info->num_local_links);
 
 		for (j = 0; j < info->num_local_links; j++) {
-			info->hw_link_id[j] = hw_link_id;
+			info->hw_link_id[j] = partner_ab->wsi_info.hw_link_id_base + j;
 			info->valid_mlo_link_id[j] = 1;
 
+			ath12k_dbg(ab, ATH12K_DBG_QMI, "mlo hw_link_id %d\n",
+				   info->hw_link_id[j]);
+
 			hw_link_id++;
 		}
 	}
-- 
2.39.5


