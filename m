Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEFCF916A3
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 14:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfHRMoC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 08:44:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33899 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfHRMoC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 08:44:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so5909394wrn.1
        for <linux-wireless@vger.kernel.org>; Sun, 18 Aug 2019 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMFKk1n9F0RltZTUuZxEGQUuLJ8Qu6vhKVRysw5bjnk=;
        b=BL9J2p2YxiLC+yxrDCDBNCpaiospQJ8ci9Hp2Hv2OnihgXE9UCF/h26f/yCE3lA1kW
         ObohkSVZBArxG3rI5ZxVFOfU7Uvl45SWYC1Cv+gNW0C0UlqufJFC5u3xHH/Bn4kr5GqU
         lSiolgv3pzkrEdOTM7TrRzTAtpV0vHf26u4O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMFKk1n9F0RltZTUuZxEGQUuLJ8Qu6vhKVRysw5bjnk=;
        b=tGtoXQFXT3ZLIFVxKMT6XgkjJonMBeHkgVGXjwm1bE8kYl39J3kPABu1fq1TNpdTz1
         GI5um5fMzK7AWGWXh4uvyxwedvUzHB/6RiZsqs1ji3xER5g9RdVxT8opzY9yW/9hb5TP
         fJf0qZWZUbOEWNSC0ytbRS7pYe3nSfl3uZlX8dbDtAhz332fMtyOrhp1LWnPtYxBQYDa
         UFa69dieaxrJnAoJIH29rC96R9Kl0VW/+Fm4iJiqhxzadd1oNSBAJLvtDg6hZDB4yQ/3
         g664Pxl6mA9d2JwKx1Q0bAkeoXTMXSdgtDf5w8ENm/wK111Y8HVrbYkzoODh9WRO15q4
         Iztg==
X-Gm-Message-State: APjAAAWMkrUICBo2PFdQR5txk8PxUGlpFtOWmkkdQGAAVgGfdi3N86gv
        mcitUZ08ejq86bs8r56kez9oMLo/QBJEk8QI5wLG7w==
X-Google-Smtp-Source: APXvYqy+zUjgw2x03zlenTbShENN2bqsYybRbLljEolpan5f5jMnZyZfeqPkywSR72xgBORHbXC30uZJeXTW9MJMubg=
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr20642258wrn.316.1566132239479;
 Sun, 18 Aug 2019 05:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190818104629.GA27360@amd> <CAOf5uwnUx3mtGGHFGqKB30qcb_AMhMEhHLp2pf-4pUdhi7KP7w@mail.gmail.com>
 <20190818114332.GA32205@amd>
In-Reply-To: <20190818114332.GA32205@amd>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sun, 18 Aug 2019 14:43:48 +0200
Message-ID: <CAOf5uwncAHQ-nfFzQhv=T+pyXJ+60_QNT4F11VJg+25GjFFkxQ@mail.gmail.com>
Subject: Re: wifi on Motorola Droid 4 in 5.3-rc2
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

On Sun, Aug 18, 2019 at 1:43 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Sun 2019-08-18 12:53:01, Michael Nazzareno Trimarchi wrote:
> > Hi
> >
> > On Sun, Aug 18, 2019 at 12:46 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Hi!
> > >
> > > First, I guess I should mention that this is first time I'm attempting
> > > to get wifi going on D4.
> > >
> > > I'm getting this:
> > >
> > > user@devuan:~/g/ofono$ sudo ifconfig wlan0 down
> > > user@devuan:~/g/ofono$ sudo ifconfig wlan0 up
> > > user@devuan:~/g/ofono$ sudo iwlist wlan0 scan
> > > wlan0     Interface doesn't support scanning.
> > >
> >
> > Try to use iw command. iwlist use an obsolete interface that you need
> > to activate in kernel for back compatibility with old command. Can be
> > your problem?
>
> Let me see ... CONFIG_CFG80211_WEXT was not set.
>
> Tried enabling it, and now I got. I remember getting it before,
> too... let me try few more boots, perhaps it is random.
>
> Best regards,
>                                                                 Pavel
>
>
>
> [   13.653778] panel-dsi-cm 58004000.encoder:display: using lookup
> tables for GPIO lookup
> [   13.661834] panel-dsi-cm 58004000.encoder:display: No GPIO consumer
> te found
> [   14.756622] ------------[ cut here ]------------
> [   14.761352] WARNING: CPU: 0 PID: 20 at
> /data/fast/l/k/drivers/net/wireless/ti/wlcore/sdio.c:86
> wl12xx_sdio_raw_read+0xa8/0x128
> [   14.772888] Modules linked in:
> [   14.776062] CPU: 0 PID: 20 Comm: kworker/0:1 Tainted: G        W
> 5.3.0-rc4-58571-gdbaece1 #85
> [   14.783630] Hardware name: Generic OMAP4 (Flattened Device Tree)
> [   14.791381] Workqueue: events request_firmware_work_func
> [   14.796813] [<c010f2b4>] (unwind_backtrace) from [<c010b528>]
> (show_stack+0x10/0x14)
> [   14.804595] [<c010b528>] (show_stack) from [<c08c1d68>]
> (dump_stack+0xa8/0xc8)
> [   14.811950] [<c08c1d68>] (dump_stack) from [<c012df4c>]
> (__warn+0xe8/0x114)
> [   14.816894] [<c012df4c>] (__warn) from [<c012dfb4>]
> (warn_slowpath_null+0x3c/0x48)
> [   14.826629] [<c012dfb4>] (warn_slowpath_null) from [<c0566674>]
> (wl12xx_sdio_raw_read+0xa8/0x128)
> [   14.835540] [<c0566674>] (wl12xx_sdio_raw_read) from [<c0567704>]
> (wl12xx_get_mac+0x134/0x260)
> [   14.844268] [<c0567704>] (wl12xx_get_mac) from [<c05530cc>]
> (wlcore_nvs_cb+0x270/0xb64)
> [   14.852355] [<c05530cc>] (wlcore_nvs_cb) from [<c04d7264>]
> (request_firmware_work_func+0x3c/0x64)
> [   14.861267] [<c04d7264>] (request_firmware_work_func) from
> [<c01455c0>] (process_one_work+0x140/0x348)
> [   14.870697] [<c01455c0>] (process_one_work) from [<c0145964>]
> (worker_thread+0x164/0x4b0)
> [   14.878906] [<c0145964>] (worker_thread) from [<c014a788>]
> (kthread+0x110/0x148)
> [   14.883636] [<c014a788>] (kthread) from [<c01010e8>]
> (ret_from_fork+0x14/0x2c)
> [   14.893615] Exception stack(0xeda0bfb0 to 0xeda0bff8)
> [   14.893615] bfa0:                                     00000000
> 00000000 00000000 00000000
> [   14.903625] bfc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [   14.913635] bfe0: 00000000 00000000 00000000 00000000 00000013
> 00000000
> [   14.922058] ---[ end trace b611e5d6e7d5aa92 ]---
> [   14.926788] wl1271_sdio mmc4:0001:2: sdio read failed (-110)
> [   14.932525] wlcore: ERROR couldn't get hw info

You have a timeout here. Can be that your reset sequence of the wifi
is not optimal because
is not responding?

Michael

>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
