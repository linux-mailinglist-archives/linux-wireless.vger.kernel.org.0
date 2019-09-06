Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BCEABC7A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389837AbfIFP3Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 11:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388007AbfIFP3Z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 11:29:25 -0400
Received: from localhost.localdomain.com (unknown [151.66.4.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 622092070C;
        Fri,  6 Sep 2019 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567783764;
        bh=goP0T3nK9wdPLM00EOzxui8WH6coYbI+vkgT50x1Uug=;
        h=From:To:Cc:Subject:Date:From;
        b=iCVkv0XW9kvBUvbAlgcQYhkSe+ErY/EBI3yhViGoadkYST84/2FwRuESWtDMLPxrM
         0YoXMTp8u8k+ufz0xsKovvtT+jLTPBY7mKGZ+PMTRyv8Pe9JJN+WZzWu12VRQMxRJI
         hFaT+JuVGxXHcrwFVq07SFPyuwJ58maj7IYUqwSs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: enable SCS by default
Date:   Fri,  6 Sep 2019 17:29:04 +0200
Message-Id: <5933942ffd23f71b925cc6be26e9918fd663ed46.1567783646.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable Smart Carrier Sense algorithm by default in order to improve
performances in a noisy environment

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 1104e4c8aaa6..835499979b73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -50,7 +50,7 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 		 MT_TMAC_CTCR0_INS_DDLMT_EN);
 
 	mt7615_mcu_set_rts_thresh(dev, 0x92b);
-	mt7615_mac_set_scs(dev, false);
+	mt7615_mac_set_scs(dev, true);
 
 	mt76_rmw(dev, MT_AGG_SCR, MT_AGG_SCR_NLNAV_MID_PTEC_DIS,
 		 MT_AGG_SCR_NLNAV_MID_PTEC_DIS);
-- 
2.21.0

