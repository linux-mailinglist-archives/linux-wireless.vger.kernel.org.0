Return-Path: <linux-wireless+bounces-6366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 221768A62B5
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 07:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200281C21702
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093E39FCF;
	Tue, 16 Apr 2024 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ntYKBp09"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DDA39FDA
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243624; cv=none; b=TvK6ZGjJfNR/JRXCu+MxcL8nULwDrNdSMpRRqpRmOZO6HOjS1ve6lZLimPmQk4H/DsS7npeIyVGrasblm51r7CGD6Ej6+af8iNqTqqq2FsJJl+vucYTFPv3M7hHY0BEnNawo0j98/yoNVu6mDzOzESS7yXdrVrDmvEZ5vzfs4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243624; c=relaxed/simple;
	bh=UwAjjjZWj++YCBYjDviX0/SCOuyW069AAvJC2T1HFSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kauBQewbicfiBSyGCNVS2H0C2RO/Auei5B9OYty/Dwr/fDPcf6xEt2brjNHq1ns6ZtYQhEspxRLL3b/l3XEfe11utWxn8W6eQaBtmzPtA/ZU2o1ey8ngA3xhSx+gJD3nOSP6by1cYmFZgqYO3N5AlNYM+WNCyjfoK9FIKnhcWDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ntYKBp09; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G2wSKW015615;
	Tue, 16 Apr 2024 05:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=x+GV2XwqztwxE2ZCwmqbxE6izqUdCwRrWrcNWuj/RO4=; b=nt
	YKBp09T1L6pOHqBW8O0jxGWqDT+8x40N1sG7AlzHPo4dSqRKxllFL5mTSli4SBSH
	QBay3M7wlKLi4UPM12o64xLUAqLHzMc48xD/rTQkfATWPgtbY7ScoExqan22n9dO
	gJ1Eol0dIXXjcRic95jnk27hHOPb3nJ+hqD3KPwivuxMdTE7tsiqqQu1JXooLf0L
	A4Bu+H4XF99j8ZM6oAW1LmvV23T8Wu/IeFHwPkJmGJ9i9qAhw0WaFtzdmPmwM/Yq
	SQnEDp4REDMD7T9kOYb36vSCSorSgE7FQkOXqvF88kelk63mma71JFlWCSZ8aeas
	WuAfEnH6AG9jSQO3bfFA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhbg88tau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G50Fim012427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:15 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 22:00:13 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 7/7] wifi: mac80211_hwsim: add support for BSS color
Date: Tue, 16 Apr 2024 10:29:43 +0530
Message-ID: <20240416045943.576656-8-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416045943.576656-1-quic_adisi@quicinc.com>
References: <20240416045943.576656-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 6rBSRsX-GtDXw7K4Dqc3nsRHbRQtvsfj
X-Proofpoint-ORIG-GUID: 6rBSRsX-GtDXw7K4Dqc3nsRHbRQtvsfj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160028

Advertise support for BSS color and then once the countdown reaches 0,
call color change finish.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4399eb1d9f46..2298e89fb7b6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2313,6 +2313,10 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 
 	if (link_conf->csa_active && ieee80211_beacon_cntdwn_is_complete(vif, link_id))
 		ieee80211_csa_finish(vif, link_id);
+
+	if (link_conf->color_change_active &&
+	    ieee80211_beacon_cntdwn_is_complete(vif, link_id))
+		ieee80211_color_change_finish(vif, link_id);
 }
 
 static enum hrtimer_restart
@@ -5323,6 +5327,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_BSS_COLOR);
 
 	hw->wiphy->interface_modes = param->iftypes;
 
-- 
2.25.1


