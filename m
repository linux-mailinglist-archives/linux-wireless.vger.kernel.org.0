Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13811128E9E
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 16:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLVPHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 10:07:19 -0500
Received: from nbd.name ([46.4.11.11]:47410 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfLVPHT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 10:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sy6QXNlWforqwdkGoQGiL7LT7Z9fULlE3Ro0jFvGKZA=; b=NtD8ntrwNYzkfYjc+Xg3JmLIMO
        vCwXdFZ/mdGfTsqPsqBLWq8XFmQ6GmMpKKhu0ooSEPJdbu9Omn7H13/cDGQos4ayxmqyBTRLIFS3n
        h2gfME+8dxVQEz4c2kMUdsaUYwyHaCileUJiC8+3Kkd6AIT4Xkc1oYRC8rhSb9Qm6DcI=;
Received: from [81.95.5.44] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ij2pB-00030X-SB
        for linux-wireless@vger.kernel.org; Sun, 22 Dec 2019 16:07:18 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 50A4E742EAFC; Sun, 22 Dec 2019 16:07:17 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] mt76: clear skb pointers from rx aggregation reorder buffer during cleanup
Date:   Sun, 22 Dec 2019 16:07:17 +0100
Message-Id: <20191222150717.51379-4-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191222150717.51379-1-nbd@nbd.name>
References: <20191222150717.51379-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During the cleanup of the aggregation session, a rx handler (or release timer)
on another CPU might still hold a pointer to the reorder buffer and could
attempt to release some packets.
Clearing pointers during cleanup avoids a theoretical use-after-free bug here.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 6d64c2c4a159..3815d28a32ea 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -276,6 +276,7 @@ static void mt76_rx_aggr_shutdown(struct mt76_dev *dev, struct mt76_rx_tid *tid)
 		if (!skb)
 			continue;
 
+		tid->reorder_buf[i] = NULL;
 		tid->nframes--;
 		dev_kfree_skb(skb);
 	}
-- 
2.24.0

