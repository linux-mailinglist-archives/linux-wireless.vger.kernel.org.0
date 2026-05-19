Return-Path: <linux-wireless+bounces-36668-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICLuH9q5DGoFlgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36668-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 21:28:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 835145842B0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 21:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C6D4300406A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558693A3E78;
	Tue, 19 May 2026 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b7QL9BzQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HX+clHse"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45A371052
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218901; cv=none; b=r0aMq071C1tkGFYZNVIvmq/bMNL+XqEMNzXJbwttIr3pscaq7EJSSm1iv5EGlL7fZ5j1ko7FA/4nYc5fzByyyNjOc12nsMEk7fwQKtrbXbW5DDrnxmCGxhysmNYxVC1/RLpMcJ3g3AAaBpHmDJzcFbUnNt0ZbWL/ViKt1AV4wRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218901; c=relaxed/simple;
	bh=wEDWjQyJ+3zirFk7QR/oXa6vzQojxRbSjzQ3G4EiNQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q67wwHOCNDAKbjJw+3+Z5Bbz/3/mGZFexr/nQRw+Oj+C9wj09Tq/vii8ClwrnpxJ3bIqA9KDQ2IfqmHBtPeevgQ7VPMLBYkmAdaEvGlTm+t1Wd/cQU6LYaRpjhQQ3cVrGCN3+1z+dmkKkYHAErGSBVS12GbhHLTI0T9swR6x5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b7QL9BzQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HX+clHse; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEwZ6q629613
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 19:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EdOeg9kry5DCuhVDvfah3Cl7e8TyQfRe7gs
	fuaY4ir4=; b=b7QL9BzQEIYUjPGzh1YP6aIuq+IezWk55BiQ0BkoyBruIVDGTfv
	solSi23EZRdJmH/f0lWgHbY6wggn7hXIdfDMn2senOtlnHmaSZo0/Jl3ifWjrgbE
	4XPWW1q6w9C49iebJ3Un+Ye9IzvQ0EezOKsne2TYU/uT98K05D09AA9VoRgy5Dpx
	UUeNz2fZcHHCKgOlh+K1N7UE2vz+OohoPBLP1VkwRAMcGDkKU+xUs8XvTF8FyUQz
	wUfjiLuc8wsh85lS5aXwWBVvHqw6B3ncFEshH1eGxZhaCHOYw/1g0L5wPT6/DGhJ
	dyXtNGl7QNCMA8laPJwgdunPLrjYYOVdFZQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3ns5k0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 19:28:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7e7adc4f8dso357108a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779218899; x=1779823699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdOeg9kry5DCuhVDvfah3Cl7e8TyQfRe7gsfuaY4ir4=;
        b=HX+clHseg/pkq2/Cyhzj2CZb1f0O4L3hZ1iJRZXPCIKkqEfm8rRWFkx5OgMNhboyM3
         FJeAq5ZOLL8GAvANqb45CVLPGNJQiQvmSTHkcsNr75ljQWXlWFAVB6W0eyggrHXhCka9
         eMVQNyfngs+JYcAn6HQoxL5IaQvxYaVbgZot8zrZVCRnL9TeF+nRT8Gu0WWTOA+95Xnj
         5EKKOqloDkJyI8uyayW1XdOoMY9cAdspHxBCDF85EDMEcWHomgJw4g7cipdd22Q7wTzx
         j6YnAbMAGx5rH+lZHB8dAyVHdikGi6u+iDPX6K2K6Q887E8a+xMH2bRSqlm7sSHgCCH5
         YaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218899; x=1779823699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdOeg9kry5DCuhVDvfah3Cl7e8TyQfRe7gsfuaY4ir4=;
        b=DT6PCO9LdxI6iPk2RANzBD2ep4ogjRFU4nAeWhuLRweGqEBE25P93bacB+qybgSBNf
         px3azjjIRvxEBkToB3MFpziAEgZvt3+5sDKsM9xCqS9opEEBObXfWN93LEnPCwUiVIln
         l19BqQmC/174bmN43N4bAOFp295dYtOb6G6f9qOxL5dlXNDRAfXd7Um1bqYcUIQ3iKn1
         k69fcxKeYgZiijUv+KhNxA/L+yVT8cU2ykt/AZeh27WlkzaVKK0t/oYmLDwxFMfaGzeg
         NXNlyE0U4PffLtAU9xAqszdQK/Rxn1YmSjwLYbXFQGHSV2b0PFZ6qDCgy8Nf6QxD7AP2
         X9pQ==
X-Gm-Message-State: AOJu0YzRtzmt8sp2jlpUWnRBLT0U/DUoVpMlqWqBrnsL0RxtoHuShqMH
	/DsbgZnyeuQILBaeQBlyMw8aijs4H16cHuR+gQMu6DxuxhDyJWo6RSnW1lcJb4T3agwY3n95z5w
	xmTCs6jePsGvwM1XHZMAc6j06qdHsOoGRGIckQaGSeYo3t3go1jDVjW/gKnea5FyTYhttqSdDVZ
	+wsQ==
