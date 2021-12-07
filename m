Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E26846C1A8
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 18:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhLGRZp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 12:25:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55294 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229745AbhLGRZo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 12:25:44 -0500
X-UUID: 32fe2cfa28044b8da4866361d8a6c923-20211208
X-UUID: 32fe2cfa28044b8da4866361d8a6c923-20211208
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1697312388; Wed, 08 Dec 2021 01:22:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Dec 2021 01:22:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Dec 2021 01:22:03 +0800
From:   <sean.wang@mediatek.com>
To:     <lorenzo.bianconi@redhat.com>
CC:     <nbd@nbd.name>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Mark-YW.Chen@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: fix possible resume failure
Date:   Wed, 8 Dec 2021 01:21:57 +0800
Message-ID: <1638897717-14465-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <Ya8ysehFjoEGGEf+@lore-desk--annotate>
References: <Ya8ysehFjoEGGEf+@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Fix the possible resume failure due to mt76_connac_mcu_set_hif_suspend
>> timeout.
>>
>> That is because clearing the flag pm->suspended too early opened up a
>> race window, where mt7921_poll_tx/rx scheduled a ps_work to put the
>> device in doze mode, that is unexpected for the device is being
>> resumed from the suspend state and would make the remaining MCU
>> comamnds in resume handler failed to execute.
>
>do we have a similar issue in mt7921s_resume()?

We don't have the same issue found in mt7921s_resume because the driver
guarantees all MCU commands (even in mt7921s_resume) always work in the active
state.

But we can have the same patch for mt7921s just to make code consistent with
mt7921e.

>
>>
>> Fixes: ffa1bf97425b ("mt76: mt7921: introduce PM support")
>> Co-developed-by: YN Chen <YN.Chen@mediatek.com>
>> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
>> b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
>> index 5635de3c80b1..21a48f02ab60 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
>> @@ -315,7 +315,6 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
>>	struct mt76_connac_pm *pm = &dev->pm;
>>	int i, err;
>>
>> -	pm->suspended = false;
>>	err = pci_set_power_state(pdev, PCI_D0);
>>	if (err)
>>		return err;
>> @@ -353,7 +352,11 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
>>	if (!pm->ds_enable)
>>		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
>>
>> -	return mt76_connac_mcu_set_hif_suspend(mdev, false);
>> +	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
>> +
>> +	pm->suspended = false;
>> +
>> +	return err;
>>  }
>>  #endif /* CONFIG_PM */
>>
>> --
>> 2.25.1
>>
>
