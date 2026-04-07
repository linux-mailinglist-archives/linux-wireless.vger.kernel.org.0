Return-Path: <linux-wireless+bounces-34425-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBLcNb6V1GknvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34425-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:27:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5786E3A9EFF
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAFC43028F53
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A363783DE;
	Tue,  7 Apr 2026 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YhvDUgz6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GJAAFEHA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F63378D98
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539607; cv=none; b=bf1MCO8t+CSyhHiGIRtlGhbis91IXyzflBVWOLfsbVzIMDy22YNar1URV89wLxPmP3jsrCBOUZKmC/nrRwy+jYjCXNBwsr4bYYCaq4iR4bSHRRfPORGKjvn7p+hDMdSRjBzGBALKuQi0pLsroL8NMJxHaL+fhAN7RcUCUMyzqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539607; c=relaxed/simple;
	bh=Ct1YlGpgOJpDi8jm1HIexRSTHx+VmC41VcQAcJo21sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPxzit8ONKsf48JSkt4xK68s3QQpr9wyvvaFWsltap/fEevxvd7a91a+9ZnjXgc0cX3Qgi5r5hZFW57Tr9M5Ifm0Q96YA2Pl082yBBS1OKDRrkCiEhtGSYH2TgQLEnFnrTVnxN3M55UG9JXG0ysl8WBig97Y7SrCxVy7kLpEKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YhvDUgz6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GJAAFEHA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LPgFE3815288
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 05:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lM1GMM51Iu7/nwLIogGClI6hwQIaOlrbCMte0LgS4Qw=; b=YhvDUgz6R0unB1cN
	O0/BelCtQ17OfARXy21byqG3l2pb9B2//t7Qa5OhINjOB7Mi/Kp0eTP+f90zWGit
	4tB0T+K15OhfFLQJV60Kg6NM5M89LXW8S7CF7rDLMGrubgMxNSgXxCznDb9Uo/A8
	W5dTx7BGgVmOx5oxMwt063kWpNUICcSH1IGrKlB42n6+qxrZFGlRpzljxYlvkH9/
	O899Eu/64VQZ7Qc0AdG01lm9dgfjOtfXO5EX7LjqfG33eklJSTvenaIja6EMuvyV
	0oCgc6lD+mwIv4OUrILFXui5AFdQEVQKw9yDFYLErYeIwloAcHuhTmKLTAXnAqB/
	/GSTLQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr4s5tg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 05:26:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82ca8323edbso6309359b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775539604; x=1776144404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lM1GMM51Iu7/nwLIogGClI6hwQIaOlrbCMte0LgS4Qw=;
        b=GJAAFEHAY+jK4y/6c5+rhEdCmjIHePeDuh+rq3f6icTjRhLqztAR1QViOuDHUfOrcq
         cAYHkI9KUljs6ZHGHRoS6HCNGXMXrBaB7kmbKMYi+cefY2vAx/tDoc1GvAqjrD+L64ZD
         XVJsejt99vwxi89i+6k6Qn5FCixrUI5Rb3eQh+0nRoxrW+6gXh8GBBjoIMHqKzR/sqhI
         AlbVjqjJQDjCqI0qYn6JOPPEYWi1x7oCR7dDkvhxgH/JC4kR2AhlrVMEsK0iD0345h0X
         FagfY/HLeWckJmmh+q4g80pzXMLmC6jh+UCdXi52+KtgSsaqAdz9UuT7Ghr5J8BdwZCU
         NJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775539604; x=1776144404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lM1GMM51Iu7/nwLIogGClI6hwQIaOlrbCMte0LgS4Qw=;
        b=EtygWxS8tQ7sALTXtpwdL4U6fpZqXoOdjG3SGFIhwnzWvEZBUnHVhCkg7WzESbciru
         V8G5Mh9xg4WMwwkG1wH0nwuj10hPXEK5mQ+9dYnsDFsT/nsvVh7hYpYkpv1sHF9MWLnT
         FFjVoVwNURCyUEMMX1Vsxf32KNj8wNWiH8YAnMg0jJOs5vQ+UJVnGm4IJraVq/SZlE54
         uRuGI/6oOjOmy457kxANjoX8yZ3j2zXx/8YrQRRGSsW6LEFsUF1tX+D1clW/Qm13fL7K
         SgZStU2/txNvDBf59cohU98sywkqMrogE54gUpT4p+p0Zj+bPg9YeQ/Wa8ihA0h99m3I
         HwKQ==
