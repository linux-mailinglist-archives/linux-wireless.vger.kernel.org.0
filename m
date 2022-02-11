Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA24B2B7F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 18:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351981AbiBKRNH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 12:13:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiBKRNH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 12:13:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2CF1FC
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 09:13:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA083B82B0C
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 17:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EC0C340E9;
        Fri, 11 Feb 2022 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644599583;
        bh=pP7xpDeWv9McijteCTZ3bDe78UR3krRFVE8xYmzRLTs=;
        h=From:To:Cc:Subject:Date:From;
        b=rRdwVkXF1M1YzbXaPSIXpZE9acW2ZWs8eATBf54HBaD84OWdbc4X2xX0uHdTtMiVC
         pnuGr2vZRMaOa9eQ/5N1lwa8LfYHDsKwg42Ygd9uVLwl+ivSXxNfSFwSsNvGfTxzgL
         7D6Im1MBPmzzPdlC7Z/YnIiu/rv22NIjqr7tJRJjUwhwYwe16w8PHbx9ajIcgeWrKi
         Kxlbj7xUz72J4mWsNOIAj+hdKPjFNfYdMrc6GERaT8oOpU1QY8B701yDs+ez7sRxWh
         H2UvG3Ci0p6aW0hiMq658ZgR9vVEWzYVro4nUymv5YEevBPPlyWW2ekUdCTfcK9Rwl
         7PtDQrW0yOE8w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: fix endianness warnings in mt7915_debugfs_rx_fw_monitor
Date:   Fri, 11 Feb 2022 18:12:50 +0100
Message-Id: <2e8c3702650c132e8860203544f76e18ab62d943.1644599483.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warnings:
warning: incorrect type in initializer (different base types)
   expected restricted __le16 [usertype] msg_type
   got int
warning: incorrect type in assignment (different base types)
   expected restricted __le32 [usertype] timestamp
   got unsigned int

Fixes: 988845c9361a0 ("mt76: mt7915: add support for passing chip/firmware debug data to user space")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 280823fc9f92..87b494be0e61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -947,13 +947,13 @@ void mt7915_debugfs_rx_fw_monitor(struct mt7915_dev *dev, const void *data, int
 		__le16 len;
 	} hdr = {
 		.magic = cpu_to_le32(FW_BIN_LOG_MAGIC),
-		.msg_type = PKT_TYPE_RX_FW_MONITOR,
+		.msg_type = cpu_to_le16(PKT_TYPE_RX_FW_MONITOR),
 	};
 
 	if (!dev->relay_fwlog)
 		return;
 
-	hdr.timestamp = mt76_rr(dev, MT_LPON_FRCR(0));
+	hdr.timestamp = cpu_to_le32(mt76_rr(dev, MT_LPON_FRCR(0)));
 	hdr.len = *(__le16 *)data;
 	mt7915_debugfs_write_fwlog(dev, &hdr, sizeof(hdr), data, len);
 }
-- 
2.34.1

