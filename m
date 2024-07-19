Return-Path: <linux-wireless+bounces-10394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBCC937A1F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 17:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1721C21A26
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF32CA6;
	Fri, 19 Jul 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Enq37hVn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF9145B10
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403970; cv=none; b=nBeABnmc5WjFSMvbq1y20mneUjfqAJ52KDyxkhaclRl7QueY9VchuqrqiDWcry4nTl5vACUKG73pVXAr6D6YJusSHDEyHkxhME3HoutvXOJUtnpmQ/qkZmHYJ9p23NpbHfrzUP5ZuEs+L6RwFhgllROTScJUcGRfXX6bPTde8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403970; c=relaxed/simple;
	bh=66FHnfmaE6h89RAAbkrPHqkY7GzalpP6SXQMhaUvtMg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OpJ8inp0vdX3nCqdsWINe2DKkzo9Jdbg85Gj9rldjhEKBIej58T8VZdezuZwv6VfKTNyqvyghXRBt4IsyOfocDt2OyQALvSQMk3DSG7x9XlqzCCLAeBKq8o1tLbZ2YNye1vDo+LEy3wPY5aMLLUjbxxhiPjL5EJDFBtbmXznECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Enq37hVn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBsO0Z009076;
	Fri, 19 Jul 2024 15:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gf9kdtAMEagQj8kUwDpSU+
	NooM2tTz6Aw7ZuH+bGSu0=; b=Enq37hVnmng7CIneRFQx5w2VGWjCv22UI5Nvec
	PcAiNBQOcdDyHyk6mGMNI5SK12tJHKQdVrP38odJtpO8sCDHJBwamhQ3JF1qJWDn
	sohXVCQ3JnPoGoOexnKclHcQrpa79UqNtI8z4WeICiXH2X4LB3YeTmHcxmdmAxrI
	DFLOuty2Gn/0oVSOORf9z0BpvLTcpFszXgKYqC/xKD1Qh18lVNea0W9dmC/X1/mn
	W/y/C0cFR8JzrYFNJ1bVAJaAlx4JyeN9vUp4pqC/3eevRcTaY7J/viTcdVdsG31u
	Es2yjxeMDsvmLgMl/EX6CXv9F/+J80HHcrNJTHW3WsBuwkyQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40fe46hxe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 15:46:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46JFk29F007315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 15:46:02 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Jul 2024 08:46:01 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH] wifi: cfg80211: check radio iface combination for multi radio per wiphy
Date: Fri, 19 Jul 2024 21:15:40 +0530
Message-ID: <20240719154540.2946632-1-quic_periyasa@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0HH3zYsptbQ_GQ_h8JwcnSb3TJtMq_OX
X-Proofpoint-ORIG-GUID: 0HH3zYsptbQ_GQ_h8JwcnSb3TJtMq_OX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407190120

Currently, wiphy_verify_combinations() fails for the multi-radio per wiphy
due to the condition check on global interface combination that DFS only
works on one channel. In a multi-radio scenario, global interface
combination encompasses the capabilities of all radio combinations, so it
supports more than one channel with DFS. For multi-radio per wiphy,
interface combination verification needs to be performed for radio specific
interface combinations. This is necessary as the global interface
combination combines the capabilities of all radio combinations.

Fixes: a01b1e9f9955 ("wifi: mac80211: add support for DFS with multiple radios")
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 net/wireless/core.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4d5d351bd0b5..de33bdde1e29 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -603,16 +603,19 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 }
 EXPORT_SYMBOL(wiphy_new_nm);
 
-static int wiphy_verify_combinations(struct wiphy *wiphy)
+static
+int wiphy_verify_iface_combinations(struct wiphy *wiphy,
+				    const struct ieee80211_iface_combination *iface_comb,
+				    int n_iface_comb)
 {
 	const struct ieee80211_iface_combination *c;
 	int i, j;
 
-	for (i = 0; i < wiphy->n_iface_combinations; i++) {
+	for (i = 0; i < n_iface_comb; i++) {
 		u32 cnt = 0;
 		u16 all_iftypes = 0;
 
-		c = &wiphy->iface_combinations[i];
+		c = &iface_comb[i];
 
 		/*
 		 * Combinations with just one interface aren't real,
@@ -693,6 +696,29 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 	return 0;
 }
 
+static int wiphy_verify_combinations(struct wiphy *wiphy)
+{
+	int i, ret;
+
+	if (wiphy->n_radio) {
+		for (i = 0; i < wiphy->n_radio; i++) {
+			const struct wiphy_radio *radio = &wiphy->radio[i];
+
+			ret = wiphy_verify_iface_combinations(wiphy,
+							      radio->iface_combinations,
+							      radio->n_iface_combinations);
+			if (ret)
+				return ret;
+		}
+	} else {
+		ret = wiphy_verify_iface_combinations(wiphy,
+						      wiphy->iface_combinations,
+						      wiphy->n_iface_combinations);
+	}
+
+	return ret;
+}
+
 int wiphy_register(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);

base-commit: 338a93cf4a18c2036b567e9f613367f7a52f2511
-- 
2.34.1


