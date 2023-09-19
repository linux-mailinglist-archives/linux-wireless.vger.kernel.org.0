Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8D77A6332
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjISMjA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 08:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjISMi7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 08:38:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2089.outbound.protection.outlook.com [40.92.98.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52939F9
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 05:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LahZvm1bK1FD3CN3cJ4dmGQ9JprRq1k1XnEr1zih8FsvZp6IbvzjpjBTxqst/5ALz35YoM6CGoxagS1u6JK6Xy8oIBiQOoXj4Y+Jo1Ng7vwgrTiDSZH5wqnR0YCekQLUkbmSbTYEZbSo6VfzQVeEB7n4xf5jsXfjt0aBmlIVqfNFAc37VOjhO8cMjuxpVLsqI/3tjc9wYDhhZQ+eq0KV7JyMDQRtKtloxEqNN2uWzQW2ZV5nhZuefOsb5e67YK5Nd02K6sEdcwG2UeI2UhNJAIp/KDoD3a/kLGWbvT2CE/L3SiuYqD8m0PQqjV6HlU6Yu3QrUDlCS0suFi+eFikYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbVTe44JsWzpfdulS8Lp71S+hoHg00PvpawU92+6okk=;
 b=TiptDnhRrygnwPXDAmld1S9MvOIyQkEwQLUGlXeQtcMjS5j+5729SXWr8ICQMDFSFG7pa7LBp8VDnxQwWrqH89DFeRdTFcayIS1O132d7kug3scC8HyMTwPA45dgDR4CKWinWVsU3X65O6n93Ot8VtWXizpMjSoqnEIJyeb/jl/SEO0UynuQN6EOJsbxUHM8fYVp8GTChOA26fdDLutsql5tYuPXrUDWg4Smdt6H4rAXgHy2JasxqgHR5r42VyxJainger9zV6OabzG/1Y1gjcMLhBnfp+3PKkeX+UtbLD1rm8O/zWzaiDr/NO8eDlDFjVNX8aJNfl12qjC5wlv7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbVTe44JsWzpfdulS8Lp71S+hoHg00PvpawU92+6okk=;
 b=mvdlpHfEe0lYN5YXQbChZgIgtLtP4Ea1ya1Aok/+/UyG61XUKrVQ0bfJMvD9weZdT7HDplXEH+uFrda1wnNnJ2ECMYVjgB+RHagqB6r1tgpl82grOu7uXjpetFhPPssE0BGvUd/lWvvdr4EOptylXJajMq0Ct/znuvR8Ghc9NJqckTvPPr/A3m5HDYnWTQzw4PY6J8Pur3SBBXMwb4stpSyl0RX8r/5yBM4byHECYyn+rAOO2UwDwzZyjLG4nIWSf3MWvTufaBB2N6TlvZTsyNs8SffU5zjw9CXRTxnOncL02h8m7KQ8Ts1WMeWe8R85XV441Tcw7T6HdN1HGhdT5g==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB3535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Tue, 19 Sep
 2023 12:38:48 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b03c:5b9d:f7a4:9470]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b03c:5b9d:f7a4:9470%6]) with mapi id 15.20.6813.014; Tue, 19 Sep 2023
 12:38:48 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     nbd@nbd.name
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        lorenzo@kernel.org, ryder.lee@mediatek.com, sean.wang@mediatek.com,
        shayne.chen@mediatek.com
