Return-Path: <linux-wireless+bounces-7364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F728C05B5
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 22:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A92B1F211EF
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1FD131729;
	Wed,  8 May 2024 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M9bD/kP2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F9130E4A
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200182; cv=none; b=X5fvIm6nwCMHNfwGc1oHu/7J/8mnUCGCbhDqkJWaFe1x1x+ytR22s6wGjeGRPYMMiy5aqpOGYmkVkUYPrnkzrQbo51CpNpHzQ+jlNuEuMqIpsvV2ZJi196z1QkMs/3DnwsDnGNV1oCDT6lI9b5M8DNCs6IurVt6dC8jjD6jMn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200182; c=relaxed/simple;
	bh=HPeXebHGFPe4VQzvALn/FFxn+k049S/KXK02/WT40Bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itt4km3MWbnmFiWfZ6crnBWz8N4KXjYjeW7gVV13oy9VD/0omKfWXAR6PO07pmf6Sa81kEaW8RE1vhStJT2xXFmDS+anIq8jOPXrHrwDFirVxoUwWM6k9zkrZssu873V3hdXu3c+Ey5SnUZxP5Z+IPX7PskrqiGTiFF0dNja8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M9bD/kP2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448CiPvu010621;
	Wed, 8 May 2024 20:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Qw/gD/Ez6xbn+jHvRP7Wq/nhmWExVTCPzOqpd510MPs=; b=M9
	bD/kP2BUtpB/ffTssr0VCGghcdgcTdyhldY3IVsgzb8iJhJd0S1U7Y/bkbwU4/E0
	008j//ooHcLroqxvuBPCuCua8f4xi1Vq/n6AjyHeYz2qaktrnNrrho9OzdvPGxge
	piiqD+f41A9tsxeeNWx3pY4jvg6AqK9lFyeYBV1qKmM3oKS0NzBA1XJGTtt+H/DC
	XI6s6eiPUibR/GvPkkNGPS1a/FZ40poabi5JVZ6/IH51XM1f9jtyNrSg28vEavIn
	BvgvsZzMbHQaRTy2mjQhwHTYnpFvndL8+j/P8QXh6W8pu9OI9BXmn9P9CiJ46vGi
	KSC3b9UKlH+aov4oxpmA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09nqh1ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 20:29:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448KTPP6007908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 20:29:25 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 13:29:24 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v2 6/9] wifi: ath12k: refactor arvif security parameter configuration
Date: Wed, 8 May 2024 13:29:09 -0700
Message-ID: <20240508202912.11902-7-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240508202912.11902-1-quic_alokad@quicinc.com>
References: <20240508202912.11902-1-quic_alokad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v624LnmGjtbAPOe84h0lKGnBTQW5yNKu
X-Proofpoint-GUID: v624LnmGjtbAPOe84h0lKGnBTQW5yNKu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080150

Configure security parameters in a separate function to make it
easier to support setting the same for nontransmitted profiles.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 33 +++++++++++++++++----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 97bb50e04b00..9391bea86050 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1295,6 +1295,26 @@ static int ath12k_mac_remove_vendor_ie(struct sk_buff *skb, unsigned int oui,
 	return 0;
 }
 
+static void ath12k_mac_set_arvif_ies(struct ath12k_vif *arvif, struct sk_buff *bcn)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)bcn->data;
+	const u8 *start, *tail;
+	u16 rem_len;
+
+	start = bcn->data + ieee80211_get_hdrlen_from_skb(bcn) + sizeof(mgmt->u.beacon);
+	tail = skb_tail_pointer(bcn);
+	rem_len = tail - start;
+
+	arvif->rsnie_present = false;
+	arvif->wpaie_present = false;
+
+	if (cfg80211_find_ie(WLAN_EID_RSN, start, rem_len))
+		arvif->rsnie_present = true;
+	if (cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT, WLAN_OUI_TYPE_MICROSOFT_WPA,
+				    start, rem_len))
+		arvif->wpaie_present = true;
+}
+
 static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 {
 	struct ath12k *ar = arvif->ar;
@@ -1303,8 +1323,6 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_mutable_offsets offs = {};
 	struct sk_buff *bcn;
-	struct ieee80211_mgmt *mgmt;
-	u8 *ies;
 	int ret;
 
 	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
@@ -1316,16 +1334,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 		return -EPERM;
 	}
 
-	ies = bcn->data + ieee80211_get_hdrlen_from_skb(bcn);
-	ies += sizeof(mgmt->u.beacon);
-
-	if (cfg80211_find_ie(WLAN_EID_RSN, ies, (skb_tail_pointer(bcn) - ies)))
-		arvif->rsnie_present = true;
-
-	if (cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
-				    WLAN_OUI_TYPE_MICROSOFT_WPA,
-				    ies, (skb_tail_pointer(bcn) - ies)))
-		arvif->wpaie_present = true;
+	ath12k_mac_set_arvif_ies(arvif, bcn);
 
 	if (arvif->vif->type == NL80211_IFTYPE_AP && arvif->vif->p2p) {
 		ret = ath12k_mac_setup_bcn_p2p_ie(arvif, bcn);
-- 
2.39.0


