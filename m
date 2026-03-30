Return-Path: <linux-wireless+bounces-34197-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLOXGNDgymnEAwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34197-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:45:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB47936119D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29ABC308E4C2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 20:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2323A1680;
	Mon, 30 Mar 2026 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G6s47FSc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lyh8kaCa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80786393DC0
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903176; cv=none; b=U+0X+7KcjxSDDh1YYAGpMCuoG8sQKTr9lsgZH6ZhkSH3dfhhaqCA8sqjcq5lhb3xy744kA9SmvtYnMvRSU48VZ5aq08ckYl3pJyHEnw+YWaJ3Kf+F7vqj83mbup0ymvW/Dacnk0q+f9dkYe3LCz1JebPhBnbRiImPHby++Net/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903176; c=relaxed/simple;
	bh=djpjHF6y5AufNPbBPbBXyws2WpMjIV2aZwn8IK0Ao44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kR5OvLTlK/bsARHJyl7Hm+Kr7cFvFstEucXh2f0RbpcMVuC3EiMY0xOZqQQJZVFzHTir96HxlNOqBReDHmhbwdQ4lx51UxBKl1/WM63c+Ozbg5Sb9FVnACP/5kxcuPQuzyy5A72Gdq2SMzJ4tamKf2s5LXskyCBZkJ9oM/lrOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G6s47FSc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lyh8kaCa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UEOIak1557400
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9U7IonkBdkRAhcnL68BzupxStBnxfId1isZHipcKmAE=; b=G6s47FScJ0sxqmGo
	9Erw5+yexs90a+/x8ne5pA3bkg9Mr6tgS+3HGmB9+dAnUWTt1pzqSWgb9QT1PqaM
	K5uEML5EdjpcEDkdgqZZ+Hj0C06uJqWa/MFkdk4JjCfom7gdN6t4tq+C3+hRSlTq
	r7Va8pbyyOlkzZwPkWWIO6s40KZ150g/zk/CUDQ7K//ACEwXZ+XXH3oMJp2rNySg
	Ya+8rkhHlSbD5qi/wqfWIgrjZDA1pU4pl073e2VC1H3SLPHHNc4cLeAZ56YBJB/k
	ZTfnIbKpnX3GxMWjgKGagcvLdpOdaJelcRZ+EYP6qSp9PLlFMmPFA8p6qUv2iiSc
	xDqxWQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7twm1e3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24a00d12cso21827875ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774903172; x=1775507972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9U7IonkBdkRAhcnL68BzupxStBnxfId1isZHipcKmAE=;
        b=Lyh8kaCaJCJSarZDyh7FpzLlZvt9JvK17wUEaBXrMuAssVx8Q7EjwFyG5/5BwRKnOi
         zuEdNYGkHlCojcpgOkrfz1xoahrypkiw2xGWg1aZrqkxf+M6dZh1xoFydfeUPsEYnJZo
         qxDtxwHTe3kW5isX6wm6SZnFlfJ3V54CZAkTHc9+IB3Zdh0iTxQEkCA7Hx3w4ILmNyiR
         TNHYyjMUzWZe04DEHNiLa9S/eHiBWgyRoQPkUP/7o0h0Fl7z16hhhD+NM0WTPbI5U4Gn
         qQ9xlSkh4oRwRCDfG/GL4Lrbxtf4GwWP3HvQaKqTdg4BZK2La23vSv1InBDKDAqjcHnJ
         inqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903172; x=1775507972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9U7IonkBdkRAhcnL68BzupxStBnxfId1isZHipcKmAE=;
        b=XHJgC7ycZBkOzaQn9YKDTItkeVj2biBByNr9jW7dpH9ITmVuLx7e9PZ2eRHtVJnGss
         R27gZLvXez4b8qmwEukmus2CarA/BvhhTyE3jD6PGd/fKO6sXXNL58Hx1/7e4Fu2T8VN
         4tgBK4ynsBg4k7M8DhdPuq5Jog5mcSSTNA6uPQOGiZcnqipOX6Xg7HJu5muXDEvshdrS
         HsjAXXdZUK061KpaGnySDE13jJbeuXhCrwUktz3Ss/WlUNtMKUjVl8aukAqIR8YpXA0t
         zARuagLi+vxK3dsoGy9iWzkL3sk9jIpqegRzVt56kQAs0z4DE3i9Yma9rVP1RPs+5Xlx
         HTow==
X-Gm-Message-State: AOJu0YzWZqN4GLZNsrikljfrOy8ighBlR43BqTjDySpNJvkRdk1uarJp
	GM+wnLD+Vl2XulKxSODycDccws4wn/yRN71vXkYnE/EFxCTA2NDujPPgEJtj2R4lNV8nGI59kHR
	/dG83GfdDihMP+pg6+VUfcRvfmZTeEjfOgn1Fh3lo/wKBYuO5GwqoJZO5OLAuH8i6CiqlIA==
