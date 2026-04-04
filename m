Return-Path: <linux-wireless+bounces-34343-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKBEEBGU0GlG9QYAu9opvQ
	(envelope-from <linux-wireless+bounces-34343-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Apr 2026 06:31:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C18399E8A
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Apr 2026 06:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A8BF301FD42
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2026 04:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72334D3A5;
	Sat,  4 Apr 2026 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rhra5k4J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iw7GpMP6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC162330651
	for <linux-wireless@vger.kernel.org>; Sat,  4 Apr 2026 04:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775277065; cv=none; b=h+yYuTWLy90wKoUTUOLMG2xspgjwSRGhniBRwloa4pcEXiBGMc3xxjgMbL3Vem5/zuZnDHmQttYW6Szv2Dtspl80gJ0pd61kXkHKZrQ4iHYzboB4CyzjlCy4rZIaBddBBnsCu2t4hWtx+r4C2Jp1uZTdYImE3hNw6jFngGOJHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775277065; c=relaxed/simple;
	bh=kRkpjAcqLpyGH48sEgcrZnCkiwnJnMX+6jvmkTspUhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciFUdocT3rwCl7kTFktq+kZ6xXZLJMV0pVxKe77bR0zRDxGeDr3yqb8TqyjskJ+lUcpU3X6gW4gatxlNDQGIuyQcMNjcazF4oRZskedO6izh4cxWSkM5Kclx0qj+gebv9k7sTjVluzSEPXRTOhtFRrLSlUh87o48XKPJioyJWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rhra5k4J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iw7GpMP6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6340KAMA1310004
	for <linux-wireless@vger.kernel.org>; Sat, 4 Apr 2026 04:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IBOjD1SCE/uWKPBO1BDvYmWOu32r5baQpc1
	YaXyTiMM=; b=Rhra5k4JaJGSlN/R3BdhSADj2gpyni/r1udJO1qbq7DAHk58suk
	dM71Vo4+w3hqg0vYyjM2v7RPAIi4ezwmMMR6VbwNgivDMOPyCRMygOb4oTAX35Mk
	1zseK9l80iIELX2nlFYtWMZGzsL6CiqFkM04Es7KNtscmdiVAmocYhte+hUOWCYN
	HxerNXwnWE7qhqNkS8Ut+u1phuK8ECzjjZkz7bmhsNV2mCzStgMpDoRkDuIxc/QN
	buKrRDyl+Sv2ZTA05wm7YQrB7KrQP2W/LPPLD6/R3Ma3QA6tBWN/ql7zAiVHABDM
	hlTHVj9d1fP36Vw94Xzc6ZCXENTJHxE7Lpg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dar0mgayk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 04 Apr 2026 04:31:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ccc035f125so463184eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 21:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775277062; x=1775881862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBOjD1SCE/uWKPBO1BDvYmWOu32r5baQpc1YaXyTiMM=;
        b=iw7GpMP6u5nLgjbcb++a8LwB/2OoE4dwkPMrQrXKT97ZBRclHlE0mcN7AQdKYVFOLB
         MJNlzkYwemQ+dfQo9HI2DfyI6FjsEHyWZC5sJZH5XMDkdcQWcpfnCD26YpUlTQylwnVp
         kfXzGAbyF7QM6FeserN2iOmQpH8sxOc2iRSaMAIVeJjlFSvzCCbx0wOdCH13aKVCOUI/
         igu8iqyhe6uQLKTCthYySzjFytbWdqa5qH9mxIRrK3Gmo28H1YhfXze6chCP/d0DRtQE
         d9pjkav9uaHqf3kj7X4+shlpVX9bFfh/6+ezVLcZWx4J2yxqJKLTj7m4Fds795AXqUPC
         8GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775277062; x=1775881862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBOjD1SCE/uWKPBO1BDvYmWOu32r5baQpc1YaXyTiMM=;
        b=gCdOy2nG1nA9oGB/zkqS50AUXnAR6of2G+9clhGtK76AyXGuzYUO3vuyi0sbF0TJbp
         Xw1DkMq1V7V09JjkCufGBdtd3YnzPqlCNJUfZrRYE0zuMGiF7xkDDH/d7AIeSVXnVIZO
         1KPK4ykRJUVwaliEwW6rydSgYfjGYYMZ9N70vwvS8NlrjUYSdbA10yXQeJ0TphHBevA2
         QKmKE0YdGuLusGCTshFRB2gEb3EJS4rzOH+5mVhMLB25MifIr7YvttNDl7KnOzqLtScx
         UePP6gg3mdOQGfO0S6k6/TutbRYkzABavNTfHJZhphlIbwui7tu1+4QTrWs4l4VJ8zLX
         YBSg==
X-Forwarded-Encrypted: i=1; AJvYcCWPmfJcIFyTJw9wPLX6eOHTFnIPsy5aP7OyDVexI89EN4ZTyx7UGAffcikZAjmQc/BuE+k+hd5YZuTl6vfgQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTo+Qqn9r1WAb5oiWTAznPbqnv/tFb61NWPOVv6mBWaalMJKE4
	iwf7thQqga0YzIj4CntO24ThFMfh5/UxoaAMCBsB/uUqUhahdQpfAB/tb4SP8bNC9zmM8VUGsqp
	CKS3FyuKbQ2ep8SpcJc5tsfu0yb+P7FtlC5qirxnjH9ekaI9h7VpAYKg4uki7rnPBbA0yFQ==
X-Gm-Gg: AeBDiesACkfYMn+T3q9dl4tyljNctkg2oLL1/hTAxL114rBcoj0fL8lyy/c9CABGJpv
	l6a340rq58ujxre4HkHeVidVgrCkfRY0ua99npXdG03JA+t8xqjQCOlNG78KM5tw/cxj/DItwAb
	W3l1ORgYXGvM8dcFvTBViUWyHncF4Zmj3Gt4YBiHDfpOhvIRCTTOU4XLZZlNBdW6/lMAf8fV/VY
	7XtmzgLr99vJOpyUJEOv6Ny8ou1yF1eaHqmPggmif1/q/MvHziCSSAl/tpD//N/K0Db6tKwZaA8
	BdYR9vwfNEr5K+5azNXTenUDIQ2en7UgLFpNtTq12e0nzw/KUH/+ET48X65NgE9G1jT8pHuLW5X
	heT+HNFHk0Kdfu4Z3UduFuJZBt1HW96Y7udmswlOnLl4kKTDgMKOBDvPfuKNp9tnx1m/DiWZjJ5
	t6Tw==
X-Received: by 2002:a05:7022:2219:b0:123:2de5:346e with SMTP id a92af1059eb24-12bfa9cddfbmr2202723c88.0.1775277061444;
        Fri, 03 Apr 2026 21:31:01 -0700 (PDT)
X-Received: by 2002:a05:7022:2219:b0:123:2de5:346e with SMTP id a92af1059eb24-12bfa9cddfbmr2202704c88.0.1775277060868;
        Fri, 03 Apr 2026 21:31:00 -0700 (PDT)
Received: from san-w175-na3-01.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede7f085sm6271622c88.12.2026.04.03.21.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 21:31:00 -0700 (PDT)
From: Wei Zhang <wei.zhang@oss.qualcomm.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Zhang <wei.zhang@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath11k: cancel SSR work items during PCI shutdown
Date: Fri,  3 Apr 2026 21:30:50 -0700
Message-ID: <20260404043050.3433754-1-wei.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _6CD3qw6yKC_lBWXuGVqrxHgualTltPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAzNiBTYWx0ZWRfX9W/KMh9k+tvs
 SCANmo2p0HWkKeD+xZyCFwUSmtHqBr2732vKrmOPbb1jBgz6/fXEg67Lu358FN98f5QzX64NCXi
 Ssr3JW8wpl1Wmya1US87IZbMTo8VSOUwxrZMFHmFxZOoKDOC4Mpc3mZ0kX19Sy4XV8bn878GYS4
 Rdr7mvjYISohsw2twPJYt6grkxt10qJYz4M3ybKTg9YqDnAs6rPyvvZer7d3r0ri1NJeBZUOluV
 gH/aq5pfHmywsObKMw1ADNG7x1Wps3ZLmkWBI5vFPhqxHp39Jm/9UowlX4mgWHrA/fSfSIhtwee
 I0i78AHfoq1UtL6fEXr4OIY+5rOc1n3prfnHLTfllT5c3G9YUOr1sv8ZU6oHSZ9oyvsxkwCFLvW
 3DpAVHPBOpH7DOPu+UyI+nI+WA6XruGMfnTlzxRL/c8u2IHUM1o+RJsnYeAbKkLVab9do0AgVub
 UIBm082XHT26ZeNPicg==
X-Authority-Analysis: v=2.4 cv=PpaergM3 c=1 sm=1 tr=0 ts=69d09406 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=2AV42wVkYpmhdkL2cwwA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: _6CD3qw6yKC_lBWXuGVqrxHgualTltPt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040036
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34343-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 82C18399E8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A reboot can crash the kernel if it overlaps with WLAN firmware crash
recovery (SSR). The crash is a NULL pointer dereference in the MHI teardown
path while freeing DMA-backed MHI contexts.

Simplified trace:
  dma_free_attrs
  mhi_deinit_dev_ctxt [mhi]
  ath11k_pci_power_down [ath11k_pci]
  ath11k_pci_shutdown [ath11k_pci]
  device_shutdown
  kernel_restart

On the host side, SSR is driven by the MHI RDDM callback, which queues
reset_work to perform device recovery. reset_work power-cycles the device
by calling ath11k_hif_power_down() followed by ath11k_hif_power_up(). The
power-down phase deinitializes MHI and frees DMA resources.

Shutdown/reboot runs fully asynchronously with this RDDM-driven SSR
recovery flow. As a result, the shutdown path
(ath11k_pci_shutdown() -> ath11k_pci_power_down()) can race with the SSR
recovery sequence.

Fix this by canceling SSR-related work items during PCI shutdown, marking
the device as unregistering, and serializing the RDDM callback path that
checks and queues reset_work. This ensures that no new SSR recovery work
can be queued once teardown has started, and that any in-flight recovery
work is fully synchronized before device power-down, preventing MHI
teardown and DMA resource freeing from running more than once.

Note: This issue only affects PCI/MHI-based devices. AHB-based ath11k
devices do not queue reset_work in normal SSR flows.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04866.5-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Fixes: 13da397f884d ("ath11k: add support for device recovery for QCA6390/WCN6855")
Fixes: 5edbb148bc57 ("wifi: ath11k: Add firmware coredump collection support")
Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 4 +++-
 drivers/net/wireless/ath/ath11k/pci.c | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index f994233df2bb..a6c9ff112c68 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/msi.h>
@@ -282,8 +282,10 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 			break;
 		}
 
+		spin_lock_bh(&ab->base_lock);
 		if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
 			queue_work(ab->workqueue_aux, &ab->reset_work);
+		spin_unlock_bh(&ab->base_lock);
 
 		break;
 	default:
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 7114eca8810d..35bb9e7a63a2 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1210,6 +1210,14 @@ static void ath11k_pci_shutdown(struct pci_dev *pdev)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
+
+	spin_lock_bh(&ab->base_lock);
+	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
+	spin_unlock_bh(&ab->base_lock);
+
+	cancel_work_sync(&ab->reset_work);
+	cancel_work_sync(&ab->dump_work);
+
 	ath11k_pci_power_down(ab, false);
 }
 

base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
-- 
2.34.1


