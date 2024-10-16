Return-Path: <linux-wireless+bounces-14053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D99A01E9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06D41F26070
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4331991D9;
	Wed, 16 Oct 2024 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H+hHp0JU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F731B2193
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061864; cv=none; b=K/joLuF42Ft/Y7llGPOPt6n7LQO+GDXnQ0TfCx/pXPoMs6DyGLSU0d80j0vc7+I6dgADcG3hzwmQ+2LTZgZcwfJlyBmkvcDC2D8W0OGjawoxGVPOaGbB3mMm96ynRWvxa9hbcaSmsYyUMQZXM1HiSwPMxAY/hJ/jQWfx2wfEO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061864; c=relaxed/simple;
	bh=cniHWkTZZQa8NXdrw8AzkXqUfbH0GSDs0jA1ajxKeWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pA/4ibzO86foCt0hH3eVQYeC1bCeQQskgAHQvgMLRgDBOY0yeLs7qzb+N30NihYpvI6Dp5A4za9Wm9hLsFu9sVPtaz1GFI0nCDhpeVo2oo78zNp1FlQ4NKfO8OTnfjlrAnXMdCQyyq0UvtHfWv5zL+HaZ5c9ZsPCPHCar7dQpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H+hHp0JU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G0uO7D025590;
	Wed, 16 Oct 2024 06:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lk7/Yejga3Uk2ucy5+rvquU1M6pqNm4q7mr2gDxvmnI=; b=H+hHp0JUA2GU3GUU
	zRXzS4LMRSAPiZUXZnN490lt6zzNpe+nr+NNVcX9C6KKJVH0lTyb2KHh/3Im4FNP
	OeeyL9jeuzjVscN+YKeT5DhLcs3hdcSPZysAnaZiRSkvlrM6LHLfQkOReKnn6oHu
	FiloOB05RqjMVAu9KsUoEbAFZcvhmt1dX7gBCzpSaLR8efpRMTQNE59dq1OOlpaZ
	6NouzAYrUV9NwuS/6+3chRgAmOKlKjjCVaiCkj+Wmyjcp9yG8g//2IweeYnAt5FC
	lLuwkSjNFgntaSR6a2DUvYBeTaKF3yE8AV2HYz9rWeqj7wBxlb/blPraSt0Gw3eA
	+rz3Gw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429t5kjjw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G6venn006958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:40 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 23:57:38 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 10/11] wifi: ath12k: fix A-MSDU indication in monitor mode
Date: Wed, 16 Oct 2024 14:56:59 +0800
Message-ID: <20241016065700.1090-11-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241016065700.1090-1-quic_kangyang@quicinc.com>
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: OVx4hNHvpp13fwbmE7otaQ6Q_NoLlSKt
X-Proofpoint-GUID: OVx4hNHvpp13fwbmE7otaQ6Q_NoLlSKt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=951
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160044

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
index ed963ea2cb8f..1105c1a0da19 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -873,11 +873,11 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar, u32 mac_id,
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
 
@@ -900,10 +900,15 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar, u32 mac_id,
 
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
@@ -911,6 +916,12 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar, u32 mac_id,
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


