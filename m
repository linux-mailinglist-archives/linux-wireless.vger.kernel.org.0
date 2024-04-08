Return-Path: <linux-wireless+bounces-5962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863DB89B6B0
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 06:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC62812D8
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 04:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BDA749C;
	Mon,  8 Apr 2024 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IuyQN2+H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABD7482
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549171; cv=none; b=fiSmqvaCd+dSLgs0qIKexsWar1EwK6nDjGhd0BpwIhrEVp4lWK9odLKOlGTNFMin1I7v9a7+xlrwzWId/KI2T2I1MUL3oiwhjwOEUGtJxcTREP50JDc3v6qqGXCYeuIC6wEMIKeC/eHpSycNB4mVYf0k8O+2B7ULXR/EbCpCqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549171; c=relaxed/simple;
	bh=l1GfZpEPSTPvajOjHz+aS2s0OQ7nIE0si7JsJMq0qK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBTjvpvJDJeq/OGsb2slxqigaFJa7PbwiNAMK2zuCwvqByQF2xQ+sXJU9GSPBKeDIzx9bcI5fXu3FdLPNGa+xxAlgg2e0TeSRFhJ1r2LA/+s2Bjyp5dKp9Nt/Fd+ZP6SN533LMtuXAep1wCy4T58PXTZfniBAgO61DWvPZemWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IuyQN2+H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4382rDhk016594;
	Mon, 8 Apr 2024 04:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=RflLuIxOQZrvFJTc1yrBGpLHHu5OyHjDdGm4uBXbdf0=; b=Iu
	yQN2+HjBuJ3gkuILfDLjHh3QFbymRHLZyXpZ0W0dYCTB4h8RVrTNDdHUI7f8HJ3o
	6+BGjtlk2B1XRW8WBXP8dqOQN2bxVR3E/kP9MqwwEfJ5ug+Z/o2fwdFQZf7kObpJ
	Pwh+hkSTYngHRrSvS5AKxu6WEDfbhPu4paSUbfVJ8Nt2bQlPD32Azw9w2ibfnz7J
	HIqv6fFNBreKJxD8djZ395YTUdVz6M0AO9pJvaKnzkAQQEUsztIn7nN11cyEAgnz
	bwp18KV3sOrKRp4r7JrYpbWLWmHsbg/Qc0PSdBN938kLbg1Yll7iRe0AwY/7RF84
	iI24an7pknaszn30OEKg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaypdajut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 04:06:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438464TV025081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 04:06:04 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Apr 2024 21:06:03 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 1/4] wifi: ath12k: avoid redundant code in Rx cookie conversion init
Date: Mon, 8 Apr 2024 09:35:44 +0530
Message-ID: <20240408040547.837639-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408040547.837639-1-quic_periyasa@quicinc.com>
References: <20240408040547.837639-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: Pnhf3f2PHiy9QMAgrjoHC1Dk-v6ivgFy
X-Proofpoint-ORIG-GUID: Pnhf3f2PHiy9QMAgrjoHC1Dk-v6ivgFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=884
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404080029

Currently, in the Rx data path cookie conversion initialization procedure,
the primary page table index (ppt_idx) is computed within the secondary
page table iteration. However this is invariant, and hence the ppt_idx
should be calculated outside of the iteration to avoid repeated execution
of the statement.

Found in code review.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index a0aa8c571867..796c757c0f58 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1425,10 +1425,11 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 			}
 
 			tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
+			ppt_idx = ATH12K_NUM_RX_SPT_PAGES + tx_spt_page;
+
 			dp->spt_info->txbaddr[tx_spt_page] = &tx_descs[0];
 
 			for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
-				ppt_idx = ATH12K_NUM_RX_SPT_PAGES + tx_spt_page;
 				tx_descs[j].desc_id = ath12k_dp_cc_cookie_gen(ppt_idx, j);
 				tx_descs[j].pool_id = pool_id;
 				list_add_tail(&tx_descs[j].list,
-- 
2.34.1


