Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9A187E63
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 11:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgCQKdQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 06:33:16 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57739 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQKdQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 06:33:16 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02HAWwVp025210, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02HAWwVp025210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 18:32:58 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 17 Mar 2020 18:32:58 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 17 Mar 2020 18:32:58 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Tue, 17 Mar 2020 18:32:58 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>
Subject: RE: [PATCH] rtw88: add debugfs to fix tx rate
Thread-Topic: [PATCH] rtw88: add debugfs to fix tx rate
Thread-Index: AQHV+QPS9h9ZLy9E5U2M/GVMmM07xahGU7JUgAQrRBCAAeVFp4AANj0w
Date:   Tue, 17 Mar 2020 10:32:58 +0000
Message-ID: <ce990869ebf0478d98cd7e8416b36289@realtek.com>
References: <20200313065114.23433-1-yhchuang@realtek.com>
        <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
        <2e492e530d744713871f885e324106ef@realtek.com>
 <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
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

// Add Johannes for commenting on adding another nl80211 commands

Kalle Valo <kvalo@codeaurora.org> writes:> 

> Tony Chuang <yhchuang@realtek.com> writes:
> 
> > Kalle Valo <kvalo@codeaurora.org> writes:
> >
> >> <yhchuang@realtek.com> writes:
> >>
> >> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >> >
> >> > It is useful to fix the bit rate of TX packets. For example, if
> >> > someone is measuring the TX power, or debugging with the issues
> >> > of the TX throughput on the field.
> >> >
> >> > To set the value of fixed rate, one should input corresponding
> >> > desc rate index (ex, 0x0b for DESC_RATE54M to fix at 54 Mbps).
> >> > Set a value larger than DESC_RATE_MAX will disable fix rate, so
> >> > the rate adaptive mechanism can resume to work.
> >> >
> >> > Example,
> >> >   To fix rate at MCS 1:
> >> >   echo 0x0d > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
> >> >
> >> >   To not to fix rate:
> >> >   echo 0xff > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
> >> >
> >> >   To know which rate was fixed at:
> >> >   cat /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
> >> >
> >> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >>
> >> No way, debugfs is not a method for working around nl80211 and doing
> >> whatever idea you come up with. The goal is that we have a generic
> >> nl80211 command for all generic actions, like this one. And I think we
> >> already have an nl80211 command for fixing the tx rate, right?
> >>
> >
> > No, as I can see, there's no suitable nl80211 command that can achieve
> > what I want. If you are saying about
> NL80211_CMD_SET_TX_BITRATE_MASK,
> > it's used to allow some rates. But actually the firmware has its own rate
> > adaptive mechanism, so mask out the other rates does not mean the rate
> > left will be chosen. Moreover, the hardware will choose a lower bit rate
> > when retry, then the TX rate is not fixed at all. So the debugfs can disable
> > the firmware's RA mechanism, also disable the TX rate fall back when retry.
> > Both of them cannot be done by setting TX bitrate mask.
> 
> I'm confused, here you talk about firmware implementation etc but I'm
> just talking about replacing the fix_rate debugfs file to an nl80211
> command (for providing the fix_rate value). Can you clarify more why you
> think nl80211 is not suitable?

Oops, I thought that you wanted me to use the existing nl80211 command.
Now I know that you think we can add a new nl80211 command to help drivers
to fix the TX bitrate if necessary. If adding another nl80211 command for that
is acceptable, I can work on this. But I need Johannes's comment if it's better
to add a new nl80211 command or to expand the existing command
(ex. NL80211_CMD_SET_TX_BITRATE_MASK). It looks like that adding a new
nl80211 command will be better for me as expanding the existing one would
have great impact on the already distributed drivers/user-tools.

> 
> > I am sorry I need to add another debugfs for it, but to actually fix the TX
> > bitrate, we really need another debugfs or module parameter. Because
> > according to the design of the device there is not a good enough general
> > command I can use to fix the TX rate. If there is a command that can fix
> > the TX bitrate for me, please let me know, I can switch to it.
> 
> Sorry, but I'm not yet convinced that a debugfs file is justified.
> Fixing a transmit bitrate sounds like a very generic command, not
> something which should be in debugfs.
> 

Thanks.
Yen-Hsuan
