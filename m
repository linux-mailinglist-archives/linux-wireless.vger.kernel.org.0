Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C396F7C60
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 07:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjEEF1q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 01:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjEEF1p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 01:27:45 -0400
Received: from mail.kevlo.org (mail.kevlo.org [220.134.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54DAA27E
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 22:27:43 -0700 (PDT)
Received: from localhost (ns.kevlo.org [local])
        by ns.kevlo.org (OpenSMTPD) with ESMTPA id cbebcb91;
        Fri, 5 May 2023 13:27:39 +0800 (CST)
Date:   Fri, 5 May 2023 13:27:39 +0800
From:   Kevin Lo <kevlo@kevlo.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: 8188f: no need to initialize
 interrupts
Message-ID: <ZFSTy4hi/RZ4tIel@ns.kevlo.org>
References: <ZEswqUHBXPHC/znL@ns.kevlo.org>
 <87ildgpnsd.fsf@kernel.org>
 <ZEtpDi8oCr0E9scd@ns.kevlo.org>
 <02a6f536d1a144749d97db5c301ee76c@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02a6f536d1a144749d97db5c301ee76c@realtek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 02, 2023 at 09:10:04AM +0000, Ping-Ke Shih wrote:
> 
> 
> 
> > -----Original Message-----
> > From: Kevin Lo <kevlo@kevlo.org>
> > Sent: Friday, April 28, 2023 2:35 PM
> > To: Kalle Valo <kvalo@kernel.org>
> > Cc: linux-wireless@vger.kernel.org; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Jes Sorensen
> > <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
> > Subject: Re: [PATCH v2] wifi: rtl8xxxu: 8188f: no need to initialize interrupts
> > 
> > On Fri, Apr 28, 2023 at 08:40:34AM +0300, Kalle Valo wrote:
> > >
> > > Kevin Lo <kevlo@kevlo.org> writes:
> > >
> > > > There's no need to initialize interrupts for RTL8188FTV like the vendor driver.
> > > >
> > > > Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> > >
> > > Why do this, what's the benefit? Or is this just a theoretical fix. The
> > > commit log should explain this.
> > 
> > If I understand correctly, just like rtw88 usb devices, rtl8xxxu has no
> > hardware interrupt.
> > 
> 
> With/without hardware interrupt, it depends on IMR (interrupt mask register)
> setting. If it is enabled, driver can receive C2H, PS indicators, and beacon
> TBTT events via certain USB endpoint. But, normally vendor driver doesn't
> use them neither.
> 
> Why it initializes interrupt in this patch is to reset ISR (interrupt status
> register) to avoid unexpected interrupts are received. So, if it doesn't
> really enable interrupt by IMR, I suppose it should work well even without
> this patch.
> 
> Kevin, could I know the real problem you met?

Ping-Ke, many thanks for the clear explanation.

I didn't encounter any problems.  As you mentioned, while the vendor driver
doesn't have IMR settings, there is no harm in initializing interrupts.
Please drop this patch, thanks.

> Ping-Ke

Regards,
Kevin
