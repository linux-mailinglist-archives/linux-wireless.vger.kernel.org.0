Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9838B189C1B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 13:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCRMlm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 08:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgCRMll (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 08:41:41 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BEC32076E;
        Wed, 18 Mar 2020 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584535301;
        bh=tP+u4ybkKs8jDbO/sPn25phauZi0VKfegPje63qy7Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8Z66ysB7BEys739CfNE5DU4j+aLPJJEBH6BxdXcKNT/YxaeQ/7jyiMKQbZwOPpZe
         KGaTgZbvgBmwSplWw/1w121u0jxXdwKBJtakNwz52F9snP47Yd6GBwfs5/wVeVdAdm
         jsRqhyAi0uLXt3bySAzmOs8eB+ohP3tfuW4Kn/LY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] mt76: mt7615: add missing declaration in mt7615.h
Date:   Wed, 18 Mar 2020 13:41:05 +0100
Message-Id: <d341335a636b6ccd088dd2cfeec2d296eb4dc8c7.1584534454.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584534454.git.lorenzo@kernel.org>
References: <cover.1584534454.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add mt7615_mcu_wait_response declaration in mt7615.h since it will be
reused adding usb support to mt7615 driver

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 044a43256a35 ("mt76: mt7615: introduce mt7615_mcu_wait_response")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 8b3d95a2d7b2..676ca622c35a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -383,6 +383,7 @@ int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			    enum set_key_cmd cmd);
 void mt7615_mac_reset_work(struct work_struct *work);
 
+int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev);
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
 int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable);
-- 
2.25.1

