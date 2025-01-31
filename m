Return-Path: <linux-wireless+bounces-18254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD1FA2436E
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 20:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E20416463A
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A2154C0F;
	Fri, 31 Jan 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WH/5HSY2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA91F2382
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352264; cv=none; b=PV/k+4c55e5y9leusS4TxjLYComtT/lXqz86pD8mt3ySyiTvQcwWhaJWh0ouNNDuiN4K/no76j31Sv7HkFMWTbfZMxFzlM37FeFbVdlVVSxIAbKHFMozOBuek5/azQZDTzS6v8sIH6uiAiolLaHxtJW0hWo9jw2EP8hk2oA4Wbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352264; c=relaxed/simple;
	bh=D+L0AIdygtQru5begpYfsiKoSQnbTaQRVAWXNAC1VXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f0fgzZau4TM8io9VBccXZadw3xGuodhuEjnt4wTkHGVhjIaNpwHka3SKhTBrMtQB2KcWgAercX+NiRAnHChItw97xWnKwFStLaMLbz+l2Dr4NTeSSx6xfZC2imrqZoBSPZZwtgC2I/FrHpk0Ngrq1A1Y+1f7VnsbKgug0CI1v8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WH/5HSY2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VDKclT005807
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o9GNOAkE6eL
	6bowCQbZVe3GXyZFPeLl6kYmRQN9+Q4w=; b=WH/5HSY22Clszo3pCefVSRBJvVe
	8PvMHCH4f86lReEb1t2wcyJ+LyHB8x5YUFDMFp4tIF4s9s0DIiWq+eFSpTle72f0
	Y8kq1zCCFDydKFlFuhU7u4Y2e36AUCujG6CM/fubQhuU7dgfZlACslTW4MtvC2So
	cqFNCRrpbBERowrUrLi+ueJQ9Ao/1pEhssFRnvpGz91853K2vf+y65oi6xCgmum0
	YGmeteKkhvWO49+t0blrW2ofQ8MaoWrZehGZnDBPqfu89VR9F5a4//JXBpFOtzCm
	KtOyRFYChuXe+7cLkjDLM1PNalK0Uw9kfnsbcE3/ou3El79xGSUIgvCqtqQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gyaqrvhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:37:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166855029eso47502785ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 11:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738352260; x=1738957060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9GNOAkE6eL6bowCQbZVe3GXyZFPeLl6kYmRQN9+Q4w=;
        b=h84fIGq0FHdp+aBP9eZVFmYsLDvB77wmTQaMF5CxYhK3cdUT0YBP2ros1yu4HWNXw0
         EfSyzKud29WEgoIwtGpDExwFoXdrm/AqS/3dePE+P0OZBUas+M6tlYOJbO3qSRfyb7FV
         YcAphTJ++fpz2UYLLCpOaZWEXcAjdAVEzRJKqXZCp7PT3a9yAMTDwFcisr6Tc3hZYb1Z
         bs5sVyhupAmUxxuJloBmdG1sPREPOTk29HpyJjpNkViOenCqZdApoYLNnfwT5MK0GjJT
         oeKeBYmpDd9dVmt0y1tAdokTd4DPfXvXJJ498MTucPpMFhyihw2FHUvz9C+oUwE2eOQA
         9igw==
X-Gm-Message-State: AOJu0Yx6rB5pNAZ1CYnTo25R7Hoj+ap/8/fK5pv06TkhAnUviszm5Abs
	MAbmYVr8PkT4LennpowxUgx/QKKO/vIsaZHY8z6ToBHMeMCKe2gWnw9aTNh/si6aSYg0QYt+ITL
	7+wll+9aClSPBCmoQOUFT+DXrBw5SRbZY+y8oOa7CnR2liVzwHNcEvTzHwpp3OwCeFN9LvI0EVg
	==
