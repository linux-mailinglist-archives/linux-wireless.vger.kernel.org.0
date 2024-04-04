Return-Path: <linux-wireless+bounces-5881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1D1898E77
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 21:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B8128C2AA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AE51327E7;
	Thu,  4 Apr 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RX4DME0B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573013329D
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257239; cv=none; b=P7C4mduBU37YLVZF3cHt+zb8P1SkQO9ebiqi2QbK/aF0P1tXdHWIQDbDApo3ase3YBwzxurfb8GKvLU4GvLrOdVIbMD+gPKl8434y8JFgHVvOIoiM3J5orPVRqqC6kXlCuV91Fe4864HpCIeWHF7btJhniUYvsPcTnd4XXaefuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257239; c=relaxed/simple;
	bh=jUetgPXgtgbCptNKJieNJ12lgqDl41DHjnRa5M3lm1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwnuMqr2lxhYY7ofVViV3hkHA8ck/87MxpcFKAYU97Kr/gWsDXZYkqHItKno1ZEWGz55f1VH2IAJ58CiDxyDQe+82pbBg70MSpcvYRTsoRV/hdKdwfwVA+awyHZb5VPL86sr1Dhh/VKCss61T4BkvJQyW4zweRGEZV+ZQMXHdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RX4DME0B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434G1hqA010062;
	Thu, 4 Apr 2024 19:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mZLwLwEf4B2/Dk0YocTpoZCQ6VRU7vo+Qt3b2b5gaEs=; b=RX
	4DME0BMWOsr7h/5NS0oZ3kvV7QPVSU96mTZh3ThBSjeQIkoqrA9d4fvscL2l7Te+
	0DVp32SzDgFeubBUh5/IZLAi1+4iFYkJ0vTUdf4YEch5d9MytrFuViUqBowkwCop
	UFaZyh99WoIrQ5uaVOkJdI78k8g04HfuBYh8wHFkwyPl7tHzCVtkpM86nPRtsx+Z
	RHmSsBce09CQgBDCAw4WVAYtaiBdjuI36KBXG79nDFcsFKno6jntQ/JvYZsVT2ie
	x/uBfDZVgmx9gcMyT68n6XH+O2BZHEOUNI77zAGmr9lKh5FSXXR35e4xCeBv+mNO
	EgzCcLj0qQtRZL3msKvw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9ep3tbbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 19:00:15 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 434J0E5U012580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 19:00:14 GMT
Received: from hu-mdharane-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 12:00:13 -0700
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran
	<quic_mdharane@quicinc.com>
Subject: [RFC v2 2/2] wifi: mac80211: Add support for link reconfigure removal
Date: Fri, 5 Apr 2024 00:29:50 +0530
Message-ID: <20240404185950.776062-3-quic_mdharane@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404185950.776062-1-quic_mdharane@quicinc.com>
References: <20240404185950.776062-1-quic_mdharane@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vo-Qra7mS29jzq8VJ4DAVK3sTnCicZlz
X-Proofpoint-GUID: vo-Qra7mS29jzq8VJ4DAVK3sTnCicZlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_15,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040134

Add mac80211 routine to support sending link removal command to
offloaded driver which accepts reconfigure Multi-Link element and the TBTT
count for the link to be removed. To support this, introduce new
mac80211 ops "link_reconfig_remove" to initiate link removal procedure
in driver with Multi-Link reconfiguration element and TBTT count received
from the userspace.

Also, add mac80211 routine "ieee80211_update_link_reconfig_remove_status"
which will be used by driver for sending TSF and current TBTT count
receive from driver during the following scenarios,

  1) When first beacon with Multi-Link reconfigure element is sent out in
  air, mac80211 will notify the userspace that link removal is started and
  it can proceed with further action like BTM etc.,
  2) When last beacon with Multi-Link reconfigure element (i.e. with link
  removal tbtt count as 0) is sent out in air, mac80211 will notify the
  userspace that link removal is completed. After which, userspace shall
  initiate the disassociation of the peer(s) connected and removal of
  the link completely.

Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
---
 include/net/mac80211.h     | 25 +++++++++++++++++++++++++
 net/mac80211/cfg.c         | 12 ++++++++++++
 net/mac80211/driver-ops.h  | 19 +++++++++++++++++++
 net/mac80211/ieee80211_i.h |  4 ++++
 net/mac80211/link.c        | 34 ++++++++++++++++++++++++++++++++++
 net/mac80211/trace.h       | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 126 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f57c29de3a91..c55204e3d736 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4394,6 +4394,10 @@ struct ieee80211_prep_tx_info {
  *	if the requested TID-To-Link mapping can be accepted or not.
  *	If it's not accepted the driver may suggest a preferred mapping and
  *	modify @ttlm parameter with the suggested TID-to-Link mapping.
+ * @link_reconfig_remove: Notifies the driver about the link to be
+ *	scheduled for removal with ML reconfigure element built for that particular
+ *	link along with the TBTT count until which the beacon with ML
+ *	reconfigure element should be sent.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4778,6 +4782,9 @@ struct ieee80211_ops {
 	enum ieee80211_neg_ttlm_res
 	(*can_neg_ttlm)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			struct ieee80211_neg_ttlm *ttlm);
+	int (*link_reconfig_remove)(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    const struct cfg80211_link_reconfig_removal_params *params);
 };
 
 /**
@@ -7600,6 +7607,24 @@ void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
  */
 void ieee80211_send_teardown_neg_ttlm(struct ieee80211_vif *vif);
 
