Return-Path: <linux-wireless+bounces-34304-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGT3IADpzWkLjAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34304-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:56:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A76933834D1
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46CE7303D28E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 03:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2B235AC06;
	Thu,  2 Apr 2026 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HP06aR2v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jf1aA3PZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C332B361667
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102076; cv=none; b=XReiWd22S/XseVBM+TliZzDd+d3cv27Mrbv74NXtbcHF7Jq1LP4D/QvgHXTeGJHav+eAwD2XCIRHosHt0KzJB7p9qGrR/Ukjr0knsdasNiAz7KP0TkUEFamC61C7M+bPvBimyI4CyHzeMddUbgl3H7eM5GBWpneWSSYr4XIZZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102076; c=relaxed/simple;
	bh=djpjHF6y5AufNPbBPbBXyws2WpMjIV2aZwn8IK0Ao44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BuiLNIZhXDIGZt4Ihj3ZNYvQ+ziIKIj1ZQlcySS6YPtZRJlhXPnWNrRZBLDOdZ7UTLMwKRQnSdeEYV25R+GeiqNPn1xVXMejuSIDmfhPivfKZSV/bx0aD/JehX/Eap3y9goDOgInQ5KAy32U5BGaBssRK4VHIHTWH4MK2UdWsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HP06aR2v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jf1aA3PZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M4q883336658
	for <linux-wireless@vger.kernel.org>; Thu, 2 Apr 2026 03:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9U7IonkBdkRAhcnL68BzupxStBnxfId1isZHipcKmAE=; b=HP06aR2vP1RfflZH
	YOcYIx778+80cw02ELYTQuvkPLTk/aYvArWH6YchSvU58nVeQkddK4J3TPkfWxST
	4Z/SPjxXgzcdqUftICNbuCVPoRAWAKL9opNQ/eTOSwxGhO9xhW6hdMnTpAXi4GSw
	2YOv0gNsvAjLfCFYcCC50e/DcOYSbteJyP+Grzpm0vgTCk6y8N7N5De7pAcwYdbq
	gt/8CeZ4vsFX3a9mAlp4u2hHgQ9+GKzoxi2BgZQGD4ffsXsJ8V/9grrdna/oI9p0
	IHoS/5PwYFSSKhKNqwa6zAp5y/BCz1n6ySAS92c5sBaPe1VBFxX5zzjbkM5SxHUy
	mCaOdg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3vdfn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2026 03:54:33 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82c70d1f65aso236286b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 20:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775102072; x=1775706872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9U7IonkBdkRAhcnL68BzupxStBnxfId1isZHipcKmAE=;
        b=Jf1aA3PZsf6n4LRtt+Pp2QFTV/7TNIzGbIYCFIWhrlLhvDfMyTc57YdS28pvjGCz1Q
         RHCPfyHm/s2zRpiIy8wRr4yGUgOloKQmojlSeTcZm1hv5M/JlcSd7o5cmLATkHeTb1VM
         1eNAQdjGi3J+xm3ppq1HRH4QW3F6+fIsLShUY1yjXSqJ5T3LYJAXhqZE8ikPM/eXvTNt
         AVvg8mGOI5cQ6BxJ38cWmM1gfjSR7WGhw/y3IGoxOX/dh3k0vI7aLxaMQ/8hughh0ULu
         iBbATq0N/9ALCPMn3omntci+ygk6mAn9woZPYKmYuIZHYzp4nJmg9dKKrMv+OqZem9rH
         4RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775102072; x=1775706872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9U7IonkBdkRAhcnL68BzupxStBnxfId1isZHipcKmAE=;
        b=htl8+DwLwk/ujJpjP3rz6dSaOaZVLJK9w1HHeC/4W2SkgeO2HqSwaJbDNJG3tpRk8j
         pUwolfl2xJ7Mjy34Upt00r/3XnnKz28NqaKeZrNN5Gg8qU6VTx6ZWOXlA725RVAvkrKt
         CpIgk11HaQ00IGpr4AVtt228gx4qUTcBLs1P/APmx+baOFVYWAWM4R7Me++FMuzcoWAM
         wBW5rC96TGbt3RJyK6CQshfmpsCZS0DuUlTRDXgfebbH3dRElau9ZFu64Ro+ysl4p9JM
         gidtNjhzZq1C7m1ncrCIFq7DgsAdY3cZaO2jCZh9kqjgma/dFzyyI+SPilAoeCEARXdx
         OY4Q==
