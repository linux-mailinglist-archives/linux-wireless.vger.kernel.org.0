Return-Path: <linux-wireless+bounces-9427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E7F912262
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 12:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C7A28AF7E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E02171647;
	Fri, 21 Jun 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DaWdTXWS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C4917109B
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965740; cv=none; b=jAVA084rPevXdPfujd7/304OY2BpSG9Uxohe9SUD1Rhfksk8blju8JEmsbA32+8VrivA7GmKeEdRl0gCzZByjsGnR75b4UQIvCYQ2gP8hkhGRntbN+4JTJfKt2mVBdHbMggFchZcKYkBul8nRgH8+9Au3tsKH8iazmRRaOfKRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965740; c=relaxed/simple;
	bh=Ukg4mchcWuzTasNT4GL32mXRh9h7YAwbS01BncSs6jA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IHHSHJw4BjETichI2R3ok1hcc3KFlF/PM6vpNVEtwWjGAf0Lw/7PpRYelT2b0UYiEyELyEcdKSW8qcoa5ohK8reENZOOC/rnuweBUkb7mSx6juSyxqoI9hZLd7BykT4wSxSWp3ofxIKVIyr+pcyrY2I1EIDTqfUWW2pxMipnvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DaWdTXWS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L67AAo018160;
	Fri, 21 Jun 2024 10:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mRA1HZXsl2V0hmg48lYdjzuM13cxSnGOq2Y
	sSrNH+7o=; b=DaWdTXWS8TIKb8MxpYUnuGNuXFhTArQcZLR6MDX4WQEvZNbCDMk
	eLEHuC4rgjmex+kNLmam36nxZ9BbEsQdBjpFgYnkyFyej5en9C3kHHQIrmyGIXP/
	jbaQFd2T1czR9umEZ8QzmbH8yWNJv/2z36pkjo+c0FcMTk0yzEyRqszyeeW1cOzp
	zG3bDoz8Zd11pEmLmPKQOuGMlKvYpgPrUcYR/PdxBfQwoN82HYsu6GYJzyH04W04
	L2XiRmIuHD/Og9lnaaMKPttXT+hTO7dNKWRXApIy2WUBu8TZ1bxOWTcetpqsuODF
	1UGIx+Kd+cCm8eWPIO/vSmN1fVd/Hojo2Hg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrp1a9as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 10:28:53 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 45LASn5u007849;
	Fri, 21 Jun 2024 10:28:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3ys41mbaew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 10:28:49 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45LASms5007843;
	Fri, 21 Jun 2024 10:28:49 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45LASmsx007842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 10:28:48 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id C324D41149; Fri, 21 Jun 2024 15:58:47 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Lingbo Kong <quic_lingbok@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: Fix pdev id sent to firmware for single phy devices
Date: Fri, 21 Jun 2024 15:58:09 +0530
Message-Id: <20240621102809.3984004-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: aWoannXO4upzofr0_lDdb_Cdvw54QoEw
X-Proofpoint-ORIG-GUID: aWoannXO4upzofr0_lDdb_Cdvw54QoEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210077

From: Lingbo Kong <quic_lingbok@quicinc.com>

Pdev id from mac phy capabilities will be sent as a part of
HTT/WMI command to firmware. This causes issue with single pdev
devices where firmware does not respond to the WMI/HTT request
sent from host.

For single pdev devices firmware expects pdev id as 1 for 5 GHz/6 GHz
phy and 2 for 2 GHz band. Add wrapper ath12k_mac_get_target_pdev_id()
to help fetch right pdev for single pdev devices.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
v2:
   - Addressed Kalle's comments
     - Function protoype changed to static
     - Coding style changed for better readability

Note: Wrapper ath12k_mac_get_target_pdev_id() will be used when driver sends
pdev id while requesting stats such as HTT or WMI control path stats.
Adding wrapper as a separate patch to eliminate depedency for future
development.
---
 drivers/net/wireless/ath/ath12k/mac.c | 76 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h |  1 +
 2 files changed, 77 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 17b7fab03d50..278087c15bc3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -670,6 +670,82 @@ static struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
 	return NULL;
 }
 
+static struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k *ar)
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
+	switch (band1) {
+	case NL80211_BAND_2GHZ:
+		if (band2 & WMI_HOST_WLAN_2G_CAP)
+			return true;
+		break;
+	case NL80211_BAND_5GHZ:
+	case NL80211_BAND_6GHZ:
+		if (band2 & WMI_HOST_WLAN_5G_CAP)
+			return true;
+		break;
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_vif *arvif)
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
+	/* fw_pdev array has pdev ids derived from phy capability
+	 * service ready event (pdev_and_hw_link_ids).
+	 * If no vif is active, return default first index.
+	 */
+	if (!arvif)
+		return ar->ab->fw_pdev[0].pdev_id;
+
+	/* If active vif is found, return the pdev id matching chandef band */
+	return ath12k_mac_get_target_pdev_id_from_vif(arvif);
+}
+
 static void ath12k_pdev_caps_update(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 69fd282b9dd3..5c543fc87b35 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -81,5 +81,6 @@ int ath12k_mac_rfkill_config(struct ath12k *ar);
 int ath12k_mac_wait_tx_complete(struct ath12k *ar);
 void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
 void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
+u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar);
 
 #endif

base-commit: cac9bfd02678adbcca9a7dce770609b9f7434d37
-- 
2.34.1


