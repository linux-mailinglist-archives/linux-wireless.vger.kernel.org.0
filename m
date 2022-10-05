Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAEE5F54D4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJENA5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJENAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70071EEC9
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Dz3cpMbKVTgi/LgtRVPv4Yp0tjzRZpJdH55/cnHyiXY=;
        t=1664974853; x=1666184453; b=isrgxQkMGYJB3+CtX5eoG6QSDJdM3vRNEycccob1f1wjkDN
        uxRoTawQNCQep/aJejYB7/CTrDrfZvRCEZKjqTw/naDQnHx6g1Sylmk9ie244B+I1XDbbxBgFH9Dd
        rud1vg6utC4hQuSURNMoSd2N5obQX2NV7aikr7iXM1AUmv2Q2ZL1/GsVF3/QmgJGK1FmmWEwqBJoV
        NoTU9vZo1Mp/HvBJvwpg3kwP8I+t5MbrXsf42AEU0rrJH8Zb+sDn5KguyZGuRULLErRgnT6QEuO5c
        t1Caj9I3Xmf/K5K62broNUKeelwYeI8eq8pnUqr7NDH0seJfPWYfwnLREq1aBCyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og414-00G2RL-2X;
        Wed, 05 Oct 2022 15:00:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 01/28] wifi: mac80211: add pointer from link STA to STA
Date:   Wed,  5 Oct 2022 15:00:21 +0200
Message-Id: <20221005145226.79cdfa994df6.I362a711645dc73579dfc3c93fb553f8ffc98765c@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

While often not needed, this considerably simplifies going from a link
to the STA. This helps in cases such as debugfs where a single pointer
should allow accessing a specific link and the STA.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h  | 3 +++
 net/mac80211/sta_info.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ac2bad57933f..7778a92d9582 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2176,6 +2176,7 @@ struct ieee80211_sta_aggregates {
  * All link specific info for a STA link for a non MLD STA(single)
  * or a MLD STA(multiple entries) are stored here.
  *
+ * @sta: reference to owning STA
  * @addr: MAC address of the Link STA. For non-MLO STA this is same as the addr
  *	in ieee80211_sta. For MLO Link STA this addr can be same or different
  *	from addr in ieee80211_sta (representing MLD STA addr)
@@ -2196,6 +2197,8 @@ struct ieee80211_sta_aggregates {
  *
  */
 struct ieee80211_link_sta {
+	struct ieee80211_sta *sta;
+
 	u8 addr[ETH_ALEN];
 	u8 link_id;
 	enum ieee80211_smps_mode smps_mode;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cebfd148bb40..71b1488bd390 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -511,6 +511,7 @@ static void sta_info_add_link(struct sta_info *sta,
 	link_info->sta = sta;
 	link_info->link_id = link_id;
 	link_info->pub = link_sta;
+	link_info->pub->sta = &sta->sta;
 	link_sta->link_id = link_id;
 	rcu_assign_pointer(sta->link[link_id], link_info);
 	rcu_assign_pointer(sta->sta.link[link_id], link_sta);
-- 
2.37.3

