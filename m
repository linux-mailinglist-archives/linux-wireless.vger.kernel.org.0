Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9712166B4D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 01:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgBUAIA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 19:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbgBUAIA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 19:08:00 -0500
Received: from localhost.localdomain (unknown [151.48.137.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 027682071E;
        Fri, 21 Feb 2020 00:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582243680;
        bh=F3ezLyPAEF0ppQSPhDFdznR6I5ZXXQGpYSAVOQZLoAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBIwPGOapgTVkCebjHpRWpLjg8lonPIWNmLgS+d6S9UjpGfVtOOqev1jF5OBs2GzQ
         ISUK5K/LprLSPWkydvlUm8iHt7lIuK4zSkHX2c2Pwne9sQPA85vR27Oy9/m7FRkLM1
         rTl6BqTbd+YjNBxVMvoqL61dJhW5mV17HaqCFvbk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 3/8] mt76: mt7615: add mt7663 support to mt7615_mcu_set_tx_ba
Date:   Fri, 21 Feb 2020 01:07:30 +0100
Message-Id: <5708ec66f5b2a8ed55f53a0bb3e43bfb6808835b.1582243031.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582243031.git.lorenzo@kernel.org>
References: <cover.1582243031.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extend mt7615_mcu_set_tx_ba routine in order to support mt7663e driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 7218a3041ead..1b8c8da56b84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1746,7 +1746,9 @@ int mt7615_mcu_set_tx_ba(struct mt7615_dev *dev,
 	wtbl_ba->sn = add ? cpu_to_le16(params->ssn) : 0;
 	wtbl_ba->ba_en = add;
 
-	if (add) {
+	if (is_mt7663(&dev->mt76)) {
+		wtbl_ba->ba_winsize = cpu_to_le16(params->buf_size);
+	} else if (add) {
 		u8 idx, ba_range[] = { 4, 8, 12, 24, 36, 48, 54, 64 };
 
 		for (idx = 7; idx > 0; idx--) {
-- 
2.24.1

