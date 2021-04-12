Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112D235C62C
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 14:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbhDLM0W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 08:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240788AbhDLM0V (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 08:26:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C477F6128A;
        Mon, 12 Apr 2021 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618230363;
        bh=JpKFcxPTaq41/kFgj0Nl+OiJyfDAvcprwV4PIKH7lL4=;
        h=From:To:Cc:Subject:Date:From;
        b=ASpInl3EuRuEwksxP/++yx/iiy0AOZ6rUAgxfQ2HX/ciczG6tGjFJh0fDSNXBpAww
         4stq3Vf5Qoci/9NL7ifHDmQBUysmjM0L5qe2YDJ1joIhXb6HrImfK8jxxsJafXCSsX
         9QeynNkABtpRS3v1nZ5DyWOdUmAK/zu9TKd1Z5/DSWHviGUb5NDOr+DWAoJ2YHkaWG
         j3L13g0k9VGqpW44C1pTdrZreL5gxQcxBXUR6ZvdwV6UjP7eB866ZO7g+hWiFPtp9T
         8gwaYMR/cLpbQmM8LM/uVVLMRQJtizlGlPL6a/WqdEE0qvHJh+z2PrRmvSGcc9HK9U
         H/g1XKiLJcORw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: add rcu section in mt7921_mcu_tx_rate_report
Date:   Mon, 12 Apr 2021 14:25:54 +0200
Message-Id: <476fdb99788304f96b2a7e5ecf5da1e78c2d5022.1618230139.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce rcu section in mt7921_mcu_tx_rate_report before dereferencing
wcid pointer otherwise loockdep will report the following issue:

[  115.245740] =============================
[  115.245754] WARNING: suspicious RCU usage
[  115.245771] 5.10.20 #0 Not tainted
[  115.245784] -----------------------------
[  115.245816] other info that might help us debug this:
[  115.245830] rcu_scheduler_active = 2, debug_locks = 1
[  115.245845] 3 locks held by kworker/u4:1/20:
[  115.245858]  #0: ffffff80065ab138 ((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0x1f8/0x6b8
[  115.245948]  #1: ffffffc01198bdd8 ((work_completion)(&(&dev->mphy.mac_work)->work)){+.+.}-{0:0}, at: process_one_8
[  115.246027]  #2: ffffff8006543ce8 (&dev->mutex#2){+.+.}-{3:3}, at: mt7921_mac_work+0x60/0x2b0 [mt7921e]
[  115.246125]
[  115.246125] stack backtrace:
[  115.246142] CPU: 1 PID: 20 Comm: kworker/u4:1 Not tainted 5.10.20 #0
[  115.246152] Hardware name: MediaTek MT7622 RFB1 board (DT)
[  115.246168] Workqueue: phy0 mt7921_mac_work [mt7921e]
[  115.246188] Call trace:
[  115.246201]  dump_backtrace+0x0/0x1a8
[  115.246213]  show_stack+0x14/0x30
[  115.246228]  dump_stack+0xec/0x134
[  115.246240]  lockdep_rcu_suspicious+0xcc/0xdc
[  115.246255]  mt7921_get_wtbl_info+0x2a4/0x310 [mt7921e]
[  115.246269]  mt7921_mac_work+0x284/0x2b0 [mt7921e]
[  115.246281]  process_one_work+0x2a0/0x6b8
[  115.246293]  worker_thread+0x40/0x440
[  115.246305]  kthread+0x144/0x148
[  115.246317]  ret_from_fork+0x10/0x18

Fixes: 1c099ab44727c ("mt76: mt7921: add MCU support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 7d45e8795e15..aa55667b6ed7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -413,9 +413,12 @@ mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb,
 
 	if (wlan_idx >= MT76_N_WCIDS)
 		return;
+
+	rcu_read_lock();
+
 	wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
 	if (!wcid)
-		return;
+		goto out;
 
 	msta = container_of(wcid, struct mt7921_sta, wcid);
 	stats = &msta->stats;
@@ -423,6 +426,8 @@ mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb,
 	/* current rate */
 	mt7921_mcu_tx_rate_parse(mphy, &peer, &rate, curr);
 	stats->tx_rate = rate;
+out:
+	rcu_read_unlock();
 }
 
 static void
-- 
2.30.2

