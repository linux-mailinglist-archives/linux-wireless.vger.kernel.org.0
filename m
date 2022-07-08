Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02556BEC6
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiGHQwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbiGHQw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 12:52:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F4B2BB33
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657299148; x=1688835148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkgT01xD1QFEq3LaQ8YC1xfCtkTa+Xx6ol/y4IH4Wcs=;
  b=ZBc2+g9S9eSKphY2eMM41/BLZhnALr+qMJS2Q48sYUIbEP95m4vNP18b
   ODcPR2icCLkbtu6ZIRTibF6GDz0yu4m+W1bTDz7NjQlmvnezGaPInjHyt
   HqdbTLZBXStLltJtC0rlc1HUix2vYM8/oVCx5gZcGQkZmFVeNczVO5rNd
   Y=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 08 Jul 2022 09:52:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 09:52:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 09:52:27 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 09:52:25 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] cfg80211: Indicate transmit address in external auth request
Date:   Fri, 8 Jul 2022 22:22:12 +0530
Message-ID: <20220708165212.2069149-2-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708165212.2069149-1-quic_vjakkam@quicinc.com>
References: <20220708165212.2069149-1-quic_vjakkam@quicinc.com>
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

If external authentication request triggered during MLO connection, the
link address used by driver can be different from the interface address.
Add support to indicate transmit address to use for authentication
frames sent by user space for current external authentication request.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h | 6 ++++++
 net/wireless/nl80211.c | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 140354f5f15b..be0ebed560f6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3553,6 +3553,11 @@ struct cfg80211_pmk_conf {
  *	the real status code for failures. Used only for the authentication
  *	response command interface (user space to driver).
  * @pmkid: The identifier to refer a PMKSA.
+ * @tx_addr: Transmit address to use for current external authentication
+ *	request. Only valid for the authentication request event. Driver must
+ *	indicate support for randomizing transmit address of authentication
+ *	frames with %NL80211_EXT_FEATURE_AUTH_TX_RANDOM_TA to fill non-zero
+ *	value in this parameter.
  */
 struct cfg80211_external_auth_params {
 	enum nl80211_external_auth_action action;
@@ -3561,6 +3566,7 @@ struct cfg80211_external_auth_params {
 	unsigned int key_mgmt_suite;
 	u16 status;
 	const u8 *pmkid;
+	u8 tx_addr[ETH_ALEN] __aligned(2);
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index eda2ad029c90..e00539c98112 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19280,6 +19280,15 @@ int cfg80211_external_auth_request(struct net_device *dev,
 		    params->ssid.ssid))
 		goto nla_put_failure;
 
+	if (!is_zero_ether_addr(params->tx_addr)) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+			    NL80211_EXT_FEATURE_AUTH_TX_RANDOM_TA))
+			return -EINVAL;
+
+		if (nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, params->tx_addr))
+			goto nla_put_failure;
+	}
+
 	genlmsg_end(msg, hdr);
 	genlmsg_unicast(wiphy_net(&rdev->wiphy), msg,
 			wdev->conn_owner_nlportid);
-- 
2.25.1

