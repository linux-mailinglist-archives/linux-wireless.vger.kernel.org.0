Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0A87CF7C7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345488AbjJSL7W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 07:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345485AbjJSL7U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 07:59:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2058.outbound.protection.outlook.com [40.92.98.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C808B13E
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 04:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As+qEO0GFsciQmMTaXDok+YuXTUJGu6W7z3yfgEm7zuEt9lsapt2PFiUKANNEpF42d9qIx5QAHEQf9/SFlM3zk3JvF2pI0BjVjRmSNJGPZ1qieOdZ1SgB0I6BDyo0DmakFLzvw6saQ79geTty2/q2oKUiW+lkAYtubYilTi7JmgYep8EKXfJtV/xEAlVkjfnRwfpd7VkhGoyL9HAg815YR+wWhnIWhklBnPm+OUac1LppgGvdPqfbyjcm4U93HxezXyjR8P02qwkcP1/e4b34rAuUld9ZKPMg7i2bLzilqxl3i0zfZMy31oc5+u6F5VN9h5vcpbwy40AVoKRryrrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PYELlLRj/GVS7zUmN1Ca4BFDWB26dSlU0wtnSPSaKs=;
 b=McyCCvWKeRUPnGj+3Ij82HLKdRtummpncDAsXTaw+tZBTx80a73ao5eik7deexhLtE79dlULSuuEFWPFM6HirYr3gx2SKMD9yG9MBZIzudNqrCqAM2wB/jpizC6xdEJH64k3sgY4jOMok1QVlSscFBq1XApaF3jbpDcrKqlAUVzydCO/nCCRrxh2oYsAwZAl4iqHNZojA8wk+nqwKUReku1SFupiU2EYuliBIZvS0DEpWLfN2qXT80I67pvhJKJQuH5CgJED7dLXdp4suaFZFmqCv5OKF08QMDCwwaGdqEBz6y1FC+4kW+wj5AlYyxSB51jFTchPPUl2ICAfdigMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PYELlLRj/GVS7zUmN1Ca4BFDWB26dSlU0wtnSPSaKs=;
 b=Xum7TdtH33wYTO+8l+sv33vq7nJelyzEfVprgElAHl9DW0kyGUqTV4UXvMiAGoKsf8jdRsQsbLLZpLFQjpPWKny3+t0sDI12q+lMO0p2eE4F4tI3itEMHB9dMwIpyHXmof6yMrP12D6c5MbO5r07QVYRy9pS0kt9264CGoluPNIkPf9lTCk3eayg6mazQdP6aCvCRmhFx4NLhjOt/IcYbfrBpLwJ0vatRoyfnMWg7DeuviuVZqsylj/5NBn8cYfD+9oBqwbauKsdkuktTmAJZPJWDEVW5xneZZJHucP0zOXnQlljzfC6zEjFDHsd/5ly0AnvN7oW01ibtpymoifSPQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYWP286MB2729.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 11:59:15 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 11:59:15 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH V2 1/3] wifi: rt2x00: improve MT7620 register initialization
