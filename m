Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9184548E08B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 23:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiAMWnn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 17:43:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39140 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232512AbiAMWnn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 17:43:43 -0500
X-UUID: ffa7af9da401431e8acef053ad6e06a4-20220114
X-UUID: ffa7af9da401431e8acef053ad6e06a4-20220114
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 69137826; Fri, 14 Jan 2022 06:43:41 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 14 Jan 2022 06:43:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 Jan
 2022 06:43:39 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Jan 2022 06:43:39 +0800
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
Subject: Re: [PATCH 2/3] mt76: sdio: honor the largest Tx buffer the hardware can support
Date:   Fri, 14 Jan 2022 06:43:38 +0800
Message-ID: <1642113818-9675-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <Yd/sYYP1XJ3J8RuR@lore-desk--annotate>
References: <Yd/sYYP1XJ3J8RuR@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

<snip>
>> @@ -299,6 +301,17 @@ int mt76s_hw_init(struct mt76_dev *dev, struct
>> sdio_func *func, int hw_ver)  }  EXPORT_SYMBOL_GPL(mt76s_hw_init);
>>
>> +u32 mt76s_get_xmit_buf_sz(struct mt76_dev *dev, u32 dev_max_len) {
>> +	struct sdio_func *func = dev->sdio.func;
>> +	u32 host_max_len = min_t(u32, func->card->host->max_req_size,
>> +				 func->cur_blksize *
>> +				 func->card->host->max_blk_count);
>> +
>> +	return min_t(u32, host_max_len, dev_max_len); }
>> +EXPORT_SYMBOL_GPL(mt76s_get_xmit_buf_sz);
>
>I think we can squash this patch with the previous one and move the code above in mt76s_init(). Agree?

these comments you have in the patchset all look fine to me, I will post v2 soon.

	Sean
>
>Regards,
>Lorenzo
>
>> +
>>  int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
>> {
>>	struct mt76_queue *q = &dev->q_rx[qid]; diff --git
>> a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
>> b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
>> index a04cd2444247..9fcf507e09bd 100644
>> --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
>> +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
>> @@ -254,7 +254,7 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
>>		}
>>
>>		pad = roundup(e->skb->len, 4) - e->skb->len;
>> -		if (len + e->skb->len + pad + 4 > MT76S_XMIT_BUF_SZ)
>> +		if (len + e->skb->len + pad + 4 > dev->sdio.xmit_buf_sz)
>>			break;
>>
>>		if (mt76s_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
>> --
>> 2.25.1
>>
>
