Return-Path: <linux-wireless+bounces-4586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0773878E0E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 06:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AF4B20F19
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 05:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD973C8DD;
	Tue, 12 Mar 2024 05:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IzH4j/wd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB4C126
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219673; cv=none; b=JbYBd8stOSfTkRXw2/GaqDpTLpjF9yHBItgqfMDV1qWG2GJgazL0i5gDTHJSzlVIaZ3JAG/W3ak1cEqTyZ1NqVGmpGlnr1tdaSYjUV2hTWR3cP7WMIchNPHgG7IkUQON1krTz/papRxgZLq0eCvRWNHGmAu59w8jKvgMXuyrFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219673; c=relaxed/simple;
	bh=0vhKn75tW2+IKqCXbiqKo6O8H4UNUVi0OvPMOFrCinI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFFdhOpJ3vt36YxrOyiDg0knJKz9DUJH4gAEG0ckiWj/RRVg39OOHpbhpG8azICD1vuvQBKphGPruDzWiHFbp90FYyK1gOZITalHmvpxKbYPxbdXCSsmuIyfqjgJ3+qdXESF2IK6nDA1iZimsuEkZCscMy2s9qDOo/k41vp9kA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IzH4j/wd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C4QX4r022434;
	Tue, 12 Mar 2024 05:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=K74oR90dIM8wfqj6AdZ7Fp75JGBTgyEwJVd0CznAtWM=; b=Iz
	H4j/wdlZ9O3l5ZYIxzSzeFMeaZrtfJRHaBZAuLD7jFsSka4wjmK1KC5h3HLRDGpS
	uUtXO8F29U80R9oJ6IFyE+O3kcFtsRSoVoQsDuTqahlj4pKvu9n64eJ7iEBmUWWV
	trcPFOzFUGXgUfNKNs888itjMpmkeSYYb+yRWCjZslv4oTwLWo6v83emk8lo9rCE
	guVVcjBvCZ3AaCyhgjIxj2HyImayYnYmKMPoShY39PazNFwGddYW57f2kzUvFoMD
	INSYgcOlQfElOfwdPTF58HZbyZTrG42EFhOy8+1UYteslS5Ufl9dptfi2lmMSW9I
	pjf3T7Fo2zwkzOjvwxAQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wt7j18yx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 05:01:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C512hE020319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 05:01:02 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 22:01:00 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: dynamically update puncturing bitmap
Date: Tue, 12 Mar 2024 12:59:47 +0800
Message-ID: <20240312045947.576231-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312045947.576231-1-quic_kangyang@quicinc.com>
References: <20240312045947.576231-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Quc89oNXNbhQ7OjSEomrn7Wmj7mx0eH4
X-Proofpoint-ORIG-GUID: Quc89oNXNbhQ7OjSEomrn7Wmj7mx0eH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_04,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120037

Every time EHT Operation element changed, mac80211 will parse it and
extract the valid puncturing bitmap according to the bandwidth.

So update bandwidth and puncturing bitmap once they changed. Then
send them to the firmware by WMI event.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 58 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 16 ++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 52a5fb8b03e9..94ebc14e7f35 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6502,6 +6502,54 @@ ath12k_mac_change_chanctx_fill_iter(void *data, u8 *mac,
 	arg->next_vif++;
 }
 
