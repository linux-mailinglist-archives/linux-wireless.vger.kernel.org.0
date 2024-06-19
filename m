Return-Path: <linux-wireless+bounces-9225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C64890E235
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 06:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18951B22CCA
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 04:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD432A8D3;
	Wed, 19 Jun 2024 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GVf03ovv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0355884
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770237; cv=none; b=auNMpKreHkN8E1GGvAH1kuGUy1xhnr3sXRNJEEYM+ocEZrg/ZBihkodNSwOCYS/6th61gaF+tafsexlRfHhiEHamL6NSsTIBBWgi/Nvh3vap8SB52m/3g3R2vMW72HCtHvAbFsu19GjG20vJ62h7BQ7dpAeIF4EPkB4MG5vlMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770237; c=relaxed/simple;
	bh=p9VeLXrVXqZ7v2vt2XZuMm8Dj/imrcQzP0sjO5qPR7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNmpOu6XrO3O6fFifCxmzDxDHxnpFwIEFDD+LGFdZknB+xQrcZ8eBaza+6IpAVuYMi+hPDfn052icz7tPibz7byonFfputJWFshObBhj0ubmEBUtDSy2QAV5mzfDtfgYCuZEQimbbw4nfjyhy+1gYTeXJIWsvKBxO9zrT9vhz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GVf03ovv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILaK2k014853;
	Wed, 19 Jun 2024 04:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pgyljzOsemmbt3W+YQVcYHcVAxp7HdhcfwGrCh8plvs=; b=GVf03ovvZUrGSasu
	l+Ks/h1WuIP1yZgtOj1yRnnYTsXhfCay9N3emGPXu89ekzrAVBoSQyl0FPRd9wRR
	uxftYXvjI5f/1+iG4DmgHCPMIcrjXxZa7Filz34yiDv/Trf7cg7CxzTh1T8N5w9q
	Y2Wdwx/7HQyVZFaxKQsmXxs3mpL77TVHMCZRU/CB7kxFKpX9c/YKNHCGMMBuLOxQ
	P+eZK8q8YlZZEqs+k2O3sGXwif1qBwj910leZnIf8CP+MzLNgSobeqNrXPRJ/uDJ
	t4iTVsCNl7ITqeQAo4m5yUoCS9zJLXhs0VfvvSpbcEw1CKaXe1cNMX7IxxQ4UgkV
	+ugXlw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9x0kg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J4AV8F022842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:31 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 21:10:30 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 3/9] wifi: nl80211: allow CAC while other links are beaconing during MLO
Date: Wed, 19 Jun 2024 09:39:53 +0530
Message-ID: <20240619040959.1457547-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619040959.1457547-1-quic_adisi@quicinc.com>
References: <20240619040959.1457547-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rflR5LnhiFcoMA62Dr1E2WbYgQNruiFO
X-Proofpoint-GUID: rflR5LnhiFcoMA62Dr1E2WbYgQNruiFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_01,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=987
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190029

Currently if any of the link is beaconing, CAC can not be started.

However, with MLO, it is possible that interface is beaconing already on a
link that did not require CAC, but now another link is being started that
does require CAC. Hence, same check does not apply to MLO.

Add changes to check the link under consideration is beaconing or not in
case of MLO.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/wireless/nl80211.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b44332dc52be..7420a966997f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10025,7 +10025,20 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		goto unlock;
 	}
 
-	if (cfg80211_beaconing_iface_active(wdev) || wdev->links[0].cac_started) {
+	if (cfg80211_beaconing_iface_active(wdev)) {
+		/* During MLO other link(s) can beacon, only the current link
+		 * can not already beacon
+		 */
+		if (wdev->valid_links &&
+		    !wdev->links[0].ap.beacon_interval) {
+			/* nothing */
+		} else {
+			err = -EBUSY;
+			goto unlock;
+		}
+	}
+
+	if (wdev->links[0].cac_started) {
 		err = -EBUSY;
 		goto unlock;
 	}
-- 
2.34.1


