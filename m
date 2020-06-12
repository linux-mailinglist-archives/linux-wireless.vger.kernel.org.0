Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624E41F767C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2020 12:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgFLKJO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jun 2020 06:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFLKJN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jun 2020 06:09:13 -0400
Received: from localhost.localdomain.com (unknown [151.48.140.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B5C206A4;
        Fri, 12 Jun 2020 10:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591956552;
        bh=7Mx23gktiiommLLEWopms1Sxg4Sfe4qhEzZx09cUVRc=;
        h=From:To:Cc:Subject:Date:From;
        b=wDgaMjQSrohDrdnuXbcKAGjYN40lMSlgXYZiUsz/FYpRi+l1UQIY1CQArSVw2yLAB
         e7A1B7jEKDUc8t7ur0V/3pq56qLsfZ70fPoqqlIDzsyreq1uD+fDWXUZ1V23uAqyvS
         tf6OG8Jo1doU2RpnO3W5Vs3wAEc+9E6RpyzTVzI4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: rely on register macros
Date:   Fri, 12 Jun 2020 12:08:59 +0200
Message-Id: <edc1ef4e264c8e9ed9864bdaf726b9b25c4ffc02.1591956144.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For consistency with the rest of the code always rely on defined
macros for register access

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/util.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 9fda65db8cac..5d58b16bfe9f 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -9,7 +9,7 @@ mt76_reg_set(void *data, u64 val)
 {
 	struct mt76_dev *dev = data;
 
-	dev->bus->wr(dev, dev->debugfs_reg, val);
+	__mt76_wr(dev, dev->debugfs_reg, val);
 	return 0;
 }
 
@@ -18,7 +18,7 @@ mt76_reg_get(void *data, u64 *val)
 {
 	struct mt76_dev *dev = data;
 
-	*val = dev->bus->rr(dev, dev->debugfs_reg);
+	*val = __mt76_rr(dev, dev->debugfs_reg);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index ecde87465bf6..f53bb4ae5001 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -13,7 +13,7 @@ bool __mt76_poll(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 
 	timeout /= 10;
 	do {
-		cur = dev->bus->rr(dev, offset) & mask;
+		cur = __mt76_rr(dev, offset) & mask;
 		if (cur == val)
 			return true;
 
@@ -31,7 +31,7 @@ bool __mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 
 	timeout /= 10;
 	do {
-		cur = dev->bus->rr(dev, offset) & mask;
+		cur = __mt76_rr(dev, offset) & mask;
 		if (cur == val)
 			return true;
 
-- 
2.26.2

