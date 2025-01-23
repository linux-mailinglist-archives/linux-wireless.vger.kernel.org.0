Return-Path: <linux-wireless+bounces-17848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C81DA19C1C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 02:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DD016BCB2
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 01:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5851A28D;
	Thu, 23 Jan 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RSEoJMEx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FF6F9D9
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737594686; cv=none; b=eKgb/hluC77ExmECWTDZ4B4spwx9KiicqTUnrOQ1YeHKInpiUZrMtFxIFmtcx6isNwgDzi62d0heLPZjIc0X9IQOv/NDMNL/csL9VqobHVuUuuQtruFissw80QtsPoEeoMYoVvR1XAyZWAImVgZDLnsFEZsu+Jj+WNu1e7WDFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737594686; c=relaxed/simple;
	bh=+4wuyWrRbw0ge7CilHGGpEX6jPgyfCrO1CKHv+ddbLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyIiUXsByvO+cGKYz7GeakzBIeDegPLFhP46UT7KWfAdR22qGnk5lNhSuEcSlPt0T8H+dcUSsM9wURjUj60+2v6O0R+feK5zIZ/yUHjnxGq7qOck7dSYg06Ukq/bq5rfdAhmBuTeg1Bwd9nxlLVCVeTy9eN8Quu0mIxc7dQFfOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RSEoJMEx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MKpcRb021169;
	Thu, 23 Jan 2025 01:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8JZyIqlFrcGKYkauA3I19CCi
	6+tTsvaVEmCSQ7RaHpQ=; b=RSEoJMExVMNBD0A7/TdTRNlSkhTAARqxvdqp4C6f
	dNiQtcNRshcL/WRhZ+gdpwsPV4yGWjZtrnI54xGiNvK2GSNx7KshipLoHcvtJH9m
	UlHsqx3an9hYGfAstkUsQ+MaVM1tYNBbVNreR23s/9XzlNTDQMAlzlBeZRqgit0u
	aDNiod+1Xv5uG809+hu3FHwDYHkwW169qjVqRYI+VoDVsO+Z2RvQu7AsMXzGuV8R
	wwc/KGqsDcgatKNjI52eXhQzhPP8p8gBZAyLXyjpvFEZy2316eQ3pYoBCparMlSR
	ghPfszr4AdwC9z+vxU7YpsrNJZMpXtHVYpLmliHt8tSjfg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44b834rd6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 01:11:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50N1BJKB015222
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 01:11:19 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 Jan 2025 17:11:18 -0800
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211: Set the WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR flag for cfg80211
Date: Thu, 23 Jan 2025 06:39:50 +0530
Message-ID: <20250123010950.1958211-3-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250123010950.1958211-1-quic_nithp@quicinc.com>
References: <20250123010950.1958211-1-quic_nithp@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Whumo4kU_TZaneRAgo47yHrcIX-mrSbB
X-Proofpoint-ORIG-GUID: Whumo4kU_TZaneRAgo47yHrcIX-mrSbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_11,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230007

Set the WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR flag in
ieee80211_register_hw() when the driver advertises NO_VIRTUAL_MONITOR
support. This wiphy flag enables cfg80211 to verify the presence of
NO_VIRTUAL_MONITOR support.

Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 net/mac80211/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 53e5aee46885..864ea54a9fb3 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1148,6 +1148,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		    (!local->ops->start_nan || !local->ops->stop_nan)))
 		return -EINVAL;
 
+	if (ieee80211_hw_check(hw, NO_VIRTUAL_MONITOR))
+		local->hw.wiphy->flags |=
+			WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR;
+
 	if (hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO) {
 		/*
 		 * For drivers capable of doing MLO, assume modern driver
-- 
2.17.1


