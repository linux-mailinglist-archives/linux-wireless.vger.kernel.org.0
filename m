Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A93C183F1D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 03:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgCMCYD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 22:24:03 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49051 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCMCYC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 22:24:02 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02D2Ncao006068, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02D2Ncao006068
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 10:23:38 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 13 Mar 2020 10:23:38 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 13 Mar 2020 10:23:38 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Fri, 13 Mar 2020 10:23:38 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "tamizhr@codeaurora.org" <tamizhr@codeaurora.org>
Subject: RE: [PATCH v2 2/2] rtw88: add a debugfs entry to enable/disable coex mechanism
Thread-Topic: [PATCH v2 2/2] rtw88: add a debugfs entry to enable/disable coex
 mechanism
Thread-Index: AQHV9eid5DTKsHzIFkaU/75iZgvikahFzUJQ
Date:   Fri, 13 Mar 2020 02:23:38 +0000
Message-ID: <33d4904b71a04ed8b0226ce07b037e05@realtek.com>
References: <20200309075852.11454-1-yhchuang@realtek.com>
        <20200309075852.11454-3-yhchuang@realtek.com>
 <877dzpu2lt.fsf@tynnyri.adurom.net>
In-Reply-To: <877dzpu2lt.fsf@tynnyri.adurom.net>
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

Kalle Valo <kvalo@codeaurora.org> :

> <yhchuang@realtek.com> writes:
> 
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > Sometimes we need to stop the coex mechanism to debug, so that we
> > can manually control the device through various outer commands.
> > Hence, add a new debugfs coex_enable to allow us to enable/disable
> > the coex mechanism when driver is running.
> >
> > To disable coex
> > echo 0 > /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable
> >
> > To enable coex
> > echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable
> >
> > To check coex dm is enabled or not
> > cat /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable
> 
> I forgot, did we add a command to nl80211 for managing btcoex? At least
> we have talking about that for years. Please check that first before
> adding a debugfs interface for this.
> 

Yes, I found there was a thread [1] talking about adding a callback to
enable/disable btcoex, but it seems not get applied eventually.

And there's another thread [2] talking about add a btcoex subsystem.
But seems like nobody can implement it cleanly in the host.

I think adding btcoex subsystem could have a lot of pain since each
vendor is using different mechanism controlling the btcoex, and it
usually comes with RF related design which is difficult to write a common
function to deal with all kinds of them.

Yen-Hsuan

[1] https://patchwork.kernel.org/patch/10252135/
[2] https://www.spinics.net/lists/linux-wireless/msg133333.html 

