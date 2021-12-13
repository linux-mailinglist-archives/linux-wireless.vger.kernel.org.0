Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54947347D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 19:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhLMS6L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 13:58:11 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:46406 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236468AbhLMS6L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 13:58:11 -0500
X-UUID: 29a3e20f9780424e8f96e610e30ecbfb-20211214
X-UUID: 29a3e20f9780424e8f96e610e30ecbfb-20211214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 685674370; Tue, 14 Dec 2021 02:58:08 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Dec 2021 02:58:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Dec
 2021 02:58:07 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Dec 2021 02:58:07 +0800
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
Date:   Tue, 14 Dec 2021 02:58:05 +0800
Message-ID: <1639421885-6126-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YbcYJ47OKfh0A5Vt@lore-desk--annotate>
References: <YbcYJ47OKfh0A5Vt@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> >> From: Sean Wang <sean.wang@mediatek.com>
>> >>
>> >> Update pm->suspended usage to be consistent with mt7921e driver.
>> >>
>> >> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> >> ---
>> >>  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 7 +++++--
>> >>  1 file changed, 5 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
>> >> b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
>> >> index 84be229a899d..44ee9369f6bf 100644
>> >> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
>> >> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
>> >> @@ -278,7 +278,6 @@ static int mt7921s_resume(struct device *__dev)
>> >>	struct mt76_dev *mdev = &dev->mt76;
>> >>	int err;
>> >>
>> >> -	pm->suspended = false;
>> >>	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
>> >>
>> >>	err = mt7921_mcu_drv_pmctrl(dev);
>> >> @@ -294,7 +293,11 @@ static int mt7921s_resume(struct device *__dev)
>> >>	if (!pm->ds_enable)
>> >>		mt76_connac_mcu_set_deep_sleep(mdev, false);
>> >>
>> >> -	return mt76_connac_mcu_set_hif_suspend(mdev, false);
>> >> +	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
>> >
>> >should we check return value here? Something like:
>> >
>> >	if (err)
>> >		return err;
>> >
>> >	pm->suspended = false;
>> >	return 0;
>> >
>> >Or, is the chip up even if mt76_connac_mcu_set_hif_suspend() fails?
>>
>> yes, chip is eventually up again by recovered with the following wifi
>> reset
>>
>> with current logic, if do so (not mark pm->suspended back as false to
>> show suspend/resume is over),
>>
>> the pm runtime would not be enabled again after the wifi reset
>
>maybe we should just set pm->suspended = false; in mt7921_mac_reset_work() as we do for hw_full_reset, wdyt?

That looks fine to me. I will submit another patch for that prior to the patch.

>
>Regards,
>Lorenzo
>
>>
>> >> +
>> >> +	pm->suspended = false;
>> >> +
>> >> +	return err;
>> >>  }
>> >>
>> >>  static const struct dev_pm_ops mt7921s_pm_ops = {
>> >> --
>> >> 2.25.1
>> >>
