Return-Path: <linux-wireless+bounces-17934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9DA1C443
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 17:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A207C3A87C5
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BB02AF00;
	Sat, 25 Jan 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d0DfPC8r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9FA70823
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737821613; cv=none; b=DKK91uGbRURcBN/c4PQNB1i3morqrW1aUlXHnJuxD8SsPZGaxT97BKNcXEgbvbGDW1PVshXMiRPiw4LqNSMPSBu5NFBx0j6kV7ibEOt4xH9qho6r8w1AiBVqX7QK5GZTDZ4xz3AbxZW58CvPrCiALDJt+Ye70TPjE1AOfqaKK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737821613; c=relaxed/simple;
	bh=br3bAxU8SHf1IQdyBMDfzT4ivl2BdCTkUMHAarYVLMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6eizG5DvwXEL/l3LhZ7JvJOxPOyUO6Il3gipYbSoEbBE2l2qqgPNMVtHQJ1ln6FCc9JD0YkSnlOz5ELCkOS+ZqTRdV3/AtIKjoTza0HBEnzjtusJ24lJGmA81oYWt627x1c8CGUDsvN5bvKuL6223iGEnkR8h3fXCDUqF3+27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d0DfPC8r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50PDUOSW021983;
	Sat, 25 Jan 2025 16:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9/FolBaqxax0dO5vPvpK29kXI5rywEFdHAaxt1IhD9k=; b=d0DfPC8ri5v4K+/x
	aarRdMkXbweiQy4lAFPhytw9S7izq7vwtg722PTztVy0fdSiS8j7LfCCYB+9C1kz
	qwKQ4z8LDZgSkBxLpOKtgDNNyKZ9lNV5f2Dpfhzp4mFBaElRlroMJRfg8DoJBrE4
	XRbMaZ8t3R3a1HNSxXJhJpAeb2N8EyUmTQ3CPMpJ1VUelbIcWZJll8g4ncUHM4yR
	e7UIkfEwzEWuoaxbR+0lHxqH4NypB/JWcZEtCmRuknhkGF9pcTWA7WWr/RUwZY22
	TLv5Ac16D97VknRfOpuqBk3fk0O7tPrOSRT+VFrgwJ1W076eliDzVGcObMqVZVZC
	qzgsSg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs2hgpv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 16:13:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50PGDM3x014580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 16:13:22 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 25 Jan 2025 08:13:20 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH v3 5/5] wifi: mac80211: set tx power per radio in a wiphy
Date: Sat, 25 Jan 2025 21:42:48 +0530
Message-ID: <20250125161248.1042318-6-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250125161248.1042318-1-quic_rdevanat@quicinc.com>
References: <20250125161248.1042318-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PP2nIBlwR-RQrz7KF9fxDcrWa5cDnSt_
X-Proofpoint-GUID: PP2nIBlwR-RQrz7KF9fxDcrWa5cDnSt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501250118

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


