Return-Path: <linux-wireless+bounces-17161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814EAA0492D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 19:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013FB18868F5
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 18:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C71F3D47;
	Tue,  7 Jan 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QFLRwZUF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A81F1902
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274425; cv=none; b=iiTDYuaEUfMP7okXytKQv5WmvYUkLwVVeO+rqGJrgaEwzBpQdb74kznqrPGeMtq7ndBdylWWzrWmGzKoEHoDG04az0jdKyN+kaJn/1QUmBBph3118L1Zv4aBsOw+OKhUCEMZs9L5K4xo51QukJ7DZOueQneSNi9CVeP5WdKmdII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274425; c=relaxed/simple;
	bh=K9oNRJKWVCOa++6KTn2KUjH+8Yqsikq1EUj4kIN9ipk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ncx37VRTKWgvaZwn3qKu7APnlLc0uNTrzjcVSyIJZnYraAkWyQqcgD44XSzbF7iXXg9stGV9MVMNcNBnm7DpvUxKUJbJ4F3ndcFdZn4bjlSUlDMfThYVe9Wwu39rq/0du9hiJpprrg4XKESH6EJgqmTBtDLt8cXQbdjLGxmP+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QFLRwZUF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507Afnpr026038;
	Tue, 7 Jan 2025 18:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rUR+j0wJ3GrR1mMcywhBMPT3H46RShAcG6GRcFeJPQY=; b=QFLRwZUFUzxGAVVu
	tsOz1oEWqWOMmX7cF1qKyu3OrZJ0dJU7cH+VtoySiW8n0+mjsBTvlpH2Py/5tzLM
	F11FN7/VADXzx2vhnx4MImTffa4f+8PSs9/kAv81aPjYPfE5DFTQb+EUHCR6Jdc5
	HsF2AgqzSpyvnm+tVZy1K9BHeemecTNMUg/ojLVECsvFKSltMAXHeyu+4dCmEF2X
	CeeLUyNONGJ3R7l32VbBPavaa8Rd/Jj9wA++8/klgToA5vPk6aWCqRjNZJmtiS3U
	RqVwA4+Bg9D2hUeNFIx1fnPqw7k6Pg39IPBPvKjuH5sJ7EgWMqVlmHnjoOzztPNj
	sHdg/g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4412r795xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 18:26:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507IQvpC004468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 18:26:57 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 10:26:55 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH RFC 1/5] wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
Date: Tue, 7 Jan 2025 23:55:02 +0530
Message-ID: <20250107182506.1838704-2-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107182506.1838704-1-quic_ramess@quicinc.com>
References: <20250107182506.1838704-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: jZvMF5I1F1TtUPhnCwQwR_-MM2SSFzQ_
X-Proofpoint-ORIG-GUID: jZvMF5I1F1TtUPhnCwQwR_-MM2SSFzQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070153

From: Roopni Devanathan <quic_rdevanat@quicinc.com>

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

