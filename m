Return-Path: <linux-wireless+bounces-5429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665C888F77C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 06:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9303B1C280D9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 05:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B5291E;
	Thu, 28 Mar 2024 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mNNvyv8/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E0148CC6
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605189; cv=none; b=fN4R5FS1dTzEA6XNQgRkXoso2Qvz+hVjJKwEpjaOnApfHDdC6l4fUpjUd6PKcBQkY5ejx5qUXO6Nr9hDzo5zGh5EnzkwX4/nQsED6QGVfy1efm5s3ELysfFzR/nPptljh8iwo89P+oo+rf+gFCWBblmUzGVa1PCVeYahu2XFYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605189; c=relaxed/simple;
	bh=Uli//x4LJJ20rGtwDZsx0ib6e1xck4gYfGE91LCRpvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNhzUrxApX/khB+S4Btx1y7kLgWc1QvWAdhtd+MxUrDFQ/+FM9Nr4GW8kLIX6MiHGuF2UEplNkfBCOZA34z0RoNf4MkUzpUE8xQtXJpFA3mAztarnnDvAKTx9x6A+zTdrpxUK1lfsz4dOBQPlENfgSeSXT4n46Yriz/2bYcd0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mNNvyv8/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S4vEZ5028424;
	Thu, 28 Mar 2024 05:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=stcE2jBfQYsN8Vcfq1r+WUB8/KU+bvE3aF7LQTE1vOY=; b=mN
	Nvyv8/vGPCe7p9K/OBh/NLHOTPbK2WOMRsjP2uJJbG5Cp+gHphfSb9dRM75kNexz
	peAZ/jVk+P06mjgXNNz+4Y0J6KGiMy+A5KLe9PkcSl2Y2ba9QPJErFoLrdX23p7D
	q+7EwP5IOsrUjByAFg1B3NqvVqMseYAgMAU5eq1KZuEEcQR6tO7FTJeQYh2T/U/s
	/dqnxNmU+JhGuqtFuCkotbMySE65KXx1Tc27s8u38SKKG8dxNHPFG9vb+mwcIPO7
	4sA7fn7C1ljRNPWW5zwnEnFCYsxV8dEqJQECdNkgeifMeoSYZYJDTmuXRW/jJW8O
	uUk8QL49BZxdBuUXDdtw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1whx05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:53:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S5r2mi001359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:53:02 GMT
Received: from hu-mdharane-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 27 Mar 2024 22:53:00 -0700
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran
	<quic_mdharane@quicinc.com>
Subject: [RFC 2/2] wifi: mac80211: Add support for link reconfigure removal
Date: Thu, 28 Mar 2024 11:22:35 +0530
Message-ID: <20240328055235.3034174-3-quic_mdharane@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
References: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hv-RIC3Y_5OIM5Amqp0rV_kHDv40I8-Q
X-Proofpoint-ORIG-GUID: hv-RIC3Y_5OIM5Amqp0rV_kHDv40I8-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_04,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280035

Add mac80211 routine to support sending link removal command to
offloaded driver which accepts reconfigure Multi-Link IE and the TBTT
count for the link to be removed. To support this, introduce new
mac80211 ops "link_reconfig_remove" to initiate link removal procedure
in driver with Multi-Link reconfiguration IE and TBTT count received
from the userspace.