X-Gm-Gg: ASbGncuK1hgqTA/NjPmJNq+qbDDosNtNc3hk9PkmpvbiipRAg3OR/QGv0ufOR6KBcSq
	JB6IreitWej2mTx3qLBrAnKye9l0IvW0lUP0MSviXF8+1TtddiBrWpEVxTFiNGskimFZLs6ZFds
	TAJHUq43dfNOyXlJw3WvhIF/rs5Lt4zsNyy9BJMAiBlL3WMTSGwpyYWgkoRIWETG0VPceme++XD
	DNMJAggSFRicBz+F+R+DqPfvkPCayZzLlR24SSAY3IM9OoYnoI5Ns12imQkxgfOBKLrnLcNU7/A
	zTO883gJXJYMV1zZAGBn8d+mwwI+l4ArmuQu0JdffcZl7kNBn3alNayAHKtn0a0wSv77RkTS77f
	VSd+2PPkIqU2auzkCvWR/BzH5+IQxKFoQyw==
X-Received: by 2002:a17:903:41c3:b0:215:8809:b3b7 with SMTP id d9443c01a7336-21dd7c4e56amr167565355ad.7.1738352260087;
        Fri, 31 Jan 2025 11:37:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsNhJdYwpVGxr7gZe/JpH+zcfYROCM5zmLxZA9xPuW//dr1Y16PsVWRm56XIAfkJpTQlTwYA==
X-Received: by 2002:a17:903:41c3:b0:215:8809:b3b7 with SMTP id d9443c01a7336-21dd7c4e56amr167565035ad.7.1738352259572;
        Fri, 31 Jan 2025 11:37:39 -0800 (PST)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848acac43sm4019271a91.40.2025.01.31.11.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:37:39 -0800 (PST)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH v2 2/2] wifi: ath12k: add get_txpower mac ops
Date: Sat,  1 Feb 2025 01:07:26 +0530
Message-Id: <20250131193726.3568086-3-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131193726.3568086-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250131193726.3568086-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aJXb5Q3WC4Bb_NSgP1_5tiZMZblSsySw
X-Proofpoint-GUID: aJXb5Q3WC4Bb_NSgP1_5tiZMZblSsySw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310149

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Driver does not support get_txpower mac ops because of which
cfg80211 returns vif->bss_conf.txpower to user space. bss_conf.txpower
gets its value from ieee80211_channel->max_reg_power. However, the final
txpower is dependent on few other parameters apart from max regulatory
supported power. It is the firmware which knows about all these
parameters and considers the minimum for each packet transmission.

All ath12k firmware reports the final TX power in firmware pdev stats
which falls under fw_stats. add get_txpower mac ops to get the TX power
from firmware leveraging fw_stats and return it accordingly.

While at it, there is a possibility that repeated stats request WMI
commands are queued to FW if mac80211/userspace does get tx power back
to back(in Multiple BSS cases). This could potentially consume the WMI
queue completely. Hence limit this by fetching the power only for every
5 seconds and reusing the value until the refresh timeout or when there
is a change in channel.

