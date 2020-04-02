Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F170019C1AE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbgDBNHu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbgDBNHq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:07:46 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB7C206F5;
        Thu,  2 Apr 2020 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832866;
        bh=o4R7A2vkRsfDOuilwq8p3GqvjBziISTy/i4WEdHyEKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rfK3eezXA2+nRjY7RS172wo1CdQJX9GSy4n31KxUXRX4slnb6un/cbI+vFG9/vRrb
         xULbDkrEF54zi7/2in+7boJHnkS+GwCVPLVSjMv8sm4u+AwsM88VVbYJo40+awNK8D
         nFUfEXGYB6Q9o+k97DTbzL5Maiy3PiL3n23msVfk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 05/12] mt76: mt7615: add ethool support to mt7663 driver
Date:   Thu,  2 Apr 2020 15:06:35 +0200
Message-Id: <675b37fc399560fb8bc2b3b583c1d22d7b61d402.1585832458.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report n9 firmware version using ethtool

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 610cfa918c7b..32e3e4219076 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1914,8 +1914,14 @@ static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 	}
 
 	ret = mt7615_mcu_start_firmware(dev, override_addr, flag);
-	if (ret)
+	if (ret) {
 		dev_err(dev->mt76.dev, "Failed to start N9 firmware\n");
+		goto out;
+	}
+
+	snprintf(dev->mt76.hw->wiphy->fw_version,
+		 sizeof(dev->mt76.hw->wiphy->fw_version),
+		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
 
 out:
 	release_firmware(fw);
-- 
2.25.1

