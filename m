Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E24F0013
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 15:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbfKEOlc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 09:41:32 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:36558 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfKEOlc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 09:41:32 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iS01H-0008U3-VY; Tue, 05 Nov 2019 15:41:20 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix ieee80211_txq_setup_flows() failure path
Date:   Tue,  5 Nov 2019 15:41:11 +0100
Message-Id: <20191105154110.1ccf7112ba5d.I0ba865792446d051867b33153be65ce6b063d98c@changeid>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If ieee80211_txq_setup_flows() fails, we don't clean up LED
state properly, leading to crashes later on, fix that.

Fixes: dc8b274f0952 ("mac80211: Move up init of TXQs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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
2.20.1

