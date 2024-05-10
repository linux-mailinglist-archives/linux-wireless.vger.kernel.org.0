Return-Path: <linux-wireless+bounces-7420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DAE8C1D8F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 07:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A411C21460
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 05:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41514D2BE;
	Fri, 10 May 2024 05:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RG149Lba"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87D56757
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715317704; cv=none; b=ndKjqkjl0cjI3HWWHCRx1JYmxKeuxe4HLCAmbNtTZhM4trD2c8BCOO5/a2RnZVE3S14TNvyt75KxDScX4RHZKGKhwT9CtuJRGiJIMO+6a0sNZrOxjiOrm2N6eRvstctIwHqxgf+xtXYUa/kXapmAto+M0AhU4erjdrj5LtAJz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715317704; c=relaxed/simple;
	bh=2CGDxoDVspLvu6/ZSWdPq0wpZ/CqCLqi3dqciTEkN1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJtsTCwnWcGwte17PhQazaXnQeDaVSUY4LF40xq5Ovz0peeVIsQdbl2yhdg6RQSfqJFwj+5uEQLVmE1HsTJ0/gYz4sNQSRrPUUjJLtjgA4JZy6u1lyd9Rm03hTTBIsnPQg7fpEAbatlVctSwMLu6azZeVgJk9le3IC1SaM9z8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RG149Lba; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2tnqZ029691;
	Fri, 10 May 2024 05:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=1H1ZMOq
	tqXcnTRzy1xg0vOoah1KZzYfYoiP+OGekrgY=; b=RG149Lba21kaI9kb201nSFS
	F74bqOZxTvPeTjxJnMbPVS8XKy4AocpN6hzmey/SZa1hG8FSE8Vqad55k/s7R/v6
	umRitNhooRDOvFiQHw6QNS0ZULoLrAAQIGbpS+nlpgGADtXZodBY9h9Dfq7Wg4lV
	moX4Z1xtm6GqMf9Kjv9jNPDjI1Wtn/4BH2WACd++lOW//EgoDjpTkGteDg4vHD4F
	VarYT9gZMnKuoEgoXgBkcHXTDuUELU0bKzmXg+pb+0Pnl7XnVf2BRVOrc9UfuRnq
	wN61ncLk86VwtRJGzX3qb6iOMajWAyPkr4JQqtl4jJ50+z4J7gQF14vGVTkeo0A=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w18kjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:08:13 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44A58AaA031840;
	Fri, 10 May 2024 05:08:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xwe3krc50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:08:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44A58Ac8031806;
	Fri, 10 May 2024 05:08:10 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44A58AgU031800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:08:10 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 0EC404116F; Fri, 10 May 2024 10:38:09 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Lingbo Kong <quic_lingbok@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v2 3/5] wifi: ath12k: Fix Pdev id in HTT stats request for WCN7850
Date: Fri, 10 May 2024 10:38:04 +0530
Message-Id: <20240510050806.514126-4-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-GUID: S--2vKepqsgO2Zugwm7LYbqLNE518Biq
X-Proofpoint-ORIG-GUID: S--2vKepqsgO2Zugwm7LYbqLNE518Biq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_03,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100034

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
 drivers/net/wireless/ath/ath12k/dp_tx.c |  8 +++-
 drivers/net/wireless/ath/ath12k/mac.c   | 61 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h   |  3 ++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index a22fa43c87ec..c570e55c638e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1018,6 +1018,7 @@ ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
 	struct htt_ext_stats_cfg_cmd *cmd;
 	int len = sizeof(*cmd);
 	int ret;
+	u32 pdev_id;
 
 	skb = ath12k_htc_alloc_skb(ab, len);
 	if (!skb)
@@ -1029,7 +1030,12 @@ ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->hdr.msg_type = HTT_H2T_MSG_TYPE_EXT_STATS_CFG;
 
-	cmd->hdr.pdev_mask = 1 << ar->pdev->pdev_id;
+	if (ab->hw_params->single_pdev_only)
+		pdev_id = ath12k_mac_get_target_pdev_id(ar);
+	else
+		pdev_id = ar->pdev->pdev_id;
+
+	cmd->hdr.pdev_mask = 1 << pdev_id;
 
 	cmd->hdr.stats_type = type;
 	cmd->cfg_param0 = cpu_to_le32(cfg_params->cfg0);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 96dc5c2e096f..11b8b916084d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -666,6 +666,67 @@ static struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
 	return NULL;
 }
 
+struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	struct ath12k_pdev *pdev;
+	struct ath12k_vif *arvif;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		list_for_each_entry(arvif, &ar->arvifs, list) {
+			if (arvif->is_up)
+				return arvif;
+		}
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
+
+	arvif = ath12k_mac_get_vif_up(ar->ab);
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
index 69fd282b9dd3..f7a6966ba92d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -81,5 +81,8 @@ int ath12k_mac_rfkill_config(struct ath12k *ar);
 int ath12k_mac_wait_tx_complete(struct ath12k *ar);
 void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
 void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
+u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar);
+u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_vif *arvif);
+struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k_base *ab);
 
 #endif
-- 
2.34.1


