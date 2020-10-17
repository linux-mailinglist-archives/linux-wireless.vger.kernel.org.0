Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A25C29129A
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Oct 2020 17:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438505AbgJQPPe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Oct 2020 11:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438497AbgJQPPd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Oct 2020 11:15:33 -0400
Received: from localhost.localdomain (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0134320708;
        Sat, 17 Oct 2020 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602947733;
        bh=ieLHAkfoTL6veJU67Q0vgu9nGCFFzvsal3UxRs6qX6U=;
        h=From:To:Cc:Subject:Date:From;
        b=I46HP+vWorNPjFH4w4XxrKa1Ih1ayziBx4rkuly22cZpRR/WNyYO4jTBnakK9aMgM
         +dCfMiurmH1Dd5fEGrSbdMlijdAuzv9Q+ov4BI9RWIYi8DZ7pRNZ1nhCbrk6uBnMtb
         aPZ4hg/a4lhcUyPqID/hHPMU59DveGrY1DWlf+to=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, yn.chen@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: fix tkip configuration for mt7615/7663 devices
Date:   Sat, 17 Oct 2020 17:15:25 +0200
Message-Id: <4c01c75b6e80dcab7b49e36637de9551aeb85a47.1602947612.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix Tx-Rx MIC overwrite during TKIP hw key configuration

Fixes: 01cfc1b45421 ("mt76: mt7615: add BIP_CMAC_128 cipher support")
Tested-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index abb86a13f241..09da41cbdc6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1046,15 +1046,17 @@ int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
 	if (cmd == SET_KEY) {
 		if (cipher == MT_CIPHER_TKIP) {
 			/* Rx/Tx MIC keys are swapped */
+			memcpy(data, key, 16);
 			memcpy(data + 16, key + 24, 8);
 			memcpy(data + 24, key + 16, 8);
+		} else {
+			if (cipher != MT_CIPHER_BIP_CMAC_128 && wcid->cipher)
+				memmove(data + 16, data, 16);
+			if (cipher != MT_CIPHER_BIP_CMAC_128 || !wcid->cipher)
+				memcpy(data, key, keylen);
+			else if (cipher == MT_CIPHER_BIP_CMAC_128)
+				memcpy(data + 16, key, 16);
 		}
-		if (cipher != MT_CIPHER_BIP_CMAC_128 && wcid->cipher)
-			memmove(data + 16, data, 16);
-		if (cipher != MT_CIPHER_BIP_CMAC_128 || !wcid->cipher)
-			memcpy(data, key, keylen);
-		else if (cipher == MT_CIPHER_BIP_CMAC_128)
-			memcpy(data + 16, key, 16);
 	} else {
 		if (wcid->cipher & ~BIT(cipher)) {
 			if (cipher != MT_CIPHER_BIP_CMAC_128)
-- 
2.26.2