Subject: [PATCH] wifi: mt76: mt76x02: correct external LNA gain
Date:   Tue, 19 Sep 2023 20:38:33 +0800
Message-ID: <TYAP286MB0315CAB1FCED135CAC91CF09BCFAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <9ca15b75-390f-4647-bc70-3f2f8994db27@nbd.name>
References: <9ca15b75-390f-4647-bc70-3f2f8994db27@nbd.name>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [yKNMJ5lJlrumarZnAdz9WvVVHw4vz59iartbCHmRzE4=]
X-ClientProxiedBy: KL1PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:820::36) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230919123833.8671-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB3535:EE_
X-MS-Office365-Filtering-Correlation-Id: 4386d6a8-67ae-48c9-a637-08dbb90d5ea3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KgPRKFEE3LUuNPsUW4+O1F4dN/b8M41zxOp7DSF5XhP9o5t/QBro2YROyz71hhZFig8MHW1LxKwYJn/nAHPT6nX084YAzXERlGZV8FlZuh2ECSuhvqjsCIoN/a3HQdcaG9NIw5YdW3qhOkkMY+J7mFvM/Pk2lsuWbWCruywXTtGtQl+nvVtFUByOH0eNbUxi9AN1Eh8AhNtMowWilqigya1QXFPNe3weJ6Yw0A+REoAD3JlOn+4vMtx2BXXMs/UZcTfIDlDfGhWO+4MaJbxv/TdaxTJFf9yKWH47F/JPs6UWiORVrsXJ3CYKM30AoiEMXupvThGedsfSEJfzTAfFrFz1qv8ZlYunV6SNKTuyORg7RaLyKz1XVcg2m2EYnywiEjUr75c9UQeEXjINRFjE3Go99UOppKfdftfOPe70KRFIFqh3TPo/XruQMWU2MRM227ARJc/9bC5iyJTn2PR4Kavf0KDGOUCLysoDphHK6eUeQKQ62hZZLx+E9p4fUV691zit3dwvvi6DCCP06Du8TJ/BUnmMtciNZpp7BqW1NxxVARy4vjl9tThG3OR2BWC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RPV9Ybegni9CV1i/npndPtmq7aRy5sT11QG0Me9LduL+CbRESyTeosGcwQFM?=
 =?us-ascii?Q?t5VKT5DSd6hCpeLUn7TX01s3qStn3Bg7TqacDkwpge/YD0MqJcqeuQ1PkHx4?=
 =?us-ascii?Q?WrwiUyrRZv/MVVnQtDuIXywadPl1HG+LJxTDQ/UVsQ47pMcOWpt0jGBcKe1W?=
 =?us-ascii?Q?3ofyBFEC7ZOX5Wpi7RZpt9loGYHv1zT4GLXvFviozsusobEJlEvrjwOxIqDd?=
 =?us-ascii?Q?oDoMF+uaXlgwuZt2QsCnttbnukD3Yxv6Kco8vDnuoNUhcssGuvPYgjCfEbMd?=
 =?us-ascii?Q?NpYIrkVKFwh3FtnIQspZy2hkpujZdYbdlO7PNJUIfKHruUb/2+7KCkitlIn8?=
 =?us-ascii?Q?qmpP0XNkLTVTeJdLeMYxCh98c0PoOQ8G8EBLb4AX4fd5YsWZMPtGzMKHP1sB?=
 =?us-ascii?Q?t2SrTSUDj0jVh6J5pghk31hY9fzr4XS2GUH/a5nz7z5GLOhkIpIyr3BHsmga?=
 =?us-ascii?Q?EdasuE7XYN83MGuHw+n7YojhF68FM2kCHSLzMs2Inv++V4A6rMdnwlB4l0ba?=
 =?us-ascii?Q?oAvAvKGSOlzvgxO3MYVt/3CYLJ98yjYeadigLaoGUUr+7fgFwt9RzbM5Ku4t?=
 =?us-ascii?Q?fEOmBm64VTtkNlCzUSEya/lEqsP1ROEj3LQrrX8o/8PLCVoQpEk3sAwpub7l?=
 =?us-ascii?Q?hyrWnQrdtddxTKr3tgfUXtRFBsdABILEzFDOLpWPqnubkJToVPC0Xe8HDwex?=
 =?us-ascii?Q?DLH7O1HO8BaoVfP3mHnXPXSjuBWYuMVhOIuuOB/Sf5f6bRA0j8d7Gd+NwdN3?=
 =?us-ascii?Q?rEWGwPSuaMlgJ3Bc4CYk6UHF/YlQNUQzKbNbtT9M4FO/isUtDQ9FJys9b/iQ?=
 =?us-ascii?Q?OzZiFG7XfkaM2UjuSGtTTDPiDAm8pQGj8MgR5/h4On8FHR+k9op4nOKDHl+6?=
 =?us-ascii?Q?FZm3zHd+kAyqnFGXruosI9PTUF6RZ0RMqgJgIQEznYjjDQB92bzNCGYN4EOs?=
 =?us-ascii?Q?Mn3iZ2X1fsc6vgYKgNezzhxXDuyWORlO7QO/X1fDemKj82B6FBmgF0X/NyJh?=
 =?us-ascii?Q?RkSlyUvLadb2muGfEFlynXLxd9HvM8CvdphVr2G5nVRCNv6DmSYA49jJB9/m?=
 =?us-ascii?Q?e09zruHMEcrksf2i6pl1BiiSvDyP2NM+lB9VOt3ns6R+8xtvcXH6Zilmmcxz?=
 =?us-ascii?Q?IV8uHGHhrA2Ch9Zz5Pt1VCfCGUuEnNsJLdIusrT6/zPEQqUzDXGLnzOqSNp6?=
 =?us-ascii?Q?WA/ZYwq0AFE8DR0PDeNvZ6EljS1+7v5cGOEwp7fzynqLNFuoj7oIyXrO96A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4386d6a8-67ae-48c9-a637-08dbb90d5ea3
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 12:38:48.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3535
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 19 Sep 2023 13:39:48 +0200, Felix Fietkau wrote:

