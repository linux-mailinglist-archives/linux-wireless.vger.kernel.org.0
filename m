Return-Path: <linux-wireless+bounces-36621-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A/DZI1W6C2riLgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36621-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:18:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B8575F9F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91FFD306094F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 01:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29181DA0E1;
	Tue, 19 May 2026 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VNKsHQU4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rp6W5vDw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C327B32C
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153402; cv=none; b=u3KNzu6B/ovsBW6l7nvdeXJg6Rvn1IpoiB44h3dg3TGwP87a/E6fedqBPqEB6eFdGwzBE0qyygZMIFgYU+DjP5TswGOS/iifMnHoIVHtufsjyh3VBOiqpjWJ03eXeBNz+jw0NxJtZrwZyZrlPeLbWyf7xStzgvv3rc2nd0AuAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153402; c=relaxed/simple;
	bh=i35RztO7R7E/jr8HG99R3xuekBUX3BIyeCnh8bKifaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rsOfdsxriwdDyS3PHcSW2OAkk5kOMLpwJgKpb65vfnpp/GgyUJctKhZguCSagSfd79HzQl5fMualyHYz7r85OaA8TrTNXTnsz/Ksiym2D5Iiy51PEodZDSCwu3vXUkEgkzm2Ds+RfvrBpB59RgkmXM9cMlCT0TFfQb2MMRnzWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VNKsHQU4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rp6W5vDw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ILKCkn353057
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QeEKpg4+swA
	NGEXGj1FSmAom3Yj6pHYjgmmzTryEFr0=; b=VNKsHQU4zJm5EWQw34EbTAUXOBY
	UHt3VF69O3lhmzEQ0CHVLtIon8QOgeUw9lmTpbH8y5fY9gqSAinepXCB5ARxpXkW
	RofDFOBiV6uzCFSFPz2IfvKbSwlpdBpvgeTPfoqScF/mhvDoLk6Pl9rvEuXU5C/p
	j+TsarAgeb5unkDAL1Dd1clykBJp/hVv6k7p89SWvol8p222m1EWhL0c7aaEVq+S
	dLtnISzIFaBT/DfhUn1Uc2GRa25YRxBflC3+s/9Ft0g66Oxm0cW04zL+/SsbkXVi
	k39hj3Nq5HL+VveprkmNahMqYSS8CNCeosNMeuqE0YSDFCIK1Ny/0sLewiw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xjakpmn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:16:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba6fe41283so30496065ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 18:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779153397; x=1779758197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeEKpg4+swANGEXGj1FSmAom3Yj6pHYjgmmzTryEFr0=;
        b=Rp6W5vDw00G5YPLpSMOnQnRpoZv9HgNHolamKTcee+aA8tFgp2HWny4T86vFrO6nzr
         E31jODXPWz7u9xTkTL+6CYOqyyqXrlNaOB+D08B2qzPOhTDsjde486GK/XvzFU4rOWc2
         ax0SaojdEGk7s1oUEX5upUeM0mGnCbfqQl31VbwfD+RWLkvkZDPBQU8Y/f085HgUST+x
         SCamayANLx1bGJBT/okhmJ0dkwRGOQRoBdOXOFSq/z1bGeqe9vwVoac0uK3j/KLsaTKD
         +2flQRGdqBOxN2FNh6PXfcbf3vdikEqV2MNygpAcUZPGmgV2mdD1T8N+qOs12/MwxdAp
         Kstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153397; x=1779758197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QeEKpg4+swANGEXGj1FSmAom3Yj6pHYjgmmzTryEFr0=;
        b=LLqgdLpm/1CyV9QgsRFXJcuAHaxb4xEFUWkq9jf2OyYXovXw7TPv2REt75KzJR/m4S
         7nTco3QxTRwUPawXzFIWm+fCHIGcwtaViZyI2rwYk3DXe9DNsaFZtDPLNH+953ZHhbRH
         SFFNAJ2W40XDiwKyL7pXE+lUvKyX1jFbwV3nQxLbwY3XdBfziSZlW4tFEJvcdOWgqxV0
         4vyKh85kYNoK3FoEJbBMFU/k/uAWaz1xw64ENxa1RS+iGvxHNirjxCBoWf1qx2BW8xQ+
         wJznwD6u6nDkkC9a00LkvSZfRbI8uXedSmW8CWsFLIooHSJtF+DX6RBosoONYPenza1g
         RQDg==
