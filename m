Return-Path: <linux-wireless+bounces-13689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6EA993F8C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 09:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0B8283D39
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120101D043A;
	Tue,  8 Oct 2024 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AmzG/htE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBA1D095C
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370775; cv=none; b=MEU+fnKwejraxkNxI6iYD5FB7NZ+w0g1PaSwH72F+thgBrkgUGZYdpHmQIYu6QvxZuD/cSr03M3yIg9L5VoufYQdR+x9InVnjfsmybGmJg7sX8J/sZCfoXP/bNLuig2TTyxyThO5WRBsfKei9hop4rC5IWkzwKCaO85oyZe5p5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370775; c=relaxed/simple;
	bh=ca5aQy7+DG508N6ygCCG/Uu0KeyMaN9rkv64yo7aooE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ltLibJO+VXoeFnGkty2vYvQxrkaNVVaQvaB+hKVy0lSV55gPPd4EJqmkITfh0RjQ3W//qAFq+6o67+NidD6E7o45Qk4Ppet1z5diXzcZt9blEzISW9FCyl4wolIs97jnNstCyIQWq76IQJydRDJRNx/dJ7aB0e8O8I8KPwwacYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AmzG/htE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49851Xpd010523;
	Tue, 8 Oct 2024 06:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fLG8DpscNWw2auGxUcWqHg
	4NSVnCvU+rzSRVWeCQRpY=; b=AmzG/htEKfL6ewxvfvzzdcMWMKJYu/J8suqzjt
	o0EM2B7LRo3EoE3cDERXF2IwSC0wJPn7qOXDPOU2s7j1ILX67P2rr0cQ3aEs2+Q2
	q/tNY6RsDwwJpPlQEL+oaBbMZ9o5OsiQsWC/H0Dn4SW/P5heA+auKtj0ph4l6yp+
	s+mQCWzTO6dvFPcUbhB2OXS7+1cZvWkWjg9E/ldIWjJgf88dOT9wUzL+f6NGeRlM
	yRzMnOOSuzQv0IKE3/PM2C9JQrZGQ54Tbw2quiUwxikjjJSxEqm6KskvikqS7FMS
	z8Wr7Dc0M0nNzqV7596aRjsSdHqxNFwcgmrZ90weVb/xQnfQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424x7rr7ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 06:59:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4986xTpn030377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 06:59:29 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Oct 2024 23:59:27 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 0/4] wifi: ath12k: add 11d scan offload support and handle country code for WCN7850
Date: Tue, 8 Oct 2024 14:56:34 +0800
Message-ID: <20241008065638.1142-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: lkYvuiFz9THF-j9iEgdPZNUepe2sdDIw
X-Proofpoint-ORIG-GUID: lkYvuiFz9THF-j9iEgdPZNUepe2sdDIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=911 spamscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080044

This patch-set is mainly does four things:
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


base-commit: b9545f4570fcfebe982439de7c9106e55b4bf756
-- 
2.34.1


