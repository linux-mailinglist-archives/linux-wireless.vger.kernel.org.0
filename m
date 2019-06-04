Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D1F35299
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2019 00:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFDWMv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jun 2019 18:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfFDWMv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jun 2019 18:12:51 -0400
Received: from localhost.localdomain (unknown [151.66.15.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF475206B8;
        Tue,  4 Jun 2019 22:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559686371;
        bh=sKy/yEBh5xWfp2mAWzv3bh0R0yH1wPIwS9LFYeZgTXg=;
        h=From:To:Cc:Subject:Date:From;
        b=QSJIDAgtJTk98w8jJi/vPGCkNvsMJ0ym5KcPVDS81ttAbCnj+wX2u7m/nLcdEguJt
         hpJGET0P7/UyaHTAuozRCTFZKnOuAiAu6d6kELOKJkPGHzksgnEANKobL/8eiqbHQM
         +32t58YdiHNHdBRrOY094+KU6tCEWwvQr1IclcxQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: remove key check in mt7615_mcu_set_wtbl_key
Date:   Wed,  5 Jun 2019 00:12:20 +0200
Message-Id: <51396ab29d290f95caecbb7fd817c654b74b36dc.1559686202.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not check key pointer in mt7615_mcu_set_wtbl_key since if set_key_cmd
is SET_KEY, key will be always not NULL. This patch will address a false
positive reported by Coverity-Scan

Addresses-Coverity-ID: 1445463 ("Dereference after null check")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on 'mt76: mt7615: fix slow performance when enable
encryption'
https://patchwork.kernel.org/patch/10972385/
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index d104435cd901..7a41c37e7460 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -879,7 +879,7 @@ int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 		u8 cipher;
 
 		cipher = mt7615_get_key_info(key, req.key.key_material);
-		if (cipher == MT_CIPHER_NONE && key)
+		if (cipher == MT_CIPHER_NONE)
 			return -EOPNOTSUPP;
 
 		req.key.rkv = 1;
-- 
2.21.0

