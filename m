Return-Path: <linux-wireless+bounces-34305-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKNeEk7pzWkLjAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34305-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:58:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B77A7383514
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FA52310BF06
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 03:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3D736167E;
	Thu,  2 Apr 2026 03:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HpI6Sl/A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQSgDd3Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00D35F19D
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102079; cv=none; b=mUJVu5I7bBP5SBffszJpoxwv/cAaU/C+3LSykNt01F2DUgjzx4qO/A9fVzzE9nEv1xCu6l2+hYWBPx8a8lPTMYZKZrCAleUiczQKa2DHmxZx4feinpre7y0Rc9hzJJc+/DAfKjlSTzeOSfcpXZkXSwIRcha9NYIdwPv0caTa/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102079; c=relaxed/simple;
	bh=jI3MJb34Fpf484h0NsiAZuAs/DRVNF3NhnamK3BdUY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJHVDp/0XfNGSYpitzfy418ZM40RCNyTTUf8xJailkGpB4H4v3bs7zqgoQuwTsJuBdsH9h194VEG1ZW7bWlts/f40w9c+SiFhdsTRMNrsczEXrV5udTqC/4ntxj3aqqcdm2rpG8bPWml4A7J0B+q0uSprSqJk+ryRSQVwgNzcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HpI6Sl/A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CQSgDd3Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M40Vv1128558
	for <linux-wireless@vger.kernel.org>; Thu, 2 Apr 2026 03:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/NLOqrmrcKA3RfsbA2VIhZMGTu92GozTrB1hx2pX3L8=; b=HpI6Sl/AfkDqHLSc
	SN9Lc1JmcsgfQnTPAMlPnEzHZX9pD13HbBwrgFh1lebVOSgCoicnOq95v5UUBwH1
	4uWZBDxi9D8T5jmJhuGIKake3K10Imk98LekdG8eumoeoEn1JfrDTY2wzlzLdsdB
	U6PbZ5dKGTtN0G0J/iviezwCqZo3BIhBM4V25KmyQpMHxavAvwT3GXIaSXQ5fPMd
	Qov8E/nyHVm38M5fENYNS71W/da4BtEPNTUIlOqCVq3a2cAMngAFh9OA8I+cesxS
	eCJSPK/fGjyJWzkC38EUEQFgpPXVdL8h0oL0C4z7CEw6kNi98EnxGUKj436UND/3
	oawDKg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d96k9a36t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2026 03:54:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82c1e1a6cfbso313778b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 20:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775102076; x=1775706876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NLOqrmrcKA3RfsbA2VIhZMGTu92GozTrB1hx2pX3L8=;
        b=CQSgDd3Q0nfXBAcTlfRwwyifZ9OiyYOSKgIhD/jwUeYWMYpmH6/H7HnMJhshhYYd1j
         3yEpxDzrx2kAeZo94Xj4clIw5jIh4l/Myp9H/y/LDtIF+oCxliF6ZX+NmPTE7dF0pLOU
         65gi+lCZOpJpqIEObKbNnPAlfglrBsN3admNRqpkmazJtapaoQYqSnzWsU1o4uFkbul8
         gIk7vgNqVIi9dct2jPOj6q4adGNbdmelRFYgS4wWpfb/7SjS2eSalvlAPVR6Ni6olfEY
         8ze3Yv9LAi8R2svVXcNQbQ0BVnk4QUdNa4SA1jrmkEeOebaBC8Nrx/pc4kI5Cct7LbIl
         +7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775102076; x=1775706876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/NLOqrmrcKA3RfsbA2VIhZMGTu92GozTrB1hx2pX3L8=;
        b=epM+PnN4i0LA6bRGbTb/DAeYcIYYrloPF7awB02JyMhYDlHqp71+HwmnDz9RbJH5/j
         RC+DMc3BsKOiYcMX1qerIPOOXLNqKTQCqJXiAl0D5GmnskKsScmLo+Vd4jcyUZhWbRiP
         wz4XYQI3GwUNAuP4ZTtOVbpSl+0zMw2oJYrjqww7P34274i9UF0YX3OLrek0dhpbWPOP
         RYvOxrRAIeQiUNO22fJSl40MY/Ou04GgWQJEJey+zM0l6EfxJHKxXTqe5XT1sz0Djlo3
         FXNVpfpYOdd0pZTiGNmzMy4CUoG970iZ8sX6/j4EDLz+ybqFbMgNdwtsN7mUAlCQ9EC7
         tNPg==
