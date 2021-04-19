Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41290364921
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbhDSRjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 13:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhDSRi7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 13:38:59 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5312CC06174A
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 10:38:28 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v6so8417489oiv.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4NiwLZPvVYLvCZUZzWQow0TWWxAr7l52dYRb/hfIfhQ=;
        b=aldVZ+iq2iBRNL8Dop54Q9fZ+15BrVi8iu+q4QmFAnoE1hWQSzJl2wzsZkoKXw9h+5
         FQ3x5Ytz3HAhs1EUU/PInugD5x3WF4GfCGrHNB7kARkD1pWJNGPEaPuHWJSwU8GyoKmn
         lYpipkWu3wJFITH/ieSijBdMZJecJ5ec8sNEFVjXdF09Vw6Yu6SxuxAeVJk5I7it+d7r
         bElU9/7ZxSVjIWqJkyL7gbTlv7d8opX+j+indcNXsX4A5po+mmH37iKEaB6hvPUMv6mR
         JBtNRwIN+eA6u7LMy30UrP5/cgMHwi+/6KaKxVOgFYZJfvpnF/VeaZslFMHg+3Q2pHav
         lkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4NiwLZPvVYLvCZUZzWQow0TWWxAr7l52dYRb/hfIfhQ=;
        b=fpgOXbZN57yiMIjdUUbPFD/NR4FY9kj0MC1bNkvfGZgHH8rgyiSEscY/8ldeeWCAgv
         YluxqGSUCeQgo6pogiXf20+Kug37LBeaGccg74rdeWT4bY6jTqqYeL9657hDe82/Dyfn
         xVGmUSk+jzS/ec2/sqgQdB3S26R0Gh5qjn1PLJkUsJ+iugfz22nQj4E1PoUrf/dlM+N4
         3y2gUJiZyj+3fJlr8IB3tzgJ2N4cdfPQc5FRmvE7T/ku+Hm3X6NhwFEgxmLZnaFagO/h
         xuGRoxlk3VoTINoNdrJF2nfT5I/+X/Vx+6G/Y9mqxcEpi481NzupE9bUj2JwvSUpLMuG
         63jA==
X-Gm-Message-State: AOAM530p/lWh8aPGeQuUialih76nDRKbtvv1R3NONMLn4OZTZEdTg3mW
        C3ly8EQGfLB+rK3bqMtZepM2peAfDB8=
X-Google-Smtp-Source: ABdhPJwwr5vWfwOxvHbrzWLunzz1u5v4kspxXdj7EYoSYfpx/Mh1R6BKyBAVuDq6BnrcGA3DmNPpIw==
X-Received: by 2002:a54:4184:: with SMTP id 4mr159983oiy.72.1618853907436;
        Mon, 19 Apr 2021 10:38:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id o6sm1247538ote.14.2021.04.19.10.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 10:38:26 -0700 (PDT)
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
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <8fd98fb4-f289-65a7-964f-4f29cfad50a6@lwfinger.net>
Date:   Mon, 19 Apr 2021 12:38:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <9001d5aa093c4dc08cf0aba62056df4c@sicoop.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/19/21 4:56 AM, michaltoma wrote:
> 
>  >*De :*Larry Finger <larry.finger@gmail.com> de la part de Larry Finger 
> <Larry.Finger@lwfinger.net>
>  >*Envoyé :*jeudi 15 avril 2021 19:57
>  >*À :*michaltoma; linux-wireless@vger.kernel.org
>  >*Objet :*Re: [Bug report] - RTL8821CE 802.11ac PCIe Wireless Network Adapter - 
> Not handled properly by the rtw_8821ce dirver on Kernel 5.11.11
>  >
>> > On 4/15/21 5:09 AM, michaltoma wrote:
>> > Hello Larry,
>> > 
>> > 
>> > Here is the full dmesg:
>> > 
>> > https://pastebin.com/ZUXQeKAt <https://pastebin.com/ZUXQeKAt> 
> <https://pastebin.com/ZUXQeKAt <https://pastebin.com/ZUXQeKAt>>
>> 
>> On this list, please do not top post.
>> 
>> Thanks for the upload. Those 80 BIOS Errors do not lend much confidence in the 
>> quality of your BIOS! Have you checked for updates?
>> 
>> Have you tried when setting the options disable_msi=y and disable_aspm=y for 
>> module rtw88_pci if you use the kernel driver, or module rtw_pci if you use my 
>> GitHub repo. That fixes a lot of strange errors.
>> 
>> Larry
> 
> Hello Larry,
> 
> I tried to update the BIOS (without success so far as Lenovo doesn't provide 
> anything else than a windows 32 bit exe file).
> But this led me to boot a windows 10 on my laptop. Surprisingly this somehow 
> "unlocked" the Wifi.
> Seems the issue is somehow related to the chip deep sleep mode (I remember 
> reading something about this a while back), from which the driver is unable to 
> wake it up but the windows driver manages to do so.
> Not sure if this might help in diagnosing the problem but just reporting back.

If you boot Windows and Linux, it is absolutely imperative that you disable 
"quick boot" in Windows. That mode sometimes leaves devices disables for other 
OS's. I think this is what happened here.

Larry

