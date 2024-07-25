Return-Path: <linux-wireless+bounces-10513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD7393C15E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3F51C21FCD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0BA198E75;
	Thu, 25 Jul 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PvGx9yOa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB1199EBC
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908878; cv=none; b=jliH0LaHRdE+N9Goxt/bUXtQ9m3M+jhoc6K4+Y/VSSxwHUCfX8BUdj03C5Z4ExoyHIArKY5CVbONeWZ9l+EGNjPjY7O7W13sVJdfl6/RrmP51IHYTltqaEA3QjVnkff+5ILDdZ7arXLenMe0EId9JaFUXRMyyNbcHDeaVgYN+Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908878; c=relaxed/simple;
	bh=mGME6xXUuCW708zcUo2i9GnUcadQDhgtgH6zWESnh/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9ViE5JprfcVXpAUVgLwXuN4WkBukdUYYU5+iyi8yJRt5tq75hkU/scqa5zo+Wh3jprsRCHrf/PdWuT8f2LJnZddmPv4zIddhTBpmDmnxPrw+ynbyKZp0+YLufihfHpwDIzzj65whwpiHe754RykIsE0ZMiJ5pAPgG3497VnOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PvGx9yOa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P9W5jL011243;
	Thu, 25 Jul 2024 12:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1sXm2ERfsX9ChBwv85AsK4QaVXxGlZTrBCssjGnDfM4=; b=PvGx9yOa7eBkvGmS
	bWQm4hB6jkcDfTZaO9c4Y0fh6LIYuuDLHDZ11QX40M+V8DVvchJqVnQV60iW5FxD
	0m+ZVN8xMz5mPpn2Ls5fBExN4e8GTMKZ6FuH8jmSOZUjgCjvY2RP2Qf+gESv8sfq
	xRso60SV9P3f76Al613jhe1IQSibgSiykSVNKLRa1MyTclYvcvH4hS8FKsQyx9uz
	kzZbGTObEewUv/T/2ZeOwxT/XxgjmMqlh8uQ1JgyaIJ4gxFqLS9xmGjfkHkqZKU9
	ah0K3XVurBx5r378ol0Gf9gVFWuRHBD664NB7I1YLtOSI9KJfYBEAKnz/N0OdKLN
	PE9NdQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40jyrfkegc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PC1DX3006210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:13 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 05:01:12 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 10/11] wifi: ath12k: fix A-MSDU indication in monitor mode
Date: Thu, 25 Jul 2024 20:00:34 +0800
Message-ID: <20240725120035.493-11-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240725120035.493-1-quic_kangyang@quicinc.com>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: Cq7ZGVG_VC73g21LdUfCwXhdUYZWo33L
X-Proofpoint-ORIG-GUID: Cq7ZGVG_VC73g21LdUfCwXhdUYZWo33L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_11,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=908 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250082

From: Kang Yang <quic_kangyang@quicinc.com>

In monitor mode, host will reap MSDUs and then the MSDUs with same PPDU
ID will be aggregated into an A-MSDU in ath12k_dp_mon_rx_merg_msdus().

However, ath12k_dp_mon_rx_merg_msdus() doesn't calculate the total
length of the A-MSDU. This causes Wireshark to display the A-MSDU
incorrectly.

Therefore, need to add calculation of the A-MSDU length.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 1f989bcf795b..6ebfded60397 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -870,11 +870,11 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar, u32 mac_id,
 			    struct ieee80211_rx_status *rxs, bool *fcs_err)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct sk_buff *msdu, *mpdu_buf, *prev_buf;
+	struct sk_buff *msdu, *mpdu_buf, *prev_buf, *head_frag_list;
 	struct hal_rx_desc *rx_desc, *tail_rx_desc;
 	u8 *hdr_desc, *dest, decap_format;
 	struct ieee80211_hdr_3addr *wh;
-	u32 err_bitmap;
+	u32 err_bitmap, frag_list_sum_len = 0;
 
 	mpdu_buf = NULL;
 
@@ -897,10 +897,15 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar, u32 mac_id,
 
 		prev_buf = head_msdu;
 		msdu = head_msdu->next;
+		head_frag_list = NULL;
 
 		while (msdu) {
 			ath12k_dp_mon_rx_msdus_set_payload(ar, msdu, tail_msdu);
 
+			if (!head_frag_list)
+				head_frag_list = msdu;
+
+			frag_list_sum_len += msdu->len;
 			prev_buf = msdu;
 			msdu = msdu->next;
 		}
@@ -908,6 +913,12 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar, u32 mac_id,
 		prev_buf->next = NULL;
 
 		skb_trim(prev_buf, prev_buf->len - HAL_RX_FCS_LEN);
+		if (head_frag_list) {
+			skb_shinfo(head_msdu)->frag_list = head_frag_list;
+			head_msdu->data_len = frag_list_sum_len;
+			head_msdu->len += head_msdu->data_len;
+			head_msdu->next = NULL;
+		}
 	} else if (decap_format == DP_RX_DECAP_TYPE_NATIVE_WIFI) {
 		u8 qos_pkt = 0;
 
-- 
2.34.1


