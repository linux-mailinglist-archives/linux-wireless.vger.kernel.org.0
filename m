Return-Path: <linux-wireless+bounces-36280-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EK4D2SPAmryuQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36280-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:24:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AC7518EB8
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F9883038F54
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AAC35E940;
	Tue, 12 May 2026 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eo9tHR3A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iMzdyfjc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B13630AC
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552643; cv=none; b=qAV2ZD5NzczeoaFtu5Y+WhB18+44/ntf/LoVBi5SmSVHZbRKq4+U+Ufj1NBWm+q8hkZA5sg0/oPCoRjaQyMzb48AiWyVnOvtauI57PllagFb6DR9oYcG8DuraHTIFGYspBEMrF3OQqvdD+9Mgg2G5qx0VF+p9+Yi9Dgb7tmuu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552643; c=relaxed/simple;
	bh=ExgOHaVKcNUPGCyLrKtdzPOXtp8E34JaZXanUGoXV0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3Qy/y4uGITTZk9Ii0H33nClTi+WDb84gCYHsajfu1gxVpu9Ulaz9uPgM8btPFAR7hzlVbTcQYC2TYhmiiKBQPddZVLHxnrlt0G5z76hqIGzNuIYnS/uJJ+/Q2EwFt20eKZQy/OSUXc6ewTMVIUB+Jhz6B42ZQLno62advpvZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eo9tHR3A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iMzdyfjc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6hrL2803762
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vHuEOWTWgku
	FCgRCml8bt7nPD8/09L3zu8ijOwpUPws=; b=Eo9tHR3AVszig8PXZK7//OygSEa
	mfAMvqEh2o8mzVDkFu2ZbTUxZv/96QNGEf3SOoD/meaaAsnMP+y5hkcl32RvFqAP
	XSFA7IbkYxFNstTOzZeJf6FersXOmLvkdRBH+EvYRFMbfnKHn3hkcbMgr7B8AvLW
	fawyVruhB2uTuPialscJaE8Roog6lHxMEyRsAcem0cleEwUE0ttpqzPXfr66nNWx
	gBxes5lVGU6eQ5NjCh8M7TMKFLafwpABlpzSyWdLJYeIrDac/vmU2GpUjMSJHpDq
	688/qyKkRWZ5fNMQNETXD3XysXg2Mp0tfjD/Qjc28hcXA3PKl5Ta9dmz1SQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv393kc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:24:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa860e71eso2743196b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 19:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778552640; x=1779157440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHuEOWTWgkuFCgRCml8bt7nPD8/09L3zu8ijOwpUPws=;
        b=iMzdyfjcWoNd6X7Kr8HusTbR1J/+S/1UvyX1LzigzNZZJ+VHs9BGoTudytmFSLLv2H
         j6aQ37qGWL6dMArl0RQagc6t/TEr/P+/fAtG7Kq6YMEfWIOb5tbjQWo2FSvvZUUJbsFh
         +ardd3al1ajPhTtpVKn1pVSPRe8+wlZ+FVjtCtF0u5mF6AT+bgUf1+reacV6Ge0mJwvk
         myxFIL8tY91XbNlQg9J7/dFo/UGZp3UiB2pvoV8bMf6kCffVWmYCNiNAPZRJvNLF8YsV
         Ooq2+rjZcRLNboTZUFjoOUj5/Jqu93yKQmPwFcbTlaTbPIFzPCka79K+rI0pbwKvEiMv
         hKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778552640; x=1779157440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vHuEOWTWgkuFCgRCml8bt7nPD8/09L3zu8ijOwpUPws=;
        b=mUNcqvSN9joI8+Ep+8UhIwvSKLG1tuFXUwafMHhmnE0vXorRiRBpAgG1kbKEJrUg2N
         YBQxPtlxpfpTVtVR2KKyVAwBNN18yifMrI7Q2wPeVf9fhBXLVN30kuQ1RKChZnaK4qP9
         giI0f4m4ZRP19VkGjib9kaRBuM1MHl12ILEl7RZVfWdG815Mst0zW/Af/1vLjQfWDPiW
         nuE51BBHXte08VsSHIFxj06u1+5E+7+H6uSaOTdtJWHVlBslplbCUr1c1mhxe6NqW4C3
         Ou5L/FQTDgTflj7bPp0YRXq4KXVV9cOqfb8KzpAnLL2QR5AHI+fJT9+CBlvffrnZKKMV
         Furw==
X-Forwarded-Encrypted: i=1; AFNElJ9Czb1p6uRvxaAqgGITCIGLi8BqA8eVBmYOT24XgQg2cFXnSCCblnQ+0nPtoF7nuFsR/O0GWyXfFFiUQT6Fcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XM+bHrKXiaBbk7sXG0Es9yGueJBIrosDXo7tAQRVuO5+88E4
	xIKnjKIcs4Vr9IgflARUtUk/VRv/GBlIEZLtUjaZhw2CTqOaU/t8GQOauYXtHNFJn3FRQ/rF1Vr
	Ay0GnjO/5aWMPSsFqsXkW/iNUm+AkrN1iuFp6kauCQ+Dp8d8HrqBKEyVLAKHnKxe6KZH5dx3kYO
	BFuDeL/p4=
