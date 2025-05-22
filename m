Return-Path: <linux-wireless+bounces-23291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F7AC07F9
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADA51BC57D1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01B28640C;
	Thu, 22 May 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QD7f4hQP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03851289E2F
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904207; cv=none; b=Cs14a3yQGxmhjKEb4EuRCOEuKGlV3xbR6ZW2oK+uhWjoZoI+akVs/dxrcV/rt0xSmc14ak6W6xi83dvjtxCqzhEjHr4dbvyq0Z/LYLsRBGcl4EPxMn/JeVnuOaCzWuDFaA/ehsctm387F22HSoMwiCxojjdvOnJSViuKJ9+6+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904207; c=relaxed/simple;
	bh=g7w+pqROPuMNmYuwcvP5lcOHtHX6LpOHgj6XH1FK3co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk/UNqRYc9IbxCXQxGRFdBiX3W6br/f9BP1o73f1DYP9r9JFALBNwYbWcM8VcT71X7R/+i/Qe5V3n7w23aPy0zw7gc4W5F7c7BqvDbKEqzHmrdzveJ6p4lrPDus5w3VTC66Krzqy74y5M2Z82NfqGDiwCIaU5gLxCJb7P4kg7Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QD7f4hQP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7b1VL027623;
	Thu, 22 May 2025 08:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9NT3N8CDRFMmqjV5qdcn3wWt4iMElb6vL6dHTJxidP0=; b=QD7f4hQPzXFEDvc5
	1FZN5adl15mA/jBezDbWRqMljKwcq+Ep6Qd6Ivr5MvkN6vkzgKaFPSwvKAb95qxK
	tv6fjF+J1dzaUyYblX2M/WsfyI0b4MLwFmBEeQepYGZzsOUpDrz8rrlOCFIYr/gu
	6kKMF6DSk5I8u4etRAlJ1FCDn5UpIES2biKqUZWXa8gBNhROMNrRGSXANh8XZpZ1
	oHMD6s8L/DNEBQq6yju2nNnrE96I6rNEjTsmeVL9k0S8NTqL+agUkrezvIxPtWSi
	LYASzJ1PtfwD0n19sCV4GU5aNUNcV6E5tglu68IETKZfWGxpDadbPZDBjVlo9H7g
	0jceeQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9dn3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:42 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8ufJt008926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:41 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 22 May 2025 01:56:39 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v9 09/10] wifi: mac80211: correct RX stats packet increment for multi-link
Date: Thu, 22 May 2025 14:26:00 +0530
Message-ID: <20250522085601.2741458-10-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
References: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: sGWN_aFtqOXnTq3Q0P85dhDO9-Ojz2M_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfX50LIPGInOQpi
 mgNTcoFQXWD4cytNStQ4ZsluKyKI/OAnSJD0KM/zyVuh6XT8lh3+95dVXKd+uOhHDefqWe5YEJi
 IAgNNmAcS0NhzU4CrCWJBG7RJmM9OiYAJ2HuPIZQyIShdFzkJCkrbHakjYwtDMHI+W36H7CzFab
 nHraUSEFs8ysUeRIsQ1W5mXQv/ImHSEp7XFUsCdIi01K+K6JYu9sCLYUVbbL8kNlyKGy4Qd5bKe
 cj0ag9/zBOn9w4m2KSUldf3ERzevfi0Bq5eDp6U7C55bT2dliQCByqqrkYp0TSyaE0zpOGpOGUX
 SdzMV84wnmbBIUDF9jB1mqtoqIp+LzBz7yBogOuBotochNE2zC/JuBJdeCnqKiiqWZlhIkVm8hY
 5wZ4fY0z0EsIorQQzkD6tNPc1VLw8ml4T5DhG0JQiLgDNGwvF1smr7h/Ed1cyIOMBEbAiBv3
X-Authority-Analysis: v=2.4 cv=GawXnRXL c=1 sm=1 tr=0 ts=682ee6ca cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=DHE891H7Gske2VlohvUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sGWN_aFtqOXnTq3Q0P85dhDO9-Ojz2M_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=968 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220089

Currently, RX stats packets are incremented for deflink member for
non-ML and multi-link(ML) station case. However, for ML station,
packets should be incremented based on the specific link.

Therefore, if a valid link_id is present, fetch the corresponding
link station information and increment the RX packets for that link.
For non-MLO stations, the deflink will still be used.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/rx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09beb65d6108..a3222c0e86ac 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -231,8 +231,19 @@ static void __ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
 
 	skb_queue_tail(&sdata->skb_queue, skb);
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
-	if (sta)
-		sta->deflink.rx_stats.packets++;
+	if (sta) {
+		struct link_sta_info *link_sta_info;
+
+		if (link_id >= 0) {
+			link_sta_info = rcu_dereference(sta->link[link_id]);
+			if (!link_sta_info)
+				return;
+		} else {
+			link_sta_info = &sta->deflink;
+		}
+
+		link_sta_info->rx_stats.packets++;
+	}
 }
 
 static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


