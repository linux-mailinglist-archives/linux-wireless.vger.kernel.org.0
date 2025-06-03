Return-Path: <linux-wireless+bounces-23571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3CDACCC32
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 19:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28FC16FF55
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B0F1A4F12;
	Tue,  3 Jun 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pwyAjEUA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27761D54C2
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971796; cv=none; b=LcHgCkmFluxBExjTam3JG2e1R/thEBpop5SgPhQ8gLIh1IiWytyNG2IrLNXhiD9AghhT0HDijkXxtPk7PLS1Kd6ScO+t1RL62esiO6Bj84bjNF8uQPgcssG9KNRfIhUNisxV9wyw6/w/zUjmqiVHxoXey2Iik21rC6QUKZjnQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971796; c=relaxed/simple;
	bh=jfsX5cDSITkQPnAOa177SFRdOAGUk9VfkzNIdGwXSi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQGkXJK9cy8RimMEaBsEoIRreYn0a1r6eJcTzTnfiVv3lSVxv6HB8g3u8P25gE7G6EWDUUg31clX4FDtxvpvZI6L61m+x8HxIHf/l5gTDlcmsfc7+a4d4J+JwHH7SmXq+0RgOTOuUjyjWp1PekIsF1EgUTdwSlKHsHQ5IeGjej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pwyAjEUA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539JEVK004229;
	Tue, 3 Jun 2025 17:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j5Pzpw4G/lY7vriBCrQRHMycSn0fPeY6j6f/O0qE42M=; b=pwyAjEUAqt9bxYHW
	CmYITcEwbH4q/s6fXqjJz3nNQjmiRMGJiqxrS8gWcCSW0TxC8CKKDFb8npvhdYbo
	rU2958IE8ucVRMtQimZmNGJPBi5WcSrn6FjXVsy4iRSHZpEdF+QorxxI4vLtZMBg
	5UiUiSkV9Z6B6G/PpuULL2HsCbkjVaihaqeVBG67+L/e/AzuGmN999C9LGknsyFG
	iIGHgZOOX7KIforCY1q//bquvbDRlicO/sQn9S7eYlbpxy5odkfUwYGwbnm+68OS
	mYXDtqhAnJPeNlWs4TVmvctocld9287H3AVYzaj2gPX/6otExT8d6g2/IcvUzE7D
	1IYRGQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8rud3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 17:29:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 553HTn8V022982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Jun 2025 17:29:49 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Jun 2025 10:29:48 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v12 2/4] wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
Date: Tue, 3 Jun 2025 22:59:22 +0530
Message-ID: <20250603172924.336883-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172924.336883-1-quic_rdevanat@quicinc.com>
References: <20250603172924.336883-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 36e99SOAQx7IZL-PZ7Sf5DrTWaRYElrD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE1MiBTYWx0ZWRfXwH7M2h5HsX4B
 UPhMqsl1pPhh93U7wWr+XTSFz32oUJGoojS/kPnRO+vbKZYWM4rFmX33ZlME1FgnJ/UrMrBQUQl
 khk3SA9fiyscXGYsTj3xoByTdpsT8l6It2sYfe9XGWs3pm2o+0jRLTPbp/WJiKJ1PE3F3Vh9Ek7
 NwD2Opb+HIhZG7h2CKFGH1GDowDa1aGvmbSnZCUxVzwKMBIsgv/2ajVeWhjnoF8bWMY10jXo/2q
 leemIre6tkFXDnAB7C6adlPj0HmSrYDvxApgyTkmMOmd9e/QNe0YZF/8TrK1ZjT/n4MKR5nrF8k
 p8kGKLb8ooGRThXNwBTdURqO3aUfjfXqge197xf2YXhfWzHebVW+i7oz0VciXYd5j5DTxjJnXLP
 IFy8Zp1BJZRkSPUzRzXG1rjVMYWcRiobMQXNhJ0UEL0Q4P1rOPyZbmCzUynVBA2YCLedoEtm
X-Authority-Analysis: v=2.4 cv=RdWQC0tv c=1 sm=1 tr=0 ts=683f310e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=dT9kF_FcwchNhhVsS6MA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 36e99SOAQx7IZL-PZ7Sf5DrTWaRYElrD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030152

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
index 6a0d12f65136..25faf0147f2d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5445,6 +5445,18 @@ struct wiphy_iftype_akm_suites {
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
@@ -5700,6 +5712,10 @@ struct wiphy_radio {
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
@@ -5789,6 +5805,8 @@ struct wiphy {
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


