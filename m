Return-Path: <linux-wireless+bounces-17165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FE5A04931
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 19:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A327A2A98
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667B1B4F0E;
	Tue,  7 Jan 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ORaCAtjk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDD81F37CF
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274434; cv=none; b=qq8UfMf3dKUYKy4B8haocmwPJtWN8G3dnFpDtGrWSTMPvwWNJiJnR23hnKYbLH0k0qLCSwTvd3jL8tgdUe9v4f5HPulICdXKk/RsE0U21kcJ0ioYf9iyRnYjMll/hTyDyckVFDxe6ka6Bu8KL0oP60Rke8CrLT2xqNgrXammDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274434; c=relaxed/simple;
	bh=E3Ke9SdT4ePvcX2H1Xc540vLe/LlB5X1JSYh2wMjfrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aye5tfx1mZT+1F1Gnd+O3BvSL19c4Xlghha0tMEMB31mrTl96VopheVvbssUS1LhnLGAHEn9mORJ3hAR8As+I+13pkmuYkUP0dtc0T3ptZsfgXZ/ZS2Hm4av67ZWSCBgR/eF8g9Gmzc1shuqS3d8kN0/l62fsMU1IF8SYWiddOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ORaCAtjk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5079olE6003529;
	Tue, 7 Jan 2025 18:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wRGXKl7kdq44S9Q3tcc5/EjyGasCoGVwHf45Xxc3guM=; b=ORaCAtjkAMs+KU8o
	P8bgCPWRx8emHW4wn5RkF4eMxCk9Zll9cCsDLhT3QY1FQR9Yq6V4t+Rb9Ud+M6B2
	G2wHvWQJ33ZMwllvd1f+Bu/TUObeAbDIoyyuqOZlr83QIEu6TYaVgkYbNn2mgwQ3
	1tSbkD9o35iAXEtv1nq4RbT6ul2UHwC+4QbsNV3Bf1xBXgRq6DxJK6u8M+ZA8LKQ
	Bodl1hbJH9Jotf20rNjahLx1H+X4eV/Dkm+khfzqnbnEoLcrtvcs5TWLSrJRTWHL
	9oi+1OZuBYqqk2ZOUS9qv+QDsokWv28tw8mSDSbFUMJSC0d6XAF80UHT4R66tjsA
	h18Lhw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4412091a0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 18:27:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507IR3mn022020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 18:27:03 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 10:27:01 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH RFC 4/5] wifi: cfg80211: set tx power per radio in a wiphy
Date: Tue, 7 Jan 2025 23:55:05 +0530
Message-ID: <20250107182506.1838704-5-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: pR441JO3krBt8tKvKVeCfOw8RvOGRY9v
X-Proofpoint-ORIG-GUID: pR441JO3krBt8tKvKVeCfOw8RvOGRY9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070152

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
index 2df5e3d3cc84..0e4456563316 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2624,7 +2624,7 @@ brcmf_cfg80211_disconnect(struct wiphy *wiphy, struct net_device *ndev,
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
index 101975509247..a3bf7bc91532 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4731,7 +4731,7 @@ struct cfg80211_ops {
 	int	(*set_wiphy_params)(struct wiphy *wiphy, u8 radio_id, u32 changed);
 
 	int	(*set_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
-				enum nl80211_tx_power_setting type, int mbm);
+				u8 radio_id, enum nl80211_tx_power_setting type, int mbm);
 	int	(*get_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				unsigned int link_id, int *dbm);
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e2125ce42fb5..da9ac9998926 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3068,7 +3068,7 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 chan
 }
 
 static int ieee80211_set_tx_power(struct wiphy *wiphy,
-				  struct wireless_dev *wdev,
+				  struct wireless_dev *wdev, u8 radio_id,
 				  enum nl80211_tx_power_setting type, int mbm)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7cf6597b4c18..f74ac312b0c9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3758,7 +3758,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			mbm = nla_get_u32(info->attrs[idx]);
 		}
 
-		result = rdev_set_tx_power(rdev, txp_wdev, type, mbm);
+		result = rdev_set_tx_power(rdev, txp_wdev, radio_id, type, mbm);
 		if (result)
 			return result;
 	}
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index cc06db496e5d..2e3369d95bbf 100644
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
index 7bf91c6d3d81..f260fcd96b9a 100644
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
2.34.1


