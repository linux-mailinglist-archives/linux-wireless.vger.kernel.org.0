Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBD01ADBEC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 13:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgDQLKf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 07:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgDQLKb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 07:10:31 -0400
Received: from lore-desk.lan (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD79221F7;
        Fri, 17 Apr 2020 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587121830;
        bh=Z70chfJO6OSuyFZvWhBc+cZGaip+JVIOLAFo4lbB6Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yVf+8eapa5VLXcsCtsOE2csM3e63EQ+CFwCvaNQLD+Lxk95chLYRugFdIX6+oMDRw
         KBIrry7Z62tpVVnLume7G44tRwKchs1wzfpVXq6Vf/cBso3kCo6zal3CNC+oKxhs4O
         0R91FRygZeCBR+ZU1AxkCRVSatHoBKHoe4Z2a3M8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 2/3] mt76: remove PS_NULLFUNC_STACK capability
Date:   Fri, 17 Apr 2020 13:10:05 +0200
Message-Id: <b38bf2d8036b8e84f315423d2c7ac8aa5f7b4153.1587121517.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587121517.git.lorenzo@kernel.org>
References: <cover.1587121517.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

remove IEEE80211_HW_PS_NULLFUNC_STACK capability from mt76_phy_init
routine since 802.11 ps is not currently supported by any devices and it
will conflict with mt7663 ps fw support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index f44f99184c10..39abedc45e4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -294,7 +294,6 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 		hw->max_tx_fragments = 16;
 
 	ieee80211_hw_set(hw, SIGNAL_DBM);
-	ieee80211_hw_set(hw, PS_NULLFUNC_STACK);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 	ieee80211_hw_set(hw, SUPPORTS_RC_TABLE);
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
-- 
2.25.2

