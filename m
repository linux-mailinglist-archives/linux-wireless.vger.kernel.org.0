Return-Path: <linux-wireless+bounces-15681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411059D7CF2
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 09:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DC0B21142
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB97376;
	Mon, 25 Nov 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KQzpjqyL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3C1537D7
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523573; cv=none; b=vAycbYXCn3PPr8/Ota0N7EhNXK1oL7Lkf1NlaZZHMgU4Lu2z/lV0Js5vmuHOMpUGkT+Xj55+UJyiQPF20v+yjl80/udMssA3VYE21RfyLE/dTdgbBGCKhrKN2FjwoHMxspmjOOCM08H3dGMwh/TIbWI5TVgEqQDTgp5MRAvNFAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523573; c=relaxed/simple;
	bh=DHMRsUfWh7OLzpydDhhJPywaLHaJt9j6/7i55cXa6aE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkkG4gTBi94IY0DkkYnMBg9tlsSCRm0u3BxtBbMa9KNZ43uzbYOTghps43bYk4jrUr4M7VwqF5ZiPxw1qAjTKF73psSuGqppnBykF6xtAVww4UQq7ev//ce+MrTDQus90ekuHCcZbY6K4GByK1IkZbW+UWmOXnS5pBZgGN3/2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KQzpjqyL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AONoHle015900;
	Mon, 25 Nov 2024 08:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F0ngjll7Dx3Pxv9nNGBtWL+Dt3jgYd2WSvuJCGWHnGA=; b=KQzpjqyLTvEecQ8h
	zChf/D2or/bU8ugkpQbagVbQvaML8o8oK19f2T4DyTzjfCtkKSPC8JN0qcPZSTy5
	XHA48fRwf9xqJPLLnbk8NaCalLj7s3AjtctWyAXrt6lKCdUanxIAAXvCYRdRWZLP
	fgQ8Z6gecc0bS4SyrJLR5trErJoRyS7nCxJ0K+nckEi9zFyEAExGzwiGLbJouKpc
	saiu7hUZ0otLE81cxk9fquen69zcCTBB1oAwpnQ/huZ1fczHCMjdQvcmiuWNUij8
	HS+FULPXrTDRBkL9UdCAkRY408g8vMbWIRMXVDY7eB2oZCcFZb80DTvCSB9BbN62
	mBwjfw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4337tjbuk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 08:32:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP8WkYE020873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 08:32:46 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 25 Nov 2024 00:32:44 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH 1/2] wifi: cfg80211: send MLO links tx power info in GET_INTERFACE
Date: Mon, 25 Nov 2024 14:02:16 +0530
Message-ID: <20241125083217.216095-2-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125083217.216095-1-quic_ramess@quicinc.com>
References: <20241125083217.216095-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xoRbVxISJRN3Ob4vbHT5TvlMYS6Ccic4
X-Proofpoint-ORIG-GUID: xoRbVxISJRN3Ob4vbHT5TvlMYS6Ccic4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250072

Currently, TX power is reported on interface/wdev level as
part of NL80211_CMD_GET_INTERFACE. With MLO, Multiple links
can be part of an interface/wdev and hence its necessary to
report the TX power of each link.

Add support to send tx power for all valid links of an MLD as
part of NL80211_CMD_GET_INTERFACE request.

As far as userspace is concerned, there is no behavioral change
for Non-ML Interfaces. For ML interfaces, userspace should fetch
TX power that is nested inside NL80211_ATTR_MLO_LINKS, similar to
how channel info(NL80211_ATTR_WIPHY_FREQ) is fetched.

Co-developed-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  2 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  3 +-
 include/net/cfg80211.h                        |  2 +-
 net/mac80211/cfg.c                            |  1 +
 net/wireless/nl80211.c                        | 13 +++++-
 net/wireless/rdev-ops.h                       |  7 +--
 net/wireless/trace.h                          | 44 +++++++++----------
 net/wireless/wext-compat.c                    |  2 +-
 12 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 61b2e3f15f0e..72ce321f2a77 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1441,6 +1441,7 @@ static int ath6kl_cfg80211_set_txpower(struct wiphy *wiphy,
 
 static int ath6kl_cfg80211_get_txpower(struct wiphy *wiphy,
 				       struct wireless_dev *wdev,
+				       unsigned int link_id,
 				       int *dbm)
 {
 	struct ath6kl *ar = (struct ath6kl *)wiphy_priv(wiphy);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 297a7c738c01..689e779fe00f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2676,7 +2676,7 @@ brcmf_cfg80211_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 static s32
 brcmf_cfg80211_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			    s32 *dbm)
+			    unsigned int link_id, s32 *dbm)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_cfg80211_vif *vif = wdev_to_vif(wdev);
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index fca3eea7ee84..a099fdaafa45 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -410,7 +410,7 @@ mwifiex_cfg80211_set_tx_power(struct wiphy *wiphy,
 static int
 mwifiex_cfg80211_get_tx_power(struct wiphy *wiphy,
 			      struct wireless_dev *wdev,
-			      int *dbm)
+			      unsigned int link_id, int *dbm)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
 	struct mwifiex_private *priv = mwifiex_get_priv(adapter,
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index e96736cc7259..e7aa0f991923 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1669,7 +1669,7 @@ static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 }
 
 static int get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			int *dbm)
+			unsigned int link_id, int *dbm)
 {
 	int ret;
 	struct wilc_vif *vif = netdev_priv(wdev->netdev);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 8b97accf6638..0b2282528342 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -881,7 +881,7 @@ static int qtnf_set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int qtnf_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			     int *dbm)
