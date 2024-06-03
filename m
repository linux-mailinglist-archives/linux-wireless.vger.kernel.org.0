Return-Path: <linux-wireless+bounces-8393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F23028D7ADC
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 06:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF43B21B93
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 04:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA961F602;
	Mon,  3 Jun 2024 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RG/OZuav"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99317C77
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717389754; cv=none; b=SEorsEJiin7JY/yn2iGBjlhUSq0HnepW9FcZRbMXPaKtIBUvI5mFaIxTHvFF/i3/dhyntH3ggY3LmFh3tnCncfGRnuxEznv05yan5WxeTK/iNYT0orPZYDD7up8KsPntsnWZuFFYFgQ6+fyUoO8NE353rE9sHhN1Mh+eUlCOicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717389754; c=relaxed/simple;
	bh=cFD8SkHd2XDXtzQf16vYGV+n6aBHxCUk2g/Gm0ksiJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8roMun+3BZz8MIDm/Q/hj1IFyDhYDGg5an+w3OZINMpgp6Y1XGnAyEq2GNI71yo9agosBMPZCLGt86oKEi+/UlUhIfvgr73FpZPMCoPF/Pasmfn5hXwtq7Xs75ZxOBlILxQqkvWrBVZubU+nxU372uQusJETkDGKaLUWaGgpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RG/OZuav; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4531e9Fh024027;
	Mon, 3 Jun 2024 04:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2NcbMM8VANa
	3Wh9JYxJprFXtBmupZcXTTbOC9fiHsNk=; b=RG/OZuavfJbYW8v1rY5t73HdU1M
	z3rICc3e7W0Tu21dsWBfrlOePmbcwPtG6GdeBbQr3cYaqdwiFBRM0RUcXLNTHNys
	u8KOXugfFqXoKsSUdK8bijYSnnh6ZvNnU0zPJP+Qh+VQ0NYbnS+EyFM8E7awqC85
	o7eWRMfENdoMx4v4WpC0X9oJxP0kb3n5fdTKzNtt9T7r7NXfnfD1hTPiZg9IwXOT
	zfqN0dj1d/kl5uLHPFzBem6miYRi0Qut7u9O9nbv4YKp2VEp5HN1VNoIBfknOeWu
	BGj1o5j1x+5ebQLqDowBruEudZcFkTLaHQbTwjcLSnpvc2rg7HFbq9d4K5A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw7djydq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 04:42:28 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4534gPxP020289;
	Mon, 3 Jun 2024 04:42:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3yfvqkfu1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 04:42:25 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4534gOrU020283;
	Mon, 3 Jun 2024 04:42:24 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4534gOZg020282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 04:42:24 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id C93E741181; Mon,  3 Jun 2024 10:12:23 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Lingbo Kong <quic_lingbok@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v4 3/5] wifi: ath12k: Fix Pdev id in HTT stats request for WCN7850
Date: Mon,  3 Jun 2024 10:12:12 +0530
Message-Id: <20240603044214.960261-4-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603044214.960261-1-quic_rgnanase@quicinc.com>
References: <20240603044214.960261-1-quic_rgnanase@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 53V9jdByoZIICmJ1oXmSKEzuVJZ4oEa4
X-Proofpoint-GUID: 53V9jdByoZIICmJ1oXmSKEzuVJZ4oEa4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030037

From: Lingbo Kong <quic_lingbok@quicinc.com>

Pdev id from mac phy capabilities will be sent as a part of
HTT stats request to firmware. This causes issue with single pdev
devices where fimrware does not respond to the stats request
sent from host.

Single pdev devices firmware expects pdev id as 1 for 5GHz/6GHz
phy and 2 for 2GHz band. Handle pdev id for single phy device
while sending HTT stats request message to firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c |  5 ++-
 drivers/net/wireless/ath/ath12k/mac.c   | 59 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h   |  3 ++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index c4cfa7cf7cb9..d2f6b016a3b3 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1086,6 +1086,7 @@ ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
 	struct htt_ext_stats_cfg_cmd *cmd;
 	int len = sizeof(*cmd);
 	int ret;
+	u32 pdev_id;
 
 	skb = ath12k_htc_alloc_skb(ab, len);
 	if (!skb)
@@ -1097,7 +1098,9 @@ ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->hdr.msg_type = HTT_H2T_MSG_TYPE_EXT_STATS_CFG;
 
-	cmd->hdr.pdev_mask = 1 << ar->pdev->pdev_id;
+	pdev_id = ath12k_mac_get_target_pdev_id(ar);
+
+	cmd->hdr.pdev_mask = 1 << pdev_id;
 
 	cmd->hdr.stats_type = type;
 	cmd->cfg_param0 = cpu_to_le32(cfg_params->cfg0);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 784964ae03ec..31a66ade7852 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -670,6 +670,65 @@ static struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
 	return NULL;
 }
 
+struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k *ar)
+{
+	struct ath12k_vif *arvif;
+
+	lockdep_assert_held(&ar->conf_mutex);
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif->is_up)
+			return arvif;
+	}
+
+	return NULL;
+}
+
+static bool ath12k_mac_band_match(enum nl80211_band band1, enum WMI_HOST_WLAN_BAND band2)
+{
+	return (((band1 == NL80211_BAND_2GHZ) && (band2 & WMI_HOST_WLAN_2G_CAP)) ||
+		(((band1 == NL80211_BAND_5GHZ) || (band1 == NL80211_BAND_6GHZ)) &&
+		   (band2 & WMI_HOST_WLAN_5G_CAP)));
+}
+
+u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_vif *arvif)
+{
+	struct ath12k *ar = arvif->ar;
+	struct ath12k_base *ab = ar->ab;
+	struct ieee80211_vif *vif = arvif->vif;
+	struct cfg80211_chan_def def;
+	enum nl80211_band band;
+	u8 pdev_id = ab->fw_pdev[0].pdev_id;
+	int i;
+
+	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+		return pdev_id;
+
+	band = def.chan->band;
+
+	for (i = 0; i < ab->fw_pdev_count; i++) {
+		if (ath12k_mac_band_match(band, ab->fw_pdev[i].supported_bands))
+			return ab->fw_pdev[i].pdev_id;
+	}
+
+	return pdev_id;
+}
+
+u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar)
+{
+	struct ath12k_vif *arvif;
+	struct ath12k_base *ab = ar->ab;
+
+	if (!ab->hw_params->single_pdev_only)
+		return ar->pdev->pdev_id;
+
+	arvif = ath12k_mac_get_vif_up(ar);
+
+	if (arvif)
+		return ath12k_mac_get_target_pdev_id_from_vif(arvif);
+	else
+		return ar->ab->fw_pdev[0].pdev_id;
+}
+
 static void ath12k_pdev_caps_update(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 69fd282b9dd3..877005b56a7c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -81,5 +81,8 @@ int ath12k_mac_rfkill_config(struct ath12k *ar);
 int ath12k_mac_wait_tx_complete(struct ath12k *ar);
 void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
 void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
+u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar);
+u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_vif *arvif);
+struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k *ar);
 
 #endif
-- 
2.34.1


