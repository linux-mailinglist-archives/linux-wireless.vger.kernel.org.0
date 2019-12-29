Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E4E12C22E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2019 11:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfL2KDQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Dec 2019 05:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfL2KDQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Dec 2019 05:03:16 -0500
Received: from localhost.localdomain.homenet.telecomitalia.it (host151-113-dynamic.27-79-r.retail.telecomitalia.it [79.27.113.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238BE207FF;
        Sun, 29 Dec 2019 10:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577613795;
        bh=aqERlIiwPkgPbXijTScus7dCLR+gumSjpmCyKS3liPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8WcnGQjpaiesG7AH8b5Lo3Cu/G7/6qzx4qsDfASVt+F+wrxeRoFrX+STj/J+w9dt
         jACHi60+7xaEEfnRpfdLldF4wAdAs9HPRWDl+k0nsJnjRfpy/2e+yOJ9/tpwGnVKSA
         Rpn+KYjkGV7GhAWqKOPLlAFkeHAm0Qkh0L5zDew4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 4/4] mt76: mt76x2: get rid of leftover target
Date:   Sun, 29 Dec 2019 11:03:08 +0100
Message-Id: <b812f90d5de1a3e7112efa3a5728676efdf36e5c.1577613505.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1577613505.git.lorenzo@kernel.org>
References: <cover.1577613505.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove tracing leftover target in mt76x2 Makefile

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/Makefile b/drivers/net/wireless/mediatek/mt76/mt76x2/Makefile
index 7b2b187fbf47..caf089538c11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/Makefile
@@ -13,5 +13,3 @@ mt76x2e-y := \
 mt76x2u-y := \
 	usb.o usb_init.o usb_main.o usb_mac.o usb_mcu.o \
 	usb_phy.o
-
-CFLAGS_pci_trace.o := -I$(src)
-- 
2.21.0