>On 19.09.23 13:24, Felix Fietkau wrote:
>> On 19.09.23 06:48, Shiji Yang wrote:
>>> Referring to the MT761{0,2} EEPROM content, setting the corresponding
>>> EEPROM control bit means enabling external LNA. In this case, we
>>> should use the EEMROM LNA gain instead of 0.
>>> 
>>> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
>>> ---
>>>   drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
>>> index 0acabba2d..a0b95509a 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
>>> @@ -135,9 +135,9 @@ u8 mt76x02_get_lna_gain(struct mt76x02_dev *dev,
>>>   	u8 lna;
>>>   
>>>   	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
>>> -	if (val & MT_EE_NIC_CONF_1_LNA_EXT_2G)
>>> +	if (!(val & MT_EE_NIC_CONF_1_LNA_EXT_2G))
>>>   		*lna_2g = 0;
>>> -	if (val & MT_EE_NIC_CONF_1_LNA_EXT_5G)
>>> +	if (!(val & MT_EE_NIC_CONF_1_LNA_EXT_5G))
>>>   		memset(lna_5g, 0, sizeof(s8) * 3);
>>>   
>>>   	if (chan->band == NL80211_BAND_2GHZ)
>> 
>> I took a closer look at the interpretation of these flags and how they
>> are handled in the vendor driver. From what I can tell, on MT76x2 LNA
>> gain should only be used as part of the RSSI calculation for internal
>> LNA devices. In the MT76x0 code, I see no such checks, so the LNA gain
>> should be used unconditionally.
>> What do you think about this patch?
>> 
>> Thanks,
>> 
>> - Felix
>
>Sorry, there was a missing line in the last patch. Here is the right
>version:
>
>--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
>+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
>@@ -131,15 +131,8 @@ u8 mt76x02_get_lna_gain(struct mt76x02_dev *dev,
>  			s8 *lna_2g, s8 *lna_5g,
>  			struct ieee80211_channel *chan)
>  {
>-	u16 val;
>  	u8 lna;
>  
>-	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
>-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_2G)
>-		*lna_2g = 0;
>-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_5G)
>-		memset(lna_5g, 0, sizeof(s8) * 3);
>-
>  	if (chan->band == NL80211_BAND_2GHZ)
>  		lna = *lna_2g;
>  	else if (chan->hw_value <= 64)
>--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
>+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
>@@ -256,7 +256,8 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
>  	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
>  	int channel = chan->hw_value;
>  	s8 lna_5g[3], lna_2g;
>-	u8 lna;
>+	bool use_lna;
>+	u8 lna = 0;
>  	u16 val;
>  
>  	if (chan->band == NL80211_BAND_2GHZ)
>@@ -275,7 +276,15 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
>  	dev->cal.rx.mcu_gain |= (lna_5g[1] & 0xff) << 16;
>  	dev->cal.rx.mcu_gain |= (lna_5g[2] & 0xff) << 24;
>  
>-	lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
>+	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
>+	if (chan->band == NL80211_BAND_2GHZ)
>+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_2G);
>+	else
>+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_5G);
>+
>+	if (use_lna)
>+		lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
>+
>  	dev->cal.rx.lna_gain = mt76x02_sign_extend(lna, 8);
>  }
>  EXPORT_SYMBOL_GPL(mt76x2_read_rx_gain);
>

Your patch looks better than mine. Yes, I also found that the MT7610
stock driver always unconditionally reads lna gain from eeprom. So
please keep your fix version.

Regards,
Shiji Yang
