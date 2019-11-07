Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1EDF2DBA
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 12:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbfKGLv6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 06:51:58 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55144 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387468AbfKGLv6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 06:51:58 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iSgKR-0000wr-Uw; Thu, 07 Nov 2019 13:51:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  7 Nov 2019 13:51:48 +0200
Message-Id: <20191107115149.10709-2-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191107115149.10709-1-luca@coelho.fi>
References: <20191107115149.10709-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.4 2/3] mac80211: fix ieee80211_txq_setup_flows() failure path
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If ieee80211_txq_setup_flows() fails, we don't clean up WEP/LED
state properly, leading to crashes later on, fix that.

Fixes: dc8b274f0952 ("mac80211: Move up init of TXQs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index aba094b4ccfc..2d05c4cfaf6d 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1292,8 +1292,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	ieee80211_remove_interfaces(local);
  fail_rate:
 	rtnl_unlock();
-	ieee80211_led_exit(local);
  fail_flows:
+	ieee80211_led_exit(local);
 	destroy_workqueue(local->workqueue);
  fail_workqueue:
 	wiphy_unregister(local->hw.wiphy);
-- 
2.24.0.rc1

