Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6D770F09
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Aug 2023 11:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjHEJSR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Aug 2023 05:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHEJSO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Aug 2023 05:18:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2061.outbound.protection.outlook.com [40.92.98.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24DE70
        for <linux-wireless@vger.kernel.org>; Sat,  5 Aug 2023 02:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kx1RTPqkMSOa052qg38PsSIs24cKTtl+gqi71avTAhm19DVLLOFxgTE8nV9ZGPeuaK/vqCOfCEO7iIEjG11TKNNVb2KR+UN6m4+FhnqyMI65kkS4T4mit6LEAe6XLmwdss/JuTJZ0n4mzHl61TyRfxW8kq6zpyoSrRkXeViOAGCLq5/7R1ACW2eSISOr5jveFtv/HR0D2uMjte/mX3HnUqEm3yYNQNhgIutKs5RDY2AJWG4mhLVIkeNRssG7RMaIm49OcQLnmnyqurSQWB9ntF/4jcxArYlIl+0LFMdV8ia1eZX0J41yiQDOOUFM31c+dKA7aMD+gM0ukjlBF2Jfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIECVLYYg/Q4QCSnQrE7KGhBYn44xv7C3I0lS3Gg2pU=;
 b=SPM6d/Z470Jh6tH6T4wyQrkPR9Sxvvc+dGGxjlevGbGBECHRa3IL86A4YdAWZPATG3U47ovg+QAGeaZrOYGpEy4PsRgolpUGBZkHJ+WFW8+aOv4SfUu+joIzoXZefKxFxgrGqXkk5lh1iCRr/T08e9pCasa8n/vBX/y33WJpmxChvSOgr8VPFFFtx3Gk2Q2Xyyi44jraGAMkkpmalRa7j6n2IiM0fHMPK6KN4/Uz7aN8kI8SUV4me7gPQWQFbpPFscDrAqAmgKjJ7fDTqSlnXezvG/j2TAL21lZVeJSBtFUxmlSQpLPfuG4LgacV8pfQUM5igw6ZFSmdPvuNSWfSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIECVLYYg/Q4QCSnQrE7KGhBYn44xv7C3I0lS3Gg2pU=;
 b=KCcJRlcJdzVL+OZhoEaDmM0JdWAwdEONVj3smklYS5xvS+Byuwu3ybR9aLdyyTKvfQrFVHmbdV1+GB6Vv9rSllRGUHKeyC/LeiLQImktE0EExkUiwD0y9LKj2Jd3szdgMalO47pR44JRT+RRXi0IVKuIVxb2zO82Crqxe4Rz8xJJpTeCB6BJadT7Fhrq0G9qRDWgvu2WfCR8uewQbitDN92lW2HKmm52x3iQSNp98is7USz/maoZj3lsS/qcjow+0JzG1v5zB8k4Gs/AqMqXl5QbONqVqY93bSFwQc2rOo4EVy07gto5/L1DYLie53jkgEvUILFAvy/QIjwdWstqYQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYTP286MB3450.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Sat, 5 Aug
 2023 09:18:08 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f4c2:4b38:d074:f1e9]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f4c2:4b38:d074:f1e9%5]) with mapi id 15.20.6652.022; Sat, 5 Aug 2023
 09:18:08 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] wifi: rt2x00: limit MT7620 TX power based on eeprom calibration
