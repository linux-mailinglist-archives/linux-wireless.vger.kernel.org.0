Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46D97A5881
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 06:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjISEso (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 00:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISEsn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 00:48:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2028.outbound.protection.outlook.com [40.92.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1BCFD
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 21:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw8iZouDxSx6GeO96UEegyG6wzE0JlMxJcCORNkhEVL5V7tyvFTKIMwXQqWrIE8bRf5iEHqbefhzOY//6F0ZmOAHL/Gy9SOLdn97Ad5J8EVUFMqeCSByuvexuQlHCV+snwDNYhJqvTu//HtML3fkCBtxIdRbUnvF9RoQ6l3Q2clwZRmhtwlE3hL6khkciBiPEuIJPY70iGKi1GvrL5UbZUYqr8JZ8yO8IR7yBvqe5hkGTxWc+6839BSlnq2PBqsdWty2Qas+SUcl2+IWwkeBlZAGu3qPH+g6uQANM8YTyTBE29C9ckOITMPPg+n3tx2Ff8VnGPQrfIwthWzBdtGfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R10sg/GWR0oK16657nDi1NKbHb3bKvPsWhCwc6LcFig=;
 b=Lf4lh9blJMsW2BUzRKCwupv5hX+cN65uK2XCd8GtoJGK3y8o7SH8CNDB8149ayTMD8PM+mystOt2CYg8QUQgm+MydYQaJn9AP6+VGwX/5/951Rt4TGKYVhz376aTCMuB3e0uug0qx43FIg/Tf/avwnHjYAp+gmUOyACz+n33tB1L+Q9mfHnwyV/bevtvMmfl8wrLPGcY9wdDyvPDmzlgvfXctz2gY3XLBl0/duVFbiqsPSYW8GXfMPyv4qE/5a4/Kq2aGkFSorxMDVXzaG8vHyJBEX/6GfMsXUFW9mC+N0npbuw839LFnKGrvESP4QIIKifTbca7uGPovIbeGYmsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R10sg/GWR0oK16657nDi1NKbHb3bKvPsWhCwc6LcFig=;
 b=JieK7yEZp4flSjrzNIxDQV/lHKYmjW/dPjkS9/Hjg00qW5Rt9CejZZ6xo9sVcVAY5dyehZuH4gByFZ4YhabaJCgesbwSMQRtSRj1aZ+JwJnjS1oAo2G8ChDJE05ePq0SOnGsGGXaDX5Cv9ioiVP/Xf5gWSoGZBg6UNam8qRBoGV/zsKpCFf/MmD3HQjcFlZ93Iw+bIS0aoNMqHm7tQgWaJI1SHWlFxVtvTm00GuDDFH6rZTxHFXbV9bi0xugJjhlBbYq0H6mgJXASVRLlPYZI8uFJ/Xbft0GUPsuM5i3UQUybTl2ovxo8ubSPdIK/NUgpnnZlTlWapIJM1C30XpZQQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TY3P286MB2658.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.15; Tue, 19 Sep
 2023 04:48:32 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b03c:5b9d:f7a4:9470]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b03c:5b9d:f7a4:9470%6]) with mapi id 15.20.6813.014; Tue, 19 Sep 2023
 04:48:32 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] wifi: mt76: mt76x02: correct external LNA gain
