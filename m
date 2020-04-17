Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBE61AD963
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 11:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgDQJDn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 05:03:43 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42651 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgDQJDn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 05:03:43 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H93ZckC013457, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H93ZckC013457
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 17:03:35 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 17:03:35 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 17:03:34 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Fri, 17 Apr 2020 17:03:34 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 00/40] rtw88: add support for 802.11n RTL8723DE devices
Thread-Topic: [PATCH 00/40] rtw88: add support for 802.11n RTL8723DE devices
Thread-Index: AQHWFIyBGPvBpMHAzEi6xd36kOHEBah8+OILgAAB1puAAAlqUA==
Date:   Fri, 17 Apr 2020 09:03:34 +0000
Message-ID: <63bfd72cb01041ae8b6f049d49bda880@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
        <87lfmuplrm.fsf@kamboji.qca.qualcomm.com>
 <87zhbajz6f.fsf@tynnyri.adurom.net>
In-Reply-To: <87zhbajz6f.fsf@tynnyri.adurom.net>
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

Kalle Valo <kvalo@codeaurora.org> writes:
> 
> > <yhchuang@realtek.com> writes:
> >
> >> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >>
> >> Although RTL8723DE devices are 802.11n devices, while rtw88
> >> aimed to support for 802.11ac devices, the 8723DE devices's
> >> architecture is relatively close to the 802.11ac devices.
> >> So, add support for them on rtw88, with some minor modifications.
> >
> > There's no way I'm going to review 40 patches in one go :) So I'll just
> > to look at around 10 first patches and drop the rest.
> >
> > If you want your patches reviewed smoothly submit only around 7-12
> > patches per patchset. If the patches are bigger don't send more than 7
> > patches. But if they smaller, or trivial patches, 12 patches is ok. But
> > anything more than 12 patches and I'm sure you will get reviewers
> > grumpy.
> >
> > But you can submit multiple patchsets, just try to throttle it down to
> > avoid bufferbloat in patchwork, ie. send a new patchset every other day
> > and document the dependencies in the cover letter ("this patchset
> > depends on patchset B").
> 
> I added this also to the wiki:
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa
> tches#maximum_of_7-12_patches_per_patchset
> 

Actually I can send the 8723DE within 5 patches, but I thought that split
them will be easier to review :) If too many patches is a problem, then I
can squash them back together, because most of them are hardware
settings. I can resend a v2.

Yen-Hsuan
