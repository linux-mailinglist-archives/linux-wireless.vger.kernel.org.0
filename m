Return-Path: <linux-wireless+bounces-21168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90C3A7CD73
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 11:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8844D3AC392
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3F11A238D;
	Sun,  6 Apr 2025 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQ7mBmdT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B8197A8E
	for <linux-wireless@vger.kernel.org>; Sun,  6 Apr 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743931346; cv=none; b=efo9KxTQUlNjl4xsUKIoVtw7dSZZwJcEYenpwRQFNtIhz3ZRM903WAc2B1VpXbG38eGKx3wIz6tHsip4kQqF0XoFtKK8HMmV8GSt5jVVlpuAbNUngEsqtcx2WafopkqJUj2udfuZybXoG9FoqXE8w2UToWTTBcQA11ZvgzFaRMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743931346; c=relaxed/simple;
	bh=/Ys/Hs/QmrXPBIsT+DPlIqfwEE9IVBSNE3HZQVHjefs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sa0S4TPrpzaC9Z76oksxoq6SS6JuztW/d1jF1p2pJgLXpSiBf/vvd83IVtTW+U9K8rTHzfOiGR8r4+CwSy/DbZLCXJCndo+adSu9LuOxkwSwU48xHmB6Z9ilzjYuqh+gEs9UI9B75k3s+fekjI+E0gETNzQGsIXuTAzopEq8GfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQ7mBmdT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5368c4uT028644
	for <linux-wireless@vger.kernel.org>; Sun, 6 Apr 2025 09:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xXzWxT+oGKX
	JZx0o2xs/CWZOfNKSx1HUdMCvVeJWg34=; b=nQ7mBmdThXxutPkKSTu74iNGDRn
	4DZAoX41fmSYlaPTdCXjJxyRr5AP2XX/+V5efYuXwzff+Sn3dF16eriPJOlWq9Ky
	haqnu6/40F/suz42ZrkyWGZQqK5VpU1sk30lSB81ljF7TqNoEZdQviGno6tdnLZy
	6AKJtjcwecyJRlSuXxBK+WjgUukrzIqvNuoqhZ+WuzKUX0xS2CqkHo5NYvvRUQ0i
	QWcpANhhW2Hp9QxUsV9kfINJvNa7kL8Ch08sPEmKQbq7+xWaF/8i9BLFWoo4V5sZ
	Ov+ZklXB5Q49zHg/z+IO3GgIx86MV3F3BnuIgPcBpkf6niOrIjRuBeG3U8Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpm1n4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 06 Apr 2025 09:22:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so2702847a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 06 Apr 2025 02:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743931342; x=1744536142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXzWxT+oGKXJZx0o2xs/CWZOfNKSx1HUdMCvVeJWg34=;
        b=QNMGGYGV6dLZ1HFCxCTbtMl6X70nBD/1KDbyH1/4HHdGRmPVDNOi9lAavsQqaqS7Rm
         vYruJYqjsBnbfFcweMkvmGNxZFGzaOvL9Fd4njp4jo6LeIm01Uhwn+MkWI4DXqqKL3xP
         9s0SSAw7oNwZ5iVv1QYhN3jYPRQ3qIsAG3i+fcV60A4uQ+NnoT3xKqYakoVphUDzAORk
         zUdB8AqKDyEfwDxRp3H+ykPoGH+IoxkbUCMoNKs9U1pYyy98267Ha8qpgGTn3ESJ6Vxh
         QM+7TxTB/I1S1pIe+zPmkrFBKYp8rpfERW/CsWOs+mke8CeoqM3OvGhDgUY2BlVL9EwW
         gCZw==
X-Gm-Message-State: AOJu0YwDY1MmxJFZSmcZIh7hRkmCdyBvUS/hyvBKF5bB8YbP8XbR3OZw
	53qgzhbKAyrrZGeQCoE+jZg8oyrVq9y05MpZNVhvBjgu5CEfjc5HnNrpsNWEqIN+CYp0TV7ooI2
	Er0VBKTIIjg4VqC/XAqpl2//jmcswjo9g5PQw1tQl1OebEh0PRAhz2KMunABUpggbaA==
X-Gm-Gg: ASbGncu/BMAOBlG4FcHh2jLXC88xqplEVze9pe/HmEUu6Yh42+VySdc5EiiNOobNKMR
	flrKQhzSX7YR3I3QeL1FElTKPhLMGkLNYT6AXLws6BQx5jK3vTlcvTKDw7n44EDO5IVSo77wyof
	x9h8cVknKYq4v1ZE4BgeRdFwUzJH3W4ynyGhitBTFGsL6wHPgX4u1rJ2XjycVQ6hih/6wjnORD2
	Bv8qlhC/plYb4PHYZmMms6SX/MtxSRyoSkA1cFnaByCETnhov6tDKmw6jNcbnpnS3WluczoVJP9
	CgyjubepujTDK60x/tqgYtvW4tFkA1BCzLjQ0kNlJ4xZr8DMuM93TCpyhCeDUrcyLYNhyDi9waI
	TFtMAMgOIysUVvdEGt5zITqUdmTPXtZdSu2B2V2tO5Wul
X-Received: by 2002:a17:90b:5690:b0:302:fc48:4f0a with SMTP id 98e67ed59e1d1-306a4dad016mr13562484a91.0.1743931342193;
        Sun, 06 Apr 2025 02:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr8nbRF2ZQZkdpKUsWLl6DTYywkCD18h7PoYYmapHbtyKrTk5yFQyxwumygYfBk8LRW8Geug==
X-Received: by 2002:a17:90b:5690:b0:302:fc48:4f0a with SMTP id 98e67ed59e1d1-306a4dad016mr13562462a91.0.1743931341716;
        Sun, 06 Apr 2025 02:22:21 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb5e75asm6857311a91.37.2025.04.06.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 02:22:21 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 1/2] wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers
Date: Sun,  6 Apr 2025 14:52:13 +0530
Message-Id: <20250406092214.3602182-2-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250406092214.3602182-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250406092214.3602182-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nPpd8f74nCR7EUECaIGy54E8mzwSJIRr
X-Proofpoint-ORIG-GUID: nPpd8f74nCR7EUECaIGy54E8mzwSJIRr
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f247cf cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=gym03wjq6zcI6pFnTcYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-06_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504060066

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
---
 drivers/net/wireless/ath/ath12k/dp_rx.c |  3 +--
 drivers/net/wireless/ath/ath12k/dp_rx.h |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c   | 16 ++++++++++------
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 48d907a400b3..db477f047c32 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1928,8 +1928,7 @@ static void ath12k_dp_rx_h_csum_offload(struct ath12k *ar, struct sk_buff *msdu)
 			  CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
 }
 
-static int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar,
-				       enum hal_encrypt_type enctype)
+int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype)
 {
 	switch (enctype) {
 	case HAL_ENCRYPT_TYPE_OPEN:
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 88e42365a9d8..78c0800e06aa 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -145,4 +145,6 @@ int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
 			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
 				       const void *ptr, void *data),
 			   void *data);
+int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype);
+
 #endif /* ATH12K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b19e30d95560..a1e5d94b400d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4677,8 +4677,8 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
 		arg.key_cipher = WMI_CIPHER_AES_CCM;
-		/* TODO: Re-check if flag is valid */
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV_MGMT;
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
@@ -4686,12 +4686,10 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
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
@@ -7098,6 +7096,8 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info *info;
+	enum hal_encrypt_type enctype;
+	unsigned int mic_len;
 	dma_addr_t paddr;
 	int buf_id;
 	int ret;
@@ -7113,12 +7113,16 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
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