+/* Defines for ML Reconfigure removal offload */
+
+/**
+ * ieee80211_update_link_reconfig_remove_update - Inform userspace about
+ * the removal status of link which is scheduled for removal
+ * @vif: interface in which reconfig removal status is received.
+ * @link_id: Link which is undergoing removal
+ * @tbtt_count: Current tbtt_count to be updated.
+ * @tsf: Beacon's timestamp value
+ * @cmd: Inform started or completed action to userspace
+ *
+ * For description, check cfg80211_link_reconfig_remove_update
+ */
+int ieee80211_update_link_reconfig_remove_update(struct ieee80211_vif *vif,
+						 unsigned int link_id,
+						 u8 tbtt_count, u64 tsf,
+						 enum nl80211_commands cmd);
+
 /* for older drivers - let's not document these ... */
 int ieee80211_emulate_add_chanctx(struct ieee80211_hw *hw,
 				  struct ieee80211_chanctx_conf *ctx);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f03452dc716d..3bb040c78e94 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4923,6 +4923,17 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 	ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
 }
 
+static int
+ieee80211_link_reconfig_remove(struct wiphy *wiphy,
+			       struct net_device *dev,
+			       const struct cfg80211_link_reconfig_removal_params *params)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+
+	return __ieee80211_link_reconfig_remove(local, sdata, params);
+}
+
 static int sta_add_link_station(struct ieee80211_local *local,
 				struct ieee80211_sub_if_data *sdata,
 				struct link_station_parameters *params)
@@ -5166,4 +5177,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.del_link_station = ieee80211_del_link_station,
 	.set_hw_timestamp = ieee80211_set_hw_timestamp,
 	.set_ttlm = ieee80211_set_ttlm,
+	.link_reconfig_remove = ieee80211_link_reconfig_remove,
 };
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 5d078c0a2323..4e4ffad9e7a7 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1716,4 +1716,23 @@ drv_can_neg_ttlm(struct ieee80211_local *local,
 
 	return res;
 }
+
+static inline int
+drv_link_reconfig_remove(struct ieee80211_local *local,
+			 struct ieee80211_sub_if_data *sdata,
+			 const struct cfg80211_link_reconfig_removal_params *params)
+{
+	int ret = -EOPNOTSUPP;
+
+	trace_drv_link_reconfig_remove(local, sdata, params);
+
+	if (local->ops->link_reconfig_remove)
+		ret = local->ops->link_reconfig_remove(&local->hw,
+						       &sdata->vif,
+						       params);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index def611e4e55f..3cafb7d52276 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2041,6 +2041,10 @@ static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata
 	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
+int __ieee80211_link_reconfig_remove(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     const struct cfg80211_link_reconfig_removal_params *params);
+
 /* tx handling */
 void ieee80211_clear_tx_pending(struct ieee80211_local *local);
 void ieee80211_tx_pending(struct tasklet_struct *t);
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 43f9672fc7f1..081072624913 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -501,3 +501,37 @@ void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->activate_links_work);
 }
 EXPORT_SYMBOL_GPL(ieee80211_set_active_links_async);
+
+int __ieee80211_link_reconfig_remove(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     const struct cfg80211_link_reconfig_removal_params *params)
+{
+	struct ieee80211_link_data *link;
+
+	if (!ieee80211_sdata_running(sdata))
+		return -ENETDOWN;
+
+	if (sdata->vif.type != NL80211_IFTYPE_AP)
+		return -EINVAL;
+
+	link = sdata_dereference(sdata->link[params->link_id], sdata);
+	if (!link)
+		return -ENOLINK;
+
+	return drv_link_reconfig_remove(local, sdata, params);
+}
+
+int ieee80211_update_link_reconfig_remove_update(struct ieee80211_vif *vif,
+						 unsigned int link_id,
+						 u8 tbtt_count, u64 tsf,
+						 enum nl80211_commands cmd)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		return cfg80211_update_link_reconfig_remove_update(sdata->dev, link_id,
+								   tbtt_count, tsf,
+								   cmd);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(ieee80211_update_link_reconfig_remove_update);
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 8e758b5074bd..4d94ed0f6638 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3145,6 +3145,38 @@ TRACE_EVENT(drv_neg_ttlm_res,
 		  LOCAL_PR_ARG, VIF_PR_ARG, __entry->res
 	)
 );
+
+TRACE_EVENT(drv_link_reconfig_remove,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 const struct cfg80211_link_reconfig_removal_params *params),
+
+	TP_ARGS(local, sdata, params),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		__field(u32, link_id)
+		__field(u16, count)
+		__dynamic_array(u8, frame, params->elem_len)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		__entry->link_id = params->link_id;
+		memcpy(__get_dynamic_array(frame), params->reconfigure_elem,
+		       params->elem_len);
+		__entry->count = params->link_removal_cntdown;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT ", " VIF_PR_FMT ", link_id :%u frame:0x%.2x count:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG,
+		__entry->link_id, le16_to_cpup((__le16 *)__get_dynamic_array(frame)),
+		__entry->count)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


