Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE01D664C0C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 20:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbjAJTJW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 14:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbjAJTIe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 14:08:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE82E4ECA3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 11:08:22 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e3so3605925wru.13
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 11:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nEwIdrLZTfrZ4pXoUGcec9+euEAaYix7cI4sfMdbo4=;
        b=g/z8p40l3stuFbucozBjhaTUWM3RyeXdGrNENonjYvFOQgqGCvaxx2kWA8IMEDaQED
         2bgH2e4Th+gdBxuYgw6rjn15/mm4UzsI8RQq1B/DGq6g/L++qjC8Bvbn855OiwG6syPc
         9tUEsOT+nyu6nX76Gc5RF+0viZc/LWQtvmFWeaAi+7OZreylXip38Cc0ZKiuAatMptck
         q2F9X0Ddggp6Tem0jPfnJEwYrKjJvQu0ngXVXEwPrRr9bRDNrZyKu5xnhl5we8mCoBjH
         4K2fFcFw5qGb6fbpMYYFn/QqwKYH8s12oWqCLA8VO2828mQ46IUp+/rvNZZgQjMMD9uz
         JA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nEwIdrLZTfrZ4pXoUGcec9+euEAaYix7cI4sfMdbo4=;
        b=6bCfCsxfSYTrpo33rr0MBG1LMETGz/gjzxTVJqjY985AXD4OWPcanyhrpsGBuK+GMM
         BFd+2/dSAiJ89HWJ+M4KKOM9Xz9ruXqhhk/62qkHgRztxDJty8lv3aOVLBXLVTVKHbXA
         +/Vhzxcx/4eH9Q0pFH316wTRsFsUPZRhygoEXtujspb3q8gquSrak66Ehsk0lQyJd78z
         zQzILQvm+1mXUVFSFjCkAO9h5KPakC5YQ1XPT7bd6xVSMVzK9BJ4GKgBnnmFdpp5jt+P
         93joRRaTo3mHeILtQg7DXx3aOhAQpsSbo1qY2kZqZO3+I9u1TogS6QtzjFNxVTJ2apgA
         d5FA==
X-Gm-Message-State: AFqh2kpNk2yJIvoKhgs4D3aL6wEdEW5zn4uO0+X5Uxs5HrmNQkK8wI3o
        rSt5NzJW6aErAUh6UyaOLtw=
X-Google-Smtp-Source: AMrXdXuxOOcRV3EpQeBfRsBCT6l4epcC6iRiH4PcX9fjyRVEx2/E7eILs+GGVWUsYbI2JNj9fBhvfg==
X-Received: by 2002:adf:f851:0:b0:2bc:7e19:fe84 with SMTP id d17-20020adff851000000b002bc7e19fe84mr4323898wrq.62.1673377701462;
        Tue, 10 Jan 2023 11:08:21 -0800 (PST)
Received: from tp440p.steeds.sam ([2602:fbf6:10:8::2])
        by smtp.gmail.com with ESMTPSA id q11-20020adff50b000000b0027f9f073211sm12034686wro.65.2023.01.10.11.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:08:21 -0800 (PST)
Date:   Tue, 10 Jan 2023 21:08:10 +0200
From:   Sicelo <absicsz@gmail.com>
To:     Alexander Wetzel <alexander@wetzel-home.de>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: WLAN broken on Nokia N900 with v6.2-rc1
Message-ID: <Y723mvhkubsvuA3R@tp440p.steeds.sam>
References: <Y6tTLPvsxh/Im4Ed@tp440p.steeds.sam>
 <a115fbb8-1048-9ae9-fcfb-ac1fd7d33449@wetzel-home.de>
 <Y7RdQqBQx58dIMAP@tp440p.steeds.sam>
 <f528de6f-2737-8560-3542-051d2d8f3654@wetzel-home.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f528de6f-2737-8560-3542-051d2d8f3654@wetzel-home.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello

On Tue, Jan 10, 2023 at 07:59:24PM +0100, Alexander Wetzel wrote:
> Should have seen the potential sooner, but can you please check if the
> following patch fixes the issue?
> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
> 
> This patch seems to be a perfect fit to what you are describing...
> 

Yes, someone pointed me to this patch a day ago, and it does fix the
issue indeed.

Apologies for not responding sooner.

> FYI:
> There is another regression report which has that as a very likely but not
> yet confirmed fix:
> https://lore.kernel.org/linux-wireless/7cff27f8-d363-bbfb-241e-8d6fc0009c40@leemhuis.info/T/#t
> 
> (The discussion above has another patch you really want to have when AMPDU
> is supported.)
> 

I will give this a try as well during the course of the week. I noticed
the speeds were low, but that could just be the weak hardware itself
(1x600MHz ARM CPU), and I have not had time to compare performance from
before the commits in question.

Regards
Sicelo
