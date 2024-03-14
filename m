Return-Path: <linux-wireless+bounces-4723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C266087B65F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 03:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B98EB22261
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD11E8BEA;
	Thu, 14 Mar 2024 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jOY5WsXq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59C8BF0
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710382735; cv=none; b=jZxAvIYfZo3jza4H1Yguv1TMgHTCKNnYL9cHRuDXiLw3bzU1bpWYFs2idsl1W5MjVttp7XXaqJX0nKkAoVR4QxBqzNUpC4eI5WSfECGcHtfs1cSTeBDu1aPQjxDFausiIwTGFpSf0Klosq1QsteP1QwJXF2a8wCh0BLaOdse4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710382735; c=relaxed/simple;
	bh=9iM/11sT9kOWMGfoQLvHE6E9N7wkulCFhi7gR/+qe4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lVz2XBwb1OUDobI1P7ad6NZAIlSBLzaEq/wCsV+Ez73++ta4vH4V4W3MYZCFbH5FkjbBAF/4Ggy3AMVXaO6/6f+LjstcCtxtKzt5lSLVnwBH9Pqa8urABQUBwZLgOSLUcHaYlRF5v8r3nE+yDhwoB824ftxBH1TH+nEhHZoSty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jOY5WsXq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DNUCf2007946;
	Thu, 14 Mar 2024 02:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=AF+Yixa
	uiBvNx6Jv7nypnceLeuDXIqSHpxLS02SFiXE=; b=jOY5WsXq5MeLyBROSNgZ1qz
	2k76ZuqK335X/frx1Yau3cS+g6MDPjMTwFA1KNUBqNIn8y+lgwmVFvGz6XIdZsDH
	qNGa1B9SutEQu8LGjhw1KUV93QbMQcgZVdxaD8Qhi+8isWbEL1ftX4Lj0aG6gwAq
	zu6puYLhdvlKjhkYoPk2lRPKel4vPRW+Zo7Bk7uah6aQ3yacALcGFu++QK8OmgX7
	sshicTK+zMdTcBKEc6mhf5YZAPfQnnSPbRNzIz4ZIv5ZqwuWBeWrAT4meIDzvqQn
	MD3yq3V2KWmL65Y7VjBlQsiP+AzG+mLXtYpbpOQSG/EDPOu4GKcEN9AQWIVOSgQ=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuc5f9qy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 02:18:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E2ImB8028585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 02:18:48 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 19:18:47 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH] wifi: ath12k: remove duplicate definitions in wmi.h
Date: Thu, 14 Mar 2024 10:18:30 +0800
Message-ID: <20240314021830.305021-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tJwJ1WpBwyOlKFkqc02K9fFhnRIKU72T
X-Proofpoint-ORIG-GUID: tJwJ1WpBwyOlKFkqc02K9fFhnRIKU72T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=874 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140013

There are some duplicate definitions in wmi.h, remove them.

No functional changes, compile tested only.

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 103462feb935..eb9a4d5aa44c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -164,10 +164,6 @@ struct wmi_tlv {
 #define WLAN_SCAN_MAX_HINT_BSSID         10
 #define MAX_RNR_BSS                    5
 
-#define WLAN_SCAN_MAX_HINT_S_SSID        10
-#define WLAN_SCAN_MAX_HINT_BSSID         10
-#define MAX_RNR_BSS                    5
-
 #define WMI_APPEND_TO_EXISTING_CHAN_LIST_FLAG 1
 
 #define WMI_BA_MODE_BUFFER_SIZE_256  3
@@ -4776,8 +4772,6 @@ struct wmi_probe_tmpl_cmd {
 	__le32 buf_len;
 } __packed;
 
-#define WMI_MAX_MEM_REQS 32
-
 #define MAX_RADIOS 3
 
 #define WMI_SERVICE_READY_TIMEOUT_HZ (5 * HZ)

base-commit: ffd4e60352172cc167ff74e8bfd8a331a5830013
-- 
2.34.1


