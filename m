Return-Path: <linux-wireless+bounces-32275-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPXtJucboWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32275-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:21:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944C1B29F7
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 963E3305FC6C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5497355039;
	Fri, 27 Feb 2026 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HXPbOW/E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yktfpo41"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53657354AD8
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772166116; cv=none; b=HknwnUdLhV9RB7M7kt3Q9fOSQbwKa9MHuPkJE01wsTNrQG/CXjZIWvab6vDFdxZZRnhmoE1z70tckkrI5w5o8ITnK6k+TK5sICGq8IcULzYGpc+LcVQtD3qaw4D/DrqkBWo/vvLXmkB3BCX31UH3n1Hnk7m+AYAluGM+QCT2lpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772166116; c=relaxed/simple;
	bh=Q+VQCyGd4PAdwks3R9BJJKJTqHHRdTPeYr0wyLCO4K4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C5Bi7vF88+EEok+KVCxcIubaF4WgTYX9sXVQW/r2mbzCbtYszjhBu3ON5JT6NzfsKMf47+lJ+SI38u+JI98NuxJ8Jp6fU3S29nmSyRdOWvYluQgAe+xh6Zw4Rl/WBHxhOxbfKrRnKQ1cK8VqEiVU062eWkXRaLuIPvKbrLd3A7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HXPbOW/E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yktfpo41; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2K1MR2353440
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ucnwCOp6De/roXp3UDRPA3fB1Exa4pLU72x
	SjX0GZwg=; b=HXPbOW/ES15KXopwzYWlcYV/hEtXaAN9qOczNpu1ANa5Da+DmJo
	i4wowYcrP2fL/45ppNP7GjbFmzEz2C/0UmwoHL26w7h1J/junBsawStI3jNoFSIH
	a+16AcEdLizp2TPDj6MjgMUTlJoZAQ/+1pU+42cRWD5zs57TUd8kyJkISPQ09foo
	1dMc96e1yghWqk5wtVurLprYrS6md4m1xaKKhw+EJlWrrnUq0DIKBh+TPNll/lRp
	ruN6tP1NAcRU47JVvo+1KkpNthZ0oHSFF4zxhH90R16+KM3hv7dEVanUvKIuP/xf
	0Yh6tpJV8QP0T+bejtNzczOGX6FT1D0Kd1w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjm8u381k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:21:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad6045810so15787525ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772166112; x=1772770912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucnwCOp6De/roXp3UDRPA3fB1Exa4pLU72xSjX0GZwg=;
        b=Yktfpo41c2cpWrbmiHOCDSON6ahhdMKAPjRbVdf6ggerrTjpoQ3pkjV6YOX9cEh73Y
         6C80VEcNNWD+AEH9vZVQPPCRDozRPQVlsemSfxEBqRQnvM1FIx7hkcpcCbfyW6IIzutg
         ineZbM0OxcMGLOFH/bEtdBjOmT2MGECEOU7L49ntUZpQthTPxtPikdNQdBINLktYKuw8
         5DiLQCom5HiG+YIlJ75xbeRsNYWfPIxm4eBH6Bykgh8x0c8ippjdKPTgtjKf3GN9/nuP
         foLD3zkkntn35gMn+4VPZZJ2SQhzIGIsCRMO9reUIspy5Mu807Ilf0k5EuLYWmoOAyXQ
         IxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772166112; x=1772770912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucnwCOp6De/roXp3UDRPA3fB1Exa4pLU72xSjX0GZwg=;
        b=SpfJqPDyELC2fI12fg8N6MEOrbfpywI7JRi64o+tB3PwshvmWHfFYjpawiaFLBH3Sr
         r5xjRu/6iOb0y+6EqNw4FWbRXnZjoQEYl9p4GIFPX70oUH0caBFPyJLyvbs1bLNNf6T8
         G9h0GGXt7TjBdySZa+6T9OSPXFWNvmzKr3UXqS1SEPGr7E43+3Oc8zzUDbELvnxRhk9w
         CEWmZZUVdjIYjUQx8vWZ/d0iuJvbcZhwCPZclo8uXy7BDuOboFsMgO6Ggm3ibEGMoh8B
         E6+8UGCvMrydIojkHtFaceuP1XCtc0853NdHE5GTaIZN7+4ETJqOefMaC63mb67/Y+6G
         2Xnw==
X-Gm-Message-State: AOJu0Yz712rnnmNFPHG+IAMnWmOe8iqgbI56iqK7rT2WjpVQ1YI0xFac
	aOwCSBNb6qb7zbb+YEhTgQEBHln3iiQdDcD04ccQY73J3uP+LtHJXlwjPxLiD99WbYOaHXysUL2
	9u6JV13Buvr51MnKeTVzzX8OftZ2aRW44K7pC8fTBFeObw9cZDTQz7PDkDGA0EMjHppNSKQ==
