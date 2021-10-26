Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F30A43BC3D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 23:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhJZVWd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 17:22:33 -0400
Received: from static-109-72-52-77.cpe.sn.co.rs ([109.72.52.77]:52144 "EHLO
        fx.arvanta.net" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239517AbhJZVWW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 17:22:22 -0400
Received: from elm.arvanta.net (arya.arvanta.net [10.5.1.6])
        by fx.arvanta.net (Postfix) with ESMTP id DED6317DA6;
        Tue, 26 Oct 2021 23:19:54 +0200 (CEST)
Date:   Tue, 26 Oct 2021 23:19:54 +0200
From:   Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Subject: Re: [BUG] mwifiex sdio wifi crashes on samsung peach pi chromebook
Message-ID: <YXhw+qwY1rtkPk+1@elm.arvanta.net>
References: <YXKXf1cBjPWqD1Aw@elm.arvanta.net>
 <CA+ASDXPExGHnDdZwvMGbZTTYB76Psy2JMTH7RTnvO1Zggh6c_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ASDXPExGHnDdZwvMGbZTTYB76Psy2JMTH7RTnvO1Zggh6c_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, 2021-10-26 at 13:55, Brian Norris wrote:
> Hi,
> 
> On Fri, Oct 22, 2021 at 4:20 AM Milan P. Stanić <mps@arvanta.net> wrote:
> > On my chromebook samsung peach pi (exynos-5800) wifi driver stops to
> > work at random time, sometimes after few hours and sometimes after day
> > or two.
> 
> I don't have official recommendations, nor HW to test at the moment,
> but for the record, Peach Pi should have Marvell SD 8797. You can see
> what firmware Chrome OS used to ship for those devices here:
> 
> https://chromium.googlesource.com/chromiumos/third_party/marvell/+/HEAD/sd8797_uapsta.bin
> https://chromium.googlesource.com/chromiumos/third_party/marvell/+log/HEAD/sd8797_uapsta.bin

On these urls I can't find actual file to download, or I'm blind (or
don't understand how this site 'works').
Whatever I click I get new url and not binary file to download.

Could you give url for binary file that I could download, please?

> Notably, the versioning there (e.g., W14-66-27-p18) suggests it's a
> different branch (?) than what's currently provided in the main
> linux-firmware (W14.68.29.p59). So you might give a try at replacing
> the file in /lib/firmware/mrvl/. No guarantees though.
> 
> > kernel is mainline 5.14.4 without patches, but I recall that I noticed
> > this crashes on older ones but can't remember exact version.
> 
> Did it ever work well? I'm curious if this was a kernel regression, or
> perhaps just a long-standing firmware issue.

Yes, it worked for few years but started to crash about few months ago
and that happened when I upgraded complete root filesystem, so it could
be related to upgraded firmware. Thank you for hint what to try to test.
 
> Brian
