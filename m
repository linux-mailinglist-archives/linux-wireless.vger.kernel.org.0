Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19A967AD4
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfGMPJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jul 2019 11:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbfGMPJY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jul 2019 11:09:24 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3AA020850;
        Sat, 13 Jul 2019 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563030563;
        bh=U9RnIKbE7wP8KY0uBIQ/2GT7YgM5yFUB8fa91wCBddI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TS4j6uwRy2jresyrdE/Ik/l1E99KrbQbcZVLGyu3vBmTTnJth9UFluK1M0CQhYowF
         sU/njMOWpIttGHi72ZYEB1nglsHzj/CJt4z6GqJ9mQ22UISSre1hWld0x81gqhlCAi
         x21z0K1qiaVwx+p458GEm+iz/sA9J9lpS4Pl0NpU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        royluo@google.com, linux-wireless@vger.kernel.org
Subject: [PATCH 4/7] mt76: mt7615: remove wtbl_sec_key definition
Date:   Sat, 13 Jul 2019 17:09:04 +0200
Message-Id: <f4bb125dd2fc6d3e034e1c037158769e58f5a001.1563029769.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563029769.git.lorenzo@kernel.org>
References: <cover.1563029769.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of wtbl_sec_key definition since it is no longer used

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index ef0cd81b822a..d4d08fa59349 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -288,19 +288,6 @@ struct wtbl_hdr_trans {
 	u8 rsv;
 } __packed;
 
-struct wtbl_sec_key {
-	__le16 tag;
-	__le16 len;
-	u8 add; /* 0: add, 1: remove */
-	u8 rkv;
-	u8 ikv;
-	u8 cipher_id;
-	u8 key_id;
-	u8 key_len;
-	u8 rsv[2];
-	u8 key_material[32];
-} __packed;
-
 enum {
 	MT_BA_TYPE_INVALID,
 	MT_BA_TYPE_ORIGINATOR,
@@ -384,7 +371,6 @@ struct wtbl_raw {
 				     sizeof(struct wtbl_vht) + \
 				     sizeof(struct wtbl_tx_ps) + \
 				     sizeof(struct wtbl_hdr_trans) + \
-				     sizeof(struct wtbl_sec_key) + \
 				     sizeof(struct wtbl_ba) + \
 				     sizeof(struct wtbl_bf) + \
 				     sizeof(struct wtbl_smps) + \
-- 
2.21.0

