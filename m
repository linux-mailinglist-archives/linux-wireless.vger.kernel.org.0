Return-Path: <linux-wireless+bounces-22982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561B9AB7D43
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 07:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E848F4C685C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F185C1D79A0;
	Thu, 15 May 2025 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ea7mWzYH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853329616C
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 05:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288176; cv=none; b=BZRcHwjLF0GBQgjBjqSnCACdRYnV/BzcSUZTww4adRanPZlGHBo4oQu7n5goLiX1Ad1hsMfR5XIN0HVDwDlzxaxAHPwVAS7AxuWtws2HyOUmLSl6v4XntC7F3P0nyHWggEnCI5c8L4+0gUtFUzxp3VApg4mHNUSOo/fHWXOHrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288176; c=relaxed/simple;
	bh=JynbsBMhBwctY/aG/CR5OXaInEbfjkVV7ik3+YYmVzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeuailtBFxddbdmdkklLHKl4MFi8hx6Fc2giO4WfqihX0XzGxu1U6Tb9Bfidud6ligb53NWs6X/KarpatCCWGqKAo+vT/iTg3dOf7GuilGPudidwuKrS3FMl8jyKQqa3d8WaPOzUsuoFYIrAdK4SRNzEPXBgZHLhkCWiTrGO8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ea7mWzYH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJZeNm020085;
	Thu, 15 May 2025 05:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vVrUuN76Km2exhslLlJqDY3WOA66sZLfzM2RuZ7IE78=; b=Ea7mWzYHaFdE54wN
	Ly2RFValev7F+eUr+VhSPmSE5nFzE/TUzw6AYpaH82KNsegjmlPAV3wcwOgzOQuR
	EKU6J9XpkXp8CtUQlTR4cTc6hQ9RBKDSpjXx5GBN1U8sIxI9E7bwO0EnVoJsY5O3
	gqY0MuJ2QQMG8N3v302cMtupSPiM46VDpwEky+sYa2iOzwifFD8yl/q7FIWEFNJS
	cEvaQCgQE7fgdGkgYrrwKO+Wfd2XBx6vKiqGYSsHMreKwZi1Vd7JJtd5jqmw1Pnz
	wBQNe1mDb1ZVQXk8UJuIFmZnqB4BPe5larKFLYeRjlO9nITjGZ4/+zI+BhpkWSSA
	oT0XQA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnn0r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F5nU9V001075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:30 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 22:49:28 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v8 05/10] wifi: cfg80211: allocate memory for link_station info structure
Date: Thu, 15 May 2025 11:18:59 +0530
Message-ID: <20250515054904.1214096-6-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: afxzcavllGZe1fn2ZSG6WHbZUDtEkd5C
X-Authority-Analysis: v=2.4 cv=aIbwqa9m c=1 sm=1 tr=0 ts=6825806b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=aSMRPBMcyynYYuKUxwgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: afxzcavllGZe1fn2ZSG6WHbZUDtEkd5C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1NSBTYWx0ZWRfX/iUGlVO3duOW
 HSVQjmXO6RjTmzuzHBW2vW95qG0BZDw1Fx7/qccPduy08Hpv+hNS7v3YYItKNieQVw3+gnPnZGS
 t6/LaEeRxT6WNaq2+BalwGLjc1Qx+C3NJqImyASm5hUnF/HbO0VuqMmqH9aNyZMRpOhOwod6tIE
 uWErvkK0uOjsr6LlMplayc2TNnWAOytktEe9/nChR4lxjUSR/WCmBfTf0j7ZCLwDCQVI7qxu2zW
 Y4aBD4XrciBi3buZsWfCf/vTSe0ZNLwUNmvifcCsiLfSUKsrgMjb7wHctL/s8i5RuKqnrQhrhj6
 7mXnizC4pZv/l7giCMjwvvL4XJkzUohFA643fGlNFYT8elip7brZJdDxGH40RJNscrUs9eU8ksu
 lGSRtDdxiLNdiIXPjvf7wtTxnimyJvfu4peGO+exOZtIs4rKN5J94HEqgysJTq88gR3QsoBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150055

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
index 9095a8304d1d..cc0b89d0578c 100644
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
+				err = -ENOMEM;
+				goto out_err;
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


