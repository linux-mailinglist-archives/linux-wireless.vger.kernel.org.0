Return-Path: <linux-wireless+bounces-6361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BE18A62B0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 07:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B0C282615
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 05:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5483381DE;
	Tue, 16 Apr 2024 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NAzAqPy6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8C381C4
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243612; cv=none; b=moJu+M9CIWL6LO0d3KPEyDleXFL2GzOvagdy3zCtqOrez0cS6iaw6YbNHJE3I62jR0NFUl7sgFXRDqcCOd0m0xyq1Ad6kU6CUO1o/ATIM3BmvWXByRjwWBA9uAt43AGzfVkAAxb8yukFZPdyh+ymUGW2oD8kfLAj4WEfS6dK/n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243612; c=relaxed/simple;
	bh=HVzhK+pLhA5w/jPYbbeqxrgxGqowgkIfTY4c+Xi6xEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DguMkQ4gfnUlz8MWdE1Vyv++G6AwgpzgZ4wVcZkXszjmx66bqAhmZSMZj/noXQOAyzj+wBvK+r8e7oKW/MDB/FiHfRM0d5aHSNahLAB09MS39kcVVqdJThhEjt2ZTQGTQJ9G146W2s4azf0QPtQIiub31LNDpAf+wWGQXhioRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NAzAqPy6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G2w9IH006328;
	Tue, 16 Apr 2024 05:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=qs/djIE
	NjG4RS8T9NQgor8fSl5QkWKUVzsn3hR2W9gQ=; b=NAzAqPy69yxS0aJFsDLWwOT
	KuV2UmHvcwOKUF4aGhtVcVuxNPSpjn0Zp/myY6yOLZ/YN3x/j4H6IRz9vVUvjC1M
	9wFF3m6rCfjK9LVu7xxONlQrp05bvX3nZoznC4G/V+FytNEv/ePkL1TnAPZlKbpw
	5k9rzj2WJvOpkhONdv6p8VHtkfD44jCQW75y3FZhInafryt9efcFJe4Jpo8iK5XS
	0sGQCg4CVcBCjSx9K+6uUOx9qhQ1JwgxALskk2JSJWwLOHrIK9nx6P1E8XgTm2X/
	/a7zLRi+vbdkSo/Wloinqh6YdU9Py+8h7Kthdb9Niay/HSg/XhHBMjzIMkfNupw=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh1m5jd4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G501DA021519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:01 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 21:59:59 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 0/7] wifi: cfg80211/mac80211: add support for HE BSS color handling with Multi-Link Operation
Date: Tue, 16 Apr 2024 10:29:36 +0530
Message-ID: <20240416045943.576656-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 7wOL1vuq7XvHqDUU6ZRWfyNkTaVO5FAr
X-Proofpoint-ORIG-GUID: 7wOL1vuq7XvHqDUU6ZRWfyNkTaVO5FAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 mlxlogscore=792 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160028

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
 drivers/net/wireless/ath/ath11k/mac.c         |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |   3 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   6 +
 include/net/cfg80211.h                        |  29 ++--
 include/net/mac80211.h                        |   6 +-
 net/mac80211/cfg.c                            | 138 ++++++++++++------
 net/mac80211/rx.c                             |   7 +-
 net/wireless/nl80211.c                        |  10 +-
 net/wireless/trace.h                          |   6 +-
 11 files changed, 144 insertions(+), 67 deletions(-)


base-commit: d26a0a66f9290a3665e283826637722507af5ce3
-- 
2.25.1


