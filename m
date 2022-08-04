Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE559589C36
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 15:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbiHDNJz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiHDNJy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 09:09:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D632E15738
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 06:09:48 -0700 (PDT)
X-UUID: 7caa4bb023f549bbb966b3c600761c7f-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/4C4aVQMh4NofH2NbUELDZGPlO1FKVl1Qiqt7ZiiGS0=;
        b=AUr0OrLj2IFaig2DW2kuwUZ9GyNCtIlwfNNaMcWfkFSTjPYcvui4005Y+kW8BQPOFAfQBsDFxcja80QxXqco5x4CzshBq3un3AY1cTdg8L97bWARVvizXWh6hblkE1U8k64pKt0x/6AhhAma5z/E9fMMyTJt9Z92+5Q9kKQMlJk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:40c76438-44da-4724-b857-f74798ae6c34,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:0f94e32,CLOUDID:5b824cd0-a6cf-4fb6-be1b-c60094821ca2,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 7caa4bb023f549bbb966b3c600761c7f-20220804
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1759874264; Thu, 04 Aug 2022 21:09:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 4 Aug 2022 21:09:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Aug 2022 21:09:42 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo@kernel.org>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: apply the previous MCU timeout
Date:   Thu, 4 Aug 2022 21:09:41 +0800
Message-ID: <1659618581-20400-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YuuAX3aa/bmL5ZdM@localhost.localdomain--annotate>
References: <YuuAX3aa/bmL5ZdM@localhost.localdomain--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Apply back the previous MCU timeout that can trigger the chip reset to
>> recover the fatal error in time.
>>
>> Fixes: 8fcd1fb7cbd5 ("mt76: move mt76_connac2_mcu_fill_message in
>> mt76_connac module")
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>>  b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> index 0afcadce87fc..da8223c515eb 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> @@ -3050,7 +3050,10 @@ int mt76_connac2_mcu_fill_message(struct
>> mt76_dev  *dev, struct sk_buff *skb,
>>	u8 seq;
>>
>>	/* TODO: make dynamic based on msg type */
>> -	dev->mcu.timeout = 20 * HZ;
>> +	if (is_mt7921(dev))
>> +		dev->mcu.timeout = 3 * HZ;
>> +	else
>> +		dev->mcu.timeout = 20 * HZ;
>
>Hi Sean,
>
>I did not get the fix here since we are setting dev->mcu.timeout in
 mt76_connac2_mcu_fill_message caller (e.g. mt7921s_mcu_send_message).
>Am I missing something?

oops! You're right. The patch should be dropped out. Thanks for the head-up.

	Sean
>
>Regards,
>Lorenzo
>
>>
>>	seq = ++dev->mcu.msg_seq & 0xf;
>>	if (!seq)
>> --
>> 2.25.1
>>

