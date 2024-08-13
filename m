Return-Path: <linux-wireless+bounces-11332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F0094FD7D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 07:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F96AB22E91
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 05:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744DA2E3EE;
	Tue, 13 Aug 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QJJtn6Fj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56A2D611
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723528788; cv=none; b=ZyGUXZLphhNkYYxMKxmkL20ASIgZa1Xb8WJhV3Xh10c+27J6beXGDfcFjdT6UMrzWiBVSstpzmfWJ7SCsO5IJooeto/xm/yMicom84cxz52iCqwPlAYjGXpMNEaMRcETle6PwJmSjJ/JabQ8YiscHRyRSGnmyDmtlilyM2snD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723528788; c=relaxed/simple;
	bh=0Pj9E0pZhdBb15PijwUttqpFabvQQcpqoEhFI0rrkv4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TuFUWuhMACKCgynH+3+KNxERwQi8GTil5ppWvr1Q4wtUiIfKxMQwWtS1P+Ut6p5L5zwGnzFW/3uMz0W4giR5+rXLJW6Kd7v5zEs06SGF4JK/VQWePn/QxdhqNKRzMT+Zy2J3GhslII51zM35yYWJGWbDA3fg/WMS5uyNcwypjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QJJtn6Fj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CMVFrK012643;
	Tue, 13 Aug 2024 05:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=50Wh1MbICSA4vsfJ/L+YoH
	Z3YqNGhafUHiyhtTD779k=; b=QJJtn6Fjf77WvbupQx9uuM3L2PsLacd/YBTfNC
	59jN08CMwQ5kzLb9rO1BGBB4gRxQI3iIhorezmOxLClDvCV998QmtKLTD4RmOH4u
	k6dRNrD7cTXJyZhYgFP7QoSp+EgM4/3FYQwY3GUmyCDrZ/TSuFwrDdFHIjLa3hk0
	qu3Wyg+aw5nkgG0a9xdewFboUW21j8Yi4bNGELGG7GLpGp4PDNL0rVmN70idaVBb
	qhAbnV176uZLC8jHaLDJ88/SovMi0ydFccagIA1zkTDYUdp1gONjTMYS1v5v2FCm
	XIxPVmokNEvDthj+p8wxPV+pLFMyzhOdd5LSlVQG57o95lLA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x167xcpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 05:59:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47D5xZMr021838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 05:59:35 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 12 Aug 2024 22:59:34 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2] wifi: cfg80211: check radio iface combination for multi radio per wiphy
Date: Tue, 13 Aug 2024 11:29:17 +0530
Message-ID: <20240813055917.2320582-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: s8_PhDXq6rWxajp30U40WFg20bCmsiM3
X-Proofpoint-ORIG-GUID: s8_PhDXq6rWxajp30U40WFg20bCmsiM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130041

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
 v2:
  - Rebased to ToT

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

base-commit: cc32e9fb380d8afdbf3486d7063d5520bfb0f071
-- 
2.34.1