Date:   Tue, 19 Sep 2023 12:48:02 +0800
Message-ID: <TYAP286MB0315A2BAF9E9E74B2377EE4CBCFAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Ku7Lj3NqN7RmWVOQTUqUJ+TcB8o+bC1U]
X-ClientProxiedBy: TYAPR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:404:14::33) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230919044802.2425-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TY3P286MB2658:EE_
X-MS-Office365-Filtering-Correlation-Id: df0a3d46-cd39-473e-e077-08dbb8cbac42
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VD/oeVMyNEDRMvVOl+K9M0pTGeqyJ8PEU8v1lBoNukfhEgCXR37je10VDWQc+yZypcoqUJiDzmL7r29TUYdHb6BGdVZ4WmdQhRUzHHsS/5iTWAewS1di17VsROORbTKcYx3Df2vh2kxVz3R/P2jFBP7vw0iBO7UqUWRNzfUrAMlCsj66bKDUgMnXOO7NDLlwSbYvU+FYhiVvmrC1nUKphLmBpH3F+q98gIpzIHixEwpxg3HZP7Fi2y0AoILWXM9LARAnEWOWAYKd3Ge8gzNecYN3BWTjGpPhbEnVFb4w70zxf/IMTywlB3wYPvHH5cqFYOtoCN92tCaVJ5PBWVMNhnLCyX9shsQhMVOgaRQliX0DwoB8KQk9aU2JOR8R/Tu3IU8qrJYyRuDBlx1kwFyTTNYYk26UBlxoavrYh2T4bZ+VrtOKahqZKiwMcIbinYH76idzynhSvFKF/oxpemz7CuM9PBT+MMHyaq4JODThyAZ9MiCECyu5em36R9DRev5Hv3rKfBiCiJq0LuDf1uuPat5geVMV4dm76zFSZBJlY6x7qvUedOfgGUotif3u2jBMrVAyKeg1B6lKV2pNpL3566gpVswGVFEUH36evf9Dl8M=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RpgvZh+mzYMpAmLsBIjQ7jFOTOhZ0BqwS4nhZXl0G+I6EcTK6dBMyWC8GpMh?=
 =?us-ascii?Q?Ze3Av0P0lx2JJ6Gjh8Ad2xnz4GMMye8hhoA1JRDorx6KFvqQW+bF0HmIEjT7?=
 =?us-ascii?Q?xIAawOSvEj4CERlaGq37GFYF22j7dAqRr/CaseFHUw6hTPI5Fi4BRkEwFe71?=
 =?us-ascii?Q?Xnu2r31uk5oRGuJTXBfDbbFIjHf8SbA2gngWlvgml/uwuOdQWZZUlqVkMUuW?=
 =?us-ascii?Q?i5lYhEw//XK4QlUOKdWWUqEcuV/hrbivdgmOmD6DngwDTf7SYCeJqLOScMVJ?=
 =?us-ascii?Q?6tuWgLlaveoHtNlWiAqWgETgDg/Msq41VxLz5KShzAsdaJ5qoW9GRggEjcAY?=
 =?us-ascii?Q?p+KDf9jzRMpIN306RURSgMecOADqcT71qrxhGFnnkmVrrNc274LMpPg0h7CZ?=
 =?us-ascii?Q?uKbazF4WIH1dnDQ4iJnjBLX4vT2064Hs35ienockBUvM16bs1kYnpHg3Vn2g?=
 =?us-ascii?Q?Id/SFXLxs1VA1U5lyWS4InsDfOaFGK/NJdK2U6i8fcByF+nNRrpz1yXRsJ9y?=
 =?us-ascii?Q?/5BEzNmuILnT6rDWe8gVcLseo/J6ZzCfdGGDt4DUAHwvY0wQ7r/2GRR58k1x?=
 =?us-ascii?Q?uXoV9dQbtu3Ju18cEoTMaMHS00AjGHsoYuP04KOLNs63f2wxKIEh9Hv3kDRK?=
 =?us-ascii?Q?Fv/G7h5V/UIBXVoUJqju8t8vjn5fETbMk9lh2oGI+RjzdZotc7qSheH2qNRt?=
 =?us-ascii?Q?ygZmbP+ACKggxejbDHNAGvP6qBh30qgKAezUurNroPVvwj4LGbPFhRr2SfH6?=
 =?us-ascii?Q?xnn5M1kPd1QrBvpMqZE/XVkBLzrwdkgwsYyKXnrMOYTXToHnZrZYaVB8mAxd?=
 =?us-ascii?Q?oWp7Lu2ya8Bh19PHd8jmqNr7pl/cMsHe+XD0EK/18xCFdIuBY4nCgFHStfUX?=
 =?us-ascii?Q?Flz2H47lqOrMcuJTGn6I1y/IfOhQg+uLU5Un27688YCGRHRbmTlHwYhslFQ8?=
 =?us-ascii?Q?63/4yxHECJAyw6uE7yjj0XZ8uUMR7RplntK5+VA/2C6mxri/DES8hLmOS4x+?=
 =?us-ascii?Q?MJMfBBPOzm2lMthqib7z+hsmhQX5cACbua7hcCwwBInJ/AK1T+qYiLPzGTxG?=
 =?us-ascii?Q?V5kUDsyi80vQbbnq2Vb0CQwJRzsjdwfy3FoFGUZ9IWcBzhd+pgQ4b0wko8km?=
 =?us-ascii?Q?WpSh6+lf7MWeXFVaiqHyOORvX88n86NMwybTw6JPY1ii6INd7Cemuq0sd0eb?=
 =?us-ascii?Q?Eu541Hn/VBl6KyBrZ/4az5xZkpBQ9/ijK312wgW+DT54YaE97oHjTMd5k2I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0a3d46-cd39-473e-e077-08dbb8cbac42
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:48:32.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2658
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Referring to the MT761{0,2} EEPROM content, setting the corresponding
EEPROM control bit means enabling external LNA. In this case, we
should use the EEMROM LNA gain instead of 0.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
index 0acabba2d..a0b95509a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
@@ -135,9 +135,9 @@ u8 mt76x02_get_lna_gain(struct mt76x02_dev *dev,
 	u8 lna;
 
 	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_2G)
+	if (!(val & MT_EE_NIC_CONF_1_LNA_EXT_2G))
 		*lna_2g = 0;
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_5G)
+	if (!(val & MT_EE_NIC_CONF_1_LNA_EXT_5G))
 		memset(lna_5g, 0, sizeof(s8) * 3);
 
 	if (chan->band == NL80211_BAND_2GHZ)
-- 
2.39.2

