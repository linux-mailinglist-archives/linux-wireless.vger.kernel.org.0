Return-Path: <linux-wireless+bounces-138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C37FB03C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 03:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CDD1C20A67
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 02:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958355693;
	Tue, 28 Nov 2023 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CVxW7gz0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96035191
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 18:55:02 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS2Lthn023213;
	Tue, 28 Nov 2023 02:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=5bVWElZbJVzUBT6C363eH2FeGH4ewMadW4Zi62UQpGI=;
 b=CVxW7gz0+o9LRtFUJGNQUDxcPRxRMUrb2kjCq9hq5HVkfrcEe6bBKdWvfX58ApP3As/G
 7sxFNz+4PPwm9mUrNRsPhuK5OlLIA3zoKLd8+X6DCg46zM77pCHZGi/V4WfswpFwWDMu
 mh9/LUwlBA5OeirZ3X2ulowvyv9VdDfT/ybcxdBbV0Ft9fXLffqp4KSvBSCcp1/PRx/R
 ZeTMsYjMXVLGJ1H8FHpN37f6oLlCJkYydz+9k/xnwB56OzkcfkJtnPIU92wL0Kk/dKSe
 DvNEvdz37/yZ76NIrKNTjj61Rati+xNgJU9BCV7n+sHlBLn5BeIbgLONIxEk/cQwvFPN XQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3un586r9bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 02:54:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS2stBg015578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 02:54:55 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 18:54:54 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: ath12k: some improvement to RX throughput
Date: Tue, 28 Nov 2023 10:54:37 +0800
Message-ID: <20231128025440.46988-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: qyPMbjw6FpeIyexg8KoKfLLu-DcFwDRW
X-Proofpoint-GUID: qyPMbjw6FpeIyexg8KoKfLLu-DcFwDRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_01,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=434 priorityscore=1501 spamscore=0 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280021

Some fields of hal_reo_update_rx_queue are wrongly
defined, fix it in the first patch.

Currently the maximum block ACK window size is 256,
with the second patch, it is extended to BA1024.

The small MAC buffer ring becomes the bottle neck
in RX throughput test, so enlarge its size to get
a better peak result. This is done is the third patch.

With above three changes, more than 6% increase is
seen in RX throughput test.

Baochen Qiang (3):
  wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
  wifi: ath12k: add support for BA1024
  wifi: ath12k: change MAC buffer ring size to 2048

 drivers/net/wireless/ath/ath12k/dp.h       |  3 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c    |  2 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h | 42 ++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/hal_rx.c   | 11 ++++--
 drivers/net/wireless/ath/ath12k/mac.c      |  2 +-
 5 files changed, 47 insertions(+), 13 deletions(-)


base-commit: 16a212b4f33c4edd9ce9a9e0953b5389216e8ed9
-- 
2.25.1


