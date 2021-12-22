Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3ACB47D7AB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 20:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbhLVT1h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 14:27:37 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:43154 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237755AbhLVT1f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 14:27:35 -0500
X-UUID: 81adc15f65384902bccb2eb2f2dd2c61-20211223
X-UUID: 81adc15f65384902bccb2eb2f2dd2c61-20211223
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 377665507; Thu, 23 Dec 2021 03:27:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 23 Dec 2021 03:27:29 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Dec 2021 03:27:29 +0800
From:   <sean.wang@mediatek.com>
To:     <lorenzo.bianconi@redhat.com>
CC:     <nbd@nbd.name>, <sean.wang@mediatek.com>,
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
Subject: Re: [PATCH] mt76: sdio: lock sdio when it is needed
Date:   Thu, 23 Dec 2021 03:27:28 +0800
Message-ID: <1640201248-14901-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YcMJDdDrDVIT0Y55@lore-desk--annotate>
References: <YcMJDdDrDVIT0Y55@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Acquire the SDIO as needed as possible because either MT7663S or
>> MT7921S is a multiple-function device that always includes Bluetooth
>> that would share with the same SDIO bus. So not to avoid breaking
>> Bluetooth pairing, audio, and HID such kind of time critical
>> application on that, we only lock sdio bus when it is necessary in WiFi driver.
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c | 3 +++
>> drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 3 +++
>>  drivers/net/wireless/mediatek/mt76/sdio_txrx.c   | 8 ++++++++
>>  3 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
>> b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
>> index 31c4a76b7f91..71162befdae8 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
>> @@ -56,7 +56,10 @@ static int mt7663s_parse_intr(struct mt76_dev *dev, struct mt76s_intr *intr)
>>	struct mt7663s_intr *irq_data = sdio->intr_data;
>>	int i, err;
>>
>> +	sdio_claim_host(sdio->func);
>>	err = sdio_readsb(sdio->func, irq_data, MCR_WHISR,
>> sizeof(*irq_data));
>> +	sdio_release_host(sdio->func);
>
>I guess you can move this in mt76s_rx_handler() and remove the duplicated code in mt7921_sdio.c
>

I got your point, but I still prefer we can release sdio lock as early as possible when WiFi driver doesn't need it
to allow BT driver has the chance to get the lock quickly.

>Regards,
>Lorenzo
>
>> +
>>	if (err)
>>		return err;

<snip>
