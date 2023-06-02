Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3871F903
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 05:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjFBDuJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 23:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFBDuH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 23:50:07 -0400
Received: from titan.fastwww.net (titan2.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906EF180
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 20:50:05 -0700 (PDT)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=OsYOKvr1T0RiWwtNUdLVPV1ESQj4sdHQ2IZ8mDnXN/nXXtYBgFkC2DFVZHtAD4nYmTkhtOlif7Dgf33HVzVNQtepq44LDxKNcOiCY8K0Wx3IMXutqpTwaSNz+NqjAb5r6VTJpqXMGbHgZSMosJjHtPT+OvgUIpPyT7cjCXmn+Wb2Em1kikVEFwx13TKm/5UqLjsOpD5DLtaYXZOLZ81ndyWtl31A0H4pK76IFnJaUbJNYKvc4ua2xOLp9wR5Z+tfJeQurjDIGou+XxDwt7yk7zrOr5glOgR+SnwGnouxhKsWmoofeUA3o/KSXX3p3tCI5ZuUHhIh0lVJ+SJ49isNjg==;
  h=Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
Received: (qmail 3810841 invoked by uid 108); 2 Jun 2023 03:50:03 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 2 Jun 2023 03:50:03 +0000
Received: from [192.168.68.80] ([76.75.112.137])
        by titan.fastwww.net with ESMTPSA
        id kTnVGetmeWQXJjoApSktOw
        (envelope-from <bjlockie@lockie.ca>); Fri, 02 Jun 2023 03:50:03 +0000
Message-ID: <f622ae86-eead-b22c-10d1-c098754c34db@lockie.ca>
Date:   Thu, 1 Jun 2023 23:50:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: RTL8822BE not working after suspend
To:     Utkarsh Verma <utkarsh.naveen@gmail.com>,
        linux-wireless@vger.kernel.org
References: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com>
 <CALKa4bQ6quTd6PoHCt9wQ-x6LznzmSz3Vbw1aOTc21USgdnctQ@mail.gmail.com>
Content-Language: en-US
From:   James <bjlockie@lockie.ca>
In-Reply-To: <CALKa4bQ6quTd6PoHCt9wQ-x6LznzmSz3Vbw1aOTc21USgdnctQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Try a more recent kernel.


On 2023-06-01 21:33, Utkarsh Verma wrote:
> Additionally, here is the dmesg log after resuming the laptop:
>
> Jun 02 06:25:06.698947 metia kernel: rtw_8822be 0000:04:00.0: failed
> to poll offset=0x5 mask=0x2 value=0x0
> Jun 02 06:25:06.699373 metia kernel: rtw_8822be 0000:04:00.0: mac
> power on failed
> Jun 02 06:25:06.699751 metia kernel: rtw_8822be 0000:04:00.0: failed
> to power on mac
> Jun 02 06:25:08.698770 metia kernel: rtw_8822be 0000:04:00.0: failed
> to poll offset=0x5 mask=0x2 value=0x0
> Jun 02 06:25:08.699414 metia kernel: rtw_8822be 0000:04:00.0: mac
> power on failed
> Jun 02 06:25:08.699800 metia kernel: rtw_8822be 0000:04:00.0: failed
> to power on mac
> Jun 02 06:25:20.688984 metia kernel: rtw_8822be 0000:04:00.0: failed
> to poll offset=0x5 mask=0x2 value=0x0
> Jun 02 06:25:20.689553 metia kernel: rtw_8822be 0000:04:00.0: mac
> power on failed
> Jun 02 06:25:20.689968 metia kernel: rtw_8822be 0000:04:00.0: failed
> to power on mac
> Jun 02 06:25:22.692089 metia kernel: rtw_8822be 0000:04:00.0: failed
> to poll offset=0x5 mask=0x2 value=0x0
> Jun 02 06:25:22.692584 metia kernel: rtw_8822be 0000:04:00.0: mac
> power on failed
> Jun 02 06:25:22.693016 metia kernel: rtw_8822be 0000:04:00.0: failed
> to power on mac
> Jun 02 06:25:24.958755 metia kernel: rtw_8822be 0000:04:00.0: failed
> to poll offset=0x5 mask=0x2 value=0x0
> Jun 02 06:25:24.959390 metia kernel: rtw_8822be 0000:04:00.0: mac
> power on failed
> Jun 02 06:25:24.959814 metia kernel: rtw_8822be 0000:04:00.0: failed
> to power on mac
>
> On Fri, Jun 2, 2023 at 6:59 AM Utkarsh Verma <utkarsh.naveen@gmail.com> wrote:
>> Hi everyone,
>>
>> This is my first bug report on the mailing list, so please let me know
>> if I mess anything up.
>>
>> I have an ASUS TUF FX505DT which has the RTL8822BE WiFi card. It works
>> fine normally without any issues. However, once I suspend my
>> laptop(closing the lid) for a considerable amount of time (> ~30
>> mins), the WiFi card doesn't work after resume and I have to reboot
>> every time.
>>
>> This bug really undermines the portability aspect of the laptop as I
>> can't simply close the lid and continue my work later. The WiFi simply
>> dies every time I suspend, and I have to reboot.
>>
>> It would be really helpful if I could get this to work in the meantime
>> as well with a workaround as I will be on the move soon.
>>
>> Lastly, thank you for all the work put into the drivers. They work
>> mostly fine without any issues. This suspend issue is the only thing I
>> can see, and I would be glad to help to get it fixed.
>>
>> My machine details:
>> OS: Arch Linux w/Linux 6.1.31-1-lts
>> Card: Realtek 8822BE WiFi
>> Laptop: ASUS TUF FX505DT
>>
>> Please let me know if you need further information.
>>
>> Regards,
>> Utkarsh Verma

