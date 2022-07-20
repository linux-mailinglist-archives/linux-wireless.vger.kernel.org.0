Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AEC57C017
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jul 2022 00:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiGTWcp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 18:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTWco (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 18:32:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710794B0F0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 15:32:43 -0700 (PDT)
X-UUID: 41ce3d42a2ec4e92a980ba2b1950e8d6-20220721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:2810ddc0-f843-4f8a-9675-b96252bc118e,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:3,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:53
X-CID-INFO: VERSION:1.1.8,REQID:2810ddc0-f843-4f8a-9675-b96252bc118e,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:3,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:53
X-CID-META: VersionHash:0f94e32,CLOUDID:ba5ed464-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:fe589d076ed3,Recheck:0,SF:28|17|19|48,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 41ce3d42a2ec4e92a980ba2b1950e8d6-20220721
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 470889267; Thu, 21 Jul 2022 06:32:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 21 Jul 2022 06:32:37 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 21 Jul 2022 06:32:37 +0800
From:   <sean.wang@mediatek.com>
To:     <lorenzo.bianconi@redhat.com>
CC:     <nbd@nbd.name>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/3] mt76: mt7921s: fix the deadlock caused by sdio->stat_work
Date:   Thu, 21 Jul 2022 06:32:36 +0800
Message-ID: <1658356356-29058-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YtXYffraDN7RxoTr@lore-desk--annotate>
References: <YtXYffraDN7RxoTr@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Because wake_work and sdio->stat_work share the same workqueue
>> mt76->wq, if sdio->stat_work cannot acquire the mutex lock such as
>> that was possibly held up by mt7921_mutex_acquire, we should exit
>> immediately and schedule another stat_work to avoid blocking the mt7921_mutex_acquire.
>>
>> Also, if mt7921_mutex_acquire was called by sdio->stat_work self, the
>> wake would be blocked by itself, so we have to changing into an
>> unblocking wake (directly wakeup via mt7921_mcu_drv_pmctrl, not via
>> the wake_work) in the context.
>
>Hi Sean,
>
>it seems to me we are missing some logic here (e.g cancelling ps_work as we do in mt76_connac_pm_wake()). Is it enough to move mt7921_usb_sdio_tx_status_data on mac80211 workqueue? Can you see any performance issue? (same for mt7663).

I will try to reuse the mac80211 workqueue for stat_work that can help mt7921_usb_sdio_tx_status_data as is and fix the deadlock. thanks for your suggestion!

>
>Regards,
>Lorenzo
>
>>
>> Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
>> Co-developed-by: YN Chen <YN.Chen@mediatek.com>
>> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>  .../net/wireless/mediatek/mt76/mt7921/mac.c   | 22 +++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> index 6bd9fc9228a2..75e719175e92 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> @@ -1080,10 +1080,28 @@ bool mt7921_usb_sdio_tx_status_data(struct
>> mt76_dev *mdev, u8 *update)  {
>>	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev,
>> mt76);
>>
>> -	mt7921_mutex_acquire(dev);
>> +	if (!mutex_trylock(&mdev->mutex)) {
>> +		/* Because wake_work and stat_work share the same workqueue
>> +		 * mt76->wq, if sdio->stat_work cannot acquire the mutex lock,
>> +		 * we should exit immediately and schedule another stat_work
>> +		 * to avoid blocking the wake_work.
>> +		 */
>> +		struct work_struct *stat_work;
>> +
>> +		stat_work = mt76_is_sdio(mdev) ? &mdev->sdio.stat_work :
>> +			    &mdev->usb.stat_work;
>> +		queue_work(dev->mt76.wq, stat_work);
>> +
>> +		goto out;
>> +	}
>> +
>> +	mt7921_mcu_drv_pmctrl(dev);
>>	mt7921_mac_sta_poll(dev);
>> -	mt7921_mutex_release(dev);
>> +	mt76_connac_power_save_sched(&mdev->phy, &dev->pm);
>>
>> +	mutex_unlock(&mdev->mutex);
>> +
>> +out:
>>	return false;
>>  }
>>  EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_status_data);
>> --
>> 2.25.1
>>
>
