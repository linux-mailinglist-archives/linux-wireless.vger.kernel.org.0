Return-Path: <linux-wireless+bounces-22949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8AFAB71E5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 18:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D7517913B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F2427A112;
	Wed, 14 May 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gPpTJYpI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3D27EC78
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241374; cv=none; b=mHcsYKVc6+MYPEpFQx8qI90cnj1YxuwK2Wo85n6umcRzP0dzQTc63bXf/NVUbPyiVFpazejx/KGfcYaDsaZt+oTyNXIRTS2wkIwwWFDHLqjHKujqIDTq23Xp7wZxcbZp6TdqMEGdlQ30+/+n36S3Wt/zQfdpi0ViQaAtf93ghbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241374; c=relaxed/simple;
	bh=DoEeQqkejHKpDE8mQ9oTMe2zlEMalSz51twz7vrB+As=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYD7lYpzDN4HssyilD7jAPTe6KHsLDQ9/agKoWFtJXDEGu0TVjMbYEZIZClCFO40sSXbKxfMb1QNWe2TAXla4miBml9toGs6htu2vYGjNCgO54U3XPB0AbznMQ2CpIBgjeB56H96Wd4hTjsWfJ/ETtZasjaQLkTrQfv71z2KYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gPpTJYpI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAv1B7002689;
	Wed, 14 May 2025 16:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KdtD9n/cUacQH1M9TaF7ujRoiNeYExyR3vhbdLXVLN4=; b=gPpTJYpIfEYzaroX
	nmWtBQx7UwR+7sd498geS6oFiaqe3Qy0xmqJb7GLMHOUjamk0FBk2wyegI2MLFhX
	DuLhkeYBmuFXk2+v7oSeBkzrHO0+/Sb8tgi4aRmcktKSgPV8mbaBiDDy4ml+o1hg
	XlDZ2ALeJTfMiCYCoQKUhACnUJTM14bo3LRtZTbObop5gUnFsrjGgIwctV7isH5j
	aZp9j+GWbI1aZEZLZcOh3ea28wZQ4KypdeLsC5OCnwuYO/pIbDM28nWxytAm8F5u
	trI1aSPV2CkybScCMe7aCnwhZ/+e76BDnj4vIFbPXYq8POwOFoi3ip7JAjhNFoJk
	RK0sSA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbex3cqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EGnShq026242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:28 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 09:49:27 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v7 05/10] wifi: cfg80211: allocate memory for link_station info structure
Date: Wed, 14 May 2025 22:18:52 +0530
Message-ID: <20250514164857.227540-6-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514164857.227540-1-quic_sarishar@quicinc.com>
References: <20250514164857.227540-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE1MSBTYWx0ZWRfX/OW7BkhvKWFN
 egf7ZaxL/p+016tuk/ghVgA/cfLvYnskfCHD2lvf637rQhEVd1jlOt5SYc84NofLOxp31lB0G7m
 G/Krh9lDiNvuEXSsY1TbSVn2uSDLzNFtBccovAV5ovVweVW2pntCka+g2i6pXx+AQCf7HZP8N2O
 PbZdU9nntgvXYqqin1M9IMG4mz48SP26ivYx1OPFIgAa6gRJubfvIdTDJavwnQwHxUk+R0mbJnD
 3uoEboWkD9kFKqjGBlXHD8NMnylJgvBtWyNiqUAMmMuf0RfAqQGYPMdYmaVm8P/Dq+qrSpDVQa6
 gKttlSJkHtlDycPHkdCm5zCSKpd4sr/IAJLJ6pLqJyCMd7zRuY/qCXnEIaoJAivrlNkiD9Fa4k8
 x5ah5207Dpe2EnmmNP5NXeTZENpmOKpb7+whyAYZUPoOlY27llym+kx9Ndp/taxR5HfJ0pBq
X-Proofpoint-ORIG-GUID: fsbIU2aXJFAdU1HfGw8N4x4Dz_ZUjvys
X-Proofpoint-GUID: fsbIU2aXJFAdU1HfGw8N4x4Dz_ZUjvys
X-Authority-Analysis: v=2.4 cv=IcuHWXqa c=1 sm=1 tr=0 ts=6824c999 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=aSMRPBMcyynYYuKUxwgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140151

Currently, station_info structure is passed to fill station statistics
from mac80211/drivers. After NL message send to user space for requested
station statistics, memory for station statistics is freed in cfg80211.
Therefore, memory allocation/free for link station statistics should
also happen in cfg80211 only.

Hence, allocate the memory for link_station structure for all
possible links and free in cfg80211_sinfo_release_content().

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h |  9 +++++++++
 net/wireless/nl80211.c | 27 ++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 48096a23deb2..65a1a6511172 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8579,7 +8579,16 @@ int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
  */
 static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
+	int link_id;
+
 	kfree(sinfo->pertid);
+
+	for_each_valid_link(sinfo, link_id) {
+		if (sinfo->links[link_id]) {
+			kfree(sinfo->links[link_id]->pertid);
+			kfree(sinfo->links[link_id]);
+		}
+	}
 }
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a5c760605ce9..392e7990f8f0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7360,7 +7360,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	struct wireless_dev *wdev;
 	u8 mac_addr[ETH_ALEN];
 	int sta_idx = cb->args[2];
-	int err;
+	int err, i;
 
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
 	if (err)
@@ -7380,6 +7380,16 @@ static int nl80211_dump_station(struct sk_buff *skb,
 
 	while (1) {
 		memset(&sinfo, 0, sizeof(sinfo));
+
+		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+			sinfo.links[i] =
+				kzalloc(sizeof(*sinfo.links[0]), GFP_KERNEL);
+			if (!sinfo.links[i]) {
+				cfg80211_sinfo_release_content(&sinfo);
+				return -ENOMEM;
+			}
+		}
+
 		err = rdev_dump_station(rdev, wdev->netdev, sta_idx,
 					mac_addr, &sinfo);
 		if (err == -ENOENT)
@@ -7404,6 +7414,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	cb->args[2] = sta_idx;
 	err = skb->len;
  out_err:
+	cfg80211_sinfo_release_content(&sinfo);
 	wiphy_unlock(&rdev->wiphy);
 
 	return err;
@@ -7416,7 +7427,7 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 	struct station_info sinfo;
 	struct sk_buff *msg;
 	u8 *mac_addr = NULL;
-	int err;
+	int err, i;
 
 	memset(&sinfo, 0, sizeof(sinfo));
 
@@ -7428,9 +7439,19 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
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


