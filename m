Return-Path: <linux-wireless+bounces-23267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01051AC040A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 07:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2264A473D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28531A5BA4;
	Thu, 22 May 2025 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LWAgX8wb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD121A5B99
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747892046; cv=none; b=X2gEFac9DRVHl+X684784EZSy0ZWB8uLXiRk1uBmai69ehEUrq3UctJjUk3LAzN5cL4Gf4cWnHyLttLvFZhdTIcmz9484btVsldk/7GDICejIAEmmFRzEA5YNMS1sytKox+pwQau0bfWFMO1YBVUEmklDw+2xAmyYSDQ9HHqBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747892046; c=relaxed/simple;
	bh=OP3GGMP/rQexa1fmF60rY6xaRdEpbin/+zF2PMx5c+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCSHofcl8bqA6CBnfA4udEwVlxqsTxc4XwOcN5mEIxaYhZ4fXR/biyRKxNSMU+ydJIbaK70d0Amw9i56V4nY1IShYugLopUIpmlA5Aq1f2fqf/HxnPqTe39W4V7paF4kz7gPF5ovmEnNmYdLogmfGux2SR3KmtVT5uuy00AYuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LWAgX8wb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHn7dM016582;
	Thu, 22 May 2025 05:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+R1OIWwSzS8FSyAoSGvRw2pXnosd/gCdSxBvHXvhjnw=; b=LWAgX8wbung0M7L6
	tFSaXKnWRwQc+NnBcFLz70n3P4DtTpGPEuWgt5RVTDQ+d6smumZihlTZUg7R8VbO
	V3FqN3ptcNKDIU3FBoQCTixShGLOJVNXU2mMnhHzzl+rMfX3YJyB9exwvIhQiCYj
	cVyFdbUvDcxiR171asoBYn2EVNU+ZVxobpKRTR4JJg6hB9QAOwesHLNyXCnltger
	XPfb9LYNTGOFpVkCbv3vMaIt3vK92RPk6+ZAc3tLoE0TLshch7mypkGgnScZDHfd
	jG/Wii7ILKo4el9Av2ixbcKUgJUpsT/LByS4Zoq0kLw/lCRuU6SKSOpVizU9Ir2i
	m53JSw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9w4r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 05:33:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M5Xw7X007877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 05:33:58 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 21 May 2025 22:33:56 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v11 1/3] wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
Date: Thu, 22 May 2025 11:03:24 +0530
Message-ID: <20250522053326.4139256-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
References: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682eb747 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=X7iRgK--q0HppJMW348A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -t9eTpS35zkbP89jH6A0oL6n02TdfuLF
X-Proofpoint-GUID: -t9eTpS35zkbP89jH6A0oL6n02TdfuLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA1MyBTYWx0ZWRfXwQ6JsBlZVqgS
 tu9nHu81scHPVSugndDORIV4zIm0HWkN8WVtmMrFWXN7hxlqZvKkVhVL53aqg2CcfAPPwA/jmBD
 pQ8jTaiOo2Ob/SD/4hZkvYFq8gMGQcNazn6knVksCw7btqon9uXk9whi7dnoF4PTjBs9e5Mp/AO
 Q8hlIyar9ZARSuVYY74cILer/4nY9mr8npznMVI5I2f9yG2oli/+XrhyrjTgt0JOB3LscXQUL3Z
 SxXQ2QB7/4YjRhEeHbnoqQKe8hXnZ6mk6tzF28tv6VHvTHaQ7vV8/gz1if3YT3/SNEXh5E/Kcgn
 cTPTFAzWw2ZlGkNmuGcKaYgoDBR3TCQy09ge04Cd2hWTRAuGVs+d1KgWu+slFEBI4g1wuEThPso
 oWZsnlaNh/5HnI5ENm2dhvVel7/jJgE5Pr9JP871ekcWPfHJLtv73imLRIjyIugg4Iuh3RQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220053

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
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  3 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  4 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  3 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  3 +-
 include/net/cfg80211.h                        | 21 +++++-
 include/uapi/linux/nl80211.h                  | 10 +++
 net/mac80211/cfg.c                            |  3 +-
 net/wireless/core.c                           | 19 +++++
 net/wireless/nl80211.c                        | 69 +++++++++++++++++--
 net/wireless/rdev-ops.h                       |  8 ++-
 net/wireless/trace.h                          | 11 +--
 net/wireless/wext-compat.c                    |  6 +-
 15 files changed, 145 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 8c2e8081112e..69a347d36757 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1376,7 +1376,8 @@ void ath6kl_cfg80211_tkip_micerr_event(struct ath6kl_vif *vif, u8 keyid,
 				     GFP_KERNEL);
 }
 
