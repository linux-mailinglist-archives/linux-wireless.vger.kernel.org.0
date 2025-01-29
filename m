Return-Path: <linux-wireless+bounces-18151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF24A220EB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 16:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118C118845B5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A25224EA;
	Wed, 29 Jan 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DIeyySV8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979A14830F
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165994; cv=none; b=iPO7Bm9TnBhMn7bvNHz/aMtOx9mrjwum55u49+6uUrVZYtyXfPLjrQpxfyTfVu6CZjj+7FK7oCvyKzdQ3B3pYj6qLI/Mda8aL/gUziGd26MXGAuF7JheeiaoGUSq60XgLfQQltd5fdWdPr0/kJu2MjBooipPDQnknqkosMASnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165994; c=relaxed/simple;
	bh=YwJJUJlYW8f+YQEaj1fSch4rUjTM0fMhX8zW6vL70BI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1m0m97J3Zg/MbcmaIZbkzQS91wbJ2UNoKszIukHzLv9891ib77Y37VrjJwk3kLn2cJJhUTFkmHw1ASX5+UO9cIHtRrLS8Nbv9XDDJQ2+CCv9aPVYWwPMgNs83E0+OuymT6U17AofOSXK9fc81wMpf8kFa8kGIjhFxVhatvnhlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DIeyySV8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEqpOH004774;
	Wed, 29 Jan 2025 15:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bUKwZ+wdjU8sEMBYhqDoXSDu+R5aMS6dnBzTseHYVeI=; b=DIeyySV8GgZ88s4r
	Xg/AfdMQAiOSB01E1/L1O/R2Kd9XgH019PRSYr8Ujc4baDS6ii5iR4q1R/GAfi3G
	8Md6Du5B4FsXFiMdrCJuYzPNpxV8wM9TRCyHJFxRnNN3FpjkxncQivuE+h3QsB6Z
	9UnofOk93brKmj//f+aydhryqfNkM6Dnieg+o1fsIrWnykTNA+4U+jhyOSlcpSSC
	5q+Dy1TYu9xp4srgZXT+LS2jw1ZZo8V73+unLvxn1YZRzPJAKfhrOT1jMyQ5jHQw
	gJyc3mS/d0ydG41h+IqXJKWX12wkPrfEvNMCfI9AwAx2mX1vbT0vwsj8S7JP7A0e
	hizcoQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fpfu84t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TFr6fN021328
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:06 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 07:53:05 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v4 1/5] wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
Date: Wed, 29 Jan 2025 21:22:42 +0530
Message-ID: <20250129155246.155587-2-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: pE18ptmbJp67V5RKTzKodpAbCT1p2vtA
X-Proofpoint-ORIG-GUID: pE18ptmbJp67V5RKTzKodpAbCT1p2vtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290127

Currently, setting RTS threshold is based on per-phy basis, i.e., all the
radios present in a wiphy will take RTS threshold value to be the one sent
from userspace. But each radio in a multi-radio wiphy can have different
RTS threshold requirements.

To extend support to set RTS threshold for each radio, get the radio for
which RTS threshold needs to be changed from the user. Add a new attribute
in NL - NL80211_ATTR_WIPHY_RADIO_INDEX, to identify the radio of interest.
Create a new structure - wiphy_radio_cfg and add rts_threshold in it as a
u32 value to store RTS threshold of each radio in a wiphy and allocate
memory for it during wiphy register based on the wiphy.n_radio updated by
drivers. Pass radio id received from the user to mac80211 drivers along
with its corresponding RTS threshold.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   2 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |   2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |   2 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   2 +-
 include/net/cfg80211.h                        |  20 +++-
 include/uapi/linux/nl80211.h                  |   8 ++
 net/mac80211/cfg.c                            |   2 +-
 net/wireless/core.c                           |  18 +++
 net/wireless/nl80211.c                        | 108 +++++++++++-------
 net/wireless/rdev-ops.h                       |   6 +-
 net/wireless/trace.h                          |   5 +-
 net/wireless/wext-compat.c                    |   8 +-
 15 files changed, 133 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 72ce321f2a77..120dbd66ea11 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1376,7 +1376,7 @@ void ath6kl_cfg80211_tkip_micerr_event(struct ath6kl_vif *vif, u8 keyid,
 				     GFP_KERNEL);
 }
 
