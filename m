Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D59A48CA72
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 18:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355831AbiALRyT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 12:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355828AbiALRyS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 12:54:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C657C06173F;
        Wed, 12 Jan 2022 09:54:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B1F26197C;
        Wed, 12 Jan 2022 17:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C203DC36AE5;
        Wed, 12 Jan 2022 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642010057;
        bh=62/2GcC6liVVLjkwFGQyylJoz6dvpigFN0sFMpC5l2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djWdGtc9TaJyXt5Z5++WRi8lPOoUYiKEqznaQyoOQmG1b0LszD8dGOurvcDeIJSft
         eCwbXt9l+y3Ps3QkMmf+Yr3yqzdelHG7lbMPlq9wIsGrMKk2EcxB1FHwu4lr4waWVA
         mPTseskwzeo5+JDsYW1P1CgGjlPjh88FSsFESgXgvuoQptWwguR7Q/1wxAWkC/s/tW
         ZFmVFFAz2M2Rj9VJOi1oWLCexUxpeQ2ZZZ67Im2MvzxwPuFH4zzEu/OdUINTWn7CwQ
         0dpf0rIjeTIfwKHuPoN8d38tz2dWNjdmYfzXFZv5WyxssHOKnWm2mxWEG6bzHUdyMI
         pjGFgLKUN4XFw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com, devicetree@vger.kernel.org, robh@kernel.org
Subject: [PATCH v2 2/6] mt76: mt7915: enable radar trigger on rdd2
Date:   Wed, 12 Jan 2022 18:53:51 +0100
Message-Id: <91cd17a51272ed2d8020c94c0db63936712f9f70.1642009736.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642009736.git.lorenzo@kernel.org>
References: <cover.1642009736.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable radar trigger for rdd2 in mt7915_radar_trigger.

Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 464d2b42f0df..e140336a4fe1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -79,7 +79,11 @@ mt7915_radar_trigger(void *data, u64 val)
 {
 	struct mt7915_dev *dev = data;
 
-	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_RADAR_EMULATE, 1, 0, 0);
+	if (val > MT_RX_SEL2)
+		return -EINVAL;
+
+	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_RADAR_EMULATE,
+				       val, 0, 0);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_trigger, NULL,
-- 
2.34.1

