Return-Path: <linux-wireless+bounces-11056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB934949E92
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 05:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970F928B3BA
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 03:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354219049B;
	Wed,  7 Aug 2024 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ChzK+78U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BCF1917CE
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002360; cv=none; b=FLDALPFDIEfslhPM//gx1JNHNGWjmc0c6RSfeVnqTXtVWjiAONNIIGMaJXeO7ATXMno7PNwwHUr1lXwJndaPchR7vXH9JblSwAEa9UlEgVdMCgpcSPusgpz35QOlkASXDAArCnRRkKGbNiVKD6ypImXGMs/75+NIbRE2Admwnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002360; c=relaxed/simple;
	bh=ujMXtzW5VG5vImvQqNXxBs9MRS03aT6BxKGMbvkrEA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXO4kfgfl6YXav9OO5EoSMqwAn26Ce4PImttTzUPJv7etsOmDaH/7495+GmkARdmcdAQYdsYDSg7cRwQos+B5Zacv0G7RGDAeUUYLI+jsOxQB7nk1zMtMPOVH6AyFlXmS1cqbp1ObMNwZ7UMcF75R/PsXLjUnru1qRAcNqHxmhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ChzK+78U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476H6bi6007546;
	Wed, 7 Aug 2024 03:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OX7Qx6T6vDhxTziTFCRCskXPLKQNLVfVgbY0nfe6+hM=; b=ChzK+78Uuq9yIbWE
	/Nu8rSQH1qDL0NyqIGkMhKbiNPPIyriGPOJKs+qIoDExZj5/iEqJr0yO+Giwo0wN
	tT4f0UQ9eJ9G8goaId2iVdkq9H2z3qyMoWLI8P4058Qs1HWN0OpISm771FSqZKIR
	ouOUhJvSqROF9pI6BLlPNEFwVKyobsHi/MSo2PG4WdOutdjAdE0kcQ2aA3SDuwYy
	/SFdxiM476xNjllmqgrxBnllDfFpAGfLflewn7wiHdjYyGnp3c8ynlLMRYu+AHLO
	4m1hveTcREm9YoWP/T51txHfHsG+eC4ycvquOIsfI+5FKFhIDclHOXSCwc5t1yTz
	jofQ5w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scx6sh84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 03:45:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4773jrrs014486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Aug 2024 03:45:53 GMT
Received: from hu-mdharane-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 6 Aug 2024 20:45:51 -0700
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran
	<quic_mdharane@quicinc.com>
Subject: [PATCH RFC v4 2/2] wifi: mac80211: Add support for link reconfigure removal
Date: Wed, 7 Aug 2024 09:15:21 +0530
Message-ID: <20240807034521.2091751-3-quic_mdharane@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807034521.2091751-1-quic_mdharane@quicinc.com>
References: <20240807034521.2091751-1-quic_mdharane@quicinc.com>
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
X-Proofpoint-ORIG-GUID: nIi-zkxWDrLQ6JYBFGZi79AEVrP-XvHk
X-Proofpoint-GUID: nIi-zkxWDrLQ6JYBFGZi79AEVrP-XvHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_20,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070021

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
 net/mac80211/trace.h       | 31 +++++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0a04eaf5343c..c3d6d3c3ba56 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4430,6 +4430,10 @@ struct ieee80211_prep_tx_info {
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
@@ -4814,6 +4818,9 @@ struct ieee80211_ops {
 	enum ieee80211_neg_ttlm_res
 	(*can_neg_ttlm)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			struct ieee80211_neg_ttlm *ttlm);
+	int (*link_reconfig_remove)(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    const struct cfg80211_link_reconfig_removal_params *params);
 };
 
 /**
@@ -7646,6 +7653,24 @@ void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
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
+						 u32 tbtt_count, u64 tsf,
+						 enum nl80211_commands cmd);
+
 /* for older drivers - let's not document these ... */
 int ieee80211_emulate_add_chanctx(struct ieee80211_hw *hw,
 				  struct ieee80211_chanctx_conf *ctx);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 85cb71de370f..a1a2b4f61d8c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5090,6 +5090,17 @@ ieee80211_set_ttlm(struct wiphy *wiphy, struct net_device *dev,
 	return ieee80211_req_neg_ttlm(sdata, params);
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
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -5204,4 +5215,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.set_hw_timestamp = ieee80211_set_hw_timestamp,
 	.set_ttlm = ieee80211_set_ttlm,
 	.get_radio_mask = ieee80211_get_radio_mask,
+	.link_reconfig_remove = ieee80211_link_reconfig_remove,
 };
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d382d9729e85..d3976d0e51c6 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1728,4 +1728,23 @@ drv_can_neg_ttlm(struct ieee80211_local *local,
 
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
index a3485e4c6132..11c673d17648 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2058,6 +2058,10 @@ static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata
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
index 1a211b8d4057..e59a38809fa6 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -528,3 +528,37 @@ void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
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
+						 u32 tbtt_count, u64 tsf,
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
index dc498cd8cd91..8103eb7377a4 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3154,6 +3154,37 @@ TRACE_EVENT(drv_neg_ttlm_res,
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
+		__field(u32, count)
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
+		LOCAL_PR_FMT ", " VIF_PR_FMT ", link_id :%u count:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG,
+		__entry->link_id, __entry->count)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


