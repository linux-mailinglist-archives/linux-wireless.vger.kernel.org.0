Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA1573A37
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbiGMPer (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiGMPem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072173FA22
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2gxJf+24sS74868SelZRPE/r131WVxGbsGNG97XeGEA=;
        t=1657726481; x=1658936081; b=pzAIew+rtsr/jW6o+gf3BuJCZ5fncElfk36NdAY4lFNRuf0
        BiCOTV5021DMfCWaYWPP4r3V9zecmRCYCLpt2pmwADuULixpY7UyNg8gD2rJfVxAVJ0gN1EEDpy0P
        hPYGU5HRuM9hY0gqXpQOWNc7RimJzXQV4JCAYVCjLBAkD5GYsCAI/PGtDy9dsmADENJW8jtBjekBv
        ZH/Syp34/+JRw6y2xhqeoRPBR+BiSf17dz7Qj/XPAgyyF6Vj++rruZE/KmQZ88Sr3Q46N25ZkNL/H
        v/a8N64gO1edT+kpSmsSWJ6jyspi15+tVA/5IixJdJ07/0exHPqxL4kuB2p8g1zA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNq-00EnaA-Gn;
        Wed, 13 Jul 2022 17:34:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/21] wifi: mac80211: release channel context on link stop
Date:   Wed, 13 Jul 2022 17:34:17 +0200
Message-Id: <20220713173301.be8c59cca5e7.Iec7ad2a4c925d9256891b75ba845540e93d12a99@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

When a link is stopped for removal, release the channel
context it may have.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 271fc81a5ea4..b11374115ff2 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -420,6 +420,8 @@ static void ieee80211_link_stop(struct ieee80211_link_data *link)
 {
 	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
 		ieee80211_mgd_stop_link(link);
+
+	ieee80211_link_release_channel(link);
 }
 
 struct link_container {
-- 
2.36.1