Date:   Thu, 19 Oct 2023 19:58:56 +0800
Message-ID: <TYAP286MB031553CCD4B7A3B89C85935DBCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019115859.2791-1-yangshiji66@outlook.com>
References: <20231019115859.2791-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [LusD4yKUbCMe3Iu74XrVn5segyZkGUhi]
X-ClientProxiedBy: TYCPR01CA0196.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::20) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231019115859.2791-2-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYWP286MB2729:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f82d3f-bf13-4c48-3be7-08dbd09ad0d2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAJLQwSB/6rn9vaz7Cq3Lz/SUECBZQ1Em5nor7REHw3go0iaa1ZOpW0NESLUtDMTTuHfcH4RMx3EksADC6+AfMqjrxbCKf/4ferOz0Y+14WQGIZBitrGNNeYSJE3RrXtk4k54HkUUdb5gXu3ehXGKQKsO3SR5tdA155KqhYiZIp6mk8WoKBlYpKWv5vtTTVCRq1w/aa54rEweJLaS4qGghWMp2nIXbaGFeA7dJc+xBatU5zdd1mfM26t2Rs92eZxSmSsnXJ7CVsjtmf3A0TfxyUxRkUlNQGS3a4t3RUjRUvedzSgfCEcsfcX9kll4veEYSAGfqfhKGxEBGopzM05yFAz6wAAWohYZ1V1QohKYeCQ8oXMgpH7/nqMdZ6Ij+evjLawoLwR2jnDehY+gLTjX6KxHZxrM6Lk0PsaXONwvsNg/uxRoh6+1T8lnxabj9+Va/AXnlyGm27fXfsJxcgn7idypXRuXBzx3nUiAIudLJk/xAeR6kEkiAfBYpYksKWyqQukGu3FWPiRQoGrvfF0NSTjKngBnKl1dDso9x0qxDDDR2uJUFgoEW+VNBrNFZHIFEvvppepIWxLBRSG/gpKyNUG7Bz2I113ShWcQ3rEmkCCXki7Bo2/qZQASZc/R2Zg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/9y1SuyRWzUNEj8D3blAGPGMjSWwSR8IfNQYky3LGuQO0v2JG3iIEzR8m8Zu?=
 =?us-ascii?Q?j7hKqK5EXDjEfHzuG3qYXTFVXuyVbfW/Rz7IYTfG8UKiV+GWOJh8+u5FGN4R?=
 =?us-ascii?Q?eMobxrb7dMxESb7s0kBtw0yVHkmjZNVW+9MsQTY2pRaKe32qFZtSQMs69H4g?=
 =?us-ascii?Q?B45lmPlKdH6MaCF5ZZ7dJ7BI1rbOrUdDDRMe9bsekUXB8jEzgK0hN1cV6MPe?=
 =?us-ascii?Q?ZUeBTLQiw9iXFVI/kGhysIm2oFU/rTh0y3TvZPYmap6RR2wZeA6A5d66VSoM?=
 =?us-ascii?Q?CNy6BVcGzukDJMsw2pMFs3tKtg2JTa5BowSJof90UtVweATcznfN91aCKr3Y?=
 =?us-ascii?Q?Ef/YyGRF+C/1OURCo7wYnj8DurNvZNBVn2/zd0usJyVaLeHmX4aclbdIR3K1?=
 =?us-ascii?Q?nt/U6/DAx39t1SOIOdbbqIYa+cqlQ9j7OyJtlcwlMH7yzz/y+TVrTVyuP2Xl?=
 =?us-ascii?Q?x2HruuA7PB/BppUJhV+IY2bGSJ3nLCRJ7D+Lqrfka1TixRrtzcPtmDvngeF4?=
 =?us-ascii?Q?k+yeXUcJIzE6cvJuw+X64H77+xuzY9jNFpB+xH3zY9BQL4yltV7g79NuelMe?=
 =?us-ascii?Q?N9iuuuRGizUyYQtaO/Oa6fXKZs4SYYgO2uw3KqB1m3WyrvOA7eQAzx7EEZHU?=
 =?us-ascii?Q?ff8RLLGTrEDw0XsGAHP2zFpw24VLPTMLCL8ldp/jjKV7SC6S7dh960Jd5qWx?=
 =?us-ascii?Q?HlTMk5B/ZfugeLjO0mlPJyx5WkXzHwEwDzBvFockhCIUdQw97XPweqDNBPED?=
 =?us-ascii?Q?tCqD9REKS4YF+VmPzcDA9dgzuKA6iEGVpMGG4S3+SN6l5+aCwZwxOV6+aO1t?=
 =?us-ascii?Q?DsBx4DLVtc7wNWeRakueQl0qXv4lgAugNU9StUqKs+xenZt+xrK3mcItX7LN?=
 =?us-ascii?Q?avYyhzq5YRz6WnOhTJI+UbvaRGa0qR3rNpW9NQlSURF2GDh+OIz2bK+O2IaU?=
 =?us-ascii?Q?X/IHumy62NUWOeXGD7gUkGPzxlaXUg0tEWD/5JgIDP0vbUkRk3toZqS21OkA?=
 =?us-ascii?Q?2/HE/mrG2cerweuracuSeChnCjiim0q59M6Inv4nQBvUYQW7hgQv1tvw0KNY?=
 =?us-ascii?Q?7PR8+T9mX99w9ZK8DBIGTHhTfGKkC2wNG3n1pSwITDL0aNZ6yzgs2FbXgJ4X?=
 =?us-ascii?Q?e4XvRU3+hvUKV+HaOertw5CZutmJz3vj4OEWhavSiUZcqioVQyEG47/Ke6Jj?=
 =?us-ascii?Q?RGS9up/m+u6n01a9axfSrudr+PlElv4TeRfy7YwPGb2DSaEVT6lMU1TO2Nw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f82d3f-bf13-4c48-3be7-08dbd09ad0d2
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 11:59:15.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2729
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 7fb9bc83b..08d979f69 100644
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

