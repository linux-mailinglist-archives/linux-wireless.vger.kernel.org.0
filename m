Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131BA77877F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 08:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjHKGfo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 02:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHKGfn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 02:35:43 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2102.outbound.protection.outlook.com [40.92.99.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955CC26B2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 23:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWpdRpeVQqscmJ0k8k4tKcIAQkrDnTU3o1Ea4a4Zwa5F418KFrUvfwWEBnjHG7Sq8+NK985REO6mbqqKlfX1Fp3rVZb8vmoWVOvGrZCf8G6OhlUER+2mrtU/bJfm6Tri4GvKJMPrz9KrSOgMU3GXsGW6UCtBtwyda5SVOjeAe/NGoPYy1b4N78L8+0ck9rV7jdfG+G+4eXQ6h0zJM7Chp38ZTzeyTS2Qlw8VNPGL7fIAOdgIvW46JxMzDjrdafMhnHIuQjeFbJ0tJkNuYkFIT9/plMnujm7AxtyKfA/O2DTcQ9oLVgRlc8Qjzv9onj/PUZd/Ozsx+ddDTh7bBNq5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJV637o3GXiss8u0A++8lvVXidUAn/SidmuvfPKwPZg=;
 b=Q9u8f6x10zI03ORqH1ZP9vyI2BXX23633y7MqiVqaWwO34cy4BTR0/F4L9dw+dKsQLwf3FvLrD7L//f5fSiUCByr15vUhWOpwuviMXfTV0RxlDnK7W8cA41MVrohthw5Aei1GylFmpYhC6hSe4d36ePF8TOGh8Y+UNraoXjtecRhbAutc3iRbxUGqiDlrS8KZscCpxzuovcDwqFETNqdwFhT6Et7IQ5w0Xc6+y5+GJs2S65+HpiHNcRQpZFTLXyUuykLXxR+dLVcgGLczOdH4MfKUTsvboJxhq7IDfTpqFRvPwGLiSUTjaoRmkO5jfK+rZx73iOzA4gEdsM4xgWoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJV637o3GXiss8u0A++8lvVXidUAn/SidmuvfPKwPZg=;
 b=KJBOvT/9WawxggQaIDIEAScyfSHcNzGRsj9LEelxxo4RjQHYyjjovv/U4F4SWiixH+5t1qrd8CdRcMlmasUj+WG6KwRFOtto00VKtNCXYUxgUmfuiCRTz6CeNfeUrdpzmYWsuVtsvTsiB4r9xw2WgGTP15KCQd4lOcJr1NnG1N6EfD1DjYZT/9dR9pt8VsUF292D3uXyezU58k5ON3cuHn7gwjFHpyu9L/+9wt3L6eD9v3gWndRalolJboGHUXBA6cb64+Ko047NZhnHIu6Jwn0ee1cmATcWD/aEKgDpo5AYaYps4uvZhfNgo7ArFi905coFNC0MoLmUTem/Am+xwQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB3470.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 06:35:39 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f4c2:4b38:d074:f1e9]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f4c2:4b38:d074:f1e9%5]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 06:35:39 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH V2] wifi: rt2x00: limit MT7620 TX power based on eeprom calibration
