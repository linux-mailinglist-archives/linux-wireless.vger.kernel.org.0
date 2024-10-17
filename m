Return-Path: <linux-wireless+bounces-14128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2502F9A1931
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 05:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFC4B250DD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 03:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD367E583;
	Thu, 17 Oct 2024 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bPZD30UC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1213AD06
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134702; cv=none; b=Y9wMFlnBUaVLhpEUUPmluLs2QioSii3lj7sMN1TY5D24xMc+I/gTqA0oh9mjJD0vVe2SGcL4CINvg/GYJs531KjShfoJI4KtIup6Fm1BeKO0xkMvNoMKMNanSHDkNmlWOpasfPeRbsp0EttdrLhHDLrNLcqHIqNsywb9DQAK9M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134702; c=relaxed/simple;
	bh=8v4ScUY18pOpcpLCil17VfcStYgsTp1wE03ROWYulM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7jk/mN37TobhYGYx3h7lEvf1MalM+WBq5QtMZjOGjtBc+jlmczsoaa2urHICmix5mG6csVMhcbwHpm/ZczEKOqAPbR3UtYv2rubRWv1RtPSNSEi7tnKNVl8z2dGnKlDjF9QRZ/TvQA5sGIrx+0pK2yudrUF+Ca3f/mUoBZqNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bPZD30UC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GFopJs002357;
	Thu, 17 Oct 2024 03:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dv31Dft1u9+cntKlhDh62mu6SyaHorgNbrWTeE1nTUE=; b=bPZD30UCWx4g2/GR
	/LTJUccevG9z+hWmSDIVKa9yybMC5V/+2DOMPXETE2dY7nkyckVGfjWaBryxZxlS
	Ux8dLgH1Xu6FnYfiUG0BjqtJXd+AhhiuL8vbUXlQB7zC1qs58jgtLc5FjzxYo4bP
	M6gT7AgwrZBWgs35WTiVpg3FYD9A4HaHW5eSEqSTYN6btdUQbX2hH5iSVaP1NNN8
	yxSXrqjtEN0B7I8fCn4vDn4/RMnHCet+N+ZulRiYIFZg6PndoPaCmcFXc+TOJ1Ao
	9aOSk7HLOo8r83uhoZFen75j9KM/fMlKsEEl8RFD/uJt/wQXQGCwVp+jN+6q6Jf9
	/XHIZA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a5xykkt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:11:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H3Bcku030707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:11:38 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 20:11:37 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 10/11] wifi: ath12k: fix A-MSDU indication in monitor mode
Date: Thu, 17 Oct 2024 11:10:55 +0800
Message-ID: <20241017031056.1714-11-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241017031056.1714-1-quic_kangyang@quicinc.com>
References: <20241017031056.1714-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: PWullOR_7GzzJWwBd5CKw6FT6Xbv1aB3
X-Proofpoint-ORIG-GUID: PWullOR_7GzzJWwBd5CKw6FT6Xbv1aB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=951 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170021

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
index 42181652bfd9..bf50c90f4c40 100644
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


