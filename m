Return-Path: <linux-wireless+bounces-5767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F8D895E69
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 23:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345C4288632
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 21:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3D115E5AA;
	Tue,  2 Apr 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jbvmWhZ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0312DDBE
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091956; cv=none; b=Spuiiff+iNn9yESoyK/BkkkCpy27Ot5QXlV/SZdWeOetw8dnf8mL3N49ilobtr3LFYN/9rzfWa8a1R6ilYolrChjvADLxRX3fv1wJMoqy9CKt3wjiCJvI5dER4blOJrENMMR086lmV3/RegonKbOu4hHEa8ReJGTkJTyqBejf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091956; c=relaxed/simple;
	bh=QGFSju/xtJlSmAOEoaQV4VAfRWIXKtYoaqEGccEqyKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jadjJf+QKSEyb3m7wuSx7W8J80VV2jh5YyARP/JiJ7jTm1tTy143GIzMsowv28geBCHKQsfQkyY+L2FetsB8WStKXeYfdeNDos5tLU7HIu7S64qpNuntKHXI7Ji3xTn3oVp8c5Jo74gOeW0tp/1bw3UbJRDvosunjPuyqHAOF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jbvmWhZ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432HDuSg018895;
	Tue, 2 Apr 2024 21:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=iuHKgaN0UdFzti4ivh25s5UvnrZVlq0j6E+8ytyec6A=; b=jb
	vmWhZ9zZYHmkKBdT2nALKkAQgU4qUbDlQwfke5n+Cr9rp9mRaCscqdkg7AsBaey9
	1vAqCjV5UFFOPKOHrCQleXdn7wWOahBlX7msYsVpdD7Z0mGWPW+QW5OLQvkPWP0E
	VEzIq8e3UAIYD0YhRcQMReEjQD6fFiUdzGY/JPR+xJa9ppU2NR3UB22ACGO7gpKx
	rdLIKA57tGpqLCbjI/bSgBAGI2ldEnba/oDAvr6sbXUHaM5BkRKijjNd6ggEOAeF
	6sAm1dz83KeFlGGMbHW9gCgpwKX4fT+Zh9KnIMu4XtMiTKI0ZUuErPfHQeRNsWc1
	lxIcDnQn5mCmQoGDQ5ig==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8ha3hfd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 21:05:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432L5o0U031821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 21:05:50 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 14:05:50 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 6/9] wifi: ath12k: refactor arvif security parameter configuration
Date: Tue, 2 Apr 2024 14:05:35 -0700
Message-ID: <20240402210538.7308-7-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240402210538.7308-1-quic_alokad@quicinc.com>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UpNw-9e0Uxfb4GYsR9_q2pjvUnNSixK1
X-Proofpoint-GUID: UpNw-9e0Uxfb4GYsR9_q2pjvUnNSixK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020157

Configure security parameters in a separate function to make it
easier to support setting the same for nontransmitted profiles.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 33 +++++++++++++++++----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 01422fcfa760..996ce2c4698a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1242,6 +1242,26 @@ static int ath12k_mac_remove_vendor_ie(struct sk_buff *skb, unsigned int oui,
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
@@ -1250,8 +1270,6 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_mutable_offsets offs = {};
 	struct sk_buff *bcn;
-	struct ieee80211_mgmt *mgmt;
-	u8 *ies;
 	int ret;
 
 	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
@@ -1263,16 +1281,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
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


