Return-Path: <linux-wireless+bounces-13679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E7993E2E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 07:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1399C2843BF
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 05:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2A137772;
	Tue,  8 Oct 2024 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nA1kLEHW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7823A6
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728363991; cv=none; b=FAuHCLEAD9m+UFJTu/DulwXQ9SQ/8C77FuleqTboTMxDSEtyAXe6Elk867kmWPtb9SvTqJiuG6gzDb0pWu9qF/vTKgebwI977Rktl7ShXaeDRmNyxLxl23+mQNlfXa6V3UMDpQBw8ah3JQGxL6FldRvzJIXdIvuCnOU6CGCvwr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728363991; c=relaxed/simple;
	bh=D4x9L/x7mJVFxgCBP9PIUjzT3/VeaqxT0ynKQrN9yFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JvLXujwbwAQMMSiON5aR78OtLsdpSmH/Ao+rxLu1vDJx4+xVhYZDls5OzDHCHx5j5KHcVMA8qWBoCVTLjWfUsxaH2gSsFd+jMV1tQmDtnLSUFUmtKqRODQVIstXvDG4Qca9Z6lc/BBy60H96YoIrfAiuU8Di6DBOUZXx36Bpo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nA1kLEHW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497Ev2dW017601;
	Tue, 8 Oct 2024 05:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jsJtcu1jA1+4y+T6ldcYoY
	VwwLZ2dAVh55aSHciChls=; b=nA1kLEHWA8D0FTWta7YE4ZfvuHhdmELP6XrEnd
	tlQZznmOmGWeLsFG6DEw5wFmqLwWAc+rvyij+7EkErp4ESZrplBNEO5z/dkbNVMs
	sxy6lWlPRjsH2ZDXBhTMt4OFbVUs54V2iaFdDQPsHJRloCGi7y+nixtistAQY8HI
	pQ2Ts035EQG3iA7SKLF+6233/krWk01RbseKH9aLJS45P2J7GK352fuYEhmPgi10
	51aJtz5pc/3E6nDrBVm0o2Wp+XzmlXq0pqs3ANa3SAweLpIO9X+eECJuqgAC7VOg
	YF7Uikxbqro3lcgpIvMVvgraprIbo75zSfn6HPy8nDeF8FoQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs4e7m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 05:06:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49856NdP014177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 05:06:23 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Oct 2024 22:06:21 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 0/2]  iw: display wiphy interface combination in info command
Date: Tue, 8 Oct 2024 10:36:05 +0530
Message-ID: <20241008050607.1113396-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Ei0W_JXhps-xLSbUjX_7UHKNlmPyWNLW
X-Proofpoint-GUID: Ei0W_JXhps-xLSbUjX_7UHKNlmPyWNLW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=925
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410080031

Wiphy having multiple hardwares grouped under them advertises about it
via NL80211_ATTR_WIPHY_RADIOS and NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS
attributes. Add support to parse them and display in info command.

NOTE: nl80211 sync patch is sent for testing purpose only. Actual sync
      can be done in its original way

Aditya Kumar Singh (2):
  update nl80211.h
  iw: add output for wiphy interface combinations

 info.c    | 219 ++++++++++++++++++++++++++++++++++--------------------
 iw.h      |   7 ++
 nl80211.h |  65 ++++++++++++++++
 reg.c     |   7 --
 4 files changed, 212 insertions(+), 86 deletions(-)


base-commit: d088c8a4ad03b8f74b11dec55f895cdc7576b0e0
-- 
2.34.1


