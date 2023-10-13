Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4577C914A
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 01:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjJMXW1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 19:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjJMXW0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 19:22:26 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2072.outbound.protection.outlook.com [40.92.99.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C775BE
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 16:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksaxAFYyv1hdyD2gO2FdreW4mt5FN6u+MSghEe6oj4rlc6iQQ5ufaszUq4HK24tjk04YA2Tjy64cvs8bUBtjr0GQgm/Paw9U+fal+TARY766aiIzcbkmLXFpZ8rwqMFCJsyHyt0hZEet0uiyXV95CyED8jR0U+yH5ESX9h86YKGCdU1kHWmX7iPTL21NuIHFcWbLqudKEvgchI/52VZKLE+Noei64bRr58W00lNUNeK6nZ9lz2iecpQ2YPGFshrZ9kqGQ1Umvnut4wlQv1wqq2Ia08dbesS4n0+036ZUCm/8aysfy5Pcgvf+qd+a3SyEJGGUlUYfDzfx/TT5z9+SRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wi0KsgjoU4BgJtfmSpQQNmdlzzYYiBArj7G/m6I4f/U=;
 b=U57nrog2jQgiNZn0i//nAXcltjlTQ8mBHtypCmYYcUygXs1AjQZktJBh0uMQf04nP6kAew/VUzRZ8wZBaVSE8X3pTDMOQED3Kcrlew/CWJ0L3JEhGTi9xoKzHtKal7BerLowo6YMiCkyhem77nclFr+agYtkFr0f4IWQSyTH7jnJ+GK025VdCv7nSntDM1s5oopji8mtbpIMOI98ftEys+IhARTkYe6T1LyAcGSjaaL+Jk9mtGFCtC/Jw5vyw+XbrQXSnHXNHmewfQioUiZTkk6w2t+86z5oWoMxvwipNAKn6nlvDNd+HZVA87oyEHWqQEs7QdMwqcyAdkwI9CItjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wi0KsgjoU4BgJtfmSpQQNmdlzzYYiBArj7G/m6I4f/U=;
 b=LBQtDF9rctDe4yWV1ovCnhl8i4v3ZB4KW1KOVrXqNmrFGr/u5HozHfNfQ9LstSXiKpLICecvfs+Fs//84gg17BbGPt4cYlCy2HP9L2x147irp3jK7d6MZLDXfYQjV1KhRc42pGfLXgQz7OSWsWPqGRMdzV8Tj0Z+Lywva7wjDuxPOB7CGe+p7j27hDAvBGh8EJSrYueJpceeAqoenehhP8xhn8hJKQHwcST3i7MavolDIzQ4Q6tvGaQDrR3VTc8OQWlOLPf0zlPENX94AY3UVWIaRVFQZjodB/dimae/H/hK4X7o/fEllxF1sc8jFooLXziA6Ui7PpnjR7Ose7/ZCw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYYP286MB1691.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.31; Fri, 13 Oct
 2023 23:22:22 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a%4]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 23:22:22 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 1/3] wifi: rt2x00: improve MT7620 register initialization