X-Gm-Gg: Acq92OGDazzG5gbyml6nWYHcmPXSsk8F6TVUD2gqDQg8XHzGg7ys1bZAH9AuaRQCJNp
	VuQeuaZ+BazhOqWVMkhE1GbrOIMgQ995b4ndpSuqf8Sajb9M33vLB/lVIuDr0Ibrl9UqYiHkVNl
	XyRwyog1hag6mg6uaGJeWVzB0nsI0NvzIoBMpa3aOiQ85ITvd4b5qjrVFlKVT0ev2/I96C9GdNL
	qt3B6o9T5H5GZOnl7Wu5FWSoyfl2nsVecruMEx9FKG/O+ucgLMsZ/+a+/WzlnYbth0EFkX1v6NP
	CzPlZYTQYXrs+kBKL80R8qZ6V6XZqcAxJvsXof3MgSKZSi2uq35i7hidKIY1Itj5lmjqprAJ7Uc
	DrPQDhBbCDGMa7rfrP2FneSLmo181Zqu6hT1YX4aT1qHWFixVjpwfsfG9uUOVuRtIhsZRq9KiiZ
	i+e8bg
X-Received: by 2002:aa7:9314:0:b0:82f:5d4f:7355 with SMTP id d2e1a72fcca58-83eebc2c657mr972670b3a.33.1778552639860;
        Mon, 11 May 2026 19:23:59 -0700 (PDT)
X-Received: by 2002:aa7:9314:0:b0:82f:5d4f:7355 with SMTP id d2e1a72fcca58-83eebc2c657mr972652b3a.33.1778552639338;
        Mon, 11 May 2026 19:23:59 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf16sm25199256b3a.40.2026.05.11.19.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:23:59 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 1/2] wifi: ath11k: fix invalid data access in ath11k_dp_rx_h_undecap_nwifi
Date: Tue, 12 May 2026 10:23:50 +0800
Message-Id: <20260512022351.2033155-2-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
References: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyMCBTYWx0ZWRfX0eUKF4G6y83W
 svzO4f0+ExQ1zZtsD9wvet25wehNiAyOdDghIkERjKuxhfpnCxuteD+esOlvFaUpf/PahXPPW8w
 imNLAneOGRHeBqQy1bRmaa9bKpL9aY2gzviPrI/KvIbpl4Yb7IVscUKtT7FUe52jDTK2DNSKwfG
 /5vGEAy0t8b4HAc5+USqv2b01BVsZJKyBpwyUC7SvcBegvD/vbSfLaH4b8Zj4e+FbURpE4oXKfS
 yfkuA/+hUbMFgtDajrAlBWGt/oMNFWoH5KxRPmXvWaWRZl7djBmtrnAcUyZt5ce/ZdElur4UgWM
 4fhFt9OPmaf06ewXRMMePaFEyV2NhFlz+n1peABrXxS+uj9y0NXyEsA+tnUJhMRXEhGBFKsNfYq
 73TTu1lWT4tUjJoKqX1EP6gwDgu0z/k/YSxvN5mqG8PtBAfadjjhjqyE4b2KdF+4Cg44Cv2i1jY
 CeYPMVqO/g5iCk4HMoQ==
X-Authority-Analysis: v=2.4 cv=Kvp9H2WN c=1 sm=1 tr=0 ts=6a028f41 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pyFkC3i_6phWDu-JDTMA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: ysC_i7YFAhTS4iCTsK7JyyZJLnBTPxW-
X-Proofpoint-GUID: ysC_i7YFAhTS4iCTsK7JyyZJLnBTPxW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120020
X-Rspamd-Queue-Id: 98AC7518EB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36280-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

In certain cases, hardware might provide packets with a
length greater than the maximum native Wi-Fi header length.
This can lead to accessing and modifying fields in the header
within the ath11k_dp_rx_h_undecap_nwifi() function for the
DP_RX_DECAP_TYPE_NATIVE_WIFI decap type and
potentially result in invalid data access and memory corruption.

Kernel stack is corrupted in: ath11k_dp_rx_h_undecap+0x6b0/0x6b0 [ath11k]
Call trace:
 ath11k_dp_rx_h_mpdu+0x0/0x2e8 [ath11k]
 ath11k_dp_rx_h_mpdu+0x1e0/0x2e8 [ath11k]
 ath11k_dp_rx_wbm_err+0x1e0/0x450 [ath11k]
 ath11k_dp_rx_process_wbm_err+0x2fc/0x460 [ath11k]
 ath11k_dp_service_srng+0x2e0/0x348 [ath11k]

Add a sanity check before processing the SKB to prevent invalid
data access in the undecap native Wi-Fi function for the
DP_RX_DECAP_TYPE_NATIVE_WIFI decap type.

