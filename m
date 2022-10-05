Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F655F54EF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJENBl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiJENBA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:01:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661678598
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WQSHX7a3BLWpRk6Ls7uz7U33b97yHn8sRUi+9tXhHJU=;
        t=1664974859; x=1666184459; b=UjzjdBxw+tsQJTZnAuuPyHQ9bfZ6uMW1c2kgzJIYCfWay5t
        UETDOyIfnf93JZ70p+SHGH4BkF0mHaXrPPbz8YR118xzoekxxLw0nfT+XslGRIgmhN3Q38smc/xEg
        TOpspt83t8zsjY+40eHczNYIADeBctrjmR/+H6CMvVDueuQX2fJsId2h3HZoC3Vi/I0bP1VEizAXH
        WBwQDhXMnSAv/rUB9VyzCE2wdY6J2f/oIcE68HjAIX4CbbH3q0px+JE/Lih7ts/GRpMZTk3kHFWUc
        p2dYCNaIVTN4KSuyltHQrvgt6NiXZWUd3+fE8qh4f4ZvnT7J2/EgjTxJ+YcAyNnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og41B-00G2RL-1u;
        Wed, 05 Oct 2022 15:00:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 28/28] wifi: mac80211: fix ifdef symbol name
Date:   Wed,  5 Oct 2022 15:00:48 +0200
Message-Id: <20221005145226.32ee46c4bda7.I7205d59557ee48d7b4dc2a72a5295ada426c7ce2@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
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

This should of course be CONFIG_, not CPTCFG_, which is an
artifact from working with backports.

Fixes: 9dd1953846c7 ("wifi: nl80211/mac80211: clarify link ID in control port TX")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 27c964be102e..d9e7a2ed5d2c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2971,7 +2971,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 
 		if (pre_conf_link_id != link_id &&
 		    link_id != IEEE80211_LINK_UNSPECIFIED) {
-#ifdef CPTCFG_MAC80211_VERBOSE_DEBUG
+#ifdef CONFIG_MAC80211_VERBOSE_DEBUG
 			net_info_ratelimited("%s: dropped frame to %pM with bad link ID request (%d vs. %d)\n",
 					     sdata->name, hdr.addr1,
 					     pre_conf_link_id, link_id);
-- 
2.37.3