-static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 changed)
 {
 	struct ath6kl *ar = (struct ath6kl *)wiphy_priv(wiphy);
 	struct ath6kl_vif *vif;
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index a1a0a9223e74..fc6e33cb3d48 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1408,7 +1408,7 @@ static int wil_cfg80211_disconnect(struct wiphy *wiphy,
 	return rc;
 }
 
-static int wil_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int wil_cfg80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 changed)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	int rc;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4b70845e1a26..418b9dadb039 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1623,7 +1623,7 @@ static s32 brcmf_set_retry(struct net_device *ndev, u32 retry, bool l)
 	return err;
 }
 
-static s32 brcmf_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static s32 brcmf_cfg80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 changed)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct net_device *ndev = cfg_to_ndev(cfg);
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a099fdaafa45..8f1929ee2a92 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -737,7 +737,7 @@ mwifiex_set_rts(struct mwifiex_private *priv, u32 rts_thr)
  * Fragmentation threshold of the driver.
  */
 static int
-mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 changed)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
 	struct mwifiex_private *priv;
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index e7aa0f991923..2de0834d76cd 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -800,7 +800,7 @@ static int change_bss(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 changed)
 {
 	int ret = -EINVAL;
 	struct cfg_param_attr cfg_param_val;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 0b2282528342..e4ba386f6265 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -370,7 +370,7 @@ static int qtnf_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
-static int qtnf_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int qtnf_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 changed)
 {
 	struct qtnf_wmac *mac = wiphy_priv(wiphy);
 	struct qtnf_vif *vif;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 7fcc46a0bb48..c7458bf9a7f1 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1298,7 +1298,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	return ret;
 }
 
