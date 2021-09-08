Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD6D4033DF
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 07:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347634AbhIHFiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 01:38:00 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:33412 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347579AbhIHFhi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 01:37:38 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 7307120D69
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 14:36:27 +0900 (JST)
Received: by mail-pg1-f200.google.com with SMTP id w5-20020a654105000000b002692534afceso983654pgp.8
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 22:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qJwO1NbnZbUZL6sq8r76996/TvLIJQa4xEunP1ATgxs=;
        b=Ia8qe9kR1oqyevVuR6azmfSQRShGfIjozoDzBmlRyRGsIka3OWpKjqJ+E4VTaLQ8AL
         GLC5uSORgESjL/Tz+A6JQQ4LuBf2QEoT7Rhx7O2TVOsV5gsIBX8BW/6HlVopEbwXmfMK
         DzQAzrUh6qnWIcGs3p5kJWxHDersN/hQKaOOptUqXQVCpmkb4gdRfTrk6+9gAbPgx+KI
         9WnZcziEpZArV0+FcSVdbmumMLryOx6FZPEQs0VUI4MObhwLsFm6/3SgwVHQaui6njnD
         2o14BmURqLjLD1DDh4L60JeBbIYTqi75oOvbc3/OVibB6RyH4u0Pf/4APUdHxZLyAWFR
         RAhA==
X-Gm-Message-State: AOAM533ujhRSHLwuotVDRvy8r9BlEn+m0z00WAqC0z36cMQiLrgsmfMk
        G8myLSXtH3phUUNti4X2rjqwmXfWQbBC3QHyydqXUU3LY6p/lHB8TPDf4h8w4G/wM5bp0XTSgtn
        CXFKtW0y6enDuHRrrdnkt1ywHLkzj
X-Received: by 2002:a17:90a:dc15:: with SMTP id i21mr2190165pjv.64.1631079386326;
        Tue, 07 Sep 2021 22:36:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1N5Da3IhedEiHxxLTOABOwEt4mpwnAV69iajVuygoGXQA63Q+o7kepvJk4OEakSLzE81Pnw==
X-Received: by 2002:a17:90a:dc15:: with SMTP id i21mr2190144pjv.64.1631079386025;
        Tue, 07 Sep 2021 22:36:26 -0700 (PDT)