X-Gm-Gg: Acq92OF2zZlZdfWOXnS/p7F3lo7hYElln/LGSZrPRON6iOAlShZs8KLBb0/BvLwrWl6
	kMNbH6u2E4WH0RGJI0km1eFZIbtvUQzsTTdW2NM3/1ZvLzcOvS89xkhLfiYhAnT89FnFx5fuO1L
	p7xcDrgHxKbFXR3HHRKq3nILSF6JJ3Vd9WY9CVMli2e7javyi1FjmNJv6Zgb3GGkNWVohjzACOD
	vUGWWBYBCsnZkBdLP7mgFlZ+cwZz2hSUN2/jlGmlVn0yuf5x/uEypcJOLjxc6HZbzSKXhpxe01J
	RBx9FvpRWlloF5tEB0vrxHut0G6rFUjqh0E1wUMK/O2VIMAyrUUp66R4lvhhanutGuXRjd5DSSa
	yySjrvu/uj+zQoJv1EYwQC+uMutEUj+ZDetyHNUDHuLWs0EVEN7juj8nRMs2TQhVWfvo+kCQRro
	Fx
X-Received: by 2002:a05:6a20:9153:b0:39b:8b59:4ec9 with SMTP id adf61e73a8af0-3b22e178e05mr13015348637.0.1779218898869;
        Tue, 19 May 2026 12:28:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:9153:b0:39b:8b59:4ec9 with SMTP id adf61e73a8af0-3b22e178e05mr13015332637.0.1779218898363;
        Tue, 19 May 2026 12:28:18 -0700 (PDT)
Received: from hu-rdeuri-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82c4031662sm16778813a12.16.2026.05.19.12.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:28:17 -0700 (PDT)
From: Ripan Deuri <ripan.deuri@oss.qualcomm.com>
X-Google-Original-From: Ripan Deuri <ripan.deuri@oss.qualcomm.com
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath12k: fix error unwind on arch_init() failure in PCI probe
Date: Wed, 20 May 2026 00:58:15 +0530
Message-Id: <20260519192815.3911324-1-ripan.deuri@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE5NCBTYWx0ZWRfX6RnAXdVUHoHx
 Rq0rQkIhWlGrYMzt4NOO1DQfbMVn7JdFoWHOs4a3x6rmqxdt+5XHcY2umGBuvtcXYC/w6tfAnDz
 gduVBD1xvSFNngZFKyLYRtPTYAqI/pFsnqvHdIkmCovU8s53abaYOFKp5CKP+9xNdqs/cRdZRZh
 uZG4xQxI2Hl7Oh1Pn5KRc0dllCOQixx5ccRJRgbanSAUgBR5EDSwzHjRenI3b98UUiBqUzr0/La
 rMKbpKLm+NswMzTNds8KwS5imsw9bCszorSxKWQLIjta/9zJBmk+UuycwQ8eSsFHi/6KJspEH6y
 9bHdOUNdbPewBfeHdYPitvUMF7Z/UK3fDGcW1J5D1ILL6NBTQNO6n97zR4RaN5vE1wv2R0pbY9J
 nRqO5PwSGZFMyTUzpwZCDBnYFZ06+BPFiKa+wF7wt+vuv3I/Wbb6IVDSOA3ZTpde5N0kUdT812y
 At+33LDek5rEjXDGJuA==
X-Proofpoint-GUID: JxbaSE5B6D7qBYN5IIPFF1pVZDSySCud
X-Proofpoint-ORIG-GUID: JxbaSE5B6D7qBYN5IIPFF1pVZDSySCud
X-Authority-Analysis: v=2.4 cv=Mr9iLWae c=1 sm=1 tr=0 ts=6a0cb9d3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=yK6w-Yv6rmC57_qGVNoA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190194
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36668-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ripan.deuri@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 835145842B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ripan Deuri <ripan.deuri@oss.qualcomm.com>

When arch_init() fails in ath12k_pci_probe(), the code jumps to
err_pci_msi_free, leaking resources in teardown.

Redirect the failure path to err_free_irq so teardown matches the setup order.

Compile-tested only.

Fixes: 614c23e24ee8 ("wifi: ath12k: Support arch-specific DP device allocation")
Signed-off-by: Ripan Deuri <ripan.deuri@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 375277ca2b89..d9a22d6afbb0 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1639,7 +1639,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	ret = ab_pci->device_family_ops->arch_init(ab);
 	if (ret) {
 		ath12k_err(ab, "PCI arch_init failed %d\n", ret);
-		goto err_pci_msi_free;
+		goto err_free_irq;
 	}
 
 	ret = ath12k_core_init(ab);

base-commit: 7b25796f571fc09a7aa6fe7efb23edccd326917d
-- 
2.34.1


