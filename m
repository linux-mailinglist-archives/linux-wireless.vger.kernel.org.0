Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4884E9DFE5
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 09:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfH0H6c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 03:58:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54991 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfH0H63 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 03:58:29 -0400
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=[192.168.0.11])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i2WN1-0001L3-Bk; Tue, 27 Aug 2019 07:58:27 +0000
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190822133524.6274-1-colin.king@canonical.com>
 <d3c16158-ef89-f5ee-2f67-4357c70e8fe9@lwfinger.net>
 <31258833-174f-080b-489e-85d3556bd1de@canonical.com>
 <f1aa1f6f-d293-c2cd-d1fc-a6b10d49a1bb@lwfinger.net>
From:   Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] bcma: fix incorrect update of BCMA_CORE_PCI_MDIO_DATA
Message-ID: <a29bf743-f913-c129-8789-0091ec137491@canonical.com>
Date:   Tue, 27 Aug 2019 08:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f1aa1f6f-d293-c2cd-d1fc-a6b10d49a1bb@lwfinger.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22/08/2019 17:38, Larry Finger wrote:
> On 8/22/19 11:11 AM, Colin Ian King wrote:
>> On 22/08/2019 17:03, Larry Finger wrote:
>>> On 8/22/19 8:35 AM, Colin King wrote:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> An earlier commit re-worked the setting of the bitmask and is now
>>>> assigning v with some bit flags rather than bitwise or-ing them
>>>> into v, consequently the earlier bit-settings of v are being lost.
>>>> Fix this by replacing an assignment with the bitwise or instead.
>>>>
>>>> Addresses-Coverity: ("Unused value")
>>>> Fixes: 2be25cac8402 ("bcma: add constants for PCI and use them")
>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>> ---
>>>>    drivers/bcma/driver_pci.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bcma/driver_pci.c b/drivers/bcma/driver_pci.c
>>>> index f499a469e66d..d219ee947c07 100644
>>>> --- a/drivers/bcma/driver_pci.c
>>>> +++ b/drivers/bcma/driver_pci.c
>>>> @@ -78,7 +78,7 @@ static u16 bcma_pcie_mdio_read(struct bcma_drv_pci
>>>> *pc, u16 device, u8 address)
>>>>            v |= (address << BCMA_CORE_PCI_MDIODATA_REGADDR_SHF_OLD);
>>>>        }
>>>>    -    v = BCMA_CORE_PCI_MDIODATA_START;
>>>> +    v |= BCMA_CORE_PCI_MDIODATA_START;
>>>>        v |= BCMA_CORE_PCI_MDIODATA_READ;
>>>>        v |= BCMA_CORE_PCI_MDIODATA_TA;
>>>
>>> I'm not sure the "Fixes" attribute is correct.
>>>
>>> The changes for this section in commit 2be25cac8402 are
>>>
>>> -       v = (1 << 30); /* Start of Transaction */
>>> -       v |= (1 << 28); /* Write Transaction */
>>> -       v |= (1 << 17); /* Turnaround */
>>> -       v |= (0x1F << 18);
>>> +       v = BCMA_CORE_PCI_MDIODATA_START;
>>> +       v |= BCMA_CORE_PCI_MDIODATA_WRITE;
>>> +       v |= (BCMA_CORE_PCI_MDIODATA_DEV_ADDR <<
>>> +             BCMA_CORE_PCI_MDIODATA_DEVADDR_SHF);
>>> +       v |= (BCMA_CORE_PCI_MDIODATA_BLK_ADDR <<
>>> +             BCMA_CORE_PCI_MDIODATA_REGADDR_SHF);
>>> +       v |= BCMA_CORE_PCI_MDIODATA_TA;
>>>
>>> Because the code has done quite a bit of work on v just above this
>>> section, I agree that this is likely an error, but that error happened
>>> in an earlier commit. Thus 2be25cac8402 did not introduce the error,
>>> merely copied it.

I did a second look at Larry's comments above and realized the code he
is referring to is in bcma_pcie_mdio_set_phy which is OK

Instead, the code I'm fixing is in bcma_pcie_mdio_read, which was broken
by commit 2be25cac8402fab56bb51166f464d1b420bcf744

        if (pc->core->id.rev >= 10) {
                max_retries = 200;
                bcma_pcie_mdio_set_phy(pc, device);
+               v = (BCMA_CORE_PCI_MDIODATA_DEV_ADDR <<
+                    BCMA_CORE_PCI_MDIODATA_DEVADDR_SHF);
+               v |= (address << BCMA_CORE_PCI_MDIODATA_REGADDR_SHF);
+       } else {
+               v = (device << BCMA_CORE_PCI_MDIODATA_DEVADDR_SHF_OLD);
+               v |= (address << BCMA_CORE_PCI_MDIODATA_REGADDR_SHF_OLD);
        }

-       v = (1 << 30); /* Start of Transaction */
-       v |= (1 << 29); /* Read Transaction */
-       v |= (1 << 17); /* Turnaround */
-       if (pc->core->id.rev < 10)
-               v |= (u32)device << 22;
-       v |= (u32)address << 18;
-       pcicore_write32(pc, mdio_data, v);
+       v = BCMA_CORE_PCI_MDIODATA_START;
+       v |= BCMA_CORE_PCI_MDIODATA_READ;
+       v |= BCMA_CORE_PCI_MDIODATA_TA;
+
+       pcicore_write32(pc, BCMA_CORE_PCI_MDIO_DATA, v);


>>
>> Ugh, this goes back further. I didn't spot that. I'm less confident of
>> what the correct settings should be now.
>>
>>>
>>> Has this change been tested?
>>
>> Afraid not, I don't have the H/W.
> 
> I admit that I looked at this only because I found it hard to believe
> that the collective wisdom of the list would have missed the usage of
> "=" instead of "|=". At least that test was passed. :)

Maybe not after all :-)

> 
> Larry
> 

I'll send a V2 with the write fix, and the same fixes commit sha