Also, add mac80211 routine "ieee80211_update_link_reconfig_remove_status"
which will be used by driver for sending TSF and current TBTT count
receive from driver during the following scenarios,

  1) When first beacon with Multi-Link reconfigure IE is sent out in air,
  mac80211 will notify the userspace that link removal is started and
  it can proceed with further action like BTM etc.,
  2) When last beacon with Multi-Link reconfigure IE (i.e. with link
  removal tbtt count as 0) is sent out in air, mac80211 will notify the
  userspace that link removal is completed. After which, userspace shall
  initiate the disassociation of the peer(s) connected and removal of
  the link completely.

Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
---
 include/net/mac80211.h     | 25 ++++++++++++++++++++++++
 net/mac80211/cfg.c         | 12 ++++++++++++
 net/mac80211/driver-ops.h  | 19 ++++++++++++++++++
 net/mac80211/ieee80211_i.h |  4 ++++
 net/mac80211/link.c        | 40 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/trace.h       | 30 ++++++++++++++++++++++++++++
 6 files changed, 130 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f57c29de3a91..c4a0069a6cbb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4394,6 +4394,10 @@ struct ieee80211_prep_tx_info {
  *	if the requested TID-To-Link mapping can be accepted or not.
  *	If it's not accepted the driver may suggest a preferred mapping and
  *	modify @ttlm parameter with the suggested TID-to-Link mapping.
+ * @link_reconfig_remove: Notifies the driver about the link to be
+ *	scheduled for removal with ML reconfigure IE built for that particular
+ *	link along with the TBTT count until which the beacon with ML
+ *	reconfigure IE should be sent.
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
+ * ieee80211_update_link_reconfig_remove_status - Inform userspace about
+ * the removal status of link which is scheduled for removal
+ * @vif: interface in which reconfig removal status is received.
+ * @link_id: Link which is undergoing removal
+ * @tbtt_count: Current tbtt_count to be updated.
+ * @tsf: Beacon's timestamp value
+ * @action: Inform started or completed action to userspace
+ *
+ * For description, check cfg80211_link_reconfig_remove_status
+ */
+int ieee80211_update_link_reconfig_remove_status(struct ieee80211_vif *vif,
+						 unsigned int link_id,
+						 u8 tbtt_count, u64 tsf,
+						 enum ieee80211_link_reconfig_remove_state action);
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
index 43f9672fc7f1..aa9d05067590 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -501,3 +501,43 @@ void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->activate_links_work);
 }
 EXPORT_SYMBOL_GPL(ieee80211_set_active_links_async);
+
+int __ieee80211_link_reconfig_remove(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     const struct cfg80211_link_reconfig_removal_params *params)
+{
+	struct ieee80211_link_data *link;
+	int ret;
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
+	ret = drv_link_reconfig_remove(local, sdata, params);
+
+	return ret;
+}
+
+int ieee80211_update_link_reconfig_remove_status(struct ieee80211_vif *vif,
+						 unsigned int link_id,
+						 u8 tbtt_count, u64 tsf,
+						 enum ieee80211_link_reconfig_remove_state status)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (vif->type != NL80211_IFTYPE_AP) {
+		sdata_err(sdata, "Discarding link reconfig status for unsupported vif type\n");
+		return -EINVAL;
+	}
+
+	return cfg80211_update_link_reconfig_remove_status(sdata->dev, link_id,
+							   tbtt_count, tsf,
+							   status);
+}
+EXPORT_SYMBOL(ieee80211_update_link_reconfig_remove_status);
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 8e758b5074bd..40fefdc34a79 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3145,6 +3145,36 @@ TRACE_EVENT(drv_neg_ttlm_res,
 		  LOCAL_PR_ARG, VIF_PR_ARG, __entry->res
 	)
 );
+
+TRACE_EVENT(drv_link_reconfig_remove,
+	    TP_PROTO(struct ieee80211_local *local,
+		     struct ieee80211_sub_if_data *sdata,
+		     const struct cfg80211_link_reconfig_removal_params *params),
+
+	TP_ARGS(local, sdata, params),
+
+	TP_STRUCT__entry(LOCAL_ENTRY
+			 VIF_ENTRY
+			 __field(u32, link_id)
+			 __field(u16, count)
+			 __dynamic_array(u8, frame, params->ie_len)
+	),
+
+	TP_fast_assign(LOCAL_ASSIGN;
+		       VIF_ASSIGN;
+		       __entry->link_id = params->link_id;
+		       memcpy(__get_dynamic_array(frame), params->ie,
+			      params->ie_len);
+		       __entry->count = params->link_removal_cntdown;
+	),
+
+	TP_printk(LOCAL_PR_FMT ", " VIF_PR_FMT ", link_id :%u frame:0x%.2x count:%d",
+		  LOCAL_PR_ARG, VIF_PR_ARG,
+		  __entry->link_id,
+		  le16_to_cpup((__le16 *)__get_dynamic_array(frame)),
+		  __entry->count)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


