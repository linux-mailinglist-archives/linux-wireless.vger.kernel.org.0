Return-Path: <linux-wireless+bounces-7355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681088C05AC
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 22:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231482821EC
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E5E39AD6;
	Wed,  8 May 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X0r2oDQb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D21DFC5
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200177; cv=none; b=hrgjf7Ob/xefSAKWr0Hk5nSitEEGpDgIO9CvfuOTFQHS2o3CQGnn0RIe9XhaTmL7ANq7u9cVNKrVq2dcFm8XQ7v3SWSj3B4wIqLpnUovReylD8TgPziJCSfpcpCBLOGmtKmCicOyh9VS7aNdAJmVOfnQzRicZ2nRW+piW8NXq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200177; c=relaxed/simple;
	bh=NR07HW/pIHo2DZaXRGaUhkxV0MsWAsjI2lH/R9Qpgtw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=juSb3Hlicy5E1rkXCbpAnxiejJmXPi7VaMRtIgpJB4WWGkH0Nmx4R2wT8lSuDmzRErcHdf+J+nmWeUbsPxasqXXstI7Z8Y5G8qbBdDp7rFgGPvFBiEqa0UNh4yomU7glu+06zdaXMFaAYPCIGqtFj+AFcq8zxnRMLym3A2Pt/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X0r2oDQb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448CXBW8005908;
	Wed, 8 May 2024 20:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=N6umCKl
	z8QXrWrUgmeJKBy51fG0HofSZLDLKhMe9MMA=; b=X0r2oDQbyfv/xUCyd3lwEku
	4p1mNlQFv8qGqHPMAYN8E8fKllam9tgkNZnrOJ9Pd5Ie+ga8ij5t9z56qbbaNzZG
	GoNPbJUTgqVKE0TM1DuGdbutcoaq59i/Qe82OqwwUi/zmiPRpYwTgh3hZi/vN8k0
	FbAZWl03kNloxeegmkUTMzKEuHzX6wiERhHECE2rS0balIkLeFeRwDcRRNaw/Y9F
	4flEIERJQgWUGZ2Aqkl2aT6yCd+tF+tZctaiSKhZ++Jp1hqp6Qr5zeFbr1aVMw5i
	bHI6WsfWebrA3dPvjo+Z6E8TQ93Ebrv3IHRuwKwbdT+IqeIwqGsziUeU6DoFcEw=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09geh25n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 20:29:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448KTM8I007881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 20:29:22 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 13:29:22 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 0/9] wifi: ath12k: MBSSID and EMA AP support
Date: Wed, 8 May 2024 13:29:03 -0700
Message-ID: <20240508202912.11902-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
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
X-Proofpoint-GUID: 98Cd6-4mhXEh4XvEhfsDeM9_9qOe0BZj
X-Proofpoint-ORIG-GUID: 98Cd6-4mhXEh4XvEhfsDeM9_9qOe0BZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=920 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080151

Add support for multiple BSSID (MBSSID) and enhanced multi-BSSID
advertisements (EMA) features in AP mode. Set extended capabilities,
WMI resource configurations to advertise the driver support to
userspace and to firmware. Configure each MBSSID profile by sending
BSSID index, total BSS count to firmware. Retrieve and propagate
MBSSID/EMA beacon templates to firmware. Set the arvif security
parameters for non-transmitting profiles.

v2: Rebased v1 patches, no functional change.

Aloka Dixit (9):
  wifi: ath12k: advertise driver capabilities for MBSSID and EMA
  wifi: ath12k: configure MBSSID params in vdev create/start
  wifi: ath12k: rename MBSSID fields in wmi_vdev_up_cmd
  wifi: ath12k: create a structure for WMI vdev up parameters
  wifi: ath12k: configure MBSSID parameters in AP mode
  wifi: ath12k: refactor arvif security parameter configuration
  wifi: ath12k: add MBSSID beacon support
  wifi: ath12k: add EMA beacon support
  wifi: ath12k: skip sending vdev down for channel switch

 drivers/net/wireless/ath/ath12k/hw.h  |   1 +
 drivers/net/wireless/ath/ath12k/mac.c | 324 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/wmi.c |  40 +++-
 drivers/net/wireless/ath/ath12k/wmi.h |  46 +++-
 4 files changed, 345 insertions(+), 66 deletions(-)


base-commit: 1025c616ee13372f3803b158abb1d87ef368ae3d
-- 
2.39.0


