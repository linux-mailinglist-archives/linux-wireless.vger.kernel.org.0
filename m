Return-Path: <linux-wireless+bounces-18154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14501A220EE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 16:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285863A6399
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA418224EA;
	Wed, 29 Jan 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZrAfZSdI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5D14830F
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166000; cv=none; b=WbqcsBLXQ58KX8wZlKdlkOXgbePk4z4/b9gThNqCN86IB81jwcMHKY1CkxJ9E2IyZk/zfc1sPZdHRU55N+qpVFovq0rYVmrm318uLhW2W7x7UYK/y2GUFYUp0XcrqQZK0Ip0RlNRf7bRd6MXb093lfIlM549zTp0DlspdxMSB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166000; c=relaxed/simple;
	bh=PXPQ06GojbI4/IbWkH3yCwqZf477s5nQK4TzT3JJa1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcZDrgMGXNR85igPkhOT2PinJF6gmJJTHo0HYdOP0iAT/k+YCiZidg3akjOqiYpupkyNNqPkkJjGDFWq3oYf3VDPR51JtqMnB8qivrChp1wxlBsal4m2fol8oKpRKW3oqkunxZ4VwbtsCba24J7LCjBiz9xbOxCpJtZ2qfj+LKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZrAfZSdI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFac4B028317;
	Wed, 29 Jan 2025 15:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S9U+j2p2mgFbwjVQs7NPRFKq2EpD3f4LAfCrggylHss=; b=ZrAfZSdIgg0Bmozx
	Egkf1RB2fcIV4+xjQWRuaBl1q0vI549h+7dISY3Tmx4FlrkP7amCXmsAsYpcGp7A
	8Qox5wOw2PE8ifn7KR3//xS6k+hYbWMzCnGNmk1xkGb3njRdhVpGhEZGgyfMS/JN
	wcVuordXET6Gl5F6vrahe1KVHGTkrmDRqqEXeugIjFunfKu4P3eqxosxtO09q9LI
	iq2MeXHXvxtqjS6CfXMGLMUhMAWKEX4rD5jCvz/JzdPUIp1WSc3EEd2GoY+pO0aY
	N96VK3QCFesXQpMLAPy75pbnhQNE2uh1O4eRWntuEQA1GV2DGjSw1Yug+FNwX5DU
	yrfXMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fq4gg1k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TFrCk2029146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:12 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 07:53:10 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v4 4/5] wifi: cfg80211: set tx power per radio in a wiphy
Date: Wed, 29 Jan 2025 21:22:45 +0530
Message-ID: <20250129155246.155587-5-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: WIlyR89jkoHXMKN06YoBOCIaKOI7EzHw
X-Proofpoint-GUID: WIlyR89jkoHXMKN06YoBOCIaKOI7EzHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501290128

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

A wiphy can have multiple radios(wiphy.n_radio) combined in it
and each radio is identified by radio index (radio_id).
When set tx power is done without a valid wdev then it is
a radio level configuration but currently it is being considered at
wiphy level since radio identifier is not present in nl80211_set_wiphy().

Pass the radio id that is obtained via NL80211_ATTR_WIPHY_RADIO_INDEX as an
argument to set_tx_power op to indicate the underlying drivers about the
radio of the wiphy to which the configuration should be applied.

When NL80211_ATTR_WIPHY_RADIO_INDEX is not passed or the wiphy is a
non-multi radio wiphy, radio id value of NL80211_WIPHY_RADIO_ID_MAX(255)
is passed in which case drivers should apply the configuration to all
radios.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c            |  1 +
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   |  2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c       |  2 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c    |  2 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c     |  2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c     |  2 +-
 include/net/cfg80211.h                                |  2 +-
 net/mac80211/cfg.c                                    |  2 +-
 net/wireless/nl80211.c                                |  2 +-
 net/wireless/rdev-ops.h                               |  6 +++---
 net/wireless/trace.h                                  | 11 +++++++----
 net/wireless/wext-compat.c                            |  3 ++-
 12 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 120dbd66ea11..bf23daec8662 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1405,6 +1405,7 @@ static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u3
 
 static int ath6kl_cfg80211_set_txpower(struct wiphy *wiphy,
 				       struct wireless_dev *wdev,
+				       u8 radio_id,
 				       enum nl80211_tx_power_setting type,
 				       int mbm)
 {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 418b9dadb039..6a7c4c06585c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2628,7 +2628,7 @@ brcmf_cfg80211_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static s32
-brcmf_cfg80211_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+brcmf_cfg80211_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev, u8 radio_id,
 			    enum nl80211_tx_power_setting type, s32 mbm)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 8f1929ee2a92..a6ae8011f14b 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -374,7 +374,7 @@ mwifiex_cfg80211_cancel_remain_on_channel(struct wiphy *wiphy,
  */
 static int
 mwifiex_cfg80211_set_tx_power(struct wiphy *wiphy,
-			      struct wireless_dev *wdev,
+			      struct wireless_dev *wdev, u8 radio_id,
 			      enum nl80211_tx_power_setting type,
 			      int mbm)
 {
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 2de0834d76cd..b8b5ec062c3a 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1636,7 +1636,7 @@ static void wilc_set_wakeup(struct wiphy *wiphy, bool enabled)
 	srcu_read_unlock(&wl->srcu, srcu_idx);
 }
 
-static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev, u8 radio_id,
 			enum nl80211_tx_power_setting type, int mbm)
 {
 	int ret;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index e4ba386f6265..7c1a378726fc 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -894,7 +894,7 @@ static int qtnf_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 }
 
 static int qtnf_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			     enum nl80211_tx_power_setting type, int mbm)
