Return-Path: <linux-wireless+bounces-3137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3699849F7B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC9C1F2369D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F72EB08;
	Mon,  5 Feb 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q2Z+iJLw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B93CF5F
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150622; cv=none; b=q5j5ecmqMe845QueoPHSny3KoUZ6AjnoDEJkhekekQmz1pKIXu8bUvzchdM+px7E4IGi252qCFFS3Q5Q+EAzYG/ZJcH4reIoH8lFp7AR9L5ClQWgtAWjZJ45IiF6SNdMAwt53ognCI/TeReRt+mlCTR4y05oHvsg5YKyAbdz4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150622; c=relaxed/simple;
	bh=RyvGv2/DpLrs/7SnCmEJl2LW2ZVW9u1MG2nCiY5zUjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcHtQ6ZJxUqducMiNxlYoxRwrY+1dgpsZJBI06iKufbE3wbtZ1O85lU8/rgrrP/sb+TmQyZsD5AXdAbtErYDARSGnoIQjDRLlxxKhCHC5ciI2aGMn58j/yDyUNIUP348/1zdtwSnmKL9Mw5aZJZH5knv6nYo/h2jr+aSxLGdfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q2Z+iJLw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415DQwUJ021214;
	Mon, 5 Feb 2024 16:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=xgjvjWRDc6gYswOL2akXLO+IreXPh2JHuZBucmiX/oA=; b=Q2
	Z+iJLwyRlor/CztvN3Lrf/dipn1lyCrtCz8asnp5LgaJsq2/XTMe7viHVecy5t+V
	xZ+rhhiAlCnuxFqbAjqDrKs/8sHs9AhurtsC+MLihmXqMIzjBfzepEBUJHzA0jP9
	DvTCkr6tsuMTfECJT2iAzuEfcb06QwcxANzgpslI4RkSJ0RPS5Jw5sfXCpSuTsHk
	FLxnb4RKUMPVAS3kuh//pmEfuipn3/u0E3zz/jS5Pa9RtXi/d36LVOISvS8v8s2h
	qGxfWwOkOm3GLf6OreIpEveFkxbewpz/4AWPMu1W+BZgSM0iCwWmrD5nqXcwkdZO
	d2QqGrxaWzNd05pDp9jw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2v2591e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:30:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415GUGub014652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 16:30:16 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 08:30:14 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 3/3] wifi: mac80211: remove only own link stations during stop_ap
Date: Mon, 5 Feb 2024 21:59:52 +0530
Message-ID: <20240205162952.1697646-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205162952.1697646-1-quic_adisi@quicinc.com>
References: <20240205162952.1697646-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6pK432AdDVmzlM5L0apCuZ9D3LSa9gkf
X-Proofpoint-GUID: 6pK432AdDVmzlM5L0apCuZ9D3LSa9gkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=857 malwarescore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050125

Currently, whenever AP link is brought down via ieee80211_stop_ap()
function, all stations connected to the sdata are flushed. However, in case
of MLO there is a requirement to flush only stations connected to that link
and not all.

For instance - Consider 2 GHz and 5 GHz are AP MLD. Now due to some reason
5 GHz link of this AP is going down (link removal or any other case). All
stations connected, even legacy stations connected to 2 GHz link AP would
also be flushed. Flushing of other link stations is not desireable.

Fix this issue by passing self link ID to sta_flush() function. This would
then only remove the stations which are still using the passed link
ID as their link sta. Other stations will not be affected.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5035c2bdf348..ef28479fa00f 100644
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


