Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5781B08C3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDTMHv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 08:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgDTMHu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 08:07:50 -0400
Received: from localhost.localdomain.com (unknown [151.48.159.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E2BB206DD;
        Mon, 20 Apr 2020 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587384470;
        bh=hg6wS/HV8kcXH5ugWtUCXLzLdrfCedTehl3Md/SXsXI=;
        h=From:To:Cc:Subject:Date:From;
        b=diTzGR3Q54WwTDRsM5hUHE/MP4FpjLDXsjAOwvF2V1GeY8Y9nOVV73Uv+XNRD1rpW
         /WbbhP6HzWVrCmXqhSSgSIE7sEsa15ejuIR4qbD0WIoVeaFUTX08zqdUjh5Z/ce6rh
         kFwxEXcBGsCs4nlDyURt6EoN1Ff7UiFvclYsFUjQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: fix mt7615_firmware_own for mt7663e
Date:   Mon, 20 Apr 2020 14:07:45 +0200
Message-Id: <0ab0cba65fe838c658dd8e9b61cda618a37ecfca.1587384173.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check the firmware-own configuration has been applied polling
MT_CONN_HIF_ON_LPCTL register

Fixes: f40ac0f3d3c0 ("mt76: mt7615: introduce mt7663e support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index d448bbeba1c1..7081bc4723ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1710,9 +1710,8 @@ static int mt7615_firmware_own(struct mt7615_dev *dev)
 
 	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_FW_OWN);
 
-	if (is_mt7622(&dev->mt76) &&
-	    !mt76_poll_msec(dev, MT_CFG_LPCR_HOST,
-			    MT_CFG_LPCR_HOST_FW_OWN,
+	if (!is_mt7615(&dev->mt76) &&
+	    !mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN,
 			    MT_CFG_LPCR_HOST_FW_OWN, 3000)) {
 		dev_err(dev->mt76.dev, "Timeout for firmware own\n");
 		return -EIO;
-- 
2.25.3

