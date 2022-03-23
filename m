Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37D94E5B6E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 23:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbiCWWsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 18:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345383AbiCWWsT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 18:48:19 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A07CB23
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648075608; x=1679611608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sm1wy3jCpodTBf1YRGy0mXveij4WM3scCR9Il3HoguA=;
  b=lvrk1XBJWwYlWhLWcmZww0v+WEmleZiOKBmZVcJwkjF1cj4rsyx1VlKi
   tHM2nmHHBWQ2Cg2p9UWA6V0A5JdSkyVg9vYJw7WV5uuJDRUgjNMgIL6TC
   fsugQ8tAMiyHpjJGB3wpYhytSK58w4gfz4RgeLf99rXlrPgzQbtHZVGR9
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Mar 2022 15:46:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 15:46:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 15:46:47 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 15:46:46 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Muna Sinada <quic_msinada@quicinc.com>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 1/2] cfg80211: support disabling EHT mode
Date:   Wed, 23 Mar 2022 15:46:35 -0700
Message-ID: <20220323224636.20211-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
v2: Rebased on top of wireless-next git repository.

 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 1 +
 net/wireless/nl80211.c       | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 68713388b617..b557833119c1 100644
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
index 0568a79097b8..c7bd16024f84 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3175,6 +3175,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EHT_CAPABILITY,
 
+	NL80211_ATTR_DISABLE_EHT,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ee1c2b6b6971..7e15c6888751 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -790,6 +790,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_RANGE(NLA_BINARY,
 				 NL80211_EHT_MIN_CAPABILITY_LEN,
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
+	[NL80211_ATTR_DISABLE_EHT] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -10376,6 +10377,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_HE]))
 		req.flags |= ASSOC_REQ_DISABLE_HE;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_EHT]))
+		req.flags |= ASSOC_REQ_DISABLE_EHT;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&req.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
@@ -11164,6 +11168,9 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_HE]))
 		connect.flags |= ASSOC_REQ_DISABLE_HE;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_EHT]))
+		connect.flags |= ASSOC_REQ_DISABLE_EHT;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&connect.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),

base-commit: f5ba9781dde28f87d1e6db580ab63b308b5b5e1b
-- 
2.31.1

