Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4943B1829F0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 08:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbgCLHoI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 03:44:08 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57767 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbgCLHoI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 03:44:08 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02C7hjZ0024403, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02C7hjZ0024403
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 15:43:45 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 15:43:45 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 15:43:45 +0800
From:   <yhchuang@realtek.com>
To:     <johannes@sipsolutions.net>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <arend.vanspriel@broadcom.com>, <anbeltra@microsoft.com>
Subject: [PATCH] mac80211: driver can remain on channel if not using chan_ctx
Date:   Thu, 12 Mar 2020 15:43:37 +0800
Message-ID: <20200312074337.16198-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Some of the drivers are not using channel context, but let the
stack to control/switch channels instead. For such cases, driver
can still remain on channel because the mac80211 stack actually
supports it.

The stack will check if the driver is using chan_ctx and has
ops->remain_on_channel been hooked. Otherwise it will start its
ROC work to remain on channel. So, even if the driver is not
using chan_ctx, the driver is still capable of doing remain on
channel.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 net/mac80211/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 944e86da5c65..fcb0e6e6b4dd 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -576,7 +576,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			WIPHY_FLAG_REPORTS_OBSS |
 			WIPHY_FLAG_OFFCHAN_TX;
 
-	if (ops->remain_on_channel)
+	if (!use_chanctx || ops->remain_on_channel)
 		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
 
 	wiphy->features |= NL80211_FEATURE_SK_TX_STATUS |
-- 
2.17.1