X-Gm-Gg: ATEYQzylr3UJ3a7R+wRw9YtmLi4wyh8nx4DLlr/GAfL5L2wEjxuRqVMce0clv7Oo0Ui
	UHji8aSqB4psUP3EEIY52uWskJoksf6P93jKa7oMgRZRH++bqiMBHDdGDKZlmZa7Hbcj2hr2m1h
	51N1y1KGlDFiyFhjq8RxLCu31/pBqhQrathgUOwqmHjd5IuZ26o3FqntS3Mj4dLOZ5OjXvgx68r
	57nqeP/EBkDxn8FjWI+VgNdpaJKdJeFKid88QzrwaZ6Aafnx+1SeoH/QZ/l8DnC9E4qUBruciqz
	Rq11k4XELG5+hA42cLEIgXOI4/4PATwzCLqQY6g7dUuEdQhVAQ1ndXHyRcZD3yRlqFgoqbVwlUC
	Q11r7ZS0a9PJxb98Sy9m+uUcKfsvaXnoDtzc5aGvJj7hTWGIiFp5W8/QbKibKzmLNYEaP42Ez/K
	/3OKfbepl6IuD7NBWkQlF4Gysy/uT48ic9OpKSgUrpqS3FSBTU9GCfpkk=
X-Received: by 2002:a17:902:d485:b0:2a8:f8bd:bb72 with SMTP id d9443c01a7336-2ae2e4d7357mr14002975ad.50.1772166111832;
        Thu, 26 Feb 2026 20:21:51 -0800 (PST)
X-Received: by 2002:a17:902:d485:b0:2a8:f8bd:bb72 with SMTP id d9443c01a7336-2ae2e4d7357mr14002685ad.50.1772166111284;
        Thu, 26 Feb 2026 20:21:51 -0800 (PST)
Received: from hu-periyasa-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c1af1sm56791735ad.27.2026.02.26.20.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:21:50 -0800 (PST)
From: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Remove the unused argument from the Rx data path
Date: Fri, 27 Feb 2026 09:51:28 +0530
Message-Id: <20260227042128.3494167-1-karthikeyan.periyasamy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAzMCBTYWx0ZWRfX9i14si71sovV
 jDygthz2R8+iRezAhOjWjXD5U3diKIL13fqOoign3mcPVTYMayrQBHOGh1jSONKf6GCW8iUeDTe
 heNyhjl83+hqnJriSbAwaznu1tvtJkpx4m/Bx919AOXyDnNYEA99Bo4JrN9WReA3jZovdBeE+Fz
 DEDSCIZzy7ptMyoDq8L9j5kumv2vnorGX9gtZs0i6/HMXSIVtYd1YANot013Nxm4gHWKVBmhZB2
 QUCSOuxfzT7XeIULLUxHeA9B7jF+6tFGEL4UDYYm9v1WdY8ctvzo0HBF/loN1CTmOABn5o5KB+N
 57a9SfXq7gaGrDeQ4mr6ktpf6XTtgwLWrUKmkDlbuz2Cp9PwCmEJsNALLrUp/fua9jjP0UsJKhq
 PNxtrz3NNpAE/kIwBRt//oLsObbqV7mGQYV2b6BPIhgURUUwrzmZwWe4tp6Wg5gPKyVZJqKrmRQ
 /cdganM8O47TZYSHPjA==
X-Authority-Analysis: v=2.4 cv=O780fR9W c=1 sm=1 tr=0 ts=69a11be1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=wAaFTtMVbGzhZbg6bA8A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: sOGr1NXmUvJqyT_oN41d46ZdPjKiODb8
X-Proofpoint-GUID: sOGr1NXmUvJqyT_oN41d46ZdPjKiODb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32275-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.periyasamy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0944C1B29F7
X-Rspamd-Action: no action

Currently, the Rx path uses new infrastructure to extract the required HAL
parameters. Consequently, the HAL Rx descriptor argument is no longer
needed in the following helper functions. Remove the unused argument from
the following helper functions.

ath12k_dp_rx_h_undecap()
ath12k_dp_rx_check_nwifi_hdr_len_valid()
ath12k_wifi7_dp_rx_h_mpdu()

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  2 --
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  2 --
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 25 ++++++++-----------
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index a32ee9f8061a..c0e2b2c1a292 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1117,7 +1117,6 @@ static void ath12k_dp_rx_h_undecap_eth(struct ath12k_pdev_dp *dp_pdev,
 }
 
 void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
