Return-Path: <linux-wireless+bounces-12771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3942974425
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 22:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B06D28818A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0DB1A7074;
	Tue, 10 Sep 2024 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O5TT0uFA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B8197A6B;
	Tue, 10 Sep 2024 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000816; cv=none; b=tf10kQKoX4ZPHuKvhQX34CGD/Vg+fyQZKP86HFS3bL3aV7n/nazrdB1XEctMpJbQBSzoqO5kXqjGm+wkaikXzMgjLamL0iMBG+6LCQUJpzr335jNSoJcKT5MJbOTsI8wmvqczGs2+kEscR9FPplIlIlRkTXa6Fp5TI3yn5qja/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000816; c=relaxed/simple;
	bh=zen7WDNeO31dhz4+IfbTkr5Qw+vuV26ucn//PvOQFAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aajvbEoVrtvJX5fhSInzmSReZ52lLt/iobsK5lCrj/yNQ4jKeKCZQp9S8fEisa1FHcg+N7mwYt++Fa2jEEQqRNOUrAmHJtZQ31Gk2E5cfNnxq0EGXSAyn7r3RBUA9QRkHU4Jn4lE7VoYO57OhxDNSPDQAMh7LA3/DQ1hDAUSq6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O5TT0uFA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AF3Ngk023787;
	Tue, 10 Sep 2024 20:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=V6DJ9sOOSOXMHDWh431m9C
	ToIoOW32pG61L9XfIH8uo=; b=O5TT0uFAUd8dw11S7GoB27AeEviYVeBamyy4hp
	3jwcRNG3D7EIgugAx/ogBIvh87vbySazebIQC0mFd61+MPRh7Q3QQO9m1f5D3SMv
	nGhep1tATOILB0XLcjLnXutJrM/plnTMdzIPgbX/0QYbtox98rkM8TaLNIIKDMQw
	kawGMiBP+CbCFPhhtgQlWLIf0rWvN6TnFR+VRAKFVFO6Hk+jFZTVWPt5MX+pTsJJ
	QbgLqi9O6Eg7DLpUKyntSgIZFA2cq8BReJzXwUcQ6iVQtol+vlYuCszbE4PrUcoC
	bFTJsgOxFsbjPhdB/v9Y+wwCoxz5k2GhGHWup3cLLZOQHhSg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6p79mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 20:40:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48AKe49s011038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 20:40:04 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Sep
 2024 13:40:03 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 10 Sep 2024 13:40:03 -0700
Subject: [PATCH] wifi: mac80211: constify
 ieee80211_ie_build_{he,eht}_oper() chandef
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240910-wireless-utils-constify-v1-1-e59947bcb3c3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKKu4GYC/4WOQQ6CMBBFr2K6dkyLNFpX3sOwoGWQSaBopyCEc
 HcLC7cu3+K9/xfBGAhZ3A6LCDgSU+8TqONBuKb0TwSqEotMZrk0SsKHArbIDEOklsH1niPVMyg
 0lbZSn1HXItmvgDVNe/lRJLYlI9hQetdsvV/G4xShK8lvUkMc+zDvb0a1qf+HRwUKrMlMpvVFy
 /x6fw/kyLuT6ztRrOv6BQfZwx7lAAAA
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O9tBipnOqVpIAtBmE6ZGkrF1ma29V1EK
X-Proofpoint-GUID: O9tBipnOqVpIAtBmE6ZGkrF1ma29V1EK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=989 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100153

The chandef parameter passed to ieee80211_ie_build_he_oper() and
ieee80211_ie_build_eht_oper is read-only. Since it is never modified,
add the const qualifier to this parameter. This makes these consistent
with ieee80211_ie_build_ht_oper() and ieee80211_ie_build_vht_oper().

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 net/mac80211/ieee80211_i.h | 4 ++--
 net/mac80211/util.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4f0390918b60..3f4d2773b828 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2545,8 +2545,8 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 				const struct cfg80211_chan_def *chandef);
 u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata);
-u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef);
-u8 *ieee80211_ie_build_eht_oper(u8 *pos, struct cfg80211_chan_def *chandef,
+u8 *ieee80211_ie_build_he_oper(u8 *pos, const struct cfg80211_chan_def *chandef);
+u8 *ieee80211_ie_build_eht_oper(u8 *pos, const struct cfg80211_chan_def *chandef,
 				const struct ieee80211_sta_eht_cap *eht_cap);
 int ieee80211_parse_bitrates(enum nl80211_chan_width width,
 			     const struct ieee80211_supported_band *sband,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f94faa86ba8a..f0db60878321 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2752,7 +2752,7 @@ u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 	return pos + sizeof(struct ieee80211_vht_operation);
 }
 
-u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef)
+u8 *ieee80211_ie_build_he_oper(u8 *pos, const struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_he_operation *he_oper;
 	struct ieee80211_he_6ghz_oper *he_6ghz_op;
@@ -2844,7 +2844,7 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef)
 	return pos;
 }
 
-u8 *ieee80211_ie_build_eht_oper(u8 *pos, struct cfg80211_chan_def *chandef,
+u8 *ieee80211_ie_build_eht_oper(u8 *pos, const struct cfg80211_chan_def *chandef,
 				const struct ieee80211_sta_eht_cap *eht_cap)
 
 {

---
base-commit: fe57beb026ef5f9614adfa23ee6f3c21faede2cf
change-id: 20240910-wireless-utils-constify-1e9d5b053e5f


