Return-Path: <linux-wireless+bounces-21565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2BBA8A8A9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 21:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4441891C0E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B1421B9D8;
	Tue, 15 Apr 2025 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U6XGGY0t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7591231A32
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744747130; cv=none; b=hKJKZdma8TrMUzHdir6923WkcSJkt8TBzAfVlnMhL++dPk6ABiF0XTUnRJqKIlv1nj/arJYUOR3SmFc3+rnxlQPaEWrtZ1TIJ85xdeRZ5Dc6t41jLR6P7oWGCGnXGJo18wG0+FitoPKDL10RrrBCbSt3Bm6huiWyDvdZ9Xljh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744747130; c=relaxed/simple;
	bh=pCnRjzKySqVQqB1zOTFCCDEAzZtYSGJjyQO8RMS6xlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaiNLklPUzse8ZpVLWfcD6tlFcILUlppIhYfpX01VVd2+TwA4LCzxZDPWs0yCgx4h6IR7R5tHYrfO8YGjd/nvKVe6PPTk6QWIcjlT/l5bdJxx0akoE379eG8d4QkMUvITGa3AIw2MSugsuzxBQb9SJzWyKBDQ6FY5LFTehWqUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U6XGGY0t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FIsvdV002435
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=08yO9bZX4ip
	/nKeL9Yu+eSgLY0HMzS6FnQY5A6qKGIg=; b=U6XGGY0tFwBKeMoPUlnC9f/BVla
	GraO6nbzbHGBPMUqZa9i1jx5aWdxEvfM/yWMFnZU77w1zK37wmZOgOceE7Q7NB6W
	zKdkicjygp8PzkwFIs5na4gF7FcjIZmN5SrlSgLRln5Sei0Qgmggk/1Yrab3qQ+O
	jm+FsSzI75G+rbup8xybWxT5JvfBdaHr3JNJA+1m5oUooraqR+3Rj7NcEM8pDKl0
	WWS4MwgxXW1503oPU4imRsVyXElUY53MymS2KutSVlQsu7ZqwclHwUcHMgiXUNZL
	haZJvqHC7VjqhYmSbOXJgLj8sPxR/07D4CkYUvi9cfCAV1hGvOGhudWAfRQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk15gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:58:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so4828165a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 12:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744747127; x=1745351927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08yO9bZX4ip/nKeL9Yu+eSgLY0HMzS6FnQY5A6qKGIg=;
        b=LIL/tK7YC/C+3GsBz1N3xTwU47IOIbBUN1mRCU+udL0iz6PiNhpmehreIC9Pvcb1x3
         zj4eciO2lulIfFIPzhPuRqGqVq1QgkHmkUD8xr1d7SG5jR/7wbJq0oTyX5NQtKcyp35M
         f3KHpUdg9hDaPwaeczmicrKwkRJYCS6LYt+YmsDv+AgYBZzDC4S35qyIPfO8xnO1i+FC
         ZKjz8+2dPbpoxnKKRhqXH/MjYgh7mVYYn/K647/nlTVF8CG9bgSlmqzpXTxThoaJJPza
         Ywi9ayOTsgkCmj58X8Fhc+3ec/WShHr8XGo0bkKkKiTG3NO7I1EryhemyZtaqvGUBd+e
         /TrQ==
X-Gm-Message-State: AOJu0YwsMrLZ7PBzr+O89awCbmSAKhX1mT5NJJE33kvSM5jWlS59nVOk
	+KVMPwsFCojRB1lA9aL+KV+XbhlMl0GYnMNAO4+WIRTStzVsYLZiv6roBtebR0ifm1CS8/t+i6X
	EuEu09bepqUAqd9ciqntYMUa5m4E8vKZ4ACRsj/FiQ+GZZuK9boE2hZCz2l7GvC298A==
X-Gm-Gg: ASbGnct1WX8u4RXGsa91jWaoLRPkCsPVpI9vB5dBMqLMjsmd5MmH5BDwqJF3SJZDkHU
	ah3Awz02q9ZGy42mn8/wSBx+Drd0GFeiHNN+gon8q7tOlDNVem2eD4iWTmwY4UG7bj65b7qDgmi
	ioEOGgKd0QV6cduC+clckgzJSz7ltHAAUC/EAe9ZsNTALrR9hH3fCpFmXdXGqSkudvJTFDz7jkF
	ZDkU/b53WNX398ikv1pWD9TIpt24il6aNHO3gcaoLKHPKjUhfRRta7JC8daz46t1nrHwCauhcxk
	mIPQz0uP4ogcX/fsNI+qXOUR7jTW2a2oVv1Qbyv2z0I+jKvO6Bn1N1fDEDYG2gmgs55h1iyLM6/
	hni3V6ePa18KV10nFmHwKTSXPjRMB78twx/dIiowr
