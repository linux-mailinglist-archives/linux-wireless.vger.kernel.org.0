Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437791176EA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 20:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLIT7X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 14:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIT7W (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 14:59:22 -0500
Received: from localhost.localdomain (unknown [151.66.51.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 423772080D;
        Mon,  9 Dec 2019 19:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575921562;
        bh=3ktVn+l1Ecwh8XwssnCNsgaPYd0r+RVVW6J6Dk8J7RQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MDlvN0DtVjZbt34s3W2BzEaUmQkwr3vNe0pY7H1litpmRa6RIFE1vWIHGMz3ZjQG2
         nnJAJS9Bq1y1kjlieA9MEmum0hRa0RiLpzcytFa1JRWt7VSRo7aGCx0FTbYf1TaxKN
         M7m99U/+OvcwppHMmvY8rwO91sYf0kSHkm1oUNw8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7615: report firmware version using ethtool
Date:   Mon,  9 Dec 2019 20:58:59 +0100
Message-Id: <5bb77cc6224a0ca46cecf2e435460610d583e6ae.1575921398.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Print fw_ver and build_date members of struct mt7615_fw_trailer
similarly to what appears in the output of 'dmesg' when the MCU firmware
is loaded.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 9d86f77d3492..7efb4b997c28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -539,8 +539,14 @@ static int mt7615_load_ram(struct mt7615_dev *dev)
 		goto out;
 
 	ret = mt7615_mcu_start_firmware(dev, 0, FW_START_WORKING_PDA_CR4);
-	if (ret)
+	if (ret) {
 		dev_err(dev->mt76.dev, "Failed to start CR4 firmware\n");
+		goto out;
+	}
+
+	snprintf(dev->mt76.hw->wiphy->fw_version,
+		 sizeof(dev->mt76.hw->wiphy->fw_version),
+		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
 
 out:
 	release_firmware(fw);
-- 
2.21.0

