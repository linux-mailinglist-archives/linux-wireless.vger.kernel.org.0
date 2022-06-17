Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29906550007
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jun 2022 00:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiFQWhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 18:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFQWhX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 18:37:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16823A1BF
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 15:37:16 -0700 (PDT)
X-UUID: be1ca2b7b86e462b926a4bc9e8e0e4e6-20220618
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:84a477c5-3cad-4310-8f6f-e0ebc47a13a2,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:3,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:59
X-CID-INFO: VERSION:1.1.6,REQID:84a477c5-3cad-4310-8f6f-e0ebc47a13a2,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:3,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:59
X-CID-META: VersionHash:b14ad71,CLOUDID:74e5b0f6-e099-41ba-a32c-13b8bfe63214,C
        OID:5522a99faf10,Recheck:0,SF:28|17|19|48,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: be1ca2b7b86e462b926a4bc9e8e0e4e6-20220618
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1294325903; Sat, 18 Jun 2022 06:37:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 18 Jun 2022 06:37:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 18 Jun 2022 06:37:10 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>
CC:     <lorenzo.bianconi@redhat.com>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Mark-YW.Chen@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/2] mt76: mt7921u: enable HW beacon filter
Date:   Sat, 18 Jun 2022 06:37:09 +0800
Message-ID: <1655505429-4173-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <092a2631-4e91-203e-9199-96fd3c689afa@nbd.name--annotate>
References: <092a2631-4e91-203e-9199-96fd3c689afa@nbd.name--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>>On 16.06.22 03:10, sean.wang@mediatek.com wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> HW beacon filter and HW connection monitor can be supported on MT7921U
>> as well so we enable them to be consistent with MT7921[E,S].
>>
>> Tested-by: Deren Wu <deren.wu@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt7921/main.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> index acf6567368b7..d803a7dd5f83 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> @@ -677,8 +677,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
>>	if (changed & BSS_CHANGED_ASSOC) {
>>		mt7921_mcu_sta_update(dev, NULL, vif, true,
>>				      MT76_STA_INFO_STATE_ASSOC);
>> -		if (dev->pm.enable)
>> -			mt7921_mcu_set_beacon_filter(dev, vif, info->assoc);
>> +		mt7921_mcu_set_beacon_filter(dev, vif, info->assoc);
>To me it looks like patch description and code change don't really match. Could you please explain why you change it so that the beacon filter is enabled even if PM isn't?

dev->pm.enable is supposed to control runtime pm only and not related to hw beacon filter.

MT7921U still cannot support runtime pm as eafe031fd664 ("mt76: mt7921: disable runtime pm for usb") said.
but it doesn't only disable runtime pm but also would block the hw beacon filter to be enabled on MT7921U.
So here I correct dev->pm.enable usage to allow hw beacon filter enabled for MT7921U.

>
>- Felix
>


