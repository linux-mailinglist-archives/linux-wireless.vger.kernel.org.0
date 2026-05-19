Return-Path: <linux-wireless+bounces-36618-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCf5EAm4C2pZLgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36618-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:08:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4348B575EB2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26F433010523
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 01:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF02414A4F0;
	Tue, 19 May 2026 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IkdTOtGf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F1nHeZMC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50177273D9F
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152895; cv=none; b=PuZE5nqhLZWe1i+8TmPR0iQgTBOuiY9uRkXbDg6Ejmrqp6rbSq0uUEqjqhgSM8bUbo7kIWB2/HvjeH9KtrzKt7qODgBt1K2gVbUqF4wOpNKC7xksDL3yQgVCk+cnGijxy7iOmWa73APE96bp/Nf3kIKXhLuo3PCBrliMb8XSz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152895; c=relaxed/simple;
	bh=82W8X6WjVvgxpwWmaYIi3oqMBM54+IJiysY4Vvipr1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRL6i4GWHUEwfh4MDTpwtNAQbACtQWGeW4XrbwIbqe5pZ9l35/0UqIRCkCEfXhau9TnHLx3sUHevyD2SJhOdU8T5o4iIxep0r3qWOVEco4EA8nL8uUCO/CME6C47Oy7pxU5cH44WnFtC/5LuMbZshzHKEyJWgz076jj1DmCMg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IkdTOtGf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F1nHeZMC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IH1wih2091139
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=80wE/aXvl5M
	YFDgaTLolK83rI9KtsH8kzvD/cz5hbtU=; b=IkdTOtGfdHWRWN54iOF3gKeMkql
	bn2SF4JvZER6PAKMmkzjGqVh88clRv3SQk6gy73OD3m2q88qWjInhOEWyZw5/qU7
	NoupC7M4wpJpw0iwYssX5HHyqcJW5mUeKb0bgvqCaETUKkUmD+HXJqa5jLnAPDGm
	boNEcL7HNKd9YZkL3pJcZTPnDLTMv+yvj5uAKl0WTO54r5lvVeGKXrFUxRIUcYX7
	poklcA4KL+iOVpxO4qb1xvkmR45AsInKHshpts4wk3MwO15ASW0m/rjv81Daiv9T
	Fv95/ZvrWmpScA5U5OCBwK27/WQBo5bFqvh+EVdlWv1k66YuTNsz7Txzc2A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e80rpk1uf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:08:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c823549b1fcso5511056a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 18:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779152888; x=1779757688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80wE/aXvl5MYFDgaTLolK83rI9KtsH8kzvD/cz5hbtU=;
        b=F1nHeZMCav3FNiJi2ya2Jx6hdWKvAQO/L8jJtw73DBKUOeeFR99pU4lGOZwrDKVkyj
         CfK4TAxzi9hp4UmQZtiaxJ2VpruMWdKcKRTpmoOj5ShngONBpIkOoIjfUfIRo5wLMn76
         ETYSKr5Sk76WrCeAp6B+IIl2JFewgK6yFwVrD4euudEL4A5pzW5G5bZGxv+jLq8R0MZp
         0/Nv/BKZesCRh4qkXZp6JQHDvalLJ0MTRSQfGnKaWLfcq4w2M2fbEQ+Du4NGJAhOLQKY
         05jZIYpxOWv5tVbE9C1I1PQean2IoO6gwTkrUJAD7SAQUSicKvsVGClOrC2XUIXGMDu0
         QNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152888; x=1779757688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=80wE/aXvl5MYFDgaTLolK83rI9KtsH8kzvD/cz5hbtU=;
        b=fVf8CKiuPNtW19KhC6T+hNxLi2zbvrTfTgoeVX20lwEHXhpYCGtbB39D46ochLECrl
         8XWRxEFUiRs/l12kr2qmTl/WfAx+IEz6Fa9uyZN5w6wjySCF8biq6qjDtYTX6uYyjSWK
         qvzV/DX8hM9iDkmVreM6whH1LXU3xeJaDGjtfoh4BuVYR32C7dT+VDGqixKHt39PQRAc
         0ERVKr9GLMbQ7jmuTJ+FKBKe9cioUq80oVkVmJShiXWPVA1ksrBt0UmZgo6ZG+oUGxK1
         8cEw+4aqSCCAHXvbTqQ4ATP5rVfc4peWiPa7EktJwJzjaajj/kwk4azU/nBq5Ryo7qTt
         H8Qg==
X-Gm-Message-State: AOJu0YyU5RWg9ikyaz3VLzZpnrKHf8HbQrX2abnxuew4Ulty8N/Vq6u7
	jMseoA1GjLNxuTVlygDRvKhGTWe29wbevUtteguY/PTIH8mzS7xN9+TLoGjO8T706FSQaUgTgGo
	ypi5slohAsmKct5xw4MMO991qwrIKIm2AfTR7ljmzDFJLq4kG+X64ih3YrWQZyfY8lTq+ig==
