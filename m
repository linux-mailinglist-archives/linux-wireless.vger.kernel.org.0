Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF67A5A0F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 08:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjISGlJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 02:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjISGlI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 02:41:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC1116
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 23:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=nuOFkwXcHMlONqrxvS6YnEruBw2TgS/r6GuSmCj8Q+Q=; t=1695105658; x=1696315258; 
        b=nOyW8fTU6uBYVUk+nepO7cufqWL/myzenfZ6vVaSk6KwY0yP6PNacFFQHx8YJgukryhk71AzzHM
        C++PqgCURmwKMpDBxzgeaH6p42UFftk2wJvHEuwqUEUdSwnqgWYUTcnhTxF+xv3dNZxltohJWDaKI
        OzAHLDZf0zVfWaRn3hoZ432kQVLHIfIdR0qc/swqQkm9Q+imwTTSxkrLXFn5Cwy/keIFYv1IuASNz
        mFJgFMNvVdW0Yi9v2TmrkuiTRLrrJLAkUpaSulO3nGgnl1EDW/46YiVPefdMMiSQTeP1QKhf4F09D
        PvvvENlyRbKwSKUbrJT3uH3ghrPmEYtq35lA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qiUPm-008uK6-1g;
        Tue, 19 Sep 2023 08:40:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+c12a771b218dcbba32e1@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: ethtool: always hold wiphy mutex
Date:   Tue, 19 Sep 2023 08:40:52 +0200
Message-ID: <20230919084051.942b0bbde0ce.I7215d6cd3bcb4bb8631ddf872356408dd69477fe@changeid>
X-Mailer: git-send-email 2.41.0
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

Drivers should really be able to rely on the wiphy mutex
being held all the time, unless otherwise documented. For
ethtool, that wasn't quite right. Fix and clarify this in
both code and documentation.

Reported-by: syzbot+c12a771b218dcbba32e1@syzkaller.appspotmail.com
Fixes: 0e8185ce1dde ("wifi: mac80211: check wiphy mutex in ops")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 4 ++++
 net/mac80211/ethtool.c | 9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 8d993f6ab919..c8bc36821b54 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4067,11 +4067,15 @@ struct ieee80211_prep_tx_info {
  *	This callback must be atomic.
  *
  * @get_et_sset_count:  Ethtool API to get string-set count.
+ *	Note: the wiphy mutex is not held for this callback since it's
+ *	expected to return a static value.
  *
  * @get_et_stats:  Ethtool API to get a set of u64 stats.
  *
  * @get_et_strings:  Ethtool API to get a set of strings to describe stats
  *	and perhaps other supported types of ethtool data-sets.
+ *	Note: the wiphy mutex is not held for this callback since it's
+ *	expected to return a static value.
  *
  * @mgd_prepare_tx: Prepare for transmitting a management frame for association
  *	before associated. In multi-channel scenarios, a virtual interface is
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 9894d2024470..f2e8c2eff25f 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -19,11 +19,16 @@ static int ieee80211_set_ringparam(struct net_device *dev,
 				   struct netlink_ext_ack *extack)
 {
 	struct ieee80211_local *local = wiphy_priv(dev->ieee80211_ptr->wiphy);
+	int ret;
 
 	if (rp->rx_mini_pending != 0 || rp->rx_jumbo_pending != 0)
 		return -EINVAL;
 
-	return drv_set_ringparam(local, rp->tx_pending, rp->rx_pending);
+	wiphy_lock(sdata->local->hw.wiphy);
+	ret = drv_set_ringparam(local, rp->tx_pending, rp->rx_pending);
+	wiphy_unlock(sdata->local->hw.wiphy);
+
+	return ret;
 }
 
 static void ieee80211_get_ringparam(struct net_device *dev,
@@ -35,8 +40,10 @@ static void ieee80211_get_ringparam(struct net_device *dev,
 
 	memset(rp, 0, sizeof(*rp));
 
+	wiphy_lock(sdata->local->hw.wiphy);
 	drv_get_ringparam(local, &rp->tx_pending, &rp->tx_max_pending,
 			  &rp->rx_pending, &rp->rx_max_pending);
+	wiphy_unlock(sdata->local->hw.wiphy);
 }
 
 static const char ieee80211_gstrings_sta_stats[][ETH_GSTRING_LEN] = {
-- 
2.41.0