Date:   Sat,  5 Aug 2023 17:17:55 +0800
Message-ID: <TYAP286MB0315C7523FE0E2EEA7413BC4BC0EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [YEXj+y3wW2Iz7jNbZzfqhuyHVRfmA8kl]
X-ClientProxiedBy: TYCP286CA0309.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::10) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230805091755.6402-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYTP286MB3450:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddcbe9e-c246-4128-ecbc-08db9594e1c3
X-MS-Exchange-SLBlob-MailProps: 02NmSoc12DfEDR1Ya0qMyVi4VKFaWiNOwtKOE+vOr5QuyHgyLLHHgFjT6R8Cvgw7gXrHrc540L5S+Y+9RUpQ8E6sYJVdJod7/qQcP5+2j6iz1N6yOeOHTZcCkKM1MbEMc++z8wt2nuSuw/3fLa1hk2j1mVlEguFeUZPu6+cfaXCO8ntqjyCyZ6GTZT/lICoaSSFimqy4rk13IhtyAQNPatE33sdfJak9a2XQI/lY74gOqIK8oGFls8xlG9jUCq7avqxu4n9muWT/Pg5+sYiTPttIa69Ws4GTmrNE6gDVOMI1uKW65Z35cVX2u9OoH8Pv331PPuZ/kDBytn4WvvdXho4RR8EMEUDNoeP8BpLZfm0rZT8FtOzbO0THOJQD5FQugYvcLAihIpuin116BgTgbkH9ElpdbGdyt9nig0DDO6uQw4Xfol0Bh5GD8yNg9vqMll42ZbaKbmnD3MtlO6FoaHdgXRewCI92Vd6jBFZziP1tsmu2myTGcQ2AxVbV6PKS8Pa1QLUqG9r0xD3076TZaaLbaXmbbTyDXiY/vJnjDVb/jcANpzHSd/Fl2s1Ho24nQMKxvTy37awMPAFNP0GPTp72EtD7TMsVHE2ieIObFY6sHh3NMRlehfTi9jAaJyI97FwNeX1cn7/MHyp3zmdKq8pWDWAKFxfGzoMy4nx++N94e1QwOk4wGnDWtWao3AkueF5F1fNpTcfyfQtOWx+7aoUlwgrJVef9tQNjqfQE6RLoC/FDJn6etaHrBgwPqwtf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0zPvcRU+U3UlgLLTQsBfIGFfvN1JGvye5kvLZD7wx5pqSu4R6C5jVNK7n4SSgm2mRt3ETB8AxTveOy/IT68KRzWuGNqOJ6E2SMTE3ZIOLvXzImhBvvdil5MYyMl0jFAVdN/QHFdTi5w7roajj/YWUEdmOAsWwpkHgIogevzt4s55ZJfjekkUhAyK7qcz6NNCdVptxyTqqUeSssNqFpyBzOPyPR9javbHn8ZvPu80Zuj2EKB208qs37Xi5mErndNQbtg+JldKBNPhvkskn9Zgmq1zy0S7sGj3jkDkwvAHOzI1HHl1o4jlMq0W8gTVFT5VVp8HBT/GjrEwaAdJANmEUsEQpVrSeWFAUrNGDuBvNIU+bgC7avlBMysT2VbNX1PmaiwbeVbagIcgn7QfxQFGEKXMbe3rtda2kUQon0foEFrAhEdld7QMtY/IBKXafvgDQEKEdbUcOhGRh8pZPwrIVfHYHFOIKlqCjSX56DQ4+6fn3miLzsGoS0oH2KZIOB2DlbS+kxUlySUw1+lYsuNwQSF70//bkthVH37ykeWnGuUirRXuuWJJBgLDjYvIK7DoLQEqVcpP/HjL8d6yQXkkm9yhDQ+/6KggZrgB0HJRkFF7CQmECdUKD9KbupLWBeT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LcaRdNeR2CG3MZYethaNoXZn62CJoM1SzQWAE5ajyrxHpQYO9FqFamROvWv5?=
 =?us-ascii?Q?2Lf5Vus8f8eYClMP1au1NGc+83MCbL5H34HHa3mgWCaGlsSETAbreK4z9SMA?=
 =?us-ascii?Q?yuhxLaTYg2SL5SMfOJpVn44K3csTws7IctRErrhODxyvde8/ax+iZlERXZci?=
 =?us-ascii?Q?2mCe4LUb6IDCvSy0xCbBVwQwD1N0iCI7WTqBygTuFRQNgy2kBLTHRyjd6Kr+?=
 =?us-ascii?Q?fAlcOzVY3pgnj46c/xzgQUhTSZxvfD+FWwX16WfT+X1nk9NqMoeuYOcC30Gf?=
 =?us-ascii?Q?/7WTEr1cbCFxKxdQE1ujIAvY8TFReQeNXXsJPeEKnyLKHQ7Df+V3lct/KRRy?=
 =?us-ascii?Q?OYqgCt39tVP243y6GfB4fSSOy9QeaZCDMxgg6P0he5i9OjO8ETMKe1yY0fvv?=
 =?us-ascii?Q?yYByVoNhXMrpUt4Ogjzb5ZBOOwLNSfLnQcZHiN9WTb4BIs6RuRGfL87SGGDp?=
 =?us-ascii?Q?JT92UuQAc7Vsl2LyEEW8pd1Zfy/csq4yThygByTeVswqmEhW8z9UmC9K/MkB?=
 =?us-ascii?Q?feIZjj0MHxWwamkzgBoWv6QLYaNh1ZgVTwXL3ea60c1zOiHEpYHbkgjobI36?=
 =?us-ascii?Q?cuBxC1MAvmSCfebrhISkUTAYg4Da0wBlo1XH62qOm6TbyoGcxm+2dOkWSawH?=
 =?us-ascii?Q?/yMHnzZ7yX+5nK3FNVYU+AQoeq+0F9KdVFlTp3tY9cQNhZJhAwWhbMf1OGz4?=
 =?us-ascii?Q?1QZRMkuw1qhdpx4Adjfe7h+dCUAXTzk1s1mRr/38PSn2Apx7O5e1/Of5awsH?=
 =?us-ascii?Q?E1Sh/Y0IkxEDq0P3mmeMKzBOeY+tcumu7/rp91PVgkzGk6YYoJju0R8CVNsq?=
 =?us-ascii?Q?IYwklpH10yfarBkXnos1cZuR9rpFrjYzT4ouEJFQTlEIFXOIh+WyE+WWAesj?=
 =?us-ascii?Q?DTyldFYsBJUNeSeLuTm9enPt28kYFOcjEkk10+rE9iiYw0nKogPni9Es9t2y?=
 =?us-ascii?Q?TxvLik3JVmYduWhgH9AxSp2mF7l5cmbd95vhasMa+43EAByUBOXrGenXN1GE?=
 =?us-ascii?Q?wNhYAAWRtWokKg/ZW4yCyzY4N5mce0Y/thl+q0Z2mJnHP0D+8ZX6gPEqCKpb?=
 =?us-ascii?Q?7FTJC0IEXxOr5bpxGg003zrogr28XLCSa7tRakdX7okxBx0NwiWIfd56VHXw?=
 =?us-ascii?Q?fCPjnhWVdTUCPQ5XOMkqUyAhvSmezJURe+uV9uaFsghNChcVGcD5liWfWwES?=
 =?us-ascii?Q?MlmBGDq6dvNNeU6kK2OQo582KPkw3tI2RCyupq22WVfIjPmeZh5rJWrPbhU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddcbe9e-c246-4128-ecbc-08db9594e1c3
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 09:18:08.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3450
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
it's only used by RT6352(MT7620).

