Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9DB7CE4C1
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfJGOKY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 10:10:24 -0400
Received: from nbd.name ([46.4.11.11]:59050 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbfJGOKY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 10:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xpsgVLAhty0xvbV0v5NJk/FBqH3pVGiT5oePlgM8iSU=; b=DMSgVurAX8HNMH6L0YNq6U/muA
        opNe0su59G0VNIwOd9eTLJIQOuIwOcSfLCqbO06hSkAjPQPp5KNdhsEkUUFeW8quvxR54grBFOjN7
        QQU3zBUfi5VWlILsZcyC62sHuKPqXlbQcT1peSln74wN8Sh8UZF3uyfg1ThrHmny4uRo=;
Received: from p54ae9582.dip0.t-ipconnect.de ([84.174.149.130] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iHTiQ-0002Wo-Um
        for linux-wireless@vger.kernel.org; Mon, 07 Oct 2019 16:10:23 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 5B6E46AB2C99; Mon,  7 Oct 2019 16:10:22 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt76: drop rcu read lock in mt76_rx_aggr_stop
Date:   Mon,  7 Oct 2019 16:10:20 +0200
Message-Id: <20191007141022.75184-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191007141022.75184-1-nbd@nbd.name>
References: <20191007141022.75184-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A rcu read locked section is not allowed to sleep, and the rcu lock here
isn't actually necessary, because we're holding dev->mutex.
Fixes an issue when the tid work item is still running while freeing
a station or stopping the aggregation session

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 2276fd4e9ec3..b05d439dca3b 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -277,17 +277,13 @@ static void mt76_rx_aggr_shutdown(struct mt76_dev *dev, struct mt76_rx_tid *tid)
 
 void mt76_rx_aggr_stop(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tidno)
 {
-	struct mt76_rx_tid *tid;
-
-	rcu_read_lock();
+	struct mt76_rx_tid *tid = NULL;
 
-	tid = rcu_dereference(wcid->aggr[tidno]);
+	rcu_swap_protected(wcid->aggr[tidno], tid,
+			   lockdep_is_held(&dev->mutex));
 	if (tid) {
-		rcu_assign_pointer(wcid->aggr[tidno], NULL);
 		mt76_rx_aggr_shutdown(dev, tid);
 		kfree_rcu(tid, rcu_head);
 	}
-
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(mt76_rx_aggr_stop);
-- 
2.17.0

