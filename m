Return-Path: <linux-wireless+bounces-18155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC94A220EF
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 16:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2D8188447B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5FF1DE2DA;
	Wed, 29 Jan 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZbTD8wjz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26351DE8AB
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166002; cv=none; b=OEiqrSNgo/JdzsINKypH+MSmHM2fBceZyDXR09ss0Ph1p+zPNNYZlMeyW7tWaF/rsp5ZqIpB7YfMltxuuh2STlm8eywUZAi6f8d9Nkn3Oc0skvWmQXVkGbitSzLSEnY/xO0PXb5brg8LOLeoI6Dg7wviCg9iwHSx7jY8nIuJyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166002; c=relaxed/simple;
	bh=bylTh7ZN6KHicditCnh6dw2iXizg4eBwLNRij5APWCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEDVccLJmpelVn8ALN50uwrCPlMidrEU1h5xHvoTwXgX75Sk9J7dkhtOx62QUPaXLgh1gnKaNxSKetb/lOKNQZve/az8jL0nx6c0g9uPgZmhyedS8chegmcBTay2VeWecrW3frTTc1J8U2CCnJbibhVxdzpEy62Ud3Mayjho6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZbTD8wjz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T6SGNR009925;
	Wed, 29 Jan 2025 15:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F6tXmAqcGTt4JyXwts8Vq5IUL84AqtLJdslMmd1tgnI=; b=ZbTD8wjzWVxkmtIY
	/ccjddmN/tkjuiChlUQN/W1xZHU8h3xRsP+jT9P6/TzxzBbTftRENp18aJfubIqX
	w2wrjBtC1m5Ak0khzvZ24tS1CCsCkb71+239SPpyhokwoeUL7n1ll8G2Polu/bB8
	2uGlTv8gcBDxGsMiUiGY2xyD8z2IVmKAXgk9aABKsNSFOr58+ho/q2DDvA3l2xND
	Is7aj25F2mUxS3XUgNANZF8rCe4ZiATNoTGh4lsV1kr49nPcHguF1A+wpWoboLCq
	IU6eL4L/XeCcmziZSj7IYz+pFCO8RgpohF11kF+VZufQY07Gmi33m9W3P2bNwsRf
	VeulQw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ff33s0ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TFrEfm025440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:14 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 07:53:13 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v4 5/5] wifi: mac80211: set tx power per radio in a wiphy
Date: Wed, 29 Jan 2025 21:22:46 +0530
Message-ID: <20250129155246.155587-6-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D5tBhfxj-j-7NEflVEygqDlNtptq0pC-
X-Proofpoint-GUID: D5tBhfxj-j-7NEflVEygqDlNtptq0pC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290128

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

If set tx power is being done without a valid wdev/sdata
then the configuration applies to the radio but currently
it is being done at wiphy level(i.e. to all radios of wiphy)
since radio identifier is not available.

Use the radio_id argument of ieee80211_set_tx_power() to identify
to which radio of the wiphy the configuration should be applied.
If the wiphy is a multi-radio wiphy(wiphy.n_radios > 0), validate the
radio index of link's channel context against the radio id provided
and apply the configuration.

radio id value of NL80211_WIPHY_RADIO_ID_MAX(255) indicates that radio
index is not mentioned and the configuration applies to all radio(s) of
the wiphy.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 net/mac80211/cfg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f86350b3a668..ed769672ea77 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3079,6 +3079,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata;
 	enum nl80211_tx_power_setting txp_type = type;
+	struct ieee80211_chanctx_conf *conf;
 	bool update_txp_type = false;
 	bool has_monitor = false;
 	int user_power_level;
@@ -3154,6 +3155,12 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 			if (!link)
 				continue;
 
+			if (radio_id < wiphy->n_radio) {
+				conf = wiphy_dereference(wiphy, link->conf->chanctx_conf);
+				if (!conf || conf->radio_idx != radio_id)
+					continue;
+			}
+
 			link->user_power_level = local->user_power_level;
 			if (txp_type != link->conf->txpower_type)
 				update_txp_type = true;
@@ -3174,6 +3181,12 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 			if (!link)
 				continue;
 
+			if (radio_id < wiphy->n_radio) {
+				conf = wiphy_dereference(wiphy, link->conf->chanctx_conf);
+				if (!conf || conf->radio_idx != radio_id)
+					continue;
+			}
+
 			ieee80211_recalc_txpower(link, update_txp_type);
 		}
 	}
-- 
2.17.1


