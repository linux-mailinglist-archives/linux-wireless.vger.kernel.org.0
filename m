Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61930314DBD
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 12:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhBILAJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 06:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232238AbhBIK5p (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 05:57:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE80564E4B;
        Tue,  9 Feb 2021 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612868075;
        bh=YTnXJxbp4iMFaJefTnGhcfF8ZD7Kl5z84Qdir6O6OTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fk+1OTjezpg3kUnNLxZXebk+pXoFqPg3GxXksluheWr1cgpRybFdEVhmTmR5AsRtz
         skOIHNBTRzUSQkejpzd4nfToYYzrqIFmd1q6Kt/DBsvbbveZHA4wJTTsDQPfF6R9I8
         Lsfwnq8i/fBxlCs58v+xZLEBnNNOcJWvQKxhVk4nI5dqjFmjtHXhp3PH5nZ6Yqf51U
         3x0CGEFwD10w9ghqqA/Fu9/bDUU+XvQhJb1mD2rnYiVv3DoaTSIt3IDbFGtOd8SI4Q
         PI++q9y4aHWLlmE/fGv9HETTZbTeCOI3SEICyXg4J8sWn7R8lrNIb5LyMx2hpvs8yS
         BO/+FUdx+o2cQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 5/6] mt76: mt7921: fix uninitialized pointer access in mt7921_get_wtbl_info
Date:   Tue,  9 Feb 2021 11:54:06 +0100
Message-Id: <857ff74f736d4e593f5ad602cee7ac67ebfca5ca.1612867656.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612867656.git.lorenzo@kernel.org>
References: <cover.1612867656.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

fix possible uninitialized pointer access in mt7921_get_wtbl_info
routine

[  270.073205] wlp1s0: deauthenticating from 9c:5c:8e:c9:93:14 by local choice (Reason: 3=DEAUTH_LEAVING)
[  270.094918] 8<--- cut here ---
[  270.097988] Unable to handle kernel NULL pointer dereference at virtual address 0000000a
[  270.106120] pgd = 7ac68838
[  270.108842] [0000000a] *pgd=00000000
[  270.112426] Internal error: Oops: 805 [#1] SMP ARM
[  270.117216] Modules linked in: mt7921e mt76_connac_lib mt76
[  270.122803] CPU: 0 PID: 7 Comm: kworker/u8:0 Tainted: G        W         5.11.0-rc2+ #67
[  270.130891] Hardware name: Mediatek Cortex-A7 (Device Tree)
[  270.136459] Workqueue: phy0 mt7921_mac_work [mt7921e]
[  270.141557] PC is at mt7921_get_wtbl_info+0x224/0x2d8 [mt7921e]
[  270.147498] LR is at 0x0
[  270.150026] pc : [<bf030398>]    lr : [<00000000>]    psr: 60000013

...

[  270.317696] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  270.325869] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[  270.334043] [<bf030398>] (mt7921_get_wtbl_info [mt7921e]) from [<bf02ea9c>] (mt7921_mac_work+0x298/0x2c0 [mt7921e])
[  270.344529] [<bf02ea9c>] (mt7921_mac_work [mt7921e]) from [<c013cde8>] (process_one_work+0x1f0/0x538)
[  270.353780] [<c013cde8>] (process_one_work) from [<c013d17c>] (worker_thread+0x4c/0x55c)
[  270.361874] [<c013d17c>] (worker_thread) from [<c01447a8>] (kthread+0x124/0x150)
[  270.369275] [<c01447a8>] (kthread) from [<c0100150>] (ret_from_fork+0x14/0x24)
[  270.376501] Exception stack(0xc19c7fb0 to 0xc19c7ff8)
[  270.381550] 7fa0:                                     00000000 00000000 00000000 00000000
[  270.389724] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  270.397896] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  270.404509] Code: e59de012 e1cdc1b6 e1cdc1b8 e59dc016 (e582e00a)

Fixes: 1c099ab44727c ("mt76: mt7921: add MCU support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index d784c75d47bf..58de7f32a625 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -404,11 +404,10 @@ mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb,
 
 	if (wlan_idx >= MT76_N_WCIDS)
 		return;
+
 	wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
-	if (!wcid) {
-		stats->tx_rate = rate;
+	if (!wcid)
 		return;
-	}
 
 	msta = container_of(wcid, struct mt7921_sta, wcid);
 	stats = &msta->stats;
-- 
2.29.2

