Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9373A41E91B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 10:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352749AbhJAIcA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 04:32:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:56763 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352324AbhJAIcA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 04:32:00 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1918UASo8018928, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1918UASo8018928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 1 Oct 2021 16:30:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 1 Oct 2021 16:30:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 1 Oct 2021 16:30:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Fri, 1 Oct 2021 16:30:09 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH] rtw88: consider triggering state of simulating fw crash
Thread-Topic: [PATCH] rtw88: consider triggering state of simulating fw crash
Thread-Index: AQHXtRcLeZbBLSoEA0um9eDnHPVrpau9rlQwgAAipAA=
Date:   Fri, 1 Oct 2021 08:30:09 +0000
Message-ID: <c38681821bba424b845372b23e9e70e6@realtek.com>
References: <20210929094724.23595-1-pkshih@realtek.com>
 <87o889mfna.fsf@codeaurora.org>
In-Reply-To: <87o889mfna.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/9/29_=3F=3F_11:27:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org <kvalo=codeaurora.org@mg.codeaurora.org> On
> Behalf Of Kalle Valo
> Sent: Friday, October 1, 2021 2:19 PM
> To: Pkshih <pkshih@realtek.com>
> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org; Kevin Yang
> <kevin_yang@realtek.com>
> Subject: Re: [PATCH] rtw88: consider triggering state of simulating fw crash
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > In certain cases, triggering fw crash simulation via fw_crash debugfs
> > will take a while. If the state is queried too early before restart
> > begins processing, it may mistakenly think restart process has been
> > done. If some tests are started at this time, something unexpected
> > might happen due to the follow-up restart process.
> >
> > To avoid that, we consider the triggering state.
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >  drivers/net/wireless/realtek/rtw88/debug.c | 5 ++++-
> >  drivers/net/wireless/realtek/rtw88/main.c  | 1 +
> >  drivers/net/wireless/realtek/rtw88/main.h  | 1 +
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/debug.c
> b/drivers/net/wireless/realtek/rtw88/debug.c
> > index babf7fb238cc..682b23502e6e 100644
> > --- a/drivers/net/wireless/realtek/rtw88/debug.c
> > +++ b/drivers/net/wireless/realtek/rtw88/debug.c
> > @@ -886,6 +886,7 @@ static ssize_t rtw_debugfs_set_fw_crash(struct file *filp,
> >
> >  	mutex_lock(&rtwdev->mutex);
> >  	rtw_leave_lps_deep(rtwdev);
> > +	set_bit(RTW_FLAG_RESTART_TRIGGERING, rtwdev->flags);
> >  	rtw_write8(rtwdev, REG_HRCV_MSG, 1);
> >  	mutex_unlock(&rtwdev->mutex);
> >
> > @@ -897,7 +898,9 @@ static int rtw_debugfs_get_fw_crash(struct seq_file *m, void *v)
> >  	struct rtw_debugfs_priv *debugfs_priv = m->private;
> >  	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
> >
> > -	seq_printf(m, "%d\n", test_bit(RTW_FLAG_RESTARTING, rtwdev->flags));
> > +	seq_printf(m, "%d\n",
> > +		   test_bit(RTW_FLAG_RESTART_TRIGGERING, rtwdev->flags) ||
> > +		   test_bit(RTW_FLAG_RESTARTING, rtwdev->flags));
> >  	return 0;
> >  }
> 
> You use the verb "consider" both in the title and the commit log, but
> it's not really telling much (though I admit my english isn't very
> good). From looking at the patch all I see is that it prints the state
> of RTW_FLAG_RESTART_TRIGGERING flag. How is that "considering" anything
> and how does that improve any of this?
> 
> Can you improve the commit log and explain this is in detail? And what's
> "it" in this case?
> 

In order to make it clear, we change the title and provide the detail
by v2 [1].

[1] https://lore.kernel.org/linux-wireless/20211001082301.4805-1-pkshih@realtek.com/T/#u

--
Ping-Ke


