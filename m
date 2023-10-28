Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB77DA6DF
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Oct 2023 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjJ1MP5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Oct 2023 08:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1MPz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Oct 2023 08:15:55 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2100.outbound.protection.outlook.com [40.92.98.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1904F7
        for <linux-wireless@vger.kernel.org>; Sat, 28 Oct 2023 05:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7384eKXsSVAIxiYddQIMqoBDGmmOwOeam80TcO8IgWWTK6DnlqeQC41f+LiWIOc3O+/uVAGHp4f/vuPOCHF2en/ZvTfvrK6GZabDcNyITD6oh0IiT/fqOwdFmZEWbkeL4brUuiXdztj7QJIP3pAvXIDtxbp94uicNKleafKQmwVjUM3Yk23+9A8lI/g5Bsr+SLlPuJUXnNJ3bHhUEAVAkpDpV+1waLebcrrJEsrwMMFfWEGMfa+6wEx6DcelpRwAIda4tJBkzroKmjVxAgjGyycTmAHKyj10e46ANMtHp7EST2dAIjT/VSMvC4zfEUebnUvOzabagKFGpsw0HaHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kS6tdKoSosELNP4BSmRK4sep2svFMhPiQwszS4SgL8=;
 b=LIqV6wrbrZamdNp24Xag4EzGre/YOxOzZyY0CNfMKFAnOm5JB9zXaDVv71fzGdiraBjbDYtKA8d2Azk3cWbzPw9yqHLs/+hy1VdBdfMigG0Ss3sYzQdsNDX6S4rr/gBlXSrfl0wqPQmiaJy02I6cUertIGsi00GZnwNmTF5thLeZDsdKQV/Ime2EnfxIlTtViCFy47D2rn9HGtOwfCbvgvIzZ8Rgs4D8NNJH4n2l+hDzLwPRZK/Wjp70HaxwP8DGtJe3PIU1ZqRoFoceOwcf7xrkP2UV7XlzY+Rk47vJxlxbJZbAR7LRay6QUAJW3vI18LpAG5CxAp3wGC6FG5z3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kS6tdKoSosELNP4BSmRK4sep2svFMhPiQwszS4SgL8=;
 b=VsXoUmLkz7vWDIepz//jk3eI6l2HJ+9X5ip+04bE0H2dzVobNgUCGVyXdD5E8MEYW09uw1igYOdUOXYcUlRt8GqYcNMamuKZFqMzVpiGg3SPIGPMUXNsBmBFv3NoWehSpCys6WjqnC8ynzdCqw9UdxvaUAPRYEHEnjOBajCvMNlYnthb6+fl7Drg525Rlmb61mEtXTdY8hZTKvWVfcJCSfHwlNeIxznbH1JMgoBLHnGRD2i6dzvT9XdhYqJIqwBBHtxmxK3SltBlbj3XQ/qcZVcOptVIs03lBrGJmphwlqUN5k0EB20+K8uUZU2QLzHmfoqLTlRcZklAfUH+7Zhx8w==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB2504.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Sat, 28 Oct
 2023 12:15:46 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6933.019; Sat, 28 Oct 2023
 12:15:46 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 1/3] wifi: rt2x00: introduce DMA busy check watchdog for rt2800
