Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7A55ACBE
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jun 2022 23:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiFYVYW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jun 2022 17:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiFYVYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jun 2022 17:24:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DECA13F39
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jun 2022 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bR2RUPUkWWAzbxL8eF6zc5illViuxH8B5Sbe3Rf7rn0=; b=dxb03xaE1GkK8AXZ2TfOAJ6fT7
        VE6Lt28dEJSLy5wuRWf4CHiFVUeKJzoHKGjX24+aYOtcivFDxxlXDaSVExcDRCgSoQ4M9eDS40KN7
        fmPk9M6Cq/top2OLbkNpQnR9x2lb3lh8BiM2mjkNNf2M+Or6VDwtzUmi18stJIbg+Ri8=;
Received: from p200300daa733bc000d99dad39793d523.dip0.t-ipconnect.de ([2003:da:a733:bc00:d99:dad3:9793:d523] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o5DGI-0003Vi-CB; Sat, 25 Jun 2022 23:24:14 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     toke@kernel.org, johannes@sipsolutions.net
Subject: [PATCH 7/7] mac80211: only accumulate airtime deficit for active clients
Date:   Sat, 25 Jun 2022 23:24:11 +0200
Message-Id: <20220625212411.36675-7-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625212411.36675-1-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When a client does not generate any local tx activity, accumulating airtime
deficit for the round-robin scheduler can be harmful. If this goes on for too
long, the deficit could grow quite large, which might cause unreasonable
initial latency once the client becomes active

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/sta_info.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 28ab55a072c6..c9852f71e8e1 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2046,6 +2046,7 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 	struct ieee80211_local *local = sta->sdata->local;
 	u8 ac = ieee80211_ac_from_tid(tid);
 	u32 airtime = 0;
+	u32 diff;
 
 	if (sta->local->airtime_flags & AIRTIME_USE_TX)
 		airtime += tx_airtime;
@@ -2055,7 +2056,11 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 	spin_lock_bh(&local->active_txq_lock[ac]);
 	sta->airtime[ac].tx_airtime += tx_airtime;
 	sta->airtime[ac].rx_airtime += rx_airtime;
-	sta->airtime[ac].deficit -= airtime;
+
+	diff = (u32)jiffies - sta->airtime[ac].last_active;
+	if (diff <= AIRTIME_ACTIVE_DURATION)
+		sta->airtime[ac].deficit -= airtime;
+
 	spin_unlock_bh(&local->active_txq_lock[ac]);
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
-- 
2.36.1