-static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, int radio_id,
+					    u32 changed)
 {
 	struct ath6kl *ar = (struct ath6kl *)wiphy_priv(wiphy);
 	struct ath6kl_vif *vif;
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 5473c01cbe66..c4852ca5ecbd 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1408,7 +1408,8 @@ static int wil_cfg80211_disconnect(struct wiphy *wiphy,
 	return rc;
 }
 
-static int wil_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int wil_cfg80211_set_wiphy_params(struct wiphy *wiphy, int radio_id,
+					 u32 changed)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	int rc;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index dc2383faddd1..0ab38debd6e6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1622,7 +1622,9 @@ static s32 brcmf_set_retry(struct net_device *ndev, u32 retry, bool l)
 	return err;
 }
 
-static s32 brcmf_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static s32 brcmf_cfg80211_set_wiphy_params(struct wiphy *wiphy,
+					   int radio_id,
+					   u32 changed)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct net_device *ndev = cfg_to_ndev(cfg);
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 60c12328c2f3..6a6023990e2a 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -737,7 +737,8 @@ mwifiex_set_rts(struct mwifiex_private *priv, u32 rts_thr)
  * Fragmentation threshold of the driver.
  */
 static int
-mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, int radio_id,
+				  u32 changed)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
 	struct mwifiex_private *priv;
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index e7aa0f991923..61c5894c6cbb 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -800,7 +800,7 @@ static int change_bss(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int set_wiphy_params(struct wiphy *wiphy, int radio_id, u32 changed)
 {
 	int ret = -EINVAL;
 	struct cfg_param_attr cfg_param_val;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 0b2282528342..f7d8d484eb0c 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -370,7 +370,8 @@ static int qtnf_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
-static int qtnf_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int qtnf_set_wiphy_params(struct wiphy *wiphy, int radio_id,
+				 u32 changed)
 {
 	struct qtnf_wmac *mac = wiphy_priv(wiphy);
 	struct qtnf_vif *vif;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 7fcc46a0bb48..55efef181595 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1298,7 +1298,8 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	return ret;
 }
 
-static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, int radio_id,
+					 u32 changed)
 {
 	return 0;
 }
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..5077c6010cf8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4752,7 +4752,8 @@ struct cfg80211_ops {
 	int	(*set_mcast_rate)(struct wiphy *wiphy, struct net_device *dev,
 				  int rate[NUM_NL80211_BANDS]);
 
-	int	(*set_wiphy_params)(struct wiphy *wiphy, u32 changed);
+	int	(*set_wiphy_params)(struct wiphy *wiphy, int radio_id,
+				    u32 changed);
 
 	int	(*set_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				enum nl80211_tx_power_setting type, int mbm);
@@ -5442,6 +5443,18 @@ struct wiphy_iftype_akm_suites {
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
@@ -5699,6 +5712,10 @@ struct wiphy_radio {
  *
  * @radio: radios belonging to this wiphy
  * @n_radio: number of radios
+ *
+ * @radio_cfg: configuration of radios belonging to a muli-radio wiphy. This
+ *	struct contains a list of all radio specific attributes and should be
+ *	used only for multi-radio wiphy.
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5786,6 +5803,8 @@ struct wiphy {
 	void (*reg_notifier)(struct wiphy *wiphy,
 			     struct regulatory_request *request);
 
+	struct wiphy_radio_cfg *radio_cfg;
+
 	/* fields below are read-only, assigned by cfg80211 */
 
 	const struct ieee80211_regdomain __rcu *regd;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e9ccf43fe3c6..464240e1903f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2899,6 +2899,14 @@ enum nl80211_commands {
  *	APs Support". Drivers may set additional flags that they support
  *	in the kernel or device.
  *
+ * @NL80211_ATTR_WIPHY_RADIO_INDEX: (int) Integer attribute denoting the index
+ *	of the radio in interest. Internally a value of -1 is used to
+ *	indicate that the radio id is not given in user-space. This means
+ *	that all the attributes are applicable to all the radios. If there is
+ *	a radio index provided in user-space, the attributes will be
+ *	applicable to that specific radio only. If the radio id is greater
+ *	thank the number of radios, error denoting invalid value is returned.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3456,6 +3464,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS,
 
+	NL80211_ATTR_WIPHY_RADIO_INDEX,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9d88f2f2831..459b4861af02 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3028,7 +3028,8 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int ieee80211_set_wiphy_params(struct wiphy *wiphy, int radio_id,
+				      u32 changed)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	int err;
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
index fd5f79266471..4e8507649d15 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -854,6 +854,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
 	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
 	[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
+	[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_U8 },
 };
 
 /* policy for the key attributes */
@@ -3608,6 +3609,33 @@ static int nl80211_set_channel(struct sk_buff *skb, struct genl_info *info)
 	return __nl80211_set_channel(rdev, netdev, info, link_id);
 }
 
+static int nl80211_set_wiphy_radio(struct genl_info *info,
+				   struct cfg80211_registered_device *rdev,
+				   int radio_id)
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
+	old_rts = rdev->wiphy.radio_cfg[radio_id].rts_threshold;
+
+	rdev->wiphy.radio_cfg[radio_id].rts_threshold = rts_threshold;
+
+	result = rdev_set_wiphy_params(rdev, radio_id, changed);
+	if (result)
+		rdev->wiphy.radio_cfg[radio_id].rts_threshold = old_rts;
+
+	return 0;
+}
+
 static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = NULL;
@@ -3617,6 +3645,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *nl_txq_params;
 	u32 changed;
 	u8 retry_short = 0, retry_long = 0;
+	int radio_id = -1;
 	u32 frag_threshold = 0, rts_threshold = 0;
 	u8 coverage_class = 0;
 	u32 txq_limit = 0, txq_memory_limit = 0, txq_quantum = 0;
@@ -3670,6 +3699,19 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (result)
 		return result;
 
+	if (info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]) {
+		/* Radio idx is not expected for non-multi radio wiphy */
+		if (rdev->wiphy.n_radio <= 0)
+			return -EINVAL;
+
+		radio_id = nla_get_u8(
+				info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]);
+		if (radio_id >= rdev->wiphy.n_radio)
+			return -EINVAL;
+		else
+			return nl80211_set_wiphy_radio(info, rdev, radio_id);
+	}
+
 	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
 		struct ieee80211_txq_params txq_params;
 		struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
@@ -3879,16 +3921,26 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (changed) {
 		u8 old_retry_short, old_retry_long;
 		u32 old_frag_threshold, old_rts_threshold;
-		u8 old_coverage_class;
+		u8 old_coverage_class, i;
 		u32 old_txq_limit, old_txq_memory_limit, old_txq_quantum;
+		u32 *old_radio_rts_threshold;
 
 		if (!rdev->ops->set_wiphy_params)
 			return -EOPNOTSUPP;
 
+		old_radio_rts_threshold = kcalloc(rdev->wiphy.n_radio,
+						  sizeof(u32),
+						  GFP_KERNEL);
+		if (!old_radio_rts_threshold)
+			return -ENOMEM;
+
 		old_retry_short = rdev->wiphy.retry_short;
 		old_retry_long = rdev->wiphy.retry_long;
 		old_frag_threshold = rdev->wiphy.frag_threshold;
 		old_rts_threshold = rdev->wiphy.rts_threshold;
+		for (i = 0 ; i < rdev->wiphy.n_radio; i++)
+			old_radio_rts_threshold[i] =
+				rdev->wiphy.radio_cfg[i].rts_threshold;
 		old_coverage_class = rdev->wiphy.coverage_class;
 		old_txq_limit = rdev->wiphy.txq_limit;
 		old_txq_memory_limit = rdev->wiphy.txq_memory_limit;
@@ -3900,8 +3952,12 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			rdev->wiphy.retry_long = retry_long;
 		if (changed & WIPHY_PARAM_FRAG_THRESHOLD)
 			rdev->wiphy.frag_threshold = frag_threshold;
-		if (changed & WIPHY_PARAM_RTS_THRESHOLD)
+		if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
 			rdev->wiphy.rts_threshold = rts_threshold;
+			for (i = 0 ; i < rdev->wiphy.n_radio; i++)
+				rdev->wiphy.radio_cfg[i].rts_threshold =
+					rdev->wiphy.rts_threshold;
+		}
 		if (changed & WIPHY_PARAM_COVERAGE_CLASS)
 			rdev->wiphy.coverage_class = coverage_class;
 		if (changed & WIPHY_PARAM_TXQ_LIMIT)
@@ -3911,18 +3967,23 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		if (changed & WIPHY_PARAM_TXQ_QUANTUM)
 			rdev->wiphy.txq_quantum = txq_quantum;
 
-		result = rdev_set_wiphy_params(rdev, changed);
+		result = rdev_set_wiphy_params(rdev, radio_id, changed);
 		if (result) {
 			rdev->wiphy.retry_short = old_retry_short;
 			rdev->wiphy.retry_long = old_retry_long;
 			rdev->wiphy.frag_threshold = old_frag_threshold;
 			rdev->wiphy.rts_threshold = old_rts_threshold;
+			for (i = 0 ; i < rdev->wiphy.n_radio; i++)
+				rdev->wiphy.radio_cfg[i].rts_threshold =
+					old_radio_rts_threshold[i];
 			rdev->wiphy.coverage_class = old_coverage_class;
 			rdev->wiphy.txq_limit = old_txq_limit;
 			rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
 			rdev->wiphy.txq_quantum = old_txq_quantum;
-			return result;
 		}
+
+		kfree(old_radio_rts_threshold);
+		return result;
 	}
 
 	return 0;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 9f4783c2354c..510d759bf908 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -577,13 +577,15 @@ static inline int rdev_leave_ibss(struct cfg80211_registered_device *rdev,
 }
 
 static inline int
-rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u32 changed)
+rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, int radio_id,
+		      u32 changed)
 {
 	int ret = -EOPNOTSUPP;
 
-	trace_rdev_set_wiphy_params(&rdev->wiphy, changed);
+	trace_rdev_set_wiphy_params(&rdev->wiphy, radio_id, changed);
 	if (rdev->ops->set_wiphy_params)
-		ret = rdev->ops->set_wiphy_params(&rdev->wiphy, changed);
+		ret = rdev->ops->set_wiphy_params(&rdev->wiphy, radio_id,
+						  changed);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 4ed9fada4ec0..08916d06f2d5 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1678,18 +1678,21 @@ TRACE_EVENT(rdev_join_ocb,
 );
 
 TRACE_EVENT(rdev_set_wiphy_params,
-	TP_PROTO(struct wiphy *wiphy, u32 changed),
-	TP_ARGS(wiphy, changed),
+	TP_PROTO(struct wiphy *wiphy, int radio_id, u32 changed),
+	TP_ARGS(wiphy, radio_id, changed),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
+		__field(int, radio_id)
 		__field(u32, changed)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
+		__entry->radio_id = radio_id;
 		__entry->changed = changed;
 	),
-	TP_printk(WIPHY_PR_FMT ", changed: %u",
-		  WIPHY_PR_ARG, __entry->changed)
+	TP_printk(WIPHY_PR_FMT ", radio_id: %d, changed: %u",
+		  WIPHY_PR_ARG, __entry->radio_id,
+		  __entry->changed)
 );
 
 DECLARE_EVENT_CLASS(wiphy_wdev_link_evt,
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a74b1afc594e..c931137e09d0 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -263,7 +263,7 @@ int cfg80211_wext_siwrts(struct net_device *dev,
 	else
 		wdev->wiphy->rts_threshold = rts->value;
 
-	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_RTS_THRESHOLD);
+	err = rdev_set_wiphy_params(rdev, -1, WIPHY_PARAM_RTS_THRESHOLD);
 	if (err)
 		wdev->wiphy->rts_threshold = orts;
 	return err;
@@ -304,7 +304,7 @@ int cfg80211_wext_siwfrag(struct net_device *dev,
 		wdev->wiphy->frag_threshold = frag->value & ~0x1;
 	}
 
-	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_FRAG_THRESHOLD);
+	err = rdev_set_wiphy_params(rdev, -1, WIPHY_PARAM_FRAG_THRESHOLD);
 	if (err)
 		wdev->wiphy->frag_threshold = ofrag;
 	return err;
@@ -355,7 +355,7 @@ static int cfg80211_wext_siwretry(struct net_device *dev,
 		changed |= WIPHY_PARAM_RETRY_SHORT;
 	}
 
-	err = rdev_set_wiphy_params(rdev, changed);
+	err = rdev_set_wiphy_params(rdev, -1, changed);
 	if (err) {
 		wdev->wiphy->retry_short = oshort;
 		wdev->wiphy->retry_long = olong;
-- 
2.25.1


