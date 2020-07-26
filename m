Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6722DF6D
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jul 2020 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGZNJv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jul 2020 09:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgGZNJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jul 2020 09:09:51 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B741C0619D4
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jul 2020 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ASbKazThAxyPI+gS02+4Qf0lChoQbWaIBby5Xxgm/sQ=; b=PXpTcGMFjC6zGuqT9BSRRjMjmX
        wIZdjYQ35UrvZiVXhpAuG2hhDb79kuBAQeBdqzx5g5Wwdr+eh+Hrg+Ac/EUAaZxZGgh9UZEmPJGte
        xLAsiLhPkJvtgAA2Pofgo+uEx7SF2UUnnCc4u9G6k63NOZeioqlDL2wqxZLGV5iaWwZ8=;
Received: from p5b206d80.dip0.t-ipconnect.de ([91.32.109.128] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jzgPU-0000J8-W4; Sun, 26 Jul 2020 15:09:49 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 2/2] mac80211: calculcate skb hash early when using itxq
Date:   Sun, 26 Jul 2020 15:09:47 +0200
Message-Id: <20200726130947.88145-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200726130947.88145-1-nbd@nbd.name>
References: <20200726130947.88145-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This avoids flow separation issues when using software encryption

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a4e7ef6b0457..7cb73416a372 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3951,6 +3951,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	if (local->ops->wake_tx_queue) {
 		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
 		skb_set_queue_mapping(skb, queue);
+		skb_get_hash(skb);
 	}
 
 	if (sta) {
-- 
2.24.0