-static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 changed)
 {
 	return 0;
 }
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 363d7dd2255a..9cbce47fcea6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4750,7 +4750,7 @@ struct cfg80211_ops {
 	int	(*set_mcast_rate)(struct wiphy *wiphy, struct net_device *dev,
 				  int rate[NUM_NL80211_BANDS]);
 
-	int	(*set_wiphy_params)(struct wiphy *wiphy, u32 changed);
+	int	(*set_wiphy_params)(struct wiphy *wiphy, u8 radio_id, u32 changed);
 
 	int	(*set_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				enum nl80211_tx_power_setting type, int mbm);
@@ -5441,6 +5441,18 @@ struct wiphy_iftype_akm_suites {
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
@@ -5698,6 +5710,10 @@ struct wiphy_radio {
  *
  * @radio: radios belonging to this wiphy
  * @n_radio: number of radios
+ *
+ * @radio_cfg: configuration of radios belonging to a muli-radio wiphy. This struct
+ *	contains a list of all radio specific attributes and should be used only for
+ *	multi-radio wiphy.
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5785,6 +5801,8 @@ struct wiphy {
 	void (*reg_notifier)(struct wiphy *wiphy,
 			     struct regulatory_request *request);
 
+	struct wiphy_radio_cfg *radio_cfg;
+
 	/* fields below are read-only, assigned by cfg80211 */
 
 	const struct ieee80211_regdomain __rcu *regd;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f6c1b181c886..5e7dca7c6083 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2893,6 +2893,11 @@ enum nl80211_commands {
  * @NL80211_ATTR_EPCS: Flag attribute indicating that EPCS is enabled for a
  *	station interface.
  *
+ * @NL80211_ATTR_WIPHY_RADIO_INDEX: Integer attribute denoting the index of
+ *	the radio in interest. Internally a value of 0xff is used to indicate
+ *	this attribute is not present, and hence any associated attributes are
+ *	deemed to be applicable to all radios
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3448,6 +3453,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_MLO_RECONF_REM_LINKS,
 	NL80211_ATTR_EPCS,
 
+	NL80211_ATTR_WIPHY_RADIO_INDEX,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3490,6 +3497,7 @@ enum nl80211_attrs {
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
 
 #define NL80211_WIPHY_NAME_MAXLEN		64
+#define NL80211_WIPHY_RADIO_ID_MAX		0xff
 
 #define NL80211_MAX_SUPP_RATES			32
 #define NL80211_MAX_SUPP_SELECTORS		128
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9351c64608a9..ac28800fcaee 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3009,7 +3009,7 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 changed)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	int err;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 70857018f020..3f4c9edc2bc8 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1077,6 +1077,23 @@ int wiphy_register(struct wiphy *wiphy)
 		return res;
 	}
 
+	/* Allocate radio configuration space for multi-radio wiphy.
+	 */
+	if (wiphy->n_radio) {
+		int idx;
+
+		wiphy->radio_cfg = kcalloc(wiphy->n_radio, sizeof(*wiphy->radio_cfg),
+					   GFP_KERNEL);
+		if (!wiphy->radio_cfg)
+			return -ENOMEM;
+		/*
+		 * Initialize wiphy radio parameters to IEEE 802.11 MIB default values.
+		 * RTS threshold is disabled by default with the special -1 value.
+		 */
+		for (idx = 0; idx < wiphy->n_radio; idx++)
+			wiphy->radio_cfg[idx].rts_threshold = (u32)-1;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(wiphy_register);
@@ -1187,6 +1204,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cfg80211_rdev_free_wowlan(rdev);
 	cfg80211_free_coalesce(rdev->coalesce);
 	rdev->coalesce = NULL;
+	kfree(wiphy->radio_cfg);
 }
 EXPORT_SYMBOL(wiphy_unregister);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7d3da0f6833..be443a9bf6cd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -850,6 +850,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 				       NL80211_MAX_SUPP_SELECTORS),
 	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
 	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
+	[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_U8 },
 };
 
 /* policy for the key attributes */
@@ -3607,7 +3608,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	int result = 0, rem_txq_params = 0;
 	struct nlattr *nl_txq_params;
 	u32 changed;
-	u8 retry_short = 0, retry_long = 0;
+	u8 retry_short = 0, retry_long = 0, radio_id = NL80211_WIPHY_RADIO_ID_MAX;
 	u32 frag_threshold = 0, rts_threshold = 0;
 	u8 coverage_class = 0;
 	u32 txq_limit = 0, txq_memory_limit = 0, txq_quantum = 0;
@@ -3661,6 +3662,16 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (result)
 		return result;
 
+	if (info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]) {
+		/* Radio idx is not expected for non-multi radio wiphy */
+		if (!rdev->wiphy.n_radio)
+			return -EINVAL;
+
+		radio_id = nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]);
+		if (radio_id >= rdev->wiphy.n_radio)
+			return -EINVAL;
+	}
+
 	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
 		struct ieee80211_txq_params txq_params;
 		struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
