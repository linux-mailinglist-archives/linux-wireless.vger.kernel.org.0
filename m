Return-Path: <linux-wireless+bounces-34427-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP9RL+uV1GknvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34427-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:28:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE8B3A9F25
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 677AF3051E9C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9F37880E;
	Tue,  7 Apr 2026 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YpUeFZJB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jJMkHwdQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE128378D93
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539616; cv=none; b=tjfu/XfJTanli8c2OLriAarW5huxIj5l9bNApvYv0uCDsMeAJ0ZJ59fOrdNfc1UKRBQE4baEMg4V4wRkTdoKKH2iEHaXAsrded+ZVpoU1HqVWP/+lVqCr4IFir+IwQvz+4gL9we4qjsGNeD5Wxt5OCB0bxz1NDwXv8S9lT/RUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539616; c=relaxed/simple;
	bh=0NN4w0R2E3va4DZ/dq5swkDObsqSfw/b8C6UihDiZ0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTowXx4Hk10Jl3YX2eYkQ8GjQShOpzyidy7L0lDlWKJfVblIkyenWj8myxQg+qCAkpsfXNfnxaaeSWqS3JatB1xF8rRaLspC1dzTDuvfWXqAMeYl5nsNDnm5McGTJdY0PRj5BSVY6feI6t7mW4jXTBFcoWtZFBFq6hf11UUiCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YpUeFZJB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jJMkHwdQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQpss3402629
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 05:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zJkK0ZHv7xgx186MXNY2Y9ThbdU6PTv+CGfvbKzd/Mw=; b=YpUeFZJBzKyFGMXu
	0g9Mwa/HeH4u5zNr9pYCj3EhQsdVCV5BO5fITaP0TdxL371Uc6YBReOrESEDOM5Q
	0bZsUTnB9I59xR2DfQtJ7KX7wWHdiAte8j72dR/Bv9zRPrEHvkoXmVY4DPed+udG
	yzT4BslcMXP0YvJ0qKEegyDPYPsy93dCF63bxyUXSAE8HSzXNCVL4tMvcPAhSnc0
	nfEtcTRXC5VEdh2xd9Prgx4IsUjQ7cPm5wRl2EVlV7cY5Ei5KdrV8/JCkgl1/HKQ
	vvk7Fn+bNPVuKp9xGQVHfCllv53WIXtdwBocjuj8o/RzDM/UOJ0roAqn3AyTijN7
	pANnUw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhs5m4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 05:26:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82c1e1a6cfbso3214685b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775539612; x=1776144412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJkK0ZHv7xgx186MXNY2Y9ThbdU6PTv+CGfvbKzd/Mw=;
        b=jJMkHwdQy982rQg+hCgDthigjS0PFParH0OilL1E8W9/x/0dqCPUS2Hk0s/xHWAdgb
         iefQDDBb++dQF7+21pfmQDT21PCYk6G4VBwahvQkQHIIh03zyh3MXYYpwsUUvk/fGNcg
         61UNUkVlLpPYKSrvVppxegMYR12hw1eOdz/aiwxjuQiSUor2FaySm5JMwvM3Y6YO3fmJ
         M0WP87FdFZdx7XpJZkdEahS0eVul3XaRLbNwMOFeXP7NlHq61N7YgzShABHrMMbevMmN
         JZb+H6HyT9BExCXRorTbJn3EIVXoNWTvH6kljbu0KKwNKuK5nXVInBuUalL3lqflA/yc
         DjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775539612; x=1776144412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zJkK0ZHv7xgx186MXNY2Y9ThbdU6PTv+CGfvbKzd/Mw=;
        b=UUGS9dG3xIpWbrUSi1NglhqjZs9S8TFqkKPn19ZTnO33ATmU0pUHUgbVOibWZJnGFT
         B06pyO+IqsFEI6JYOalEU06GP0qV3swoEIHV7VIBQgCUsXbZwfjuO25P9Mrd59L6j47M
         +pehMbXjUAY1f7azeIUrrDCsVG6yPF/yoWCzSCLaLJOs0tC1VT/UwWUa/FsSkjvh+yCy
         NKVAn9l30I6lhMG8ZJU6PRQhVhGbgs9lA5KtXwWsrfmIxKza3wDWpgtxK+o7D/sSwKfR
         +nwQwnMCk+QJ8Cw0EeAzCta1mmlpaN+ErjE/CXZBHjlJsAMZdleDA6sqDOHfUjI2858k
         BTxA==
