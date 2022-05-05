Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA951CAE1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 23:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385532AbiEEVIO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385511AbiEEVIL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 17:08:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528985EBED
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 14:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=anIbNK3VEilWFiQ9WVjT/uS/j7QzljAsnGLvifpUJUY=;
        t=1651784670; x=1652994270; b=U3GYuFFHfFnXkiwJPNEiwTiSz3fuz5DuVKpx6zilcMfoBr+
        V2wUWWuTEBl/x4sKYbSAp8LzHuoMVbQkSYJ/3PJF2ueQVV/QDvKrMr1Evns4GxDwKDm6gskND6o37
        rgni5Ss93gYaknHsCeemuMQZNO6IyqlIdbxcFG0kTE/4FxUij8N4/q2qmEO/tY+IskdC2Inii3QeD
        U+5lMXgEgPE+1qaazs/MEiZEOaZv0Je0q4CdtWRAo60IxhgQOmtJM0cqS16otaWkRBcqhjGbJ7Spn
        5vWlH9/sB6ii/8kUMo+3jzFKJ1TThSVaqwBBXO8D5GQbHmxEd9bC3NhJxl29HZCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmie9-0032Mz-65;
        Thu, 05 May 2022 23:04:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] mac80211_hwsim: call ieee80211_tx_prepare_skb under RCU protection
Date:   Thu,  5 May 2022 23:04:22 +0200
Message-Id: <20220505230421.5f139f9de173.I77ae111a28f7c0e9fd1ebcee7f39dbec5c606770@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505230421.fb8055c081a2.Ic6da3307c77a909bd61a0ea25dc2a4b08fe1b03f@changeid>
References: <20220505230421.fb8055c081a2.Ic6da3307c77a909bd61a0ea25dc2a4b08fe1b03f@changeid>
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

This is needed since it might use (and pass out) pointers to
e.g. keys protected by RCU. Can't really happen here as the
frames aren't encrypted, but we need to still adhere to the
rules.

Fixes: cacfddf82baf ("mac80211_hwsim: initialize ieee80211_tx_info at hw_scan_work")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 4689db129aec..2f746eb64507 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2478,11 +2478,13 @@ static void hw_scan_work(struct work_struct *work)
 			if (req->ie_len)
 				skb_put_data(probe, req->ie, req->ie_len);
 
+			rcu_read_lock();
 			if (!ieee80211_tx_prepare_skb(hwsim->hw,
 						      hwsim->hw_scan_vif,
 						      probe,
 						      hwsim->tmp_chan->band,
 						      NULL)) {
+				rcu_read_unlock();
 				kfree_skb(probe);
 				continue;
 			}
@@ -2490,6 +2492,7 @@ static void hw_scan_work(struct work_struct *work)
 			local_bh_disable();
 			mac80211_hwsim_tx_frame(hwsim->hw, probe,
 						hwsim->tmp_chan);
+			rcu_read_unlock();
 			local_bh_enable();
 		}
 	}
-- 
2.35.1