Note:
The proposed design can be extended to all per-radio attributes, such as,
frag_threshold, retry_short, retry_long, coverage_class, etc. This can be
done by adding the corresponding datatype entry in wiphy_radio_cfg struct
and modifying the handlers to use the added struct members. The added
NL80211_ATTR_WIPHY_RADIO_INDEX attribute can be reused to identify the
index of radio.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  2 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  2 +-
 include/net/cfg80211.h                        | 21 ++++++++++-
 include/uapi/linux/nl80211.h                  | 14 ++++++++
 net/mac80211/cfg.c                            |  2 +-
 net/wireless/core.c                           | 18 ++++++++++
 net/wireless/nl80211.c                        | 36 +++++++++++++++----
 net/wireless/rdev-ops.h                       |  6 ++--
 net/wireless/trace.h                          |  5 +--
 net/wireless/wext-compat.c                    |  8 +++--
 15 files changed, 100 insertions(+), 24 deletions(-)

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
index 902ac3108782..2df5e3d3cc84 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1619,7 +1619,7 @@ static s32 brcmf_set_retry(struct net_device *ndev, u32 retry, bool l)
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
index 7790af534b7f..101975509247 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4728,7 +4728,7 @@ struct cfg80211_ops {
 	int	(*set_mcast_rate)(struct wiphy *wiphy, struct net_device *dev,
 				  int rate[NUM_NL80211_BANDS]);
 
-	int	(*set_wiphy_params)(struct wiphy *wiphy, u32 changed);
+	int	(*set_wiphy_params)(struct wiphy *wiphy, u8 radio_id, u32 changed);
 
 	int	(*set_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				enum nl80211_tx_power_setting type, int mbm);
@@ -5414,6 +5414,18 @@ struct wiphy_iftype_akm_suites {
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
@@ -5671,6 +5683,11 @@ struct wiphy_radio {
  *
  * @radio: radios belonging to this wiphy
  * @n_radio: number of radios
+ *
+ * @radio_cfg: configuration of radios belonging to a muli-radio wiphy. This struct
+ *	contains a list of all radio specific attributes and should be used only for
+ *	multi-radio wiphy.
+ *
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5758,6 +5775,8 @@ struct wiphy {
 	void (*reg_notifier)(struct wiphy *wiphy,
 			     struct regulatory_request *request);
 
+	struct wiphy_radio_cfg *radio_cfg;
+
 	/* fields below are read-only, assigned by cfg80211 */
 
 	const struct ieee80211_regdomain __rcu *regd;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 6d11437596b9..fe9162d308a2 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2871,6 +2871,17 @@ enum nl80211_commands {
  * @NL80211_ATTR_VIF_RADIO_MASK: Bitmask of allowed radios (u32).
  *	A value of 0 means all radios.
  *
+ * @NL80211_ATTR_WIPHY_RADIO_INDEX: Integer attribute denoting the index of
+ *	the radio in interest. Internally a value of 0xff is used to indicate
+ *	this attribute is not present, and hence any associated attributes are
+ *	deemed to be applicable to all radios
+ *
+ * *RFC NOTE:* Rather than having a radio index we could have a radio mask like we
+ *	do for vif. If having a mask is preferred then we can rename
+ *	NL80211_ATTR_VIF_RADIO_MASK => NL80211_ATTR_RADIO_MASK and define
+ *	NL80211_ATTR_VIF_RADIO_MASK to be equal to NL80211_ATTR_RADIO_MASK,
+ *	either via a macro or as an additional enum.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3421,6 +3432,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_VIF_RADIO_MASK,
 
+	NL80211_ATTR_WIPHY_RADIO_INDEX,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3463,6 +3476,7 @@ enum nl80211_attrs {
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
 
 #define NL80211_WIPHY_NAME_MAXLEN		64
+#define NL80211_WIPHY_RADIO_ID_MAX		0xff
 
 #define NL80211_MAX_SUPP_RATES			32
 #define NL80211_MAX_SUPP_HT_RATES		77
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b8495d5f2297..33a325524997 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3004,7 +3004,7 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
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
index 8789d8b73f0f..3b004b419a74 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -830,6 +830,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
 	[NL80211_ATTR_VIF_RADIO_MASK] = { .type = NLA_U32 },
+	[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_U8 },
 };
 
 /* policy for the key attributes */
@@ -3587,8 +3588,8 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	int result = 0, rem_txq_params = 0;
 	struct nlattr *nl_txq_params;
 	u32 changed;
-	u8 retry_short = 0, retry_long = 0;
-	u32 frag_threshold = 0, rts_threshold = 0;
+	u8 retry_short = 0, retry_long = 0, radio_id = NL80211_WIPHY_RADIO_ID_MAX;
+	u32 frag_threshold = 0, rts_threshold = 0, radio_mask = BIT(rdev->wiphy.n_radio) - 1;
 	u8 coverage_class = 0;
 	u32 txq_limit = 0, txq_memory_limit = 0, txq_quantum = 0;
 
@@ -3641,6 +3642,17 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (result)
 		return result;
 
+	if (info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]) {
+		/* Radio idx is not expected for non-multi radio wiphy */
+		if (!radio_mask)
+			return -EINVAL;
+
+		radio_id = nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]);
+
+		if (!(BIT(radio_id) & radio_mask))
+			return -EINVAL;
+	}
+
 	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
 		struct ieee80211_txq_params txq_params;
 		struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
@@ -3859,7 +3871,10 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		old_retry_short = rdev->wiphy.retry_short;
 		old_retry_long = rdev->wiphy.retry_long;
 		old_frag_threshold = rdev->wiphy.frag_threshold;
-		old_rts_threshold = rdev->wiphy.rts_threshold;
+		if (radio_id >= rdev->wiphy.n_radio)
+			old_rts_threshold = rdev->wiphy.rts_threshold;
+		else
+			old_rts_threshold = rdev->wiphy.radio_cfg[radio_id].rts_threshold;
 		old_coverage_class = rdev->wiphy.coverage_class;
 		old_txq_limit = rdev->wiphy.txq_limit;
 		old_txq_memory_limit = rdev->wiphy.txq_memory_limit;
@@ -3871,8 +3886,12 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			rdev->wiphy.retry_long = retry_long;
 		if (changed & WIPHY_PARAM_FRAG_THRESHOLD)
 			rdev->wiphy.frag_threshold = frag_threshold;
-		if (changed & WIPHY_PARAM_RTS_THRESHOLD)
-			rdev->wiphy.rts_threshold = rts_threshold;
+		if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
+			if (radio_id >= rdev->wiphy.n_radio)
+				rdev->wiphy.rts_threshold = rts_threshold;
+			else
+				rdev->wiphy.radio_cfg[radio_id].rts_threshold =	rts_threshold;
+		}
 		if (changed & WIPHY_PARAM_COVERAGE_CLASS)
 			rdev->wiphy.coverage_class = coverage_class;
 		if (changed & WIPHY_PARAM_TXQ_LIMIT)
@@ -3882,12 +3901,15 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		if (changed & WIPHY_PARAM_TXQ_QUANTUM)
 			rdev->wiphy.txq_quantum = txq_quantum;
 
-		result = rdev_set_wiphy_params(rdev, changed);
+		result = rdev_set_wiphy_params(rdev, radio_id, changed);
 		if (result) {
 			rdev->wiphy.retry_short = old_retry_short;
 			rdev->wiphy.retry_long = old_retry_long;
 			rdev->wiphy.frag_threshold = old_frag_threshold;
-			rdev->wiphy.rts_threshold = old_rts_threshold;
+			if (radio_id >= rdev->wiphy.n_radio)
+				rdev->wiphy.rts_threshold = old_rts_threshold;
+			else
+				rdev->wiphy.radio_cfg[radio_id].rts_threshold = old_rts_threshold;
 			rdev->wiphy.coverage_class = old_coverage_class;
 			rdev->wiphy.txq_limit = old_txq_limit;
 			rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 8f2aa7e76c0a..cc06db496e5d 100644
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
index a57210c8087c..7bf91c6d3d81 100644
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
2.34.1


