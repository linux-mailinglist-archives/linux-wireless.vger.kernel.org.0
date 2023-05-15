Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CA47027AF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 10:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbjEOI5x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 04:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEOI5v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 04:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F712C
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684141021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOmPAdOjTw0+fn4Xbj1cUOUc0rHyTV5xc4HudNudDw4=;
        b=FB8+DTywwiftvbjheyokAgXGzmRkW7SEqzBj5Y32Th8iXzKDlB5W5hW05pyzeF0sdgmarO
        OlYV/IZorjQ+NZRg3sYQOhyF8XpbTwHGPdbYq/ZHkIBhn6vcrVMuhyxJCmjYJXvIK6BPOV
        DVTgQTb/RkBOtDiU89UeZZ+oBKu3BIw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-N7t_qBvgPLOoqicd3om9Og-1; Mon, 15 May 2023 04:57:00 -0400
X-MC-Unique: N7t_qBvgPLOoqicd3om9Og-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-969f12b2818so952034766b.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 01:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684141019; x=1686733019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOmPAdOjTw0+fn4Xbj1cUOUc0rHyTV5xc4HudNudDw4=;
        b=V9/O/tIqKrV6gx8RvGesdxOdz4L5C1U3ObFwKgi/cJoaCP0HDAraQ7nNyzLE5D8AW0
         u3bzLxrczFXgnLPrElwKKwPa3dNx401rkCv9U72RSO3O7mKvhc6ROM7xoFADXxBkgk0a
         CsgEUUWig4/sGG0G1L51vwi2g/Sl+ejd7pCcOKcckV7uTMGuTPeuPCd5IP4IFrZdUTcN
         Q5q+EtCHj2jQ6i/HS2ZUOEZGGC/0GIylCT2rx5Wu8jEuQR6svLwhoTSO8zQdIJq+en3Q
         pATtFE4CSqjorDma2O5ws8/0hWKpyds17LHJAFn28rbsJiPGKytAMnu7Imry3ceM7U+i
         Hlpg==
X-Gm-Message-State: AC+VfDyXZcb//jBBrHuzjTUBSoPv1snBn0hh53Kf1iCC0/gQsCxJeZfl
        1fI32uOpQjx/MZ4h2zd8WxDvOScj6ouiq6DZBnGVzRnjRA8LGN+pT1h01665jaeW7yX+ErC8XpD
        I8tiQ+tBfus+AsxORsVXNJsNeH8s=
X-Received: by 2002:a17:907:629b:b0:94e:2db:533e with SMTP id nd27-20020a170907629b00b0094e02db533emr29845024ejc.49.1684141019376;
        Mon, 15 May 2023 01:56:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6huIguzGMh5b7eclldzzWFH1scw2tuhsvPlcXGbQtacAwciuSYhOs0prmIiuEpUaL8qGZ5Zw==
X-Received: by 2002:a17:907:629b:b0:94e:2db:533e with SMTP id nd27-20020a170907629b00b0094e02db533emr29845007ejc.49.1684141018980;
        Mon, 15 May 2023 01:56:58 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kn3-20020a1709079b0300b0096a27dbb5b2sm7152565ejc.209.2023.05.15.01.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 01:56:58 -0700 (PDT)
Message-ID: <f629341e-5920-8061-6120-cb954d22ffe9@redhat.com>
Date:   Mon, 15 May 2023 10:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Fwd: Freeze after resuming from hibernation (culprit is brcmfmac
 change?)
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Broadcom 80211 Devices <brcm80211-dev-list.pdl@broadcom.com>,
        SHA cyfmac Subsystem <SHA-cyfmac-dev-list@infineon.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc:     Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, julien.falque@gmail.com
References: <018f62d0-ee1d-9198-9c38-e45b10921e2e@gmail.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <018f62d0-ee1d-9198-9c38-e45b10921e2e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 5/15/23 04:21, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on bugzilla [1]. Quoting from it:
> 
>>  julien.falque@gmail.com 2023-05-14 09:55:38 UTC
>>
>> Since a Kernel update a few weeks ago, my laptop freezes when resuming from hibernation. It seems to handle the resume process normally but at the moment I should see Gnome login screen, I either get a black screen with just a white underscore instead, or nothing displayed at all (no backlight). I can't do anything at that point and I have to hard reboot.
>>
>> Steps to reproduce:
>> - hibernate
>> - resume
>> - wait until the resuming process should finish: black screen instead of e.g. Gnome's login screen
>>
>> journalctl gives nothing between the beginning of the resume and the crash, as if it never happened.
>>
>> I have a Dell XPS 15 (9550) with Arch Linux. The issue happens on linux (since v6.2.0 I think) but linux-lts (currently v6.1.28) is fine.
>>
>> A bisect on linux-git gave commit da6d9c8ecd00 as the cause of the problem.
> 
> See bugzilla for the full thread.
> 
> Julien: I asked you to also provide dmesg log as I don't know
> what exactly happened, but you mentioned the culprit was
> da6d9c8ecd00e2 ("wifi: brcmfmac: add firmware vendor info in driver info"),
> which implies that the crash involves your wifi device. From my experience
> though, GDM crashes are usually caused by xwayland.
> 
> Anyway, I'm adding this to regzbot:
> 
> #regzbot introduced: da6d9c8ecd00e2 https://bugzilla.kernel.org/show_bug.cgi?id=217442
> #regzbot title: brcmfmac firmware vendor info addition triggers GDM crash on resuming from hibernation

da6d9c8ecd00e2 is known to cause a NULL pointer deref on resume,
which is likely what is happening here. This is fixed by:

https://lore.kernel.org/regressions/20230510141856.46532-1-hdegoede@redhat.com/

This patch is ready for merging and is waiting for the wireless-maintainer
to merge it and send it to Linus.

Regards,

Hans


> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217442
> 

