Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F68D213624
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgGCIQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGCIQm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:42 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FECA206A1;
        Fri,  3 Jul 2020 08:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764202;
        bh=PO1Nvdcr9vILZYFERiZQGDgnlpRlKGGzimUUNaF7Fu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJKofRg3Y9Iy/dJShoXJmcSR+Vwzel3l+lxw+pDeMBMDJj6UcH2SgQVh7wDKiWST7
         2UGvR4KuRYeQVnZi9Jh+d7ubDF2+PL/+QEPissR8isAfobk+rtTvZA8LdQxEU3wH8R
         KHeII3/XHp3/Wf2c9OFXfrHoJOlvDzQ4XUu8pSA4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 12/22] mt76: mt7615: run mt7615_mcu_set_wmm holding mt76 mutex
Date:   Fri,  3 Jul 2020 10:15:51 +0200
Message-Id: <ddb279d53ab481d2bd1518fcc52f592b86df8e7f.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make sure to run mt7615_mcu_set_wmm() holding mt76 mutex in order to
wake the device from low power state and avoid races

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index eb56cd7cb429..c52b5c68ba97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -433,11 +433,17 @@ mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	int err;
+
+	mt7615_mutex_acquire(dev);
 
 	queue = mt7615_lmac_mapping(dev, queue);
 	queue += mvif->wmm_idx * MT7615_MAX_WMM_SETS;
+	err = mt7615_mcu_set_wmm(dev, queue, params);
 
-	return mt7615_mcu_set_wmm(dev, queue, params);
+	mt7615_mutex_release(dev);
+
+	return err;
 }
 
 static void mt7615_configure_filter(struct ieee80211_hw *hw,
-- 
2.26.2

