Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8619232F6E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgG3JWE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 05:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgG3JWC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 05:22:02 -0400
Received: from lore-desk.redhat.com (unknown [151.48.137.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB0720809;
        Thu, 30 Jul 2020 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596100922;
        bh=55XcxLcaDho/KKLvUQoIoA7Rg6QuMGBPIaPyfLVN4/8=;
        h=From:To:Cc:Subject:Date:From;
        b=FR1QcrC8nsMYaN0rQFnkGqkpN4CZEbkry3h2D5mYSY3hk8C3DlvZKF/oPM/619pBs
         PjdSkfavAQnBnb/PkhhS4Uoraxw5y6lNVwW0lRsWrM2hp3576FJzGqVNMOEIvzi1i1
         pgYcQKeL4sqlrH757FfWmnvkydxTcZ6lr0NCkNBA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: hold mt76 lock queueing wd in mt7615_queue_key_update
Date:   Thu, 30 Jul 2020 11:21:31 +0200
Message-Id: <a4ba01f0fc5c4bdd532d819ac0483496d3f01f6a.1596100771.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wq queue is always updated holding mt76 spinlock. Grab mt76 lock in
mt7615_queue_key_update() before putting a new element at the end of the
queue.

Fixes: eb99cc95c3b65 ("mt76: mt7615: introduce mt7663u support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 2d0b1f49fdbc..bafe2bdeb5eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -361,7 +361,10 @@ mt7615_queue_key_update(struct mt7615_dev *dev, enum set_key_cmd cmd,
 	wd->key.keylen = key->keylen;
 	wd->key.cmd = cmd;
 
+	spin_lock_bh(&dev->mt76.lock);
 	list_add_tail(&wd->node, &dev->wd_head);
+	spin_unlock_bh(&dev->mt76.lock);
+
 	queue_work(dev->mt76.wq, &dev->wtbl_work);
 
 	return 0;
-- 
2.26.2