Also remove init_completion(&ar->fw_stats_complete) in
ath12k_mac_hw_register() as ath12k_fw_stats_init() takes care of
it for each ar.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 208 +++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/mac.h  |   3 +
 3 files changed, 148 insertions(+), 64 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 373e7baf379b..d278e4a8bb08 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -731,6 +731,7 @@ struct ath12k {
 	u32 mlo_setup_status;
 	u8 ftm_msgref;
 	struct ath12k_fw_stats fw_stats;
+	unsigned long last_tx_power_update;
 };
 
 struct ath12k_hw {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8cd33ea75590..efab885bdbb1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4280,6 +4280,145 @@ static int ath12k_start_scan(struct ath12k *ar,
 	return 0;
 }
 
+int ath12k_mac_get_fw_stats(struct ath12k *ar,
+			    struct ath12k_fw_stats_req_params *param)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
+	unsigned long timeout, time_left;
+	int ret;
+
+	guard(mutex)(&ah->hw_mutex);
+
+	if (ah->state != ATH12K_HW_STATE_ON)
+		return -ENETDOWN;
+
+	/* FW stats can get split when exceeding the stats data buffer limit.
+	 * In that case, since there is no end marking for the back-to-back
+	 * received 'update stats' event, we keep a 3 seconds timeout in case,
+	 * fw_stats_done is not marked yet
+	 */
+	timeout = jiffies + msecs_to_jiffies(3 * 1000);
+	ath12k_fw_stats_reset(ar);
+
+	reinit_completion(&ar->fw_stats_complete);
+
+	ret = ath12k_wmi_send_stats_request_cmd(ar, param->stats_id,
+						param->vdev_id, param->pdev_id);
+
+	if (ret) {
+		ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
+		return ret;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
+		   param->pdev_id, param->vdev_id, param->stats_id);
+
+	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
+
+	if (!time_left) {
+		ath12k_warn(ab, "time out while waiting for get fw stats\n");
+		return -ETIMEDOUT;
+	}
+
+	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
+	 * when stats data buffer limit is reached. fw_stats_complete
+	 * is completed once host receives first event from firmware, but
+	 * still end might not be marked in the TLV.
+	 * Below loop is to confirm that firmware completed sending all the event
+	 * and fw_stats_done is marked true when end is marked in the TLV.
+	 */
+	for (;;) {
+		if (time_after(jiffies, timeout))
+			break;
+		spin_lock_bh(&ar->data_lock);
+		if (ar->fw_stats.fw_stats_done) {
+			spin_unlock_bh(&ar->data_lock);
+			break;
+		}
+		spin_unlock_bh(&ar->data_lock);
+	}
+	return 0;
+}
+
+static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     unsigned int link_id,
+				     int *dbm)
+{
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_fw_stats_req_params params = {};
+	struct ath12k_fw_stats_pdev *pdev;
+	struct ath12k_hw *ah = hw->priv;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_base *ab;
+	struct ath12k *ar;
+	int ret;
+
+	/* Final Tx power is minimum of Target Power, CTL power, Regulatory
+	 * Power, PSD EIRP Power. We just know the Regulatory power from the
+	 * regulatory rules obtained. FW knows all these power and sets the min
+	 * of these. Hence, we request the FW pdev stats in which FW reports
+	 * the minimum of all vdev's channel Tx power.
+	 */
+	lockdep_assert_wiphy(hw->wiphy);
+
+	arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
+	if (!arvif || !arvif->ar)
+		return -EINVAL;
+
+	ar = arvif->ar;
+	ab = ar->ab;
+	if (ah->state != ATH12K_HW_STATE_ON)
+		goto err_fallback;
+
+	if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags))
+		return -EAGAIN;
+
+	/* Limit the requests to Firmware for fetching the tx power */
+	if (ar->chan_tx_pwr != ATH12K_PDEV_TX_POWER_INVALID &&
+	    time_before(jiffies,
+			msecs_to_jiffies(ATH12K_PDEV_TX_POWER_REFRESH_TIME_MSECS) +
+					 ar->last_tx_power_update))
+		goto send_tx_power;
+
+	params.pdev_id = ar->pdev->pdev_id;
+	params.vdev_id = arvif->vdev_id;
+	params.stats_id = WMI_REQUEST_PDEV_STAT;
+	ret = ath12k_mac_get_fw_stats(ar, &params);
+	if (ret) {
+		ath12k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
+		goto err_fallback;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+	pdev = list_first_entry_or_null(&ar->fw_stats.pdevs,
+					struct ath12k_fw_stats_pdev, list);
+	if (!pdev) {
+		spin_unlock_bh(&ar->data_lock);
+		goto err_fallback;
+	}
+
+	/* tx power reported by firmware is in units of 0.5 dBm */
+	ar->chan_tx_pwr = pdev->chan_tx_power / 2;
+	spin_unlock_bh(&ar->data_lock);
+	ar->last_tx_power_update = jiffies;
+
+send_tx_power:
+	*dbm = ar->chan_tx_pwr;
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "txpower fetched from firmware %d dBm\n",
+		   *dbm);
+	return 0;
+
+err_fallback:
+	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
+	*dbm = vif->bss_conf.txpower;
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "txpower from firmware NaN, reported %d dBm\n",
+		   *dbm);
+	return 0;
+}
+
 static u8
 ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
 {
@@ -7433,6 +7572,7 @@ static int ath12k_mac_start(struct ath12k *ar)
 	ar->num_created_vdevs = 0;
 	ar->num_peers = 0;
 	ar->allocated_vdev_map = 0;
+	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
 
 	/* Configure monitor status ring with default rx_filter to get rx status
 	 * such as rssi, rx_duration.
@@ -8638,6 +8778,7 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 	 */
 	ar->rx_channel = ctx->def.chan;
 	spin_unlock_bh(&ar->data_lock);
+	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
 
 	return 0;
 }
