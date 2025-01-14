Return-Path: <linux-wireless+bounces-17453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE657A0FD71
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 01:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70703A76AC
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 00:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27BF22F11;
	Tue, 14 Jan 2025 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G7Fx3tq8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0B19BBC
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736815111; cv=none; b=llF5Rj1x8QT2zNKcBCqkZ8xKGJgWJJRu1hQ9WEi9RCMq9S97I0+Bzf2PPafWyZvSMYmxmuuDnuzEzEgs76rp5xo1CHO8XSKNMBCob+ingukhATLqNnDMTGJSkm2tUWMOoyjK4nwLb7X/efniJ7BRafExtwr7JOmtMIZN3UPvLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736815111; c=relaxed/simple;
	bh=h27TpFEMUZmWks5hHeM0Zu7tEhdpcIdjdL//ynM1qVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAm2SMYgI0ga2aBxS756NrbmcfFdeJjrXPGeSPUqbo4K6V5juxCUuY+EmBCkUtFtF12ZkCCQsc1wNArvrTA63AtvcBTRlX8OBkw6C4OCPf3/FvO81YwyhIxOMA9FKGw4PRmYS8AHhPUoZ80heD4XayRpjc/SoJw9nLL/SrYLhTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G7Fx3tq8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DKZ0cR024379;
	Tue, 14 Jan 2025 00:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZFjktojHNXo4T+hGDbLBMLDijUkyGINI0+dHlxT9YR0=; b=G7Fx3tq8xB3hbnnX
	1O+5h0ZuXGRdy4uQsXsmGe0vPOujex7sBT6/rmMRqkc7SE3X2WbzRs8Rd+v0uUpl
	gOinqpZ3MtYiEhjzNFsxVqBFoYb7CDD8jLUAhjUmi17w3r0r+LiPmujxrQz98/Bq
	SlXYP9Ls8hGMZCxo7zr8lqnsoL6A3hzawKoZ8HkU+fg7wsdKKIFd2I/9pfWYKqB8
	HDLS9cECz4R59ZAkAjRJ+Z1SQ1RELAzNNRd/SkBO1TirnTbqOrKUNq+F/o/QXRlz
	dxIoOTR/5VxG7bYaHtgbHm7c7UlFm7iXsS8db+z//tbENq0ASysjpVu0ZGZ2g/Kf
	pmDPPw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445a06gdnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 00:38:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50E0cO1b025712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 00:38:24 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 13 Jan 2025 16:38:24 -0800
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
Subject: [PATCH v9 4/9] wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
Date: Mon, 13 Jan 2025 16:38:08 -0800
Message-ID: <20250114003813.2783550-5-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S2KfYofhqUEfXiTu7BVXXtuScU34uk12
X-Proofpoint-ORIG-GUID: S2KfYofhqUEfXiTu7BVXXtuScU34uk12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501140002

Generate rx and tx mcs maps in ath12k_mac_set_hemcsmap() based
on number of supported tx/rx chains and set them in supported
mcs/nss for HE capabilities.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 40 ++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 76c08f038869..d52856036ea4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6703,20 +6703,40 @@ static __le16 ath12k_mac_setup_he_6ghz_cap(struct ath12k_pdev_cap *pcap,
 	return cpu_to_le16(bcap->he_6ghz_capa);
 }
 
-static void ath12k_mac_set_hemcsmap(struct ath12k_band_cap *band_cap,
+static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
+				    struct ath12k_pdev_cap *cap,
 				    struct ieee80211_sta_he_cap *he_cap)
 {
 	struct ieee80211_he_mcs_nss_supp *mcs_nss = &he_cap->he_mcs_nss_supp;
+	u16 txmcs_map, rxmcs_map;
+	u32 i;
+
+	rxmcs_map = 0;
+	txmcs_map = 0;
+	for (i = 0; i < 8; i++) {
+		if (i < ar->num_tx_chains &&
+		    (ar->cfg_tx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))
+			txmcs_map |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
+		else
+			txmcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
+
+		if (i < ar->num_rx_chains &&
+		    (ar->cfg_rx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))
+			rxmcs_map |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
+		else
+			rxmcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
+	}
 
-	mcs_nss->rx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
-	mcs_nss->tx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
-	mcs_nss->rx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-	mcs_nss->tx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-	mcs_nss->rx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-	mcs_nss->tx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+	mcs_nss->rx_mcs_80 = cpu_to_le16(rxmcs_map & 0xffff);
+	mcs_nss->tx_mcs_80 = cpu_to_le16(txmcs_map & 0xffff);
+	mcs_nss->rx_mcs_160 = cpu_to_le16(rxmcs_map & 0xffff);
+	mcs_nss->tx_mcs_160 = cpu_to_le16(txmcs_map & 0xffff);
+	mcs_nss->rx_mcs_80p80 = cpu_to_le16(rxmcs_map & 0xffff);
+	mcs_nss->tx_mcs_80p80 = cpu_to_le16(txmcs_map & 0xffff);
 }
 
-static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
+static void ath12k_mac_copy_he_cap(struct ath12k *ar,
+				   struct ath12k_band_cap *band_cap,
 				   int iftype, u8 num_tx_chains,
 				   struct ieee80211_sta_he_cap *he_cap)
 {
@@ -6758,7 +6778,7 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
 		break;
 	}
 
-	ath12k_mac_set_hemcsmap(band_cap, he_cap);
+	ath12k_mac_set_hemcsmap(ar, &ar->pdev->cap, he_cap);
 	memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 	if (he_cap_elem->phy_cap_info[6] &
 	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
@@ -6947,7 +6967,7 @@ static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
 
 		data[idx].types_mask = BIT(i);
 
-		ath12k_mac_copy_he_cap(band_cap, i, ar->num_tx_chains, he_cap);
+		ath12k_mac_copy_he_cap(ar, band_cap, i, ar->num_tx_chains, he_cap);
 		if (band == NL80211_BAND_6GHZ) {
 			data[idx].he_6ghz_capa.capa =
 				ath12k_mac_setup_he_6ghz_cap(cap, band_cap);
-- 
2.34.1