X-Gm-Gg: ATEYQzwaUJGvxliAOTU+Ov9ghq85SbQFT49DM2NJJ7sxbZUhNG3kw6amCen9GAu06Dq
	B/DxJIYNfGBeNo16NW1w+UGL7Z0eKlkOdxpF34lyA/8Y1UtMmCrO2K/qfd09fIQth99ouI0aFsw
	9MO89lFFeW4m0Vt+XXNzx0ZablT8B+c0KmjPtb3nqj5Lfs+LBDIWNziiN9MoCBYYGRcpkRb/uGt
	F5VdZqhAkPnpuDeV0N5/2sSAWXgHVYfAXubhsiPu4esG976X2s6vI9Mb7SFj+RCcCYTAHdetCHX
	aWAWX71i5j7ACorbEtMTEZh3PUyp44Oe+il7Td9hJJjIQGEfpeZ1ePWuqvWZirIgoQ5oWgdMd6O
	BWkMHHwqiOhILmZ4XC2AyROCL7FnatvuA4T99fn6obUFo/3iZoovC0Lid1DlpfUcI0yYnF75q8B
	P7EGHQ5DYbBdDUFC/Pp2+LNNfqWrapojPTYGmNL0s=
X-Received: by 2002:a17:902:e847:b0:2b2:5124:d068 with SMTP id d9443c01a7336-2b25124d224mr54273115ad.10.1774903171740;
        Mon, 30 Mar 2026 13:39:31 -0700 (PDT)
X-Received: by 2002:a17:902:e847:b0:2b2:5124:d068 with SMTP id d9443c01a7336-2b25124d224mr54272915ad.10.1774903171124;
        Mon, 30 Mar 2026 13:39:31 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c3a4esm113517195ad.78.2026.03.30.13.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:39:30 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:09:09 +0530
Subject: [PATCH ath-next v3 4/6] wifi: ath12k: add ath12k_hw_regs for
 IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-ath12k-ipq5424-v3-4-1455b9cae29c@oss.qualcomm.com>
References: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
In-Reply-To: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>
X-Mailer: b4 0.15.1
X-Authority-Analysis: v=2.4 cv=IJoPywvG c=1 sm=1 tr=0 ts=69cadf85 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ZT2xpsdUAhckzUomvuUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8EKcFf4KgZp5zH6Q-wAwKGssdqEfUYNB
X-Proofpoint-ORIG-GUID: 8EKcFf4KgZp5zH6Q-wAwKGssdqEfUYNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NCBTYWx0ZWRfXzBorDJB21oB6
 HPqgYQiU3e+8qOWPQP8hlHxeJRoc9n8BuI7/HEHUdZCb0nPxnPRPYfFZvV1wAgOKg/CSL485i0I
 ReWv+FaGtVtkbAf1wQvPcPbMnkJeKJxspOC2jqrQafVy4tqnBKCC7WbbDFzKcp+kvOGNeJIjPVB
 lRVbjcRu4NbYmgCLy3ZepacNhAR7KgtlTAaokSZO5tRZipHo39lEEOLh0ShlasdBz7+mULAnpxc
 zZuh12WIlPYrsebTUVAeXx7PQrZnzRwlKPw/somEadaqhPGibNUJmcKHnZEc1U8AI4xEcyPbOE6
 0/yddeqTE95gUiDGUDyi/65rO5xQUrP4CAXajgbtlRJvuoCUcODsyJ7OnCrbiJgPyG4XK1gz4yd
 aHutSbVrmQqdJhOyoNMPk7C5EUGtRp04xf2W+4EzJUMMWKTX7ucfjAr9IW7cDod3FanYKCTbCjA
 xlr0DsnBNU9gOy/KP+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300174
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,quicinc.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34197-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AB47936119D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>

Add register addresses (ath12k_hw_regs) for ath12k AHB based
WiFi 7 device IPQ5424.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  2 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  3 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    | 88 ++++++++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |  1 +
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index c2cc99a83f09..a0a1902fb491 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -55,7 +55,7 @@ static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
 		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
 		.hal_params = &ath12k_hw_hal_params_ipq5332,
-		.hw_regs = NULL,
+		.hw_regs = &ipq5424_regs,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
index 9337225a5253..3d9386198893 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -364,6 +364,9 @@
 #define HAL_IPQ5332_CE_WFSS_REG_BASE	0x740000
 #define HAL_IPQ5332_CE_SIZE		0x100000
 
+#define HAL_IPQ5424_CE_WFSS_REG_BASE	0x200000
+#define HAL_IPQ5424_CE_SIZE		0x100000
+
 #define HAL_RX_MAX_BA_WINDOW	256
 
 #define HAL_DEFAULT_BE_BK_VI_REO_TIMEOUT_USEC	(100 * 1000)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 41c918eb1767..ba9ce1e718e8 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -484,6 +484,94 @@ const struct ath12k_hw_regs ipq5332_regs = {
 		HAL_IPQ5332_CE_WFSS_REG_BASE,
 };
 
