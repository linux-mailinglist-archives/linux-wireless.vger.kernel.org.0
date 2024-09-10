Return-Path: <linux-wireless+bounces-12773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87197443F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 22:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9F3289285
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8681A76DF;
	Tue, 10 Sep 2024 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dwnPBlHM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7C1A7058
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001163; cv=none; b=Q33vVgkgdMl13JefC1SE6lBIdnVE98YIu6f7YMHImGaolDSG/Jdc+emH2RwZe6Uc0KfBJ4D4BvdQUI1Q/5cf3Bc36up4BVSFV3V9CRJAhxZKvG6bxlQWASINDZs6FC4QH81z5X1L4RGLr/6MXvLbtjJs7unZvuxnJVZSW7ou3Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001163; c=relaxed/simple;
	bh=RA2mAHQ8lguiZUh8fHFkka9/3ReIJqfS5DJ8eEKATMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcnZAAOS7/dFLpZ/3nmNfguvwogcLBN+2EldCIcj6y0D3E7iuqd8kOvwKFTr1W73wAdFNo7fjUoCvhJOkY7Fc4TOeh6/WWgTZQF6gPfBcw51yrcwLGflGyH7Zom+7giKZ51wdPPaobNL48a+/7OdEFI7B31GnZPufGPsKVv16CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dwnPBlHM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AEk6Vd019866;
	Tue, 10 Sep 2024 20:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dGMUNPKjHtH7Nw5FDTIWIvwqgZzaa4a9GjywDj6GCSU=; b=dwnPBlHM8C+qqXUD
	8+xth86qSinxRK4IcXm7tn8e8bjINRZBwNpf60ZRGS46wBFXMxE2CXviggpJiUgo
	Z7z5Oi0znU6FJJHTp1YV0gGEle7l7ZAqyll6iYTa+VDCK8AydsC9XCmbC58PPo6p
	PkqHdDA//XBNexhFLwBlN+HG7JwStG5CJtfeDXAf96VMNuYdMtkSxb+OoZxx0VaM
	xiQ+TTlIjXsVym5VyuGt7yGK5yfu3hlpvMihNzZWVYpadkYEt/bKCLxDE67RA7sh
	k2qk3CCc3FG5/EfL6n7VQ6Kjt2F6sLh6w3G5efKz1yJwWLJhVuizFwWeaNCBlzn6
	PkBKfQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy59ycnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 20:45:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48AKjuDF014256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 20:45:56 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Sep 2024 13:45:55 -0700
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada
	<quic_msinada@quicinc.com>
Subject: [PATCH 1/2] wifi: nl80211: add link id of transmitted profile for MLO MBSSID
Date: Tue, 10 Sep 2024 13:45:37 -0700
Message-ID: <20240910204538.4077640-2-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910204538.4077640-1-quic_msinada@quicinc.com>
References: <20240910204538.4077640-1-quic_msinada@quicinc.com>
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
X-Proofpoint-GUID: EgmUn7V4ha2pyh_AmLRI_9KNsb56GBoU
X-Proofpoint-ORIG-GUID: EgmUn7V4ha2pyh_AmLRI_9KNsb56GBoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=925 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100154

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Currently non-transmitted profile provides the interface index of the
transmitted profile. The index matches one of the interface indices
advertised by the kernel.

For MLO MBSSID, if the transmitted profile if part of an MLD, then the
transmitted profile is a specific link of that MLD. Utilizing only Tx
index is no longer sufficient to identify transmitted profile for MLO.

Add a new attribute to specify link id of the transmitted profile of
MBSSID group if the profile is part of an MLD. It is required to map
the nontransmitted link with corresponding transmitted link.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Co-developed-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h |  5 +++++
 net/wireless/nl80211.c       | 29 ++++++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 192d72c8b465..ccdfcb33ba1e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1286,11 +1286,13 @@ struct cfg80211_crypto_settings {
  * struct cfg80211_mbssid_config - AP settings for multi bssid
  *
  * @tx_wdev: pointer to the transmitted interface in the MBSSID set
+ * @tx_link_id: link ID of the transmitted interface if it is part of an MLD.
  * @index: index of this AP in the multi bssid group.
  * @ema: set to true if the beacons should be sent out in EMA mode.
  */
 struct cfg80211_mbssid_config {
 	struct wireless_dev *tx_wdev;
+	int tx_link_id;
 	u8 index;
 	bool ema;
 };
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f97f5adc8d51..6bd46b4998c9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7987,6 +7987,10 @@ enum nl80211_sar_specs_attrs {
  *	Setting this flag is permitted only if the driver advertises EMA support
  *	by setting wiphy->ema_max_profile_periodicity to non-zero.
  *
+ * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Mandatory parameter for a non-transmitted
+ *	profile which provides the link ID (u8) of the transmitted profile when the latter
+ *	is part of an MLD.
+ *
  * @__NL80211_MBSSID_CONFIG_ATTR_LAST: Internal
  * @NL80211_MBSSID_CONFIG_ATTR_MAX: highest attribute
  */
@@ -7998,6 +8002,7 @@ enum nl80211_mbssid_config_attributes {
 	NL80211_MBSSID_CONFIG_ATTR_INDEX,
 	NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX,
 	NL80211_MBSSID_CONFIG_ATTR_EMA,
+	NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID,
 
 	/* keep last */
 	__NL80211_MBSSID_CONFIG_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7397a372c78e..bd168f3d5950 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -454,6 +454,8 @@ nl80211_mbssid_config_policy[NL80211_MBSSID_CONFIG_ATTR_MAX + 1] = {
 	[NL80211_MBSSID_CONFIG_ATTR_INDEX] = { .type = NLA_U8 },
 	[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX] = { .type = NLA_U32 },
 	[NL80211_MBSSID_CONFIG_ATTR_EMA] = { .type = NLA_FLAG },
+	[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID] =
+				NLA_POLICY_MAX(NLA_U8, IEEE80211_MLD_MAX_NUM_LINKS),
 };
 
 static const struct nla_policy
@@ -5477,6 +5479,8 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 				       u8 num_elems)
 {
 	struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
+	struct net_device *tx_netdev = NULL;
+	int err = -EINVAL;
 
 	if (!wiphy->mbssid_max_interfaces)
 		return -EOPNOTSUPP;
@@ -5509,9 +5513,7 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 			return -EINVAL;
 
 		if (tx_ifindex != dev->ifindex) {
-			struct net_device *tx_netdev =
-				dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
-
+			tx_netdev = dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
 			if (!tx_netdev || !tx_netdev->ieee80211_ptr ||
 			    tx_netdev->ieee80211_ptr->wiphy != wiphy ||
 			    tx_netdev->ieee80211_ptr->iftype !=
@@ -5530,7 +5532,28 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
+	config->tx_link_id = 0;
+	if (config->tx_wdev->valid_links) {
+		if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
+			goto err;
+
+		config->tx_link_id = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]);
+		if (!(config->tx_wdev->valid_links & BIT(config->tx_link_id))) {
+			err = -ENOLINK;
+			goto err;
+		}
+	} else if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]) {
+		goto err;
+	}
+
 	return 0;
+
+err:
+	if (tx_netdev) {
+		config->tx_wdev = NULL;
+		dev_put(tx_netdev);
+	}
+	return err;
 }
 
 static struct cfg80211_mbssid_elems *
-- 
2.34.1


