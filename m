Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38AED11F6E6
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2019 09:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfLOIyc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Dec 2019 03:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfLOIyc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Dec 2019 03:54:32 -0500
Received: from localhost.localdomain (unknown [151.66.51.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D2020700;
        Sun, 15 Dec 2019 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576400072;
        bh=B2uFL7eacM94GN6CzJ6hHY8Y5gBE1zCmo2r5rzAF3DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdqZ+y15KIyr9KpRrmZLZgEMUEa7Bv/zale6oLhZhruQIDFikQ42eUIiaJfm1D1FQ
         N0CCFXPC0mXJjPaXrn/U6FBLRypE4OCIcG9D2fO6vuc3haS98ifb0hOUGeNSX5U9Uv
         SI2/iK3DKfmuMILgSK7UTXKFZ6Hv5XBPb6Uhknys=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 2/2] mt76: mt7603: simplify led reg definitions
Date:   Sun, 15 Dec 2019 09:54:10 +0100
Message-Id: <263c57c29b774556bb11035882f8c0bc8ccdc77f.1576399834.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1576399834.git.lorenzo@kernel.org>
References: <cover.1576399834.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on FIELD_PREP macro for led register definitions and
remove open coding

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
index 6e23ed3dfdff..52425eb187f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
@@ -586,17 +586,11 @@ enum {
 #define MT_LED_STATUS_0(_n)		MT_LED_PHYS(0x10 + ((_n) * 8))
 #define MT_LED_STATUS_1(_n)		MT_LED_PHYS(0x14 + ((_n) * 8))
 #define MT_LED_STATUS_OFF_MASK		GENMASK(31, 24)
-#define MT_LED_STATUS_OFF(_v)		(((_v) << \
-					  __ffs(MT_LED_STATUS_OFF_MASK)) & \
-					 MT_LED_STATUS_OFF_MASK)
+#define MT_LED_STATUS_OFF(_v)		FIELD_PREP(MT_LED_STATUS_OFF_MASK, (_v))
 #define MT_LED_STATUS_ON_MASK		GENMASK(23, 16)
-#define MT_LED_STATUS_ON(_v)		(((_v) << \
-					  __ffs(MT_LED_STATUS_ON_MASK)) & \
-					 MT_LED_STATUS_ON_MASK)
+#define MT_LED_STATUS_ON(_v)		FIELD_PREP(MT_LED_STATUS_ON_MASK, (_v))
 #define MT_LED_STATUS_DURATION_MASK	GENMASK(15, 0)
-#define MT_LED_STATUS_DURATION(_v)	(((_v) << \
-					  __ffs(MT_LED_STATUS_DURATION_MASK)) &\
-					 MT_LED_STATUS_DURATION_MASK)
+#define MT_LED_STATUS_DURATION(_v)	FIELD_PREP(MT_LED_STATUS_DURATION_MASK, (_v))
 
 #define MT_CLIENT_BASE_PHYS_ADDR	0x800c0000
 
-- 
2.21.0

