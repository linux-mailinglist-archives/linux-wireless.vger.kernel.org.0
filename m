Return-Path: <linux-wireless+bounces-8592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCC98FDC84
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 04:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC4E287B61
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 02:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9719D8A4;
	Thu,  6 Jun 2024 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LhIeqkCB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD141759F
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639637; cv=none; b=ioRfJc9jo+sVRUUz4XNuXEUGzP5VEJl/8aU7sKjkBkeMy3OzOw5I+ZdAWrRDdI+IVG1DsRuC32FFQcjz7fBakzJ3HX/C+be9dLJfVyShKwE3TTMuS+Lm7e1ArwHDkUzlpSiucAXdyXcKRlO5Qc1dt3ddRtIgz19tKwyHL0TgzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639637; c=relaxed/simple;
	bh=SA5io7JC3lZfnJ69x2VKNjRXNi/8dEPFEEyvwJwTUJQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LsKJR8q4easmo1Bs3C+TMkDdSeC/HTJAqUmfXLdcI/Fwg2g0U8vQZv2arhbG6otkG0h+6J0as1cbaMlD6Inxy+PAJaO0l3uUEi9lmO/rU+agrGWSBfDcTFRbPNt5mfUAxysedck8zqD2dFJ4bh7GQk7QNqG3+/9xlh1zK4dVMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LhIeqkCB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455LVaom031023;
	Thu, 6 Jun 2024 02:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=r8njuQzuaw+5+HQcC33A4V
	DNXTJUrFMBsi8C0gnsJlM=; b=LhIeqkCBMqOpMxHCKG6lZ7IsVQuGxpTky9VHbM
	9+bGfhAlfQKcYEqdiYXnBbWrTL4DMpcQ0+TvWW0hqTeCqiR8OWT6iCKvsAwGbJuw
	so+YK5NK/TQ86xgYkS+V4ScfLDzmNAtPQuYAjjjihH+GtDHY3WuHDyTCEM1D2owX
	LAO+6PhX04vvwTagc0ACg8CutSkBPkhgZgvULmAZDMcABZy/A35pPOeQtEMiRvm1
	/dEBBHRyXnHN0FJJ9bervZx18EgiWWx9A7PvKfB8HHG4pQO4deWkXW5EBRSozece
	t+fB5nsROvresnXvl3ZzzwQNRbBdDInW/yBUCtN9CHD1oTfg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj87rkktd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 02:07:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 456274bq025307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 02:07:04 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Jun 2024 19:07:03 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_bqiang@quicinc.com>
Subject: [PATCH 0/2] wifi: cfg80211: handle 2x996 RU allocation in cfg80211_calculate_bitrate_he()
Date: Thu, 6 Jun 2024 10:06:51 +0800
Message-ID: <20240606020653.33205-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: JAMCmeMwzNHWOTPsDjn9QCISX_nsONjF
X-Proofpoint-ORIG-GUID: JAMCmeMwzNHWOTPsDjn9QCISX_nsONjF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_08,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 mlxlogscore=691 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060015

Handling of 2x996 RU allocation is missing in cfg80211_calculate_bitrate_he(), so add it.
Also fix a typo while at it.

Baochen Qiang (2):
  wifi: cfg80211: fix typo in cfg80211_calculate_bitrate_he()
  wifi: cfg80211: handle 2x996 RU allocation in
    cfg80211_calculate_bitrate_he()

 net/wireless/util.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)


base-commit: a116bf2be795eb1db75fa6a48aa85c397be001a6
-- 
2.25.1


