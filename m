Return-Path: <linux-wireless+bounces-34731-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R34ZMJ7e3WkYkgkAu9opvQ
	(envelope-from <linux-wireless+bounces-34731-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:28:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D93F5EFB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1BA23008E04
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 06:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680FA34EEED;
	Tue, 14 Apr 2026 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ItSn+Gf9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SwDuMCmc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0DD34CFC5
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148123; cv=none; b=OFnL8N5ruUUg8xEyezsCf0aeKcobr34oxd8xHeMnjARJxdfDfov3M1rNq1eJEtSvpyGUlkCjKh97NtMJCIqMbvT21yPF1XsVIgh9zVjHa1C25Zew6vLb/8aEH2nhFEN9jj2xGjVhy81SKw5zPJ32uphI0f8owxW61A8M/oAXOYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148123; c=relaxed/simple;
	bh=QjCYjesVVFSTAGdWSOI/L3Za7DS9gI1Ngh25Ynszua4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tZBFhQyR5bkV2PHxOrY7E08FWay+9RcmzdVmS9zEWEuw8FIlDnt3zvfEtUJNbcREecBwgQ+6oGasCvim9L1carYIR+9fobZXlCpo4N14empCIRMQdN7HCZc3NFZq4vZAxu3YVhak2YnDrSU4eZzYLqiq///FpQFAR9oenE64hnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ItSn+Gf9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SwDuMCmc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6CoO6395301
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 06:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jYG1v408quIn73bFq02nBIz5X2VttPYJCXB
	8qX5Hqt4=; b=ItSn+Gf9cE88mfdYQwG6uHi1cDD2rIvUI2Of5piFSGo38Z/zvLf
	HEmyU5DbguNvPyBz6wCy36JgeESGHE65gtHGd/+nQof9nu9LquAKB6sCpGs6wMkq
	gpywYnKRYk1QJcUGZer5rftY2JxjXvg20Tq5ktOzTTzeg2wyAd68ZiGyZhMFhU7V
	KSmyactZYL0JsWXT83k7UFXFsmSDMnXedZ7jmLjkhMCi0aMN/NUdGy1CmVzQxL0L
	P4tQlCeD56fsMknYjoy+CKLime3Da0tGMVQjI5B25Ft5rOkbvG1sfi31Dzsb+6CK
	OM8nSlcUH7MBeyNKpsR9c+8GkfiZmbDR5HA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870sbua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 06:28:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3595485abbbso5145690a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 23:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776148120; x=1776752920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYG1v408quIn73bFq02nBIz5X2VttPYJCXB8qX5Hqt4=;
        b=SwDuMCmciIn7c+5DqiM2SPRNr68ALQyagFDhEBR0/Ac1DCFjGSgXN4UAqAxJOIxcen
         pfhi6IULHISSE42m4Hnnb429NQMwp2a51x+Aw1pPeRyiWLzMk0UcsiCuPYMt5j5A2CNP
         5JroWrjf4PyOIZ6QJQpmtddopjQIA2Kkn4haJXltkwt6VVqAUY52gOSHVB6gzlRouGsd
         dhZh9g9sPie+Z3owxUM1bPUjMJsxpdfo+LmAl+PoELkHjBOQ24VGCism4bVR5rbjbosv
         I4dmJXe46FtDi717ZQqFPxE7OZ75nUmeJi4VmC5PaEZoECM3tdBQHVNDr5T9z61DT5SC
         k6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776148120; x=1776752920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYG1v408quIn73bFq02nBIz5X2VttPYJCXB8qX5Hqt4=;
        b=CxtZh1rZNZ6yVWGPNcuQq9oQyWG+ATwBiEgDEIxqpU+bwyTDlyT8osOO5TjL98zKGC
         VmR1+It4u+3TE7NPoEsSh/uVCiqxwWIulMEdBB7GggEoFBKQ0ky0W5p8mA8Tmqx+vEJs
         txVhGTHAwYTcK00bSg2Kk+t7pO4B5iroAbaawaAD8QL3hhnAP3Amxh8B+bqwJhqOgVEF
         PLKUUQzyii0kGZ9FXCyaTHRiFzfOceW7kGFpjYCTqYLmciyTtjfZZMcpr71PQlZpwWmG
         6D3p4k7IChvPcgqymUGngPjTQquPt6tzs3J+rNr0p9fTZURmT00B2WG/dJHK0U45ENsp
         N6+w==
X-Gm-Message-State: AOJu0YwQQ3N+id8cpghQArISSxKAmHSdVqu2FJJp2CuLIUo9okzkdL9r
	o8R/8fZfZzKz4fPdovkv8PWCzv3JyETkRIZ0NkcVbVdJErkjG/ep0BJxGE+bV4tNRoYEaqJx96k
	r1BfeSM73k85KYy6FdZHXO1dkOhpvlKq6zLVJySyvXQZQi6V5RsaiZm3+nv7Vt25yTqIVdQ==
X-Gm-Gg: AeBDiesfBOaNejjAw35MNdTYrm3ZOG6qhCLGAmYG/HyKL0CranjsWc5v9HrFPoNr7cn
	ZDKpDIeRcaabrrFra13aG23btC8MNzjk1/JsI+W4IxRKkLl4TU4tCPyykziZbOSK0WeTnvpvEoN
	WKk7dHkJ+JVk6v8Wa2ul3t6kCh3BjJ2pJTDvBBbkri2LwtEVx3Yy9iHIuucjtMi7FVXx8Fciv4D
	LMy3sxrdk+gaJp24JZ4oJEh8AskELhD3DhsUlMoDz/FSjKR3NR+dfQwFGw7wAYJ+Dd+I7sm7C6q
	94vZjpVnkx4YGo0KoGfEKiAEGiVNGZKqTo5FUpx96FOuSkrV1g6PACuLqDhV6prMlr166/uTPM0
	flNPTbeknIbEVZQM7UcVT+xpRVZxLfac74b1Hrh6JVmZG9xpw0z44kWx9918eU/pMIGCldpNq6+
	DF5c3/kr4OWswV+A0FXp5s7Ek3/DvsTPXmA2h3DNx9V9dcAaBMiuin7WY=
X-Received: by 2002:a17:90a:fc4e:b0:35f:bddd:3860 with SMTP id 98e67ed59e1d1-35fbddd407fmr4921845a91.6.1776148119776;
        Mon, 13 Apr 2026 23:28:39 -0700 (PDT)
X-Received: by 2002:a17:90a:fc4e:b0:35f:bddd:3860 with SMTP id 98e67ed59e1d1-35fbddd407fmr4921818a91.6.1776148119223;
        Mon, 13 Apr 2026 23:28:39 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e3fc21sm993564a91.1.2026.04.13.23.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 23:28:38 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix invalid IRQ requests during AHB probe
Date: Tue, 14 Apr 2026 11:58:29 +0530
Message-Id: <20260414062829.2371761-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y1veDXJ2P3NGczLOmvsZS2VCxQV5UOoV
X-Proofpoint-GUID: Y1veDXJ2P3NGczLOmvsZS2VCxQV5UOoV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA1OCBTYWx0ZWRfX+6Gp8MkPilPp
 elzhZpXZ7j/tBjK3Z3yluGDcTV0yQW1pZEZdMSrlO7443R/DcXrWyYPy/GBYStqg59IlOaWNBFN
 DGCsp9uLFzUVmpIsU92z1lD4Qn76CFM5BLHo93+Eut0MEIBYFIZZNYojRuMrS9ycb184rJ9+XqQ
 +st37qmhKmpr0twfr1xmTCM3PKaGbEMc9uGf74wo5w3NGNM/AEcqHLWtW5wFojjRkIr5WvoBtj/
 GuZMIIsV9yO8OiNiKX+nGPioMZ1I83hcGer71cJy5AH3n0DiD7nsWKqIT1PRFtYMAFHcWMMdwHc
 CgQYgp5Tk2ggJHQXWBMxhhBtDtBTuin8cwDdsurP7nzYaeDlnHUCtwjRGXdBFpXtQYdAJaCixtN
 PG6u44thfdE4sylPGwNXXfY768JKPKss4gEhfdKN1AyoqneKbJ9+qQ60rKkLzN/mSnDIBFok3UQ
 BYcCxHjxIU3+o9cEMuA==
X-Authority-Analysis: v=2.4 cv=MK9QXsZl c=1 sm=1 tr=0 ts=69ddde98 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VOb1adjnMac3WpnspdkA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140058
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
	TAGGED_FROM(0.00)[bounces-34731-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 271D93F5EFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ath12k_ahb_config_ext_irq() iterates over ATH12K_EXT_IRQ_NUM_MAX (16)
entries while checking TX ring masks, but the tcl_to_wbm_rbm_map array
contains only DP_TCL_NUM_RING_MAX (4) valid elements.

When the iterator (j) is greater than or equal to DP_TCL_NUM_RING_MAX,
it accesses tcl_to_wbm_rbm_map[j] out of bounds. This results in
reading uninitialized memory for wbm_ring_num, causing the driver to
evaluate incorrect BIT() conditions and request IRQs for rings that do
not have an assigned interrupt line or device tree entry.

This leads to request_irq() failures with -ENXIO or -EINVAL during
ath12k AHB probe.

Fix this by splitting the loop into two separate loops: one iterating
over DP_TCL_NUM_RING_MAX for TX ring, and another iterating over
ATH12K_EXT_IRQ_NUM_MAX for remaining IRQ entries.
Also add a bounds check for num_irq.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Fixes: 6cee30f0da75 ("wifi: ath12k: add AHB driver support for IPQ5332")
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 2dcf0a52e4c1..30733a244454 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -583,31 +583,36 @@ static int ath12k_ahb_config_ext_irq(struct ath12k_base *ab)
 		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath12k_ahb_ext_grp_napi_poll);
 
-		for (j = 0; j < ATH12K_EXT_IRQ_NUM_MAX; j++) {
-			/* For TX ring, ensure that the ring mask and the
-			 * tcl_to_wbm_rbm_map point to the same ring number.
-			 */
+		for (j = 0; j < DP_TCL_NUM_RING_MAX; j++) {
 			if (ring_mask->tx[i] &
-			    BIT(ab->hal.tcl_to_wbm_rbm_map[j].wbm_ring_num)) {
+			    BIT(ab->hal.tcl_to_wbm_rbm_map[j].wbm_ring_num) &&
+			    num_irq < ATH12K_EXT_IRQ_NUM_MAX) {
 				irq_grp->irqs[num_irq++] =
 					wbm2host_tx_completions_ring1 - j;
 			}
+		}
 
-			if (ring_mask->rx[i] & BIT(j)) {
+		for (j = 0; j < ATH12K_EXT_IRQ_NUM_MAX; j++) {
+			if (ring_mask->rx[i] & BIT(j) &&
+			    num_irq < ATH12K_EXT_IRQ_NUM_MAX) {
 				irq_grp->irqs[num_irq++] =
 					reo2host_destination_ring1 - j;
 			}
 
-			if (ring_mask->rx_err[i] & BIT(j))
+			if (ring_mask->rx_err[i] & BIT(j) &&
+			    num_irq < ATH12K_EXT_IRQ_NUM_MAX)
 				irq_grp->irqs[num_irq++] = reo2host_exception;
 
-			if (ring_mask->rx_wbm_rel[i] & BIT(j))
+			if (ring_mask->rx_wbm_rel[i] & BIT(j) &&
+			    num_irq < ATH12K_EXT_IRQ_NUM_MAX)
 				irq_grp->irqs[num_irq++] = wbm2host_rx_release;
 
-			if (ring_mask->reo_status[i] & BIT(j))
+			if (ring_mask->reo_status[i] & BIT(j) &&
+			    num_irq < ATH12K_EXT_IRQ_NUM_MAX)
 				irq_grp->irqs[num_irq++] = reo2host_status;
 
-			if (ring_mask->rx_mon_dest[i] & BIT(j))
+			if (ring_mask->rx_mon_dest[i] & BIT(j) &&
+			    num_irq < ATH12K_EXT_IRQ_NUM_MAX)
 				irq_grp->irqs[num_irq++] =
 					rxdma2host_monitor_destination_mac1;
 		}

base-commit: e6630ad4c58f89ba72e64fca5989ecf1e06319c9
-- 
2.34.1