X-Gm-Message-State: AOJu0Ywnui1YIxOCbxHhdnjIkKmhKIoJoxIlmK9jOpSbwPbkrxypXSdN
	bTbD23Cs6OUHQxatH2k6SO8HemFe5WmZFDB9grG836mcNp+CxuL7mIE6UYfZm4tycjBmUB/Rvmk
	JrI26uU5xEHov1zQXSEYX1+rV64rBWEfwSndFBAax+Gs3Ao6iVZLIJvpi+1+sU9+HLBDXig==
X-Gm-Gg: ATEYQzwQAckY9IrxhLpP0gIVJ4rwpJj8TDFsCAPJJAfKp1jqU9QKhnKgS5soI9WhPOM
	5wM9LeIkqYOSn5SCtseqwshXwj2m2iTLxtjEpVTmeAlfL4C9eHOw6k5uYSDGpGRlThx/Tguym8t
	mW3qGtHs13irAKugSM+jUn3T4fTJZtrSIOhuwzwI/5ipNrejR7P39N6ft1HHG1aIncgMSLplJZ3
	5FAMpxoUeC3aYr4mWkUAEVr1W5tLKjD+DYINgKrQqnqtjLZR/Z3EtSU6nCtWWGXZZ3E7GYFJae7
	yIubPTroN2/484n1kl42BzLKlna7JmqOQdB8EFXKxjPpQ2hnGH8210oM7wLQ8XeGD+NJyGsFjzE
	C2QGMMEzdRt7kJvWw8mIs4++A0/BCVKgXBnCnrnGIBhCfE71RsxEk/HFY8T92/hlLRFrfY5CIIX
	0MjGnjuaIz9taDUVYeKZGSN8nQGFm6ri2Uir5uk/8=
X-Received: by 2002:a05:6a00:3d08:b0:82a:17b8:1474 with SMTP id d2e1a72fcca58-82ce88ea07emr6644292b3a.1.1775102075877;
        Wed, 01 Apr 2026 20:54:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d08:b0:82a:17b8:1474 with SMTP id d2e1a72fcca58-82ce88ea07emr6644257b3a.1.1775102075286;
        Wed, 01 Apr 2026 20:54:35 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b272bdsm1456189b3a.12.2026.04.01.20.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:54:34 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 09:24:03 +0530
Subject: [PATCH ath-next v4 5/6] wifi: ath12k: Add CE remap hardware
 parameters for IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-ath12k-ipq5424-v4-5-cd1e0f0a6c88@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=doLWylg4 c=1 sm=1 tr=0 ts=69cde87c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=LDmrCAwXcT0UWmoAFo4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: hxTHh1KP1S2C31dpVHunUDFshE_HG-Yr
X-Proofpoint-GUID: hxTHh1KP1S2C31dpVHunUDFshE_HG-Yr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzMSBTYWx0ZWRfX50FRAuXTS+dO
 MmAaaByJP+N4pqypI0oq2CmRFI1tN0cejmtzY9tDhA61gW5O2JNKRpF1Q63WBl48Jr78nZss4p3
 dr3DZnZOb2ScYveRCd5aGFYpTXtb5JlE+HG+N6b+dsRBYVj5Dt1xl7xFnAsEvE5MYSQdUJO3ylc
 CLWAoaEKLQEvVXQ2O3lAV75/zNlZZW9KTRgxWvZNS4Ui0kGFavaGRiH2kifm9b4slTgVgSLlHi8
 qVdx4kASrzp3a6jiiMXMB9+B3hMYqsvqBF8UhzekpzwdoH3nupxITwugE0xoUG6B+dQLIQEEdwb
 uPPyHe7EaoJJY0l4fLCNvV+1ARqgyozdq39SexzyuudZjc7KttpCl3UJuWwo0yJgGPV/LZ1tV+r
 +Gr4JyeoLzAGKG9iD18Uv9Pzd7Rfe94ZHvWAG4HYe5RUceeT7TFj6Rzzl1D4dVMZa86k2ilMFmu
 VpGJTTs92FZcu6n+zHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020031
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,quicinc.com:email,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34305-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B77A7383514
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>