+static u32 ath12k_mac_nlwidth_to_wmiwidth(enum nl80211_chan_width width)
+{
+	switch (width) {
+	case NL80211_CHAN_WIDTH_20:
+		return WMI_CHAN_WIDTH_20;
+	case NL80211_CHAN_WIDTH_40:
+		return WMI_CHAN_WIDTH_40;
+	case NL80211_CHAN_WIDTH_80:
+		return WMI_CHAN_WIDTH_80;
+	case NL80211_CHAN_WIDTH_160:
+		return WMI_CHAN_WIDTH_160;
+	case NL80211_CHAN_WIDTH_80P80:
+		return WMI_CHAN_WIDTH_80P80;
+	case NL80211_CHAN_WIDTH_5:
+		return WMI_CHAN_WIDTH_5;
+	case NL80211_CHAN_WIDTH_10:
+		return WMI_CHAN_WIDTH_10;
+	case NL80211_CHAN_WIDTH_320:
+		return WMI_CHAN_WIDTH_320;
+	default:
+		WARN_ON(1);
+		return WMI_CHAN_WIDTH_20;
+	}
+}
+
+static int ath12k_mac_update_peer_puncturing_width(struct ath12k *ar,
+						   struct ath12k_vif *arvif,
+						   struct cfg80211_chan_def def)
+{
+	u32 param_id, param_value;
+	int ret;
+
+	param_id = WMI_PEER_CHWIDTH_PUNCTURE_20MHZ_BITMAP;
+	param_value = ath12k_mac_nlwidth_to_wmiwidth(def.width) |
+		u32_encode_bits((~def.punctured),
+				WMI_PEER_PUNCTURE_BITMAP);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "Set puncturing bitmap %02x and width %d for vdev: %d\n",
+		   def.punctured, def.width, arvif->vdev_id);
+
+	ret = ath12k_wmi_set_peer_param(ar, arvif->bssid,
+					arvif->vdev_id, param_id,
+					param_value);
+
+	return ret;
+}
+
 static void
 ath12k_mac_update_vif_chan(struct ath12k *ar,
 			   struct ieee80211_vif_chanctx_switch *vifs,
@@ -6594,6 +6642,16 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 				    arvif->vdev_id, ret);
 			continue;
 		}
+
+		ret = ath12k_mac_update_peer_puncturing_width(arvif->ar, arvif,
+							      vifs[i].new_ctx->def);
+		if (ret) {
+			ath12k_warn(ar->ab,
+				    "failed to update puncturing bitmap %02x and width %d: %d\n",
+				    vifs[i].new_ctx->def.punctured,
+				    vifs[i].new_ctx->def.width, ret);
+			continue;
+		}
 	}
 
 	/* Restart the internal monitor vdev on new channel */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 103462feb935..d0599a6dce4d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2199,8 +2199,11 @@ enum wmi_peer_param {
 	WMI_PEER_SET_MAX_TX_RATE = 17,
 	WMI_PEER_SET_MIN_TX_RATE = 18,
 	WMI_PEER_SET_DEFAULT_ROUTING = 19,
+	WMI_PEER_CHWIDTH_PUNCTURE_20MHZ_BITMAP = 39,
 };
 
+#define WMI_PEER_PUNCTURE_BITMAP		GENMASK(23, 8)
+
 enum wmi_slot_time {
 	WMI_VDEV_SLOT_TIME_LONG = 1,
 	WMI_VDEV_SLOT_TIME_SHORT = 2,
@@ -2604,6 +2607,19 @@ struct ath12k_wmi_soc_hal_reg_caps_params {
 	__le32 num_phy;
 } __packed;
 
+enum wmi_channel_width {
+	WMI_CHAN_WIDTH_20 = 0,
+	WMI_CHAN_WIDTH_40 = 1,
+	WMI_CHAN_WIDTH_80 = 2,
+	WMI_CHAN_WIDTH_160 = 3,
+	WMI_CHAN_WIDTH_80P80 = 4,
+	WMI_CHAN_WIDTH_5 = 5,
+	WMI_CHAN_WIDTH_10 = 6,
+	WMI_CHAN_WIDTH_165 = 7,
+	WMI_CHAN_WIDTH_160P160 = 8,
+	WMI_CHAN_WIDTH_320 = 9,
+};
+
 #define WMI_MAX_EHTCAP_MAC_SIZE  2
 #define WMI_MAX_EHTCAP_PHY_SIZE  3
 #define WMI_MAX_EHTCAP_RATE_SET  3
-- 
2.34.1


