Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE22621D0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 23:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgIHVSM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbgIHVSE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 17:18:04 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39F0C061757
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Q0/dp04+WwOiXGx5hxNk6pkFfeocyh5P28C7NhQSm6Q=; b=LQtwEYshH2d+QQNfr/EH7rPT1k
        s1Zid346Sue3I7Dwg1izovXFVc0xco7GmOIR+bCb5ti/LAOAYJseO7RvUhGD5TFV0DeBoTVESc44F
        A72rR/g8shGWvRnpTPvQtCmWUDfWOIIRWG8NRuMrz194jCOZBk3IPcMmJPyiHQHUkGP0=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFl02-0002Cx-6L
        for linux-wireless@vger.kernel.org; Tue, 08 Sep 2020 23:17:58 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 01/11] mt76: mt7615: fix MT_ANT_SWITCH_CON register definition
Date:   Tue,  8 Sep 2020 23:17:46 +0200
Message-Id: <20200908211756.15998-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is used for testmode tx antenna selection

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 9137d9e6b51d..61623f480806 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -575,7 +575,7 @@ enum mt7615_reg_base {
 #define MT_MCU_PTA_BASE			0x81060000
 #define MT_MCU_PTA(_n)			(MT_MCU_PTA_BASE + (_n))
 
-#define MT_ANT_SWITCH_CON(n)		MT_MCU_PTA(0x0c8)
+#define MT_ANT_SWITCH_CON(_n)		MT_MCU_PTA(0x0c8 + ((_n) - 1) * 4)
 #define MT_ANT_SWITCH_CON_MODE(_n)	(GENMASK(4, 0) << (_n * 8))
 #define MT_ANT_SWITCH_CON_MODE1(_n)	(GENMASK(3, 0) << (_n * 8))
 
-- 
2.28.0