Add CE remap hardware parameters for Ath12k AHB device IPQ5424.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ce.h       | 13 +++++++++----
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 22 +++++++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index df4f2a4f8480..009cddf2d68d 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -38,10 +38,15 @@
 #define PIPEDIR_INOUT		3 /* bidirectional */
 #define PIPEDIR_INOUT_H2H	4 /* bidirectional, host to host */
 
-/* CE address/mask */
-#define CE_HOST_IE_ADDRESS	0x75804C
-#define CE_HOST_IE_2_ADDRESS	0x758050
-#define CE_HOST_IE_3_ADDRESS	CE_HOST_IE_ADDRESS
+/* IPQ5332 CE address/mask */
+#define CE_HOST_IPQ5332_IE_ADDRESS	0x75804C
+#define CE_HOST_IPQ5332_IE_2_ADDRESS	0x758050
+#define CE_HOST_IPQ5332_IE_3_ADDRESS	CE_HOST_IPQ5332_IE_ADDRESS
+
+/* IPQ5424 CE address/mask */
+#define CE_HOST_IPQ5424_IE_ADDRESS	0x21804C
+#define CE_HOST_IPQ5424_IE_2_ADDRESS	0x218050
+#define CE_HOST_IPQ5424_IE_3_ADDRESS	CE_HOST_IPQ5424_IE_ADDRESS
 
 #define CE_HOST_IE_3_SHIFT	0xC
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 9b9ca06a9f45..a2c98cc1e348 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -329,9 +329,15 @@ static const struct ath12k_hw_ring_mask ath12k_wifi7_hw_ring_mask_wcn7850 = {
 };
 
 static const struct ce_ie_addr ath12k_wifi7_ce_ie_addr_ipq5332 = {
-	.ie1_reg_addr = CE_HOST_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.ie2_reg_addr = CE_HOST_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.ie3_reg_addr = CE_HOST_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie1_reg_addr = CE_HOST_IPQ5332_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie2_reg_addr = CE_HOST_IPQ5332_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie3_reg_addr = CE_HOST_IPQ5332_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+};
+
+static const struct ce_ie_addr ath12k_wifi7_ce_ie_addr_ipq5424 = {
+	.ie1_reg_addr = CE_HOST_IPQ5424_IE_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.ie2_reg_addr = CE_HOST_IPQ5424_IE_2_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.ie3_reg_addr = CE_HOST_IPQ5424_IE_3_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
 };
 
 static const struct ce_remap ath12k_wifi7_ce_remap_ipq5332 = {
@@ -340,6 +346,12 @@ static const struct ce_remap ath12k_wifi7_ce_remap_ipq5332 = {
 	.cmem_offset = HAL_SEQ_WCSS_CMEM_OFFSET,
 };
 
+static const struct ce_remap ath12k_wifi7_ce_remap_ipq5424 = {
+	.base = HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.size = HAL_IPQ5424_CE_SIZE,
+	.cmem_offset = HAL_SEQ_WCSS_CMEM_OFFSET,
+};
+
 static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 	{
 		.name = "qcn9274 hw1.0",
@@ -822,8 +834,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.iova_mask = 0,
 		.supports_aspm = false,
 
-		.ce_ie_addr = NULL,
-		.ce_remap = NULL,
+		.ce_ie_addr = &ath12k_wifi7_ce_ie_addr_ipq5424,
+		.ce_remap = &ath12k_wifi7_ce_remap_ipq5424,
 		.bdf_addr_offset = 0x940000,
 
 		.dp_primary_link_only = true,

-- 
2.34.1