Date:   Sat, 28 Oct 2023 20:15:30 +0800
Message-ID: <TYAP286MB0315F9EFFA3D13AA1AD7AEF4BCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [nP6WELRpB07OYD/tQ50YJTcHfECBb+2qJsv9PXriLn4=]
X-ClientProxiedBy: TYCP286CA0322.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::11) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231028121532.5397-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB2504:EE_
X-MS-Office365-Filtering-Correlation-Id: b38d04aa-b169-4107-8d1c-08dbd7af9d15
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8Ted2ksJmGJ6h9QTiL47mDjOusrdKI91rJpjZlkj7i1JmAOoEhtUREqRgwjde7R8qGNA8AslGnUHoIx/3YIp+Dx6cCAGHDTLpe+TOEJ87noZ1554R93f4NdWbBaNU7QRenj6HzZS1mld4PHt3wfAZzys6Ycu/5zmKiTVGfDwlILLFrPHrKy4YuOCbmEg1GBen/XVCGRKOHaQImLKTX5Any78SKGT6QShOPbNAlY4Bf5nh5MsDdx7aNj8SIgL1Svf+HK0J3R+w2BCCBwfFhjVlDZofPzoloaspecuyWouwiVncxAgZcfiF4wSN+47SeYioB1YDQKQeZz3B0jbj85ZxQ+rj4YFQrbj5WqFPEqRfx743KZBB4euTAo0H0fHCCbB3kcLdsx15L+9/Ml0giHVIBDmA3yaz7sicYcnh6qVZvGSqhGebax89c7rralzXQQ1sG1iXvJkRH42Pm3Z8IUYNWL7UZAT2CmMgDmVRdXlEO04swXYEQQx5MCuHGwL/uHFA6JYRRKZX3I0FeciwCGw8o6wP780y/BvBYBg7u9ubt0wwT8oo1g59Cxd26g61XWxNgVIz4RhF/AJTwa//OE69nqobYgTR+1uKfmy0MnYZJL1wa8TiPJ/5jn9Rc/TZZG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Z+JlYdmoe4WxBkbLxxM2kpQP+BuAdeO7ACwHOgQG2aBY+c0LaPfNwCB3OZt?=
 =?us-ascii?Q?d/VOn4hYmbsQGZMIEGG0eyAl9OBJ7HLdADDvn3ebU48OQQEE+TZJrV9KJF/5?=
 =?us-ascii?Q?CfRuBJBDAAQG9cyk+kUpkg0926bXZ1GeSae8+PGAD0TiErc92m6IaadJyYTo?=
 =?us-ascii?Q?WKS5pZoc2/tw2iDEe7Qq5v1Qqy5Ync5BI9ezyOBo5DLJ15wvT1808YS842Eg?=
 =?us-ascii?Q?L4jqmZhuBwYsWPECnl3cDAGmzU+VBpicTxduQdq4f9hatlxa4ZTE97IIJ9Pc?=
 =?us-ascii?Q?XkxRVCoiSoCLv5IU84WmfHasazLIAd+ICXaA+VX2sgNyCLVVjnnH4p7R6c36?=
 =?us-ascii?Q?9yLRzP7gpJ0teeg48UhcTk2noSP2ZXerQuwGRfFd6iAvsEE5xKJzHKOu0RxL?=
 =?us-ascii?Q?g/D+OYeU4OURfGQN2e+VJPX5DxDJJl7Q5sQ4zyNX9jDL85HF/9AyDZihzD4k?=
 =?us-ascii?Q?RgoF5LgnFCe3VhYvc+GHnj1RXlqUTCwmQSPoYYmgQWBf07aRGAZU7kWJ7q0j?=
 =?us-ascii?Q?IEDlKVUNoUrhI7Mxj/ieG6vDF/Pol0B8qSrP7hdLyeNR8KWAYJsIfNIsetF2?=
 =?us-ascii?Q?afiEKmPgAyZvkT1X5AgxKrJCvLzuCJsnn/Guze9Ju7B4JxySL/s8hp+rVOdH?=
 =?us-ascii?Q?XIpwjZ/oaXSY1P/URCfiyU527oW7xWAv3R/23eURQJIhGn5VARTuYLb7Z4pA?=
 =?us-ascii?Q?7elVtyjx0kJmy1wsHZoRXpbtYCBROCt/GkdgC6tnkgmw95vLP+y00IDXv5JK?=
 =?us-ascii?Q?yWKbwfKtJQHpBFEHdrpqjGwa1tRLsRx5MAheflvXnRlIvU7PxwjV5kB8B3BT?=
 =?us-ascii?Q?wu9Uy5Xt5L+gonL1uvqgAtvYWFHMIapt220+CrZtSSoAnSlD3bCUm120N4IT?=
 =?us-ascii?Q?6iLSo/UNorCgATOOMfGV/6MF5/kCx5pOXu77P/CAgETXwqNF4CMQuXRPZ5sr?=
 =?us-ascii?Q?Xo+Seu4Uhzp+mw8t3T+VfqzLZ4xbM9hgqjSeeXep50hirpSbn2Z/1R1NJUK8?=
 =?us-ascii?Q?1/kOiE3kSoraphVER0e6lKZPxKCRyTM+UZDA0UmNtkRPqTUr6+Ro0mFhooLq?=
 =?us-ascii?Q?NOQOnAooLYsVuO92chYbjw1iXOAOw/JHQBBqdGSrsRqQsMyGcdk1woCdyM9f?=
 =?us-ascii?Q?0vG7g9Fvew+f90HghFi3qK0glb569+RY9oVkRGUGFdOPupv8iP7kFKQi1xhc?=
 =?us-ascii?Q?EJQwSVo+nUfsoTjlkkWx0UKU8HUX8YoX/7hQE+be6ctEmxYAkN3HTQM3LLc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38d04aa-b169-4107-8d1c-08dbd7af9d15
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 12:15:46.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2504
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When I tried to fix the watchdog of rt2800, I found that sometimes
the watchdog could not reset the hung device. This is because the
queue did not completely stop, it just became very slow. The Mediatek
vendor driver for the new chips (MT7603/MT7612) has a DMA busy
watchdog to detect device hangs by checking DMA busy status. This
implementation is something similar to it. To reduce unnecessary
watchdog reset, we can check the INT_STATUS register together as I
found that when the radio hung, the RX/TX coherent interrupt will
always stuck at triggered state.

