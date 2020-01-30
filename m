Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E598B14DD0E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgA3OrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:24 -0500
Received: from nbd.name ([46.4.11.11]:57442 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbgA3OrW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KxgAELrbWifHChymz7VCJj5aEFJbPCi9k5N6+/p4uO8=; b=V9NNZu4kg8NrBKNB8PtCxPxksZ
        sTKQvtrvYUXz9P8mGeuQ/x7LnIKzX2fGrRJqLRgqE2Jzg4yn+SzqcCjA8SFtJiongZgNUADWCrM//
        mTK/PTN5GbjC0u2cYgcQ0DDDckDTPKF0Y+X33dJU1ZTYWZejK39GX61sdW39GdyU0UDE=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6G-0001Vj-Ho
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 15:47:20 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EDF5A7AE4692; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 05/15] mt76: mt7615: store N9 firmware version instead of CR4
Date:   Thu, 30 Jan 2020 15:47:08 +0100
Message-Id: <20200130144718.14298-5-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

CR4 is used very little, N9 is the main firmware that the driver interacts with

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 097d3fc365f7..2352e7687790 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -491,6 +491,10 @@ static int mt7615_load_n9(struct mt7615_dev *dev, const char *name)
 		goto out;
 	}
 
+	snprintf(dev->mt76.hw->wiphy->fw_version,
+		 sizeof(dev->mt76.hw->wiphy->fw_version),
+		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
+
 out:
 	release_firmware(fw);
 	return ret;
@@ -528,10 +532,6 @@ static int mt7615_load_cr4(struct mt7615_dev *dev, const char *name)
 		goto out;
 	}
 
-	snprintf(dev->mt76.hw->wiphy->fw_version,
-		 sizeof(dev->mt76.hw->wiphy->fw_version),
-		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
-
 out:
 	release_firmware(fw);
 
-- 
2.24.0

