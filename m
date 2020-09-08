Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6C2618E6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbgIHR6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 13:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbgIHQMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:46 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43ABC06136A
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bmw2xoKPGbQI0D8yI49ROdm9it8RGSMSPf2EPtMd0t4=; b=sPXEex8UPkTjswKriP3rlFGG6H
        iLBpmeoJEo+pEmROU3j5w4L4Lmi7dIZoEq6TLUYOTNbF0jIdAosEizvn7r1qgu2W3iwttYk5R6CUu
        kEDxzTTvROR3JuVcafHjhD3gJiY5DSMisJXPECcteqowPhJxgMEZX8rP5OoNMp17/4N0=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFcrw-00050i-KS; Tue, 08 Sep 2020 14:37:04 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v4 01/14] mac80211: add missing queue/hash initialization to 802.3 xmit
Date:   Tue,  8 Sep 2020 14:36:49 +0200
Message-Id: <20200908123702.88454-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908123702.88454-1-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes AQL for encap-offloaded tx

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d2136007e2eb..bee9b01c5a6b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4209,6 +4209,12 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	if (is_zero_ether_addr(ra))
 		goto out_free;
 
+	if (local->ops->wake_tx_queue) {
+		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
+		skb_set_queue_mapping(skb, queue);
+		skb_get_hash(skb);
+	}
+
 	multicast = is_multicast_ether_addr(ra);
 
 	if (sta)
-- 
2.28.0

