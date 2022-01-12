Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F96248C5B7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 15:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354015AbiALOO4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 09:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354005AbiALOOe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 09:14:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBDBC06173F
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 06:14:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77156142A
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 14:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD90CC36AEB;
        Wed, 12 Jan 2022 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641996873;
        bh=62/2GcC6liVVLjkwFGQyylJoz6dvpigFN0sFMpC5l2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHPM5obxDUu4Hj8lXY4nwxiP2P4quWrJ/5EgWWeueWtQOftJiQy8u5Q9N7YYKmfLg
         gcJ+6ZFqWxGUxOmuZuZEWEiERtNkZ21jMDz6TPztWpdVOMG7+vOYKuZNzRtBxm5aWK
         eyX/TVrcz8xMbqXWSu5t8xAsWIZZOtX4U1lp7PZA/qRssDITQkM6P4Ixy6ePbe6oEf
         JeFW3+SRNLO0MqMhq4UOEV+P/6SPDd1TZmaF9hwAVN8zfZRiDl9VNx33uQVjirYars
         arGFCH+rRiAe6C8g9+v4Yyv6+G9DwCYMVCXod8ZRuDc/VFQOTiIUqwgYQ39y0m9FaQ
         4QkJ3uMAHvZLg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com
Subject: [PATCH 2/6] mt76: mt7915: enable radar trigger on rdd2
Date:   Wed, 12 Jan 2022 15:13:49 +0100
Message-Id: <91cd17a51272ed2d8020c94c0db63936712f9f70.1641996493.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641996493.git.lorenzo@kernel.org>
References: <cover.1641996493.git.lorenzo@kernel.org>
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

