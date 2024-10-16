Return-Path: <linux-wireless+bounces-14037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D39A017E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFB11C22AC6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1FE18CC01;
	Wed, 16 Oct 2024 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mune/E6B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4C18C32E
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060611; cv=none; b=Q55W7Tx23RvWzLn7EwfgP4i9YlEgkcNZp8c3dLK73tAjDuY11C9+RGec4QLz/MMg85FYdMK9UoVcWH8LImRHIyXd+plfo4kDdpuQN+OJU/tLnELm63H0x6GtTVGJHrdrSm3YduS3T3M1iSrIy/9Az30iDs/UCXDOLnO4BhRoNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060611; c=relaxed/simple;
	bh=+N4uOqsyyzECEqS3Wwlnf4yFqBi7RhPcZHmEkAqVr3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qcwgYgffkepr+SKhfPmVb9yiexy8MOGvoMyKA9uN56kPnYhVTQuoBsTnkXI0PEnXT/scVSVxYq+08IT6wAUsf3Rsp9ijFbiozv36eX6kFH28ICz3SdgGxitV6T533Zq7URJSdcVGzymhvu33m1QzofS5f7DXXnKvHe7P24vh5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mune/E6B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJEipb020093;
	Wed, 16 Oct 2024 06:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TAnV2ukSO4vvGKlgvm3p1Y
	BMFelYJ6Dod5kwnBuPw7A=; b=mune/E6BEtAe9skpiewMhGYoqS+ee/BOEep95E
	htBeIrTvJ75I4FD5blt5y5JpmlPPkHoUYhfk4GFjswiCPt3HUMCI1lPLQQzuaKtZ
	0Fl39mATJi9XyVOpJR37BQio1p9OGdRsNHf5aMRFUOi29T3yRVcuCfcy8tYaxlj9
	gIliXd4TuKbxsTaFgR1AHJo6iy0P2RDzrThMASeis5THNOTaYbzHWVTKjlLZO8XX
	k2kYJvSS1Iqc+UTzTam2j/ApnyiP42b+bQfR26gXeCImu5d+RGdmd74mtE1NF3kV
	We3iqxQ5BrHAv3P7ymMIEnQ32/tD1UIUd5st05dMz+WA3miA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429nm3kb0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:36:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G6ad0Z026513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:36:39 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 23:36:38 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 0/4] wifi: ath12k: add 11d scan offload support and handle country code for WCN7850
Date: Wed, 16 Oct 2024 14:35:02 +0800
Message-ID: <20241016063506.1037-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fErcd6FIgW8jZbXAXGdNr3Rvq5zaPdyz
X-Proofpoint-ORIG-GUID: fErcd6FIgW8jZbXAXGdNr3Rvq5zaPdyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=889 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160041

This patch-set mainly does four things:
1. Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware.
2. Implement 11d scan offload, and report country code to firmware by
WMI command WMI_SET_CURRENT_COUNTRY_CMDID.
3. Use WMI_SET_CURRENT_COUNTRY_CMDID to set country code for WCN7850.
4. Store country code, and update it to firmware after device recovery.

With this patch-set, WCN7850 can do 11d offload scan and update country
code to firmware successfully.

Note: This patch-set is an old patch-set in public review written by
Wen Gong. Just resend it for him.
Link: https://patchwork.kernel.org/project/linux-wireless/cover/20230914090746.23560-1-quic_wgong@quicinc.com/

v5: rebase on tag: ath/main(ath-202410111606).
v4: rebase on tag: ath-202410072115.
v3:
    1. use wiphy::mtx lock instead of adding a new lock(patch#2).
    2. rename struct according to wmi naming convention(patch#1, #2).
    3. update copyright in reg.h
    4. modifiy patch#3, #4 due to struct name change.
v2: change per Jeff.
    1. change alpha2 length from 3 to 2.
    2. change wmi_11d_new_cc_ev to wmi_11d_new_cc_event.

Wen Gong (4):
  wifi: ath12k: add configure country code for WCN7850
  wifi: ath12k: add 11d scan offload support
  wifi: ath12k: use correct WMI command to set country code for WCN7850
  wifi: ath12k: store and send country code to firmware after recovery

 drivers/net/wireless/ath/ath12k/core.c |  34 ++++-
 drivers/net/wireless/ath/ath12k/core.h |  17 +++
 drivers/net/wireless/ath/ath12k/hw.c   |   6 +
 drivers/net/wireless/ath/ath12k/hw.h   |   1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 167 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h  |   7 ++
 drivers/net/wireless/ath/ath12k/reg.c  |  70 ++++++++---
 drivers/net/wireless/ath/ath12k/reg.h  |   4 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 158 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h  |  38 ++++++
 10 files changed, 480 insertions(+), 22 deletions(-)


base-commit: 69eabe24843f238e79a6dbbd2b3fcc8eef39d6b8
-- 
2.34.1


