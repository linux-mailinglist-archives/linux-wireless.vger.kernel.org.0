Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1264E1D5704
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2020 19:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEORGZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 May 2020 13:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEORGZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 May 2020 13:06:25 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB61206D8;
        Fri, 15 May 2020 17:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589562385;
        bh=b4cJhkrFVJEWxWYzCnAVIL6jPwAniw7LhKl8j/7FCk0=;
        h=From:To:Cc:Subject:Date:From;
        b=gIGMU2P/4MDfDO5oqxMok9+WeLb+PKnjeyuXTz5SccM8DK6d/NXCquEcKYMYOvuZQ
         4yobWnYuCHeEoyf3KWXX4F/oNKN5WD1GfLM7XHF2Ko0ZhQwRzYWyIdjl00coua+Y52
         v/lSLllivZs7p/R2r6RszbPiWlLer9dVGMeD2VT8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt76x02: remove check in mt76x02_mcu_msg_send
Date:   Fri, 15 May 2020 19:05:59 +0200
Message-Id: <76af5ee7e2757af22902edbcdab1a05cd24651f9.1589562304.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76x02_mcu_msg_send is run just by mmio code so get rid of
mt76_is_mmio() check

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 89a8992d84fa..267058086a90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -20,7 +20,7 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	int ret;
 	u8 seq;
 
-	if (mt76_is_mmio(&dev->mt76) && dev->mcu_timeout)
+	if (dev->mcu_timeout)
 		return -EIO;
 
 	skb = mt76_mcu_msg_alloc(mdev, data, len);
-- 
2.26.2