Date:   Fri, 11 Aug 2023 14:34:54 +0800
Message-ID: <TYAP286MB03159090ED14044215E59FD6BC10A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+X6llkbzMdBYa/JdlfW7hT8djszTSyI6]
X-ClientProxiedBy: TYCP286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::16) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230811063454.23925-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB3470:EE_
X-MS-Office365-Filtering-Correlation-Id: f38227d6-e276-4635-165b-08db9a352d33
X-MS-Exchange-SLBlob-MailProps: 02NmSoc12DeWTel27Tf23PglDRZDz2ZWcwR1d24903lxPZxbzTImcuspsSMwX/hFGLhiMU6qOyU6hT6kOzL0oUeXVxic2vCt0SK52BtqwKQlQRC4fPTHCyEK6PccNKBd1G6tyZigStGXMTDNWhDi35rHBlCkTBD0NmYCowv2zACPIXR1EFH8IUELmrDxdgvyLcg4GcYe2SeAsztW8aG2C41c/A3jvJ7DcpXML6ab1nFe0GxTXex+IhwoWtqUq1gvaT858n7dxksTSsB1LOaJ+MD0YknZNRX8x55khilbyB2Uxk3jN9Kg2o5HIIZYBoe8sULgX23poiFId9sXiIM9VjbpCp4E1hmLhoZJhgtpD+t8KGn4uljjhewogdXqi7kcreccTfVh7OFNCvQRWbDnJsox/1QttWTs2r2p/y8TgXn+h59qV2d4rWGwZ1Mzk/D/XADq0OqrB0NrDAwkfNzV7PeQWsAYAkLaHKGVIe4nCQNbhO6Na7GVk5DG8niHL67UIrt35nuNq682r8YV7Jnrl2T73xiszXBKtVjIAexzQlPFkx3nGV4Df5F3ksd2BCCNYK1YJkagsc7cLM/3aX4Yoyp6JYMgmUXLzHj5FuFz5pZNRsTB01XK8/jZDwjgAyT3FzU8BGSTEr4APC08SeY3ZSnPLVpeMg3io6yLdc1I8iu8wMhnpB2jiK7I3fX/iZXLL29JK/n9tnlTGK36NfyQXuMmwjWtRf+RxPwMekgpmCt3GsazKBz7bBwmW1sIcd0x
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULqBAl27j88mi2nxRYlis1Ixk5PwHrNE7w/tMUGAB7zybuWR5oQXdi+cwL6RUgSrbSfiljT0+BbaNhIEI6Tp4/psfBGLCedBtVNYm1iJv2z4afTJBca6EYMZsUPsJsGMgiO7vPR0kNOW7GZWbnFZw8EFyI6UQ7vK41JuvNIJpB5PlWjzF/iE1WgWSI6K6zZk/DZXV3b66jOSINjjV/uUUmAWm7cuhhqvBNdBXJUK6zjwWNsSpr3wGZAExbO4HMNnfr6P9YHz/zJL9OiUV3GQurkMENAODIZ4a7eH3ZWxpMjPF+0lurV3p4zNTiTLj2+Fkx2faUA1O5Yrji2ofcQibBomWixrnUC40dX8Cj24d70Sx5kEogsnHgbDTRrrHgGk10WjqZhVxpaB/EtiAzd6UKkJ6QomhjoaqWDFQNaFV9H8myM0ovBYGoiDyL1zRuunvhl7SNM/VhRKG5Gk6NQ5pOE7RD2emvZ/R2Cux0YzUDJGTpjLxV0gHDNyJW/m8V30ft1pVXt64EVCsJ+xVZKNMCxvXv5Xai4q0awyKCYka7ova/LZMReeJdQW61SO0GZ3CEC2xMZp017laVBGFD7+xAI9DFkEZBbhKcLXjPWvWuLO5cJOYJQdlh7GUrZ/1cre
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?22/LcUaxDfFgedwm+H+Gs4Oa41oobv0tSnPBZnldrSkpJwvV85TGebOk5+XU?=
 =?us-ascii?Q?jw+mtiaKmS5XYspdEX7lEejMs9GCjNr7qH68DMzDT1JTx19b9gDU/gGDamcc?=
 =?us-ascii?Q?LPEOBaKfGcluR12WQijYk6iW20Q6AeYfoi8zmn69h6/zNKpOVLr4jQ7Cs+6N?=
 =?us-ascii?Q?raGF0w2YpJ/TLWojBWNbEwvEQw+GbHHX7MzpyErZiz7TW23HZVuEg+b+BQnh?=
 =?us-ascii?Q?tnC9VgQ3hLF34poBHu99yiHxeRRDyvCq29dCNK9ToVrGGoYC29ANoCxZmAZl?=
 =?us-ascii?Q?a8BDyDjRaHrT5Fv0juYauwl8QdgvLZCeauU1jBB874EnuBukUXh6vzJr7mwd?=
 =?us-ascii?Q?UqvMXwlytHjE3lTTCyTyIheQrcMFhdofkacF3xJV2bzDqqbFFyByw99q5Z7x?=
 =?us-ascii?Q?FeyBA0FShfeiDsrXV0d7fK3gR7w2TeTJYhSPHWEpC7KFiZMu/sBexA2RZ8DB?=
 =?us-ascii?Q?GHuDwIYF0kGRcq2M9V1JkbYilGH4i16lfZwxEfpoy7kjPhywLR+4664LfKLK?=
 =?us-ascii?Q?oaxfHAUypImwJv5JVp1VgO4p/ulytJQSkce9igOUpjjeVYhQLgvOZq1vhg2N?=
 =?us-ascii?Q?otjcbcfay292OlpvZEJ5EzxlyjLHsLAnNa+P+Gz4yv7P/NMa2ymd8f4kQVdX?=
 =?us-ascii?Q?o7Ax5jkqQh+P1h6h69UAiWTCAoch3vYbgJpsyASNvSnRWvZ1vZLp+oyH+oJd?=
 =?us-ascii?Q?HB/S280OlAQd+mxMSexegfAKmjOnSQqNOgtVpZ43KUVlE27TsL9MIO+4aniI?=
 =?us-ascii?Q?53J9+/0SRTTQ4bm51COlLt6chDFjSDOP+h/UJsyNKeDXMWQqCM3K7CFSehlr?=
 =?us-ascii?Q?mulc5NyMdw+QeUsxsDEf11BdA8qPXEwxZnIYql04E9sxUayLbOjJVzjs8ngg?=
 =?us-ascii?Q?QeEDe4iFJJFdm8Uk6MpUKo3bznGv1qTPRaCb6EqRovCf7SlFmzttqcJC911c?=
 =?us-ascii?Q?MJtqKRf3SKjFsteLNa5/kB1+aclXVoVRH2GJcnhDWm69whGzLxP0CTfcGphw?=
 =?us-ascii?Q?uvh1YkDtsHzWfX3DGUZpa6F/QqoRP97PNbLURevlsWNbBJu8eOB+C2EOfN/F?=
 =?us-ascii?Q?hUTi+c4oVgEbBTREFyNtWyHZGVtKNesXArIw3a/RNkBpIRngqiG++4p87yrR?=
 =?us-ascii?Q?+Oa9G1uCK+bFnmHJh6RQswpmnuX6oIVptoOn9/YgSjvGlItrPjI20TjmnEEO?=
 =?us-ascii?Q?dQmm8AuT9zP5FujXNaY3CGo95dSpjxsXP+a6Q2h2tcQ4Yi884898rPsybrM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38227d6-e276-4635-165b-08db9a352d33
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 06:35:39.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3470
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the vendor driver, the current channel power is queried from
EEPROM_TXPOWER_BG1 and EEPROM_TXPOWER_BG2. And then the mixed value
will be written into the low half-word of the TX_ALC_CFG_0 register.
The high half-word of the TX_ALC_CFG_0 is a fixed value 0x2f2f.