Date:   Sat, 14 Oct 2023 07:21:28 +0800
Message-ID: <TYAP286MB0315C345BF66B37977FD16BBBCD2A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013232130.416-1-yangshiji66@outlook.com>
References: <20231013232130.416-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [kU/wz1r+Ckz00b9ycYszlzh3ac0F6UfXA1ANgFwKcgk=]
X-ClientProxiedBy: TYBP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::19) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231013232130.416-2-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYYP286MB1691:EE_
X-MS-Office365-Filtering-Correlation-Id: bb11cee8-5930-495a-ae21-08dbcc434045
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jA42NYVSgM1czEbL7IXSgTnic0+EgDGRJuj0ipspQ5OzZZdhy8zAQFGe/qbrzoYPOeUPIb1xxAuV+KlJxxIL4k3Rz2Hr0zOUHSso1LRfbbGkZepoeVjX6WrNI7c7foo2rShcAiFXU71mHfBrVwMgpLx8pNgjBaMQslU2OJN0CWSMr66C+MGciJvepNtHrzy8hXEQmU1GTlw8OPNglnz9iRsXfn+rHNeqGZuwNKxxvGRF8KS4gOfU9PNf4TQMTb/q8myZQDbR77zZybs+olm52Y7fRHPmS4HS/DyVm0AwW/zBaIwmU0pvKzu9Stq7XKx9JPvSdZgXCLX6sn3LpyRbzr7B+XgYrjAJ74Weaut8vEFd6zOARNtrgYT5I+nzgAjt3QdQ+8qANs3OtB7pIxxsCdNP9ETeaC0W2A9ogaU29nNTeEXKpyvCBWXhxxHMsw+dy3OszTWP65SgLkYff52Ms6quJIKdpeml+2Fe+Cw1Jni9NwpDD/Kl/5OOBtaWpXgMiYDJRdqknmn/lp8+bwlM7kpImObro3ufvOb6Kdb3Y3FlPIxJ9CEAWFdfrFgOaJu+AFjv3hV+Y1OV73c+Bs87W5tlaQ5OBKQSj2lwmv9EuOIf62BdR86XghRBc65zHy85
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUtSDE1FDE/6GEYvzEVR6qFy8LVtv2JHidCQgq/GjMT3ce/fd0pkAJzbA84b?=
 =?us-ascii?Q?9XLOS4gjEjgJSg0v1gfuoBPXZkQBSty8MCoz9ehlFCd02Db/G3S065M0Hje9?=
 =?us-ascii?Q?ZTsx91r79R9d/IJ3tKc9ykrNNP2sq3qjmoqLg/yVslFXZkt2Er/29w96+Iv2?=
 =?us-ascii?Q?Q537hLywtP4RZuclnWpxRJ83pz3pA5i49+seOwqgbeDGkC7Y3oPzm8WNh0Xq?=
 =?us-ascii?Q?B2Va32VR0871yFXqY1c+5TYDvX2wt31RfjG2FvJfAWLmTbYVT7qe0zYBEwUw?=
 =?us-ascii?Q?ZYUqzwtrrQWYFrjdHi/5qA3cg8ihdBABA/VCS41KloyvEfCutDZKF8dNCfqi?=
 =?us-ascii?Q?2gX/yitaJdHwiRJywcUMoCfrDiYrRp7zj4SVGIVM83ZeDTXF2Oafad+4xS1l?=
 =?us-ascii?Q?VBVPwnsvqNoNplVk0DP/GQFmLvhbwlS3BP7ov5ENlxd2Zv+917O2+S7/IGBJ?=
 =?us-ascii?Q?INChfZsCSMrG0hrZwJbK0nxg7F3lmZcts95v8GD6SRXrf6IUvvDQhXWnw+J+?=
 =?us-ascii?Q?afh4kv9UPfqQ0ia9gA2cZRuus1tjYC2CQ/A/2uCedLK26vgHxpqbVLAzQwk3?=
 =?us-ascii?Q?d7qLIQu7K8wbSIGNK4DD17IJYPIFQyqwFEgRop6CO0MPslotpFkYPueCOZ8c?=
 =?us-ascii?Q?yPswum/ad7ev/G5uYlLzFxlHJk80KUFqqN3t1dOYiSA4+li9pv/ESpkMi2vR?=
 =?us-ascii?Q?CETmISwLrVAflKsPY0lK2wTkowsEX4qgz0KO514nX75YiADsFHaypA5dRmEd?=
 =?us-ascii?Q?YYDDKpThRq5kzYTFF+X8BkXZ8wRjOUBA+o64fL9wZ5pyF8tIDK1s9YFa4NF0?=
 =?us-ascii?Q?Mbaj6Vr4KQ5LKvyCChsfv/XmyrD50+geJMqpoQtq7a82NaAIQDnn8/aINTXm?=
 =?us-ascii?Q?w1gnO8nOzRuE9RbaobTkIZUuracaHBC+ahhxUJKYo3u3axn+QUrLpkOWhfZe?=
 =?us-ascii?Q?1zH+rM0sNskQ7lp5oN69APByZTW9Wn7GU9zTVjRq2/RdOXS41EM5GsV/81pi?=
 =?us-ascii?Q?v3ezsCNfgBXMLQp6AsLpoeKSnXXG8bw/+O70c8g39h03+hAYAgC8m3VeVb6J?=
 =?us-ascii?Q?OIzelmgzedjcaLlR7vm8rBAduql9B2G4ig7habfXKzdx8dFPEAj9lpeUMA4j?=
 =?us-ascii?Q?ttsLIuetGfXBWe38JQn32YW+3ptVMn04HqzJyxLYf0oU1MPYi1uPjMgtvn/Z?=
 =?us-ascii?Q?B/PTJbMNmUN7Aft8bf0l3l0+r7PvtO4gHwzteP8AF296bN1fyu9wrcdmbG0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb11cee8-5930-495a-ae21-08dbcc434045
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 23:22:22.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1691
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1. Do not hard reset the BBP. We can use soft reset instead. This
   change has some help to the calibration failure issue.
2. Enable falling back to legacy rate from the HT/RTS rate by
   setting the HT_FBK_TO_LEGACY register.
3. Implement MCS rate specific maximum PSDU size. It can improve
   the transmission quality under the low RSSI condition.
4. Set BBP_84 register value to 0x19. This is used for extension
   channel overlapping IOT.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800.h   | 18 ++++++++++++++
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 24 +++++++++++++++++++
 .../net/wireless/ralink/rt2x00/rt2800mmio.c   |  3 +++
 3 files changed, 45 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800.h b/drivers/net/wireless/ralink/rt2x00/rt2800.h
index de2ee5ffc..48521e455 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800.h
@@ -870,6 +870,18 @@
 #define LED_CFG_Y_LED_MODE		FIELD32(0x30000000)
 #define LED_CFG_LED_POLAR		FIELD32(0x40000000)
 