-			    struct hal_rx_desc *rx_desc,
 			    enum hal_encrypt_type enctype,
 			    bool decrypted,
 			    struct hal_rx_desc_data *rx_info)
@@ -1393,7 +1392,6 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 EXPORT_SYMBOL(ath12k_dp_rx_deliver_msdu);
 
 bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_dp *dp,
-					    struct hal_rx_desc *rx_desc,
 					    struct sk_buff *msdu,
 					    struct hal_rx_desc_data *rx_info)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 1ec5382f5995..bd62af0c80d4 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -189,7 +189,6 @@ void ath12k_dp_extract_rx_desc_data(struct ath12k_hal *hal,
 }
 
 void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
-			    struct hal_rx_desc *rx_desc,
 			    enum hal_encrypt_type enctype,
 			    bool decrypted,
 			    struct hal_rx_desc_data *rx_info);
@@ -197,7 +196,6 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 			       struct sk_buff *msdu,
 			       struct hal_rx_desc_data *rx_info);
 bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_dp *dp,
-					    struct hal_rx_desc *rx_desc,
 					    struct sk_buff *msdu,
 					    struct hal_rx_desc_data *rx_info);
 u64 ath12k_dp_rx_h_get_pn(struct ath12k_dp *dp, struct sk_buff *skb);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 7450938adf65..77a1679b41df 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -325,7 +325,6 @@ static void ath12k_wifi7_dp_rx_h_csum_offload(struct sk_buff *msdu,
 
 static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 				      struct sk_buff *msdu,
-				      struct hal_rx_desc *rx_desc,
 				      struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_skb_rxcb *rxcb;
@@ -388,8 +387,7 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	}
 
 	ath12k_wifi7_dp_rx_h_csum_offload(msdu, rx_info);
-	ath12k_dp_rx_h_undecap(dp_pdev, msdu, rx_desc,
-			       enctype, is_decrypted, rx_info);
+	ath12k_dp_rx_h_undecap(dp_pdev, msdu, enctype, is_decrypted, rx_info);
 
 	if (!is_decrypted || rx_info->is_mcbc)
 		return;
@@ -549,14 +547,14 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k_pdev_dp *dp_pdev,
 		}
 	}
 
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, rx_desc, msdu,
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu,
 							     rx_info))) {
 		ret = -EINVAL;
 		goto free_out;
 	}
 
 	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
-	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_desc, rx_info);
+	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_info);
 
 	rx_info->rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
 
@@ -1030,13 +1028,13 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
 	skb_pull(msdu, hal_rx_desc_sz);
 
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, rx_desc, msdu,
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu,
 							     rx_info)))
 		return -EINVAL;
 
 	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
-	ath12k_dp_rx_h_undecap(dp_pdev, msdu, rx_desc,
-			       HAL_ENCRYPT_TYPE_TKIP_MIC, true, rx_info);
+	ath12k_dp_rx_h_undecap(dp_pdev, msdu, HAL_ENCRYPT_TYPE_TKIP_MIC, true,
+			       rx_info);
 	ieee80211_rx(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 	return -EINVAL;
 }
@@ -1588,7 +1586,6 @@ static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k_pdev_dp *dp_pdev,
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_base *ab = dp->ab;
 	u16 msdu_len = rx_info->msdu_len;
-	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
 	u8 l3pad_bytes = rx_info->l3_pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	u32 hal_rx_desc_sz = dp->ab->hal.hal_desc_sz;
@@ -1632,11 +1629,11 @@ static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k_pdev_dp *dp_pdev,
 		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 	}
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, desc, msdu, rx_info)))
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu, rx_info)))
 		return -EINVAL;
 
 	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
-	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, desc, rx_info);
+	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_info);
 
 	rxcb->tid = rx_info->tid;
 
@@ -1673,7 +1670,7 @@ static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k_pdev_dp *dp_pdev,
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, desc, msdu, rx_info)))
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu, rx_info)))
 		return true;
 
 	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
@@ -1681,8 +1678,8 @@ static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k_pdev_dp *dp_pdev,
 	rx_info->rx_status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
 				     RX_FLAG_DECRYPTED);
 
-	ath12k_dp_rx_h_undecap(dp_pdev, msdu, desc,
-			       HAL_ENCRYPT_TYPE_TKIP_MIC, false, rx_info);
+	ath12k_dp_rx_h_undecap(dp_pdev, msdu, HAL_ENCRYPT_TYPE_TKIP_MIC, false,
+			       rx_info);
 	return false;
 }
 

base-commit: ff49eba595df500e4ddccc593088c8a4ab5f2c27
-- 
2.34.1


