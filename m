Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB78129B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 08:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfHEG4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 02:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfHEG4L (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 02:56:11 -0400
Received: from localhost.localdomain (unknown [151.66.59.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 976EC206C1;
        Mon,  5 Aug 2019 06:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564988170;
        bh=wsK4BEHu9kS7e9SPVR5pLemtrgUq+ClK62JajQzDKOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFkVooHboPByHJg6ZBRzlje10S8n5fYDpzmzny8SbjBgTDprBy9kvNHMVOrGuS5g6
         UzQdJFM9kX6D+yyFZ2/rNy1s7k3NIH+qaAuTZRCOU7cUyIdb1vhwQtWaNDtx4LTvGr
         5SCqNi3K7yMFf3GJyDMAdfTniAUJVsFt8AWqrNg4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com, ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 2/3] mt76: mt7603: move survey_time in mt76_dev
Date:   Mon,  5 Aug 2019 08:55:52 +0200
Message-Id: <bc4751cabce01f66204896f1e82cd7efe4524d0d.1564987866.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564987866.git.lorenzo@kernel.org>
References: <cover.1564987866.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move survey_time field in mt76_dev in order to be reused adding survey
support to mt7615 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h          | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h | 1 -
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 20f83e5b9337..c755b5ad5e2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -504,6 +504,8 @@ struct mt76_dev {
 
 	u8 csa_complete;
 
+	ktime_t survey_time;
+
 	u32 rxfilter;
 
 	union {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 81fb4276e742..92dddb765283 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1473,8 +1473,9 @@ void mt7603_update_channel(struct mt76_dev *mdev)
 	spin_lock_bh(&dev->mt76.cc_lock);
 	cur_time = ktime_get_boottime();
 	state->cc_busy += busy;
-	state->cc_active += ktime_to_us(ktime_sub(cur_time, dev->survey_time));
-	dev->survey_time = cur_time;
+	state->cc_active += ktime_to_us(ktime_sub(cur_time,
+						  dev->mt76.survey_time));
+	dev->mt76.survey_time = cur_time;
 	spin_unlock_bh(&dev->mt76.cc_lock);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 88c869002311..750855467f06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -14,7 +14,7 @@ mt7603_start(struct ieee80211_hw *hw)
 	struct mt7603_dev *dev = hw->priv;
 
 	mt7603_mac_start(dev);
-	dev->survey_time = ktime_get_boottime();
+	dev->mt76.survey_time = ktime_get_boottime();
 	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
 	mt7603_mac_work(&dev->mt76.mac_work.work);
 
@@ -182,7 +182,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	mt76_rr(dev, MT_MIB_STAT_PSCCA);
 	mt7603_cca_stats_reset(dev);
 
-	dev->survey_time = ktime_get_boottime();
+	dev->mt76.survey_time = ktime_get_boottime();
 
 	mt7603_init_edcca(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 2c6f7b4cf0e9..257300fec4f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -116,7 +116,6 @@ struct mt7603_dev {
 
 	s8 tx_power_limit;
 
-	ktime_t survey_time;
 	ktime_t ed_time;
 
 	struct mt76_queue q_rx;
-- 
2.21.0

