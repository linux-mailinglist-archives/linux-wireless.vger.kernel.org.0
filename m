Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0DC411F6E5
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2019 09:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfLOIy1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Dec 2019 03:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfLOIy1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Dec 2019 03:54:27 -0500
Received: from localhost.localdomain (unknown [151.66.51.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B418B2253D;
        Sun, 15 Dec 2019 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576400066;
        bh=m8382Slgk6TtPR/BB10SFu4b7IjvbGGfX7nDIiURr4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BtRefwSHlka83fGkz34ExiZwdCkqSdCcPV8FFTiRQsJnxipTkkLkCHpHPQZWT7tcZ
         0xGamwS3xh+qznqGesh6Sx6NgRLhvgp2pWX6CObyFsJ8OG6mre6TDYWzG6ZDZjEQUt
         1nI6QUjO0KDaJ6pswiD14qrf8S8DuvMhq82K6nts=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 1/2] mt76: mt76x02: simplify led reg definitions
Date:   Sun, 15 Dec 2019 09:54:09 +0100
Message-Id: <edeae5413c93a3272969662eedb582060ec6c8b3.1576399834.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
index 21c0f351fa09..b69a495d0b9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
@@ -236,14 +236,11 @@
 #define MT_LED_S1_BASE			0x0780
 #define MT_LED_S1(_n)			(MT_LED_S1_BASE + 8 * (_n))
 #define MT_LED_STATUS_OFF_MASK		GENMASK(31, 24)
-#define MT_LED_STATUS_OFF(_v)		(((_v) << __ffs(MT_LED_STATUS_OFF_MASK)) & \
-					 MT_LED_STATUS_OFF_MASK)
+#define MT_LED_STATUS_OFF(_v)		FIELD_PREP(MT_LED_STATUS_OFF_MASK, (_v))
 #define MT_LED_STATUS_ON_MASK		GENMASK(23, 16)
-#define MT_LED_STATUS_ON(_v)		(((_v) << __ffs(MT_LED_STATUS_ON_MASK)) & \
-					 MT_LED_STATUS_ON_MASK)
+#define MT_LED_STATUS_ON(_v)		FIELD_PREP(MT_LED_STATUS_ON_MASK, (_v))
 #define MT_LED_STATUS_DURATION_MASK	GENMASK(15, 8)
-#define MT_LED_STATUS_DURATION(_v)	(((_v) << __ffs(MT_LED_STATUS_DURATION_MASK)) & \
-					 MT_LED_STATUS_DURATION_MASK)
+#define MT_LED_STATUS_DURATION(_v)	FIELD_PREP(MT_LED_STATUS_DURATION_MASK, (_v))
 
 #define MT_FCE_PSE_CTRL			0x0800
 #define MT_FCE_PARAMETERS		0x0804
-- 
2.21.0

