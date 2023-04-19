Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A06E7069
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 02:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjDSAVi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 20:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjDSAVf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 20:21:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D254AA5E2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 17:21:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33J0KYktC020268, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33J0KYktC020268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 19 Apr 2023 08:20:34 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 19 Apr 2023 08:20:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 19 Apr 2023 08:20:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 19 Apr 2023 08:20:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Hans Ulli Kroll <linux@ulli-kroll.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Tim K <tpkuester@gmail.com>, "Alex G ." <mr.nuke.me@gmail.com>,
        Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        ValdikSS <iam@valdikss.org.ru>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 3/4] wifi: rtw88: set pkg_type correctly for specific rtw8821c variants
Thread-Topic: [PATCH v3 3/4] wifi: rtw88: set pkg_type correctly for specific
 rtw8821c variants
Thread-Index: AQHZcTWhs9mTMlEeIUm9+FRiD4ucxa8wOCrggAAHFgCAAYbR0A==
Date:   Wed, 19 Apr 2023 00:20:33 +0000
Message-ID: <3bad94b1b1914b30a38e8325e2593aeb@realtek.com>
References: <20230417140358.2240429-1-s.hauer@pengutronix.de>
 <20230417140358.2240429-4-s.hauer@pengutronix.de>
 <abc17f5fe6c944a5a1361d4d76817a08@realtek.com>
 <20230418085806.GO13543@pengutronix.de>
In-Reply-To: <20230418085806.GO13543@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, April 18, 2023 4:58 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless <linux-wireless@vger.kernel.org>; Hans Ulli Kroll <linux@ulli-kroll.de>; Larry Finger
> <Larry.Finger@lwfinger.net>; Tim K <tpkuester@gmail.com>; Alex G . <mr.nuke.me@gmail.com>; Nick Morrow
> <morrownr@gmail.com>; Viktor Petrenko <g0000ga@gmail.com>; Andreas Henriksson <andreas@fatal.se>;
> ValdikSS <iam@valdikss.org.ru>; kernel@pengutronix.de
> Subject: Re: [PATCH v3 3/4] wifi: rtw88: set pkg_type correctly for specific rtw8821c variants
> 
> On Tue, Apr 18, 2023 at 12:36:31AM +0000, Ping-Ke Shih wrote:
> >
> >
> > > -----Original Message-----
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Monday, April 17, 2023 10:04 PM
> > > To: linux-wireless <linux-wireless@vger.kernel.org>
> > > Cc: Hans Ulli Kroll <linux@ulli-kroll.de>; Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih
> > > <pkshih@realtek.com>; Tim K <tpkuester@gmail.com>; Alex G . <mr.nuke.me@gmail.com>; Nick Morrow
> > > <morrownr@gmail.com>; Viktor Petrenko <g0000ga@gmail.com>; Andreas Henriksson <andreas@fatal.se>;
> > > ValdikSS <iam@valdikss.org.ru>; kernel@pengutronix.de; Sascha Hauer <s.hauer@pengutronix.de>
> > > Subject: [PATCH v3 3/4] wifi: rtw88: set pkg_type correctly for specific rtw8821c variants
> > >
> > > According to the vendor driver the pkg_type has to be set to '1'
> > > for some rtw8821c variants. As the pkg_type has been hardcoded to
> > > '0', add a field for it in struct rtw_hal and set this correctly
> > > in the rtw8821c part.
> > > With this parsing of a rtw_table is influenced and check_positive()
> > > in phy.c returns true for some cases here. The same is done in the
> > > vendor driver. However, this has no visible effect on the driver
> > > here.
> >
> > I agree this patch, but still want to know more about the meaning of
> > "...no visible effect...". Do you mean your USB device works well with/without
> > this patch? or, IO is absolutely the same when loading parameters with
> > check_positive()?
> 
> Yes, it works with and without this patch. With this patch
> check_positive() returns true in some cases whereas without this patch
> check_positive always returns false.
> I don't know at all what effect this change could have, maybe I just
> need the right test case to verify it really makes a change.
> 
> I just realized that something like the below is missing, as the
> cond.rfe part needs the raw rfe value from fuses >> 3.
> 
> Maybe we just take 1/4 and 2/4 and drop the others. I am running out of
> time for further debugging RTW8821C which is a chip our customer isn't
> interested in.
> 

I think we can take all patches, because they go forward to correct direction,
and other flaws can be fixed after people can really get that kind of modules.

Ping-Ke

