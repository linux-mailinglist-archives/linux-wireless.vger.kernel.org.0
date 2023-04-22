Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0E6EB6BB
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Apr 2023 04:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjDVCGf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 22:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDVCGe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 22:06:34 -0400
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 19:06:30 PDT
Received: from mail.rslp.org (mail.rslp.org [46.23.92.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD282122
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 19:06:30 -0700 (PDT)
Received: from [IPv6:::1] (<unknown> [2607:fb90:37a:3c0a:40f6:775a:9fcf:f54c])
        by mao.rslp.org (OpenSMTPD) with ESMTPSA id 532b3c7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 22 Apr 2023 03:59:48 +0200 (CEST)
Date:   Fri, 21 Apr 2023 21:59:45 -0400
From:   Pogprogrammer <spikey@rslp.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
CC:     b43-dev <b43-dev@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: NetworkManager cant connect on Macbook Pro7,1
User-Agent: K-9 Mail for Android
In-Reply-To: <19d8ea51-d37a-5446-fd7c-716e7e8b1aef@lwfinger.net>
References: <50BB827E-7437-4E25-9F5F-636115EF2D20@rslp.org> <19d8ea51-d37a-5446-fd7c-716e7e8b1aef@lwfinger.net>
Message-ID: <A174C362-2FAB-4191-A967-84D3B43F40AF@rslp.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Larry,
Thank you for responding. Yes, the Macbok pro 7,1 does have an Intel Core 2 Duo. 
As for my dmesg, I have it on anonfiles for at least the next few hours.
https://anonfiles.com/66ceMcm8zc/dmesg_txt

Again, thank you.

On April 21, 2023 8:05:13 PM EDT, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>On 4/21/23 18:11, Pogprogrammer wrote:
>> Hello, I installed b43 and I get the error that DMA is not supported and it will be switched to PIO. This was a bug on kernel 2.6, but I am using 6.1+. My mac is partially supported according to http://linuxwireless.sipsolutions.net/en/users/Drivers/b43/ and that may be part of the problem, but:
>> I am on void linux and networkmanager can identify all the networks but if I connect I get errors like "not found network" or maybe "bad password".
>> This is a fresh install and sometimes certain daemons just arent running, so here is my list:
>> Dbus, dhcpcd, NetworkManager, udevd, wpa_supplicant as well as the agetty-tty[1-6].
>> 
>> _______________________________________________
>> b43-dev mailing list
>> b43-dev@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/b43-dev
>
>Your description of the problem is not terribly coherent, thus I will be requesting some more information.
>
>DMA should be supported. It certainly works on my PowerBook G4 with a ppc32 processor. I expect that a MacBook 7.1 has an Intel processor. If not, please enlighted me.
>
>I would like you to run the command 'dmesg > dmesg.txt' and post dmesg.txt on some site where I can read it.
>
>The b43 devices are certainly slow as compared to modern devices, but the one on my PowerBook certainly works.
>
>Larry
>
