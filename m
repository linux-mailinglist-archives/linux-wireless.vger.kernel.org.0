Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0DB4B7B89
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Feb 2022 01:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbiBPACG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 19:02:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiBPACE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 19:02:04 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE870071
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 16:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644969710; x=1676505710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wNz6d+C+/h0KzZGtxbnCBhklaE8pA+w0bK3uye1D6ZA=;
  b=OvPhzMzopwaNwaEbPmmMDDLELrB/1n0Bgpd5ypJectiwUVJLLHEUfzyV
   aQ8Ci9RMdq1ChX3AJIb9vD0SU/zjMAHHdkvD/VK+pvTGdBog+R9hnOu2k
   l/Db0hCwAOJ9OozeAXWj4DhmcHjSqo95vurEDbmkT7qJQLIBLLUEGLoQ7
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 16:01:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 16:01:50 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 16:01:49 -0800
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 16:01:49 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Muna Sinada <quic_msinada@quicinc.com>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 1/2] cfg80211: support disabling EHT mode
Date:   Tue, 15 Feb 2022 16:01:36 -0800
Message-ID: <20220216000137.29276-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220216000137.29276-1-quic_alokad@quicinc.com>
References: <20220216000137.29276-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Muna Sinada <quic_msinada@quicinc.com>

Allow userspace to disable EHT mode.
This forces EHT capable interfaces to disable during association.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 1 +
 net/wireless/nl80211.c       | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 136c0c537334..27359f74dd01 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2735,6 +2735,7 @@ struct cfg80211_auth_request {
  *	userspace if this flag is set. Only applicable for cfg80211_connect()
  *	request (connect callback).
  * @ASSOC_REQ_DISABLE_HE:  Disable HE
+ * @ASSOC_REQ_DISABLE_EHT:  Disable EHT
  */
 enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_HT			= BIT(0),
@@ -2742,6 +2743,7 @@ enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_USE_RRM			= BIT(2),
 	CONNECT_REQ_EXTERNAL_AUTH_SUPPORT	= BIT(3),
 	ASSOC_REQ_DISABLE_HE			= BIT(4),
+	ASSOC_REQ_DISABLE_EHT			= BIT(5),
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 98ed52663d6b..cdc9087ccbb8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3175,6 +3175,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EHT_CAPABILITY,
 
+	NL80211_ATTR_DISABLE_EHT,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1595e14fd678..be1f7463b8a8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -782,6 +782,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_RANGE(NLA_BINARY,
 				 NL80211_EHT_MIN_CAPABILITY_LEN,
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
+	[NL80211_ATTR_DISABLE_EHT] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -10362,6 +10363,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_HE]))
 		req.flags |= ASSOC_REQ_DISABLE_HE;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_EHT]))
+		req.flags |= ASSOC_REQ_DISABLE_EHT;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&req.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
@@ -11150,6 +11154,9 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_HE]))
 		connect.flags |= ASSOC_REQ_DISABLE_HE;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_EHT]))
+		connect.flags |= ASSOC_REQ_DISABLE_EHT;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&connect.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
-- 
2.31.1