This adapted from the discussion/patch of the ath12k driver [1].

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Link: https://lore.kernel.org/linux-wireless/20250211090302.4105141-1-tamizh.raja@oss.qualcomm.com/ # [1]
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 50 +++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index fe79109adc70..fbe2061a544d 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2502,6 +2502,29 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 	ieee80211_rx_napi(ar->hw, pubsta, msdu, napi);
 }
 
+static bool ath11k_dp_rx_check_nwifi_hdr_len_valid(struct ath11k_base *ab,
+						   struct hal_rx_desc *rx_desc,
+						   struct sk_buff *msdu)
+{
+	struct ieee80211_hdr *hdr;
+	u8 decap_type;
+	u32 hdr_len;
+
+	decap_type = ath11k_dp_rx_h_msdu_start_decap_type(ab, rx_desc);
+	if (decap_type != DP_RX_DECAP_TYPE_NATIVE_WIFI)
+		return true;
+
+	hdr = (struct ieee80211_hdr *)msdu->data;
+	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+
+	if ((likely(hdr_len <= DP_MAX_NWIFI_HDR_LEN)))
+		return true;
+
+	ab->soc_stats.invalid_rbm++;
+	WARN_ON_ONCE(1);
+	return false;
+}
+
 static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 				     struct sk_buff *msdu,
 				     struct sk_buff_head *msdu_list,
@@ -2572,6 +2595,11 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 		}
 	}
 
+	if (unlikely(!ath11k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu))) {
+		ret = -EINVAL;
+		goto free_out;
+	}
+
 	ath11k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
 	ath11k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status);
 
@@ -3261,6 +3289,12 @@ static int ath11k_dp_rx_h_verify_tkip_mic(struct ath11k *ar, struct ath11k_peer
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
 	skb_pull(msdu, hal_rx_desc_sz);
 
+	if (unlikely(!ath11k_dp_rx_check_nwifi_hdr_len_valid(ar->ab, rx_desc,
+							     msdu))) {
+		dev_kfree_skb_any(msdu);
+		return -EINVAL;
+	}
+
 	ath11k_dp_rx_h_ppdu(ar, rx_desc, rxs);
 	ath11k_dp_rx_h_undecap(ar, msdu, rx_desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, rxs, true);
@@ -3953,6 +3987,10 @@ static int ath11k_dp_rx_h_null_q_desc(struct ath11k *ar, struct sk_buff *msdu,
 		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 	}
+
+	if (unlikely(!ath11k_dp_rx_check_nwifi_hdr_len_valid(ar->ab, desc, msdu)))
+		return -EINVAL;
+
 	ath11k_dp_rx_h_ppdu(ar, desc, status);
 
 	ath11k_dp_rx_h_mpdu(ar, msdu, desc, status);
@@ -3997,7 +4035,7 @@ static bool ath11k_dp_rx_h_reo_err(struct ath11k *ar, struct sk_buff *msdu,
 	return drop;
 }
 
-static void ath11k_dp_rx_h_tkip_mic_err(struct ath11k *ar, struct sk_buff *msdu,
+static bool ath11k_dp_rx_h_tkip_mic_err(struct ath11k *ar, struct sk_buff *msdu,
 					struct ieee80211_rx_status *status)
 {
 	u16 msdu_len;
@@ -4005,6 +4043,7 @@ static void ath11k_dp_rx_h_tkip_mic_err(struct ath11k *ar, struct sk_buff *msdu,
 	u8 l3pad_bytes;
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
 	u32 hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
+	struct ath11k_base *ab = ar->ab;
 
 	rxcb->is_first_msdu = ath11k_dp_rx_h_msdu_end_first_msdu(ar->ab, desc);
 	rxcb->is_last_msdu = ath11k_dp_rx_h_msdu_end_last_msdu(ar->ab, desc);
@@ -4014,6 +4053,9 @@ static void ath11k_dp_rx_h_tkip_mic_err(struct ath11k *ar, struct sk_buff *msdu,
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 
+	if (unlikely(!ath11k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+		return true;
+
 	ath11k_dp_rx_h_ppdu(ar, desc, status);
 
 	status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
@@ -4021,19 +4063,21 @@ static void ath11k_dp_rx_h_tkip_mic_err(struct ath11k *ar, struct sk_buff *msdu,
 
 	ath11k_dp_rx_h_undecap(ar, msdu, desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, status, false);
+
+	return false;
 }
 
 static bool ath11k_dp_rx_h_rxdma_err(struct ath11k *ar,  struct sk_buff *msdu,
 				     struct ieee80211_rx_status *status)
 {
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
-	bool drop = false;
+	bool drop;
 
 	ar->ab->soc_stats.rxdma_error[rxcb->err_code]++;
 
 	switch (rxcb->err_code) {
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
-		ath11k_dp_rx_h_tkip_mic_err(ar, msdu, status);
+		drop = ath11k_dp_rx_h_tkip_mic_err(ar, msdu, status);
 		break;
 	default:
 		/* TODO: Review other rxdma error code to check if anything is
-- 
2.34.1