This patch also changes the watchdog module parameters to the new
'hang_watchdog' and 'dma_busy_watchdog' so that we can control them
separately. That's because they may have different behavior on
specific chip.

This watchdog function is a slight schedule and it won't affect the
WiFi transmission speed. Watchdog can help the driver automatically
recover from the abnormal state. So I think it should be default on.
Anyway it can be disabled by module parameter 'dma_busy_watchdog=0'.

Tested on MT7620 and RT5350.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 81 ++++++++++++++++---
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  3 +
 2 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 594dd3d9f..6ca2f2c23 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -30,9 +30,15 @@
 #include "rt2800lib.h"
 #include "rt2800.h"
 
-static bool modparam_watchdog;
-module_param_named(watchdog, modparam_watchdog, bool, S_IRUGO);
-MODULE_PARM_DESC(watchdog, "Enable watchdog to detect tx/rx hangs and reset hardware if detected");
+static bool modparam_dma_wdt = true;
+module_param_named(dma_busy_watchdog, modparam_dma_wdt, bool, 0444);
+MODULE_PARM_DESC(dma_busy_watchdog, "Enable watchdog to detect tx/rx"
+		 " DMA busy and reset hardware if detected");
+
+static bool modparam_hang_wdt;
+module_param_named(hang_watchdog, modparam_hang_wdt, bool, 0444);
+MODULE_PARM_DESC(hang_watchdog, "Enable watchdog to detect tx/rx hangs"
+		 " and reset hardware if detected");
 
 /*
  * Register access.
@@ -1260,15 +1266,12 @@ static void rt2800_update_survey(struct rt2x00_dev *rt2x00dev)
 	chan_survey->time_ext_busy += rt2800_register_read(rt2x00dev, CH_BUSY_STA_SEC);
 }
 
-void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
+static bool rt2800_watchdog_hung(struct rt2x00_dev *rt2x00dev)
 {
 	struct data_queue *queue;
 	bool hung_tx = false;
 	bool hung_rx = false;
 
-	if (test_bit(DEVICE_STATE_SCANNING, &rt2x00dev->flags))
-		return;
-
 	rt2800_update_survey(rt2x00dev);
 
 	queue_for_each(rt2x00dev, queue) {
@@ -1296,18 +1299,72 @@ void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
 		}
 	}
 
+	if (!hung_tx && !hung_rx)
+		return false;
+
 	if (hung_tx)
 		rt2x00_warn(rt2x00dev, "Watchdog TX hung detected\n");
 
 	if (hung_rx)
 		rt2x00_warn(rt2x00dev, "Watchdog RX hung detected\n");
 
-	if (hung_tx || hung_rx) {
-		queue_for_each(rt2x00dev, queue)
-			queue->wd_count = 0;
+	queue_for_each(rt2x00dev, queue)
+		queue->wd_count = 0;
+
+	return true;
+}
+
+static bool rt2800_watchdog_dma_busy(struct rt2x00_dev *rt2x00dev)
+{
+	bool busy_rx, busy_tx;
+	u32 reg_cfg = rt2800_register_read(rt2x00dev, WPDMA_GLO_CFG);
+	u32 reg_int = rt2800_register_read(rt2x00dev, INT_SOURCE_CSR);
+
+	if (rt2x00_get_field32(reg_cfg, WPDMA_GLO_CFG_RX_DMA_BUSY) &&
+	    rt2x00_get_field32(reg_int, INT_SOURCE_CSR_RX_COHERENT))
+		rt2x00dev->rxdma_busy++;
+	else
+		rt2x00dev->rxdma_busy = 0;
+
+	if (rt2x00_get_field32(reg_cfg, WPDMA_GLO_CFG_TX_DMA_BUSY) &&
+	    rt2x00_get_field32(reg_int, INT_SOURCE_CSR_TX_COHERENT))
+		rt2x00dev->txdma_busy++;
+	else
+		rt2x00dev->txdma_busy = 0;
+
+	busy_rx = rt2x00dev->rxdma_busy > 30 ? true : false;
+	busy_tx = rt2x00dev->txdma_busy > 30 ? true : false;
 
+	if (!busy_rx && !busy_tx)
+		return false;
+
+	if (busy_rx)
+		rt2x00_warn(rt2x00dev, "Watchdog RX DMA busy detected\n");
+
+	if (busy_tx)
+		rt2x00_warn(rt2x00dev, "Watchdog TX DMA busy detected\n");
+
+	rt2x00dev->rxdma_busy = 0;
+	rt2x00dev->txdma_busy = 0;
+
+	return true;
+}
+
+void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
+{
+	bool reset = false;
+
+	if (test_bit(DEVICE_STATE_SCANNING, &rt2x00dev->flags))
+		return;
+
+	if (modparam_dma_wdt)
+		reset = rt2800_watchdog_dma_busy(rt2x00dev);
+
+	if (modparam_hang_wdt)
+		reset = rt2800_watchdog_hung(rt2x00dev) || reset;
+
+	if (reset)
 		ieee80211_restart_hw(rt2x00dev->hw);
-	}
 }
 EXPORT_SYMBOL_GPL(rt2800_watchdog);
 
@@ -12015,7 +12072,7 @@ int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev)
 		__set_bit(REQUIRE_TASKLET_CONTEXT, &rt2x00dev->cap_flags);
 	}
 
-	if (modparam_watchdog) {
+	if (modparam_hang_wdt || modparam_dma_wdt) {
 		__set_bit(CAPABILITY_RESTART_HW, &rt2x00dev->cap_flags);
 		rt2x00dev->link.watchdog_interval = msecs_to_jiffies(100);
 	} else {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index aaaf99331..62fed38f4 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -926,6 +926,9 @@ struct rt2x00_dev {
 	 */
 	u16 beacon_int;
 
+	/* Rx/Tx DMA busy watchdog counter */
+	u16 rxdma_busy, txdma_busy;
+
 	/**
 	 * Timestamp of last received beacon
 	 */
-- 
2.39.2

