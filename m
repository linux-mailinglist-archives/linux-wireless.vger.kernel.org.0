Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB43E46E8C9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 14:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhLINK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 08:10:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51004 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhLINK2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 08:10:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81850B8240D
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 13:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A96C341C8;
        Thu,  9 Dec 2021 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055213;
        bh=ROEviUsdC2Ji6uVb+Y9ch5GYYPFdrw81mqrWChFCkFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZTuZtxToQ627Exbw4UqwaatG8wNHtPfQUma2trorL9uOhnGg+QJg+dPprBukNHDs
         NqGk5hoj6tCIMZpw8nqZPXoOxMSp/IvWuZF2xEQC/x3EAZ4Q/LNGKb72WIFoj/C8jE
         25NQPMMJagv6Xic2zv32f6EGltmyRjIFc0IFj1oWytGSqt27ESM0fbPny5iuRa45I6
         FWG3tOjxbedJEJjQBXR5dHq0fymLWH83vv4yapGXCTx4pcr5RZUdIvxFMr4T5H+jhD
         h6ZeLfZeo+ChzTW+kWtv161hArEKmwYbTaQiDDxoDlcGgCnUrhJ1joDC7fd2N8EWfT
         BYfE9k6N7RgOg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 3/7] mt76: connac: remove MCU_FW_PREFIX bit
Date:   Thu,  9 Dec 2021 14:06:25 +0100
Message-Id: <4098aa566b94433ead8c74c5ef260efc6b545bf3.1639054861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639054861.git.lorenzo@kernel.org>
References: <cover.1639054861.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of MCU_FW_PREFIX bit since it is no longer used

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index c1016bf33809..c6b653c3e249 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -497,11 +497,9 @@ enum {
 #define MCU_CMD_UNI_EXT_ACK			(MCU_CMD_ACK | MCU_CMD_UNI | \
 						 MCU_CMD_QUERY)
 
-#define MCU_FW_PREFIX				BIT(31)
 #define MCU_UNI_PREFIX				BIT(30)
 #define MCU_CE_PREFIX				BIT(29)
-#define MCU_CMD_MASK				~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
-						  MCU_CE_PREFIX)
+#define MCU_CMD_MASK				~(MCU_UNI_PREFIX | MCU_CE_PREFIX)
 
 #define __MCU_CMD_FIELD_ID			GENMASK(7, 0)
 #define __MCU_CMD_FIELD_EXT_ID			GENMASK(15, 8)
@@ -574,17 +572,17 @@ enum {
 };
 
 enum {
-	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
-	MCU_CMD_FW_START_REQ = MCU_FW_PREFIX | 0x02,
+	MCU_CMD_TARGET_ADDRESS_LEN_REQ = 0x01,
+	MCU_CMD_FW_START_REQ = 0x02,
 	MCU_CMD_INIT_ACCESS_REG = 0x3,
-	MCU_CMD_NIC_POWER_CTRL = MCU_FW_PREFIX | 0x4,
-	MCU_CMD_PATCH_START_REQ = MCU_FW_PREFIX | 0x05,
-	MCU_CMD_PATCH_FINISH_REQ = MCU_FW_PREFIX | 0x07,
-	MCU_CMD_PATCH_SEM_CONTROL = MCU_FW_PREFIX | 0x10,
+	MCU_CMD_NIC_POWER_CTRL = 0x4,
+	MCU_CMD_PATCH_START_REQ = 0x05,
+	MCU_CMD_PATCH_FINISH_REQ = 0x07,
+	MCU_CMD_PATCH_SEM_CONTROL = 0x10,
 	MCU_CMD_WA_PARAM = 0xc4,
 	MCU_CMD_EXT_CID = 0xed,
-	MCU_CMD_FW_SCATTER = MCU_FW_PREFIX | 0xee,
-	MCU_CMD_RESTART_DL_REQ = MCU_FW_PREFIX | 0xef,
+	MCU_CMD_FW_SCATTER = 0xee,
+	MCU_CMD_RESTART_DL_REQ = 0xef,
 };
 
 /* offload mcu commands */
-- 
2.31.1

