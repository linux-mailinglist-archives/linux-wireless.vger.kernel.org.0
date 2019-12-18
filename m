Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5913124A7A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfLRO5c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:57:32 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51108 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfLRO5c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:57:32 -0500
Received: from [192.168.2.97] (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 39359580075;
        Wed, 18 Dec 2019 15:57:29 +0100 (CET)
Subject: Re: [PATCH v9 4/6] mt76: mt76x02: remove a copy call for usb speedup
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>
References: <20191126214704.27297-1-markus.theil@tu-ilmenau.de>
 <20191126214704.27297-5-markus.theil@tu-ilmenau.de>
 <20191217094019.GA2567@localhost.localdomain>
 <ed93b477-dc15-8af4-eadc-9ecc5c4509ec@tu-ilmenau.de>
 <20191218131753.GB13035@localhost.localdomain>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Autocrypt: addr=markus.theil@tu-ilmenau.de; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Message-ID: <582a2ea7-22b6-0af9-392f-c3b5374ad5b3@tu-ilmenau.de>
Date:   Wed, 18 Dec 2019 15:57:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218131753.GB13035@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/18/19 2:17 PM, Lorenzo Bianconi wrote:
>> On 12/17/19 10:40 AM, Lorenzo Bianconi wrote:
>>>> This patch removes a mt76_wr_copy call from the beacon path to hw.
>>>> The skb which is used in this place gets therefore build with txwi
>>>> inside its data. For mt76 usb drivers, this saves one synchronuous
>>>> copy call over usb, which lets the beacon work complete faster.
>>>>
>>>> In mmio case, there is not enough headroom to put the txwi into the
>>>> skb, it is therefore using an additional mt76_wr_copy, which is fast
>>>> over mmio. Thanks Stanislaw for pointing this out.
>>>>
>>>> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
>>>> ---
>>>>  .../wireless/mediatek/mt76/mt76x02_beacon.c   | 20 +++++++++++++++----
>>>>  1 file changed, 16 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
>>>> index 1c4bdf88f712..68a4f512319e 100644
>>>> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
>>>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
>>>> @@ -26,15 +26,27 @@ static int
>>>>  mt76x02_write_beacon(struct mt76x02_dev *dev, int offset, struct sk_buff *skb)
>>>>  {
>>>>  	int beacon_len = dev->beacon_ops->slot_size;
>>>> -	struct mt76x02_txwi txwi;
>>>>  
>>>>  	if (WARN_ON_ONCE(beacon_len < skb->len + sizeof(struct mt76x02_txwi)))
>>>>  		return -ENOSPC;
>>>>  
>>>> -	mt76x02_mac_write_txwi(dev, &txwi, skb, NULL, NULL, skb->len);
>>>> +	/* USB devices already reserve enough skb headroom for txwi's. This
>>>> +	 * helps to save slow copies over USB.
>>>> +	 */
>>>> +	if (mt76_is_usb(&dev->mt76)) {
>>>> +		struct mt76x02_txwi *txwi;
>>>> +
>>>> +		mt76_insert_hdr_pad(skb);
>>> Do we really need mt76_insert_hdr_pad? I think beacon header should be 4B
>>> aligned.
> mt76_insert_hdr_pad takes into account just 802.11 header length and it is 24
> or 28 for mgmt frames.
>
> Regards,
> Lorenzo

Ok, thanks. Then I drop the call.

Markus

>>> Regards,
>>> Lorenzo
>> I can leave it out of course, but I don't  know, if beacons from
>> mac80211 are always 4B aligned.
>>
>> Regards,
>> Markus
>>>> +		txwi = (struct mt76x02_txwi *)(skb->data - sizeof(*txwi));
>>>> +		mt76x02_mac_write_txwi(dev, txwi, skb, NULL, NULL, skb->len);
>>>> +		skb_push(skb, sizeof(*txwi));
>>>> +	} else {
>>>> +		struct mt76x02_txwi txwi;
>>>>  
>>>> -	mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
>>>> -	offset += sizeof(txwi);
>>>> +		mt76x02_mac_write_txwi(dev, &txwi, skb, NULL, NULL, skb->len);
>>>> +		mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
>>>> +		offset += sizeof(txwi);
>>>> +	}
>>>>  
>>>>  	mt76_wr_copy(dev, offset, skb->data, skb->len);
>>>>  	return 0;
>>>> -- 
>>>> 2.24.0
>>>>