+			     u8 radio_id, enum nl80211_tx_power_setting type, int mbm)
 {
 	struct qtnf_vif *vif;
 	int ret;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index c7458bf9a7f1..eddea77b9cec 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1795,7 +1795,7 @@ static int cfg80211_rtw_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int cfg80211_rtw_set_txpower(struct wiphy *wiphy,
-				    struct wireless_dev *wdev,
+				    struct wireless_dev *wdev, u8 radio_id,
 				    enum nl80211_tx_power_setting type, int mbm)
 {
 	return 0;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9cbce47fcea6..24e5d7cfb9e5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4753,7 +4753,7 @@ struct cfg80211_ops {
 	int	(*set_wiphy_params)(struct wiphy *wiphy, u8 radio_id, u32 changed);
 
 	int	(*set_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
-				enum nl80211_tx_power_setting type, int mbm);
+				u8 radio_id, enum nl80211_tx_power_setting type, int mbm);
 	int	(*get_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				unsigned int link_id, int *dbm);
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index bd121815bd93..f86350b3a668 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3073,7 +3073,7 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 chan
 }
 
 static int ieee80211_set_tx_power(struct wiphy *wiphy,
-				  struct wireless_dev *wdev,
+				  struct wireless_dev *wdev, u8 radio_id,
 				  enum nl80211_tx_power_setting type, int mbm)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b5ca793eb853..69a366e5ca0f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3766,7 +3766,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			mbm = nla_get_u32(info->attrs[idx]);
 		}
 
-		result = rdev_set_tx_power(rdev, txp_wdev, type, mbm);
+		result = rdev_set_tx_power(rdev, txp_wdev, radio_id, type, mbm);
 		if (result)
 			return result;
 	}
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 0b4185013fb2..c22a458e8158 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -589,12 +589,12 @@ rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u8 radio_id, u32
 }
 
 static inline int rdev_set_tx_power(struct cfg80211_registered_device *rdev,
-				    struct wireless_dev *wdev,
+				    struct wireless_dev *wdev, u8 radio_id,
 				    enum nl80211_tx_power_setting type, int mbm)
 {
 	int ret;
-	trace_rdev_set_tx_power(&rdev->wiphy, wdev, type, mbm);
-	ret = rdev->ops->set_tx_power(&rdev->wiphy, wdev, type, mbm);
+	trace_rdev_set_tx_power(&rdev->wiphy, wdev, radio_id, type, mbm);
+	ret = rdev->ops->set_tx_power(&rdev->wiphy, wdev, radio_id, type, mbm);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 5fd600f54e0a..98ec4f3e8ec7 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1716,23 +1716,26 @@ DEFINE_EVENT(wiphy_wdev_link_evt, rdev_get_tx_power,
 );
 
 TRACE_EVENT(rdev_set_tx_power,
-	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 radio_id,
 		 enum nl80211_tx_power_setting type, int mbm),
-	TP_ARGS(wiphy, wdev, type, mbm),
+	TP_ARGS(wiphy, wdev, radio_id, type, mbm),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		WDEV_ENTRY
+		__field(u8, radio_id)
 		__field(enum nl80211_tx_power_setting, type)
 		__field(int, mbm)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		WDEV_ASSIGN;
+		__entry->radio_id = radio_id;
 		__entry->type = type;
 		__entry->mbm = mbm;
 	),
-	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", type: %u, mbm: %d",
-		  WIPHY_PR_ARG, WDEV_PR_ARG,__entry->type, __entry->mbm)
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", radio_id: %u, type: %u, mbm: %d",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->radio_id, __entry->type,
+		  __entry->mbm)
 );
 
 TRACE_EVENT(rdev_return_int_int,
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index fd4a4112610e..3f1112fa56e8 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -892,7 +892,8 @@ static int cfg80211_wext_siwtxpower(struct net_device *dev,
 
 	guard(wiphy)(&rdev->wiphy);
 
-	return rdev_set_tx_power(rdev, wdev, type, DBM_TO_MBM(dbm));
+	return rdev_set_tx_power(rdev, wdev, NL80211_WIPHY_RADIO_ID_MAX, type,
+				 DBM_TO_MBM(dbm));
 }
 
 static int cfg80211_wext_giwtxpower(struct net_device *dev,
-- 
2.17.1


