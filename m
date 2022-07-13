Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F7573323
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiGMJpN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbiGMJpK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D1E0279
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iMXRL1IqDkOptLlFdMeThVCZYDALiu33p00E5x+o1Eg=;
        t=1657705508; x=1658915108; b=IjW8ScZnxORvBkdX3QL/PggDtZUC3hILr3JU9zgcpS7AKkn
        2owQlr4SF5nc4/TYrOrc4PJKtS0HiDbuWDmpv2vt9QjuiljsFZRCxdPIIglWAWdsRI2LndLKlWBWD
        ZP+wj/ZimJJ51qk3ebGmQ/bLrsecRaLeWjFZZMA6QLFAWdffDZ5fe8ltKpKZ32bx+YC4OmlnJ96Vg
        5UjxwZ7ycY8Og0V5GHeDC8Ao7NGnGlUW03cOlXG3TdCe/OwOg+Ux5ATZSEMjQTz+vQ5PEVJ8JAXXJ
        l04eJzMIZF0Ulm60lICgIt/2WPBrQc03P23+PVF2aJUDIaLfFqb3NtXDCSMh2MYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYva-00EgvB-IC;
        Wed, 13 Jul 2022 11:45:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 07/76] wifi: mac80211: add an ieee80211_get_link_sband
Date:   Wed, 13 Jul 2022 11:43:53 +0200
Message-Id: <20220713114425.643de96a8383.I7e6296e1c8b4d4fe9909056621940c5e02e76eea@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

From: Shaul Triebitz <shaul.triebitz@intel.com>

Similar to ieee80211_get_sband but get the sband of the link_conf.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 18bab27eda4f..a0023ad7ca1c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1543,6 +1543,28 @@ ieee80211_get_sband(struct ieee80211_sub_if_data *sdata)
 	return local->hw.wiphy->bands[band];
 }
 
+static inline struct ieee80211_supported_band *
+ieee80211_get_link_sband(struct ieee80211_sub_if_data *sdata, u32 link_id)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+	enum nl80211_band band;
+
+	rcu_read_lock();
+	chanctx_conf =
+		rcu_dereference(sdata->vif.link_conf[link_id]->chanctx_conf);
+
+	if (!chanctx_conf) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	band = chanctx_conf->def.chan->band;
+	rcu_read_unlock();
+
+	return local->hw.wiphy->bands[band];
+}
+
 /* this struct holds the value parsing from channel switch IE  */
 struct ieee80211_csa_ie {
 	struct cfg80211_chan_def chandef;
-- 
2.36.1

