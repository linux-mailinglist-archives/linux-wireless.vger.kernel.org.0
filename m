Return-Path: <linux-wireless+bounces-5439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9C388F8BC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D339A1F2776F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE5B537FC;
	Thu, 28 Mar 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ek0iPnvm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FF2561F
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611019; cv=none; b=LyQSHpMn5PBvgMMB3OS+9SErDa1+iagE2nYIHR2LPlCftaLqP3lfwH9GJ6dY2kLeDU7Sfpxk0ywwLMXrFRsplCyH9UtBvr1WGRIIOcwi0OoConmIUfyul20CQ/hTxByyhJxH13va4mAwgiKCQktW2M4A5gLU8GIcg5hNT5Ac9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611019; c=relaxed/simple;
	bh=f6MNTOWwzwf6ydIW6HtiwQ76qAdLfrunihPWPOaZACo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgOkcawmooGQexyu2/RDwr+pIXtIWCecVabMOWOZ0IJZyP7t4IpCcHdLJwRFoc5F8QSbsgl3oOQ6RzEbJKI7HYxPp4ljQGtGfLnIzM16bHvx577K0V525jUC8GaV5gA/yrBiYNsWB7mrBUQDxjOM5hlA0yRxFlVyiHmdzhQ2mRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ek0iPnvm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S5S5OV016571;
	Thu, 28 Mar 2024 07:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=7xp+XbKb73LQNxCMLPSORGHvndiMuoHtAUrCCwDw+eU=; b=ek
	0iPnvm8spNXXxE6Dfu5ymEiwHdNw8wmSDxOrCF/z96nBKX4OHkkJplkiJYuSc+/t
	6d3/NjagXEmLNi36e674LL9Ifo6gF65psqNV8wsBHdrKCMseKH6UyUgFsYkdV+Kt
	H0LvQWA0orkKvvErS3HBo0JYSJ1br2Rb44dioyLQNNAZFQgw37vxYzrJGxPkBEHU
	ykzvPRBxqAkTKK98PjL5DHVooB6jLw3QoJaCCs1URgSoWzqdi4OUjtPjdW6stPPE
	Z7wtGvQDoA1s8VYu/CpF+65yJMEsNrLezvJLmP8InoPuJkIee6pvN1FTFJz555IQ
	w0Crvj3UBNQ0ziDynK8A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wtbn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7U75r000502
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:07 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:30:05 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 10/13] wifi: mac80211: expose channel context helper function
Date: Thu, 28 Mar 2024 12:59:13 +0530
Message-ID: <20240328072916.1164195-11-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: xMKdNmPFr_uNVzBGA_dI9aiknVAtmJmp
X-Proofpoint-ORIG-GUID: xMKdNmPFr_uNVzBGA_dI9aiknVAtmJmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=994
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280048

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

Currently, link specific channel context helper function scope is static.
For multi hardware iface combination support, mac80211 need this helper
function, so expose it internally.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 net/mac80211/chan.c        | 2 +-
 net/mac80211/ieee80211_i.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 5a7fb0e4f89d..08a362892d9a 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -67,7 +67,7 @@ static bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local)
 	return ieee80211_num_chanctx(local) < ieee80211_max_num_channels(local);
 }
 
-static struct ieee80211_chanctx *
+struct ieee80211_chanctx *
 ieee80211_link_get_chanctx(struct ieee80211_link_data *link)
 {
 	struct ieee80211_local *local __maybe_unused = link->sdata->local;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index def611e4e55f..202bbffec746 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2577,6 +2577,8 @@ void ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
 					  bool clear);
 int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 			       struct ieee80211_chanctx *ctx);
+struct ieee80211_chanctx *
+ieee80211_link_get_chanctx(struct ieee80211_link_data *link);
 
 void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *chanctx);
-- 
2.34.1


