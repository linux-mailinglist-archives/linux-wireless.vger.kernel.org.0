Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34141DE98
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 18:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349318AbhI3QP4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 12:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349136AbhI3QPz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 12:15:55 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A1C06176A;
        Thu, 30 Sep 2021 09:14:12 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HKywy72JLzQk1t;
        Thu, 30 Sep 2021 18:14:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Subject: Re: [PATCH 1/2] mwifiex: Use non-posted PCI register writes
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <CAHp75VdR4VC+Ojy9NjAtewAaPAgowq-3rffrr3uAdOeiN8gN-A@mail.gmail.com>
 <CA+ASDXNGR2=sQ+w1LkMiY_UCfaYgQ5tcu2pbBn46R2asv83sSQ@mail.gmail.com>
 <YS/rn8b0O3FPBbtm@google.com> <0ce93e7c-b041-d322-90cd-40ff5e0e8ef0@v0yd.nl>
 <CA+ASDXNMhrxX-nFrr6kBo0a0c-25+Ge2gBP2uTjE8UWJMeQO2A@mail.gmail.com>
 <bd64c142-93d0-c348-834c-34ed80c460f9@v0yd.nl>
 <e4cbf804-c374-79a3-53ac-8a0fbd8f75b8@v0yd.nl>
 <CAHp75Vd5iCLELx8s+Zvcj8ufd2bN6CK26soDMkZyC1CwMO2Qeg@mail.gmail.com>
 <20210923202231.t2zjoejpxrbbe5hc@pali>
 <db583b3c-6bfc-d765-a588-eb47c76cea31@v0yd.nl>
 <20210930154202.cvw3it3edv7pmqtb@pali>
From:   =?UTF-8?Q?Jonas_Dre=c3=9fler?= <verdre@v0yd.nl>
Message-ID: <6ba104fa-a659-c192-4dc0-291ca3413f99@v0yd.nl>
Date:   Thu, 30 Sep 2021 18:14:04 +0200
MIME-Version: 1.0
In-Reply-To: <20210930154202.cvw3it3edv7pmqtb@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD24B268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/30/21 5:42 PM, Pali Rohár wrote:
> On Thursday 30 September 2021 17:38:43 Jonas Dreßler wrote:
>> On 9/23/21 10:22 PM, Pali Rohár wrote:
>>> On Thursday 23 September 2021 22:41:30 Andy Shevchenko wrote:
>>>> On Thu, Sep 23, 2021 at 6:28 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>>>> On 9/22/21 2:50 PM, Jonas Dreßler wrote:
>>>>
>>>> ...
>>>>
>>>>> - Just calling mwifiex_write_reg() once and then blocking until the card
>>>>> wakes up using my delay-loop doesn't fix the issue, it's actually
>>>>> writing multiple times that fixes the issue
>>>>>
>>>>> These observations sound a lot like writes (and even reads) are actually
>>>>> being dropped, don't they?
>>>>
>>>> It sounds like you're writing into a not ready (fully powered on) device.
>>>
>>> This reminds me a discussion with Bjorn about CRS response returned
>>> after firmware crash / reset when device is not ready yet:
>>> https://lore.kernel.org/linux-pci/20210922164803.GA203171@bhelgaas/
>>>
>>> Could not be this similar issue? You could check it via reading
>>> PCI_VENDOR_ID register from config space. And if it is not valid value
>>> then card is not really ready yet.
>>>
>>>> To check this, try to put a busy loop for reading and check the value
>>>> till it gets 0.
>>>>
>>>> Something like
>>>>
>>>>     unsigned int count = 1000;
>>>>
>>>>     do {
>>>>       if (mwifiex_read_reg(...) == 0)
>>>>         break;
>>>>     } while (--count);
>>>>
>>>>
>>>> -- 
>>>> With Best Regards,
>>>> Andy Shevchenko
>>
>> I've tried both reading PCI_VENDOR_ID and the firmware status using a busy
>> loop now, but sadly none of them worked. It looks like the card always
>> replies with the correct values even though it sometimes won't wake up after
>> that.
>>
>> I do have one new observation though, although I've no clue what could be
>> happening here: When reading PCI_VENDOR_ID 1000 times to wakeup we can
>> "predict" the wakeup failure because exactly one (usually around the 20th)
>> of those 1000 reads will fail.
> 
> What does "fail" means here?

ioread32() returns all ones, that's interpreted as failure by 
mwifiex_read_reg().

> 
>> Maybe the firmware actually tries to wake up,
>> encounters an error somewhere in its wakeup routines and then goes down a
>> special failure code path. That code path keeps the cards CPU so busy that
>> at some point a PCI_VENDOR_ID request times out?
>>
>> Or well, maybe the card actually wakes up fine, but we don't receive the
>> interrupt on our end, so many possibilities...
