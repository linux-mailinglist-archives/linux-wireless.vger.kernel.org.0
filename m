Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5252DF48
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 23:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiESV1c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 17:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiESV13 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 17:27:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF4E6E8CD
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=Gr6B1tgrAFT+D66yZWb+qNqrwrvW3wthTovF4Vgg5sQ=; t=1652995647; x=1654205247; 
        b=avGhM1wXwi4WcDoWyIBL6ayuKRl6VWgVYWBo6adYNJtvwvHRVrw/jOhnFAVKpNM//VowPr0v8Kw
        NJ+gBTJF1nKO28izlKXdPeq0PXDF561kbA1/4+5UWlbpZnLQMgKHMs7NquAaF/vBR+wvPott5VM3d
        z8th0AM8ViZFlDXCWANqWJmXOj4QJkUG1Uh8UNfUkypGcfThCUYHEYdOTHKFHjSqdOHrL4Okbr5bN
        bSEE0HGkwYQmfDGPdyqE6a0X1vg1UIQxbTXicW801Rz66g0DwWhIYYUNARl71pNSUTlSvrDWUPEw6
        dOdFQAlSnaxq9zUx0wHB16Cl4ahU6Y4+wJrg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nrng4-00GZd0-Pa;
        Thu, 19 May 2022 23:27:24 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 1/3] mac80211_hwsim: call ieee80211_tx_prepare_skb under RCU protection
Date:   Thu, 19 May 2022 23:27:20 +0200
Message-Id: <20220519232721.af7f735316fb.I77ae111a28f7c0e9fd1ebcee7f39dbec5c606770@changeid>
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
2.36.1

