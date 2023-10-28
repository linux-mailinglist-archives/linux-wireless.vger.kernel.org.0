Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5727DA6E0
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Oct 2023 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJ1MQB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Oct 2023 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjJ1MP6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Oct 2023 08:15:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2100.outbound.protection.outlook.com [40.92.98.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C35F2
        for <linux-wireless@vger.kernel.org>; Sat, 28 Oct 2023 05:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO2Nr7bY72v6pkUqCFFmRFf2Hf4ZXKaHVRbMjZzYpl4YHkUFZqgAEgQyIb9ahxCTehv0fKFu6E/M5xa31KjVwcTKnzIQxBLxHgITz5WXmMrzvzO+5htxni+eGMbIKJCESPvElyZUwrupdGXcu1nlcN8h5N7SElgYoo9GBRMgk5iJjYCPl0LNviWW9R3w3rglgShmVI3kq7FbhlmSnLuqenWkroGdJYS3hg3kdTbsioevwLNf3nFESMDmhMc/pBWywTIukzF1miAs1IciNIvVCgFNk2RjET7wsi8qQaVBKhY+qmNuBCv9SMm0/vqkKOlw0gz/mdZhZeh5GJ+xfZceQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyLnx4XRRGTFz+0ABHX6QJ9I3vyURIlc7WdhcMFzm0c=;
 b=Amk7kT556luvvmqQgcR6FE8rKpMAejafD2EfVmSl9BIY7spZiZa49tzdZAwBTRStMIbfJhNE3kVKet1sV2KzbfuG+E5JNvgted4VjgC0FIe6ZNK3DESWusyiJzKV35aHJdWkSmdhjguKZtN6hNERPM/1SexsLJmBE58lqAq+KvVdetFTgyKUkn+qPzkCXxO5lvK2y5hf06r8i4efMNDFdm0S4nrp517Cqf5GSaluE1Ry/GCeHQyAxXm6BM5dFX+8tWo82fMfJ+Xr7O54OxHRP+uLWArKGjcsdrGEshdzBpmjOo6F5h2N5QB2WQsLrIYYLMj2M6VzPOaPBE4HvHaR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyLnx4XRRGTFz+0ABHX6QJ9I3vyURIlc7WdhcMFzm0c=;
 b=Dxd/E9I2MWkhxVBN+S/AiAM6hQ8/FXD3/M2oSt3eYKnsRBcH30LJde1Pa4m/uTN5/3mQBp0a0ElKhgTWMxLTjmgJ/8dHLQcMMMLcfJeQlkGpsw1VOoJ1K/GsImrES+7aXEjRO9G6iBaJB8+FIq9mEuLtaOhY3lr5fUTTsjQxGFXY+USIHNbknRW/Ir21yr82vzA9RA3ed13U0h290MrIz9aIFQz9tP2ud+yTXWdp77Ph2PfKqli3uM0mbZozkyIj9aYQ6IxoP0l7giQhkwoSNAFhEh7vxhvHwqEz8JGiidFh/aIuwgchol+g8eWuWsV73S9trx6xPRQ7CPbneIxmnQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB2504.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Sat, 28 Oct
 2023 12:15:49 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6933.019; Sat, 28 Oct 2023
 12:15:49 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 3/3] wifi: rt2x00: restart beacon queue when hardware reset
