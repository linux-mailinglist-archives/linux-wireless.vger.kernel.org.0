Return-Path: <linux-wireless+bounces-24661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61817AED79F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 10:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BFA1898E9A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A641226165;
	Mon, 30 Jun 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ra8DsPjo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA272397B0
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272906; cv=none; b=EM/aitMNBe/PNdXesHMWwspZw3ux/BB87YWYmkeh76QPR/KMvWNN82omA1JjoYXN28/ZA2pXlCoR1lly7AjmGkYFL08s5tYhyvsKrdEaPVRRQ7STRVFE3dIifurS1bM/V/mEbjLw9N71vBZvNcGQS7oEK236n7UOY2pDWg1pr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272906; c=relaxed/simple;
	bh=q2yq3KWdnWkm0yInYeHT5zd8yRku0jXPWiDESObWxkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YwbdwR1SeXWRwuWqx8xZkIVnqgQrzcJMcRhJMug/dRKMwhqV2KSFqiV722o9lyA4MuX7oMEVddX2/wtqhRrv7HUwgIsV92SIhttrIr7g4MaqGEVEwcLm+qLlrw8HayAmkikFFXGoAmBUryFmiyH7VCGcq7oS8HueSddQIKJ3Fk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ra8DsPjo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U8DYaj025086;
	Mon, 30 Jun 2025 08:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iRxqb7fg64nMj6iaZIqR8j
	BQyGGFFeXmEZsNOLBqJTo=; b=Ra8DsPjosMhJRhPu5XYZhg5kZZoSc++RsqUELE
	ega5dynOcV7BVy+gGGThRiiudsUbnuYHk8r3RVLSbRX+tXbwt+cItxYvCYGBfn6D
	36swa1jcmr8MYsZ1x+coZe/8IVeCCGd9LMLgsqQqSzS7oHnajrZLHjpNrXYA+NGU
	N5l3nCWZ90h1BGXmIOks4LdpFGxNWfpn2Xav1zXpDCcrmRir/SKO8UfIq1gxkUly
	/EjxkLYC0mYaqkttyo8RrE76I9k6LY1+Q6gtGyhHkPyXBhKAhhVApdx7NQ7jOVNW
	9CwdZiJJ7x39m/lVWGuwGGtGB8ARFEd9ZpWOvgtYGgkoZAbQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j801uxyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 08:41:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55U8fcgK022684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 08:41:38 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 01:41:37 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>,
        Sarika Sharma <quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next] wifi: mac80211: fix rx link assignment for non-MLO stations
Date: Mon, 30 Jun 2025 14:11:19 +0530
Message-ID: <20250630084119.3583593-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: apu-sPydJW9UPQrm0YdBcSi5gqYiiFHr
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=68624dc3 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=fjvuiBosIumh2puzDHcA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: apu-sPydJW9UPQrm0YdBcSi5gqYiiFHr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA3MCBTYWx0ZWRfX9JiynrxH/qyi
 qWgohO7zURmIjawBEfOdk7TKCeEWH17Uvk1g8/ajd+4dBflT4F7qM8+atuFFujnZCrJmsDbG7tH
 uUYyvhXp+SNQVOQZOVfZ7+WEE9iRSabMzzVeDsuk1Ek2KQQXe8dXTJ/z1dGoDU+SS2zxergY8/K
 CJXU5bLLdbXDzXxeKJJMwUZxStYbzgHNzUnglfnHco/FDNp2dOxOK8dA3yFHihJMreuphee2P2S
 zJWq2xy002uOwn33EjcHcgVTsy9GvWb3fQghi/klpKgq4QcgApXfBhYDi72SmwzIILEJ6+F3s7G
 H0ZV1kcY76YCLeS2+F+3ctF5uVbqIlOoO/QcYiIpyHQqYoe0SE3UZkv0gGaUrPXGum6lYAHfsZA
 zh2rvYqS+hdO5YiFhRfP3Cz1idVzBFkJmxkZ+fz28PC8L8A9fid4E4+ek7SsUDZwmeLVhQKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=963 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300070

From: Hari Chandrakanthan <quic_haric@quicinc.com>

Currently, ieee80211_rx_data_set_sta() does not correctly handle the
case where the interface supports multiple links (MLO), but the station
does not (non-MLO). This can lead to incorrect link assignment or
unexpected warnings when accessing link information.

Hence, add a fix to check if the station lacks valid link support and
use its default link ID for rx->link assignment. If the station
unexpectedly has valid links, fall back to the default link.

This ensures correct link association and prevents potential issues
in mixed MLO/non-MLO environments.

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/rx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 8699755081ad..caa3e6b3f46e 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4245,10 +4245,16 @@ static bool ieee80211_rx_data_set_sta(struct ieee80211_rx_data *rx,
 		rx->link_sta = NULL;
 	}
 
-	if (link_id < 0)
-		rx->link = &rx->sdata->deflink;
-	else if (!ieee80211_rx_data_set_link(rx, link_id))
+	if (link_id < 0) {
+		if (ieee80211_vif_is_mld(&rx->sdata->vif) &&
+		    sta && !sta->sta.valid_links)
+			rx->link =
+				rcu_dereference(rx->sdata->link[sta->deflink.link_id]);
+		else
+			rx->link = &rx->sdata->deflink;
+	} else if (!ieee80211_rx_data_set_link(rx, link_id)) {
 		return false;
+	}
 
 	return true;
 }

base-commit: 28aa52b6189f1cc409f96910c63fa1b99370b99e
-- 
2.34.1