X-Gm-Message-State: AOJu0Yzjp1mTonp0z4w5M3NhziAt0mPSzlC/H/XkZKqCxnQ0X0ruYh5x
	9Bm98F2DieYdvBXgPGOnSBVekXfEZ5Rg7CIXnnqUiTjU438pcgu2Ovj6QTAuYFY2D6XYrJRkYvI
	r+5KGm4XMsrfw/WSsXdHDWkBwPWAFLF/wj5onxHdGlKtmvM0mg8jwAqOxW/uaQAaUzA10vqaaoa
	205A==
X-Gm-Gg: AeBDiev2Uk4yZiIq3ydL9nLqym6jp756cd+qKnrLY94Nozt8jeZXCWeGGdYptQYEDmQ
	7j9fGw19/ns4pdIYcwn2NM8D//mFZlAd3KfdyNRxCzxgYDIeUpZj6bvhZ3+T2xAhEdoCipdrkll
	JzzKWBvGxBx+ktCt9ymNXmahdLj2jYBGpHoUQGyF80dySydCiJ/DsESCPn4uaq5IgMB8BZ3t9k8
	I9Q9GtznyARisSEApSmHETs4V0eU4ONQCihYsff3x9HDHViZTIt7/j9zxwhDkW5YPH6mDfET6UH
	DtgFKUZjeZEaBORPei8MPXTxPilEcsDLUV3M8FmZanShZ0Djffx6R+cfAqsibMF2P7wYs3XT5VZ
	oBJyO9WWUoN/Ts8lrxa6bGFY+8XpMi7enKttVeH3ZUinfVE3oJBqguQS6K5SkQzKb7mOwr84LXi
	RBa3j5H4O9xXRPrk7zlJ1NF3LGVFlgS1HYg/UroZI=
X-Received: by 2002:a05:6a00:ab87:b0:82c:e227:e9c with SMTP id d2e1a72fcca58-82d0dbcf9eamr15586834b3a.51.1775539603671;
        Mon, 06 Apr 2026 22:26:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:ab87:b0:82c:e227:e9c with SMTP id d2e1a72fcca58-82d0dbcf9eamr15586799b3a.51.1775539603076;
        Mon, 06 Apr 2026 22:26:43 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm19897219b3a.41.2026.04.06.22.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:26:42 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 10:56:29 +0530
Subject: [PATCH ath-next v5 2/6] wifi: ath12k: Add ath12k_hw_params for
 IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-ath12k-ipq5424-v5-2-8e96aa660ec4@oss.qualcomm.com>
References: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
In-Reply-To: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=dO6WXuZb c=1 sm=1 tr=0 ts=69d49595 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=vBmMNsOPyRzkxF6eNBIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: k685QBbWb_dMiX1fFMJ9ZieOSaHUgDVV
X-Proofpoint-ORIG-GUID: k685QBbWb_dMiX1fFMJ9ZieOSaHUgDVV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA0OSBTYWx0ZWRfX6CgVsJOP/p5k
 ZNvIZ13hxtQmUV7N+wL+z66I0tM9Ev6oD+Pt8agzOxtEvsU9nK2m62oQrl0yQCZ4v2cJ0torP8N
 8z3sUq2nkrWcZoWUqexuflpMW0JWKqrSWxOf3+JPSQ25d+DV4r8p+/Bwom29wUqq9oZOQmY9ad/
 QrlrHvpJy+Y6IGqeAL2O6DW4kk4/zYIhCwrEg/KpINvSf9m+n0zMHbx8iQM6G0xLDBNl74A1rDF
 liRTTvCOwWMeduZm1OG4q3zvWem1FcH/sVpefBnJGCLReNdIJRzDptmu74zi5cuEXs96HNA/Fbp
 Nddjm9+a1dO9Xfw0onJgewj3m1+Z6BFVKKrER3XygmN6LxavBXDd1fbs+5pwXsLcmuQriTnjeeW
 8Eh3BSYwrWa7//H7nTrv2UFH9DPiU9y0GS6Tx4y83YD38XxM//RDB2IH/dmDoh+hC931EcLOjBz
 Kq58W0wl6KgbMXToQRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070049
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34425-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,quicinc.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5786E3A9EFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>

