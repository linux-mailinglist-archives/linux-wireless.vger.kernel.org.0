Return-Path: <linux-wireless+bounces-16444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB29F4659
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 09:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DFE67A5AFB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DA31DDA09;
	Tue, 17 Dec 2024 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CdT2gmgA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE81DAC81
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425131; cv=none; b=BL+eE1bdQ6yY7Ljq3+FOZR3K4FHrheDpjypuLeSNfsW3Pz44XBejAnbQ/f796LxeZ0qx8i3x6Qnt9XWIQ3/d/C2SnhEYIGBnqFpK6T/Q84fbT0K0al5QBC9RfE4bnDzWH9HKin+oJTam57TKG+P2uHenZWUrq+7p5dS8jTVDYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425131; c=relaxed/simple;
	bh=1uPPEbXkZ3rNoIIOxFqr97gCT2nMwS/XIuZn4WC4dHw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oN6lRQEg7xMojqBhaL2B1NL0RRL0jv3rN3ZGtSGc9SDXwcT1V+TMBLxflcf1i2U64i3YzWS9/LmSKdD+OUnJnDwk6TbAUQpbliDY95Zv6PwKj0qLUSRWZcMz4CvxAqg1bxPylGODCTR12vHajGH7vraJnLu8WUO8YmbvjJ9K1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CdT2gmgA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH629L7006099;
	Tue, 17 Dec 2024 08:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4shnESK351X/5YDbb34cqG
	TPOfH9ydsU2HqAL3UPaQk=; b=CdT2gmgA0v9++cqOh1MTstfk81zjudb7SVvBrD
	Ssc1dp2GbB3R0PTSQK1/6ysiJYxw6OXvEKv9409ZAUglff3WbDZhp1wbOLtTqgbC
	GWUPFkDQE1Asu59LbI7bmiNnB141EXCTxEubsdmkPz50mYm+Na/16Omb8hOBTixq
	Z+s90xicdD+8BXp24yrWYA5KaHtVrjClZnzaN1HBX8LqBKI6wakQdXImUVdITX2r
	e/ZLEBZNCZtip6WJcgpRgbHWgR0xstKcq0QxH4jSNdkhu55kv1QO9arTKC6UhSqa
	iLEbffl9NAusSxaEYflGENsRc004XsnqUErQ1sR30fN2lUZg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k3p48dhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 08:45:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH8jPMd031025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 08:45:25 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 00:45:24 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 0/8] wifi: ath12k: Refactor the monitor status Rx path
Date: Tue, 17 Dec 2024 14:15:03 +0530
Message-ID: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: 6sIEITuJkrBfLv_eNBP8U9Oza_8EOdM8
X-Proofpoint-GUID: 6sIEITuJkrBfLv_eNBP8U9Oza_8EOdM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=693 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170071

Currently, the monitor status Rx path was inherited from ath11k but has
not been updated for the ath12k 802.11be hardware. Also there is no issue
at present since the monitor status Rx path is not enabled. However, in
the future, the monitor status Rx path will be enabled. Therefore, it is
necessary to update the TLV structures, bitmask definitions, remove the
unused bitmask, change the Tx monitor SRNG ring ID and refactor the
monitor status parse handler.

v3:
 - Rebsed to ToT
v2:
 - Rebsed to ToT

Karthikeyan Periyasamy (8):
  wifi: ath12k: Add documentation HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
  wifi: ath12k: Refactor monitor status TLV structure
  wifi: ath12k: cleanup Rx peer statistics structure
  wifi: ath12k: Fix the misspelled of hal TLV tag
    HAL_PHYRX_GENERICHT_SIG
  wifi: ath12k: fix incorrect TID updation in DP monitor status path
  wifi: ath12k: Remove unused HAL Rx mask in DP monitor path
  wifi: ath12k: Change the Tx monitor SRNG ring ID
  wifi: ath12k: Avoid explicit type cast in monitor status parse handler

 drivers/net/wireless/ath/ath12k/core.h     |   4 -
 drivers/net/wireless/ath/ath12k/dp.h       |  14 ++-
 drivers/net/wireless/ath/ath12k/dp_mon.c   | 134 ++++++++-------------
 drivers/net/wireless/ath/ath12k/hal.c      |   2 +-
 drivers/net/wireless/ath/ath12k/hal.h      |   2 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h |   2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h   |  14 ++-
 7 files changed, 72 insertions(+), 100 deletions(-)

-- 
2.34.1