X-Gm-Message-State: AOJu0YwOh1EGsFsZZnGl2KviW+tc5v9cZcXXCNaD7WFHlwi4pg6TkP4H
	yzewkDJX1YJxE7Rk0BVZxu0IoeRCyEH6tnT5GDNyV0OIRGHYIJlB5XwGEYPOo0XQkC3YrHRUKTE
	ToNtV5a97MMJ+d6SqdNe5P7Qf0rGPB7CnWy0Xu3zifNFNzUHwFdKlEQB6u3E6/kxTtlKl4w==
X-Gm-Gg: ATEYQzxb+V/r4P03XPY1LIE8mCTa4hmOd3fsO+3FSpXnJPOE7ghEoJVnUJA+NBB4pKw
	pb52V6YWH8FA1aMJuSlEeG9q3bb/2KlV7TCXNrzHcnfaK2MLWBUe6tCWDZOPH+qf7SlRR/aQQXO
	XP6+B3TpQznn73Cl57GjfFnPaS6gz+wv324X0pPY3a+NZeH3JoZVkMJ5QUe2XvjCS/tQahbbuxX
	QSoM0wBFg3ffYiKyG5wqIh9sbt9RFwDTGEWyfWV8mWy8E6OjMbHgQmaftHEu7VeBMwxaNsa9iV9
	1IBcmCxTmuzsMlBKOhLdAMBbMJ+JDxGM4odvpPIatEJYGZwJX0GGI2ub2d3cUQQpmNvD+kwlxZf
	PqFj4+XCLyf8I8kuokwgtF2OtkyVS5MgOTdQacLJxwW5dVIILcnECkHYuyKroIhPRb3xtT50m5x
	325triWY1bRnkytfGpWgAP9+uRXjrvWqWgE6LvAsk=
X-Received: by 2002:aa7:8894:0:b0:82c:e775:d43a with SMTP id d2e1a72fcca58-82ce8ac8ce0mr6535570b3a.35.1775102071793;
        Wed, 01 Apr 2026 20:54:31 -0700 (PDT)
X-Received: by 2002:aa7:8894:0:b0:82c:e775:d43a with SMTP id d2e1a72fcca58-82ce8ac8ce0mr6535543b3a.35.1775102071289;
        Wed, 01 Apr 2026 20:54:31 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b272bdsm1456189b3a.12.2026.04.01.20.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:54:30 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 09:24:02 +0530
Subject: [PATCH ath-next v4 4/6] wifi: ath12k: add ath12k_hw_regs for
 IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-ath12k-ipq5424-v4-4-cd1e0f0a6c88@oss.qualcomm.com>
References: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
In-Reply-To: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cde879 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ZT2xpsdUAhckzUomvuUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ePCpFV42-4XbG56XySxx7IdrK5BHcaRD
X-Proofpoint-GUID: ePCpFV42-4XbG56XySxx7IdrK5BHcaRD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzMSBTYWx0ZWRfX50zXlxQQi3uD
 5e8e12Udwdeu0cIWYj0dTWlNiGbz4ZHP9zJfocKeISJiigCt07Q8aXUj9tzE19qh4RFz8aBDkY6
 qxRP/YqoQrAhDTLYVClWTRLpnDR3fK43ZXirHsLGWZTr6r9A+qzYXBciq8mDBMZlYTUNCa3I1Ya
 yw9D+XqlRy4LpOKJgtMhpfrvnLyrKkDtUq+GxT4peCkHZCYViWm39DhzHpX1tiEqGVUuRcb5mzm
 VyxyiFamOGIZYYHTeNsX5wUCEDNFXRguOCUXM27WpnXl1NmIVEAVFJUDL86HRamCOAzXJaTaqZZ
 05u25Sok9+fa8bVFiqrXqfZC8FRspiKuszzdeae5hqKPv3UsItZC97PFk76JzaHdb+mU353m4xY
 6vHf41VVlKxwXb2GEXgKNf1aHZpSml6Gs0vo+H5/JM8prfSqy9qc6g+5xcUEUfkmUOVvS9Ypen8
 VANqOTZ5y1+MryqZqBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020031
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,quicinc.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34304-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A76933834D1
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