X-Gm-Gg: Acq92OHO20K9Rm55OBeLLlZLx3WlF574Oy67wTSsVl/bQ24turfsbr8x/m9yl1n2f4u
	IM2LZi5vP2m/AFe3tcIbdWfNYUuuIi2c0y202klhLHwo3DevA80ECQHcpDpCKWktgFeDZfQpkD6
	WRfVsbUY8gGVAok6oY3eSfQmoXycxIMeFjsS7kHxrWpdaKTCzlQV7fJi+px+LwDh7HMicsdFEXv
	dpfBjHoJCQ9S0JuxnA+IP+74BhOAEvd5ORiy8fPOjfSj4IfQ5X3Af6wPjpPHL+SofXeM0vQtNGw
	n+K5CAdsKR/hCy6aMlSgFGGE7Y3mArKEktS8ahPOinO9X+ov0B4iFUhmkFo//uTtw1F/YDO2Lkg
	AmYhMpyDgkBgLN2U6ma2RdrkNUcmSg9LA6hlV0kMsvrLZ46h5RNSjFP5w48IJOZVoI6ubzxu9H+
	pUjUqU
X-Received: by 2002:a05:6a00:4c0e:b0:83e:d52c:e6bd with SMTP id d2e1a72fcca58-83f33c9bc80mr17854603b3a.38.1779152888239;
        Mon, 18 May 2026 18:08:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c0e:b0:83e:d52c:e6bd with SMTP id d2e1a72fcca58-83f33c9bc80mr17854572b3a.38.1779152887710;
        Mon, 18 May 2026 18:08:07 -0700 (PDT)
Received: from hangtian-z2-2004.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1942a83fsm16196793b3a.0.2026.05.18.18.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:08:07 -0700 (PDT)
From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
X-Google-Original-From: Hangtian Zhu <hangtian@qti.qualcomm.com>
To: tglx@kernel.org, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] wifi: ath12k: enable threaded NAPI when DP IRQ affinity is unavailable
Date: Tue, 19 May 2026 09:07:58 +0800
Message-Id: <20260519010758.712297-3-hangtian@qti.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260519010758.712297-1-hangtian@qti.qualcomm.com>
References: <20260519010758.712297-1-hangtian@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ztuz9P32BH9iHCpAkG3WVbriXf7H4PCE
X-Proofpoint-ORIG-GUID: Ztuz9P32BH9iHCpAkG3WVbriXf7H4PCE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAwOCBTYWx0ZWRfX46+oLQik9zh5
 YHTmsI5iLZAIy5SNcTgZp24cfxlb5Uypq7z2PFF+ceqcZD1HnvG8bMMtb4I3DS27hsnylBVJEPM
 TfkaEXvgGyBN/UvqARDKnHXeG0SQ+XkCbZ9r3B4kLF/I8is9MsV0bknLkOuvw45kGo46WZADFVb
 o8/7i52KJmZd9Fc2TOi0YjxUOwZIUQ1LwpU0FuZmK0zQA160ndxjV3JTPghGiKF5h1jCNI7BkA/
 h4v+TiXL+LnapLIYB+UkOL1Z4/JSmS2enmP6ASoTCC+ndPF0ICgRmfpZ78HiZspKOdQxLDfmmFl
 jxsW0ArGXuIHxT7GLJL+dViu5LsfzoMwvpAPA4z2nrDtD8aYZXgHJLEP7rc/upCs6BtExpjhgRQ
 B9zauM8lHsGa2qFFj75gjDpqVFaVwYaIIiykkIRGIPojy6njsm0y1Zkcqj94Syk4LK63JGqSCyy
 FXcRYTXJxvs2rIbyxGg==
X-Authority-Analysis: v=2.4 cv=ecMNubEH c=1 sm=1 tr=0 ts=6a0bb7f9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=--8x25ClVUTr5G9MgJQA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190008
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36618-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[hangtian.zhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4348B575EB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>

Determine threaded NAPI policy from runtime IRQ capability of the DP MSI
IRQ.

If irq_can_set_affinity() reports that affinity cannot be set, enable
threaded NAPI for DP interrupt groups so datapath processing is not
constrained by a single-CPU softirq context.

On RB3Gen2, where IRQ affinity is unavailable in the effective IRQ path,
EHT160 UDP downlink throughput improved from 802 Mbps to 2.58 Gbps after
enabling threaded NAPI.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00074-QCACOLSWPL_V1_TO_SILICONZ-1

Signed-off-by: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 375277ca2b89..065449806ea9 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
 #include <linux/time.h>
@@ -537,6 +538,8 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 	int i, j, n, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0, base_idx;
 	struct ath12k_ext_irq_grp *irq_grp;
+	bool threaded_napi = false;
+	int irq;
 
 	base_idx = ATH12K_PCI_IRQ_CE0_OFFSET + CE_COUNT_MAX;
 	ret = ath12k_pci_get_user_msi_assignment(ab, "DP",
@@ -546,6 +549,10 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 	if (ret < 0)
 		return ret;
 
+	irq = ath12k_pci_get_msi_irq(ab->dev, base_vector);
+	if (irq >= 0)
+		threaded_napi = !irq_can_set_affinity(irq);
+
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		irq_grp = &ab->ext_irq_grp[i];
 		u32 num_irq = 0;
@@ -560,6 +567,8 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 
 		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath12k_pci_ext_grp_napi_poll);
+		if (threaded_napi)
+			netif_threaded_enable(irq_grp->napi_ndev);
 
 		if (ab->hw_params->ring_mask->tx[i] ||
 		    ab->hw_params->ring_mask->rx[i] ||
@@ -578,7 +587,7 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 		for (j = 0; j < irq_grp->num_irq; j++) {
 			int irq_idx = irq_grp->irqs[j];
 			int vector = (i % num_vectors) + base_vector;
-			int irq = ath12k_pci_get_msi_irq(ab->dev, vector);
+			irq = ath12k_pci_get_msi_irq(ab->dev, vector);
 
 			ab->irq_num[irq_idx] = irq;
 
-- 
2.25.1


