Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D034F3ABA90
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFQRVt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 13:21:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34104 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230457AbhFQRVs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 13:21:48 -0400
X-UUID: 0e27484dec4e4902a992eb0ec3a07766-20210618
X-UUID: 0e27484dec4e4902a992eb0ec3a07766-20210618
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1803025238; Fri, 18 Jun 2021 01:19:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 01:19:36 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 01:19:36 +0800
From:   <sean.wang@mediatek.com>
To:     <lorenzo.bianconi@redhat.com>
CC:     <nbd@nbd.name>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: fix the coredump is being truncated
Date:   Fri, 18 Jun 2021 01:19:35 +0800
Message-ID: <1623950375-23007-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YMtTlS3Nh4uGnJvq@lore-desk--annotate>
References: <YMtTlS3Nh4uGnJvq@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>


>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Fix the maximum size of the coredump generated with current mt7921
>> firmware. Otherwise, a truncated coredump would be reported to
>> userland via dev_coredumpv.
>>
>> Also, there is an additional error handling enhanced in the patch to
>> avoid the possible invalid buffer access when the system failed to
>> create the buffer to hold the coredump.
>>
>> Fixes: 0da3c795d07b ("mt76: mt7921: add coredump support")
>> Co-developed-by: YN Chen <YN.Chen@mediatek.com>
>> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt76_connac.h | 2 +-
>> drivers/net/wireless/mediatek/mt76/mt7921/mac.c  | 9 ++++++---
>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
>> b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
>> index 9b3f8d22f17e..d93ab1ece8ae 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
>> @@ -13,7 +13,7 @@
>>  #define MT76_CONNAC_MAX_SCAN_MATCH		16
>>
>>  #define MT76_CONNAC_COREDUMP_TIMEOUT		(HZ / 20)
>> -#define MT76_CONNAC_COREDUMP_SZ			(128 * 1024)
>> +#define MT76_CONNAC_COREDUMP_SZ			(1300 * 1024)
>>
>>  enum {
>>	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20, diff --git
>> a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> index fb4de73df701..905dddbfbb0b 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> @@ -1557,7 +1557,7 @@ void mt7921_coredump_work(struct work_struct *work)
>>			break;
>>
>>		skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
>> -		if (data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
>> +		if (!dump || data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
>
>why not just return if dump allocation fails? Doing so we will reset the device even if dump is NULL, do you think it is a real use-case?

We cannot just return if dump allocation fails because we still must properly free skb in coredump.msg_list to avoid
the memory leak.

Reset the device is eventually required even dump is NULL because mt7921 cannot work anymore in case coredump happens
so that needs the following reset to recover it back in time.

>Regards,
>Lorenzo
>
>>			dev_kfree_skb(skb);
>>			continue;
>>		}
>> @@ -1567,7 +1567,10 @@ void mt7921_coredump_work(struct work_struct
>> *work)
>>
>>		dev_kfree_skb(skb);
>>	}
>> -	dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
>> -		      GFP_KERNEL);
>> +
>> +	if (dump)
>> +		dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
>> +			      GFP_KERNEL);
>> +
>>	mt7921_reset(&dev->mt76);
>>  }
>> --
>> 2.25.1
>>
>
