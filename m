Return-Path: <linux-wireless+bounces-6941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA648B471A
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 18:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAADE1F21C76
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8403E1EA6F;
	Sat, 27 Apr 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BxwTvZs9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB801CF90
	for <linux-wireless@vger.kernel.org>; Sat, 27 Apr 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714235233; cv=none; b=BFSH4jU7wmausPcDcwr/XalGGdGUsgWRye7V5wwaXlKA7oxHr3UYhJhLCDAA7roPsSehp9vr+QCQdyaxoQWcJbPl5GJm0E8Yyb7FvRFPsf/JN3ijL0eEK4BNN0n61PVxY8qdJ5YTHw8VFH/JKPcsnCSQDYCgduHivBwCEG6ujP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714235233; c=relaxed/simple;
	bh=IDCOydwSgl8zMjc73CbR0ttgW5FlolRf6mqqD+YH54M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrxUpu3K15ukLv51W8yN5EErssudqQCG8k20I3BNe3ULOw9laVILLVhRFEv7iSbUSjLgs4pD2VTjQPJmjQmHAXzrD9qm+KJ5kRUrQdXwkJCBEAmmjxDJAV6hlVvWsxIoQLMOeKoUImO6YyB9t3EBBFr6oDnhhooA4br8WxExCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BxwTvZs9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43RG85tE005221;
	Sat, 27 Apr 2024 16:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=nFd6ENsGO/cclvnJCgMh9yw2JMm3BjWGly3AxMK9K2w=; b=Bx
	wTvZs99GNcuKHs1QabkL2Y+eg94aYNR+uu6zmV8AgGgek3Z00GVTjwKOEe3aRfUp
	CfTlFZ11uPNm+5JwrcMieM1fmjuZ8TEy7jtQNYlxe0rvvbFafuVFdJO+Y6e+irCf
	/biQEOrVG9I/V7ZmlfsA7MJxQIWr6Tso9yDMWf+17/c1RZwANOZDzZYHUNb0cbRt
	6MKEwqV8+mGljyac5xAkpW5cg3Ui0LO4iXKSyrZl4THzFJstZFnVPmhQhAWRjiJl
	KFtS3hrtvXifyGOM/7Hun60RjNVHK1+mdrBB3v5gFw43JKKTxg1FT7dx8FoLt+ZD
	t5R4gUE5siQvlZcT5BIQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrq2k0ufn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 16:27:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43RGR3F6026137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 16:27:03 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 27 Apr 2024 09:27:01 -0700
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja
	<quic_tamizhr@quicinc.com>
Subject: [PATCHv2 1/3] wifi: ath12k: fix calling correct function for rx monitor mode
Date: Sat, 27 Apr 2024 21:56:42 +0530
Message-ID: <20240427162644.2470886-2-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
References: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
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
X-Proofpoint-ORIG-GUID: hmnSK9l7zw4XK6P1RNFc5HIi18bt6lXb
X-Proofpoint-GUID: hmnSK9l7zw4XK6P1RNFc5HIi18bt6lXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-27_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404270120

Currently in ath12k_dp_tx_htt_monitor_mode_ring_config()
ath12k_dp_tx_htt_tx_monitor_mode_ring_config() function wrongly called twice.
Fix that by calling ath12k_dp_tx_htt_rx_monitor_mode_ring_config().

Currently monitor mode is disabled in driver so the change is compile
tested and boot sequence verified.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 9b6d7d72f57c..2fb9fc42db11 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1044,7 +1044,7 @@ int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 	struct ath12k_base *ab = ar->ab;
 	int ret;
 
-	ret = ath12k_dp_tx_htt_tx_monitor_mode_ring_config(ar, reset);
+	ret = ath12k_dp_tx_htt_rx_monitor_mode_ring_config(ar, reset);
 	if (ret) {
 		ath12k_err(ab, "failed to setup tx monitor filter %d\n", ret);
 		return ret;
-- 
2.34.1


