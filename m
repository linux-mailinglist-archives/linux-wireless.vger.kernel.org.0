Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8314444CB47
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 22:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhKJVYz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 16:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhKJVYy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 16:24:54 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B203C061766
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jHDvXQcNzSSJDvWeCzvjymSINyy0TXUY90dc3Fz5hBs=; b=jwRtPQA4lGDm3MngjrRh7LmIUF
        /aAORiaENwQ/hvyshYutFLaNeCrXKW32GXwMcZSYa0ZEcjZVCXcRh7BsWUOS+I7oS8HcjnRwmiy63
        aEELbn1GSUgHyk04JVdBsOLDnG0bdVc34ZOM73RaaVcbLMhfzSfP9/R7r+PdwT9bRygg=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mkv2h-0006mT-Kk; Wed, 10 Nov 2021 22:22:03 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Mathy.Vanhoef@kuleuven.be
Subject: [PATCH] mac80211: drop check for DONT_REORDER in __ieee80211_select_queue
Date:   Wed, 10 Nov 2021 22:22:01 +0100
Message-Id: <20211110212201.35452-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When __ieee80211_select_queue is called, skb->cb has not been cleared yet,
which means that info->control.flags can contain garbage.
In some cases this leads to IEEE80211_TX_CTRL_DONT_REORDER being set, causing
packets marked for other queues to randomly end up in BE instead.

This flag only needs to be checked in ieee80211_select_queue_80211, since
the radiotap parser is the only piece of code that sets it

Fixes: 66d06c84730c ("mac80211: adhere to Tx control flag that prevents frame reordering")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/wme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index 9ea6004abe1b..62c6733e0792 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -143,7 +143,6 @@ u16 ieee80211_select_queue_80211(struct ieee80211_sub_if_data *sdata,
 u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 			     struct sta_info *sta, struct sk_buff *skb)
 {
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct mac80211_qos_map *qos_map;
 	bool qos;
 
@@ -156,7 +155,7 @@ u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 	else
 		qos = false;
 
-	if (!qos || (info->control.flags & IEEE80211_TX_CTRL_DONT_REORDER)) {
+	if (!qos) {
 		skb->priority = 0; /* required for correct WPA/11i MIC */
 		return IEEE80211_AC_BE;
 	}
-- 
2.30.1

