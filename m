Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6511116
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 04:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEBCFg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 22:05:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59579 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBCFg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 22:05:36 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x42258s5005202, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x42258s5005202
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 2 May 2019 10:05:08 +0800
Received: from RTITEXH01.realtek.com.tw (172.21.6.62) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Thu, 2 May 2019 10:05:07 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITEXH01.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Thu, 2 May 2019
 10:05:07 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        Pkshih <pkshih@realtek.com>, Andy Huang <tehuang@realtek.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "sgruszka@redhat.com" <sgruszka@redhat.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v9 00/14] rtw88: mac80211 driver for Realtek 802.11ac wireless network chips
Thread-Topic: [PATCH v9 00/14] rtw88: mac80211 driver for Realtek 802.11ac
 wireless network chips
Thread-Index: AQHU9txMArZAB4AbME2H8ZtE00akX6ZUtfligAJxmpA=
Date:   Thu, 2 May 2019 02:05:06 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17E6A1D@RTITMBSVM04.realtek.com.tw>
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
 <87sgtzwtst.fsf@purkki.adurom.net>
In-Reply-To: <87sgtzwtst.fsf@purkki.adurom.net>
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

> 
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > This is a new mac80211 driver for Realtek 802.11ac wireless network chips.
> > rtw88 now supports RTL8822BE/RTL8822CE now, with basic station mode
> > functionalities. The firmware for both can be found at linux-firmware.
> 
> This looks very good now. I did a quick review of the driver and had few
> netpicks but nothing really blocking applying this. So I have now
> combined these patches into one big patch and pushed it to the pending
> branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/c
> ommit/?h=pending&id=284d1e4e3311cfe67c1c57ccc275ff0f5666aeea
> 
> I appreciate if people could do a quick check and make sure that I
> didn't do anything stupid when folding the patches. I'm planning to
> apply this to master branch still today evening so that it makes to
> tomorrow's linux-next build, and I can get it to net-next before the
> merge window starts on Sunday.

Thanks, that's great.

> 
> Yan-Hsuan, during review you have received very good comments from a lot
> of folks, I recommend you go through all of them and send fixes as
> follow up patches. I can then apply them after the merge window.

Yes I will include those good comments.
Should I send them to your next branch? Such as [PATCH][next].

Yan-Hsuan

