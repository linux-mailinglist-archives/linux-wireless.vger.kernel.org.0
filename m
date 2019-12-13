Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D08CF11DE3D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 07:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLMGhf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 01:37:35 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:58212 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfLMGhe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 01:37:34 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBD6bI2O006267, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBD6bI2O006267
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 14:37:18 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Fri, 13 Dec 2019 14:37:18 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 13 Dec 2019 14:37:18 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::7d15:f8ee:cfc7:88ce]) by
 RTEXMB04.realtek.com.tw ([fe80::7d15:f8ee:cfc7:88ce%6]) with mapi id
 15.01.1779.005; Fri, 13 Dec 2019 14:37:18 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Bjoern Franke <bjo@schafweide.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Realtek 8822BE: r8822be vs. rtwpci (mainline / lwfinger)
Thread-Topic: Realtek 8822BE: r8822be vs. rtwpci (mainline / lwfinger)
Thread-Index: AQHVrFXQi4K9V3YDkU+TLpaY4+mhfKexpZAEgAYAkfA=
Date:   Fri, 13 Dec 2019 06:37:17 +0000
Message-ID: <e28ce50db6344157832fc860a65a3ae9@realtek.com>
References: <50038b2f-8b90-d803-0377-2c19cc7ad78e@schafweide.org>
 <0101016eea4be8c6-86cd4509-2811-4de8-92be-bd5cfa50d49c-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eea4be8c6-86cd4509-2811-4de8-92be-bd5cfa50d49c-000000@us-west-2.amazonses.com>
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

> Subject: Re: Realtek 8822BE: r8822be vs. rtwpci (mainline / lwfinger)
> 
> Bjoern Franke <bjo@schafweide.org> writes:
> 
> > I'm a little confused about the status of the modules for the Realtek
> > 8822BE.
> >
> > Once, there was r8822be which had some issues, but worked more or less
> > reliable. Then came rtw88/rtwpci and in my Thinkpad A275 it is hardly
> 
> Tony, that rtwpci sounds like very confusing name for a rtw88 module,
> even I was first confused what driver is that. I think it should be
> rtw88_pci or something like that.
> 

True, I can rename it to rtw88_pci. I am also thinking if I should rename
all of the prefixes from "rtw_" to "rtw88_", but that seems to be a huge
patch. I will try to see if this is necessary to do it.

Yan-Hsuan
