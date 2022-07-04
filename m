Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71514565898
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 16:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiGDO1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiGDO1n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 10:27:43 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634A6351
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656944862; x=1688480862;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jIckJ6q27CxQEqwm6h7dYIRLxW5M+UO8WF4AeexYZik=;
  b=c5CpLkTcRQkyuoL7Qrx3pxrGLz8Q06pWHzF1zAUGURc0+ZO/YuyRlMOY
   gXDoFv9jdPtX1E87tESVM4ZY1T17tasK0EdRCDAHyZlMp3hIKfwqlPw/V
   +SGEZ1G9iy9CDA+GS7WlNaUnOJv4iZ0ddanwlHzC9tkWfJ4g5VC8J3JVs
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Jul 2022 07:27:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:27:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 07:27:40 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 07:27:39 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: nl80211: Use nested attribute to expose link ID of associated BSS
Date:   Mon, 4 Jul 2022 19:57:18 +0530
Message-ID: <20220704142718.1279055-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
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

Use nested attribute instead of top-level attribute when filling link
ID info in nested message of the associated BSS.

Fixes: dd374f84baec ("wifi: nl80211: expose link ID for associated BSSes")
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
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

