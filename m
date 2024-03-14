Return-Path: <linux-wireless+bounces-4722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79A87B659
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 03:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD9A1C20C29
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8953A0;
	Thu, 14 Mar 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NsSUi+K2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459EC5382
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710382635; cv=none; b=MAdz7I0cCO4S4vHVOePOnZxsIg7BGwIrBRov67gncRQ1+p0nwBoou+pwyfHQkRVgUWhyXvLyMUv5LXZV5XNAcZYbYzQJzN4xUKr+E2B97hxbOVtxRTLJIzMZhfTNuPQAYbKTn+tiU4X0WDGmYBTOx+Tz0TIoXHfoYjb881741Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710382635; c=relaxed/simple;
	bh=sCX8Jy5AEWcDoiXqn4HluCaIA1ut43G0HjDn/h/eWyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OCIZVKA2seWFxJF9WOHrcDtar+cTvxtmop8ExgbmQUlsIPqVwDomE7REUnSX+nh+KpnR9M6JTlJxqD3ixIpILBSe798JxtN4x10w0S3K2Ho+95ZZozR5gCAOdT7n4g3kR45gG2LyO5btOkstbuBilLop9jKDEBEA8RNPZmZ66SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NsSUi+K2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E2GDD8030338;
	Thu, 14 Mar 2024 02:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=iXAg3/t
	4zciRq7NdBZckuchQaOw2dcXJbb9usAECZu4=; b=NsSUi+K2+6ws7Wg5V3xnXr9
	3DzF/Dfn5kfbprTrWJMhXsMXJM1ru7Qg6mEvvzq+M2EK1T9BblyRDmW9HqPAJsOE
	c/krtzq/VpCNLnYwzdWfKhe3Uo3hzHzep7iooG1iKX0NTVxIW3PqWrBIiOLo0vuR
	G3Mm70kjuVWCpGa3NrqzjRjzAVt008lQ1WfFYACXZMqixIhTg+VcDmhsd0nOv8C1
	KBoNt4h7fzMPijiKD1phhlu5UgBKrfkMLmdItulrv5SMH1FNqXhHBEa3Y7MW0XDQ
	pNC55waoZWNuNtKmr3wjoZAmCQVXQQpRgIM9jbGDWmebGaAks1Q2ZMVLB9N4VmQ=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuapehxeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 02:17:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E2H92M020968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 02:17:09 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 19:17:08 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH] wifi: ath11k: remove duplicate definitions in wmi.h
Date: Thu, 14 Mar 2024 10:16:54 +0800
Message-ID: <20240314021654.304451-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: IZlkHV5k9ibIXOnOuhloUpu6gbKLg_Ob
X-Proofpoint-GUID: IZlkHV5k9ibIXOnOuhloUpu6gbKLg_Ob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140013

There are some duplicate definitions in wmi.h, remove them.

No functional changes, compile tested only.

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index bb419e3abb00..9652f4eb2f32 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -60,10 +60,6 @@ struct wmi_tlv {
 #define WLAN_SCAN_MAX_HINT_BSSID         10
 #define MAX_RNR_BSS                    5
 
-#define WLAN_SCAN_MAX_HINT_S_SSID        10
-#define WLAN_SCAN_MAX_HINT_BSSID         10
-#define MAX_RNR_BSS                    5
-
 #define WLAN_SCAN_PARAMS_MAX_SSID    16
 #define WLAN_SCAN_PARAMS_MAX_BSSID   4
 #define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
@@ -5740,8 +5736,6 @@ struct wmi_debug_log_config_cmd_fixed_param {
 	u32 value;
 } __packed;
 
-#define WMI_MAX_MEM_REQS 32
-
 #define MAX_RADIOS 3
 
 #define WMI_SERVICE_READY_TIMEOUT_HZ (5 * HZ)

base-commit: ffd4e60352172cc167ff74e8bfd8a331a5830013
-- 
2.34.1


