Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D0E47A77D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 10:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhLTJzu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 04:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLTJzu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 04:55:50 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FB6C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IUaEzAWxczRU+5MA/Mgk/Ow1DhCnVN4P+Dupg1ht25w=; b=BalW+vsBioyl6vPCKrX6SweSjy
        N3El8eqvWEeAOHpvCgBt1qlcZgQYGinkOrcptH8wg3lEuPAYSwWvtxPHS4xJA3uSv5jFz+eIuzlJS
        +K41xQ8BFD6M/zkxgzAfPdsTfFhsdYNdBGfCKim4u35AhvtWT9Kq515ihMZu1wWtquhA=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mzFOW-0002UV-II
        for linux-wireless@vger.kernel.org; Mon, 20 Dec 2021 10:55:48 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix polling firmware-own status
Date:   Mon, 20 Dec 2021 10:55:36 +0100
Message-Id: <20211220095536.76548-1-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check the register status bit instead of the trigger bit

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0911b6f973b5..35728f165950 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2697,7 +2697,7 @@ static int mt7915_driver_own(struct mt7915_dev *dev)
 {
 	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND0, MT_TOP_LPCR_HOST_DRV_OWN);
 	if (!mt76_poll_msec(dev, MT_TOP_LPCR_HOST_BAND0,
-			    MT_TOP_LPCR_HOST_FW_OWN, 0, 500)) {
+			    MT_TOP_LPCR_HOST_FW_OWN_STAT, 0, 500)) {
 		dev_err(dev->mt76.dev, "Timeout for driver own\n");
 		return -EIO;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 59693535b098..ff71f5629c17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -567,6 +567,7 @@
 #define MT_TOP_LPCR_HOST_BAND0		MT_TOP(0x10)
 #define MT_TOP_LPCR_HOST_FW_OWN		BIT(0)
 #define MT_TOP_LPCR_HOST_DRV_OWN	BIT(1)
+#define MT_TOP_LPCR_HOST_FW_OWN_STAT	BIT(2)
 
 #define MT_TOP_MISC			MT_TOP(0xf0)
 #define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
-- 
2.34.1

