Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2F18444F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 11:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCMKFc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 06:05:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42266 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgCMKFb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 06:05:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id g16so6948549qtp.9
        for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2020 03:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wH89Ibe/vkawOmsrfwNRHbw0PbtQ6P4s7dsLFgWLgfQ=;
        b=SWLxTPE4DlWbhnKplRm1DQ5U8+UpFulrtVrz/bkf7XEgXgTYRcf8pqzs0LKHGHFd7Y
         TjRWtRDganKPEfXwECv9oy91D1+c0oq/hyqm9W2s2uLj3XuIZS9enYTMR8zb4a4cmOZ/
         11cHOhsoiHh8sRs0rd35AmI8dS5zUf8HIwzg2ZJzP7HM9o+w9OX8NUKHCmKA/Tz90uWN
         F0WfpNNkmpgXMZnnCAfk5mBo5YFQWzjm9sBb3uIoKslg1BhnmIgdIUeZ/cF7+U+SXZZt
         d+JqstSSc4WJkvq986l7dut8aZ/T3aF28A4q2PnP6MBs4QFnnc7ZA2ymPryMiQuLE3eP
         uVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=wH89Ibe/vkawOmsrfwNRHbw0PbtQ6P4s7dsLFgWLgfQ=;
        b=sgj72u+TD89Aj4kunZo48R/HX54R2r7rfvUQfPQrfZvFe98Irwt7PEIXCQWj3XfeGC
         Q/7eh8UCKnw+Y60i3aNLrDlouj0OglQ1lu50l/meNQtBiStnKQiUxnICiYUFt1lfojjr
         ML8Am/QzkSUlCWU65nGSS7t6u3wrNmCdZUld5B8sjNg+LGgt46F8GIFKDHhimrAxKLLl
         ppSx4VKoCUht0ZKxNTRHN86c8BcMNYA+dMcb+pGmiaO21NIc3XgksAd+2FL8BQvF+cMD
         ZQ8ShWmR+ouYdftBD442onweUUnN24P016Hw8ZDcHlW3RJbEN0uRBJCF3UPkvECzlY+S
         Jlkw==
X-Gm-Message-State: ANhLgQ1YZ7G20pkeSYR1TDhP8GUeGsA2Vq1NwCJZBRmDkGf1DiTRFjPW
        jU6ehJhc7Wjzu2rLEwC5PKgrzvGN1V9rtVKnupsloHBV
X-Google-Smtp-Source: ADFU+vuicUlBP4Ncv0tpBEx3e071e/E2tQGoLsyyLP6ip8btfn8WiT5JYJjFKCkZhVEKBztEuEu2a8lHtETlSh2YZTs=
X-Received: by 2002:aed:35b1:: with SMTP id c46mr11527972qte.74.1584093930698;
 Fri, 13 Mar 2020 03:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAFb4eQ=Y8XUGsE2c2tur4EPTC=81Ck3tRPF9Uf+6zBnA47j-Dw@mail.gmail.com>
In-Reply-To: <CAFb4eQ=Y8XUGsE2c2tur4EPTC=81Ck3tRPF9Uf+6zBnA47j-Dw@mail.gmail.com>
From:   Equipe Soft <equipe.soft.isere@gmail.com>
Date:   Fri, 13 Mar 2020 11:05:00 +0100
Message-ID: <CAFb4eQkFGM1rhrccExu6B5_5-3g60nDD_aRt3JDA2qT9FVbDig@mail.gmail.com>
Subject: Re: Is iwlwifi-9260-th-b0-jf-b0-46.ucode a debug firmware?
To:     linuxwifi@intel.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, do you have any news about the issue?
Best regards.
@team
Le ven. 6 mars 2020 =C3=A0 10:33, Equipe Soft <equipe.soft.isere@gmail.com>=
 a =C3=A9crit :
>
> Hello,
> we are using backport-iwlwifi core45 drivers and latest AC9260
> firmware binary blob:
> latest firmware available in Intel iwlwifi firmware fork:
> https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.gi=
t/commit/iwlwifi-9260-th-b0-jf-b0-46.ucode?id=3D4bebf45872a9818a17e20791185=
00030a8fa377a
> 2019-11-28 iwlwifi: update FWs to core47-142 release
>
> At runtime, we noticed these log traces:
> iwlwifi 0000:01:00.0: Found debug destination: EXTERNAL_DRAM
> iwlwifi 0000:01:00.0: Found debug configuration: 0
> iwlwifi 0000:01:00.0: Allocated 0x00400000 bytes for firmware monitor.
> So it seems that it is a debug firmware...
>
> Q0) can you please confirm that we can safely use this debug firmware
> in our product ?
> Q1) is debug mode deliberately enabled in newer firmware or is it an
> error (maybe like forgotten to disable it) ?
> Q2) is there an impact on performance with this debug firmware ? WiFi
> speed/throughput may be reduced or not ?
> Q3) moreover, can you please confirm whether or not WoWLAN (aka
> Wake-on-WLAN) is working with this debug firmware ?
> Q4) is WoWLAN working with any AC9260 firmware version ? and any
> iwlwifi driver version ?
>
> Thanks for your help,
>
> @team
