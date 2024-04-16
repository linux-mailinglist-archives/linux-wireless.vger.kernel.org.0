Return-Path: <linux-wireless+bounces-6362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8E8A62B1
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 07:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2FB1F2112C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 05:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B37381DE;
	Tue, 16 Apr 2024 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g5olfTvD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39515381C4
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243619; cv=none; b=BbPBV8g0dzuX/FHnaOddwh0Q3rv+oIC5gcOInDKH6DQ+5I3I4rR+PxoegmCF2knqybP8s9kpwQqcUZkyL3Q9e1l1fPwVFkvKD4YpCqiWGgkdvEAuOUU1kFz5HEUEHEVEabChPt6L4IOLvYwAtCwmdNylUYbk5LMU6WbatSklYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243619; c=relaxed/simple;
	bh=rTZcYv4qs+rIYMCy26E79qFvv7coOO4lv/ldOKvKvjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqOcQkrrUE/idXwRIqIQwa4+uouioFfqPEOs+cgKuOIeCM1b7i+Y5kp/38uz2fU+Zm9gcQ+ZsOH1iiQr8FEm4mPidYf4VPymQWeGd+UbMcIsZJJQ5lcfUizeScUjQulKiQTO9hoZtB99ftN+RjQCEE3uapQoIacEaCR/vQPe968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g5olfTvD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G0SpuM027426;
	Tue, 16 Apr 2024 05:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Eggx1Omwg5XkPBCknvyvg9fDz91sqH79N/bczjdg8Ag=; b=g5
	olfTvDTizfeKw3s/aEA6wgKVG+nNVwmXeqwipgAzYjlWJostI8qFK2B6azVcn2bN
	Miu+APQiOzNXF/GOPf2yaAa0UPt138mVshx8CBuAb4xUYXpL+q+LfLn7AtGlbbam
	rNVw6AeVNiWW5NCeibnae0pfxVOBkTf0Od/xNiUXoVpUpcYw9mQrUqQ0ACk2MbAc
	ZibJSyy+K4GkGiATVbc3PmE2Y0dBDM6/7yXgbHex3W6TlOxPIWDFGVVFTq+68HrQ
	mda5Dg1w+pr3NNNyqafTL22OrgER29TqjqeJOq3SiB8oLOHZpLnQTw5aJk5sVb2y
	pzKU1/7/X1LGnL32jEEQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh5jx9q5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G5037H021687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:03 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 22:00:01 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 1/7] wifi: cfg80211: send link id in color_change ops
Date: Tue, 16 Apr 2024 10:29:37 +0530
Message-ID: <20240416045943.576656-2-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: TYEB3njHuLiIIeMVhklAAYI4WBkmVzrs
X-Proofpoint-ORIG-GUID: TYEB3njHuLiIIeMVhklAAYI4WBkmVzrs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160028

Currently, during color change, no link id information is passed down.
In order to support color change during Multi Link Operation, it is
required to pass link id as well.

Add changes to pass link id in the color_change cfg80211_ops.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h | 3 +++
 net/wireless/nl80211.c | 4 +++-
 net/wireless/trace.h   | 6 ++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1e09329acc42..0e2b3e0c8541 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1575,6 +1575,8 @@ struct cfg80211_csa_settings {
  * @beacon_next: beacon data to be used after the color change
  * @count: number of beacons until the color change
  * @color: the color used after the change
+ * @link_id: defines the link on which color change is expected during MLO.
+ *	0 in case of non-MLO.
  */
 struct cfg80211_color_change_settings {
 	struct cfg80211_beacon_data beacon_color_change;
@@ -1583,6 +1585,7 @@ struct cfg80211_color_change_settings {
 	struct cfg80211_beacon_data beacon_next;
 	u8 count;
 	u8 color;
+	u8 link_id;
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b4edba6b0b7b..a9d01cd16196 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16029,6 +16029,7 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 		params.counter_offset_presp = offset;
 	}
 
+	params.link_id = nl80211_link_id(info->attrs);
 	err = rdev_color_change(rdev, dev, &params);
 
 out:
@@ -17431,7 +17432,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_color_change,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_SET_FILS_AAD,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index cbbf347c6b2e..db4d9f567ad0 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2842,6 +2842,7 @@ TRACE_EVENT(rdev_color_change,
 		__field(u8, count)
 		__field(u16, bcn_ofs)
 		__field(u16, pres_ofs)
+		__field(u8, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -2849,11 +2850,12 @@ TRACE_EVENT(rdev_color_change,
 		__entry->count = params->count;
 		__entry->bcn_ofs = params->counter_offset_beacon;
 		__entry->pres_ofs = params->counter_offset_presp;
+		__entry->link_id = params->link_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT
-		  ", count: %u",
+		  ", count: %u, link_id: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG,
-		  __entry->count)
+		  __entry->count, __entry->link_id)
 );
 
 TRACE_EVENT(rdev_set_radar_background,
-- 
2.25.1


