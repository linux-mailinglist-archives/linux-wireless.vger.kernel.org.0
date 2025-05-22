Return-Path: <linux-wireless+bounces-23287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 656C0AC07F5
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D385A1BC51DC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A7F28A1F4;
	Thu, 22 May 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f5huxoNX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403AC286893
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904201; cv=none; b=Z47kiMsB0DuNAypib4HSGQavkI8psXf4n9S0SA9/r6rphm7otAQLoxF+gEXWwtBzbpnod0gvfpr7Jo8aQ3KbCrxO4gi0TUvamc0TZWFeX/exLNKVSiftxsUw5ej0VY+K8RO/OZgGI0YunoFemSzCHOPKtGG8ma2p9rKy5YyyWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904201; c=relaxed/simple;
	bh=fq/yozysxrskP+CC++xGvhuduFQ3x8ZgtG38C4JV5X0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOIydKRmaN994s/EU/iHcglO5ZgGN9mRmuvP/lS7LMuHPQHvQQiHkh019uoIg9QuISk2aHhUHh254ASAVcfzyOo311HFBBdRHJ7c0htiAD6MBQ0mJC4fExSxqpCYw2oJSPcG++CGHuu01IlCP8nQgldx8CUku1de+HbQfVyXuiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f5huxoNX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M8c7Yw013895;
	Thu, 22 May 2025 08:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C2MJ58Zknjcg7u3bMS4kdk2thy9DJM7Dph5x2iQ/JLA=; b=f5huxoNXBsgfsIUH
	/l6yLaMIbSEIx4sMI7889o1QX8/XfqFlrm9S9Ye6PXM8c7/HYwcDi/FLl8QZhe8J
	JBrTWLsD2P3WPx8YbYOPOt9H7jsBesOQGVP0MqO5+8elf1RT/7YMkBkNtb6Yqy3g
	zvQ1eodEPit8MzahoArjZZsNj31/YLPb+6gSODgTjg5S/FRc/GlICXlD3QuG4XL6
	KRaMOi4BppUHvsci8vP3eNjT05n7q7coa7ub2Bpnzm5LDbTipnNy6/64HGd8N7vX
	BEK/d6sdwnO+nA6iPefS6kPLFruq/N39/A2/qd4GLg1Jbnksznthl7rikN2NMr5y
	ty0oug==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9dn3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:35 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8uYQg030078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:34 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 22 May 2025 01:56:32 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v9 05/10] wifi: cfg80211: allocate memory for link_station info structure
Date: Thu, 22 May 2025 14:25:56 +0530
Message-ID: <20250522085601.2741458-6-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6rUdZLYILnKnaYDfQsdGh9lsNCqQm7XA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfX5ZKyPJrvkF4r
 rXybcyaU9cikqBFKi4nM0x3HUATY0lo8MitqZSPRYpV1GShp814ok5JIYCAowvlWlTFjSs/VR5d
 Cn5YOyoQELWwecQThZNrSoYn7elS+HrITbCdB47o5K+s9xMzDAk41bL+Uv+QPZjJXpVbLdgNCFA
 HZ86C3ahZsRELGwzsJEc0BpKV0j6xdfZQKVe4djMg6u0AaGyZ4HbV6UFvfn1qoHNAaTeqVSGnF0
 s23RkRjVaH7XCIufeofBJ9Uo2hMbw2dNo86hWUNDazfkYh/EaQvY+MbBCplHsWATa0UtKEgvM5S
 MhW6HYUQ9KfrRtlwZ+2PPgZF4GXjNcI7hTqvoKt0i5raobgVJq7epWuFVjUW0C9+Rp0VZo/pBZT
 DRi92sQJNdvw5Ws3TTVhszumUluVwE3pA834tCRi+C/f4QQfrS2G0Diu311xwdYwB36xU997
X-Authority-Analysis: v=2.4 cv=GawXnRXL c=1 sm=1 tr=0 ts=682ee6c3 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=aSMRPBMcyynYYuKUxwgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6rUdZLYILnKnaYDfQsdGh9lsNCqQm7XA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220089

Currently, station_info structure is passed to fill station statistics
from mac80211/drivers. After NL message send to user space for requested
station statistics, memory for station statistics is freed in cfg80211.
Therefore, memory allocation/free for link station statistics should
also happen in cfg80211 only.

Hence, allocate the memory for link_station structure for all
possible links and free in cfg80211_sinfo_release_content().

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h |  7 +++++++
 net/wireless/nl80211.c | 27 ++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e2a41cdca4a3..b29d1322d5fc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8577,6 +8577,13 @@ int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
 static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
 	kfree(sinfo->pertid);
+
+	for (int link_id = 0; link_id < ARRAY_SIZE(sinfo->links); link_id++) {
+		if (sinfo->links[link_id]) {
+			kfree(sinfo->links[link_id]->pertid);
+			kfree(sinfo->links[link_id]);
+		}
+	}
 }
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 16429d3707d7..71d3b6107983 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7366,7 +7366,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	struct wireless_dev *wdev;
 	u8 mac_addr[ETH_ALEN];
 	int sta_idx = cb->args[2];
-	int err;
+	int err, i;
 
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
 	if (err)
@@ -7386,6 +7386,16 @@ static int nl80211_dump_station(struct sk_buff *skb,
 
 	while (1) {
 		memset(&sinfo, 0, sizeof(sinfo));
+
+		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+			sinfo.links[i] =
+				kzalloc(sizeof(*sinfo.links[0]), GFP_KERNEL);
+			if (!sinfo.links[i]) {
+				err = -ENOMEM;
+				goto out_err;
+			}
+		}
+
 		err = rdev_dump_station(rdev, wdev->netdev, sta_idx,
 					mac_addr, &sinfo);
 		if (err == -ENOENT)
@@ -7410,6 +7420,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	cb->args[2] = sta_idx;
 	err = skb->len;
  out_err:
+	cfg80211_sinfo_release_content(&sinfo);
 	wiphy_unlock(&rdev->wiphy);
 
 	return err;
@@ -7422,7 +7433,7 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 	struct station_info sinfo;
 	struct sk_buff *msg;
 	u8 *mac_addr = NULL;
-	int err;
+	int err, i;
 
 	memset(&sinfo, 0, sizeof(sinfo));
 
@@ -7434,9 +7445,19 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->get_station)
 		return -EOPNOTSUPP;
 
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		sinfo.links[i] = kzalloc(sizeof(*sinfo.links[0]), GFP_KERNEL);
+		if (!sinfo.links[i]) {
+			cfg80211_sinfo_release_content(&sinfo);
+			return -ENOMEM;
+		}
+	}
+
 	err = rdev_get_station(rdev, dev, mac_addr, &sinfo);
-	if (err)
+	if (err) {
+		cfg80211_sinfo_release_content(&sinfo);
 		return err;
+	}
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
-- 
2.34.1


