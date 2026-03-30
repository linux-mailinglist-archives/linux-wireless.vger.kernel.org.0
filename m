Return-Path: <linux-wireless+bounces-34198-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABESAEjgymnEAwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34198-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:42:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A577361105
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21410302510A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 20:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEFA3A544D;
	Mon, 30 Mar 2026 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CdQs4war";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a9nFnuLT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B123A4F22
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903179; cv=none; b=h4Il+7FWspx63rPYG7tDX7yfyJcWYvUXQ8L1mI2ymeODYY6Vy/jkux/w8Cb1zWiHIZWiwDdEQ6QhHSWWIZpsjYct5YT9hQMy1KOVQPj/xTAPzdHyFNLATIvrC+F+x9Eyt10rmpMhkf3nK/pu6jCbZlmHUzYBdbiU9fVG13MHE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903179; c=relaxed/simple;
	bh=jI3MJb34Fpf484h0NsiAZuAs/DRVNF3NhnamK3BdUY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXxKZj8T8ZpjTddiR+cBhEUXRywp8pEX34enb/n3+yohIzt72vxW0GN10i8WdsCvgSxgDdbD8w6IyXRd+gPftJ0eh85DfV6XZvh1tIYRfiWzaH5DuUQANbjwqYkDrmKfVRUKLFiNCSVDXTniL5RwT2ZycTwN+qoYPDA5R5V3SgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CdQs4war; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a9nFnuLT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UEpUb93722183
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/NLOqrmrcKA3RfsbA2VIhZMGTu92GozTrB1hx2pX3L8=; b=CdQs4warMj4fzqle
	7RxxRMRzoti1GM2zpsPJRpZxOL5JIRaf47yiN+bm31KwsJrAs+dh9yUWdP4m0SN5
	ca1QS+ve0nf6i6zo1NGEq70J2oMYBi0Qxdtro7FX/zmEdwhv/PItguLbqF0raMuR
	WNX117kpogo853E9rp6hNatmmIPJPuRNI0XK3nzAQQuL3Sl/vMl4ADtrdceWeOWS
	A3NGewZib9839jpW/iCZasiH12Sn6k6TZQ7EF2cXs+Duf/tlJvblizRNuQ54yFko
	d6UaJTK6G/5qsdixUxA0N+MIxMj/PyW9Yd1NS3qBupwfuwV+qvx6+cmQKxS1Uq4d
	gQepVg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7pvmtg69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24305cb3cso27763145ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774903176; x=1775507976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NLOqrmrcKA3RfsbA2VIhZMGTu92GozTrB1hx2pX3L8=;
        b=a9nFnuLTk+JXv6G4AmcA0jOcyVbcHS1rOAPjWFXnD8FDLtvX/mRdBNTGPB0KaxPi/I
         4fyj0HDqU4ohmjsJZ9LdOLhUlvuz8ZUU30w6zNmIiy8yUi5UPVh7Neyw7FIAQjFqN+KJ
         tH8k46ToqJfiADhsFE+p72Yzrp7Ah/pa+8HJboBV6ZBiCgCx9DYRj3lW0pviKicE/HoU
         UK7Dmvzn9XAOMv9eQ60aE815pOXg110Hhohw1awJrXBeFgZYAxAZgWVMKGjE7+uftcCM
         +6BEYati6urJkiovNeWLUV7F307PjPisLEovT98xoAfBJw4vzgUjY8DRZkyFmbHNXozm
         pj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903176; x=1775507976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/NLOqrmrcKA3RfsbA2VIhZMGTu92GozTrB1hx2pX3L8=;
        b=BIt1BSPXzUae/F2unZF8cIqSfudg7m0hUVznyd7rWe8VLiAV39GSYuGOWs3WMjZxey
         xs/KMuc/7bTiqhHrRmdWLOWWmJAzAXgo9TvbBArlMwYwo9n32hrbfOakksw7o31yMD2E
         6cg0O0Ob7gY3Xxl5maYxdwfI1WUg+xlEmHC/zNlIlFeBI0JOovppp3tqApwAoKE2J+xk
         8J3rQr7uIpeZXe+rD8bpg03LPIA93Dc4PQG4dFFog44ozAe7XSp4z2hlRQvCn5FBRO6w
         oZtDAVUGDhscyrFfR5wLU1vNGFtXdsYrgWF570W1iEgfhVR4lYJeTztDnFD+9BdQaqo3
         c0AQ==
