Return-Path: <linux-wireless+bounces-7531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50C88C3621
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 13:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074DA28173B
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E71CD24;
	Sun, 12 May 2024 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MhURkBv7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCAA1CAB2
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715511806; cv=none; b=KDqq6by0IcqpIvgIyKmG0Zx2lhhBBBVNiGyNZEyOEymtG4FM+XLlcY209DXomWXdAOGD5vEJ6QpGsllF3POP40hf71jaH4YYLo0uVXhO3Vbx+F3coCnpAdn8Bwwi8HbET3KM1AAzdIhECQDvrvMLt5wkY/8OEp1bn0EIWZsAwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715511806; c=relaxed/simple;
	bh=yYj7aL8A3BTzLqfDDla7jzqTVReFBJ1TO6NKrJ8ogh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hBJUDbj9D4C4btoB9RWurD5ln77f8E98MF2X76xYPZ1/x9dq6uTfa5/VXtAwtVdYhSoXx7Ub3Bxrou9ATqA7aIJKqd8V5oYjg+zCfYLPaZRbBtiSXJYg5JlM1qBOHluLBlN1LCbtMeO9kB3hewMVTtqAdsBMVK2fk5hT7a9+FFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MhURkBv7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44C70DlK005907;
	Sun, 12 May 2024 11:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=0TkP1of
	Q9/M7Xhxb32vl2WjCX6fvJ510gnM2k3F+gTk=; b=MhURkBv7gUdpuovlXNbgBkP
	QK2AjGZZr/I0ehS3stwCX/HDTSGCIb86DIdHAVX4LSRvgBFjEWVkPeJ0RtSbLhvM
	8LE5VtJV1S+qxHvMHZFbXb7PyshF8RxNwl1eUjYaySRaRvBtJOvY3kVBI3lVSI+d
	9fGFqjzT5/fhKdKuueZlhSNfeCPGQQsZV+IDwW0rsXAmMJWcoXwezrMt1yFpkUjG
	yXSnnsFH2hODt5g2LZtAsyjqEsqM85Jmv4I/JCbLb0uYdDsI9josxFs9l+ntSe5p
	mXBnupJ5FyW77a9sHGcF49F2keVCjXLlfIjDlEUtZKIPujUHkiKDWTQFR88S7Iw=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y200f9nvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 11:03:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44CB38O5009864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 11:03:08 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 May 2024 04:03:06 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v3 0/3] wifi: ath12k: prepare vif and sta datastructure
Date: Sun, 12 May 2024 16:32:48 +0530
Message-ID: <20240512110251.4062260-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: 37n5o8bCO0A-DHriJ2XkJYtl3lRVNdMJ
X-Proofpoint-ORIG-GUID: 37n5o8bCO0A-DHriJ2XkJYtl3lRVNdMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_07,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=636 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405120082

From: Sriram R <quic_srirrama@quicinc.com>

To prepare the driver for MLO support, split the driver vif and sta
data structure to scale for multiple links. This requires changing
the use of arvif and arsta to per link and not per hw which can now
comprise of multiple links.
Also since most configurations from mac80211 are done per link,
do refactoring of the driver functions to apply these configurations
at link level.
Add the required locking changes to synchronize the usage of these
per link objects.

---
v3:
 - Rebased on ToT
v2:
 - Rebased PATCH 1/3 on ToT as b0afabc4d7e0 (wifi: ath12k: add support to
   handle beacon miss for WCN7850) has introduced few APIs that use
   arvif.


Sriram R (3):
  wifi: ath12k: prepare vif data structure for MLO handling
  wifi: ath12k: pass ath12k_link_vif instead of vif/ahvif
  wifi: ath12k: prepare sta data structure for MLO handling

 drivers/net/wireless/ath/ath12k/core.h   |  85 ++-
 drivers/net/wireless/ath/ath12k/dp.c     |  21 +-
 drivers/net/wireless/ath/ath12k/dp.h     |   3 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c |  14 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |  16 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h  |   2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  |   9 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h  |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 856 +++++++++++++++--------
 drivers/net/wireless/ath/ath12k/mac.h    |   9 +-
 drivers/net/wireless/ath/ath12k/p2p.c    |  17 +-
 drivers/net/wireless/ath/ath12k/p2p.h    |   2 +-
 drivers/net/wireless/ath/ath12k/peer.c   |   7 +-
 drivers/net/wireless/ath/ath12k/peer.h   |   4 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |  12 +-
 15 files changed, 681 insertions(+), 378 deletions(-)

base-commit: 1025c616ee13372f3803b158abb1d87ef368ae3d
-- 
2.25.1