@@ -3870,49 +3881,68 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (changed) {
 		u8 old_retry_short, old_retry_long;
 		u32 old_frag_threshold, old_rts_threshold;
-		u8 old_coverage_class;
+		u8 old_coverage_class, i;
 		u32 old_txq_limit, old_txq_memory_limit, old_txq_quantum;
 
 		if (!rdev->ops->set_wiphy_params)
 			return -EOPNOTSUPP;
 
-		old_retry_short = rdev->wiphy.retry_short;
-		old_retry_long = rdev->wiphy.retry_long;
-		old_frag_threshold = rdev->wiphy.frag_threshold;
-		old_rts_threshold = rdev->wiphy.rts_threshold;
-		old_coverage_class = rdev->wiphy.coverage_class;
-		old_txq_limit = rdev->wiphy.txq_limit;
-		old_txq_memory_limit = rdev->wiphy.txq_memory_limit;
-		old_txq_quantum = rdev->wiphy.txq_quantum;
-
-		if (changed & WIPHY_PARAM_RETRY_SHORT)
-			rdev->wiphy.retry_short = retry_short;
-		if (changed & WIPHY_PARAM_RETRY_LONG)
-			rdev->wiphy.retry_long = retry_long;
-		if (changed & WIPHY_PARAM_FRAG_THRESHOLD)
-			rdev->wiphy.frag_threshold = frag_threshold;
-		if (changed & WIPHY_PARAM_RTS_THRESHOLD)
-			rdev->wiphy.rts_threshold = rts_threshold;
-		if (changed & WIPHY_PARAM_COVERAGE_CLASS)
-			rdev->wiphy.coverage_class = coverage_class;
-		if (changed & WIPHY_PARAM_TXQ_LIMIT)
-			rdev->wiphy.txq_limit = txq_limit;
-		if (changed & WIPHY_PARAM_TXQ_MEMORY_LIMIT)
-			rdev->wiphy.txq_memory_limit = txq_memory_limit;
-		if (changed & WIPHY_PARAM_TXQ_QUANTUM)
-			rdev->wiphy.txq_quantum = txq_quantum;
-
-		result = rdev_set_wiphy_params(rdev, changed);
-		if (result) {
-			rdev->wiphy.retry_short = old_retry_short;
-			rdev->wiphy.retry_long = old_retry_long;
-			rdev->wiphy.frag_threshold = old_frag_threshold;
-			rdev->wiphy.rts_threshold = old_rts_threshold;
-			rdev->wiphy.coverage_class = old_coverage_class;
-			rdev->wiphy.txq_limit = old_txq_limit;
-			rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
-			rdev->wiphy.txq_quantum = old_txq_quantum;
-			return result;
+		if (radio_id < rdev->wiphy.n_radio) {
+			old_rts_threshold =
+				rdev->wiphy.radio_cfg[radio_id].rts_threshold;
+
+			if (changed & WIPHY_PARAM_RTS_THRESHOLD)
+				rdev->wiphy.radio_cfg[radio_id].rts_threshold =
+					rts_threshold;
+
+			result = rdev_set_wiphy_params(rdev, radio_id, changed);
+			if (result)
+				rdev->wiphy.radio_cfg[radio_id].rts_threshold =
+					old_rts_threshold;
+		} else {
+			old_retry_short = rdev->wiphy.retry_short;
+			old_retry_long = rdev->wiphy.retry_long;
+			old_frag_threshold = rdev->wiphy.frag_threshold;
+			old_rts_threshold = rdev->wiphy.rts_threshold;
+			old_coverage_class = rdev->wiphy.coverage_class;
+			old_txq_limit = rdev->wiphy.txq_limit;
+			old_txq_memory_limit = rdev->wiphy.txq_memory_limit;
+			old_txq_quantum = rdev->wiphy.txq_quantum;
+
+			if (changed & WIPHY_PARAM_RETRY_SHORT)
+				rdev->wiphy.retry_short = retry_short;
+			if (changed & WIPHY_PARAM_RETRY_LONG)
+				rdev->wiphy.retry_long = retry_long;
+			if (changed & WIPHY_PARAM_FRAG_THRESHOLD)
+				rdev->wiphy.frag_threshold = frag_threshold;
+			if (changed & WIPHY_PARAM_RTS_THRESHOLD)
+				rdev->wiphy.rts_threshold = rts_threshold;
+			if (changed & WIPHY_PARAM_COVERAGE_CLASS)
+				rdev->wiphy.coverage_class = coverage_class;
+			if (changed & WIPHY_PARAM_TXQ_LIMIT)
+				rdev->wiphy.txq_limit = txq_limit;
+			if (changed & WIPHY_PARAM_TXQ_MEMORY_LIMIT)
+				rdev->wiphy.txq_memory_limit = txq_memory_limit;
+			if (changed & WIPHY_PARAM_TXQ_QUANTUM)
+				rdev->wiphy.txq_quantum = txq_quantum;
+
+			result = rdev_set_wiphy_params(rdev, radio_id, changed);
+			if (result) {
+				rdev->wiphy.retry_short = old_retry_short;
+				rdev->wiphy.retry_long = old_retry_long;
+				rdev->wiphy.frag_threshold = old_frag_threshold;
+				rdev->wiphy.rts_threshold = old_rts_threshold;
+				rdev->wiphy.coverage_class = old_coverage_class;
+				rdev->wiphy.txq_limit = old_txq_limit;
+				rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
+				rdev->wiphy.txq_quantum = old_txq_quantum;
+				return result;
+			}
+
+			for (i = 0 ; i < rdev->wiphy.n_radio; i++) {
+				rdev->wiphy.radio_cfg[i].rts_threshold =
+					rdev->wiphy.rts_threshold;
+			}
 		}
 	}
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 759da1623342..0b4185013fb2 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -577,13 +577,13 @@ static inline int rdev_leave_ibss(struct cfg80211_registered_device *rdev,
 }
 
 static inline int
-rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u32 changed)
+rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u8 radio_id, u32 changed)
 {
 	int ret = -EOPNOTSUPP;
 
-	trace_rdev_set_wiphy_params(&rdev->wiphy, changed);
+	trace_rdev_set_wiphy_params(&rdev->wiphy, radio_id, changed);
 	if (rdev->ops->set_wiphy_params)
-		ret = rdev->ops->set_wiphy_params(&rdev->wiphy, changed);
+		ret = rdev->ops->set_wiphy_params(&rdev->wiphy, radio_id, changed);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 4f0abd5d49df..5fd600f54e0a 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1676,10 +1676,11 @@ TRACE_EVENT(rdev_join_ocb,
 );
 
 TRACE_EVENT(rdev_set_wiphy_params,
-	TP_PROTO(struct wiphy *wiphy, u32 changed),
-	TP_ARGS(wiphy, changed),
+	TP_PROTO(struct wiphy *wiphy, u8 radio_id, u32 changed),
+	TP_ARGS(wiphy, radio_id, changed),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
+		__field(u8, radio_id)
 		__field(u32, changed)
 	),
 	TP_fast_assign(
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a74b1afc594e..fd4a4112610e 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -263,7 +263,8 @@ int cfg80211_wext_siwrts(struct net_device *dev,
 	else
 		wdev->wiphy->rts_threshold = rts->value;
 
-	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_RTS_THRESHOLD);
+	err = rdev_set_wiphy_params(rdev, NL80211_WIPHY_RADIO_ID_MAX,
+				    WIPHY_PARAM_RTS_THRESHOLD);
 	if (err)
 		wdev->wiphy->rts_threshold = orts;
 	return err;
@@ -304,7 +305,8 @@ int cfg80211_wext_siwfrag(struct net_device *dev,
 		wdev->wiphy->frag_threshold = frag->value & ~0x1;
 	}
 
-	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_FRAG_THRESHOLD);
+	err = rdev_set_wiphy_params(rdev, NL80211_WIPHY_RADIO_ID_MAX,
+				    WIPHY_PARAM_FRAG_THRESHOLD);
 	if (err)
 		wdev->wiphy->frag_threshold = ofrag;
 	return err;
@@ -355,7 +357,7 @@ static int cfg80211_wext_siwretry(struct net_device *dev,
 		changed |= WIPHY_PARAM_RETRY_SHORT;
 	}
 
-	err = rdev_set_wiphy_params(rdev, changed);
+	err = rdev_set_wiphy_params(rdev, NL80211_WIPHY_RADIO_ID_MAX, changed);
 	if (err) {
 		wdev->wiphy->retry_short = oshort;
 		wdev->wiphy->retry_long = olong;
-- 
2.17.1


