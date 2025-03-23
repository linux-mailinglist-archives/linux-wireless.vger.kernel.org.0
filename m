Return-Path: <linux-wireless+bounces-20711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A03EA6CE4C
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 08:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9B016D7F8
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854721FFC4F;
	Sun, 23 Mar 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gmVfhIMz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42361F91C8
	for <linux-wireless@vger.kernel.org>; Sun, 23 Mar 2025 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742715657; cv=none; b=EvGCl935WwtdaAQ8ZhwTEgD/GZfZ5R/QmDfiWoCDMXYSDY4UyVe41IOPCbGGonkF9vqj1/evENpo8cqKJQVSLWRq0umC5gN0c/bsdnuuRysQMrgyo0uxzVlcG49Sx16rez/0/yDyc3UueMAycbwi7ILJQcIbqlLsK5FDpp/RoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742715657; c=relaxed/simple;
	bh=6QHxrdEIHUlsMExBA1RZ2JWeTt87E8DYjSsVgHyx0kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3Z9OrHGmBJ7K9+hglBmMvpC41eNfunzraWRzNvR6ZIWEwTzjyFCaKrqd1902QTGxu5WI9DLtSmtrYDPq2KWyPbx2I1nZ+hWiuq0xiWGZWsoKEdlq8Phk8D/NnWVf6Qrp2UYB9+/gyDpQbZh9qRhgwr+vJdx7vsATseMQlqXNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gmVfhIMz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N5PbYM003186;
	Sun, 23 Mar 2025 07:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B22kJo2s2BbCK8d4yxq3TerRZMi55wN6ImI9oEHLxDQ=; b=gmVfhIMzeV+ITlR0
	bQYAJ7EQ4ehTl20VlGl3LusFVv5ClKTTaWRWcAB4Tre/m7Vse9taiwWpO4Q1JJZ8
	ZnETtI1ckZkLMEBaR5uew/O+KV0Um/fGEuZSf8O1av8+KLHDvIqxuZ3Q17FSfwfx
	6kLGxvC29jiqRL09CIJJ/AqwqfrP0vfcA5chg9W8sZuyvDnnW/YZd8hoYiVVuw1g
	TIwHwIRBFWVy+PcKhubLX/yVLm1pb52g04Cucoy75rDOq/A0cOZ+UVk4r/aVEoBW
	38zfNeiZDd1ABDbDKKMhHWI4/y5NfWGk4dK/CWdZQRAx1qRKEoYpm6RoTUzLwMVZ
	U1oUBQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjwhhx0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 07:40:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52N7eebI022878
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 07:40:40 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Mar 2025 00:40:38 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v5 4/5] wifi: cfg80211: set tx power per radio in a wiphy
Date: Sun, 23 Mar 2025 13:09:58 +0530
Message-ID: <20250323073959.2872641-5-quic_rdevanat@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=H+jbw/Yi c=1 sm=1 tr=0 ts=67dfbaf8 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=A-QFA3xcsBRlAwhpde8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: SP_FB-56oKVWJ1GDfzHbGO3g-BXg44po
X-Proofpoint-ORIG-GUID: SP_FB-56oKVWJ1GDfzHbGO3g-BXg44po
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230057

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
non-multi radio wiphy, radio id value of NL80211_WIPHY_RADIO_ID_DEFAULT(-1)
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
index ceb816035c02..19129acfadb9 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1405,6 +1405,7 @@ static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u3
 
 static int ath6kl_cfg80211_set_txpower(struct wiphy *wiphy,
 				       struct wireless_dev *wdev,
+				       s8 radio_id,
 				       enum nl80211_tx_power_setting type,
 				       int mbm)
 {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 1bb778fceb69..6cc779782c77 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2628,7 +2628,7 @@ brcmf_cfg80211_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static s32
-brcmf_cfg80211_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+brcmf_cfg80211_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev, s8 radio_id,
 			    enum nl80211_tx_power_setting type, s32 mbm)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index aa222bd7b73c..61365a8f0974 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -374,7 +374,7 @@ mwifiex_cfg80211_cancel_remain_on_channel(struct wiphy *wiphy,
  */
 static int
 mwifiex_cfg80211_set_tx_power(struct wiphy *wiphy,
-			      struct wireless_dev *wdev,
+			      struct wireless_dev *wdev, s8 radio_id,
 			      enum nl80211_tx_power_setting type,
 			      int mbm)
 {
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index b97ecec73f29..a9d6ec88a045 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1636,7 +1636,7 @@ static void wilc_set_wakeup(struct wiphy *wiphy, bool enabled)
 	srcu_read_unlock(&wl->srcu, srcu_idx);
 }
 
-static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev, s8 radio_id,
 			enum nl80211_tx_power_setting type, int mbm)
 {
 	int ret;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index c8f30b84e36d..6615b8724c91 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -894,7 +894,7 @@ static int qtnf_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 }
 
 static int qtnf_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			     enum nl80211_tx_power_setting type, int mbm)