Date:   Sat, 28 Oct 2023 20:15:32 +0800
Message-ID: <TYAP286MB0315339CF8B38FC1286CF39DBCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028121532.5397-1-yangshiji66@outlook.com>
References: <20231028121532.5397-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [9PUNADnYYH6dWKac80lqsw3sDxTrRWvwAasQKR1MFro=]
X-ClientProxiedBy: TYCP286CA0322.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::11) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231028121532.5397-3-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB2504:EE_
X-MS-Office365-Filtering-Correlation-Id: 052d190c-7063-4235-d095-08dbd7af9f13
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcmfLivArwCTWKZI+dDjhU3dJvfsQ9cZ45P/7zhyuaIWRqOaKo9OAy+6oJnBocRG8A98fiQzqCby8KPPqp38LTPD4TvuVXpImVDCCJaIx1K5i2yyiMiHd7x79ocnUXlL1I8PMGzpGNffF4CX0Cezkc+gPNXORoaiDhATJUeKOQYeqGHpHLYb4kzTCKgWS19nUU/jA7XcT/Y1TS8ry3v/JSYzVxqUGLKwNMlVOkHCyZSCcR1K/QE2Ikv7aswcpry64bAl8U7JEX0urDIGKer/aoTKN/9t6oklrbs8NQsCMLkULimJI3+KO1spxG6Z/dW6oJWlkDVLmELVqNSZwz8IHcl8MRsKByas1buTnNDti2qpCjhreGrLtuZXBpnR7EZJ/L9u8yV98kKJzYRjPKvhroJ9rS3hqfBjQyyPV48S4dRm2WZ4m3J+vzl2WkDqKBu7mZCLkeMaBrDMcC4UgbctSJzqNBan2nooTkWoYUlTU+uuONYFLCK06eDfOMYHtBVn+AH0nB3J7QHKx+znFKKhI4UOA9MCKRrSxsCy97BGiC8POuPC07hcQyBBIparp8pe2m6AU6pNm7G9b0s/zVnx8oU4nvjnUXEM0KD9UgfHosk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JhygI5fJoklv1JgTtSQ/pPUPevrreiTUVVh+pE4N8jzXsvChehSxBW/5uetH?=
 =?us-ascii?Q?U8AXRb59avBy8MCiXku/sDFXuRudFrFiHYd0mSZLqpO12BiRc2f1WlHRIag+?=
 =?us-ascii?Q?6oKlz4tNLKXFKlYCl+ibUZeTYduNd0jw6voqjuV7iOLwJqRFUh3NvyRZjbvg?=
 =?us-ascii?Q?Z9CdToNF5eo5ccvuIkWRspgh2Yj6oVFP2lEJRCI6ncLUHOmA+3tfJ7dDY4hd?=
 =?us-ascii?Q?XIFqAAKSfkxk6evG1Vw8Y/bKRQwyoShuEb775m4KNctFSD8oJKK0MtqNobd6?=
 =?us-ascii?Q?tWpKMrVf5kz/nEoSmmN7caxoj8QH8JcoxQCJ2s8FWtYSxBCUX7Yhxz81Mz03?=
 =?us-ascii?Q?S7cb4FGxSaHEKfa1jpWT0/2iMNnda4wYIUCen3ezAbYGz9y2Wr6trL/6kZOB?=
 =?us-ascii?Q?0TJg57HeEVOkPW4WLz9NOijRgGQA239CVXZGyDNqwIHMWOwbR3isJ8NuzTYC?=
 =?us-ascii?Q?wMt0vBROnxWryZzGPOfssF9cX+idYoKwfV0ySaphf1p4S6cK9mZHQYLYnhPj?=
 =?us-ascii?Q?0RnU9NwPM7k3SOw3O6Cwa5rDWwr5oF1N2uqVZZo4/aaBs2C/YKrtDf7D9TGr?=
 =?us-ascii?Q?55+OJECclNcAqGHPxjKQ+hDWCQt+M/mOreAZzHBzRrsfDK4WC22XWbbHfmP1?=
 =?us-ascii?Q?n8Tj4zcdtcTHFOJ87H6H67p0mnaKilbtHAkq0xzXjb/vpU58IJ/KO+pXRDoA?=
 =?us-ascii?Q?xe+bgjBKbUhnlriFV8vIQMQeDrdbY73wAa/snndbgyFlTx/kCay6SCEFOP8h?=
 =?us-ascii?Q?ol/B02peZHJKy6IYFYChfWbxeA+tQCNdwV5kwnKq1D7BKdtf5En1xk2v6mOt?=
 =?us-ascii?Q?V14jEp0uk9xJF8+cquEMSse0+Hl11XIO1aXq8nZ7DdyQrDiBpusfx7zkQYm8?=
 =?us-ascii?Q?yRYJn9QmMHN1Cd/Um3PowLjBnuBkKtBkUXMT9JHaci8rWezIV9xN6qHsf97P?=
 =?us-ascii?Q?lwYX/Zm+Wmo06+Gl9Z32HQPmZUwmFv7/PLYKy9Y+FZoFS5uonH5N1DM5gda+?=
 =?us-ascii?Q?onPJ7p8HakrniNbW6KrT1RaKSCkZ/WmTSeOwu2puuXUg+Rh55fGK4OX5uPJ1?=
 =?us-ascii?Q?rNddt+iNLlqdnrpUoSfQwCFFztGQiwPiJGiZO6lntWNX12H/EIrY7owtPzxF?=
 =?us-ascii?Q?U6ZNztHrZgU7aTMenPLx6B+s2K7V3SJxFC2v3OvBQ34kQaaQcIGEDIIQvcDD?=
 =?us-ascii?Q?x38QhGuzEHwxHURmaHOojMAcDp1GNmyL2pNZCbhfW3RghATI8J2JbAZczmo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052d190c-7063-4235-d095-08dbd7af9f13
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 12:15:49.4440
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

When a hardware reset is triggered, all registers are reset, so all
queues are forced to stop in hardware interface. However, mac80211
will not automatically stop the queue. If we don't manually stop the
beacon queue, the queue will be deadlocked and unable to start again.
This patch fixes the issue where Apple devices cannot connect to the
AP after calling ieee80211_restart_hw().

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 3 +++
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 9a9cfd0ce..ac58a56c3 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -101,6 +101,8 @@ void rt2x00lib_disable_radio(struct rt2x00_dev *rt2x00dev)
 	rt2x00link_stop_tuner(rt2x00dev);
 	rt2x00queue_stop_queues(rt2x00dev);
 	rt2x00queue_flush_queues(rt2x00dev, true);
+	if (test_bit(DEVICE_STATE_RESET, &rt2x00dev->flags))
+		rt2x00queue_stop_queue(rt2x00dev->bcn);
 
 	/*
 	 * Disable radio.
@@ -1286,6 +1288,7 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 
 	/* Enable the radio */
 	retval = rt2x00lib_enable_radio(rt2x00dev);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 4202c6517..6fcbf534a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -615,7 +615,9 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 			 * and keep it running on other interfaces.
 			 */
 			rt2x00queue_clear_beacon(rt2x00dev, vif);
-		} else if (bss_conf->enable_beacon && !intf->enable_beacon) {
+		} else if (bss_conf->enable_beacon &&
+			   (!intf->enable_beacon ||
+			    test_bit(DEVICE_STATE_RESET, &rt2x00dev->flags))) {
 			rt2x00dev->intf_beaconing++;
 			intf->enable_beacon = true;
 			/*
-- 
2.39.2

