Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C523B10551A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 16:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKUPLb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 10:11:31 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:53343 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKUPLb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 10:11:31 -0500
Received: from [141.24.212.108] (thunderstorm.prakinf.tu-ilmenau.de [141.24.212.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id BFC8158006E;
        Thu, 21 Nov 2019 16:11:28 +0100 (CET)
Subject: Re: [PATCH v6 2/5] mt76: mt76x02: split beaconing
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
References: <20191119154746.20821-1-markus.theil@tu-ilmenau.de>
 <20191119154746.20821-3-markus.theil@tu-ilmenau.de>
 <20191120092803.GA517@redhat.com>
 <91b706b5-68b4-9679-a209-872f326de937@tu-ilmenau.de>
 <20191121125842.GB13833@redhat.com>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Openpgp: preference=signencrypt
Autocrypt: addr=markus.theil@tu-ilmenau.de; prefer-encrypt=mutual; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Organization: TU Ilmenau
Message-ID: <2ddc33ca-b840-fe87-5881-0672076025cf@tu-ilmenau.de>
Date:   Thu, 21 Nov 2019 16:11:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121125842.GB13833@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21.11.19 13:58, Stanislaw Gruszka wrote:
> On Wed, Nov 20, 2019 at 11:27:55PM +0100, Markus Theil wrote:
>>>> -	}
>>>> -
>>>> -	for (i = bcn_idx; i < ARRAY_SIZE(dev->beacons); i++) {
>>>> -		if (!(dev->beacon_data_mask & BIT(i)))
>>>> -			break;
>>>> -
>>>> -		__mt76x02_mac_set_beacon(dev, i, NULL);
>>>> -	}
>>>>  
>>>>  	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
>>>>  		       bcn_idx - 1);
>>>> +
>>>> +	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
>>> I'm not sure if this is correct for multi bss.
>>>
>>> In MT7620 manual BCM_BAYPASS_MASK is described as below:
>>>
>>> "
>>> Directly bypasses the Tx Beacon frame with the  specified 
>>> Beacon number. Bit0=Nth Beacon, bit1=(N- 1)th Beacon,... etc.
>>> N is the number of  Beacons defined in the  MULTI_BCN_NUM field in the 
>>> MAC_BSSID_DW1(offset: 0x1014) register.
>>> 0: Disable
>>> 1: Enable
>>> "
>>>
>>> Assuming manual is correct (it could be wrong) bypass mask should be
>>> calculated differently.
>>>
>>> Stanislaw
>>>
>> I tested the updated code with my usb nic and an mbss with 2 ap vifs.
>> Both beacons were transmitted. Maybe the manual is wrong in this place.
> If MAC_BSSID_DW1_MBEACON_N is set to 1 (2 beacons) according to manual
> bit0 is for second beacon slot and bit1 is for first beacon slot.
> Those bits are both marked at once, so no problem will happen.
>
> Problem may happen when you remove first vif/beacon. Then you will
> have bit1 marked in ->beacon_data_mask . But bit0 will be expect
> in BCM_BAYPASS_MASK by hardware (when MAC_BSSID_DW1_MBEACON_N=0)
>
> This scenarios can be extended to more vifs. So if you no longer 
> use bcn_idx and use vif_idx directly to point beacon slot/address.
> (ie. before for vif_idx 0,4,6, bcn_idx were 0,1,2 now there
> will be 0,4,6). You need to specify 7 (8 beacons) in
> MT_MAC_BSSID_DW1_MBEACON_N, and set bypass mask accordingly.
> For example:
>
> 	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N, 7);
> 	mask = 0;
> 	for (i = 0; i < 8; i++)
> 		if (dev->beacons[i])
> 			mask |= BIT(7 - i);
>
> 	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~mask);
>
> But again, this have to be tested. Ideally on mmio hardware which
> support more bssid's or on usb hardware with temporally increased
> num of bss limitation.
>
> Stanislaw
>
I'm currently fixing this. My next version will include the following for this aspect:
- clear beacon_data_mask before each round of setting beacons
- use ffz(dev->beacon_data_mask) to find next position and put next beacon in the corresponding slot
- as usb and mmio always copy the beacon, free_skb directly afterwards and drop the beacons array (the current code could leak memory for beacons in this array)

- permanently set the number of additional beacons to 7: mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N, 7)
- updating the beacon bypass mask then becomes: mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~bitrev8(dev->beacon_data_mask))

When I've tested this, I'll send an updated version.

Markus