X-Gm-Message-State: AOJu0YxCqF5T8n/scroHH5ztN2GVTx62x8z67SWJObq8OsB4IY/7AVGf
	h+NnFMrwYkHaazkXTd55UJ7Q+j55aZWzJHi0fgNnuixkKKvCmR+sgu2leJW8WBj69YdTomJxhtg
	Z+6IEAzwVR63SdFLM0mFe3D6R/OvBXn2MGSw5ui1/dvuLySQ2KtzSDFIKbdCSqdxf2XBy8w==
X-Gm-Gg: ATEYQzz0CgiHL1i33xYc+zKupSth5zjfAoIOisRw4ywIATy50NflmnqFiPID44jAZ/H
	qr4aAHiYd2bih6NQ5df5GpSjt4O3K3/NmQE3Ya+f5Pu9IMO5UGfxTbPg7u8eKjPdTFCWk2Y0zCb
	GywGmpRHVj5ydT6hablTiH1k3vrufyCdv/0WVKdgEjn4cz5K5oBvoZNG3s2xhIBpN+R30szyFcj
	JgVi9dJeilF/SYyvpdisx0bvOZe2gL4G4EJV4fY4PPRl1iu6BVQ3z6Syk5tVGzJ2bHV9MdU0Hmj
	n/LK/A1wV8qtKIPTyC9nLxTzX2ffakEBpW6GhhpGvo8AFkT8zUJQK7oGeHmMAFxncOTUQiaY3o6
	5Dub9W4OI7TuAdNNudN0b3pmcrG8cGKsWllN3DRctleu/+uf8Zd+qpglT8OHYfQE2/OTFlT7KRM
	6J7BDsYClR6TXBQqdpFl8v0qm/4UTncuuHhzA+pN4=
X-Received: by 2002:a17:902:e802:b0:2ae:b991:a46f with SMTP id d9443c01a7336-2b0cdd1a6b4mr151261775ad.42.1774903175753;
        Mon, 30 Mar 2026 13:39:35 -0700 (PDT)
X-Received: by 2002:a17:902:e802:b0:2ae:b991:a46f with SMTP id d9443c01a7336-2b0cdd1a6b4mr151261475ad.42.1774903175208;
        Mon, 30 Mar 2026 13:39:35 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c3a4esm113517195ad.78.2026.03.30.13.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:39:34 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:09:10 +0530
Subject: [PATCH ath-next v3 5/6] wifi: ath12k: Add CE remap hardware
 parameters for IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-ath12k-ipq5424-v3-5-1455b9cae29c@oss.qualcomm.com>
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
X-Proofpoint-GUID: O-lDT93lZn98zWWD2P9UO5VJI3qDwb7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NCBTYWx0ZWRfX75NL3ZtEeR2u
 DsP0um8T4UGUhUYuEW9qc/U6GHG4ochM2xrDmzAKj9jSpD3ovGRmRTZsltasYMxGIJJcVi+ALB8
 7ex+O1GSaSjgXUdALMBmD/g6PcXDq5U1CzMpdx3+EdDY3bbalSPr2rbf6VK1QqXWAJ1fiI0pVcl
 rAGMwDY4ff7/nOBAZNfmFKShWaYLK6DGMC7Ho0uaxiJhLM9ZqztNZKRZ4rCXAv+J2Y3iTLzO3B5
 envaNytsOOn80bM9P4RkHK+9fB4VP2CIRgYYCJJtHzsIylth1Lk+9fZ5y8pfUJgBK5nHXKRKuML
 FnRhSV/KMyNsFQ45zm+LT/fzOchBVwhakYr6rSCpPNDCmfg0WrkSI7/Bvxf7MHnWAYBu/NBUpRO
 9yRIzvy8iLA5K4PitqBFKZ/5iyAjhfQ6ufMSVZE1hgd7PT2405IFb9qUeG9Q7LMvNK0x3qyx8LR
 uXOeWoZtWwDI1KcEZiQ==
X-Proofpoint-ORIG-GUID: O-lDT93lZn98zWWD2P9UO5VJI3qDwb7k
X-Authority-Analysis: v=2.4 cv=S9rUAYsP c=1 sm=1 tr=0 ts=69cadf88 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=LDmrCAwXcT0UWmoAFo4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300174
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,quicinc.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34198-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 1A577361105
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


