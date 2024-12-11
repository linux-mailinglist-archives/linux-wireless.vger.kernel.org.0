Return-Path: <linux-wireless+bounces-16258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A59B89ED031
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1124188CF29
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCF1DE2A2;
	Wed, 11 Dec 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggnc1NYM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAD1DA2F6
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931844; cv=none; b=rMOmnswDLKALfsSPrTm2I48PsQQL6wjeMA7/CiV+BmTqYAoCXB1C53cthdTC4Bz7MOxaSsi2zGb98XrNX3Ezbvr7l1bQ0zifrOUnLC/A7aodF3JnBV9jGzV3G4uuV/SMkl3ItFmEB+EiXMU1pCZ0iZ+asdm2OqCnQP7iIWyBjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931844; c=relaxed/simple;
	bh=MMyJbEcUHzrIKi7CjVCmfdUa1sE8p9dCS1p8++sK2r4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az3gAsW32WIQ7CYjSTPbXn5sLi69BbDDpVh5lWvfFCq4itahYJz0uxd6L0r6AJNbN85CmKk0Bczd2SVroTQ7kqPwGAMq2FhdILmpIUTpfzHQ5scrOdTxN5lxvIVVK51BX/yvmiZP0RxtjM1qffcyJaBzOzx7w6ZEbpvM8J/X7jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggnc1NYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A58DC4CED2;
	Wed, 11 Dec 2024 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931844;
	bh=MMyJbEcUHzrIKi7CjVCmfdUa1sE8p9dCS1p8++sK2r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ggnc1NYMuAqQ+Z9tiDUvQWzPpf4ju8Pyx+yEl8holSsbLhxgwXuTmno3ERZ78ugTf
	 Y232nD/LPRI+r+G9imG420E1MWrOyxPKJQFn0ror7tHnwVlRk6pr3g0rhfgBQbCg4O
	 Nv4OZFQc/vy+sdTppsxECvjflkbNhepj/Ubm+Tt8BN+52kyPuqqHqdRAQ8iqjj/E0p
	 zPMPERnM55vKsSKw3jd64xHP2eNlZ1yuM6TUERxtf4PgDgjwyZICUGXmdxX+Vl+ziF
	 77gZs4QQIbfaVkhRTeWrNGDgAdYeiPOBwcjEfmtH7f1ND0kvn/LiINBVDweXz1HLGz
	 0PNWP0fy/7AJQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/7] wifi: ath12k: add no-op without debug print in WMI Rx event
Date: Wed, 11 Dec 2024 17:43:54 +0200
Message-Id: <20241211154358.776279-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211154358.776279-1-kvalo@kernel.org>
References: <20241211154358.776279-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

Currently, certain WMI events are frequently received by the host. Since
the host lacks the logic to process these events, the console is flooded
with ‘Unknown eventid:’ debug messages.

To address this, handle these events gracefully without printing debug
messages. There is already a block of event IDs that are ignored with a debug
print. However, this new type of event occurs more frequently, so no debug
print is necessary, and handling it should be a no-op.

While at it, re-arrange the code so that all Unknown event IDs are towards
the end of the switch block.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 20 +++++++++++++-------
 drivers/net/wireless/ath/ath12k/wmi.h |  5 +++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index e9bda625e9a7..cf5c3efec4b7 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7505,13 +7505,6 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_P2P_NOA_EVENTID:
 		ath12k_wmi_p2p_noa_event(ab, skb);
 		break;
-	/* add Unsupported events here */
-	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
-	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
-	case WMI_PDEV_DMA_RING_CFG_RSP_EVENTID:
-		ath12k_dbg(ab, ATH12K_DBG_WMI,
-			   "ignoring unsupported event 0x%x\n", id);
-		break;
 	case WMI_PDEV_DFS_RADAR_DETECTION_EVENTID:
 		ath12k_wmi_pdev_dfs_radar_detected_event(ab, skb);
 		break;
@@ -7533,6 +7526,19 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_MLO_TEARDOWN_COMPLETE_EVENTID:
 		ath12k_wmi_event_teardown_complete(ab, skb);
 		break;
+	/* add Unsupported events (rare) here */
+	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
+	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
+	case WMI_PDEV_DMA_RING_CFG_RSP_EVENTID:
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "ignoring unsupported event 0x%x\n", id);
+		break;
+	/* add Unsupported events (frequent) here */
+	case WMI_PDEV_GET_HALPHY_CAL_STATUS_EVENTID:
+	case WMI_MGMT_RX_FW_CONSUMED_EVENTID:
+	case WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID:
+		/* debug might flood hence silently ignore (no-op) */
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 270ed458302e..cd3de0a65543 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -711,6 +711,8 @@ enum wmi_tlv_event_id {
 	WMI_PDEV_RAP_INFO_EVENTID,
 	WMI_CHAN_RF_CHARACTERIZATION_INFO_EVENTID,
 	WMI_SERVICE_READY_EXT2_EVENTID,
+	WMI_PDEV_GET_HALPHY_CAL_STATUS_EVENTID =
+					WMI_SERVICE_READY_EXT2_EVENTID + 4,
 	WMI_VDEV_START_RESP_EVENTID = WMI_TLV_CMD(WMI_GRP_VDEV),
 	WMI_VDEV_STOPPED_EVENTID,
 	WMI_VDEV_INSTALL_KEY_COMPLETE_EVENTID,
@@ -752,6 +754,7 @@ enum wmi_tlv_event_id {
 	WMI_TBTTOFFSET_EXT_UPDATE_EVENTID,
 	WMI_OFFCHAN_DATA_TX_COMPLETION_EVENTID,
 	WMI_HOST_FILS_DISCOVERY_EVENTID,
+	WMI_MGMT_RX_FW_CONSUMED_EVENTID = WMI_HOST_FILS_DISCOVERY_EVENTID + 3,
 	WMI_TX_DELBA_COMPLETE_EVENTID = WMI_TLV_CMD(WMI_GRP_BA_NEG),
 	WMI_TX_ADDBA_COMPLETE_EVENTID,
 	WMI_BA_RSP_SSN_EVENTID,
@@ -850,6 +853,8 @@ enum wmi_tlv_event_id {
 	WMI_MDNS_STATS_EVENTID = WMI_TLV_CMD(WMI_GRP_MDNS_OFL),
 	WMI_SAP_OFL_ADD_STA_EVENTID = WMI_TLV_CMD(WMI_GRP_SAP_OFL),
 	WMI_SAP_OFL_DEL_STA_EVENTID,
+	WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID =
+				    WMI_EVT_GRP_START_ID(WMI_GRP_OBSS_OFL),
 	WMI_OCB_SET_CONFIG_RESP_EVENTID = WMI_TLV_CMD(WMI_GRP_OCB),
 	WMI_OCB_GET_TSF_TIMER_RESP_EVENTID,
 	WMI_DCC_GET_STATS_RESP_EVENTID,
-- 
2.39.5


