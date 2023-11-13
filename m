Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A6E7E9F22
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 15:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjKMOsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 09:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKMOsv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 09:48:51 -0500
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A71A5
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 06:48:44 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c00:2f9f:0:640:dfdd:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 6A5886090D;
        Mon, 13 Nov 2023 17:48:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Amj84jlUtuQ0-NiaHArxL;
        Mon, 13 Nov 2023 17:48:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1699886892; bh=LTQa9sc17ntD9uNZCs1vpw8MhnFcVfJo2L9K62kMj0Y=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=m3vdNVViCbOa0q5me1hZmKRbg7iDu/ANCess5OXbzhh8iFUi0ixhQjNjzu4WFNqTC
         dXI/xBhfbQ+UJToNkhyGHW9HlWW6lLAnOrfZLP0k4ecypYZ/X6NsAIS52210DY6887
         ZloyEqt/nPbBcBVQiMWCKLnJ/+jx7lvYBiLkfTOg=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: rtlwifi: simplify rtl_action_proc() and rtl_tx_agg_start()
Date:   Mon, 13 Nov 2023 17:47:30 +0300
Message-ID: <20231113144734.197359-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113144734.197359-1-dmantipov@yandex.ru>
References: <20231113144734.197359-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'drv_priv' is an in-place member allocated at the end of
'struct ieee80211_sta', it can't be NULL and so relevant checks
in 'rtl_action_proc()' and 'rtl_tx_agg_start()' may be dropped.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/base.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 7ce37fb4fdbf..1a8d715b7c07 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -1402,10 +1402,6 @@ bool rtl_action_proc(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx)
 
 				sta_entry =
 					(struct rtl_sta_info *)sta->drv_priv;
-				if (!sta_entry) {
-					rcu_read_unlock();
-					return true;
-				}
 				capab =
 				  le16_to_cpu(mgmt->u.action.u.addba_req.capab);
 				tid = (capab &
@@ -1760,8 +1756,6 @@ int rtl_tx_agg_start(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return -EINVAL;
 
 	sta_entry = (struct rtl_sta_info *)sta->drv_priv;
-	if (!sta_entry)
-		return -ENXIO;
 	tid_data = &sta_entry->tids[tid];
 
 	rtl_dbg(rtlpriv, COMP_SEND, DBG_DMESG,
@@ -1818,8 +1812,6 @@ int rtl_rx_agg_start(struct ieee80211_hw *hw,
 	}
 
 	sta_entry = (struct rtl_sta_info *)sta->drv_priv;
-	if (!sta_entry)
-		return -ENXIO;
 	tid_data = &sta_entry->tids[tid];
 
 	rtl_dbg(rtlpriv, COMP_RECV, DBG_DMESG,
-- 
2.41.0

