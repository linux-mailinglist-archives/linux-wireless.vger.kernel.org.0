Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0264E5906
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 20:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbiCWTSm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 15:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbiCWTSl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 15:18:41 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EAE8879B
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648063031; x=1679599031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ll1M4XLJeZ33EIstqlI3R1RG8FVmeRFTgtdd2vAQYW4=;
  b=pvgpjzTSF2e875SFX+RFxS53YyDygL5XJ7f0YTQaxb9olWn/TRAQeWdd
   ekliJBwNpYcN6BcXbwny4KdFCjnDHFQXI14kNZaI284fTcraeAxdqDAXC
   J52nSm30asTkSrLhYb517sHQXzAdtHnp/Zq8SO4UyTTxUYikr+jf4YYpu
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 12:17:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 12:17:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 12:16:53 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 12:16:53 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 4/4] mac80211: reset puncturing bitmap during width downgrade
Date:   Wed, 23 Mar 2022 12:16:40 -0700
Message-ID: <20220323191640.31230-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220323191640.31230-1-quic_alokad@quicinc.com>
References: <20220323191640.31230-1-quic_alokad@quicinc.com>
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

Set the RU puncturing bitmap to 0 if for any reason bandwidth
is downgraded to less than 80 Mhz.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 net/mac80211/util.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 682a164f795a..0dd7e8dae5a9 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4135,6 +4135,13 @@ u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 		break;
 	}
 
+	if (c->width != NL80211_CHAN_WIDTH_320 &&
+	    c->width != NL80211_CHAN_WIDTH_160 &&
+	    c->width != NL80211_CHAN_WIDTH_80) {
+		c->ru_punct_bitmap = 0;
+		c->ru_punct_bitmap_supp_he = 0;
+	}
+
 	WARN_ON_ONCE(!cfg80211_chandef_valid(c));
 
 	return ret;
-- 
2.31.1