+			     unsigned int link_id, int *dbm)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
 	int ret;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index b63a74e669bc..6e3e96358f05 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1812,7 +1812,8 @@ static int cfg80211_rtw_set_txpower(struct wiphy *wiphy,
 }
 
 static int cfg80211_rtw_get_txpower(struct wiphy *wiphy,
-				    struct wireless_dev *wdev, int *dbm)
+				    struct wireless_dev *wdev,
+				    unsigned int link_id, int *dbm)
 {
 	*dbm = (12);
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 27acf1292a5c..feec87c271e1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4733,7 +4733,7 @@ struct cfg80211_ops {
 	int	(*set_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				enum nl80211_tx_power_setting type, int mbm);
 	int	(*get_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
-				int *dbm);
+				unsigned int link_id, int *dbm);
 
 	void	(*rfkill_poll)(struct wiphy *wiphy);
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 61a824ec33da..b2410a913556 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3190,6 +3190,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 
 static int ieee80211_get_tx_power(struct wiphy *wiphy,
 				  struct wireless_dev *wdev,
+				  unsigned int link_id,
 				  int *dbm)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9d2edb71f981..492d18d38ea6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4010,10 +4010,10 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 			goto nla_put_failure;
 	}
 
-	if (rdev->ops->get_tx_power) {
+	if (rdev->ops->get_tx_power && !wdev->valid_links) {
 		int dbm, ret;
 
-		ret = rdev_get_tx_power(rdev, wdev, &dbm);
+		ret = rdev_get_tx_power(rdev, wdev, 0, &dbm);
 		if (ret == 0 &&
 		    nla_put_u32(msg, NL80211_ATTR_WIPHY_TX_POWER_LEVEL,
 				DBM_TO_MBM(dbm)))
@@ -4082,6 +4082,15 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 			if (ret == 0 && nl80211_send_chandef(msg, &chandef))
 				goto nla_put_failure;
 
+			if (rdev->ops->get_tx_power) {
+				int dbm, ret;
+
+				ret = rdev_get_tx_power(rdev, wdev, link_id, &dbm);
+				if (ret == 0 &&
+				    nla_put_u32(msg, NL80211_ATTR_WIPHY_TX_POWER_LEVEL,
+						DBM_TO_MBM(dbm)))
+					goto nla_put_failure;
+			}
 			nla_nest_end(msg, link);
 		}
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index adb6105bbb7d..8f2aa7e76c0a 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -600,11 +600,12 @@ static inline int rdev_set_tx_power(struct cfg80211_registered_device *rdev,
 }
 
 static inline int rdev_get_tx_power(struct cfg80211_registered_device *rdev,
-				    struct wireless_dev *wdev, int *dbm)
+				    struct wireless_dev *wdev, unsigned int link_id,
+				    int *dbm)
 {
 	int ret;
-	trace_rdev_get_tx_power(&rdev->wiphy, wdev);
-	ret = rdev->ops->get_tx_power(&rdev->wiphy, wdev, dbm);
+	trace_rdev_get_tx_power(&rdev->wiphy, wdev, link_id);
+	ret = rdev->ops->get_tx_power(&rdev->wiphy, wdev, link_id, dbm);
 	trace_rdev_return_int_int(&rdev->wiphy, ret, *dbm);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index d5c9bb614fa6..a57210c8087c 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1690,9 +1690,28 @@ TRACE_EVENT(rdev_set_wiphy_params,
 		  WIPHY_PR_ARG, __entry->changed)
 );
 
-DEFINE_EVENT(wiphy_wdev_evt, rdev_get_tx_power,
-	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
-	TP_ARGS(wiphy, wdev)
+DECLARE_EVENT_CLASS(wiphy_wdev_link_evt,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+		 unsigned int link_id),
+	TP_ARGS(wiphy, wdev, link_id),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+		__field(unsigned int, link_id)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+		__entry->link_id = link_id;
+	),
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", link_id: %u",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id)
+);
+
+DEFINE_EVENT(wiphy_wdev_link_evt, rdev_get_tx_power,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+		 unsigned int link_id),
+	TP_ARGS(wiphy, wdev, link_id)
 );
 
 TRACE_EVENT(rdev_set_tx_power,
@@ -2192,25 +2211,6 @@ TRACE_EVENT(rdev_set_noack_map,
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", noack_map: %u",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->noack_map)
 );
-
-DECLARE_EVENT_CLASS(wiphy_wdev_link_evt,
-	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
-		 unsigned int link_id),
-	TP_ARGS(wiphy, wdev, link_id),
-	TP_STRUCT__entry(
-		WIPHY_ENTRY
-		WDEV_ENTRY
-		__field(unsigned int, link_id)
-	),
-	TP_fast_assign(
-		WIPHY_ASSIGN;
-		WDEV_ASSIGN;
-		__entry->link_id = link_id;
-	),
-	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", link_id: %u",
-		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id)
-);
-
 DEFINE_EVENT(wiphy_wdev_link_evt, rdev_get_channel,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 unsigned int link_id),
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 90d5c0592667..77b4ebe66256 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -966,7 +966,7 @@ static int cfg80211_wext_giwtxpower(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	wiphy_lock(&rdev->wiphy);
-	err = rdev_get_tx_power(rdev, wdev, &val);
+	err = rdev_get_tx_power(rdev, wdev, 0, &val);
 	wiphy_unlock(&rdev->wiphy);
 	if (err)
 		return err;
-- 
2.34.1