X-Gm-Message-State: AOJu0YxT/draUf/zZKDihSh7G2gU08PDm+vqqVJV2rEwGf1QsQI+KPh2
	gRVQkIxz2hMyCDvYRwRnFt15DCM8gzAhI05uihWMyEA0fglqlzRB+nrwZE31AuXz3GthMypKDLk
	vbNb63MaDqT72bp3oXeW6QwRZznkVgmqQHoIh+10fiXLWMuT+R/Wz9SHEZcgym55R+an7zrDD5M
	+mhA==
X-Gm-Gg: AeBDiesNniI2cnEU369hZfMOAU71dVHOEiEdQz0+fPjVItMUro6nmlsEGuwPVA0lWzc
	Bizfe2egIRcIMrSSpRlOFVlgB70Ubd79MeAS9DqOSrBRPvFsZQUj0stcacj/gXzCXEaCGJ64Iyc
	n2nnyTwPU90cH0npudiVKKcis7/rOzy+zjQJEt2sjXa3/ct4D1OpgGoMBQYMjoPqP9cBrfw9lDp
	9VRzqOEAqUjvMbkOQqvy1uLQzKFKuvfettlcE0zEczELDY2ZkDP3im6hV8jTIYx0BLFuPD1/GBH
	xDNzxqJ4hbag7b6WG7/PPBApuNQr4YjXglXlTtJ7teXdKWz6K/3WM+n4jGz/B9/1mGuULrWnGHp
	yVon7+B3QP34to2zfScNYfHfAovvqgGScopLYlyirxWSAexHUSExiMZz7cI0cCMiMy+Pa+4//Ii
	rp/cxGLO7fqAYoPQp4W3GDRf8BYBwau0E+OCPXqCA=
X-Received: by 2002:a05:6a00:2e85:b0:82c:a048:30da with SMTP id d2e1a72fcca58-82d0da3e057mr14821989b3a.8.1775539611941;
        Mon, 06 Apr 2026 22:26:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e85:b0:82c:a048:30da with SMTP id d2e1a72fcca58-82d0da3e057mr14821954b3a.8.1775539611345;
        Mon, 06 Apr 2026 22:26:51 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm19897219b3a.41.2026.04.06.22.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:26:50 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 10:56:31 +0530
Subject: [PATCH ath-next v5 4/6] wifi: ath12k: add ath12k_hw_regs for
 IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-ath12k-ipq5424-v5-4-8e96aa660ec4@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA0OSBTYWx0ZWRfX4ptuu0jp1lUz
 uRPtt/MYdS+q7Ubill6sTEpuFNgXTZXyX2VnvIUEQLfEgm8lW4IHdjOU7903RdKoYvF4jqHvudm
 +Cnpcpd5W+xkbozBeKuo0kXbLwD1fZDcVxUinlR6fXLrCZCEbgBw+mXwBhpASyMdxJlCxYPYS2t
 S0VV432tJbKbz0ta8KBCJXipuF8wl0KGxp1XivEy3lzDYzyuxxeLMPDiVOdle1GLAHTWDvPYJWZ
 OOTTFie+yJReKLRQB2uo2fE/N7dPvGQRCA16LBaENbEwCH5dEXXuJIIdSihEF4dTsQKH4iBGyzy
 ElccD698kkSUE5+MGEUACCEbuM/+UwtfyCuRBKULXCUFO0W5Rsp2CxMCAZlBkv8zebWZ7tI9r1M
 7dgrbv0MLk/G8KGT1tKG5PctgYvM/spjJvUEQHmlkYM4hQ3y32oOn2iYEcU8WjEHlTELFKXXx2k
 ACYA0ZFF+dGmKquxSMg==
X-Proofpoint-GUID: iSL2Lk3IupNTTigvv1ewmjveq-C4zZry
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4959d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ZT2xpsdUAhckzUomvuUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: iSL2Lk3IupNTTigvv1ewmjveq-C4zZry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070049
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
	TAGGED_FROM(0.00)[bounces-34427-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 3DE8B3A9F25
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
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
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