+/*
+ * AMPDU_MAX_LEN_20M1S: Per MCS max A-MPDU length, 20 MHz, MCS 0-7
+ * AMPDU_MAX_LEN_20M2S: Per MCS max A-MPDU length, 20 MHz, MCS 8-15
+ * AMPDU_MAX_LEN_40M1S: Per MCS max A-MPDU length, 40 MHz, MCS 0-7
+ * AMPDU_MAX_LEN_40M2S: Per MCS max A-MPDU length, 40 MHz, MCS 8-15
+ * Maximum A-MPDU length = 2^(AMPDU_MAX - 5) kilobytes
+ */
+#define AMPDU_MAX_LEN_20M1S		0x1030
+#define AMPDU_MAX_LEN_20M2S		0x1034
+#define AMPDU_MAX_LEN_40M1S		0x1038
+#define AMPDU_MAX_LEN_40M2S		0x103C
+
 /*
  * AMPDU_BA_WINSIZE: Force BlockAck window size
  * FORCE_WINSIZE_ENABLE:
@@ -1545,6 +1557,12 @@
  */
 #define EXP_ACK_TIME			0x1380
 
+/*
+ * HT_FBK_TO_LEGACY: Enable/Disable HT/RTS fallback to OFDM/CCK rate
+ * Not available for legacy SoCs
+ */
+#define HT_FBK_TO_LEGACY		0x1384
+
 /* TX_PWR_CFG_5 */
 #define TX_PWR_CFG_5			0x1384
 #define TX_PWR_CFG_5_MCS16_CH0		FIELD32(0x0000000f)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 7b2bf23ac..acc720ef4 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -5903,6 +5903,7 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 	struct rt2800_drv_data *drv_data = rt2x00dev->drv_data;
 	u32 reg;
 	u16 eeprom;
+	u8 bbp;
 	unsigned int i;
 	int ret;
 
@@ -5912,6 +5913,19 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 	if (ret)
 		return ret;
 
+	if (rt2x00_rt(rt2x00dev, RT6352)) {
+		rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, 0x01);
+
+		bbp = rt2800_bbp_read(rt2x00dev, 21);
+		bbp |= 0x01;
+		rt2800_bbp_write(rt2x00dev, 21, bbp);
+		bbp = rt2800_bbp_read(rt2x00dev, 21);
+		bbp &= (~0x01);
+		rt2800_bbp_write(rt2x00dev, 21, bbp);
+
+		rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, 0x00);
+	}
+
 	rt2800_register_write(rt2x00dev, LEGACY_BASIC_RATE, 0x0000013f);
 	rt2800_register_write(rt2x00dev, HT_BASIC_RATE, 0x00008003);
 
@@ -6065,6 +6079,14 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 		reg = rt2800_register_read(rt2x00dev, TX_ALC_CFG_1);
 		rt2x00_set_field32(&reg, TX_ALC_CFG_1_ROS_BUSY_EN, 0);
 		rt2800_register_write(rt2x00dev, TX_ALC_CFG_1, reg);
+
+		rt2800_register_write(rt2x00dev, AMPDU_MAX_LEN_20M1S, 0x77754433);
+		rt2800_register_write(rt2x00dev, AMPDU_MAX_LEN_20M2S, 0x77765543);
+		rt2800_register_write(rt2x00dev, AMPDU_MAX_LEN_40M1S, 0x77765544);
+		rt2800_register_write(rt2x00dev, AMPDU_MAX_LEN_40M2S, 0x77765544);
+
+		rt2800_register_write(rt2x00dev, HT_FBK_TO_LEGACY, 0x1010);
+
 	} else {
 		rt2800_register_write(rt2x00dev, TX_SW_CFG0, 0x00000000);
 		rt2800_register_write(rt2x00dev, TX_SW_CFG1, 0x00080606);
@@ -7283,6 +7305,8 @@ static void rt2800_init_bbp_6352(struct rt2x00_dev *rt2x00dev)
 	rt2800_bbp_dcoc_write(rt2x00dev, 159, 0x64);
 
 	rt2800_bbp4_mac_if_ctrl(rt2x00dev);
+
+	rt2800_bbp_write(rt2x00dev, 84, 0x19);
 }
 
 static void rt2800_init_bbp(struct rt2x00_dev *rt2x00dev)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
index 862098f75..5323acff9 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
@@ -760,6 +760,9 @@ int rt2800mmio_init_registers(struct rt2x00_dev *rt2x00dev)
 
 	rt2x00mmio_register_write(rt2x00dev, PWR_PIN_CFG, 0x00000003);
 
+	if (rt2x00_rt(rt2x00dev, RT6352))
+		return 0;
+
 	reg = 0;
 	rt2x00_set_field32(&reg, MAC_SYS_CTRL_RESET_CSR, 1);
 	rt2x00_set_field32(&reg, MAC_SYS_CTRL_RESET_BBP, 1);
-- 
2.39.2

