Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5370D56D452
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 07:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiGKFfA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 01:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKFe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 01:34:59 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B8E101F5
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 22:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657517698; x=1689053698;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Mp9UY6WqfK6Uxd5E/L9N04iAoqnttmY2terDReIMJ3c=;
  b=qO9jyf+kEc/HHiK3rTdC2aJkISlNwTrUl49P5pOYmRnRmFgUIC0NxcV9
   loWEWQy62a4iBSWgpKGvRunjioxIR91CUhr6hZRUKsiVmeLY96w56aO8k
   bGsbx86lEcoOgXAUcccomWteCjj0qjKYl/519mMcuIdAh4hO21LbyaUmc
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Jul 2022 22:34:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 22:34:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 10 Jul 2022 22:34:57 -0700
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 10 Jul 2022 22:34:55 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] nl80211: Fix reading NL80211_ATTR_MLO_LINK_ID in nl80211_pre_doit
Date:   Mon, 11 Jul 2022 11:04:43 +0530
Message-ID: <1657517683-5724-1-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
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

nl80211_pre_doit() using nla_get_u16() to read u8 attribute
NL80211_ATTR_MLO_LINK_ID. Fix this by using nla_get_u8() to
read NL80211_ATTR_MLO_LINK_ID attribute.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index eda2ad0..e20d0fc 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15835,7 +15835,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		/* MLO -> require valid link ID */
 		if (wdev->valid_links &&
 		    (!link_id ||
-		     !(wdev->valid_links & BIT(nla_get_u16(link_id))))) {
+		     !(wdev->valid_links & BIT(nla_get_u8(link_id))))) {
 			err = -EINVAL;
 			goto out_unlock;
 		}
-- 
2.7.4

