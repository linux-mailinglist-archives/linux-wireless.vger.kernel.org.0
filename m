Return-Path: <linux-wireless+bounces-18822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD3DA31EFC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 07:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934D8166429
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FDB1FFC59;
	Wed, 12 Feb 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AQf/hndD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34AE1FF7D9
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341953; cv=none; b=HsXT9z4chB/Fv8btWR0/S3ESMQfB7PbT6r5JC7vmsP7BS7joCd1qiZGGP70n4XWiSo7RN614rJiGBdQlij7ybPYnBlqpbmHYNOgfs25VqNGhjLHkB4L9paoY30KIRisB6kDIQuAjbiKbNGwspchmpF1RxZ3i4J1dby2wK+TzyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341953; c=relaxed/simple;
	bh=xPA6ViTbjVY8pZZ+lX85un7m41EqZeEdA+XYWUskrbk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mGaY77jCYP3TRdbH3QLCRJqZ1GwlaHuvcEwbHAWtQBCQBx6V7iOfB0iD0kE3j9pdJuRxHo08Jq89XWJcuGhzlEsl+nq+YT52h5k6wN4vCKQC/TW0v6idXQK1MP9VcYqvk72GqSyJl2UAhwoC0V/WoF1a4lkLRTW2KKi2AALywSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AQf/hndD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C0gMqG030148;
	Wed, 12 Feb 2025 06:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=np0rdtRopNEAnKI2XKL1UL
	XDN2mxMMuhtZxnbKzE1uM=; b=AQf/hndDJs6ebgIgOeFH1rXS03xft35b+LCOk1
	XFy116HQ0zzq0DOGxSwxyS+FbuOj+P4fLrRgX5kV5ECqZj1SdhLkQmTVgjdK8N3j
	M17RflTR0HcwedD/ZQlNch25ayvGIdQG7y5KlCN+s5ueMwUeOpBC7PeT/G2sbB9l
	euSklalQR3/Nux9BTPvSExULBc6kk0J3hEWhlNk528KSpg+T9j4KmdDWsEP51Kuf
	4zZCBwOcEeVGnb3oXqMJcoTKjkej9OpZhf/uBS6pI34dkUnKMHHIoYujxTaZrFKe
	aTTaBHyTi5au8K+ADQQmccrEV6Dt/IpZZ7UacCPXaQc+wUtw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxg9kw2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 06:32:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51C6WOcO031027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 06:32:24 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Feb 2025 22:32:23 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v10 0/4] wifi: ath12k: add 11d scan offload support and handle country code for WCN7850
Date: Wed, 12 Feb 2025 14:31:56 +0800
Message-ID: <20250212063200.1631-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
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
X-Proofpoint-ORIG-GUID: axl4ciwOG9yPBuMYvsHwSrn0CYxHx8Nq
X-Proofpoint-GUID: axl4ciwOG9yPBuMYvsHwSrn0CYxHx8Nq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_02,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=918 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120049

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

v10: rebase on tag: ath/main(ath-202502111625).
v9: update copy right in patch #1, #2, #3.
v8: rebase on tag: ath/main(ath-202501172342).
v7:
    1. rebase on tag: ath/main(ath-202412191756).
    2. rewrite commit message for patch#2.
v6: rebase on tag: ath/main(ath-202410161539).
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
 drivers/net/wireless/ath/ath12k/hw.c   |   8 +-
 drivers/net/wireless/ath/ath12k/hw.h   |   3 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 167 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h  |   7 ++
 drivers/net/wireless/ath/ath12k/reg.c  |  72 ++++++++---
 drivers/net/wireless/ath/ath12k/reg.h  |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 158 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h  |  38 ++++++
 10 files changed, 482 insertions(+), 24 deletions(-)


base-commit: 704a2d7237043317ed1b0f8a08203e9ddde70097
-- 
2.34.1


