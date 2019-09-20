Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D582CB8CDD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 10:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405471AbfITI32 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 04:29:28 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58287 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405437AbfITI30 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 04:29:26 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8K8TGRL010410, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8K8TGRL010410
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Sep 2019 16:29:17 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Fri, 20 Sep
 2019 16:29:16 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 05/15] rtw88: pci: release tx skbs DMAed when stop
Thread-Topic: [PATCH 05/15] rtw88: pci: release tx skbs DMAed when stop
Thread-Index: AQHVb4S4hQTPSGBi5kOtH0MxIMGahqc0OmmA
Date:   Fri, 20 Sep 2019 08:29:15 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18DFE56@RTITMBSVM04.realtek.com.tw>
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
        <1568617425-28062-6-git-send-email-yhchuang@realtek.com>
        <CA+ASDXOMao9uucGxa6C0Q99pFvAtKTptreeshbfKqiELDKUH0Q@mail.gmail.com>
        <F7CD281DE3E379468C6D07993EA72F84D18DC62E@RTITMBSVM04.realtek.com.tw>
        <CA+ASDXP_7FVEaQrE1V=rX0Vieu8GGWj+it7p4F_8XeRNniEWkw@mail.gmail.com>
 <87tv97ctsp.fsf@codeaurora.org>
In-Reply-To: <87tv97ctsp.fsf@codeaurora.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Brian Norris <briannorris@chromium.org> writes:
> 
> > On Tue, Sep 17, 2019 at 7:10 PM Tony Chuang <yhchuang@realtek.com>
> wrote:
> >> > On Mon, Sep 16, 2019 at 12:03 AM <yhchuang@realtek.com> wrote:
> >> > >
> >> > > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >> > >
> >> > > Interrupt is disabled to stop PCI, which means the skbs
> >> > > queued for each TX ring will not be released via DMA
> >> > > interrupt.
> >> >
> >> > In what cases do you hit this? I think you do this when entering PS
> >> > mode, no? But then, see below.
> >>
> >> I'll hit this when ieee80211_ops::stop, or rtw_power_off.
> >> Both are to turn off the device, so there's no more DMA activities.
> >> If we don't release the SKBs that are not released by DMA interrupt
> >> when powering off, these could be leaked.
> >
> > Ah, I was a bit confused. So it does get called from "PS" routines:

I thought you're talking about IEEE80211_CONF_PS instead of
IEEE80211_CONF_IDLE.

> > rtw_enter_ips() -> rtw_core_stop()
> > but that "IPS" mode means "Inactive" Power Save, and it's only used
> > when transitioning into idle states (IEEE80211_CONF_IDLE).
> >
> > Incidentally, I think this also may explain many of the leaks I've
> > been seeing elsewhere, when I leave a device sitting and scanning for
> > a very long time -- each scan attempt is making a single transition
> > out-and-back to IPS mode, which meant it may be leaking any
> > outstanding TX DMA. And testing confirms this: if I just bring up the
> > interface, run a scan, then bring it down, I see many fewer unmaps
> > than maps. Doing this enough times, I run out of contiguous DMA memory
> > and the device stops working. This fixes that problem for me. So:
> >
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > Tested-by: Brian Norris <briannorris@chromium.org>
> >
> > I wonder if, given the problems I've seen (the driver can become
> > totally ineroperable), this patch and the previous patch (its only
> > real dependency) should be fast-tracked to the current release.
> 
> I agree, this sounds like a serious problem. So I'm planning to queue
> patches 4 and 5 to v5.4, if it's ok for Tony.

It's OK for me, didn't realize that this is a serious problem, so I missed it.
Also if possible you should queue patch 2, that reordering will cause
two H2C skbs not be released because HCI hasn't started, everytime
enter/leave IDLE state (rtw_power_[on|off]).

Should I resend and add a v5.4 prefix or something?

Yan-Hsuan
