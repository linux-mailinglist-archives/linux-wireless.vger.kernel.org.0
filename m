Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AEF4F8D78
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 08:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiDHExX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Apr 2022 00:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbiDHExR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Apr 2022 00:53:17 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C01188571
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 21:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649393472; x=1680929472;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ANxMMGOayknmcr1cq1QY1dJBVKlMfVeWKCgQTTJSHyk=;
  b=WNcJzDEzPcQEKS+BHexPWEmU4fFSLRo/Fu8qPP/mOG/egOlXtoef5kLo
   w/2/qye6aes3wIYoYegG/S0AnWolKqfji65lds06X/axptXgH3ZYk0s9G
   0pTqbc2T2PZD78qCs/OBVFE/Kc8cqxvU73sw8NNCqU2WymTrl3sjgHnqH
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 07 Apr 2022 21:51:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 21:51:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 21:51:11 -0700
Received: from haric-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 21:51:10 -0700
From:   <quic_haric@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH] mac80211 : fix bw change to 40 MHz during channel switch
Date:   Fri, 8 Apr 2022 10:20:52 +0530
Message-ID: <1649393452-11704-1-git-send-email-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Hari Chandrakanthan <quic_haric@quicinc.com>

When AP reduces its channel bandwidth from 80 MHz to 40 MHz, the associated
station reduces the channel bandwidth from 80 MHz to 20 MHz.

In the above case, the associated sta is expected to reduce the channel
bandwidth to 40 MHz.

The API ieee80211_parse_ch_switch_ie which parses CSA element,
checks for 80 MHz and 160 MHz if wide band channel switch element and does not
consider 40 MHz.

From IEEE Std 802.11-2020 9.4.2.162 Channel Switch Wrapper element :

The Wide Bandwidth Channel Switch subelement is present under the
following conditions:
1.Channel switching to a BSS operating channel width of 40 MHz or
wider
2.Extended channel switching to a BSS operating channel width of
80 MHz or wider

So if a station receives a CSA element from AP and if Wide Bandwidth Channel
Switch subelement is present, station can assume that ap is switching to a
bandwidth of 40 MHz and higher.

To fix the issue, station can assume 40 MHz as default new channel bandwidth
if Wide Bandwidth Channel Switch subelement is present.

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
---
 net/mac80211/spectmgmt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index 76747bf..cc29436 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -148,6 +148,11 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 					    IEEE80211_HT_OP_MODE_CCFS2_SHIFT),
 		};
 
+		csa_ie->chandef.width = NL80211_CHAN_WIDTH_40;
+		csa_ie->chandef.center_freq1 =
+			ieee80211_channel_to_frequency(wide_bw_chansw_ie->new_center_freq_seg0,
+						       new_chan->band);
+
 		/* default, for the case of IEEE80211_VHT_CHANWIDTH_USE_HT,
 		 * to the previously parsed chandef
 		 */
-- 
2.7.4

