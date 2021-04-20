Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16CE364F9B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 02:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhDTApN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 20:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhDTApN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 20:45:13 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026EBC06174A
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 17:44:42 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v6so9533557oiv.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 17:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y54RADQAKI43+F0kjEjItfFUgFjZ9l8crER7HbuVKME=;
        b=Zvshwxk2NogsO98MdHezysI6F8M46p55xwsDByciFJEauSvphivDRRJIt1vWzvfhmv
         c5Jq6corBFrZ3JV88c6VO93VfvU9XSHRTHgnBlPyzv3Ebn4WbDTD/s96PqD4hS7WmS7D
         vGBJ+i2yzxx4f3AJZc4ekIjnWi6f+7H/WfZ+pIyuBIiXdNKQBQdRIDXkRbdcb6jlPp/w
         CUAGNvCN1j6QvpadxD2hdXdzHkO8qDJOc4SxuZEwDAZPIhTAsfN8+Lwrk0V/CfCRaHsM
         YwHZX+OROWBSSHr1RJ7O1y2SMGD4qSGY/1H1OnTFK2n4mw+fcbgRvlfzjikoEpEuZrJ2
         etNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y54RADQAKI43+F0kjEjItfFUgFjZ9l8crER7HbuVKME=;
        b=IAupBwsBQEPFpMkCcs0PPr592robzlUk6dr+CnvjOWp2L1Da7N2T9HEIzoOfnx7dsX
         dxsLMXXrf1BxolUHcsc7FjBogEc3/dKRruw6o57H30A0mM07Q0F/snqBObcgfnXajLOt
         5oLY7fLh+eXM1/kFTdmTVRQzNwm4cy/HWgIB5RM3lknK1J5QEDbxmbYLF4RW2ukY+5ia
         F25/U/cfRfIh6l+94ERqv0IfPSvJEv49Gv3tDQES+CE77fE98uRfLaowXeiiDlog5ndh
         6Nz6qPcovIK/gS2myQ6uEOMNceF6AQAgAlYbeqRgs3V4tL6UGcOThI7UyaJanSAh44GJ
         Acyg==
X-Gm-Message-State: AOAM531IxEMkRoWU4chScrmY21cxUYj5ShJw7uPOQQCiiyvkjNvrszaF
        QVrwkZkYYTlAeqVsi0MQ9YrpnGHOxu0=
X-Google-Smtp-Source: ABdhPJw2lfXxnHGmCQ+eaaWlAQOC767lUoMqW2Z2njVawQwseYqE2kVeseF65Lx8kirGirYoiq2TKA==
X-Received: by 2002:aca:df44:: with SMTP id w65mr1208016oig.36.1618879482007;
        Mon, 19 Apr 2021 17:44:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 68sm3795435otc.54.2021.04.19.17.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 17:44:41 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [Bug report] - RTL8821CE 802.11ac PCIe Wireless Network Adapter -
 Not handled properly by the rtw_8821ce dirver on Kernel 5.11.11
To:     michaltoma <michaltoma@sicoop.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <2562248.KvEgbkE9EU@linux-9g0r.site>
 <c0afc587-b8f8-8bae-5589-92ebac536c9e@lwfinger.net>
 <fdab8de052c14b0ea1ed746bed9fcb8b@sicoop.com>
 <50708085-c669-a8c1-62ad-60a66da4ad9d@lwfinger.net>
 <9001d5aa093c4dc08cf0aba62056df4c@sicoop.com>
 <8fd98fb4-f289-65a7-964f-4f29cfad50a6@lwfinger.net>
 <0562d6c8e7fb4a1797d82294fa9af59e@sicoop.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <7580c121-e486-9283-b1e7-50c3a3c0433f@lwfinger.net>
Date:   Mon, 19 Apr 2021 19:44:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <0562d6c8e7fb4a1797d82294fa9af59e@sicoop.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/19/21 2:50 PM, michaltoma wrote:
> 
> *> De :* Larry Finger <larry.finger@gmail.com> de la part de Larry Finger 
> <Larry.Finger@lwfinger.net>
> *> Envoyé :* lundi 19 avril 2021 19:38
> *> À :* michaltoma; linux-wireless@vger.kernel.org
> *> Objet :* Re: [Bug report] - RTL8821CE 802.11ac PCIe Wireless Network Adapter 
> - Not handled properly by the rtw_8821ce dirver on Kernel 5.11.11
>  >
>  > On 4/19/21 4:56 AM, michaltoma wrote:
>  > >
>  > >  >*De :*Larry Finger <larry.finger@gmail.com> de la part de Larry Finger
>  > > <Larry.Finger@lwfinger.net>
>  > >  >*Envoyé :*jeudi 15 avril 2021 19:57
>  > >  >*À :*michaltoma; linux-wireless@vger.kernel.org
>  > >  >*Objet :*Re: [Bug report] - RTL8821CE 802.11ac PCIe Wireless Network 
> Adapter -
>  > > Not handled properly by the rtw_8821ce dirver on Kernel 5.11.11
>  > >  >
>  > >> > On 4/15/21 5:09 AM, michaltoma wrote:
>  > >> > Hello Larry,
>  > >> >
>  > >> >
>  > >> > Here is the full dmesg:
>  > >> >
>  > >> > https://pastebin.com/ZUXQeKAt <https://pastebin.com/ZUXQeKAt> 
> <https://pastebin.com/ZUXQeKAt <https://pastebin.com/ZUXQeKAt>>
>  > > <https://pastebin.com/ZUXQeKAt <https://pastebin.com/ZUXQeKAt 
> <https://pastebin.com/ZUXQeKAt>>>
>  > >>
>  > >> On this list, please do not top post.
>  > >>
>  > >> Thanks for the upload. Those 80 BIOS Errors do not lend much confidence in 
> the
>  >>> quality of your BIOS! Have you checked for updates?
>  >>>
>  >>> Have you tried when setting the options disable_msi=y and disable_aspm=y for
>  >>> module rtw88_pci if you use the kernel driver, or module rtw_pci if you use my
>  >>> GitHub repo. That fixes a lot of strange errors.
>  >>>
>  >>> Larry
>  >>
>  >> Hello Larry,
>  >>
>  >> I tried to update the BIOS (without success so far as Lenovo doesn't provide
>  >> anything else than a windows 32 bit exe file).
>  >> But this led me to boot a windows 10 on my laptop. Surprisingly this somehow
>  >> "unlocked" the Wifi.
>  >> Seems the issue is somehow related to the chip deep sleep mode (I remember
>  >> reading something about this a while back), from which the driver is unable to
>  >> wake it up but the windows driver manages to do so.
>  >> Not sure if this might help in diagnosing the problem but just reporting back.
>  >
>  > If you boot Windows and Linux, it is absolutely imperative that you disable
>  > "quick boot" in Windows. That mode sometimes leaves devices disables for other
>  > OS's. I think this is what happened here.
>  >
>  > Larry
> 
> Unfortunately no. I'm only booting Linux since day 0 of the laptop. This was 
> only required to try to flash the bios so I installed a copy of windows on an 
> external drive. __

Someone (the Factory) may have had Windows on it and did a quick-boot shutdown. 
I do not know any other way the iface could have been left in the wrong state.

Larry

