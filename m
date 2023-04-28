Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6236F11CD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 08:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbjD1GfB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 02:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345142AbjD1Ge7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 02:34:59 -0400
Received: from mail.kevlo.org (mail.kevlo.org [220.134.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0692735
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 23:34:57 -0700 (PDT)
Received: from localhost (ns.kevlo.org [local])
        by ns.kevlo.org (OpenSMTPD) with ESMTPA id 5130a7f6;
        Fri, 28 Apr 2023 14:34:54 +0800 (CST)
Date:   Fri, 28 Apr 2023 14:34:54 +0800
From:   Kevin Lo <kevlo@kevlo.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: 8188f: no need to initialize
 interrupts
Message-ID: <ZEtpDi8oCr0E9scd@ns.kevlo.org>
References: <ZEswqUHBXPHC/znL@ns.kevlo.org>
 <87ildgpnsd.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ildgpnsd.fsf@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 28, 2023 at 08:40:34AM +0300, Kalle Valo wrote:
> 
> Kevin Lo <kevlo@kevlo.org> writes:
> 
> > There's no need to initialize interrupts for RTL8188FTV like the vendor driver.
> >
> > Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> 
> Why do this, what's the benefit? Or is this just a theoretical fix. The
> commit log should explain this.

If I understand correctly, just like rtw88 usb devices, rtl8xxxu has no
hardware interrupt.