Add ath12k_hw_params for the ath12k AHB-based WiFi 7 device IPQ5424.
The WiFi device IPQ5424 is similar to IPQ5332. Most of the hardware
parameters like hw_ops, wmi_init, ring_mask, etc., are the same between
IPQ5424 and IPQ5332, hence use these same parameters for IPQ5424.
Some parameters are specific to IPQ5424; initially set these to
0 or NULL, and populate them in subsequent patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h     |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 79 ++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 59c193b24764..68453594eba8 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -157,6 +157,7 @@ enum ath12k_hw_rev {
 	ATH12K_HW_WCN7850_HW20,
 	ATH12K_HW_IPQ5332_HW10,
 	ATH12K_HW_QCC2072_HW10,
+	ATH12K_HW_IPQ5424_HW10,
 };
 
 enum ath12k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index ec6dba96640b..2b5d1f7e9e04 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -753,6 +753,85 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.dp_primary_link_only = false,
 	},
+	{
+		.name = "ipq5424 hw1.0",
+		.hw_rev = ATH12K_HW_IPQ5424_HW10,
+		.fw = {
+			.dir = "IPQ5424/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+			.m3_loader = ath12k_m3_fw_loader_remoteproc,
+			.download_aux_ucode = false,
+		},
+		.max_radios = 1,
+		.single_pdev_only = false,
+		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ5332,
+		.internal_sleep_clock = false,
+
+		.hw_ops = &qcn9274_ops,
+		.ring_mask = &ath12k_wifi7_hw_ring_mask_ipq5332,
+
+		.host_ce_config = ath12k_wifi7_host_ce_config_ipq5332,
+		.ce_count = 12,
+		.target_ce_config = ath12k_wifi7_target_ce_config_wlan_ipq5332,
+		.target_ce_count = 12,
+		.svc_to_ce_map =
+			ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332,
+		.svc_to_ce_map_len = 18,
+
+		.rxdma1_enable = true,
+		.num_rxdma_per_pdev = 1,
+		.num_rxdma_dst_ring = 0,
+		.rx_mac_buf_ring = false,
+		.vdev_start_delay = false,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				   BIT(NL80211_IFTYPE_AP) |
+				   BIT(NL80211_IFTYPE_MESH_POINT),
+		.supports_monitor = true,
+
+		.idle_ps = false,
+		.download_calib = true,
+		.supports_suspend = false,
+		.tcl_ring_retry = true,
+		.reoq_lut_support = false,
+		.supports_shadow_regs = false,
+
+		.num_tcl_banks = 48,
+		.max_tx_ring = 4,
+
+		.mhi_config = NULL,
+
+		.wmi_init = &ath12k_wifi7_wmi_init_qcn9274,
+
+		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
+
+		.rddm_size = 0,
+
+		.def_num_link = 0,
+		.max_mlo_peer = 256,
+
+		.otp_board_id_register = 0,
+
+		.supports_sta_ps = false,
+
+		.acpi_guid = NULL,
+		.supports_dynamic_smps_6ghz = false,
+		.iova_mask = 0,
+		.supports_aspm = false,
+
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
+		.bdf_addr_offset = 0x940000,
+
+		.current_cc_support = false,
+
+		.dp_primary_link_only = true,
+	},
 };
 
 /* Note: called under rcu_read_lock() */

-- 
2.34.1


