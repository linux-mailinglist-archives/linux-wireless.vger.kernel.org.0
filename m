Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3CD9995D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 18:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390085AbfHVQiI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 12:38:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35207 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730545AbfHVQiI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 12:38:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id g17so6056420otl.2;
        Thu, 22 Aug 2019 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WyFgxZ8d3nVnIxTzk3SzFsGbvL9UcVuLdickzGUtCvc=;
        b=pNUS4u9KAU74XE2Qs3LPZ4RiFIECie7gEvHoyhAi3cBOF+MVy4suhmGU4C0z5AAkcT
         bvztPO3bmuwye2BkHGcOh5IjyiZGmcM4r49PS5DFH0/rcmhAvHJPcXdpPfYZwTtySmhz
         Vg+KX6sC6kTeBakOMyNapL4qGGiyA+HDx2rfkz2B6DxezEtMbCZ7lxkfsgmn15zGlOYA
         gI6zjm4uXxe8JPjc9CgbmeiKIC/cR6wl5Vif+T5A6oV6PoaxeQCx/Ms1GdWmbXW65z4w
         gAFGT1cRxdRLFkeZrAYKoalPMoaAAZ9hYNJIl9+EFjKwKQ4s81WY6x0xaifaNG9fiEzQ
         upZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WyFgxZ8d3nVnIxTzk3SzFsGbvL9UcVuLdickzGUtCvc=;
        b=JfHaAGaGa2/rOcoXRKvGLRobc8VnXdKmrmcbYqlKMcUFsDledlPLug6pKqPIY6P9Fq
         Rul9Ae6yOQ0RIn753YLufodshrnmi2E71fkdOOpdjHylegE8PqDAuQro2WxauNR1BLyM
         wjmO/28eHVY10L87as9irSqHjyUBhIy5Tqwu1wsj33nDxkEMubtjDPb0ojUviF53dVvg
         Y06PB4esXM865snE6RntOtsMjONR+D5uimLHUPg/z7th2TCwTy80w2+LG0Lte5G+eoBA
         4bovLECkLiDeN+1QbN618rUJOy9gUDD2PMHHPhvCQDTqB6a5tMYxyj7CCYaXu9JDmcsI
         48Hg==
X-Gm-Message-State: APjAAAUIM8t2ByPZMBAv1T0+ZiGTh/zEh+pgWYEgoiyac70k4mLAqL6P
        tsebl0U4CJSBfJWl/sK1uPeph2hJ
X-Google-Smtp-Source: APXvYqxxwjM89i+xNPWWqX5cOg5pJRJSw/DjeIx7Arfijg2OObLp1lB4Zevpd6i6GHs/NyR8mIvOmA==
X-Received: by 2002:a9d:171:: with SMTP id 104mr415794otu.228.1566491887194;
        Thu, 22 Aug 2019 09:38:07 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id v24sm9484otj.78.2019.08.22.09.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:38:05 -0700 (PDT)
Subject: Re: [PATCH] bcma: fix incorrect update of BCMA_CORE_PCI_MDIO_DATA
To:     Colin Ian King <colin.king@canonical.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190822133524.6274-1-colin.king@canonical.com>
 <d3c16158-ef89-f5ee-2f67-4357c70e8fe9@lwfinger.net>
 <31258833-174f-080b-489e-85d3556bd1de@canonical.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <f1aa1f6f-d293-c2cd-d1fc-a6b10d49a1bb@lwfinger.net>
Date:   Thu, 22 Aug 2019 11:38:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <31258833-174f-080b-489e-85d3556bd1de@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/22/19 11:11 AM, Colin Ian King wrote:
> On 22/08/2019 17:03, Larry Finger wrote:
>> On 8/22/19 8:35 AM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> An earlier commit re-worked the setting of the bitmask and is now
>>> assigning v with some bit flags rather than bitwise or-ing them
>>> into v, consequently the earlier bit-settings of v are being lost.
>>> Fix this by replacing an assignment with the bitwise or instead.
>>>
>>> Addresses-Coverity: ("Unused value")
>>> Fixes: 2be25cac8402 ("bcma: add constants for PCI and use them")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>    drivers/bcma/driver_pci.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bcma/driver_pci.c b/drivers/bcma/driver_pci.c
>>> index f499a469e66d..d219ee947c07 100644
>>> --- a/drivers/bcma/driver_pci.c
>>> +++ b/drivers/bcma/driver_pci.c
>>> @@ -78,7 +78,7 @@ static u16 bcma_pcie_mdio_read(struct bcma_drv_pci
>>> *pc, u16 device, u8 address)
>>>            v |= (address << BCMA_CORE_PCI_MDIODATA_REGADDR_SHF_OLD);
>>>        }
>>>    -    v = BCMA_CORE_PCI_MDIODATA_START;
>>> +    v |= BCMA_CORE_PCI_MDIODATA_START;
>>>        v |= BCMA_CORE_PCI_MDIODATA_READ;
>>>        v |= BCMA_CORE_PCI_MDIODATA_TA;
>>
>> I'm not sure the "Fixes" attribute is correct.
>>
>> The changes for this section in commit 2be25cac8402 are
>>
>> -       v = (1 << 30); /* Start of Transaction */
>> -       v |= (1 << 28); /* Write Transaction */
>> -       v |= (1 << 17); /* Turnaround */
>> -       v |= (0x1F << 18);
>> +       v = BCMA_CORE_PCI_MDIODATA_START;
>> +       v |= BCMA_CORE_PCI_MDIODATA_WRITE;
>> +       v |= (BCMA_CORE_PCI_MDIODATA_DEV_ADDR <<
>> +             BCMA_CORE_PCI_MDIODATA_DEVADDR_SHF);
>> +       v |= (BCMA_CORE_PCI_MDIODATA_BLK_ADDR <<
>> +             BCMA_CORE_PCI_MDIODATA_REGADDR_SHF);
>> +       v |= BCMA_CORE_PCI_MDIODATA_TA;
>>
>> Because the code has done quite a bit of work on v just above this
>> section, I agree that this is likely an error, but that error happened
>> in an earlier commit. Thus 2be25cac8402 did not introduce the error,
>> merely copied it.
> 
> Ugh, this goes back further. I didn't spot that. I'm less confident of
> what the correct settings should be now.
> 
>>
>> Has this change been tested?
> 
> Afraid not, I don't have the H/W.

I admit that I looked at this only because I found it hard to believe that the 
collective wisdom of the list would have missed the usage of "=" instead of 
"|=". At least that test was passed. :)

Larry

