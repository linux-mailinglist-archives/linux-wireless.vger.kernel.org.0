Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254BB1ADBFF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 13:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgDQLNu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 07:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730228AbgDQLNu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 07:13:50 -0400
Received: from lore-desk.lan (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08A12076D;
        Fri, 17 Apr 2020 11:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587122029;
        bh=a71vWzTErF3OJFiK+9Grr/5TzM8WpjEOvfq3xprAfcg=;
        h=From:To:Cc:Subject:Date:From;
        b=bSvuUGl2L0fUFI44c1lbrgqtXN5OxdUrCJBA90519rBDOCnDFKx/3bm4x12GhrMjc
         IHjmoRo3BWOhtKTe+OBX0dmoEVoBHbVFndq6ySrZNvRfVeKvVcKwwbOR0/POK9f+Zb
         CQ3WntxW9k3v+SDf5CUvodNZDgtZ4Ats/OqM4uxA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: make Kconfig entry obvious for MT7663E
Date:   Fri, 17 Apr 2020 13:13:28 +0200
Message-Id: <ecb3b93924ca5159ae0fbb56ad884d3d453ff6e6.1587121960.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Make Kconfig entry obvious for MT7663E

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index a84317fb856f..e25db1135eda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -5,7 +5,7 @@ config MT7615_COMMON
 	select MT76_CORE
 
 config MT7615E
-	tristate "MediaTek MT7615E (PCIe) support"
+	tristate "MediaTek MT7615E and MT7663E (PCIe) support"
 	select MT7615_COMMON
 	depends on MAC80211
 	depends on PCI
-- 
2.25.2

