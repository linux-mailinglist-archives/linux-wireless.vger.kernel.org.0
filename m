Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964E710468E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 23:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfKTW16 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 17:27:58 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49953 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfKTW16 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 17:27:58 -0500
Received: from [192.168.2.98] (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 78F2D580078;
        Wed, 20 Nov 2019 23:27:55 +0100 (CET)
Subject: Re: [PATCH v6 2/5] mt76: mt76x02: split beaconing
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
References: <20191119154746.20821-1-markus.theil@tu-ilmenau.de>
 <20191119154746.20821-3-markus.theil@tu-ilmenau.de>
 <20191120092803.GA517@redhat.com>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Autocrypt: addr=markus.theil@tu-ilmenau.de; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Message-ID: <91b706b5-68b4-9679-a209-872f326de937@tu-ilmenau.de>
Date:   Wed, 20 Nov 2019 23:27:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120092803.GA517@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/20/19 10:28 AM, Stanislaw Gruszka wrote:
> On Tue, Nov 19, 2019 at 04:47:43PM +0100, Markus Theil wrote:
>> Sending beacons to the hardware always happens in batches. In order to
>> speed up beacon processing on usb devices, this patch splits out common
>> code an calls it only once (mt76x02_mac_set_beacon_prepare,
>> mt76x02_mac_set_beacon_finish). Making this split breaks beacon
>> enabling/disabling per vif. This is fixed by adding a call to set the
>> bypass mask, if beaconing should be disabled for a vif. Otherwise the
>> beacon is send after the next beacon interval.
>>
>> The code is also adapted for the mmio part of the driver, but should not
>> have any performance implication there.
>>
>> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
>> ---
>>  .../wireless/mediatek/mt76/mt76x02_beacon.c   | 44 +++++++------------
>>  .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  1 +
>>  .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  5 +++
>>  .../wireless/mediatek/mt76/mt76x02_usb_core.c |  5 +++
>>  4 files changed, 26 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
>> index 403866496640..09013adae854 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
>> @@ -47,10 +47,6 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 bcn_idx,
>>  	int beacon_len = dev->beacon_ops->slot_size;
>>  	int beacon_addr = MT_BEACON_BASE + (beacon_len * bcn_idx);
>>  	int ret = 0;
>> -	int i;
>> -
>> -	/* Prevent corrupt transmissions during update */
>> -	mt76_set(dev, MT_BCN_BYPASS_MASK, BIT(bcn_idx));
>>  
>>  	if (skb) {
>>  		ret = mt76x02_write_beacon(dev, beacon_addr, skb);
>> @@ -60,41 +56,30 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 bcn_idx,
>>  		dev->beacon_data_mask &= ~BIT(bcn_idx);
>>  	}
>>  
>> -	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
>> -
>>  	return ret;
>>  }
>>  
>> -int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
>> -			   struct sk_buff *skb)
>> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev)
>>  {
>> -	bool force_update = false;
>> -	int bcn_idx = 0;
>>  	int i;
>> +	int bcn_idx = 0;
>>  
>> -	for (i = 0; i < ARRAY_SIZE(dev->beacons); i++) {
>> -		if (vif_idx == i) {
>> -			force_update = !!dev->beacons[i] ^ !!skb;
>> -			dev_kfree_skb(dev->beacons[i]);
>> -			dev->beacons[i] = skb;
>> -			__mt76x02_mac_set_beacon(dev, bcn_idx, skb);
>> -		} else if (force_update && dev->beacons[i]) {
>> -			__mt76x02_mac_set_beacon(dev, bcn_idx,
>> -						 dev->beacons[i]);
>> -		}
>> -
>> +	for (i = 0; i < hweight8(dev->mt76.beacon_mask); ++i)
>>  		bcn_idx += !!dev->beacons[i];
> This looks wrong since we do not calculate all beacons, only 
> up to hweight8(dev->mt76.beacon_mask).
>
> But since we need to calculate number of all beacons we can just
> use hweight8(dev->mt76.beacon_mask) directly.

You're right that I made a mistake here. Using
hweight8(dev->mt76.beacon_mask) would be wrong
for usb devices, which may setup buffered broadcast or multicast frames
as additional beacons.
My updated patch therefore uses hweight8(dev->mt76.beacon_data_mask)
directly.

>> -	}
>> -
>> -	for (i = bcn_idx; i < ARRAY_SIZE(dev->beacons); i++) {
>> -		if (!(dev->beacon_data_mask & BIT(i)))
>> -			break;
>> -
>> -		__mt76x02_mac_set_beacon(dev, i, NULL);
>> -	}
>>  
>>  	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
>>  		       bcn_idx - 1);
>> +
>> +	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
> I'm not sure if this is correct for multi bss.
>
> In MT7620 manual BCM_BAYPASS_MASK is described as below:
>
> "
> Directly bypasses the Tx Beacon frame with the  specified 
> Beacon number. Bit0=Nth Beacon, bit1=(N- 1)th Beacon,... etc.
> N is the number of  Beacons defined in the  MULTI_BCN_NUM field in the 
> MAC_BSSID_DW1(offset: 0x1014) register.
> 0: Disable
> 1: Enable
> "
>
> Assuming manual is correct (it could be wrong) bypass mask should be
> calculated differently.
>
> Stanislaw
>
I tested the updated code with my usb nic and an mbss with 2 ap vifs.
Both beacons were transmitted. Maybe the manual is wrong in this place.

Markus  