@@ -8666,6 +8807,7 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	 */
 	ar->rx_channel = NULL;
 	spin_unlock_bh(&ar->data_lock);
+	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
 }
 
 static enum wmi_phy_mode
@@ -10109,68 +10251,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	return 0;
 }
 
-int ath12k_mac_get_fw_stats(struct ath12k *ar,
-			    struct ath12k_fw_stats_req_params *param)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
-	unsigned long timeout, time_left;
-	int ret;
-
-	guard(mutex)(&ah->hw_mutex);
-
-	if (ah->state != ATH12K_HW_STATE_ON)
-		return -ENETDOWN;
-
-	/* FW stats can get split when exceeding the stats data buffer limit.
-	 * In that case, since there is no end marking for the back-to-back
-	 * received 'update stats' event, we keep a 3 seconds timeout in case,
-	 * fw_stats_done is not marked yet
-	 */
-	timeout = jiffies + msecs_to_jiffies(3 * 1000);
-	ath12k_fw_stats_reset(ar);
-
-	reinit_completion(&ar->fw_stats_complete);
-
-	ret = ath12k_wmi_send_stats_request_cmd(ar, param->stats_id,
-						param->vdev_id, param->pdev_id);
-
-	if (ret) {
-		ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
-		return ret;
-	}
-
-	ath12k_dbg(ab, ATH12K_DBG_WMI,
-		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
-		   param->pdev_id, param->vdev_id, param->stats_id);
-
-	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
-
-	if (!time_left) {
-		ath12k_warn(ab, "time out while waiting for get fw stats\n");
-		return -ETIMEDOUT;
-	}
-
-	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
-	 * when stats data buffer limit is reached. fw_stats_complete
-	 * is completed once host receives first event from firmware, but
-	 * still end might not be marked in the TLV.
-	 * Below loop is to confirm that firmware completed sending all the event
-	 * and fw_stats_done is marked true when end is marked in the TLV.
-	 */
-	for (;;) {
-		if (time_after(jiffies, timeout))
-			break;
-		spin_lock_bh(&ar->data_lock);
-		if (ar->fw_stats.fw_stats_done) {
-			spin_unlock_bh(&ar->data_lock);
-			break;
-		}
-		spin_unlock_bh(&ar->data_lock);
-	}
-	return 0;
-}
-
 static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta,
@@ -10463,6 +10543,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.assign_vif_chanctx		= ath12k_mac_op_assign_vif_chanctx,
 	.unassign_vif_chanctx		= ath12k_mac_op_unassign_vif_chanctx,
 	.switch_vif_chanctx		= ath12k_mac_op_switch_vif_chanctx,
+	.get_txpower			= ath12k_mac_op_get_txpower,
 	.set_rts_threshold		= ath12k_mac_op_set_rts_threshold,
 	.set_frag_threshold		= ath12k_mac_op_set_frag_threshold,
 	.set_bitrate_mask		= ath12k_mac_op_set_bitrate_mask,
@@ -11210,11 +11291,10 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 			goto err_unregister_hw;
 		}
 
+		ath12k_fw_stats_init(ar);
 		ath12k_debugfs_register(ar);
 	}
 
-	init_completion(&ar->fw_stats_complete);
-
 	return 0;
 
 err_unregister_hw:
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index a0de0ddf175e..8435bdea904f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -33,6 +33,9 @@ struct ath12k_generic_iter {
 #define ATH12K_KEEPALIVE_MAX_IDLE		3895
 #define ATH12K_KEEPALIVE_MAX_UNRESPONSIVE	3900
 
+#define ATH12K_PDEV_TX_POWER_INVALID		((u32)-1)
+#define ATH12K_PDEV_TX_POWER_REFRESH_TIME_MSECS	5000 /* msecs */
+
 /* FIXME: should these be in ieee80211.h? */
 #define IEEE80211_VHT_MCS_SUPPORT_0_11_MASK	GENMASK(23, 16)
 #define IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11	BIT(24)
-- 
2.34.1


