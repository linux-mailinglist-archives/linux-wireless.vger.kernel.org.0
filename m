Return-Path: <linux-wireless+bounces-5432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D788F8B3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDDA298B42
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB152C6B8;
	Thu, 28 Mar 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f+BRoVmp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC92561F
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611002; cv=none; b=iWAOF1DTB1TTzV1uJpI0GYZkXmzzWQ+LpGev4uKMKsC14hDJDdaNdvHZzhQESpOo4Uugcp/HNJNiVQ2I5AcZExtqNuc5pO3NY0mqp2qJ1R8TzsX+/GD6F1E/F8SNODrjSWjYyEkTNbn4lo/me7m82BM5z0jd3ktciCFeC97M1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611002; c=relaxed/simple;
	bh=JL2/Tm7BaG2V9sgAIKz8NpEvmKNda25iJuwGdwGHJBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUg6sOS8xlZPFbJcc/vwUUPOrzJVvenNluhDMucqSue11J42gdyYkOhr4e8r3irVXmY/Kddl+Ya3l00eGk2hLfva8hmsh4deUg92YRjRauWGwp2Jup3UgkVUB0pavNaVUgu2oOtsrxX3kUZQC1Cs/rZZE1RK7xBfrGtt3+cDbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f+BRoVmp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S6qjxR027529;
	Thu, 28 Mar 2024 07:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=UZbA36QIpM4yifccyxCOLoRUvteQcmHywRf1LnmTIx0=; b=f+
	BRoVmpTgd+A5R35LdjWt0/rKHg+pbDrvJ9phtePA6cNtGNxgYWfONudMAU706Irz
	POAy9jfYVyo1KWyBAAiXfhose7+54yuMCaiMj6yqauS1d69FnDXFkrzVFUO5rIZX
	NibCo8xuhIRJnfEr1HdIT74DsNcx98yf2i14lIKaKESdZJ7ir7os+lQkozTb8TOp
	g3/Hzi8zG2GssFD6mA6tIb2Igf9kMHlmePL0cajqW1hCPStcltJSoK9i1F8yJFI/
	9GHgbM4ruV/l86GhUB68ZpQVFxfbMfmEWUP9LKYYKXQm3uDKlBkmDQuzGHaJmNni
	TvetS9XNp+Hpuwo2doKQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x53nxg4w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7Ttrr003744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:55 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:29:53 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 05/13] wifi: nl80211: Refactor the interface combination limit check
Date: Thu, 28 Mar 2024 12:59:08 +0530
Message-ID: <20240328072916.1164195-6-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: KYxEzmzAXEVj4iWXi9RkaQgAtKeYEvuC
X-Proofpoint-ORIG-GUID: KYxEzmzAXEVj4iWXi9RkaQgAtKeYEvuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280048

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

Move the nl80211 interface combination limit advertisement into a helper
function. This will make the iface combination limit advertisement
functionality more scalable for supporting multiple physical hardware
interface combination.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 net/wireless/nl80211.c | 49 +++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2a5e395e2e0b..37524a61f417 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1622,12 +1622,43 @@ static int nl80211_put_iftypes(struct sk_buff *msg, u32 attr, u16 ifmodes)
 	return -ENOBUFS;
 }
 
+static int
+nl80211_put_iface_limits(struct sk_buff *msg,
+			 const struct ieee80211_iface_limit *limits,
+			 u8 n_limits)
+{
+	int i;
+
+	for (i = 0; i < n_limits; i++) {
+		struct nlattr *nl_limit;
+
+		nl_limit = nla_nest_start_noflag(msg, i + 1);
+		if (!nl_limit)
+			goto nla_put_failure;
+
+		if (nla_put_u32(msg, NL80211_IFACE_LIMIT_MAX,
+				limits[i].max))
+			goto nla_put_failure;
+
+		if (nl80211_put_iftypes(msg, NL80211_IFACE_LIMIT_TYPES,
+					limits[i].types))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, nl_limit);
+	}
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+
 static int nl80211_put_iface_combinations(struct wiphy *wiphy,
 					  struct sk_buff *msg,
 					  bool large)
 {
 	struct nlattr *nl_combis;
-	int i, j;
+	int i;
 
 	nl_combis = nla_nest_start_noflag(msg,
 					  NL80211_ATTR_INTERFACE_COMBINATIONS);
@@ -1649,20 +1680,8 @@ static int nl80211_put_iface_combinations(struct wiphy *wiphy,
 		if (!nl_limits)
 			goto nla_put_failure;
 
-		for (j = 0; j < c->n_limits; j++) {
-			struct nlattr *nl_limit;
-
-			nl_limit = nla_nest_start_noflag(msg, j + 1);
-			if (!nl_limit)
-				goto nla_put_failure;
-			if (nla_put_u32(msg, NL80211_IFACE_LIMIT_MAX,
-					c->limits[j].max))
-				goto nla_put_failure;
-			if (nl80211_put_iftypes(msg, NL80211_IFACE_LIMIT_TYPES,
-						c->limits[j].types))
-				goto nla_put_failure;
-			nla_nest_end(msg, nl_limit);
-		}
+		if (nl80211_put_iface_limits(msg, c->limits, c->n_limits))
+			goto nla_put_failure;
 
 		nla_nest_end(msg, nl_limits);
 
-- 
2.34.1


