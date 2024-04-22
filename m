Return-Path: <linux-wireless+bounces-6629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE738AC3BC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 07:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9EC1F2280B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DBE10A19;
	Mon, 22 Apr 2024 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y7GamofV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931313FF6
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764083; cv=none; b=mtYcsBTCSWelQ1opDihciV3ZLkw0S72VZTcMMJc/0lNyHp07AghC584x/CKeUrbgld5EL/WNpVzCu7jLeaz+CXAg7DTJ2nP+Z3VT285nMcIAw0POq0RGGXOnGmkKqUfTT+fZ/TqKBq8966fDKd/J95iJr9sQtHERfV2ccvYf1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764083; c=relaxed/simple;
	bh=yzeqepyXWU/vEjX9M179f6nIQbbV0MLYa8Bcn5e9wPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvdIORQFmbXVYJMuH3kl+M5tv4ubVn/rA/ZZwCMJgHI2WzgM4QsOys7OJEWA0fZRbVDbPqhOaJthfHyQHF8FIeklk7uSGA6BOFgenNLCxrOL/AiWmjgx9Lr8L97NP2ENbB8u+ZBz6HVQvrtX6zQ2xTxFLpmN+3kNWvkoXPq4HrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y7GamofV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M3RIbj012370;
	Mon, 22 Apr 2024 05:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cHSQQHm2NIIlYdEmhO9I2NYFHJpIEnEZV376uD5wwmI=; b=Y7
	GamofVFXKjAnZXKSTlPIIXEkTQfr3jYhu2iPb2w+YsmTDPTzqyryW+td318Iv5dd
	NH4ShfVI8a359FbZZwXnFwP/aIj7LVU8V/PxPX7dlhvSdM260WOeyN+hZXV9GRyw
	7yOocErJN2tPw7h3PjapBp1mvvb2A/2mqCC5nNgncKQyxcoF2nDvNq5ESwY1hZXW
	P5dTRK4eynkp1fRSlEY0AeMRbX0sErh4E8eCTKy1d4O0wtjDkRSggh4a+VHguzv1
	vlelGZ6cjG2Gmr0IyXxkb+F3103T/O9uTsB1s8+MnNDpBBsDQbQNl2tY2zCtUIC9
	0fn/sszJ0xMYypQAEZHQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm5a73b1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M5YbD3015992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:37 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Apr 2024 22:34:35 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 3/7] wifi: mac80211: handle set color_change/after_color_change beacon on per link basis
Date: Mon, 22 Apr 2024 11:04:08 +0530
Message-ID: <20240422053412.2024075-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422053412.2024075-1-quic_adisi@quicinc.com>
References: <20240422053412.2024075-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: dt0kGCr03jeUleeGQliA0KFf523hBLOn
X-Proofpoint-ORIG-GUID: dt0kGCr03jeUleeGQliA0KFf523hBLOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_02,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220024

In order to support color change with MLO, there is a need to handle the
functions ieee80211_set_color_change_beacon() and
ieee80211_set_after_color_change_beacon() on a per link basis.

Implement this by making the function argument accept the link data
instead of the sdata.

Currently, deflink would only be passed. Proper link data will be passed in
a subsequent change.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6eee239d5909..3ae7c409ac77 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4666,20 +4666,22 @@ static int ieee80211_set_sar_specs(struct wiphy *wiphy,
 }
 
 static int
-ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
+ieee80211_set_after_color_change_beacon(struct ieee80211_link_data *link,
 					u64 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP: {
 		int ret;
 
-		if (!sdata->deflink.u.ap.next_beacon)
+		if (!link->u.ap.next_beacon)
 			return -EINVAL;
 
-		ret = ieee80211_assign_beacon(sdata, &sdata->deflink,
-					      sdata->deflink.u.ap.next_beacon,
+		ret = ieee80211_assign_beacon(sdata, link,
+					      link->u.ap.next_beacon,
 					      NULL, NULL, changed);
-		ieee80211_free_next_beacon(&sdata->deflink);
+		ieee80211_free_next_beacon(link);
 
 		if (ret < 0)
 			return ret;
@@ -4695,18 +4697,19 @@ ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 }
 
 static int
-ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
+ieee80211_set_color_change_beacon(struct ieee80211_link_data *link,
 				  struct cfg80211_color_change_settings *params,
 				  u64 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_color_change_settings color_change = {};
 	int err;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		sdata->deflink.u.ap.next_beacon =
+		link->u.ap.next_beacon =
 			cfg80211_beacon_dup(&params->beacon_next);
-		if (!sdata->deflink.u.ap.next_beacon)
+		if (!link->u.ap.next_beacon)
 			return -ENOMEM;
 
 		if (params->count <= 1)
@@ -4718,11 +4721,11 @@ ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 			params->counter_offset_presp;
 		color_change.count = params->count;
 
-		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
+		err = ieee80211_assign_beacon(sdata, link,
 					      &params->beacon_color_change,
 					      NULL, &color_change, changed);
 		if (err < 0) {
-			ieee80211_free_next_beacon(&sdata->deflink);
+			ieee80211_free_next_beacon(link);
 			return err;
 		}
 		break;
@@ -4770,7 +4773,7 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 
 	sdata->vif.bss_conf.color_change_active = false;
 
-	err = ieee80211_set_after_color_change_beacon(sdata, &changed);
+	err = ieee80211_set_after_color_change_beacon(&sdata->deflink, &changed);
 	if (err) {
 		cfg80211_color_change_aborted_notify(sdata->dev, 0);
 		return err;
@@ -4870,7 +4873,7 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
-	err = ieee80211_set_color_change_beacon(sdata, params, &changed);
+	err = ieee80211_set_color_change_beacon(&sdata->deflink, params, &changed);
 	if (err)
 		goto out;
 
-- 
2.34.1


