Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82D278AF89
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjH1MFt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjH1MFZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC244123
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=eQEVGXj3CRF6jXQOf2g1stP/S3rKhdYuAnPiNWLu82c=;
        t=1693224323; x=1694433923; b=DRVP+s42eDPCGxdOYHFMAP83pO2+ddGnB/Hn1lyBfUHSu1/
        f5pHeZuxLzwlCTLkh3kjW7ZW2XlwQ6bt/LO4ijfQUKZR0Aky45bcSUznf9oZukw4gu8mTniQYbS+s
        u3J2GNP79IUl/BX54yXBsuPPEAhnlp/oTFmWgw5zzu5Df/FTXZtYa8h6ek7BL9yZ7tPh502cDMJDX
        a878a2bOBDYBEgZXkxiFsrg9p6z3HY1pUA8e0/APqo3Vlal6jAlCB+a+ltiSNsisvfD4Ob12e0fMh
        PoCg94ZXouaxm4LmPRYyMQzjL7SC/+HHRmOQehJfg2gXYX+/TqeKjSN7R3jhjRvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazh-00Gjgt-17;
        Mon, 28 Aug 2023 14:05:21 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/40] wifi: mac80211: flush wiphy work where appropriate
Date:   Mon, 28 Aug 2023 13:59:34 +0200
Message-ID: <20230828135927.4320ac0c3b18.I6367381100057ec84e8e7ebc6dfc4ac0b68282a4@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Before converting more works to wiphy work, add
flushing in mac80211 where we also flush the
mac80211 workqueue. Not needed in suspend since
cfg80211 will have taken care of it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 1 +
 net/mac80211/util.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 24315d7b3126..aeb21cfe789a 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -343,6 +343,7 @@ static void ieee80211_restart_work(struct work_struct *work)
 	rtnl_lock();
 	/* we might do interface manipulations, so need both */
 	wiphy_lock(local->hw.wiphy);
+	wiphy_work_flush(local->hw.wiphy, NULL);
 
 	WARN(test_bit(SCAN_HW_SCANNING, &local->scanning),
 	     "%s called with hardware scan in progress\n", __func__);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8a6917cf63cf..6d8b73796dc5 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2319,6 +2319,7 @@ void ieee80211_stop_device(struct ieee80211_local *local)
 	cancel_work_sync(&local->reconfig_filter);
 
 	flush_workqueue(local->workqueue);
+	wiphy_work_flush(local->hw.wiphy, NULL);
 	drv_stop(local);
 }
 
-- 
2.41.0

