Return-Path: <linux-wireless+bounces-23740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72EACECD5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEFE174513
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76120D4F2;
	Thu,  5 Jun 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MTHAaSKB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A72114
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115881; cv=none; b=swZ156ZsI3QkUPFNjJVbgPt11BfUgH+N+ZEB62imqNYQGoBihdksAV/DA36wiU2oAGMvHo6+QHiNGF6aQUXwddUes/7GEwAe6UAQb/nzhujb284Mc/+KTyvk/ZEs6kyPfy/qtOz5g8fxugppFtWDysjJDpbsJ8qtFQJndAEom1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115881; c=relaxed/simple;
	bh=oRfswYUSmxg1YPqvXIvJbitbMlCunuXSr2aHgVExmJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRhw5gA2rFQngvpSoW6xKuynmoJz5+sB+W+enngJ9Cw1uiqomjoJSHWoyz2/qiPx6jx2kMI9Z0Ccvq68KNSmayfMIKA73CruzjmAgd5/wf0XAm2xJ7SnyR2N2TWXaUAkxFXfgvfLwi77kYmWGrE9aGeVvnNX5Z10DCP3x5baOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MTHAaSKB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5558BsJc032282;
	Thu, 5 Jun 2025 09:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJkc3YA9aoF3QlDZDSRtJwDII7F9zI+Lu6GCUIj1sSM=; b=MTHAaSKB4BAy9u6n
	PlAqZksnkfVG65Cju7LQ8/g7nBaRHOes/jBiIDkg8tJ+89iLKOBqB57joI+u0biA
	ISeNK0pm4oJ2uzW24GCmD9bIuqVPPTu4ePTqQi4qPgR5YwKaHqPYp9nDyeVmdoqH
	vWhgaeCVQnPC+WAYJ4gwdiOO56kwCPse6nX5d7EbZLOWnVR5XBV3lShEU/Pd8RTk
	AvqJgBoFnBo3SthtCpZYpTE7a4SYrLBoSPtNXshW3OKYWbhPQM+cGKVkhZ/fum4p
	8eEXx5LenEGhHp/+FvSiRNIdeCPwCqV56es2vhvYB14POLF/Zf7R3IDcV4ZGyDZy
	OOw4jg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471sfuyp5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 09:31:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5559VD7U017933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 09:31:13 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Jun 2025 02:31:12 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v13 2/4] wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
Date: Thu, 5 Jun 2025 15:00:50 +0530
Message-ID: <20250605093052.3351173-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605093052.3351173-1-quic_rdevanat@quicinc.com>
References: <20250605093052.3351173-1-quic_rdevanat@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=CY8I5Krl c=1 sm=1 tr=0 ts=684163e2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=dT9kF_FcwchNhhVsS6MA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: o5pLdLKeVaF8Llb3NSxvBwdojIIKVXsS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA4MyBTYWx0ZWRfX/+WfzBXPRocb
 NxoIYVnXuljP6Jxlzmi0K7vf87d78siuflIilSZvpiSUVFU0A53vrmXy4xerTSwwoRERB2UfNwY
 BWBb1U1CTYtBdzicIDAx7XJN+d+9CHfQPR8TieL0KE7oXrfgpmNCmdVD3R959ZA39ZmifcFzBVn
 d1FDFCHxJUJWi5YX9RT//TpfelWF7ozUKyx7FbfGm7EHxKYIGGkqRM7GN0rxDS0zda2ilMSHTHq
 b8HE6apEgOS6/GOzV2XSIfav3cfX3XAhpSVADlhLakbq85QlXqBNTXmw4iLeUW83j6ZKZH6Fqw3
 N5YjG0fBnM972yF1wbp9/UgxbvO1kJwkSY8QOGsjH9tGBRP56WKi5HJHYT4WIkUsJA+1sAd2yLD
 ShWElaPVD4wKMZk54zlKqG74vEncdkxavyUMPxpXBlStPNs46rjLnkXO+VBEUSDa8ZAKUvG5
X-Proofpoint-GUID: o5pLdLKeVaF8Llb3NSxvBwdojIIKVXsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050083

Currently, setting RTS threshold is based on per-phy basis, i.e., all the
radios present in a wiphy will take RTS threshold value to be the one sent
from userspace. But each radio in a multi-radio wiphy can have different
RTS threshold requirements.