X-Received: by 2002:a17:90b:4c43:b0:301:a0e9:66f with SMTP id 98e67ed59e1d1-3085ef1dbbamr766732a91.14.1744747126791;
        Tue, 15 Apr 2025 12:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfEZT644CddK0S5AW+e5KbHsbVh4dlSq52bTMb7pvWhPv9+0RgO5exJW8T0cN+4dbMmnUEAw==
X-Received: by 2002:a17:90b:4c43:b0:301:a0e9:66f with SMTP id 98e67ed59e1d1-3085ef1dbbamr766687a91.14.1744747126396;
        Tue, 15 Apr 2025 12:58:46 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8ea61sm121626265ad.103.2025.04.15.12.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:58:46 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2 1/2] wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers
Date: Wed, 16 Apr 2025 01:28:11 +0530
Message-Id: <20250415195812.2633923-2-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415195812.2633923-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250415195812.2633923-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=67feba77 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=hR7Trk4nSUdV9dTI32cA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: bKpzCoL4MvD9IBLejzpZNX-BLWDpI5Kp
X-Proofpoint-ORIG-GUID: bKpzCoL4MvD9IBLejzpZNX-BLWDpI5Kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150140

Currently for CCMP256, GCMP128 and GCMP256 ciphers, in
ath12k_install_key() IEEE80211_KEY_FLAG_GENERATE_IV_MGMT is not set and
in ath12k_mac_mgmt_tx_wmi() a length of IEEE80211_CCMP_MIC_LEN is reserved
for all ciphers.

This results in unexpected drop of protected management frames in case
either of above 3 ciphers is used. The reason is, without
IEEE80211_KEY_FLAG_GENERATE_IV_MGMT set, mac80211 will not generate
CCMP/GCMP headers in TX frame for ath12k.
Also MIC length reserved is wrong and such frames are dropped by hardware.

Fix this by setting IEEE80211_KEY_FLAG_GENERATE_IV_MGMT flag for above
ciphers and by reserving proper MIC length for those ciphers.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c |  3 +--
 drivers/net/wireless/ath/ath12k/dp_rx.h |  3 +++
 drivers/net/wireless/ath/ath12k/mac.c   | 16 ++++++++++------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 96785d60d671..f7cb1a17d6f1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1939,8 +1939,7 @@ static void ath12k_dp_rx_h_csum_offload(struct sk_buff *msdu,
 			   CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
 }
 
-static int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar,
-				       enum hal_encrypt_type enctype)
+int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype)
 {
 	switch (enctype) {
 	case HAL_ENCRYPT_TYPE_OPEN:
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 19fb41e1c32b..f5c05f17813b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -163,4 +163,7 @@ int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
 			   void *data);
 void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab,  struct hal_rx_desc *rx_desc,
 			       struct ath12k_dp_rx_info *rx_info);
+
+int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype);
+
 #endif /* ATH12K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index dfc803879028..aaa02d3d0f95 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4719,8 +4719,8 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
 		arg.key_cipher = WMI_CIPHER_AES_CCM;
-		/* TODO: Re-check if flag is valid */
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV_MGMT;
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
@@ -4728,12 +4728,10 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
 		arg.key_txmic_len = 8;
 		arg.key_rxmic_len = 8;
 		break;
-	case WLAN_CIPHER_SUITE_CCMP_256:
-		arg.key_cipher = WMI_CIPHER_AES_CCM;
-		break;
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
 		arg.key_cipher = WMI_CIPHER_AES_GCM;
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV_MGMT;
 		break;
 	default:
 		ath12k_warn(ar->ab, "cipher %d is not supported\n", key->cipher);
@@ -7153,6 +7151,8 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info *info;
+	enum hal_encrypt_type enctype;
+	unsigned int mic_len;
 	dma_addr_t paddr;
 	int buf_id;
 	int ret;
@@ -7168,12 +7168,16 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 		return -ENOSPC;
 
 	info = IEEE80211_SKB_CB(skb);
-	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)) {
+	if ((ATH12K_SKB_CB(skb)->flags & ATH12K_SKB_CIPHER_SET) &&
+	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)) {
 		if ((ieee80211_is_action(hdr->frame_control) ||
 		     ieee80211_is_deauth(hdr->frame_control) ||
 		     ieee80211_is_disassoc(hdr->frame_control)) &&
 		     ieee80211_has_protected(hdr->frame_control)) {
-			skb_put(skb, IEEE80211_CCMP_MIC_LEN);
+			enctype =
+			    ath12k_dp_tx_get_encrypt_type(ATH12K_SKB_CB(skb)->cipher);
+			mic_len = ath12k_dp_rx_crypto_mic_len(ar, enctype);
+			skb_put(skb, mic_len);
 		}
 	}
 
-- 
2.34.1


