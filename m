Return-Path: <linux-wireless+bounces-2131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112198310B3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 02:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACA41C23D17
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 01:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7E933D3;
	Thu, 18 Jan 2024 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b6swsY6H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2833CE
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 01:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705539828; cv=none; b=YWOxhVWeRu7Xtcy6UBPNDmsyll1R4BY7CTPkgmZvcOT0uiqmEzyymVbRcyQcCGzCF6DKZvjfZwBCMmiqS+tCi5cw/HNVjdhl/RSD3Q4PnZtWbW5C0HlK39VHiHIGYzgcUeaLtDp7b8Hr82jsx7z5uAarbPmo1VO4iyVFbwzYYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705539828; c=relaxed/simple;
	bh=75FdeJjLKWqcXM9kT1KE06Mjbqc1gP4b+Zp6TGvRArY=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=ELF41UCiRu8a4gwDLj8bkFBPkXQuXEOQIDk/zjnRAQdvm8KOVZ9VqapMQPFC52Ur0cc1hE7/syW53zMoWOAe8hzedRNsga4KgkZplgMjhhpdcdzNKRyZKTN2d3N6XUUntfQhh8XE+alXLyx85v8JBzUozGFXAGKvYJK0InfIoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b6swsY6H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I12ZOn027144;
	Thu, 18 Jan 2024 01:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=cF8r4mD
	c78o5m4S2Td8i1eIbLHuelBPWcR6tMD1JcFc=; b=b6swsY6HcEACSfi1x6BajYe
	x81DuHfV8NFv/6FQDtUwal9x/DZvHIhgpzGQkzgPU72agwFlYKYa6zUEEUv0HGe9
	X6YaIRlmmgJw6GDhYfHgeGme6ILH8KGXqHYE920q7dh8PYHbivWxSysQafb/ajri
	8wN+D3V47fmvGWe5b2gHtiCNurCAugUgKBy/7CKipWbtFSDy0+IjqiWFv/s3oF1a
	c84gHiCrMkx1TzCzC/0hjZXtlZKRzyG8l/sZ7cx7p/wYQi1oAHlIiq2JLr8N+rjS
	8E9GGMafB7uaPS0Gxaf6DzW3nlSiTtuQnoS7OGHUCR1pcGZi81bofoVB5l8BlFA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp6p3tjua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 01:03:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40I13aTG014354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 01:03:36 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 17:03:35 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v4 0/2] wifi: ath12k: Introduce hw abstraction
Date: Thu, 18 Jan 2024 06:33:18 +0530
Message-ID: <20240118010320.3918136-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: -rfV8sUPipyvEJbl2tNp18YZ6Xw4cywa
X-Proofpoint-ORIG-GUID: -rfV8sUPipyvEJbl2tNp18YZ6Xw4cywa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_14,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=285 lowpriorityscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180005

To support multi link operation (MLO), need to move from the multi wiphy
model to a single wiphy model. However, the single wiphy model allows
multiple link/radio to be exposed by the same mac80211 hw. So introduce
a new container (ath12k_hw) structure. This approach improves scalability
for future multi link operation support.

v4:
 - fixed the ath12k-check warning
v3:
 - Removed (struct ath12k_hw::conf_mutex) as per kalle comment
 - Rebased on master branch
v2:
 - Rebased on pending branch as per jeff comments

Karthikeyan Periyasamy (2):
  wifi: ath12k: Refactor the mac80211 hw access from link/radio
  wifi: ath12k: Introduce the container for mac80211 hw

 drivers/net/wireless/ath/ath12k/core.c   |  18 +-
 drivers/net/wireless/ath/ath12k/core.h   |  42 ++-
 drivers/net/wireless/ath/ath12k/dp_mon.c |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |   6 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  |   6 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 460 +++++++++++++++--------
 drivers/net/wireless/ath/ath12k/mac.h    |   4 +-
 drivers/net/wireless/ath/ath12k/reg.c    |   9 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |  17 +-
 9 files changed, 391 insertions(+), 175 deletions(-)


base-commit: 03a67f8046dadb966950a0a6acbac2839cddfeb1
-- 
2.34.1


