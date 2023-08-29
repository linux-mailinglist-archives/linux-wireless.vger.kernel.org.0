Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73A178C165
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjH2J1J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 05:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjH2J0r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 05:26:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF7BE62
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=tUNrWcUAQLNEbzibUIyu1Nq8RRHNNYXfJ7ogebN5tfs=; t=1693301179; x=1694510779; 
        b=bAXh/80FpcPxUhcAtmQopQCd6AviB+NanpfJYXon38Qhv12VCHzRqj2uv/LSR+heMQ1B8oUTed9
        HjsqVsy8kAQAd5cIPxXiMuhq0BVuIpLWaMb0MIXL8WIZUOkgkrN8dCFPxsg9TS2TaOvrlRBRxq9oD
        omKm8HBGtvV80kSrnLuf76+hXbeeSiFsxqwcUT1kHO87LKtNGIhxka25H/lxH0+t3mHLX3W8PJlDL
        i2VJHF1G/BiMf47jt0KCJa5f8Y4PtEe+6UvdKsGrdbgBuVpw0eFpH0KXVf0jDdiztWgSFrxkIcy+v
        Wv8hUFkBsYZ3GoHEqRhOam/SaxjqKwpUxNIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qauyu-000wq5-30;
        Tue, 29 Aug 2023 11:25:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>
Subject: [PATCH] wifi: mac80211: fix TXQ error path and cleanup
Date:   Tue, 29 Aug 2023 11:25:50 +0200
Message-ID: <20230829112549.e59574974cf9.I45c44136c03e941ee6d2c391eb45d61154278a7a@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We currently call ieee80211_txq_teardown_flows() as part
of ieee80211_remove_interfaces(), but that's not really
right in case of HW registration failures, specifically
rate control. Call it separately to fix that issue.

Reported-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 2 --
 net/mac80211/main.c  | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7e3acf670f0f..510f8aead4f9 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2255,8 +2255,6 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 	WARN(local->open_count, "%s: open count remains %d\n",
 	     wiphy_name(local->hw.wiphy), local->open_count);
 
-	ieee80211_txq_teardown_flows(local);
-
 	mutex_lock(&local->iflist_mtx);
 	list_splice_init(&local->interfaces, &unreg_list);
 	mutex_unlock(&local->iflist_mtx);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 0ab603850a85..eabf6c1bf3ff 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1457,6 +1457,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	ieee80211_remove_interfaces(local);
 	rtnl_unlock();
  fail_rate:
+	ieee80211_txq_teardown_flows(local);
  fail_flows:
 	ieee80211_led_exit(local);
 	destroy_workqueue(local->workqueue);
@@ -1493,6 +1494,8 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 	 */
 	ieee80211_remove_interfaces(local);
 
+	ieee80211_txq_teardown_flows(local);
+
 	wiphy_lock(local->hw.wiphy);
 	wiphy_delayed_work_cancel(local->hw.wiphy, &local->roc_work);
 	wiphy_work_cancel(local->hw.wiphy, &local->reconfig_filter);
-- 
2.41.0

