Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4A6BAFBB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 12:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCOL4S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 07:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCOL4Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 07:56:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56897C940
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 04:56:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32FBtpNF3015099, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32FBtpNF3015099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 15 Mar 2023 19:55:51 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Mar 2023 19:56:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Mar 2023 19:56:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 15 Mar 2023 19:56:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: add counters of register-based H2C/C2H
Thread-Topic: [PATCH] wifi: rtw89: add counters of register-based H2C/C2H
Thread-Index: AQHZUwUX5oym8Upi60mueYnXnELqdK77obDCgAAfjeA=
Date:   Wed, 15 Mar 2023 11:56:03 +0000
Message-ID: <485422aa276d49878278592861a103f8@realtek.com>
References: <20230310035943.49020-1-pkshih@realtek.com>
 <87r0tqmje1.fsf@kernel.org>
In-Reply-To: <87r0tqmje1.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Wednesday, March 15, 2023 5:52 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: [PATCH] wifi: rtw89: add counters of register-based H2C/C2H
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > The register-based H2C/C2H are used to exchange information between driver
> > and firmware, but only apply to narrow area because its data size is
> > smaller than regular packet-based H2C/C2H.
> >
> > This kind of H2C/C2H must be paired. To identify if any H2C/C2H is missing,
> > update counters to help diagnose this kind of problems.
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [...]
> 
> > +static inline void
> > +rtw89_write8_mask_add(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u8 add)
> > +{
> > +     u32 shift;
> > +     u8 orig, set;
> > +     u8 data;
> > +
> > +     mask &= 0xff;
> > +     shift = __ffs(mask);
> > +
> > +     orig = rtw89_read8(rtwdev, addr);
> > +     data = ((orig & mask) >> shift) + add;
> > +     set = (orig & ~mask) | ((data << shift) & mask);
> > +     rtw89_write8(rtwdev, addr, set);
> > +}
> 
> This function has a lot of shifting etc which feels like reinventing the
> wheel, doesn't linux/bitfield.h contain what you need? For example,
> u32_get_bits() and u32_replace_bits()?
> 

The mask argument of u32_get_bits() and his friends should be const, but our
usage could be a variable. For now, we have only one use case that the mask is
definitely const, but I remember it could lead some warning if we don't define
this as 'static __always_inline'.


My original thought to implement this function is 

rtw89_write8_mask_add(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u8 add)
{
	u8 tmp;

	tmp = rtw89_read8_mask(rtwdev, addr, mask);
	tmp += add;
	rtw89_write8_mask(rtwdev, addr, mask, tmp);
}

But, this needs three IO (two reading and one writing IO), so I implement this
a little odd patch. 


I'm thinking I can have another implementation that adds variables to maintain
counters by driver, and then I only need existing rtw89_write8_mask() to update
counters instead. Therefore, no need rtw89_write8_mask_add(). I will use this
method by v2.

Ping-Ke

