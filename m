Return-Path: <linux-wireless+bounces-14319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054439AA0E1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 13:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A838B23083
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7309A19B5A5;
	Tue, 22 Oct 2024 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mQ3TvPy7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF119CCF5
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595350; cv=none; b=e8FWvTaPlCzQet76+O3yEyoWJ0ihRV/a1N45VA8LmI5c1xNn1tmhRRrAR6TP2HvZwcrzQcNKFYpnTwbOIKdivBNeCcpAJipGfHsEPGsngKKHHTfzNVKcXefJq6EO8yjvB8POTpVXyGfS5f2S6Jq0SR03z1VpaCXlW3XeYzaP8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595350; c=relaxed/simple;
	bh=FLg7c6GGfmlnDT8aK8R4uvhJVEZYghmgcBS9RIB8uOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0eEd/uD9b1+N53nH1pqBMJ1OWdRfn1wEIH8oIqkaR92eXX7nuyV5qvdepTVvyQ7azWNNF/rPSfQqxZlFLiKZw/eUkGpPqqJUymL0PQ/72lmjlripsRgtZBiY+BdNjopfBvGknLzkjKb2932URoZwz73VKoUuKs6ssSxJ+nVfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mQ3TvPy7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M9iJ0i014302;
	Tue, 22 Oct 2024 11:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q0e/1DQ9iO7llB/O8jGr3C9UiLV3+VUkWsWU1dwMqGU=; b=mQ3TvPy70tas/mn3
	OdtEie2O1B7eiT6SiiIQDQPheTs9D7iiJhJbmNITY7tgR+Utzo/TZMk9VL5vGAs8
	4xwsnMFOLNaNWB1CekRgfgDMalmyZIRLD6CuGMeh2yOz1IyeuyWjhD3nBekSGXtI
	sfW4hVGK0bqqPz/q5Ud2CTUHygNR/60J/vawN0UQ9Agynbj1JCnxlod8I3k9iXl0
	QIkJP1KU0jSg1Q20MMn+d2sBoT82O0qrhohHttQUqaAaOdqjYLOPi9nIZ66BSaDn
	kLxlKY/ByLCFfsz7XHtX4Hdws2FufoeCsFkf2jQBq8OXOiMjWTVW25xJbqnEn1fV
	b8MGmg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vv019j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:09:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MB94Tr011089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:09:04 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 04:09:03 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 8/8] wifi: ath12k: fix A-MSDU indication in monitor mode
Date: Tue, 22 Oct 2024 19:08:31 +0800
Message-ID: <20241022110831.974-9-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241022110831.974-1-quic_kangyang@quicinc.com>
References: <20241022110831.974-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tBovuBhM1Co_OIspnrdio3mrXWybBpTv
X-Proofpoint-GUID: tBovuBhM1Co_OIspnrdio3mrXWybBpTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=943 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220071

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
index 802ae5bf9efc..3322ac11008f 100644
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


