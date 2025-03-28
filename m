Return-Path: <linux-wireless+bounces-20925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E8A749BF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 13:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C320189B5C4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9C21ADBC;
	Fri, 28 Mar 2025 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pZJp1Pso"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E0213E7D
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164749; cv=none; b=L0kX7HO2pPShBaRr80wVYGL6S+Ti5ZArS8HYXPBe+/ixNxgyEDB/ALIidiHEN2j9S1sZryq0esrigMC8N/NvLqQZBvjFZN9QaTGLBXZdHBfYlhmK9ZrnmO6VhD+/iHGozn0TmO0vAaDU5v08XwWeook3Kr42nE/+ODsMckk0pwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164749; c=relaxed/simple;
	bh=gW5l6IiCJAyZDCh9UPr6+qDGaNODot/0dDxxigHCuZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipp3MHQWeSFybolKOLIzHhVYIh8QpPGO6GP3LDJSFqIKt/L7IKSoiUubZs90rizV80YNwUaKMqTGvQwV9YU4LXjDRjU1O/fJleFXL6qHPI02HCkREKxO5/DByVJF5mjOpeL9oAqDcG5Oxwba67d2kzDqP3Eh7w27jRFTx/P4JzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pZJp1Pso; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S56srB021236;
	Fri, 28 Mar 2025 12:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lN3R0loRgVVruQ+w/a2C5zOhmmfXL2aBljhS29HDAWk=; b=pZJp1PsoNPcBVh1a
	W81URGrkjsFu0ACOwFOfLtMoKYbBlK6GfXUhnLT5mFuHb2Re/PJ6N9EM+9lFf4Qb
	Sd/P802Q5lNJOx8/xcLjvoJOz0NFQq0eZzofLRsMQQRrTRq2gIinOS7ZImzHu1kY
	gF6lfJ9Il60xNuLqwB9lLNqvv9nD/HrV7hobj8DzhvZDET3/LG3cbT2pyiMEw+Hu
	ukCjM1rsMDR+wt5sFTcZVykUVvWy0MejG4bO7c7+nhqoQEO/8WVGsdi1GjvCgKiQ
	oCHR2lJQiytZBze0ltXXGA9OKC0WpxhVsrk38t0Mkeb8PWOtG7hqgnK66D3e69do
	ZwJkGQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9svnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 12:25:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52SCPeFq019315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 12:25:40 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Mar 2025 05:25:38 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v6 1/5] wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
Date: Fri, 28 Mar 2025 17:55:15 +0530
Message-ID: <20250328122519.1946729-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: 4JkfheV0DWKRakX66KeHUgoco9tB451Q
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e69545 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=FhWZ8a7bMJWNtulm9CMA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 4JkfheV0DWKRakX66KeHUgoco9tB451Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280086

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
 include/net/cfg80211.h                        |  20 ++-
 include/uapi/linux/nl80211.h                  |  11 ++
 net/mac80211/cfg.c                            |   2 +-
 net/wireless/core.c                           |  18 +++
 net/wireless/nl80211.c                        | 119 ++++++++++++------
 net/wireless/rdev-ops.h                       |   6 +-
 net/wireless/trace.h                          |   5 +-
 net/wireless/wext-compat.c                    |   9 +-
 15 files changed, 148 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 72ce321f2a77..ceb816035c02 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1376,7 +1376,7 @@ void ath6kl_cfg80211_tkip_micerr_event(struct ath6kl_vif *vif, u8 keyid,
 				     GFP_KERNEL);
 }
 
-static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u32 changed)
 {
 	struct ath6kl *ar = (struct ath6kl *)wiphy_priv(wiphy);
 	struct ath6kl_vif *vif;
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index a1a0a9223e74..fa8c91a2f600 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1408,7 +1408,7 @@ static int wil_cfg80211_disconnect(struct wiphy *wiphy,
 	return rc;
 }
 
-static int wil_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int wil_cfg80211_set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u32 changed)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	int rc;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4b70845e1a26..1bb778fceb69 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1623,7 +1623,7 @@ static s32 brcmf_set_retry(struct net_device *ndev, u32 retry, bool l)
 	return err;
 }
 
-static s32 brcmf_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static s32 brcmf_cfg80211_set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u32 changed)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct net_device *ndev = cfg_to_ndev(cfg);
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a099fdaafa45..aa222bd7b73c 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -737,7 +737,7 @@ mwifiex_set_rts(struct mwifiex_private *priv, u32 rts_thr)
  * Fragmentation threshold of the driver.
  */
 static int
-mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u32 changed)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
 	struct mwifiex_private *priv;
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index e7aa0f991923..b97ecec73f29 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -800,7 +800,7 @@ static int change_bss(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u32 changed)
 {
 	int ret = -EINVAL;
 	struct cfg_param_attr cfg_param_val;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 0b2282528342..c8f30b84e36d 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -370,7 +370,7 @@ static int qtnf_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
-static int qtnf_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int qtnf_set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u32 changed)
 {
 	struct qtnf_wmac *mac = wiphy_priv(wiphy);
 	struct qtnf_vif *vif;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 7fcc46a0bb48..db9e7b4ddc09 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1298,7 +1298,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	return ret;
 }
 
-static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u32 changed)
 {
 	return 0;
 }
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index efbd79c67be2..a3ac72355274 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4782,7 +4782,7 @@ struct cfg80211_ops {
 	int	(*set_mcast_rate)(struct wiphy *wiphy, struct net_device *dev,
 				  int rate[NUM_NL80211_BANDS]);
 
-	int	(*set_wiphy_params)(struct wiphy *wiphy, u32 changed);
+	int	(*set_wiphy_params)(struct wiphy *wiphy, s8 radio_id, u32 changed);
 
 	int	(*set_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				enum nl80211_tx_power_setting type, int mbm);
@@ -5472,6 +5472,18 @@ struct wiphy_iftype_akm_suites {
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
@@ -5729,6 +5741,10 @@ struct wiphy_radio {
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
@@ -5816,6 +5832,8 @@ struct wiphy {
 	void (*reg_notifier)(struct wiphy *wiphy,
 			     struct regulatory_request *request);
 
+	struct wiphy_radio_cfg *radio_cfg;
+
 	/* fields below are read-only, assigned by cfg80211 */
 
 	const struct ieee80211_regdomain __rcu *regd;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ddcc4cda74af..e3dff8657487 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2899,6 +2899,14 @@ enum nl80211_commands {
  *	APs Support". Drivers may set additional flags that they support
  *	in the kernel or device.
  *
+ * @NL80211_ATTR_WIPHY_RADIO_INDEX: (s8) Integer attribute denoting the index
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
@@ -3498,6 +3508,7 @@ enum nl80211_attrs {
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
 
 #define NL80211_WIPHY_NAME_MAXLEN		64
+#define NL80211_WIPHY_RADIO_ID_DEFAULT		-1
 
 #define NL80211_MAX_SUPP_RATES			32
 #define NL80211_MAX_SUPP_SELECTORS		128
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9f683f838431..89f62cd52fae 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3008,7 +3008,7 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int ieee80211_set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u32 changed)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	int err;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9e6b31903121..de88afb6ebe3 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -995,6 +995,23 @@ int wiphy_register(struct wiphy *wiphy)
 		 wiphy->max_num_akm_suites > CFG80211_MAX_NUM_AKM_SUITES)
 		return -EINVAL;
 
+	/* Allocate radio configuration space for multi-radio wiphy
+	 */
+	if (wiphy->n_radio > 0) {
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
 	/* check and set up bitrates */
 	ieee80211_set_bitrate_flags(wiphy);
 
@@ -1185,6 +1202,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cfg80211_rdev_free_wowlan(rdev);
 	cfg80211_free_coalesce(rdev->coalesce);
 	rdev->coalesce = NULL;
+	kfree(wiphy->radio_cfg);
 }
 EXPORT_SYMBOL(wiphy_unregister);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f039a7d0d6f7..a929a0212a1e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -851,6 +851,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
 	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
 	[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
+	[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_S8 },
 };
 
 /* policy for the key attributes */
@@ -3614,6 +3615,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *nl_txq_params;
 	u32 changed;
 	u8 retry_short = 0, retry_long = 0;
+	s8 radio_id = NL80211_WIPHY_RADIO_ID_DEFAULT;
 	u32 frag_threshold = 0, rts_threshold = 0;
 	u8 coverage_class = 0;
 	u32 txq_limit = 0, txq_memory_limit = 0, txq_quantum = 0;
@@ -3667,6 +3669,16 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (result)
 		return result;
 
+	if (info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]) {
+		/* Radio idx is not expected for non-multi radio wiphy */
+		if (rdev->wiphy.n_radio <= 0)
+			return -EINVAL;
+
+		radio_id = nla_get_s8(info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]);
+		if (radio_id >= rdev->wiphy.n_radio || radio_id < 0)
+			return -EINVAL;
+	}
+
 	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
 		struct ieee80211_txq_params txq_params;
 		struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
@@ -3875,50 +3887,79 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 
 	if (changed) {
 		u8 old_retry_short, old_retry_long;
-		u32 old_frag_threshold, old_rts_threshold;
-		u8 old_coverage_class;
+		u32 old_frag_threshold, old_rts_threshold, *old_radio_rts_threshold;
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
+		old_radio_rts_threshold = kcalloc(rdev->wiphy.n_radio, sizeof(u32),
+						  GFP_KERNEL);
+
+		if (radio_id < rdev->wiphy.n_radio && radio_id >= 0) {
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
+		} else if (radio_id < 0) {
+			old_retry_short = rdev->wiphy.retry_short;
+			old_retry_long = rdev->wiphy.retry_long;
+			old_frag_threshold = rdev->wiphy.frag_threshold;
+			old_rts_threshold = rdev->wiphy.rts_threshold;
+			for (i = 0 ; i < rdev->wiphy.n_radio; i++)
+				old_radio_rts_threshold[i] =
+					rdev->wiphy.radio_cfg[i].rts_threshold;
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
+			if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
+				rdev->wiphy.rts_threshold = rts_threshold;
+				for (i = 0 ; i < rdev->wiphy.n_radio; i++)
+					rdev->wiphy.radio_cfg[i].rts_threshold =
+						rdev->wiphy.rts_threshold;
+			}
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
+				for (i = 0 ; i < rdev->wiphy.n_radio; i++)
+					rdev->wiphy.radio_cfg[i].rts_threshold =
+						old_radio_rts_threshold[i];
+				rdev->wiphy.coverage_class = old_coverage_class;
+				rdev->wiphy.txq_limit = old_txq_limit;
+				rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
+				rdev->wiphy.txq_quantum = old_txq_quantum;
+				return result;
+			}
+		} else {
+			return -EOPNOTSUPP;
 		}
 	}
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 9f4783c2354c..61ef552425b9 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -577,13 +577,13 @@ static inline int rdev_leave_ibss(struct cfg80211_registered_device *rdev,
 }
 
 static inline int
-rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u32 changed)
+rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, s8 radio_id, u32 changed)
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
index 4ed9fada4ec0..633b253d502d 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1678,10 +1678,11 @@ TRACE_EVENT(rdev_join_ocb,
 );
 
 TRACE_EVENT(rdev_set_wiphy_params,
-	TP_PROTO(struct wiphy *wiphy, u32 changed),
-	TP_ARGS(wiphy, changed),
+	TP_PROTO(struct wiphy *wiphy, s8 radio_id, u32 changed),
+	TP_ARGS(wiphy, radio_id, changed),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
+		__field(s8, radio_id)
 		__field(u32, changed)
 	),
 	TP_fast_assign(
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a74b1afc594e..b4bae7c4dc1b 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -263,7 +263,8 @@ int cfg80211_wext_siwrts(struct net_device *dev,
 	else
 		wdev->wiphy->rts_threshold = rts->value;
 
-	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_RTS_THRESHOLD);
+	err = rdev_set_wiphy_params(rdev, NL80211_WIPHY_RADIO_ID_DEFAULT,
+				    WIPHY_PARAM_RTS_THRESHOLD);
 	if (err)
 		wdev->wiphy->rts_threshold = orts;
 	return err;
@@ -304,7 +305,8 @@ int cfg80211_wext_siwfrag(struct net_device *dev,
 		wdev->wiphy->frag_threshold = frag->value & ~0x1;
 	}
 
-	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_FRAG_THRESHOLD);
+	err = rdev_set_wiphy_params(rdev, NL80211_WIPHY_RADIO_ID_DEFAULT,
+				    WIPHY_PARAM_FRAG_THRESHOLD);
 	if (err)
 		wdev->wiphy->frag_threshold = ofrag;
 	return err;
@@ -355,7 +357,8 @@ static int cfg80211_wext_siwretry(struct net_device *dev,
 		changed |= WIPHY_PARAM_RETRY_SHORT;
 	}
 
-	err = rdev_set_wiphy_params(rdev, changed);
+	err = rdev_set_wiphy_params(rdev, NL80211_WIPHY_RADIO_ID_DEFAULT,
+				    changed);
 	if (err) {
 		wdev->wiphy->retry_short = oshort;
 		wdev->wiphy->retry_long = olong;
-- 
2.17.1


