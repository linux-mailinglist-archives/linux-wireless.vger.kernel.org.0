Return-Path: <linux-wireless+bounces-4292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE0386DE11
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 10:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED04B26581
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5759C6A010;
	Fri,  1 Mar 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZT+8MUOa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BD6A349
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284798; cv=none; b=KbcNpTWuXFZKrTp4Qcljwj2N/Uzljh6smhr4sT9A6sQ42sf4aRz4+CsXQbWvEk1c4ryhLye7t12y/sZGdGic7IVYfN57WdRCNBKdfkkGts4wFnDQo8m2tKm3LMMydfP96uo6w4e+E5dxVRD8t7klC18gYJh7xrfZAgehz3SguEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284798; c=relaxed/simple;
	bh=O3uSb78VQTyr447S9tx6An27b440Z1mVOuEkfd2PlqI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=okO0OgtX5XeyoJ1xWzPWJYApz+olPS2WCXbFedRb2exgRa+YXFOqfTkDZgyxxuV/Y68hkdGzfIQ++Mz/abhRiN5Bh0tTuNqNgjR5b+vNy4ixTXDt2o6p+VbR2OdzA0UKAO8yop3xhKTsdLDxmN3u91JoAqk3BEOMnz4ZSiwQ7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZT+8MUOa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4216dKtt007913;
	Fri, 1 Mar 2024 09:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=mqrA/FEteD5a
	izcdbYN8KUPQeHydd8N7yBQigBnz1+E=; b=ZT+8MUOa4OXVKM068e30ZoqODKRc
	4VjOUgkHoKhJuBv5gz7p2wMYm8MuNpcRNYNDPGOHJDjCufu7q5dt8W4LdkX16whO
	qseLXqWdraN7DtUBpKggk6W3xln1PGs9zTg63ggSrq6ViCw8m+UYJxrk0POqCryQ
	8jBB/mIhIq6/zErBplUtHuA2J74xpHeWGkKJNxOPVrI9XfVWE5URpZbMmAToGyuh
	en+2pFWmkgV3rCltMJWMEAFgYCUApIef7UcqpgbGs9CFxsVLHsun7ay+NBhK2MIh
	qa4JXmhUlcSNO3hMs9s27NOV88s0eAkM2ieGeod2qPoFWFW0/zC66Hwq2g==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wk5brs0c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 09:19:41 +0000 (GMT)
Received: from hu-maiyas18a-blr.qualcomm.com (hu-tmariyap-blr.qualcomm.com [10.131.36.89])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4219JboB031767;
	Fri, 1 Mar 2024 09:19:37 GMT
Received: by hu-maiyas18a-blr.qualcomm.com (Postfix, from userid 0)
	id 61292A0053C; Fri,  1 Mar 2024 14:49:36 +0530 (+0530)
From: quic_tmariyap@quicinc.com
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: remove reserve member of wbm completion structure
Date: Fri,  1 Mar 2024 14:49:36 +0530
Message-Id: <20240301091936.12054-1-quic_tmariyap@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -t__FcW58jZvyHW2sCAXuRQZh3VItyO4
X-Proofpoint-ORIG-GUID: -t__FcW58jZvyHW2sCAXuRQZh3VItyO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_05,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 spamscore=0 mlxscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010078
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>

In tx completion, status desc obtained from offsetting the address
from wbm ring. Having reserved 8 bytes in status desc offsets the
address twice and read the values from the incorrect address.
So, removing the reserved 8 bytes from wbm completion structure.

Also this patch is applicable for WCN7850.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index eb2dd408e081..d01fc0b0c9a5 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -387,7 +387,6 @@ struct ath12k_dp {
 #define HTT_TX_WBM_COMP_INFO2_ACK_RSSI		GENMASK(31, 24)
 
 struct htt_tx_wbm_completion {
-	__le32 rsvd0[2];
 	__le32 info0;
 	__le32 info1;
 	__le32 info2;
-- 
2.17.1


