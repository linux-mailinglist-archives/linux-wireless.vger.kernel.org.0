Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269B57939FF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Sep 2023 12:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbjIFKfe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Sep 2023 06:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbjIFKfd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Sep 2023 06:35:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580DE46
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 03:35:28 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3866PSDN013431;
        Wed, 6 Sep 2023 10:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=YkB2L4G87iH9yWpuecD2xjyl/8M69B8XT3qHm1P/E1I=;
 b=ZGhNwRRfQTZALlVQ1PMw7tVmflbRsFGXNErynWamNgDRjXk1yQUGtyed0U1P26h9uWeP
 6W3dDumDPyOy3IzDcLSABNlKcqwoEeqy7x2F654eWVzqtA1xGSqshqvd4KqijQLWhCi8
 PamA1XGypYLHaEdePElieG5H6dK7LQWDUdghzpkVqJ+HL8BHBAun7lj/rCsUnqfZQo7K
 cDHSVGxrJTm2utprNsWrkCJZe8F0qPY6xsk2MKCk2VC2nWfKrrzd3OeG/ibvw6T3++FE
 P0hoKA9hDONghSMACXNp0sIvdYzDutdN2OouBg7pU3ne05fjdo+JLYbPWDEjm/yGHm4+ fQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxgmc18n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 10:35:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 386AZH9u025070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 10:35:17 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 6 Sep 2023 03:35:15 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 2/3] wifi: mac80211: add support to allow driver to set active link while connection for station
Date:   Wed, 6 Sep 2023 06:34:57 -0400
Message-ID: <20230906103458.24092-3-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906103458.24092-1-quic_wgong@quicinc.com>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FBQQ4vld9KHsFLX0AYk5kAiMf8PY8vcI
X-Proofpoint-ORIG-GUID: FBQQ4vld9KHsFLX0AYk5kAiMf8PY8vcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are 2 fields valid_links and active_links in struct ieee80211_vif
of mac80211. For station mode, valid_links is always include the bitmap
of active_links. valid_links stores the bitmap of links which is created
in mac80211, and mac80211 only indicate the info of links which is existed
in active_links to driver. Finally, the active_links is the bitmap of
links which station can interactive with MLO AP it is connected to.

Currently the active links is always only contain the primary link,
primary link means the link used by the latest exchange of successful
(Re)Association Request/Response frames. Then it will always have only
one link in driver after connected.

Hence add this ops in struct ieee80211_ops to allow driver to determine
the active links bit map dynamically while connecting to MLO AP.

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 include/net/mac80211.h    | 10 ++++++++++
 net/mac80211/driver-ops.h | 21 +++++++++++++++++++++
 net/mac80211/link.c       |  8 ++++++++
 net/mac80211/trace.h      | 23 +++++++++++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c7f92a3db359..c50f1a99ccd5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3732,6 +3732,14 @@ struct ieee80211_prep_tx_info {
  *	Note: this callback is called if @vif_cfg_changed or @link_info_changed
  *	are not implemented.
  *
+ * @calculate_active_links: Prepare for bit maps of links to active.
+ *	This callback is optional. The @new_links parameter is all links bit map
+ *	that mac80211 has capability to activate. Returns non-zero if driver handled
+ *	the @new_links, and the returned non-zero value is the bit map of the links
+ *	that driver allows to active. The bitmap of returned non-zero value may be
+ *	a subset of the @new_links. Return zero if driver not handled this.
+ *	This callback can sleep.
+ *
  * @vif_cfg_changed: Handler for configuration requests related to interface
  *	(MLD) parameters from &struct ieee80211_vif_cfg that vary during the
  *	lifetime of the interface (e.g. assoc status, IP addresses, etc.)
@@ -4295,6 +4303,8 @@ struct ieee80211_ops {
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *info,
 				 u64 changed);
+	u16 (*calculate_active_links)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    u16 new_links);
 	void (*vif_cfg_changed)(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				u64 changed);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index da164d4ca9a1..d2a8bf5341b5 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -950,6 +950,27 @@ static inline void drv_verify_link_exists(struct ieee80211_sub_if_data *sdata,
 		sdata_assert_lock(sdata);
 }
 
+static inline u16 drv_calculate_active_links(struct ieee80211_local *local,
+				   struct ieee80211_sub_if_data *sdata,
+				   u16 new_links)
+{
+	u16 active_links = 0;
+
+	might_sleep();
+
+	if (!check_sdata_in_driver(sdata))
+		return active_links;
+
+	trace_drv_calculate_active_links(local, sdata, new_links);
+	if (local->ops->calculate_active_links)
+		active_links = local->ops->calculate_active_links(&local->hw,
+								  &sdata->vif,
+								  new_links);
+
+	trace_drv_return_int(local, active_links);
+	return active_links;
+}
+
 int drv_assign_vif_chanctx(struct ieee80211_local *local,
 			   struct ieee80211_sub_if_data *sdata,
 			   struct ieee80211_bss_conf *link_conf,
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 6148208b320e..7ce229a64a7b 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -146,6 +146,7 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
 {
 	sdata->vif.valid_links = valid_links;
 	sdata->vif.dormant_links = dormant_links;
+	u16 active_links;
 
 	if (!valid_links ||
 	    WARN((~valid_links & dormant_links) ||
@@ -166,6 +167,13 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
 		WARN_ON(dormant_links);
 		break;
 	case NL80211_IFTYPE_STATION:
+		active_links = drv_calculate_active_links(sdata->local, sdata,
+							  valid_links & ~dormant_links);
+		if (active_links) {
+			sdata->vif.active_links = active_links;
+			break;
+		}
+
 		if (sdata->vif.active_links)
 			break;
 		sdata->vif.active_links = valid_links & ~dormant_links;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index b140a4e70df9..eb458c236101 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -652,6 +652,29 @@ TRACE_EVENT(drv_set_key,
 	)
 );
 
+TRACE_EVENT(drv_calculate_active_links,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 u16 new_links),
+
+	TP_ARGS(local, sdata, new_links),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		__field(unsigned int, new_links)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		__entry->new_links = new_links;
+	),
+
+	TP_printk(LOCAL_PR_FMT ", " VIF_PR_FMT ", new_links: %u",
+		  LOCAL_PR_ARG, VIF_PR_ARG, __entry->new_links)
+);
+
 TRACE_EVENT(drv_update_tkip_key,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-- 
2.40.1