Received: from pc-0115 (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id p2sm1113745pgd.84.2021.09.07.22.36.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:36:25 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1mNqG0-00EOgH-26; Wed, 08 Sep 2021 14:36:24 +0900
Date:   Wed, 8 Sep 2021 14:36:14 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Takashi Iwai <tiwai@suse.de>, Tsuchiya Yuto <kitakar@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Xinming Hu <huxinming820@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>
Subject: Re: mwifiex cmd timeout on one pci variant
Message-ID: <YThLznrMQ4EYUDEl@atmark-techno.com>
References: <YTg/f5mHQ6jjHDt6@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTg/f5mHQ6jjHDt6@atmark-techno.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(+cc Jonas Dreßler, sorry for two mails in a row for others)

Dominique MARTINET wrote on Wed, Sep 08, 2021 at 01:43:43PM +0900:
> I've got a board with an i.MX8MP chip, and three different marvell W8997
> M.2 modules

(I just noticed Jonas' patches "mwifiex: Work around firmware bugs on
88W8897 chip" on linux-wireless, but it doesn't seem to change anything
for me, so my problem isn't related to pci post or interrupt wake
apparently. Was worth a try...)

I'm surprised though he says the latest firmware is 15.68.19.p21, but I
can't find it anywhere -- linux-firmware only has up to 16.68.1.p179 and
I got 16.68.10.p16 from NXP dependencies, and now I'm searching a bit
harder i also found 16.92.10.p124 !? (note 16.92 instead of 16.68, also
NXP) but I have no idea where to find anything 'official' from marvell
as git.marvell.com/mwifiex-firmware.git disappeared.

Where could I find this version you speak of?


Thanks,

> -- one from laird which works fine, and two from azurewave
> which are labeled exactly the same AW-CM276MA 2276MA PCIE-UART except
> one works and not the other.
> The inscription on the chip itself are slightly different, one saying
> it's a W8997-M1216 from marvell (works) and the other having AW-CM276NF
> azurewave mark. The electronics around are also different.
> 
> I could say it's just a bad chip, but I've actually got two of each
> (samples) which act the same... And I've tried it in another device
> where it works with the same kernel/firmware, so there must be something
> wrong on the board as well as the wifi card works elsewhere.
> 
> 
> Anyway, if someone knows how to get around to debugging this, I'd
> appreciate a pointer! I can't see anything wrong with the tools I have
> here.
> If nothing else, I can't read /sys/class/devcoredump/devcd*/data that I
> saw Amitkumar Karwar request somewhere else, so just deciphering this
> would be great help.
> 
> 
> dmesg looks like this on failure:
> [  108.513028] mwifiex_pcie 0000:01:00.0: mwifiex_cmd_timeout_func: Timeout cmd id = 0x10, act = 0x1
> [  108.522388] mwifiex_pcie 0000:01:00.0: num_data_h2c_failure = 0
> [  108.528310] mwifiex_pcie 0000:01:00.0: num_cmd_h2c_failure = 0
> [  108.534143] mwifiex_pcie 0000:01:00.0: is_cmd_timedout = 1
> [  108.539631] mwifiex_pcie 0000:01:00.0: num_tx_timeout = 0
> [  108.545029] mwifiex_pcie 0000:01:00.0: last_cmd_index = 0
> [  108.550431] mwifiex_pcie 0000:01:00.0: last_cmd_id: 10 00 28 00 16 00 cd 00 1e 00
> [  108.557913] mwifiex_pcie 0000:01:00.0: last_cmd_act: 01 00 13 00 01 00 01 00 00 00
> [  108.565484] mwifiex_pcie 0000:01:00.0: last_cmd_resp_index = 4
> [  108.571318] mwifiex_pcie 0000:01:00.0: last_cmd_resp_id: df 80 28 80 16 80 cd 80 1e 80
> [  108.579237] mwifiex_pcie 0000:01:00.0: last_event_index = 2
> [  108.584810] mwifiex_pcie 0000:01:00.0: last_event: 00 00 0b 00 0a 00 00 00 00 00
> [  108.592206] mwifiex_pcie 0000:01:00.0: data_sent=0 cmd_sent=1
> [  108.597954] mwifiex_pcie 0000:01:00.0: ps_mode=1 ps_state=0
> [  108.604085] mwifiex_pcie 0000:01:00.0: ===mwifiex driverinfo dump start===
> [  108.613552] mwifiex_pcie 0000:01:00.0: info: MWIFIEX VERSION: mwifiex 1.0 (16.68.1.p179) 
> [  108.621748] mwifiex_pcie 0000:01:00.0: PCIE register dump start
> [  108.627676] mwifiex_pcie 0000:01:00.0: pcie scratch register:
> [  108.633441] mwifiex_pcie 0000:01:00.0: reg:0xcf0, value=0xfedcba00
>                reg:0xcf8, value=0x8260049
>                reg:0xcfc, value=0x1282820
> 
> [  108.648584] mwifiex_pcie 0000:01:00.0: PCIE register dump end
> [  108.654411] mwifiex_pcie 0000:01:00.0: ===mwifiex driverinfo dump end===
> [  108.661119] mwifiex_pcie 0000:01:00.0: == mwifiex firmware dump start ==
> [  110.560689] mwifiex_pcie 0000:01:00.0: cmd_wait_q terminated: -110
> [  148.127107] mwifiex_pcie 0000:01:00.0: == mwifiex firmware dump end ==
> [  148.134552] mwifiex_pcie 0000:01:00.0: == mwifiex dump information to /sys/class/devcoredump start
> [  148.143669] mwifiex_pcie 0000:01:00.0: == mwifiex dump information to /sys/class/devcoredump end
> [  148.152485] mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [  148.158915] mwifiex_pcie 0000:01:00.0: info: shutdown mwifiex...
> [  148.165829] mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [  148.443761] mwifiex_pcie 0000:01:00.0: info: dnld wifi firmware from 169340 bytes
> [  149.511193] mwifiex_pcie 0000:01:00.0: info: FW download over, size 632240 bytes
> [  150.163677] mwifiex_pcie 0000:01:00.0: WLAN FW is active
> [  150.231583] mwifiex_pcie 0000:01:00.0: info: MWIFIEX VERSION: mwifiex 1.0 (16.68.1.p179) 
> [  150.239814] mwifiex_pcie 0000:01:00.0: driver_version = mwifiex 1.0 (16.68.1.p179) 
> 
> I tried with two different firmwares, full dmesg and data.txt are here:
> hang on `ip link set mlan0 up`:
> https://codewreck.org/tmp/16.68.1.p179-data.txt
> https://codewreck.org/tmp/16.68.1.p179-dmesg
> 
> hang on `iw mlan0 scan` after successful link up:
> https://codewreck.org/tmp/16.68.1.p179-2-data.txt
> https://codewreck.org/tmp/16.68.1.p179-2-dmesg
> 
> other firmware (dmesg truncated to just timeout message):
> https://codewreck.org/tmp/16.68.10.p16-data.txt
> https://codewreck.org/tmp/16.68.10.p16-dmesg
> 
> 
> 
> Extra info:
>  - it doesn't always fail at the same place, so this looks like a
> tolerance problem? e.g. sometimes transmission works and sometimes
> a message is garbled?
> 
> - on the working azurewave module I can keep the card maxed at ~300mbps
> in or ~100mbps out without problem for a while with iperf so signals
> can't be that bad...? Or that could just be wishful thinking!
-- 
Dominique Martinet