+			     s8 radio_id, enum nl80211_tx_power_setting type, int mbm)
 {
 	struct qtnf_vif *vif;
 	int ret;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index db9e7b4ddc09..0af6a7334b68 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1795,7 +1795,7 @@ static int cfg80211_rtw_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int cfg80211_rtw_set_txpower(struct wiphy *wiphy,
-				    struct wireless_dev *wdev,
+				    struct wireless_dev *wdev, s8 radio_id,
 				    enum nl80211_tx_power_setting type, int mbm)
 {
 	return 0;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a3ac72355274..d0003ef18f0a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4785,7 +4785,7 @@ struct cfg80211_ops {
 	int	(*set_wiphy_params)(struct wiphy *wiphy, s8 radio_id, u32 changed);
 
 	int	(*set_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
-				enum nl80211_tx_power_setting type, int mbm);
+				s8 radio_id, enum nl80211_tx_power_setting type, int mbm);
 	int	(*get_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				unsigned int link_id, int *dbm);
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5413f472d6d6..b6676ebdcddd 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3074,7 +3074,7 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u32 chan
 }
 
 static int ieee80211_set_tx_power(struct wiphy *wiphy,
-				  struct wireless_dev *wdev,
+				  struct wireless_dev *wdev, s8 radio_id,
 				  enum nl80211_tx_power_setting type, int mbm)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cb03545ddd70..ce8b02886ce3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3775,7 +3775,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			mbm = nla_get_u32(info->attrs[idx]);
 		}
 
-		result = rdev_set_tx_power(rdev, txp_wdev, type, mbm);
+		result = rdev_set_tx_power(rdev, txp_wdev, radio_id, type, mbm);
 		if (result)
 			return result;
 	}
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 61ef552425b9..01229ec1cc78 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -589,12 +589,12 @@ rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, s8 radio_id, u32
 }
 
 static inline int rdev_set_tx_power(struct cfg80211_registered_device *rdev,
-				    struct wireless_dev *wdev,
+				    struct wireless_dev *wdev, s8 radio_id,
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
index 633b253d502d..1d615a3e42aa 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1718,23 +1718,26 @@ DEFINE_EVENT(wiphy_wdev_link_evt, rdev_get_tx_power,
 );
 
 TRACE_EVENT(rdev_set_tx_power,
-	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, s8 radio_id,
 		 enum nl80211_tx_power_setting type, int mbm),
-	TP_ARGS(wiphy, wdev, type, mbm),
+	TP_ARGS(wiphy, wdev, radio_id, type, mbm),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		WDEV_ENTRY
+		__field(s8, radio_id)
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
index b4bae7c4dc1b..6cdf0c37377d 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -893,7 +893,8 @@ static int cfg80211_wext_siwtxpower(struct net_device *dev,
 
 	guard(wiphy)(&rdev->wiphy);
 
-	return rdev_set_tx_power(rdev, wdev, type, DBM_TO_MBM(dbm));
+	return rdev_set_tx_power(rdev, wdev, NL80211_WIPHY_RADIO_ID_DEFAULT, type,
+				 DBM_TO_MBM(dbm));
 }
 
 static int cfg80211_wext_giwtxpower(struct net_device *dev,
-- 
2.25.1