To extend support to set RTS threshold for each radio, get the radio for
which RTS threshold needs to be changed from the user. Use the attribute
in NL - NL80211_ATTR_WIPHY_RADIO_INDEX, to identify the radio of interest.
Create a new structure - wiphy_radio_cfg and add rts_threshold in it as a
u32 value to store RTS threshold of each radio in a wiphy and allocate
memory for it during wiphy register based on the wiphy.n_radio updated by
drivers. Pass radio id received from the user to mac80211 drivers along
with its corresponding RTS threshold.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 include/net/cfg80211.h | 18 +++++++++++++
 net/wireless/core.c    | 19 +++++++++++++
 net/wireless/nl80211.c | 60 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c14e4c2210b3..bcb2d36dcc44 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5446,6 +5446,18 @@ struct wiphy_iftype_akm_suites {
 	int n_akm_suites;
 };
 
+/**
+ * struct wiphy_radio_cfg - physical radio config of a wiphy
+ * This structure describes the configurations of a physical radio in a
+ * wiphy. It is used to denote per-radio attributes belonging to a wiphy.
+ *
+ * @rts_threshold: RTS threshold (dot11RTSThreshold);
+ *	-1 (default) = RTS/CTS disabled
+ */
+struct wiphy_radio_cfg {
+	u32 rts_threshold;
+};
+
 /**
  * struct wiphy_radio_freq_range - wiphy frequency range
  * @start_freq:  start range edge frequency (kHz)
@@ -5701,6 +5713,10 @@ struct wiphy_radio {
  *	supports enabling HW timestamping for all peers (i.e. no need to
  *	specify a mac address).
  *
+ * @radio_cfg: configuration of radios belonging to a muli-radio wiphy. This
+ *	struct contains a list of all radio specific attributes and should be
+ *	used only for multi-radio wiphy.
+ *
  * @radio: radios belonging to this wiphy
  * @n_radio: number of radios
  */
@@ -5790,6 +5806,8 @@ struct wiphy {
 	void (*reg_notifier)(struct wiphy *wiphy,
 			     struct regulatory_request *request);
 
+	struct wiphy_radio_cfg *radio_cfg;
+
 	/* fields below are read-only, assigned by cfg80211 */
 
 	const struct ieee80211_regdomain __rcu *regd;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index dcce326fdb8c..32306593d449 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -995,6 +995,24 @@ int wiphy_register(struct wiphy *wiphy)
 		 wiphy->max_num_akm_suites > CFG80211_MAX_NUM_AKM_SUITES)
 		return -EINVAL;
 
+	/* Allocate radio configuration space for multi-radio wiphy */
+	if (wiphy->n_radio > 0) {
+		int idx;
+
+		wiphy->radio_cfg = kcalloc(wiphy->n_radio,
+					   sizeof(*wiphy->radio_cfg),
+					   GFP_KERNEL);
+		if (!wiphy->radio_cfg)
+			return -ENOMEM;
+		/*
+		 * Initialize wiphy radio parameters to IEEE 802.11
+		 * MIB default values. RTS threshold is disabled by
+		 * default with the special -1 value.
+		 */
+		for (idx = 0; idx < wiphy->n_radio; idx++)
+			wiphy->radio_cfg[idx].rts_threshold = (u32)-1;
+	}
+
 	/* check and set up bitrates */
 	ieee80211_set_bitrate_flags(wiphy);
 
@@ -1223,6 +1241,7 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 void wiphy_free(struct wiphy *wiphy)
 {
 	put_device(&wiphy->dev);
+	kfree(wiphy->radio_cfg);
 }
 EXPORT_SYMBOL(wiphy_free);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c1bc3662da8d..23f4bfd404e9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3609,6 +3609,33 @@ static int nl80211_set_channel(struct sk_buff *skb, struct genl_info *info)
 	return __nl80211_set_channel(rdev, netdev, info, link_id);
 }
 
