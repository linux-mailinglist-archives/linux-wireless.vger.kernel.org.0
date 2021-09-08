Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5CD4041E2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 01:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbhIHXtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 19:49:51 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:46604 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbhIHXtv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 19:49:51 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id E48C620D1A
        for <linux-wireless@vger.kernel.org>; Thu,  9 Sep 2021 08:48:40 +0900 (JST)
Received: by mail-pg1-f198.google.com with SMTP id z127-20020a633385000000b002618d24cfacso2756068pgz.16
        for <linux-wireless@vger.kernel.org>; Wed, 08 Sep 2021 16:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RIQXMwHH2j1GsdPMkx72oW0DUPEkY28+df2bBStXZ3g=;
        b=ovZD4As5DveIqKMp+WG/HfxzVjXvTDpLZ0lThcz+EImXvY+46CRQ5xRJ2eLkWv7MUy
         kihv+dsFLbjKGuGXyWbnOw+Bi/VISFIv6OThPs7WGk8KxrjV9wKbQVJ7mvdGbrcI26Mq
         /+XhomwizP4EtTGnFziHu0DBckpQsp9JR5ZAOb+KGu3kWCAPY02AMuLltcMVvn8vpeTD
         9UYlD7buy5khNzeuyVdF0qHRCgNjWz4AWDHD6iD10eilRDHpRbfyIkLlSHI5OHhDatfk
         SnDPDZowqNyLV1Bawshyckptz2gEb0EX4fymFFywOLRe5TkdjQQIDxKngItFe59XP95t
         QbQA==
X-Gm-Message-State: AOAM5330Ug/SUaxBv5B+EwJfnzoBelIlrnBb2T9g+hW5/+nb5QjfbH5H
        icskRW2sSwQqU4psWu524nnegTbrRnVnzsHkc3hu9XlxhP+o7GFmi2yEsT95CgKlhgMbnFqleBU
        VMkBNOGOLYAPuEOLzkee29s1Ldsft
X-Received: by 2002:a62:8fce:0:b0:3f0:ba71:d85d with SMTP id n197-20020a628fce000000b003f0ba71d85dmr256098pfd.2.1631144919964;
        Wed, 08 Sep 2021 16:48:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwhQ184OenlTWKdsPtQOzggJy97A85bxBM9BKGQ4pKVuo/RaRuZifnfkAIhelvlEeX96Tpdg==
X-Received: by 2002:a62:8fce:0:b0:3f0:ba71:d85d with SMTP id n197-20020a628fce000000b003f0ba71d85dmr256075pfd.2.1631144919627;
        Wed, 08 Sep 2021 16:48:39 -0700 (PDT)
Received: from pc-0115 (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id d18sm41190pge.65.2021.09.08.16.48.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Sep 2021 16:48:39 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1mO7Iy-00FEXh-Et; Thu, 09 Sep 2021 08:48:36 +0900
Date:   Thu, 9 Sep 2021 08:48:26 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Xinming Hu <huxinming820@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>
Subject: Re: mwifiex cmd timeout on one pci variant
Message-ID: <YTlLysbgRacDl0/0@atmark-techno.com>
References: <YTg/f5mHQ6jjHDt6@atmark-techno.com>
 <CA+ASDXPXL78rxJWjqvVZVAjb6ryYKbY=QP3EZ0N0kfhaFH9CeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+ASDXPXL78rxJWjqvVZVAjb6ryYKbY=QP3EZ0N0kfhaFH9CeA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris wrote on Wed, Sep 08, 2021 at 09:56:57AM -0700:
> On Tue, Sep 7, 2021 at 9:52 PM Dominique MARTINET
> <dominique.martinet@atmark-techno.com> wrote:
> > This is probably more a question for the maker.. But maybe someone will
> > know.
> 
> Last I knew, at least one of the CC'd is still employed by the owner
> of this IP (NXP now), but I don't know that much. But then, they
> haven't been giving out a lot of free support lately, AFAIK.

Thanks for the information.
I've also tried reaching out through our reseller before but it'll
likely take some time to tickle up, if it ever does...

> > Context:
> > I've got a board with an i.MX8MP chip, and three different marvell W8997
> > M.2 modules -- one from laird which works fine, and two from azurewave
> > which are labeled exactly the same AW-CM276MA 2276MA PCIE-UART except
> > one works and not the other.
> > The inscription on the chip itself are slightly different, one saying
> > it's a W8997-M1216 from marvell (works) and the other having AW-CM276NF
> > azurewave mark. The electronics around are also different.
> 
> FWIW, I've only ever worked with the PCIe-USB variant of this chip.
> And it had tons of bugs that resulted in "command timeouts" along the
> way, and it took a lot of co-working with Marvell to get the firmware
> fixed. I don't know their release model well enough to know whether
> the PCIe-UART variant will have all the same bugs (and bugfixes). But
> in case it helps, here's our firmware history:
> https://chromium.googlesource.com/chromiumos/third_party/linux-firmware/+log/HEAD/mrvl/pcieusb8997_combo_v4.bin
> *Most* of those should align pretty closely with what was published to
> linux-firmware.git, but it's not guaranteed, since Marvell didn't
> always follow our upstream-first guidelines there.

That indeed shows more updates for pcieusb than pcieuart..
The upstream repo https://github.com/NXP/mwifiex-firmware/ listed in
commit message also only seems to have ever updated pcieusb, so I guess
that's where the efforts have been poured.

Also made me try to force loading 'wrong' firmwares to see what happen
and pcie8997_wlan_v4.bin actually loads! But seems to have similar
problems. Others fail to start, but that's not really surprising.


> > I could say it's just a bad chip, but I've actually got two of each
> > (samples) which act the same... And I've tried it in another device
> > where it works with the same kernel/firmware, so there must be something
> > wrong on the board as well as the wifi card works elsewhere.
> 
> I've seen something as small as the "wrong" kind of noise cause the
> firmware to grind to a halt, so there could be a firmware bug that
> gets tickled by the particular layout or antenna configuration of the
> board in question. I suppose that's not a very helpful guess, but at
> least it might validate your observations.

Every bit helps! :)


> > Anyway, if someone knows how to get around to debugging this, I'd
> > appreciate a pointer! I can't see anything wrong with the tools I have
> > here.
> > If nothing else, I can't read /sys/class/devcoredump/devcd*/data that I
> > saw Amitkumar Karwar request somewhere else, so just deciphering this
> > would be great help.
> 
> I've never had success with that, but I haven't tried very hard. My
> understanding is that it's something equivalent to a register and
> state dump of the proprietary firmware, so you won't really learn much
> from it without proprietary knowledge.

Yes, that was my guess as well (hence the many Ccs with hopefully one
working there :-D), but I also understand free support isn't something
all companies let or encourage their employees to do.


Thanks for the reply anyway, if nothing else it might make the
difference for paying a bit more for a card with less troubling
history if my words weight enough.

-- 
Dominique