We can't get the accurate TX power. Based on my tests and the new
MediaTek mt76 driver source code, the real TX power is approximately
equal to channel_power + (max) rate_power. Usually max rate_power is
the gain of the OFDM 6M rate, which can be readed from the offset
EEPROM_TXPOWER_BYRATE +1.

Based on these eeprom values, this patch adds basic TX power control
for the MT7620 and limits its maximum TX power. This can avoid the
link speed decrease caused by chip overheating. rt2800_config_alc()
function has also been renamed to rt2800_config_alc_rt6352() because
it's only used by RT6352 (MT7620).

Notice:
It's still need some work to sync the max channel power to the user
interface. This part is missing from the rt2x00 driver framework. If
we set the power exceed the calibration value, it won't take effect.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
Changes in V2:

* Check if the current channel number is valid.
* Remove unnecessary max_power check since power_level has already
  been regulated by the mac80211.


 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 57 +++++++++++++------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 1226a883c..637d745f5 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -3865,28 +3865,51 @@ static void rt2800_config_channel_rf7620(struct rt2x00_dev *rt2x00dev,
 	}
 }
 
-static void rt2800_config_alc(struct rt2x00_dev *rt2x00dev,
-			      struct ieee80211_channel *chan,
-			      int power_level) {
-	u16 eeprom, target_power, max_power;
+static void rt2800_config_alc_rt6352(struct rt2x00_dev *rt2x00dev,
+				     struct ieee80211_channel *chan,
+				     int power_level)
+{
+	int cur_channel = rt2x00dev->rf_channel;
+	u16 eeprom, chan_power, rate_power, target_power;
+	u16 tx_power[2];
+	s8 *power_group[2];
 	u32 mac_sys_ctrl;
-	u32 reg;
+	u32 cnt, reg;
 	u8 bbp;
 
-	/* hardware unit is 0.5dBm, limited to 23.5dBm */
-	power_level *= 2;
-	if (power_level > 0x2f)
-		power_level = 0x2f;
+	if (WARN_ON(cur_channel < 1 || cur_channel > 14))
+		return;
+
+	/* get per chain power, 2 chains in total, unit is 0.5dBm */
+	power_level = (power_level - 3) * 2;
 
-	max_power = chan->max_power * 2;
-	if (max_power > 0x2f)
-		max_power = 0x2f;
+	/* We can't get the accurate TX power. Based on some tests, the real
+	 * TX power is approximately equal to channel_power + (max)rate_power.
+	 * Usually max rate_power is the gain of the OFDM 6M rate. The antenna
+	 * gain and externel PA gain are not included as we are unable to
+	 * obtain these values.
+	 */
+	rate_power = rt2800_eeprom_read_from_array(rt2x00dev,
+						   EEPROM_TXPOWER_BYRATE, 1);
+	rate_power &= 0x3f;
+	power_level -= rate_power;
+	if (power_level < 1)
+		power_level = 1;
+
+	power_group[0] = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG1);
+	power_group[1] = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG2);
+	for (cnt = 0; cnt < 2; cnt++) {
+		chan_power = power_group[cnt][cur_channel - 1];
+		if (chan_power >= 0x20 || chan_power == 0)
+			chan_power = 0x10;
+		tx_power[cnt] = power_level < chan_power ? power_level : chan_power;
+	}
 
 	reg = rt2800_register_read(rt2x00dev, TX_ALC_CFG_0);
