Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120F56B9AF
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 14:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiGHM0W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 08:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiGHM0V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 08:26:21 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32430F43
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 05:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657283179; x=1688819179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P5z5Mvh2uC3Xu3K3JbnvVrwIqNSxFc5ChefpUIqiwyA=;
  b=ne8kKR+IIESS5HcwbBUXjdeRU1I/yQ1NEjrq5tXPWreVorZR0BYXIhNJ
   hAzdObmdJpq9Sk0xfW7Fb8alpPFsB+a2JNaGUyD9AZHRlGQ4G01s6Cqvg
   9SRx5gIA6YUIULVQw/9xWJW4eh+Jgeq4j3U7Yd6m+IU/9MqsKOxPsfrGt
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Jul 2022 05:26:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 05:26:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 05:26:18 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 05:26:17 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: nl80211: fix sending link ID info of associated BSS
Date:   Fri, 8 Jul 2022 17:56:07 +0530
Message-ID: <20220708122607.1836958-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
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

commit dd374f84baec ("wifi: nl80211: expose link ID for associated
 BSSes") used a top-level attribute to send link ID of the associated
BSS in the nested attribute NL80211_ATTR_BSS. But since NL80211_ATTR_BSS
is a nested attribute of the attributes defined in enum nl80211_bss,
define a new attribute in enum nl80211_bss and use it for sending the
link ID of the BSS.

Fixes: dd374f84baec ("wifi: nl80211: expose link ID for associated BSSes")
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
v2:
 - Write more appropriate and detailed commit text
---
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 279f9715919e..7bb1ae59f3a5 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4904,6 +4904,7 @@ enum nl80211_bss_scan_width {
  *	Contains a nested array of signal strength attributes (u8, dBm),
  *	using the nesting index as the antenna number.
  * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
+ * @NL80211_BSS_MLO_LINK_ID: MLO link ID of the BSS (u8).
  * @__NL80211_BSS_AFTER_LAST: internal
  * @NL80211_BSS_MAX: highest BSS attribute
  */
@@ -4929,6 +4930,7 @@ enum nl80211_bss {
 	NL80211_BSS_PARENT_BSSID,
 	NL80211_BSS_CHAIN_SIGNAL,
 	NL80211_BSS_FREQUENCY_OFFSET,
+	NL80211_BSS_MLO_LINK_ID,
 
 	/* keep last */
 	__NL80211_BSS_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index eda2ad029c90..5d6351d3a484 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9991,7 +9991,8 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
 			    (nla_put_u32(msg, NL80211_BSS_STATUS,
 					 NL80211_BSS_STATUS_ASSOCIATED) ||
 			     (wdev->valid_links &&
-			      nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id))))
+			      nla_put_u8(msg, NL80211_BSS_MLO_LINK_ID,
+					 link_id))))
 				goto nla_put_failure;
 		}
 		break;
-- 
2.25.1

