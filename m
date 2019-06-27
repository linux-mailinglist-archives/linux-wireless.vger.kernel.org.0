Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2229057FF4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 12:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfF0KN2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 06:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfF0KN2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 06:13:28 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F7852085A;
        Thu, 27 Jun 2019 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561630407;
        bh=KBwRnKfRyZ9vRAYgTIS00rL34oddGv8gBJgzFTNcHOo=;
        h=From:To:Cc:Subject:Date:From;
        b=XO/fgqRkvXXT7wKstl2xYI8GYBUg/hXmxVj4IyoHv+b1I5IJMrz6HcefYHe9EjR14
         XZWPGQGv3IqIccFf9Wnik+YPo3ixkwyQFxqAl+F8xO8mLKp7eQs58KyNQqyzUPhZ0i
         m6fo4LbTSaTLzNuNJHVCnH5ee3xUMGYkG9ndKpkA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7603: fix sparse warnings: warning: incorrect type in assignment (different base types)
Date:   Thu, 27 Jun 2019 12:13:16 +0200
Message-Id: <2ad789eb5a6c0f796fffbb4cbd8a8355d8ede8d2.1561630260.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in mt7603_mcu_set_eeprom:
drivers/net/wireless/mediatek/mt76/mt7603/mcu.c:376:30: sparse: warning:
incorrect type in assignment (different base types)
drivers/net/wireless/mediatek/mt76/mt7603/mcu.c:376:30: sparse:
expected unsigned short [usertype] addr
drivers/net/wireless/mediatek/mt76/mt7603/mcu.c:376:30: sparse: got
restricted __le16 [usertype]

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 6357b5658a32..343ddc5543c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -346,7 +346,7 @@ int mt7603_mcu_set_eeprom(struct mt7603_dev *dev)
 
 	};
 	struct req_data {
-		u16 addr;
+		__le16 addr;
 		u8 val;
 		u8 pad;
 	} __packed;
-- 
2.21.0