Notice:
It's still need some work to sync the max channel power to the user
interface. This part is missing from the rt2x00 driver framework. If
we set the power exceed the calibration value, it won't take effect.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 56 +++++++++++++------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 1226a883c..ff891353c 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -3865,28 +3865,50 @@ static void rt2800_config_channel_rf7620(struct rt2x00_dev *rt2x00dev,
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
+	/* get per chain power, 2 chains in total, unit is 0.5dBm */
+	power_level = (power_level - 3) * 2;
+
+	/*
+	 * We can't get the accurate TX power. Based on some tests, the real
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
+	if (power_level > chan->max_power * 2)
+		power_level = chan->max_power * 2;
 
-	max_power = chan->max_power * 2;
-	if (max_power > 0x2f)
-		max_power = 0x2f;
+	power_group[0] = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG1);
+	power_group[1] = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG2);
+	for (cnt = 0; cnt < 2; cnt++) {
+		chan_power = power_group[cnt][rt2x00dev->rf_channel - 1];
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
@@ -5268,7 +5290,7 @@ static void rt2800_config_txpower_rt6352(struct rt2x00_dev *rt2x00dev,
 	rt2x00_set_field32(&pwreg, TX_PWR_CFG_9B_STBC_MCS7, t);
 	rt2800_register_write(rt2x00dev, TX_PWR_CFG_9, pwreg);
 
-	rt2800_config_alc(rt2x00dev, chan, power_level);
+	rt2800_config_alc_rt6352(rt2x00dev, chan, power_level);
 
 	/* TODO: temperature compensation code! */
 }
-- 
2.39.2

