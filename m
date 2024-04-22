Return-Path: <linux-wireless+bounces-6630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C818AC3BE
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 07:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886F1B22348
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD6018B04;
	Mon, 22 Apr 2024 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pl0/tu3V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38E13FF6
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764088; cv=none; b=RGJBZJgfwot0mYRbzvd57+t2LlMWkXX5ToK38FXTWd7NJSHNGBgXoU4L1QuMt9PAVqvO1VdqJthNM5Np+Ri+AMCvDMrWvBvUis8Jte0x2MUYPHyhOn19uEJ1/JcCBlaNUlKBIrM3tSSOq1xjfOccFCCoRN22DVYChXPkQebhL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764088; c=relaxed/simple;
	bh=Ef3Z/C4qnuYPIZmr+PzI54GhLPTLuQbx51Kj2h+uraw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CZi9Zicl5f+aqv8hzPnpsbKwEl4BX1JzzSik29tW+74WsqfhGO9egF+ivWBXhYYIF+i9N7X85r2eYk2zkgWeq1OoE6/toMCsIkvVUL94PZrOZMCzaS4Zj2bhX1JZLPUMBRAPnwOgu/vjM9xmwK/CiMf9yL+B35IIviPKRg8IRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pl0/tu3V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M3TiC7010535;
	Mon, 22 Apr 2024 05:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=0vLUa0d
	DYwcfoKBRm6JzcsMYrXtMRNeKoP5k3UP9aOU=; b=pl0/tu3VJ4/SbrOdKLw8k6S
	DsYbyruCWtci/4BMCNIUpsGNPNCNZgoTi6Y9uNqDbssGeCSpnpCZ+AKEHRnKo5Y1
	Mqt3hueMUmlctgbptojEztR18rhxqrIaQy9f61pAyn9zOQ1hwzFmH1ghLDRE3uWY
	HHKr9b7G2KBAff1Z2acOMi6PqQdT0USqW8h5s6Qq5ftfT9ncMx9c+B9vRF6RIY2e
	qulT7XV0U8xXTU0txUptpU9tENjdFiXyO7Uer4vYXqNpT7Q20S32rrGF6Ufc7B4I
	XPOZezheVivF0iT+e1Nsn8/pKFNVDFI+WxBa+9Fgazfwk0tyPi9w31OLTzH35sA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xned0gbgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M5YVhL006164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:31 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Apr 2024 22:34:30 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 0/7] wifi: cfg80211/mac80211: add support for HE BSS color handling with Multi-Link Operation
Date: Mon, 22 Apr 2024 11:04:05 +0530
Message-ID: <20240422053412.2024075-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: RWtjiNfo0u6AOd47AIL-lEdQLhXtB4zY
X-Proofpoint-GUID: RWtjiNfo0u6AOd47AIL-lEdQLhXtB4zY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_02,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=905 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404220025

Currently, deflink (or link_id 0) is always considered while handling HE
BSS color. However, with Multi-Link Operation (MLO), there is a need to
handle link specific data structures based on the actual operational
link_id.

Hence, add support for the same. Non-MLO based operations will continue to
use link_id as 0 or deflink member as applicable.

At the same time, add support for BSS color by mac80211_hwsim.

Aditya Kumar Singh (7):
  wifi: cfg80211: send link id in color_change ops
  wifi: cfg80211: notify link ID in bss_color_notify
  wifi: mac80211: handle set color_change/after_color_change beacon on
    per link basis
  wifi: mac80211: handle color_change_abort and bss_config_notify on per
    link
  wifi: mac80211: start and finalize color change on link basis
  wifi: mac80211: add support to call color_change and OBSS collision on
    a link
  wifi: mac80211_hwsim: add support for BSS color
---
v2: * Rebased on ToT
    * Fix sparse warning -
      warning: context imbalance in 'ieee80211_obss_color_collision_notify'
               - different lock contexts for basic block

---
 drivers/net/wireless/ath/ath11k/mac.c         |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |   3 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   6 +
 include/net/cfg80211.h                        |  29 ++--
 include/net/mac80211.h                        |   6 +-
 net/mac80211/cfg.c                            | 144 ++++++++++++------
 net/mac80211/rx.c                             |   7 +-
 net/wireless/nl80211.c                        |  10 +-
 net/wireless/trace.h                          |   6 +-
 11 files changed, 149 insertions(+), 68 deletions(-)


base-commit: b0d2d8f996c1ce3d4c8a1c8cb7d634536e7c2118
-- 
2.34.1


