Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F01031FDE2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 18:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBSR36 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 12:29:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSR35 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 12:29:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B625D64EB1;
        Fri, 19 Feb 2021 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613755756;
        bh=80LqvuQzMW/ojL+1PkGfKTLaCL5qkaf1dS1HRp7MsnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MR0HCifg8mQ6vs6MyKSPYbzVbiqTs16mRZP41RPSvMrzqVooT7S8LdJz09tiLUKhb
         1XHZ3KWNv1AuecPVZvzT6Ien4qXy9MNESJcojko2Sq0hffyNl5WzhaO7/mkdAAFvCX
         lboerlBpIOSqQttdKuDFcUNZsaI1zzTbLI+ckP9m012UFmfyNUMHzNlrLv82yure7M
         o0oIlIpLUvok3PmJg8/+rO/MT0z2tnJYsZ5dLgmEt1ZRgME6Dmad9sVA23LsT/9ZOv
         48Ksk75cBsmtPf35KF6On9Ka7nqHDz93qdl1GNxZ2EhzS353gC2pjNDP9ugOxmMEmy
         K5UZfsNP384UA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2 4/8] mt76: connac: fix up the setting for ht40 mode in mt76_connac_mcu_uni_add_bss
Date:   Fri, 19 Feb 2021 18:28:47 +0100
Message-Id: <5f8a202a6bd65594fc9468ea3d9af1ac90cee83d.1613755428.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613755428.git.lorenzo@kernel.org>
References: <cover.1613755428.git.lorenzo@kernel.org>
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
index ac8d6ad76054..81515419b5b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1198,6 +1198,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			.center_chan = ieee80211_frequency_to_channel(freq1),
 			.center_chan2 = ieee80211_frequency_to_channel(freq2),
 			.tx_streams = hweight8(phy->antenna_mask),
+			.ht_op_info = 4, /* set HT 40M allowed */
 			.rx_streams = phy->chainmask,
 			.short_st = true,
 		},
@@ -1290,6 +1291,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 	case NL80211_CHAN_WIDTH_20:
 	default:
 		rlm_req.rlm.bw = CMD_CBW_20MHZ;
+		rlm_req.rlm.ht_op_info = 0;
 		break;
 	}
 
-- 
2.29.2

