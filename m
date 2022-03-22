Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9034E355D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 01:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiCVAUF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 20:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiCVAUD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 20:20:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EFC11CF57
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 17:17:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i11so13417922plr.1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=flBZM8E9Q9Ij8pr/I6DfjvVEftq8+LSBXxBZD8ewLgw=;
        b=Ae31CsOxiZ5kVNyNEwuyk6tZfH3Hg7c0J5pc7W33dvxetfLewFgrRGFniZawQ1A7OO
         NHW2W+PDDaJQEJzwEI6/VZ7PMEcZIQxkVIsZXH25UzYF45F99qmQoJ7NRwULJigLNXVh
         NxJdmjxqkiAhdNROoPp1BKM17dL4zHqRuCd08Oz0shuPMQxXTdpQww8gvehKnbBeE6uf
         F8yZ7ii12b9jdc4NFJqm7Fp4jhg3hFmu8csCwnIhtZbuYTM4G07ftklSroaUQh8UwH+e
         bhM/CvW9txpyKYu0bCIfxsUemxe3hjD7Wl0p2oIMJUEzofawXzWpPbXKC8h120mjs46i
         tBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=flBZM8E9Q9Ij8pr/I6DfjvVEftq8+LSBXxBZD8ewLgw=;
        b=ZxUnBv/gyNlROP5fYYhy6Hj2gWkiTXtXaSqunI5lwxIMhWvtAxZh96z/+DRJ/85LGe
         +XfN55Krw/fsOq3KYyE8FCDYB9FXaomvke+9YtU8mb5AgKGTUGwcdEzM9OZh/4FeHKyi
         BP45eyetCDAH66F4g1jYpnZ9l0962EdkrkMN+N+TGeRCAJwtvbnU0P2quPnQvX0rjz4f
         C68kUg8N1r0ED5CMog2a169WXDelpS83mGN7bozbsTbGPHsF/3tDQ11CP0sDdtLcYcEQ
         JpDBR1Lz74oQMgnC1WYXbu3wqNASSZe9pVQ4jNYQ0xRnj2idzOhi1n+4OcdkRAIcC0/a
         9x7Q==
X-Gm-Message-State: AOAM533IlrRrqjLl+dL5O8mDhxnHm23z2eqMh7bT3dwP/ML0ylN2y58c
        tDJgzTT4rFk1rTYVmPgjAqUoUPM2++2bUA==
X-Google-Smtp-Source: ABdhPJwoxXzdo2L5myJqEKqIsy1bPEzP+Q1rEi5iufRF9kB7zgkiGfGEWasFZV3CTWktTDDdCgrjIA==
X-Received: by 2002:a17:90a:3b06:b0:1c6:7140:348d with SMTP id d6-20020a17090a3b0600b001c67140348dmr1811660pjc.99.1647908127857;
        Mon, 21 Mar 2022 17:15:27 -0700 (PDT)
Received: from google.com (249.189.233.35.bc.googleusercontent.com. [35.233.189.249])
        by smtp.gmail.com with ESMTPSA id lw4-20020a17090b180400b001c7327d09c3sm550730pjb.53.2022.03.21.17.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 17:15:27 -0700 (PDT)
Date:   Tue, 22 Mar 2022 00:15:23 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [BUG] deadlock in nl80211_vendor_cmd
Message-ID: <YjkVG1ofyUg2IJP0@google.com>
References: <0000000000009e9b7105da6d1779@google.com>
 <99eda6d1dad3ff49435b74e539488091642b10a8.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99eda6d1dad3ff49435b74e539488091642b10a8.camel@sipsolutions.net>
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/21/2022, Johannes Berg wrote:
> Hi,
> 
> 
> > Basically, my wlan driver uses the wiphy_vendor_command ops to handle
> > a number of vendor specific operations.
> > 
> 
> I guess it's an out-of-tree driver, since I (hope I) fixed all the
> issues in the code here ... :)
> 
> > One of them in particular deletes
> > a cfg80211 interface.
> 
> There's quite normal API for that, why would you do that?!

Yeah, unfortunately this is the code I was given.

> 
> > The deadlock happens when thread 1 tries to take the
> > RTNL lock before calling cfg80211_unregister_device() while thread 2 is
> > inside nl80211_pre_doit(), holding the RTNL lock, and waiting on
> > wiphy_lock().
> > 
> > Here is the call flow:
> > 
> > Thread 1:                         Thread 2:
> > 
> > nl80211_pre_doit():
> >   -> rtnl_lock()
> >                                       nl80211_pre_doit():
> >                                        -> rtnl_lock()
> >                                        -> <blocked by Thread 1>
> >   -> wiphy_lock()
> >   -> rtnl_unlock()
> >   -> <unblock Thread 1>
> > exit nl80211_pre_doit()
> >                                        <Thread 2 got the RTNL lock>
> >                                        -> wiphy_lock()
> >                                        -> <blocked by Thread 1>
> > nl80211_doit()
> >   -> nl80211_vendor_cmd()
> >       -> rtnl_lock() <DEADLOCK>
> 
> Yeah, I guess the way we invoke vendor commands now w/o RTNL held means
> you cannot safely acquire RTNL in them.
> 
> I mean, the whole above thing basically collapses down to
> 
>  Thread 1                           Thread 2
>   wiphy_lock(); // nl80211
>                                      rtnl_lock();
>                                      wiphy_lock();
>   rtnl_lock();  // your driver
> 
> The correct order to _acquire_ these is rtnl -> wiphy, and we do it that
> way around everywhere (else).
> 
> > I'm not an networking expert. So my main question is if I'm allowed to take
> > the RTNL lock inside the nl80211_vendor_cmd callbacks?
> 
> Evidently, you're not. It's interesting though, it used to be that we
> called these with the RTNL held, now we don't, and the driver you're
> using somehow "got fixed" to take it, but whoever fixed it didn't take
> into account that this is not possible?

So in my quest to upgrade the Pixel 6 kernel from 5.10 to 5.15, I noticed that
I was hitting several ASSERT_RTNL() warnings during wlan testing. When I dug
into those asserts, I found commit a05829a7222e ("cfg80211: avoid holding the
RTNL when calling the driver") was causing these issues. So I went about adding
the necessary locks in the driver which led me to find this ABBA deadlock
scenario.

> 
> > I hope that helps explain the issue. Let me know if you need any more
> > details.
> 
> It does, but I don't think there's any way to fix it. You just
> fundamentally cannot acquire the RTNL in a vendor command operation
> since that introduced the ABBA deadlock you observed.
> 
> Since it's an out-of-tree driver that's about as much as I can help.
> 
> johannes

Yeah, I understand.  Thanks for the response!

--Will