+const struct ath12k_hw_regs ipq5424_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.tcl1_ring_id = 0x00000918,
+	.tcl1_ring_misc = 0x00000920,
+	.tcl1_ring_tp_addr_lsb = 0x0000092c,
+	.tcl1_ring_tp_addr_msb = 0x00000930,
+	.tcl1_ring_consumer_int_setup_ix0 = 0x00000940,
+	.tcl1_ring_consumer_int_setup_ix1 = 0x00000944,
+	.tcl1_ring_msi1_base_lsb = 0x00000958,
+	.tcl1_ring_msi1_base_msb = 0x0000095c,
+	.tcl1_ring_base_lsb = 0x00000910,
+	.tcl1_ring_base_msb = 0x00000914,
+	.tcl1_ring_msi1_data = 0x00000960,
+	.tcl2_ring_base_lsb = 0x00000988,
+	.tcl_ring_base_lsb = 0x00000b68,
+
+	/* TCL STATUS ring address */
+	.tcl_status_ring_base_lsb = 0x00000d48,
+
+	/* REO DEST ring address */
+	.reo2_ring_base = 0x00000578,
+	.reo1_misc_ctrl_addr = 0x00000b9c,
+	.reo1_sw_cookie_cfg0 = 0x0000006c,
+	.reo1_sw_cookie_cfg1 = 0x00000070,
+	.reo1_qdesc_lut_base0 = 0x00000074,
+	.reo1_qdesc_lut_base1 = 0x00000078,
+	.reo1_ring_base_lsb = 0x00000500,
+	.reo1_ring_base_msb = 0x00000504,
+	.reo1_ring_id = 0x00000508,
+	.reo1_ring_misc = 0x00000510,
+	.reo1_ring_hp_addr_lsb = 0x00000514,
+	.reo1_ring_hp_addr_msb = 0x00000518,
+	.reo1_ring_producer_int_setup = 0x00000524,
+	.reo1_ring_msi1_base_lsb = 0x00000548,
+	.reo1_ring_msi1_base_msb = 0x0000054C,
+	.reo1_ring_msi1_data = 0x00000550,
+	.reo1_aging_thres_ix0 = 0x00000B28,
+	.reo1_aging_thres_ix1 = 0x00000B2C,
+	.reo1_aging_thres_ix2 = 0x00000B30,
+	.reo1_aging_thres_ix3 = 0x00000B34,
+
+	/* REO Exception ring address */
+	.reo2_sw0_ring_base = 0x000008c0,
+
+	/* REO Reinject ring address */
+	.sw2reo_ring_base = 0x00000320,
+	.sw2reo1_ring_base = 0x00000398,
+
+	/* REO cmd ring address */
+	.reo_cmd_ring_base = 0x000002A8,
+
+	/* REO status ring address */
+	.reo_status_ring_base = 0x00000aa0,
+
+	/* WBM idle link ring address */
+	.wbm_idle_ring_base_lsb = 0x00000d3c,
+	.wbm_idle_ring_misc_addr = 0x00000d4c,
+	.wbm_r0_idle_list_cntl_addr = 0x00000240,
+	.wbm_r0_idle_list_size_addr = 0x00000244,
+	.wbm_scattered_ring_base_lsb = 0x00000250,
+	.wbm_scattered_ring_base_msb = 0x00000254,
+	.wbm_scattered_desc_head_info_ix0 = 0x00000260,
+	.wbm_scattered_desc_head_info_ix1	= 0x00000264,
+	.wbm_scattered_desc_tail_info_ix0 = 0x00000270,
+	.wbm_scattered_desc_tail_info_ix1 = 0x00000274,
+	.wbm_scattered_desc_ptr_hp_addr = 0x0000027c,
+
+	/* SW2WBM release ring address */
+	.wbm_sw_release_ring_base_lsb = 0x0000037c,
+
+	/* WBM2SW release ring address */
+	.wbm0_release_ring_base_lsb = 0x00000e08,
+	.wbm1_release_ring_base_lsb = 0x00000e80,
+
+	/* PPE release ring address */
+	.ppe_rel_ring_base = 0x0000046c,
+
+	/* CE address */
+	.umac_ce0_src_reg_base = 0x00200000 -
+		HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.umac_ce0_dest_reg_base = 0x00201000 -
+		HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.umac_ce1_src_reg_base = 0x00202000 -
+		HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.umac_ce1_dest_reg_base = 0x00203000 -
+		HAL_IPQ5424_CE_WFSS_REG_BASE,
+};
+
 static inline
 bool ath12k_hal_rx_desc_get_first_msdu_qcn9274(struct hal_rx_desc *desc)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
index 08c0a0469474..03cf3792d523 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
@@ -17,6 +17,7 @@ extern const struct hal_ops hal_qcn9274_ops;
 extern const struct ath12k_hw_regs qcn9274_v1_regs;
 extern const struct ath12k_hw_regs qcn9274_v2_regs;
 extern const struct ath12k_hw_regs ipq5332_regs;
+extern const struct ath12k_hw_regs ipq5424_regs;
 extern const struct ath12k_hal_tcl_to_wbm_rbm_map
 ath12k_hal_tcl_to_wbm_rbm_map_qcn9274[DP_TCL_NUM_RING_MAX];
 extern const struct ath12k_hw_hal_params ath12k_hw_hal_params_qcn9274;

-- 
2.34.1