-	rt2x00_set_field32(&reg, TX_ALC_CFG_0_CH_INIT_0, power_level);
-	rt2x00_set_field32(&reg, TX_ALC_CFG_0_CH_INIT_1, power_level);
-	rt2x00_set_field32(&reg, TX_ALC_CFG_0_LIMIT_0, max_power);
-	rt2x00_set_field32(&reg, TX_ALC_CFG_0_LIMIT_1, max_power);
+	rt2x00_set_field32(&reg, TX_ALC_CFG_0_CH_INIT_0, tx_power[0]);
+	rt2x00_set_field32(&reg, TX_ALC_CFG_0_CH_INIT_1, tx_power[1]);
+	rt2x00_set_field32(&reg, TX_ALC_CFG_0_LIMIT_0, 0x2f);
+	rt2x00_set_field32(&reg, TX_ALC_CFG_0_LIMIT_1, 0x2f);
 
 	eeprom = rt2800_eeprom_read(rt2x00dev, EEPROM_NIC_CONF1);
 	if (rt2x00_get_field16(eeprom, EEPROM_NIC_CONF1_INTERNAL_TX_ALC)) {
@@ -5268,7 +5291,7 @@ static void rt2800_config_txpower_rt6352(struct rt2x00_dev *rt2x00dev,
 	rt2x00_set_field32(&pwreg, TX_PWR_CFG_9B_STBC_MCS7, t);
 	rt2800_register_write(rt2x00dev, TX_PWR_CFG_9, pwreg);
 
-	rt2800_config_alc(rt2x00dev, chan, power_level);
+	rt2800_config_alc_rt6352(rt2x00dev, chan, power_level);
 
 	/* TODO: temperature compensation code! */
 }
-- 
2.39.2

