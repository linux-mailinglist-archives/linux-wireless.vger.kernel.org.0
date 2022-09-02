Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F7B5AB43B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbiIBOvl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiIBOvG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FDF54CB4
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LQITI4s8B3FApvbu+3r828hGRyAymW8FVqoTB6EJHm4=;
        t=1662127991; x=1663337591; b=tPFESsygphgJ4gJGIp+CZydjdeg0Kvu/QFmeAq4/ntEda84
        AmrTV6XYiUk6FPsfDMJNi42vGj4Y4SD4utyvEGlFpU+z+Vv9VgvAUOTRf6feKpvm9kcdlHi0/KY9V
        dceAnAYSsovLT7oTxrG28UZysHYbj0+rm4BKUcoerDMGg4qBARLmbXzBjuRtqgCVfdSN5Kg0zki8d
        nEw3WhNCAVUOpocgF4iRacBUpHO4cLhSDLG78HdKygMTe/ESEdRU9wGMToUglLusqJKt2+TPR2DLs
        gPwylSAMGh7sAdJnBOPNt1xd6UOW+p3vrlb6Nu4IYGvpef1ahJcxde81TS27VvnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Px-006Ch3-1a;
        Fri, 02 Sep 2022 16:13:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/27] wifi: mac80211_hwsim: send NDP for link (de)activation
Date:   Fri,  2 Sep 2022 16:12:48 +0200
Message-Id: <20220902161143.426a1e56732c.I1755040c1c9adcc60358cb21e03ffee246117547@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
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

In hwsim we now track when we receive NDP (or other frames
carrying a PM bit) to see if a link should be active, but
then of course we also need to transmit NDPs to at least
set a link to inactive when we deacivate it. Implement that
as well as sending an NDP when we activate a link, which
allows receiving frames before transmitting any.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index b5bc707d8e4e..18339a56316d 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2966,6 +2966,18 @@ static int mac80211_hwsim_assign_vif_chanctx(struct ieee80211_hw *hw,
 	hwsim_check_magic(vif);
 	hwsim_check_chanctx_magic(ctx);
 
+	/* if we activate a link while already associated wake it up */
+	if (vif->type == NL80211_IFTYPE_STATION && vif->cfg.assoc) {
+		struct sk_buff *skb;
+
+		skb = ieee80211_nullfunc_get(hw, vif, link_conf->link_id, true);
+		if (skb) {
+			local_bh_disable();
+			mac80211_hwsim_tx_frame(hw, skb, ctx->def.chan);
+			local_bh_enable();
+		}
+	}
+
 	return 0;
 }
 
@@ -2976,6 +2988,22 @@ static void mac80211_hwsim_unassign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	hwsim_check_magic(vif);
 	hwsim_check_chanctx_magic(ctx);
+
+	/* if we deactivate a link while associated suspend it first */
+	if (vif->type == NL80211_IFTYPE_STATION && vif->cfg.assoc) {
+		struct sk_buff *skb;
+
+		skb = ieee80211_nullfunc_get(hw, vif, link_conf->link_id, true);
+		if (skb) {
+			struct ieee80211_hdr *hdr = (void *)skb->data;
+
+			hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
+
+			local_bh_disable();
+			mac80211_hwsim_tx_frame(hw, skb, ctx->def.chan);
+			local_bh_enable();
+		}
+	}
 }
 
 static const char mac80211_hwsim_gstrings_stats[][ETH_GSTRING_LEN] = {
-- 
2.37.2

