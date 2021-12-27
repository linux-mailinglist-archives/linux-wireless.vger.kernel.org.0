Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF348028A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Dec 2021 18:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhL0RB4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Dec 2021 12:01:56 -0500
Received: from static-109-72-52-77.cpe.sn.co.rs ([109.72.52.77]:35492 "EHLO
        fx.arvanta.net" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229565AbhL0RBz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Dec 2021 12:01:55 -0500
X-Greylist: delayed 1635 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Dec 2021 12:01:55 EST
Received: from m1 (unknown [10.5.1.15])
        by fx.arvanta.net (Postfix) with ESMTP id BF13724BE0;
        Mon, 27 Dec 2021 17:34:38 +0100 (CET)
Date:   Mon, 27 Dec 2021 17:34:38 +0100
From:   Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Subject: Re: [BUG] mwifiex sdio wifi crashes on samsung peach pi chromebook
Message-ID: <YcnrHl5rY+7YUlp+@m1>
References: <YXKXf1cBjPWqD1Aw@elm.arvanta.net>
 <CA+ASDXPExGHnDdZwvMGbZTTYB76Psy2JMTH7RTnvO1Zggh6c_w@mail.gmail.com>
 <YXhw+qwY1rtkPk+1@elm.arvanta.net>
 <CA+ASDXP6v3sJj9YEXpOMk+F73dd5sUs_PHWm5+ye16yJsy2S0g@mail.gmail.com>
 <YXmv0XkBUj/oQGva@elm.arvanta.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXmv0XkBUj/oQGva@elm.arvanta.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

On Wed, 2021-10-27 at 22:00, Milan P. Stanić wrote:
> On Tue, 2021-10-26 at 14:29, Brian Norris wrote:
> > On Tue, Oct 26, 2021 at 2:20 PM Milan P. Stanić <mps@arvanta.net> wrote:
> > > On Tue, 2021-10-26 at 13:55, Brian Norris wrote:
> > > > On Fri, Oct 22, 2021 at 4:20 AM Milan P. Stanić <mps@arvanta.net> wrote:
> > > > > On my chromebook samsung peach pi (exynos-5800) wifi driver stops to
> > > > > work at random time, sometimes after few hours and sometimes after day
> > > > > or two.
> > > >
> > > > I don't have official recommendations, nor HW to test at the moment,
> > > > but for the record, Peach Pi should have Marvell SD 8797. You can see
> > > > what firmware Chrome OS used to ship for those devices here:
> > > >
> > > > https://chromium.googlesource.com/chromiumos/third_party/marvell/+/HEAD/sd8797_uapsta.bin
> > > > https://chromium.googlesource.com/chromiumos/third_party/marvell/+log/HEAD/sd8797_uapsta.bin
> > >
> > > On these urls I can't find actual file to download, or I'm blind (or
> > > don't understand how this site 'works').
> > > Whatever I click I get new url and not binary file to download.
> > 
> > Ack, I forgot Gitiles is not super friendly for downloading binaries directly:
> > 
> > https://github.com/google/gitiles/issues/106
> > 
> > > Could you give url for binary file that I could download, please?
> > 
> > This should do it:
> > 
> > curl https://chromium.googlesource.com/chromiumos/third_party/marvell/+/HEAD/sd8797_uapsta.bin?format=TEXT
> > | base64 -d > sd8797_uapsta.bin
> 
> This works, thanks.
> 
> With this firmware it crashed after 8 hours, and I rebooted machine to
> see how long it will work on second try.
> 
> > Or some similar invocation if you have to use the browser (click on
> > the "txt" link, then base64-decode the result).
> > 
> > > > > kernel is mainline 5.14.4 without patches, but I recall that I noticed
> > > > > this crashes on older ones but can't remember exact version.
> > > >
> > > > Did it ever work well? I'm curious if this was a kernel regression, or
> > > > perhaps just a long-standing firmware issue.
> > >
> > > Yes, it worked for few years but started to crash about few months ago
> > > and that happened when I upgraded complete root filesystem, so it could
> > > be related to upgraded firmware. Thank you for hint what to try to test.
> > 
> > Could be. It does look like mainline linux-firmware got an update for
> > this file in 2019, so it's possible your distro (or whatever provides
> > your rootfs) only semi-recently got the update.
> 
> I use linux-firmware-mrvl-20210919 release but this also happened with
> some earlier versions released this year.
> 
> I use Alpine linux (https://alpinelinux.org/, I'm alpine linux developer
> and maintainer of latest stable kernels on it).
> 
> In meantime I found that Arch linux for ARM (alarm) have older firmware
> for peach chromebook here (probably copied from chromeos):
> https://archlinuxarm.org/builder/src/sd8787_uapsta_cros.bin
> https://archlinuxarm.org/builder/src/sd8797_uapsta_cros.bin
> https://archlinuxarm.org/builder/src/sd8897_uapsta_cros.bin
> 
> They even have patched kernel for this here:
> https://archlinuxarm.org/packages/armv7h/linux-peach/files/0002-use-chromiumos-mwifiex-drivers.patch
> but this is for old 3.8.11 kernel.
> 
> I will try with them and see how it would work.
> Also I will try to find if I have old root FS which worked few years on
> it (if I have it archived somewhere).
> 
> Also, I will report back results.

After two months of testing with above firmware it works better but
still crashes, sometimes after 4-12 days but more times it works about
7-8 days.

So, not sure is worth to debug this problem more for me but maybe
it is worth someone who need it to run without reboot for long periods
to find firmware which is stable.

Thank you all for help and best wishes for new year.

-- 
Kind regards
