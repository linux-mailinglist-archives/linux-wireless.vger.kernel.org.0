Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0886F7203DC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 15:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjFBN72 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 09:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjFBN71 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 09:59:27 -0400
Received: from titan.fastwww.net (titan2.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1313E
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 06:59:25 -0700 (PDT)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=h0OJyr84RkBBKyeUhdpyT7jINg6GlzTpxKgqQACi3Qsca4qyNsB5+EL1iSJXlLPQ1REICaG9NFjvnWlONY3/lhWLrZQLj4TI2MgVpscUDSm72uu5EIgnOtY89xlAjLDGRs7OEUN6/zBFhTLTaJSDMkRwdjQBinu2Wl+Q1wxtGYIi1YIngcHWpicbQsGc6FRrXqQbYROEPkTsc9NEQrvnROYHgObnMFfy2C9vEk207fQXR75B1bAHQSpde+rc7XcqZGeIZg34nkK+NwaBo4K4dpb0po02iMjidApThnXFYm0dPjfH/oAKTb1Hu4uaA2e05DTIoyrry3WL/YCugdNm7Q==;
  h=Received:Received:Received:Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Correlation-ID;
Received: (qmail 297667 invoked by uid 108); 2 Jun 2023 13:59:23 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 2 Jun 2023 13:59:23 +0000
Received: from dummy.faircode.eu ([76.75.112.137])
        by titan.fastwww.net with ESMTPSA
        id qpigKLv1eWTAigQApSktOw
        (envelope-from <bjlockie@lockie.ca>); Fri, 02 Jun 2023 13:59:23 +0000
Date:   Fri, 2 Jun 2023 09:59:21 -0400 (EDT)
From:   James <bjlockie@lockie.ca>
To:     Utkarsh Verma <utkarsh.naveen@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <d443a746-106f-4626-85a8-deefe318b46a@lockie.ca>
In-Reply-To: <CALKa4bRr8z7FowCtZ-rSR0XMNEyoRbYsDu+Mswc-gs+s9Z0U=w@mail.gmail.com>
References: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com> <CALKa4bQ6quTd6PoHCt9wQ-x6LznzmSz3Vbw1aOTc21USgdnctQ@mail.gmail.com> <f622ae86-eead-b22c-10d1-c098754c34db@lockie.ca> <CALKa4bRr8z7FowCtZ-rSR0XMNEyoRbYsDu+Mswc-gs+s9Z0U=w@mail.gmail.com>
Subject: Re: RTL8822BE not working after suspend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Correlation-ID: <d443a746-106f-4626-85a8-deefe318b46a@lockie.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=216386

You could try https://github.com/lwfinger/rtw88

Jun. 2, 2023 00:19:28 Utkarsh Verma <utkarsh.naveen@gmail.com>:

> I had been using Linux v6.3.5 for a while and switched to v6.1.31-lts
> only yesterday, hoping it might work. The same issue happens on newer
> kernels like Linux v6.3.5 as well.
> 
> On Fri, Jun 2, 2023 at 9:20 AM James <bjlockie@lockie.ca> wrote:
>> 
>> Try a more recent kernel.
>> 
>> 
>> On 2023-06-01 21:33, Utkarsh Verma wrote:
>>> Additionally, here is the dmesg log after resuming the laptop:
>>> 
>>> Jun 02 06:25:06.698947 metia kernel: rtw_8822be 0000:04:00.0: failed
>>> to poll offset=0x5 mask=0x2 value=0x0
>>> Jun 02 06:25:06.699373 metia kernel: rtw_8822be 0000:04:00.0: mac
>>> power on failed
>>> Jun 02 06:25:06.699751 metia kernel: rtw_8822be 0000:04:00.0: failed
>>> to power on mac
>>> Jun 02 06:25:08.698770 metia kernel: rtw_8822be 0000:04:00.0: failed
>>> to poll offset=0x5 mask=0x2 value=0x0
>>> Jun 02 06:25:08.699414 metia kernel: rtw_8822be 0000:04:00.0: mac
>>> power on failed
>>> Jun 02 06:25:08.699800 metia kernel: rtw_8822be 0000:04:00.0: failed
>>> to power on mac
>>> Jun 02 06:25:20.688984 metia kernel: rtw_8822be 0000:04:00.0: failed
>>> to poll offset=0x5 mask=0x2 value=0x0
>>> Jun 02 06:25:20.689553 metia kernel: rtw_8822be 0000:04:00.0: mac
>>> power on failed
>>> Jun 02 06:25:20.689968 metia kernel: rtw_8822be 0000:04:00.0: failed
>>> to power on mac
>>> Jun 02 06:25:22.692089 metia kernel: rtw_8822be 0000:04:00.0: failed
>>> to poll offset=0x5 mask=0x2 value=0x0
>>> Jun 02 06:25:22.692584 metia kernel: rtw_8822be 0000:04:00.0: mac
>>> power on failed
>>> Jun 02 06:25:22.693016 metia kernel: rtw_8822be 0000:04:00.0: failed
>>> to power on mac
>>> Jun 02 06:25:24.958755 metia kernel: rtw_8822be 0000:04:00.0: failed
>>> to poll offset=0x5 mask=0x2 value=0x0
>>> Jun 02 06:25:24.959390 metia kernel: rtw_8822be 0000:04:00.0: mac
>>> power on failed
>>> Jun 02 06:25:24.959814 metia kernel: rtw_8822be 0000:04:00.0: failed
>>> to power on mac
>>> 
>>> On Fri, Jun 2, 2023 at 6:59 AM Utkarsh Verma <utkarsh.naveen@gmail.com> wrote:
>>>> Hi everyone,
>>>> 
>>>> This is my first bug report on the mailing list, so please let me know
>>>> if I mess anything up.
>>>> 
>>>> I have an ASUS TUF FX505DT which has the RTL8822BE WiFi card. It works
>>>> fine normally without any issues. However, once I suspend my
>>>> laptop(closing the lid) for a considerable amount of time (> ~30
>>>> mins), the WiFi card doesn't work after resume and I have to reboot
>>>> every time.
>>>> 
>>>> This bug really undermines the portability aspect of the laptop as I
>>>> can't simply close the lid and continue my work later. The WiFi simply
>>>> dies every time I suspend, and I have to reboot.
>>>> 
>>>> It would be really helpful if I could get this to work in the meantime
>>>> as well with a workaround as I will be on the move soon.
>>>> 
>>>> Lastly, thank you for all the work put into the drivers. They work
>>>> mostly fine without any issues. This suspend issue is the only thing I
>>>> can see, and I would be glad to help to get it fixed.
>>>> 
>>>> My machine details:
>>>> OS: Arch Linux w/Linux 6.1.31-1-lts
>>>> Card: Realtek 8822BE WiFi
>>>> Laptop: ASUS TUF FX505DT
>>>> 
>>>> Please let me know if you need further information.
>>>> 
>>>> Regards,
>>>> Utkarsh Verma
>> 