+static int nl80211_set_wiphy_radio(struct genl_info *info,
+				   struct cfg80211_registered_device *rdev,
+				   int radio_idx)
+{
+	u32 rts_threshold = 0, old_rts, changed = 0;
+	int result;
+
+	if (!rdev->ops->set_wiphy_params)
+		return -EOPNOTSUPP;
+
+	if (info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]) {
+		rts_threshold = nla_get_u32(
+				info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]);
+		changed |= WIPHY_PARAM_RTS_THRESHOLD;
+	}
+
+	old_rts = rdev->wiphy.radio_cfg[radio_idx].rts_threshold;
+
+	rdev->wiphy.radio_cfg[radio_idx].rts_threshold = rts_threshold;
+
+	result = rdev_set_wiphy_params(rdev, radio_idx, changed);
+	if (result)
+		rdev->wiphy.radio_cfg[radio_idx].rts_threshold = old_rts;
+
+	return 0;
+}
+
 static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = NULL;
@@ -3681,6 +3708,8 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 				info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]);
 		if (radio_idx >= rdev->wiphy.n_radio)
 			return -EINVAL;
+
+		return nl80211_set_wiphy_radio(info, rdev, radio_idx);
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
@@ -3893,16 +3922,30 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (changed) {
 		u8 old_retry_short, old_retry_long;
 		u32 old_frag_threshold, old_rts_threshold;
-		u8 old_coverage_class;
+		u8 old_coverage_class, i;
 		u32 old_txq_limit, old_txq_memory_limit, old_txq_quantum;
+		u32 *old_radio_rts_threshold = NULL;
 
 		if (!rdev->ops->set_wiphy_params)
 			return -EOPNOTSUPP;
 
+		if (rdev->wiphy.n_radio) {
+			old_radio_rts_threshold = kcalloc(rdev->wiphy.n_radio,
+							  sizeof(u32),
+							  GFP_KERNEL);
+			if (!old_radio_rts_threshold)
+				return -ENOMEM;
+		}
+
 		old_retry_short = rdev->wiphy.retry_short;
 		old_retry_long = rdev->wiphy.retry_long;
 		old_frag_threshold = rdev->wiphy.frag_threshold;
 		old_rts_threshold = rdev->wiphy.rts_threshold;
+		if (old_radio_rts_threshold) {
+			for (i = 0 ; i < rdev->wiphy.n_radio; i++)
+				old_radio_rts_threshold[i] =
+					rdev->wiphy.radio_cfg[i].rts_threshold;
+		}
 		old_coverage_class = rdev->wiphy.coverage_class;
 		old_txq_limit = rdev->wiphy.txq_limit;
 		old_txq_memory_limit = rdev->wiphy.txq_memory_limit;
@@ -3914,8 +3957,13 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			rdev->wiphy.retry_long = retry_long;
 		if (changed & WIPHY_PARAM_FRAG_THRESHOLD)
 			rdev->wiphy.frag_threshold = frag_threshold;
-		if (changed & WIPHY_PARAM_RTS_THRESHOLD)
+		if ((changed & WIPHY_PARAM_RTS_THRESHOLD) &&
+		    old_radio_rts_threshold) {
 			rdev->wiphy.rts_threshold = rts_threshold;
+			for (i = 0 ; i < rdev->wiphy.n_radio; i++)
+				rdev->wiphy.radio_cfg[i].rts_threshold =
+					rdev->wiphy.rts_threshold;
+		}
 		if (changed & WIPHY_PARAM_COVERAGE_CLASS)
 			rdev->wiphy.coverage_class = coverage_class;
 		if (changed & WIPHY_PARAM_TXQ_LIMIT)
@@ -3931,12 +3979,20 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			rdev->wiphy.retry_long = old_retry_long;
 			rdev->wiphy.frag_threshold = old_frag_threshold;
 			rdev->wiphy.rts_threshold = old_rts_threshold;
+			if (old_radio_rts_threshold) {
+				for (i = 0 ; i < rdev->wiphy.n_radio; i++)
+					rdev->wiphy.radio_cfg[i].rts_threshold =
+						old_radio_rts_threshold[i];
+			}
 			rdev->wiphy.coverage_class = old_coverage_class;
 			rdev->wiphy.txq_limit = old_txq_limit;
 			rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
 			rdev->wiphy.txq_quantum = old_txq_quantum;
 			return result;
 		}
+
+		kfree(old_radio_rts_threshold);
+		return result;
 	}
 
 	return 0;
-- 
2.25.1


