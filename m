Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36CAF98DDC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfHVIgZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 04:36:25 -0400
Received: from nbd.name ([46.4.11.11]:50904 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732465AbfHVIgZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 04:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XUEbydkUWToRdqxZOYq1b3X7szSMYb85JlW49Hl/alk=; b=l3rBZDMeUJqf2aKK+G7gV4Tyw9
        Zy8+mC3o2GYFtaaWtnrxai6sxAwPos5lPYQ+ErLTRMEJ5nsQo53Smhx+9dTYS/k5m6tjm0pD0qRVl
        tY1ihaSXBLPizYFa2fThjWOZ61Zy01eB+lY1vK+qe4Lsd+HXwmibyqGasDXI5++99MpI=;
Received: from p54ae9443.dip0.t-ipconnect.de ([84.174.148.67] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i0iZz-0004vO-2C; Thu, 22 Aug 2019 10:36:23 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 8FCF563FDE2F; Thu, 22 Aug 2019 10:36:22 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
Subject: [PATCH 2/2] mt76: remove offchannel check in tx scheduling
Date:   Thu, 22 Aug 2019 10:36:22 +0200
Message-Id: <20190822083622.48998-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190822083622.48998-1-nbd@nbd.name>
References: <20190822083622.48998-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tx queues are already disabled by mac80211 during scanning or other
off-channel activity. There is no need to repeat the check in mt76,
since scheduled queues are selected by mac80211 as well.

Signed-off-by: Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 5 -----
 drivers/net/wireless/mediatek/mt76/mt76.h     | 1 -
 drivers/net/wireless/mediatek/mt76/tx.c       | 6 ++----
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 32ddbf088817..fa481d2f11bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -406,11 +406,6 @@ void mt76_set_channel(struct mt76_dev *dev)
 	bool offchannel = hw->conf.flags & IEEE80211_CONF_OFFCHANNEL;
 	int timeout = HZ / 5;
 
-	if (offchannel)
-		set_bit(MT76_OFFCHANNEL, &dev->state);
-	else
-		clear_bit(MT76_OFFCHANNEL, &dev->state);
-
 	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(dev), timeout);
 
 	if (dev->drv->update_survey)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 38f2b17581ef..d67c6a26c87c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -272,7 +272,6 @@ enum {
 	MT76_STATE_MCU_RUNNING,
 	MT76_SCANNING,
 	MT76_RESET,
-	MT76_OFFCHANNEL,
 	MT76_REMOVED,
 	MT76_READING_STATS,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index d7982aa83c11..c22a05f06fd0 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -427,8 +427,7 @@ mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
 		if (probe)
 			break;
 
-		if (test_bit(MT76_OFFCHANNEL, &dev->state) ||
-		    test_bit(MT76_RESET, &dev->state))
+		if (test_bit(MT76_RESET, &dev->state))
 			return -EBUSY;
 
 		skb = mt76_txq_dequeue(dev, mtxq, false);
@@ -487,8 +486,7 @@ mt76_txq_schedule_list(struct mt76_dev *dev, enum mt76_txq_id qid)
 		if (sq->swq_queued >= 4)
 			break;
 
-		if (test_bit(MT76_OFFCHANNEL, &dev->state) ||
-		    test_bit(MT76_RESET, &dev->state)) {
+		if (test_bit(MT76_RESET, &dev->state)) {
 			ret = -EBUSY;
 			break;
 		}
-- 
2.17.0

