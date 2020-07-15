Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E52208C9
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgGOJcN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:32:13 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37552 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgGOJcM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:32:12 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06F9VnUA2032724, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06F9VnUA2032724
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Jul 2020 17:31:49 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Jul 2020 17:31:49 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Jul 2020 17:31:48 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Wed, 15 Jul 2020 17:31:48 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kernel@iuliancostan.com" <kernel@iuliancostan.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "i@outv.im" <i@outv.im>,
        "trevor@shartrec.com" <trevor@shartrec.com>
Subject: RE: [PATCH v1] rtw88: pci: disable aspm for platform inter-op with module parameter
Thread-Topic: [PATCH v1] rtw88: pci: disable aspm for platform inter-op with
 module parameter
Thread-Index: AQHWOw2RujNwSXbT4UO+bT296oFUSqjR4mwAgAk8kAD//6rOgIABjPPw//+fKACALKDTuYAACCmg
Date:   Wed, 15 Jul 2020 09:31:48 +0000
Message-ID: <687e998811594240aecc859deecdd88f@realtek.com>
References: <20200605074703.32726-1-yhchuang@realtek.com>
        <20200610213720.3sopcuimas375xl2@linutronix.de>
        <a2aac609b5e2416b899c5842817da4bb@realtek.com>
        <20200616133531.7eyfu6jniywhak7h@linutronix.de>
        <fbf8d9cb6b864004b11372f6d70b734b@realtek.com>
        <20200617072938.dx56qsvcrpmtrrgu@linutronix.de>
 <87mu41b1b9.fsf@tynnyri.adurom.net>
In-Reply-To: <87mu41b1b9.fsf@tynnyri.adurom.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> > On 2020-06-17 05:30:22 [+0000], Tony Chuang wrote:
> >> 0000], Tony Chuang wrote:
> >> > > > On 2020-06-05 15:47:03 [+0800], yhchuang@realtek.com wrote:
> >> > > > > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >> > > > >
> >> > > > > Some platforms cannot read the DBI register successfully for the
> >> > > > > ASPM settings. After the read failed, the bus could be unstable,
> >> > > > > and the device just became unavailable [1]. For those platforms,
> >> > > > > the ASPM should be disabled. But as the ASPM can help the driver
> >> > > > > to save the power consumption in power save mode, the ASPM is still
> >> > > > > needed. So, add a module parameter for them to disable it, then
> >> > > > > the device can still work, while others can benefit from the less
> >> > > > > power consumption that brings by ASPM enabled.
> >> > > >
> >> > > > Can you set disable_aspm if rtw_dbi_read8() fails? Or make a test if it
> >> > > > is save to use?
> >> > > >
> >> > > > If someone notices the warning they still have to search for the warning
> >> > > > in order to make the link towards loading the module with the
> >> > > > disable_aspm=1 paramter.
> >> > > > Is it known what causes the failure?
> >> > > >
> >> > >
> >> > > I think as long as the rtw_dbi_read() fails, the consequent register
> >> > > operation will also fail, and still get an error read/write the register.
> >> > > And this is some sort of PCI issue, and I am not really familiar with it.
> >> > > Such as the root cause or how it fails.
> >> >
> >> > Then it does not sound safe to enable it by default.
> >>
> >> We have had a discussion about this, but I cannot find the thread now.
> >> People suggested that the module parameter should not be used.
> >> And they think that if the ASPM can help for power consumption, then
> >> it should be default enabled. But I think it should be based on that the
> >> other platforms will not just fail to bring up the device. However, the
> >> platforms are less than the others, not sure if default enable or disable
> >> is better.
> >
> > What I fail to understand is if this error affects other PCI devices as
> > well or just this one. And if it is possible to reset the wifi device
> > and everything gets back no normal. Or is it just the register reading,
> > that spams the log and would affect the system otherwise if you would
> > just avoided after the first fail.
> >
> >> > > If we can default disable it, then we can help those platforms, but
> >> > > then other platform will suffer from higher power consumption.
> >> >
> >> > So for those platform, where the error occurs, you expect that the user
> >> > manages to read the error message (a backtrace from rtw_dbi_read8())
> and
> >> > connects this the need to set a certain module option.
> >>
> >> Yes, we can discuss if it should be default enabled or not. Otherwise the
> >> people with those platforms can only do that to prevent this. Really bad.
> >
> > It would be good to know the root cause of this. So then default enable
> > would depend on it.
> > You could have a allow/forbid list based on DMI once you identified
> > good/bad systems but this includes additional maintenance.
> 
> I think there should be this kind of quirk list in rtw88 which would
> disable ASPM automatically on problematic platforms. We should not
> require the user to figure out the problem on their own and disable ASPM
> manually using the module parameter.

OK, I'll add a quirk list for the platforms.

> 
> > I think that at the very least, if the read fails you should give the
> > user additional information how to stop this from happening again. And
> > either stop issuing the commands again or skip driver loading (depending
> > what it means for device stability).
> 
> Yes, if we can guess that this is an ASPM problem giving additional
> information is very helpful for the user, please do that as well.
> 

Yes, should add additional information for the users, so they can
help to report the platforms.

Yen-Hsuan
