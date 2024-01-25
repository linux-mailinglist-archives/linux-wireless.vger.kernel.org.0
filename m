Return-Path: <linux-wireless+bounces-2480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8917C83C2F1
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179281F24F09
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682D4EB24;
	Thu, 25 Jan 2024 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="naZp3i8E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68914F88E
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187569; cv=none; b=THCfic7q5Np5okvXuLbD/T/ZmydrIAQS8O36N1gTy53Ie9fHyezQdd4A1c9K0DF9Jqk80fM3AHxIODkwVKLWT3OWr4MOMDQNtOfR+rp0jbrA0e1KYvdA4wfe0WnWL3Cnw+wGLwnZFQqRcBUWd8ND9pQ/CR9qMc9QfPJQD9SIS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187569; c=relaxed/simple;
	bh=fveO+5H+lk3A8NyX42BprP3X6Ea6DGTHOvOCQQlrhu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NERaS/pM2j9PdHIE/ep44uZbp0BZnut3E8SEELhWh8cvgalKml79Fd6f0pkMJX320L5Wbryf9UqgWv1jlfbnBKzwl7R4Hk6k7FH05lMz4DK5CnylmzQJSDAhDAhy6lF9hJ6rnudmVd213qfqT+tUdqhTHVt+RQEaZ5qxG0dipzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=naZp3i8E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P9dtPo031568;
	Thu, 25 Jan 2024 12:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=zDRhT/J+FtOUydChngJeg+g/jsUa70xFEFEH5O2dOfs=; b=na
	Zp3i8ESilCi8E+LMwL+hLktR2dVVVMgJ64DNRdaG6tTiCnlOm4yNwE1DC8lPokPZ
	eZVPtTVKYMCa7JpQk5JDlVoWJjjfWYOD/086Ls3vgypjOeW0IrCEVPu7wqdCjWUp
	0uDruUASef4NMu+df++vd5qRWXTSXJlYzztmxugJI/zTbVhXowCww55cwAhR2FFw
	3p0wHXwibzeWNxNwrVlzniuieRg+fBIOHIftiNyarNFwIiIQvgurTMSo23rBiLFd
	PTKi6LjRO4M6kQhfA4FTfLmYRzj5XUbRJeHS0yF7VX1w6Ux8LtZP8sRT03TI3mLx
	x7eA9qBzdRVlROzwiOtQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vun6w0ma2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:59:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PCxHXc009104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:59:17 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 04:59:15 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 3/3] wifi: mac80211: remove only own link stations during stop_ap
Date: Thu, 25 Jan 2024 18:28:51 +0530
Message-ID: <20240125125855.827619-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125125855.827619-1-quic_adisi@quicinc.com>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 9rnTnLTvEzNHeqmgRdRaUXS-SKaT9uFt
X-Proofpoint-ORIG-GUID: 9rnTnLTvEzNHeqmgRdRaUXS-SKaT9uFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_07,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=856
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250089

Currently, whenever AP link is brought down via ieee80211_stop_ap()
function, all stations connected to the sdata are flushed. However, in case
of MLO there is a requirement to flush only stations connected to that link
and not all.

For instance - Consider 2 GHz and 5 GHz are AP MLD. Now due to some reason
5 GHz link of this AP is going down (link removal or any other case). All
stations connected, even legacy stations connected to 2 GHz link AP would
also be flushed. Flushing of other link stations is wrong.

Fix this issue by passing self link ID to sta_flush() function. This would
then only remove the stations which are still using the passed link
ID as their link sta. Other stations will not be affected.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 26a8ea553401..968ceadd88a7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1618,7 +1618,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	link_conf->ema_ap = false;
 	link_conf->bssid_indicator = 0;
 
-	__sta_info_flush(sdata, true, -1);
+	__sta_info_flush(sdata, true, link_id);
 	ieee80211_free_keys(sdata, true);
 
 	link_conf->enable_beacon = false;
-- 
2.25.1


