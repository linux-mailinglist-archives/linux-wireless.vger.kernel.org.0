Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4926742CC5
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjF2TAp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjF2TAk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 15:00:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB4AE4B
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 12:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80A89615D8
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 19:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94108C433CC;
        Thu, 29 Jun 2023 19:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688065237;
        bh=ah18Kry4o3bgB4ytnNxb5ap/lUEyJSBIYP8vjiTTeH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onV24YGDOrrpro8Dkjuy1ct5GMeNyJZC4XmIbakU2L/yuxtva75CgDktcrXqXS0JQ
         dpyM215GukmXDh95AbHzxPxfqz28hkY9US23+hy1yuit3dj6wswt65dz1uOQbMeJPO
         uDR4+8vlT/gB3w8ZJT1Xm5f1hLh2IpGAm1RC5qDE=
Date:   Thu, 29 Jun 2023 20:46:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: iwlwifi: AX201 misdetected as AX101
Message-ID: <2023062914-upcoming-turmoil-a443@gregkh>
References: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com>
 <FFsiCdZPcJ2FItvpkX6E-0LT-gc1m-7JdRKTZ0NB9s7AmhtFt09wmR8fItdeT5xaYybsKsC_cjXuh5i_V97rgq4fJgKOmBmKytjCwSKlnAU=@protonmail.com>
 <3270268e-c926-01e6-65e1-02aa6abfd0db@leemhuis.info>
 <BgFi95lMulZVgv9IMN9yIzwTaSjvUWnYbQo1U5KT9-G8Dsxuuv4ENVy9iTx8Z8YamXBVPX-K3PYgVBSwgjGY5qXoEsQNpaVXip595AQO584=@protonmail.com>
 <0d3db91c-f071-009a-952a-bd109b16a352@leemhuis.info>
 <Up7ODaGLOvtHrl4bj_ev71C6sR5WLequE6TkRsH208_NGRQiZ-f8xdP25L7n9zTZD4bQPMH9aVbfagEh8lbzVlSQRc1mMQFvbIfKAlEU4uA=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Up7ODaGLOvtHrl4bj_ev71C6sR5WLequE6TkRsH208_NGRQiZ-f8xdP25L7n9zTZD4bQPMH9aVbfagEh8lbzVlSQRc1mMQFvbIfKAlEU4uA=@protonmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 29, 2023 at 05:30:34PM +0000, Barnabás Pőcze wrote:
> Hi
> 
> 
> 2023. június 29., csütörtök 18:50 keltezéssel, Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> írta:
> 
> > On 29.06.23 17:28, Barnabás Pőcze wrote:
> > > 2023. június 29., csütörtök 13:31 keltezéssel, Thorsten Leemhuis <regressions@leemhuis.info> írta:
> > >> On 27.06.23 23:55, Barnabás Pőcze wrote:
> > >>> 2023. május 26., péntek 19:55 keltezéssel, Barnabás Pőcze <pobrn@protonmail.com> írta:
> > >>>> I have an Acer Aspire A315-58 laptop[0], which, according to lspci has the following intel wireless chip:
> > >>>>
> > >>>>    Device:	00:14.3
> > >>>>     Class:	Network controller [0280]
> > >>>>    Vendor:	Intel Corporation [8086]
> > >>>>    Device:	Wi-Fi 6 AX201 [a0f0]
> > >>>>   SVendor:	Intel Corporation [8086]
> > >>>>   SDevice:	Wi-Fi 6 AX201 [0244]
> > >>>>       Rev:	20
> > >>>>    ProgIf:	00
> > >>>>    Driver:	iwlwifi
> > >>>>    Module:	iwlwifi
> > >>>>
> > >>>> However, in the kernel message buffer, the following message is written:
> > >>>>
> > >>>>   [    3.633490] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX101, REV=0x351
> > 
> > Gregory who is CCed since the start of the thread might care to look
> > into this. According to a quick search lspci is right, but this needs
> > expects. Maybe it's just a cosmetic problem.
> > 
> > >>> [...]
> > >>> For the record, I have done a git-bisect[1], and that turned up
> > >>>   d2ccc5c1526396aef5196e4dd2ec8538994e5072
> > >>>
> > >>> as the first good commit[0].
> > >>>
> > >>> Sadly, that patch (or even the series) does not appear to be easily backportable,
> > >>> so it seems likely that current stable kernels won't be able to support this device.
> > >>
> > >> Thx for bisecting.
> > >>
> > >> Thing is: 6.3 will be EOL in about two or three weeks anyway. And Arch
> > >> will likely switch to 6.4 (which works -- or did I get this wrong?)
> > >> within a week or two. Makes be wonder if it's the best solution for
> > >> everyone involved to not resolve this and move on.
> > >
> > > Yes, 6.4 seems to work.
> > 
> > #regzbot inconclusive: unlikely to be fixed in 6.3 before EOL, but 6.4 works
> > 
> > > I mainly meant LTS releases.  Nonetheless, lspci
> > > and iwlwifi still disagree on what device it actually is.
> > 
> > Not sure if I properly understand this.
> > 
> > Is this broken in 6.1.y as well, but working in earlier kernels? Then it
> > needs a separate report.
> 
> There are two issues:
> 
>  * lspci and iwlwifi disagreeing about the device (AX201 vs AX101), and
>  * the device not working until the aforementioned commit.
> 
> This email was originally intended to be about the first one since the device
> does work with 6.4.
> 
> But out of curiosity I wanted to find the commit that made the device work to
> see if maybe it could be easily backported to 6.3, 6.1, etc.
> 
> In conclusion:
> 
>         device does not work        device is misdetected
> 6.1          present                       present
> 6.3          present                       present
> 6.4           fixed                        present
> 
> Since the commits that fixed it don't appear to be easily backportable,
> the only thing remains to be seen is why lspci and iwlwifi disagree about the
> name of the device. That issue is still present in 6.4.

This isn't a regression then, it's never worked, but now it works in
6.4, so yeah!  And we don't generally backport new hardware enablement
to stable kernels unless it's a simple device id table update.

As for naming, realize that iwlwifi and lspci get the names of the
device from different places, so perhaps those userspace databases just
are not in sync yet?

thanks,

greg k-h
