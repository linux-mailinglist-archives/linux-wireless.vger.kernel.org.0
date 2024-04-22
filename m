Return-Path: <linux-wireless+bounces-6662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF308ACD93
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 14:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DABAB25B9A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D6149C6C;
	Mon, 22 Apr 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cAExvtCo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F011CAB
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790617; cv=none; b=izbrtYqwSNaiLn1JM+8nFmxp+DCDs60W4itdpazrBXoDj5eVHtgJ8+ik7vNf4hp5SV9G1mEIJhlanbKNyA20x93Dtcd3if3+ai0aLSgOtl+RoKjVWFk0ho1IKGES+ehkcDmaNtZhAXvpTc1gHb7sBFXKwr4DVqmAzHThlNOzO8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790617; c=relaxed/simple;
	bh=izNwSkyxSJ4rCvy6htN+pfF+FgfmdxyZa07BdeRd5y8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IUvK+MnDEL0QaV/sYMenJll8KLhk9EGFi7BgiGIJYZEW8NA6Arb9JIUuP0mIjLkIdb9QtZHXNU5hUOJlIgUy0ldAtKcMRgiTE7LbhBX54qDxsmkNCdCCV5Uk6OxGoM7W7GsJ3E4wl+cnEDQhHrIxC/ZiLEp7RmnWDss44RsrP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cAExvtCo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M50AnE013387;
	Mon, 22 Apr 2024 12:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=/Vr4LT6
	8v0zjCuKssSab2fFTHg04bVGNtr0B9erHa14=; b=cAExvtCoETCqivkJqOrgPK0
	JsxlWj/BQgSioVJYbmY5Bvdw0FgAs2HUR3mRtRyplX+tidLj5sJx7H6hWEC1LfWX
	ZxFn6jiUGgo1tGS2SXoPidr01t7iPCm8KXPcKHPIi3yhGnfbPkVu2G2WNVy/qFlq
	JJJy/JdxVj8+Us5ciax/ZNSsrwPw4L3bDO5xEOLv+imtcuNuW0daEjQxgkWsBfjD
	VWdDyWDzxxCHp49JElm7Lv0Crg8XZvkCCQtEbH+dv1EPIC3v0TJ7EK8/6/bpCy5e
	QsTWQeRDEuTPtHQM4REEnwr3t+cMI5NV+6b8mb6+504aMJ/ehcriT2Hzpq1CFMg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4qdcfq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:56:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MCuoje002329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:56:50 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 05:56:48 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: prepare vif and sta datastructure
Date: Mon, 22 Apr 2024 18:26:27 +0530
Message-ID: <20240422125630.1469456-1-quic_ramess@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EVa4_UBWxZylj9ElTiNNbwt2vIzOCQBL
X-Proofpoint-ORIG-GUID: EVa4_UBWxZylj9ElTiNNbwt2vIzOCQBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 mlxlogscore=573 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220057

From: Sriram R <quic_srirrama@quicinc.com>

To prepare the driver for MLO support, split the driver vif and sta
data structure to scale for multiple links .This requires changing
the use of arvif and arsta to per link and not per hw which can now
comprise of multiple links.
Also since most configurations from mac80211 are done per link,
do refactoring of the driver functions to apply these configurations
at link level.
Add the required locking changes to synchronize the usage of these
per link objects.

Sriram R (3):
  wifi: ath12k: prepare vif data structure for MLO handling
  wifi: ath12k: pass ath12k_link_vif instead of vif/ahvif
  wifi: ath12k: prepare sta data structure for MLO handling

 drivers/net/wireless/ath/ath12k/core.h   |  82 ++-
 drivers/net/wireless/ath/ath12k/dp.c     |  21 +-
 drivers/net/wireless/ath/ath12k/dp.h     |   3 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c |  14 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |  16 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h  |   4 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  |   9 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h  |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 848 +++++++++++++++--------
 drivers/net/wireless/ath/ath12k/mac.h    |   9 +-
 drivers/net/wireless/ath/ath12k/p2p.c    |  17 +-
 drivers/net/wireless/ath/ath12k/p2p.h    |   2 +-
 drivers/net/wireless/ath/ath12k/peer.c   |   7 +-
 drivers/net/wireless/ath/ath12k/peer.h   |   4 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |  12 +-
 15 files changed, 676 insertions(+), 376 deletions(-)


base-commit: 264e95feb91f4c02f75e7dba7a67267b0022db2c
-- 
2.25.1