X-Gm-Message-State: AOJu0YwPmMhFMjhDKPCYxM3te6Uvc5bA7yXEwfAXt6n6+v5tBehKKzLP
	hIx2iyHvDIEhYLQgEOLAiwYWvi8/ifcg1xYjsxhmcApI/gH6Yp7pV5G5+ud/eAeKTkCA1CePQTa
	ZUxDpOYs/Y5JDAwD0bslyWBRGP3NUZu/M/Zaduf+QJ/2xajcDUn8OHaHh6LFKcq/fmSV32Q==
X-Gm-Gg: Acq92OGkO8PsryT2nTBoDsXP/15L+v6yEU6FwglOpY4pTOck8MGqqhVVEYG0nid8Ze8
	g9IBgAqCIfB7weJ40cZQvboiY/Szs/rYjCQfjH2G25qpdhsXS5JMpCWL8eW8zfvWqXRqt61lXRA
	zLYWABDDn9K7Jq1pQlFNH8MVPFpPSfn5GboD0dOZ3hRrS4uy4qTZ8M5KVaYWVbld+KcV33ZaPrB
	hM4SLtT8ZT7WnQRWiFmPZ2KyqXjszF8RWl/JsC878OyuEScvl2Zfo9phHo4Sn/yLkRP5sIzJgds
	REcZDYRGKvzoomA/W6re78oyjL2e+UZSA/8smZ+UNBz83FUPlb8rIFz6RVibvjnOcYlMXlgr64T
	uG9Jzst50/zdkqnp/mDqkilvoyc+cbnyx7rf1UKd5PglBuxCyMCx6lOK/ItFrwXkZ9GNn9T6EUB
	6L2hggT4J0dA==
X-Received: by 2002:a17:903:3d52:b0:2b9:f55e:1c1b with SMTP id d9443c01a7336-2bd7e85fcacmr132809655ad.5.1779153397105;
        Mon, 18 May 2026 18:16:37 -0700 (PDT)
X-Received: by 2002:a17:903:3d52:b0:2b9:f55e:1c1b with SMTP id d9443c01a7336-2bd7e85fcacmr132809395ad.5.1779153396637;
        Mon, 18 May 2026 18:16:36 -0700 (PDT)
Received: from hangtian-z2-2004.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49a4sm151727265ad.38.2026.05.18.18.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:16:36 -0700 (PDT)
From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
To: tglx@kernel.org, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/2] wifi: ath12k: enable threaded NAPI when DP IRQ affinity is unavailable
Date: Tue, 19 May 2026 09:16:27 +0800
Message-Id: <20260519011627.713068-3-hangtian.zhu@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
References: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAwOSBTYWx0ZWRfX+z/JP+Juk9Nr
 VEVcmDXHzln6mquPQSCKcHyvsIhcGFkIP9Uy8PyXoGHMBdMk3CUza4dz2IJ5t3aWTI+0xQY53zx
 JjeQouXMGCo89HGpC6XFDgo8fGFovERfRErX3dtpzyIb1lRKqL1HHnvWDGonqSOpFF6588Gvaya
 8oJe8HLZMkVtnFwbIAc7gydz5KSuzLHgL2zdjXZpErcdGjEDAOixoPb80DJvn8iYebPW5ibr4ym
 n2iTnLbH0td0Dvd0rcOCUDe0b+81PZlDSFSRHVHVujcmApA/v3Mq2B/pMOLWigT05SUjrWyKfxv
 /iPl624PEg3qktFt7+U2GBNaQZ56ROJe6PXGEANXgixBaPy7IulrzZOHwzbbP6fUZLKzg1uq2ni
 tfXDaWffvLX75LG/1BGO2JHoAIeJ9HZafY5HLZ5pLETVc4MUXqcTCcte8yGS6abkb++ouVnjTOk
 Awt5RBDA7pclvXYHcnw==
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=6a0bb9f6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=--8x25ClVUTr5G9MgJQA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: lcRA411n-RQLVL1XdSE6iG7coA9plHjh
X-Proofpoint-GUID: lcRA411n-RQLVL1XdSE6iG7coA9plHjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190009
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36621-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hangtian.zhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 122B8575F9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


