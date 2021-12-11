Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240224714E2
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Dec 2021 18:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhLKROs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Dec 2021 12:14:48 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:41914 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231528AbhLKROs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Dec 2021 12:14:48 -0500
X-UUID: 401d122145be4718b572b09505e262d0-20211212
X-UUID: 401d122145be4718b572b09505e262d0-20211212
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1918031745; Sun, 12 Dec 2021 01:14:46 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 12 Dec 2021 01:14:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 12 Dec
 2021 01:14:44 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 12 Dec 2021 01:14:44 +0800
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
Subject: Re: [PATCH 1/2] mt76: mt7921s: make pm->suspended usage consistent
Date:   Sun, 12 Dec 2021 01:14:42 +0800
Message-ID: <1639242882-15796-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YbTU08hzeTSJPIsp@lore-desk--annotate>
References: <YbTU08hzeTSJPIsp@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Update pm->suspended usage to be consistent with mt7921e driver.
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
>> index 84be229a899d..44ee9369f6bf 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
>> @@ -278,7 +278,6 @@ static int mt7921s_resume(struct device *__dev)
>>	struct mt76_dev *mdev = &dev->mt76;
>>	int err;
>>
>> -	pm->suspended = false;
>>	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
>>
>>	err = mt7921_mcu_drv_pmctrl(dev);
>> @@ -294,7 +293,11 @@ static int mt7921s_resume(struct device *__dev)
>>	if (!pm->ds_enable)
>>		mt76_connac_mcu_set_deep_sleep(mdev, false);
>>
>> -	return mt76_connac_mcu_set_hif_suspend(mdev, false);
>> +	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
>
>should we check return value here? Something like:
>
>	if (err)
>		return err;
>
>	pm->suspended = false;
>	return 0;
>
>Or, is the chip up even if mt76_connac_mcu_set_hif_suspend() fails?

yes, chip is eventually up again by recovered with the following wifi reset

with current logic, if do so (not mark pm->suspended back as false to show suspend/resume is over),

the pm runtime would not be enabled again after the wifi reset

>> +
>> +	pm->suspended = false;
>> +
>> +	return err;
>>  }
>>
>>  static const struct dev_pm_ops mt7921s_pm_ops = {
>> --
>> 2.25.1
>>
