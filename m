Return-Path: <linux-wireless+bounces-6217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4F48A2628
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 08:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A749028764D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 06:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE101DDDB;
	Fri, 12 Apr 2024 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H3aaubLh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9842D630
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902008; cv=none; b=nFz/d6g45SINo84u9F++7u33SYt0fMzPBHUwEn6hT0BUefgJwgKft/j/Lob5TpFaz1Xb7Hpw65a0+mr4WJ44KQYGRVR1EdDWlwTiKS3uQFQw8bGCcmb9gkagVXGVECGINBk9qTa4v83H7y65uOaq7MDz6RwYn29ZPenBpBmcmEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902008; c=relaxed/simple;
	bh=t+TkjVWLco1SDdsfUMrYzo4d77OQmVjmtFsuMibrsME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnFHS9k/gOR3J3RBjL1IBHrDZo5gp7Q5OG4q6Lh5Lf7W9PJaA5bWtMS8gP+v3cC6OkfKButH9aouhFQ9OIrifEDKHOI/zA3Ht0gPUFJOU/pgi0wFz/l0flqCUOjsKW5MKsS/Z+hW5wmksEIkGdhsJMzExdr9uPtH0+IU7TZIjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H3aaubLh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C4bFHE014112;
	Fri, 12 Apr 2024 06:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=P6ZCaryHXYWRz0kI2Soi9uN3qEh+qXHERBjZgruRwaA=; b=H3
	aaubLhlFR2czmV6J63lEP3vnw8QIHzwRwcYfHou/EeSTq8iqg2YAtDHlnRTZ/a1e
	qP6N/4/iRBk8dWP5Va2GxmJ22lTwe21m6yV9aSAH/8COGFwgf/2VHS/X3ZySQ6v5
	za02jX2BGc8s8aHOF5yeSzZ3LRdoPy7G+OKhTfGp61FPu0JTeTSFDNBibekAB5Cz
	c3XdgGbU10Iv0M+SWaZ7bz0rdStTIY//E6boN/3pEwUvGdrjWA6ioMu64xz+MxPP
	PB8oycNo5lmQtaLqtks0G2vna8sSC4S4Nf/HFYA9cfnlSQ7stiSZzJ+GFOVYDxmx
	A+Y0AjwxyrAwzRmAc7Mg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xewr38777-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C66heW019961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:43 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Apr 2024 23:06:42 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 05/10] wifi: ath12k: decrease MHI channel buffer length to 8KB
Date: Fri, 12 Apr 2024 14:06:15 +0800
Message-ID: <20240412060620.27519-6-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412060620.27519-1-quic_bqiang@quicinc.com>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CSdlWmg5uvzq1-PjCme4fh1hIEV6kw2O
X-Proofpoint-GUID: CSdlWmg5uvzq1-PjCme4fh1hIEV6kw2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=851 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120042

Currently buf_len field of ath12k_mhi_config_wcn7850 is assigned
with 0, making MHI use a default size, 64KB, to allocate channel
buffers. This is likely to fail in some scenarios where system
memory is highly fragmented and memory compaction or reclaim is
not allowed.

For now we haven't get any failure report on this in ath12k, but
there indeed is one such case in ath11k [1].

Actually those buffers are used only by QMI target -> host communication.
And for WCN7850, the largest packet size for that is less than 6KB. So
change buf_len field to 8KB, which results in order 1 allocation if page
size is 4KB. In this way, we can at least save some memory, and as well
as decrease the possibility of allocation failure in those scenarios.

[1] https://lore.kernel.org/ath11k/96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz/

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 403691355abf..d6083a187021 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -140,7 +140,7 @@ const struct mhi_controller_config ath12k_mhi_config_wcn7850 = {
 	.max_channels = 128,
 	.timeout_ms = 2000,
 	.use_bounce_buf = false,
-	.buf_len = 0,
+	.buf_len = 8192,
 	.num_channels = ARRAY_SIZE(ath12k_mhi_channels_wcn7850),
 	.ch_cfg = ath12k_mhi_channels_wcn7850,
 	.num_events = ARRAY_SIZE(ath12k_mhi_events_wcn7850),
-- 
2.25.1


