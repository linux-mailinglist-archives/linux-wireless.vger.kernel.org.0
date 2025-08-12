Return-Path: <linux-wireless+bounces-26330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3D1B22EB2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD4816285C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 17:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7732FDC2B;
	Tue, 12 Aug 2025 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="muJocp8n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99952FD1CD
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018765; cv=none; b=uq8vuvCH8u7ypd0vGG1f6utbwSgkq8gHj8nIaCFxE/pkWUUXvVifNl3etUUJ2GqzfehNGrrYnm5Mn03f2GfYRs1EnZMPq5T4ISzGbnR44BWOVMubLakjdul3/0fjhHleGW/5T0Y4pCK4tF87Wduc+GrBC6ExHX4g6Ve+TYf73Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018765; c=relaxed/simple;
	bh=IAXoVbCHM7w39SIV9McjBz+xG4DSvQG02p+XKBZX7MU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lWS67HR9gHKRq37mV7ThNvVuGI/vfdBqlE6WQ5I6B/ZWLdXeI0de22Wr5RZ8Xy1D9MD12gEZMJ4A5c/jhJ0xjIA1oxwUQz5oBKvQT3LIEoh5qspys9mhQfdjykgGZlOr70VohLUTAAqHafOTUJkY21wYxiBklptcI375AuV/jtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=muJocp8n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAwjHh025649;
	Tue, 12 Aug 2025 17:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cw1jevM5Oh8AN6ONCk0AEXM50FTMR02tLs1ibXX6/aE=; b=muJocp8nczQrYkPs
	TNg/RpvVATFr44O0Ge9591vZ7IvqruHMEsVb4RTG9UZzQ6zSXGERbDxo1p/S2KWv
	jCTdlcOpJ2bfJd5M7ai5epUPDc/B3NxPqYn8QVr+u9dBFxl81SCEav8tdwuR5gKc
	DLAulyNdIcKp4XtO5oW+ggCcoIrEqFAn+8+ABOgtKnDwsbsoWw4aFyoj4bwhdmU9
	zLR/PYGUXHszH83bQWHKDpAZ2MWJnbfiJFgd3MIzIiWjx/l7Ec0PEZ5TRf3stHe/
	d07F6Vl+Acm30f3PGRe4Zx5KRLMkqYuCFjifCq1rNDxhaRV56xWrXnVWc6dTixsG
	OaHsuQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9ss4xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CHCfRN012355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:41 GMT
Received: from hu-kiranv-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 10:12:40 -0700
From: Kiran Venkatappa <quic_kiranv@quicinc.com>
Date: Tue, 12 Aug 2025 22:39:31 +0530
Subject: [PATCH ath12k-ng 05/13] wifi: ath12k: Rename hw.c to Wi-Fi 7
 specific implementation file
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-ath12k-mod-v1-5-8c9b0eb9335d@quicinc.com>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689b7609 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=7F3q8_YwuHF-GxdVt98A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: QiCuA1BGfScWh54mlFjw6tDoMlHu7_rM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX0iKV8cmpwbp+
 rasc4gZMR6ydPCkcqBfL2wzzlZe0gjJNycQSZqvBHNRRs+W5mu+JENlu0k3iZ7uGSdD+KvVdpvv
 T2pQV5oRp3YIng7cbZjsrvgK8y4JNDG1UzBe+5bntdZ+SAWUBEo09ZWaggOny50nxAatvW/HcIm
 72vSSQtDXMgOESSJwBtDcxpxFj03VsHOfOST9c3XJIn03btvGwfq2vw1UKMqlep0HCCKSxoQMr7
 CSwEwfj95E2xnReqwUH9nV1BR9Pbl/KeOyLjmvz74Wu8HijW26tc5oS5SjIJj9VFhCgaA6gWtko
 y9b/UkzMVBqqTorVDMG7jpteZSLghYsdCgXUcSY0ckgFyT0XFD93fY5AT00MQWFmkBdWbdNE6Ta
 2QzOSwaB
X-Proofpoint-GUID: QiCuA1BGfScWh54mlFjw6tDoMlHu7_rM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1011 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

Rename hw.c to hw_wifi7.c to reflect its focus on Wi-Fi 7 chipset
specific configurations. Clarify the files role in containing
hardware dependent logic tailored to the Wi-Fi 7 family.

This change is part of a broader effort to modularize the codebase
by separating common and target specific components into distinct
modules for improved clarity and maintainability.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kiran Venkatappa <quic_kiranv@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile             | 2 +-
 drivers/net/wireless/ath/ath12k/{hw.c => hw_wifi7.c} | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index fb968884f6560ed8dfeabba0e0a1562a98576313..f1105d7adafff957b8a6ee3231e03a7f6ea47ed2 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -18,7 +18,7 @@ ath12k-y += core.o \
 	    ce_wifi7.o \
 	    peer.o \
 	    dbring.o \
-	    hw.o \
+	    hw_wifi7.o \
 	    mhi.o \
 	    mhi_wifi7.o \
 	    pci.o \
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw_wifi7.c
similarity index 99%
rename from drivers/net/wireless/ath/ath12k/hw.c
rename to drivers/net/wireless/ath/ath12k/hw_wifi7.c
index ad372feaef28be9149f86008453409dad5c5d4f7..f6177f8e032d98774b4a041ecfe97187b55ed259 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw_wifi7.c
@@ -1043,13 +1043,14 @@ int ath12k_hw_init(struct ath12k_base *ab)
 	}
 
 	if (i == ARRAY_SIZE(ath12k_hw_params)) {
-		ath12k_err(ab, "Unsupported hardware version: 0x%x\n", ab->hw_rev);
+		ath12k_err(ab, "Unsupported Wi-Fi 7 hardware version: 0x%x\n",
+			   ab->hw_rev);
 		return -EINVAL;
 	}
 
 	ab->hw_params = hw_params;
 
-	ath12k_info(ab, "Hardware name: %s\n", ab->hw_params->name);
+	ath12k_info(ab, "Wi-Fi 7 Hardware name: %s\n", ab->hw_params->name);
 
 	return 0;
 }

-- 
2.34.1


