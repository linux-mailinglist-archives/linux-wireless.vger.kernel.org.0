Return-Path: <linux-wireless+bounces-20712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E5DA6CE4D
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 08:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E642B189363E
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9297A1FFC4F;
	Sun, 23 Mar 2025 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g/NCOUPu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC881F91C8
	for <linux-wireless@vger.kernel.org>; Sun, 23 Mar 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742715663; cv=none; b=Rw+FD+XQ9malaTAmbmJdIHrO/zPhCKHCwYq5cBZisRSddp5vsW5fhqE+0fQ0Ik/TDVWRdXp7XS4k96myHvIs0UzVPMiAlMBSmVWCsgkjIRHfBYhU1Gbvri77jekdBIVvrbQbFrzVVcohQErwSw31VyRsE8bwO4RzCCrQIUvIrk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742715663; c=relaxed/simple;
	bh=7OMQrE49R/iCHg52jNo/LuXlZMkfhQvG67sRQ+CEnpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1m3xf2k/oIfBeRe44gd4n0qCPFZjWUTM7ns2JXkFFr4MsuY8BkcMJ4wS8KvM9KOANZOmt8IaOesbyGh+kG4TNvlguAfsaCSS+Ada3YzZ+SLFpMSkWHNwRDKXDAxTQMf2NbKY18E+aiza5bk1Q6+5/ZakqoPwOEsdTWDlLUmB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g/NCOUPu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N5SXDH020164;
	Sun, 23 Mar 2025 07:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CoY6afbvJ3AmujtKLxQUiyEQQURR8x1Q33qdrNoL7JE=; b=g/NCOUPu3Dlc6MNI
	mO7cQ7NC3zRn6svObUsW3MUA3k4AB5LPuutLd9Gcxq/KeVboz8LvX0AP4RabRAPB
	n0RfnjiUdhEC0vtvj0GWBpQe/Ooq9oUg3ulQG+YBdJh+7BJM/vr/kFCyDPsisHrk
	ukYfq97uLCWz+SZ5yxD2503wEcH85CYZVo6ROKnPGEwHvnXkpp6rCAJSB1+RRgzH
	685dK2zoIF7HkE9Euh0cVrg8NVFlO3nYqDgwgl1uCUZy5E5Y2FB9cZxMVW3Wlaw5
	TOThHLixKquWg8dKS9RrKpwdUODnrF/W/TtmqYPfD2U0G27GVto7ptk1J3BdRifD
	0rGaFQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hne5sq0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 07:40:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52N7eg6A006146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 07:40:43 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Mar 2025 00:40:41 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v5 5/5] wifi: mac80211: set tx power per radio in a wiphy
Date: Sun, 23 Mar 2025 13:09:59 +0530
Message-ID: <20250323073959.2872641-6-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250323073959.2872641-1-quic_rdevanat@quicinc.com>
References: <20250323073959.2872641-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 39sKo2yiyKRNK0BSTmWOuzfOGCvh4FFl
X-Proofpoint-ORIG-GUID: 39sKo2yiyKRNK0BSTmWOuzfOGCvh4FFl
X-Authority-Analysis: v=2.4 cv=JvPxrN4C c=1 sm=1 tr=0 ts=67dfbafb cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EbxTufs1k9vtP76xuBMA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230057

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

radio id value of NL80211_WIPHY_RADIO_ID_DEFAULT(-1) indicates that radio
index is not mentioned and the configuration applies to all radio(s) of
the wiphy.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 net/mac80211/cfg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b6676ebdcddd..9530de1e6681 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3080,6 +3080,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata;
 	enum nl80211_tx_power_setting txp_type = type;
+	struct ieee80211_chanctx_conf *conf;
 	bool update_txp_type = false;
 	bool has_monitor = false;
 	int user_power_level;
@@ -3155,6 +3156,12 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 			if (!link)
 				continue;
 
+			if (radio_id >= 0 && radio_id < wiphy->n_radio) {
+				conf = wiphy_dereference(wiphy, link->conf->chanctx_conf);
+				if (!conf || conf->radio_idx != radio_id)
+					continue;
+			}
+
 			link->user_power_level = local->user_power_level;
 			if (txp_type != link->conf->txpower_type)
 				update_txp_type = true;
@@ -3175,6 +3182,12 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 			if (!link)
 				continue;
 
+			if (radio_id >= 0 && radio_id < wiphy->n_radio) {
+				conf = wiphy_dereference(wiphy, link->conf->chanctx_conf);
+				if (!conf || conf->radio_idx != radio_id)
+					continue;
+			}
+
 			ieee80211_recalc_txpower(link, update_txp_type);
 		}
 	}
-- 
2.25.1


