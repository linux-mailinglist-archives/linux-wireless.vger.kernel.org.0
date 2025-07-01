Return-Path: <linux-wireless+bounces-24697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E1DAEEBC6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 03:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A91217FDBF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 01:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E41917F1;
	Tue,  1 Jul 2025 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jUyN5xTV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2B1B4233
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331871; cv=none; b=nr0rES02R1WianXitY4nhQDAMgXeTHJvu6Px5Q0m0FPaD9v9Ou6kjMon/t0Ra1I/p90DKvIWSAXfKVSzTxasc50StcPzKgOm4+ouhFJjwuh2fEETzHYaU6BCzoAnCQ/TjEQE227wWLfkXnuh6obQ+s7AiSHJKMQzmNd+1FBgNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331871; c=relaxed/simple;
	bh=gBk0EbGDKgoiwl2JcpI1/kjKrPmXJGrDQRs5IRilk5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qa0cQP0ehF6MVPZC4qeMBOG99hjKysJonnPAPDoaxKRw87szbfUimufunp2Rpcc3H2TnAqcOhHXzWhNs0sHTPpoC43GGrIoJUnHZJza1YbvrbGeOTMfwiwxF2OAWitXlDloAI2rhmI/RHIeD6eo60Mi2BNMIa6HHzl3K1iBQLZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jUyN5xTV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFa8gf018851;
	Tue, 1 Jul 2025 01:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oa6jwkvCvZApAnZfKFGPGOnhPz9xWBS1/+J0Ck8VvIQ=; b=jUyN5xTVhyrcAQ5B
	WbbyXwoXw2h2q3YMlX3PRaK4Nka2xNGK59wPgGPljY4+hmsvimsogvPuHoWheTB+
	gZT4lr2ObgfRkHbKLA+Ca7zOrIxRSuPQwZpYg8HGvHuW3wF8+LjFxkIWCFPvZisS
	mvn7pkmjjQM7lacC4LF1RBsB11cVi5AGXMeCGDGYwGcXUNA71MpLEQPAStcydlsB
	oqSMpKQ3MYTw5EX3ninH+uMxEGoWyR+Rw1TO8clBYknhPbC+ZW+d4T3etm+31cIS
	N0ofLiGEZCy0mW9nJd3TCFvnkNZ96pgFsME7y+a/UW97lX7Te1iLDKvZ/GTxZbH2
	bTU/Ew==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxekav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 01:04:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56114NjG014980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 01:04:23 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 18:04:23 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
Subject: [PATCH ath-next V15 4/9] wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
Date: Mon, 30 Jun 2025 18:04:03 -0700
Message-ID: <20250701010408.1257201-5-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
References: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAwMyBTYWx0ZWRfXwTX0v5UFlRVX
 KB4q+XEfKHA86yfXmnXf+emWxAkbzzzvrqqZddh8SehSuZRS9SHVcUb3zWIXn8LSkCpHIbfwlym
 aeuOUf4AE28zFtDIKfazuEUChsjSLmL1SVDcbBRJJOWW/WEM1LZwdLibsBIHy8AS0s3Ue8q14Hs
 zrxISXfU/ULolxoLgN9pJfS07ibvjJ5uxK8Jt0LmZg6+o+e/Pdp7aHwNdHwFiexx7Ff1LDJkfx9
 VHdbcS7039Pve6q7m1p6ULmL9iIuFUMcOjcyKTTJyvD2z8c71SF0sfdpHx/Ea7uenygKi/q/L7X
 TkBEC98KF9RbI+mcKe2ixy8SRu7E1Lgpb3kwFxg7zgOVH/2nF0uJ9iHC7dyjIIlPVQ5AhU35uGF
 ScauywtugQTrdZnbzuVw1D2uGsVwhrj1/eLkAYqXFFCKic6CAjlQah+RZB3QreDdEAEjoWgQ
X-Proofpoint-GUID: xTiHXZQh1g434XwlNqtTtXLqU-IGS7_c
X-Proofpoint-ORIG-GUID: xTiHXZQh1g434XwlNqtTtXLqU-IGS7_c
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=68633418 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=WmtfbAKxhnfIJFSrnnQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010003

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
index f3833fa08070..37f50851a236 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7537,20 +7537,40 @@ static __le16 ath12k_mac_setup_he_6ghz_cap(struct ath12k_pdev_cap *pcap,
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
@@ -7594,7 +7614,7 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
 		break;
 	}
 
-	ath12k_mac_set_hemcsmap(band_cap, he_cap);
+	ath12k_mac_set_hemcsmap(ar, &ar->pdev->cap, he_cap);
 	memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 	if (he_cap_elem->phy_cap_info[6] &
 	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
@@ -7784,7 +7804,7 @@ static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
 
 		data[idx].types_mask = BIT(i);
 
-		ath12k_mac_copy_he_cap(band_cap, i, ar->num_tx_chains, he_cap);
+		ath12k_mac_copy_he_cap(ar, band_cap, i, ar->num_tx_chains, he_cap);
 		if (band == NL80211_BAND_6GHZ) {
 			data[idx].he_6ghz_capa.capa =
 				ath12k_mac_setup_he_6ghz_cap(cap, band_cap);
-- 
2.43.0


