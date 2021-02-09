Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BDB314DAB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 11:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhBIK5l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 05:57:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232159AbhBIKzK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 05:55:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1924864E26;
        Tue,  9 Feb 2021 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612868070;
        bh=sUaT1TUyWpsfR+t5Y9oclgAMSb5CMCWRXfH4IvhgAwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oa4L2arDXDUp6+/BIsx/qPstypjJSnMmy8WHaYE7CA+el7XsBtLz2jpDoQWoSJoE/
         b2FyECqFvNqo0f42QxfyqehgEdfZMQHOdmPib1f1S6vKzhENQKe6nnc+kXMVu3rYHE
         HfkGeHn+bqMiVKexRFbxdsd3QJmCfJ9B/9fvHnfXVUIFHI9mIF4IKoh2x50AmnmrCq
         X6GOZdblBxhB3uoEpXPbK5hDlGmCGGFb33gd1YS37WRcNxBZTXP+3WzmVe/ulpNXKp
         Og6RQ1tLbw+UKYz6pCmTiCJxIJnIh3t3ujiC/HWclP6HOCZAP3xwwccy8e8nRHot8H
         YNIZ3rH2PMsqQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 2/6] mt76: connac: fix up the setting for ht40 mode in mt76_connac_mcu_uni_add_bss
Date:   Tue,  9 Feb 2021 11:54:03 +0100
Message-Id: <cf52bda8de58d86608d35f5574728bacd22c7484.1612867656.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612867656.git.lorenzo@kernel.org>
References: <cover.1612867656.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Use proper value for ht40 mode configuration in mt76_connac_mcu_uni_add_bss
routine and not ht20 one

Fixes: d0e274af2f2e4 ("mt76: mt76_connac: create mcu library")
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 6cbccfb05f8b..4356bf130dbd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1195,6 +1195,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			.center_chan = ieee80211_frequency_to_channel(freq1),
 			.center_chan2 = ieee80211_frequency_to_channel(freq2),
 			.tx_streams = hweight8(phy->antenna_mask),
+			.ht_op_info = 4, /* set HT 40M allowed */
 			.rx_streams = phy->chainmask,
 			.short_st = true,
 		},
@@ -1287,6 +1288,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 	case NL80211_CHAN_WIDTH_20:
 	default:
 		rlm_req.rlm.bw = CMD_CBW_20MHZ;
+		rlm_req.rlm.ht_op_info = 0;
 		break;
 	}
 
-- 
2.29.2

