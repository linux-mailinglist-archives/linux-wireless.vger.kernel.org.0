Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B415854647E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 12:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348532AbiFJKqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 06:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348031AbiFJKov (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 06:44:51 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8501288C05
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654857671; x=1686393671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=juFrN/ZbORZzjoPVPzrK0mlWKBUj3szWqCUAnXXvzRw=;
  b=NG2B/HjCVCQ7gixXkHokr2Pu8XUESh8zncms1q5AdXT8v/Et3YhcJiuJ
   vgwpYAjjzeO6MhQnNQzK+Ldo1tp7FLi4naPQ5CLCUww1U/OB2ImeVwnPv
   t8SE6Fp9MhgAoXjeImPYLRmiKRdKTcgRZj6KkFL6EBH/fIB14fUNxfidq
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Jun 2022 03:41:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 03:41:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 03:41:10 -0700
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 03:41:08 -0700
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 2/3] cfg80211: Add provision for changing mesh header cache size
Date:   Fri, 10 Jun 2022 16:10:38 +0530
Message-ID: <1654857639-12346-3-git-send-email-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
References: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add provision to update the header cache size. The default cache size
is 50 header entries corresponding to different external destination.
In case there is a need for a bigger cache depending on the network
topology, the hdr_cache_size config can be updated.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 include/net/cfg80211.h       | 3 +++
 include/uapi/linux/nl80211.h | 4 ++++
 net/wireless/mesh.c          | 3 +++
 net/wireless/nl80211.c       | 6 +++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 34bdf1d..ec19c62 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2155,6 +2155,8 @@ struct bss_parameters {
  *      not be the optimal decision as a multi-hop route might be better. So
  *      if using this setting you will likely also want to disable
  *      dot11MeshForwarding and use another mesh routing protocol on top.
+ * @hdr_cache_size: Maximum number of entries the mesh header cache will
+ *	hold before flushing old entries.
  */
 struct mesh_config {
 	u16 dot11MeshRetryTimeout;
@@ -2188,6 +2190,7 @@ struct mesh_config {
 	u16 dot11MeshAwakeWindowDuration;
 	u32 plink_timeout;
 	bool dot11MeshNolearn;
+	u16 hdr_cache_size;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d9490e3..b22c497 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4556,6 +4556,9 @@ enum nl80211_mesh_power_mode {
  *	will advertise that it is connected to a authentication server
  *	in the mesh formation field.
  *
+ * @NL80211_MESHCONF_HEADER_CACHE_SIZE: Maximum size of the header cache
+ *	used for caching headers corresponding to an external destination.
+ *
  * @__NL80211_MESHCONF_ATTR_AFTER_LAST: internal use
  */
 enum nl80211_meshconf_params {
@@ -4591,6 +4594,7 @@ enum nl80211_meshconf_params {
 	NL80211_MESHCONF_CONNECTED_TO_GATE,
 	NL80211_MESHCONF_NOLEARN,
 	NL80211_MESHCONF_CONNECTED_TO_AS,
+	NL80211_MESHCONF_HEADER_CACHE_SIZE,
 
 	/* keep last */
 	__NL80211_MESHCONF_ATTR_AFTER_LAST,
diff --git a/net/wireless/mesh.c b/net/wireless/mesh.c
index e4e3631..f606777 100644
--- a/net/wireless/mesh.c
+++ b/net/wireless/mesh.c
@@ -21,6 +21,8 @@
 #define MESH_ROOT_CONFIRMATION_INTERVAL 2000
 #define MESH_DEFAULT_PLINK_TIMEOUT	1800 /* timeout in seconds */
 
+#define MESH_DEFAULT_HEADER_CACHE_SIZE		50
+
 /*
  * Minimum interval between two consecutive PREQs originated by the same
  * interface
@@ -79,6 +81,7 @@ const struct mesh_config default_mesh_config = {
 	.dot11MeshAwakeWindowDuration = MESH_DEFAULT_AWAKE_WINDOW,
 	.plink_timeout = MESH_DEFAULT_PLINK_TIMEOUT,
 	.dot11MeshNolearn = false,
+	.hdr_cache_size = MESH_DEFAULT_HEADER_CACHE_SIZE,
 };
 
 const struct mesh_setup default_mesh_setup = {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index dee0fa9..eae69ea 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7672,7 +7672,9 @@ static int nl80211_get_mesh_config(struct sk_buff *skb,
 	    nla_put_u8(msg, NL80211_MESHCONF_NOLEARN,
 		       cur_params.dot11MeshNolearn) ||
 	    nla_put_u8(msg, NL80211_MESHCONF_CONNECTED_TO_AS,
-		       cur_params.dot11MeshConnectedToAuthServer))
+		       cur_params.dot11MeshConnectedToAuthServer) ||
+	    nla_put_u16(msg, NL80211_MESHCONF_HEADER_CACHE_SIZE,
+			cur_params.hdr_cache_size))
 		goto nla_put_failure;
 	nla_nest_end(msg, pinfoattr);
 	genlmsg_end(msg, hdr);
@@ -7888,6 +7890,8 @@ do {									\
 				  NL80211_MESHCONF_PLINK_TIMEOUT, nla_get_u32);
 	FILL_IN_MESH_PARAM_IF_SET(tb, cfg, dot11MeshNolearn, mask,
 				  NL80211_MESHCONF_NOLEARN, nla_get_u8);
+	FILL_IN_MESH_PARAM_IF_SET(tb, cfg, hdr_cache_size, mask,
+				  NL80211_MESHCONF_HEADER_CACHE_SIZE, nla_get_u16);
 	if (mask_out)
 		*mask_out = mask;
 
-- 
2.7.4

