Return-Path: <linux-wireless+bounces-23457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCD4AC615E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 07:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F0E3B021B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 05:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C8207E1D;
	Wed, 28 May 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lcN5MXzY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90433207DEE
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411095; cv=none; b=bZ6ZXwXt3qX1WSu4MStMSXBzJg5arfU1dO1LoTvX8UVMhv+ydJwVjRknfVVM6xBA1Yh1ssaP+5eDX/FFuWBJ92+lMQQxSBKCHMgODj0Zz7D5RZoVfb6eQaNhCS3Wo2HeH9FGQlf0iDUfekns0oE4PtlUqM+MFiVhp1KAl8XyHaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411095; c=relaxed/simple;
	bh=1A7YLCiL8i/hcUEV5LSdvHAgXfju1pVdYuuUs6+ru8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfwjml6s137h01GVOugwcmPkv6rxp4lqibc74k8eF5+gpaOUK9z6hjnbmKtJVlXwxUveKrQHL1djKVuBToNFJLK2qgDLLRf2e/yf6z2oBQWFrFiI9NFaTnaxmAbreelSnYBcI1tabHTh12JB8nlH6p/olA4AZPqPlyN0LO+BQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lcN5MXzY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RIIKvK001380;
	Wed, 28 May 2025 05:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+eFog0IL+DGUX1p/9YgrHMnFrZyFzJ4qMMoJ4xZIGfU=; b=lcN5MXzYcadFEtn0
	Gv7dCyld/QI69RcY7x8BfeqReAH1fBa5YFI4MqXxqNbjKrTflyBA15vXAR/PlxVM
	2B1JKNj87EgVnrcuksyjYo+zbFAg0byvNyT9GHOojGMJtg5qSxYfnq1EjOHEEtt3
	m01VuPTKXoM1z1nIZCgMV3vGpTalipNecp7TKmbP5nmIC6qK6rI9ve+xAO5eOBHg
	oQeCI5g49WbfODXnkArA9wVVP+TN81Zv+3vBC8suR07QkqcZf8oImeSTIWRJjxae
	XeWybRkoYf2hgldofnbuq/vj0q4nRnZM/lUdO+hV4aUaSRQVon3YtxJ/T0upI0cw
	1uV9pg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g9160w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54S5ilNQ016454
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:47 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 22:44:45 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v10 05/10] wifi: cfg80211: allocate memory for link_station info structure
Date: Wed, 28 May 2025 11:14:15 +0530
Message-ID: <20250528054420.3050133-6-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
References: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=6836a2d0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=aSMRPBMcyynYYuKUxwgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 9ZIR77aW9fV8IU6kJP3A-zrSYgHVnJjj
X-Proofpoint-GUID: 9ZIR77aW9fV8IU6kJP3A-zrSYgHVnJjj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0OSBTYWx0ZWRfX8cW3iJ47kmv2
 QxebyPMKGWOIJeT4k7AuhTduDeRFapOHUi/swwuoGX1GFLJ96wNjzh2geiibJizoRTRXj7aO7US
 mbJnRQTOH8NPQBR80cOh75V6ZJ6b76f9/kaLfKCWYSDD+QHEhh1MY0MOrSwNS8PU24iPDw2Pcm3
 Jeft0NIJ8e0Ls5qYVHwFjCowSMx37QlLzcrRvb0ETVMohqmJFNRQgx4b1HnyTBTNY4n/zM0jYHC
 Qle+pFKQu/4k8BWrwsycPYwdBiQhiGAlgeLON55PrzjukvV0L1gO84rcR/oUaKHSBSH6R117Rvk
 fJBx5hUweHrHTL6V1N7bn3twcfxNeTsZ6dB2cXDyA9V9uK67j1h/ByFoWH41TwpL9X4u5p33d3l
 8ZwuSCLDta9SyC71MwDUzSm/KtBfvgaAh6coUxIRDFts4j4gac9j7kdqWAIcJCZZNjXX4V3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280049

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
index 42f35a5d550f..0ed64ec3d49a 100644
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


