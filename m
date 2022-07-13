Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B17573D10
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 21:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiGMTQu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiGMTQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 15:16:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263DB28732
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=eq0gp9Cvea+k7hlT03leopwqP3gpLQDN0cdRDV7r8bc=; t=1657739809; x=1658949409; 
        b=WX6bvW7tnFUvvZtg5dUyaiKS5ILL8WLKihk+nZ/EhBKvOCuijPvht3uGcrasPo8oBiA2MJGOMfB
        eBtXQLuFpF+fQho6FS5kKpcY7MBcmbHd13mAZbDm2cPBPciIrBcq6eUHQycwWAe2NrtpjNNVNf/cS
        AHuaYLZDm74hegCI+l0MTqC2y8lIVswKqYuz131opcD3EYpkQHpeVsX01EBpZ1EFMAOLMkTth+HpC
        Dlmo2Yv87+nFTWKvVnryXN1W2vz+s0M0gpub5GJDPjFhOXlL9+zeUyaJ0NfOkEmqEWV+BnEH7m1eV
        ajXBW6Lcc19wwvLSgUCk+7QjpbBcS+t8/pzw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBhqp-00ErEE-Cg;
        Wed, 13 Jul 2022 21:16:47 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211_hwsim: use 32-bit skb cookie
Date:   Wed, 13 Jul 2022 21:16:45 +0200
Message-Id: <20220713211645.0d320e00e5b6.Ida11d2308dbf999d8bb9b1c49aa6e73af8fd3d33@changeid>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We won't really have enough skbs to need a 64-bit cookie,
and on 32-bit platforms storing the 64-bit cookie into the
void *rate_driver_data doesn't work anyway. Switch back to
using just a 32-bit cookie and uintptr_t for the type to
avoid compiler warnings about all this.

Fixes: 4ee186fa7e40 ("wifi: mac80211_hwsim: fix race condition in pending packet")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 91440b0dc0cc..56dc0c6dab78 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -687,7 +687,7 @@ struct mac80211_hwsim_data {
 	bool ps_poll_pending;
 	struct dentry *debugfs;
 
-	atomic64_t pending_cookie;
+	atomic_t pending_cookie;
 	struct sk_buff_head pending;	/* packets pending */
 	/*
 	 * Only radios in the same group can communicate together (the
@@ -1358,7 +1358,7 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 	int i;
 	struct hwsim_tx_rate tx_attempts[IEEE80211_TX_MAX_RATES];
 	struct hwsim_tx_rate_flag tx_attempts_flags[IEEE80211_TX_MAX_RATES];
-	u64 cookie;
+	uintptr_t cookie;
 
 	if (data->ps != PS_DISABLED)
 		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
@@ -1427,7 +1427,7 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 		goto nla_put_failure;
 
 	/* We create a cookie to identify this skb */
-	cookie = (u64)atomic64_inc_return(&data->pending_cookie);
+	cookie = atomic_inc_return(&data->pending_cookie);
 	info->rate_driver_data[0] = (void *)cookie;
 	if (nla_put_u64_64bit(skb, HWSIM_ATTR_COOKIE, cookie, HWSIM_ATTR_PAD))
 		goto nla_put_failure;
@@ -4207,10 +4207,10 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 	/* look for the skb matching the cookie passed back from user */
 	spin_lock_irqsave(&data2->pending.lock, flags);
 	skb_queue_walk_safe(&data2->pending, skb, tmp) {
-		u64 skb_cookie;
+		uintptr_t skb_cookie;
 
 		txi = IEEE80211_SKB_CB(skb);
-		skb_cookie = (u64)(uintptr_t)txi->rate_driver_data[0];
+		skb_cookie = (uintptr_t)txi->rate_driver_data[0];
 
 		if (skb_cookie == ret_skb_cookie) {
 			__skb_unlink(skb, &data2->pending);
-- 
2.36.1

