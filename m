Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0087E9261
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 20:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjKLTxx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 14:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLTxw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 14:53:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416C21BFF
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 11:53:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so5938125a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 11:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699818828; x=1700423628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFh6+GBVb0Z9uHw00TBpOMCzVc3LQjABYyyVDDrhDfQ=;
        b=juWjuVjYmr2igeveUoJ0TPtj0ERgh8uP3pQRwPW6edp741P94eQzhLCqJyGuo69QkI
         MKnogt4gNCrU5pCoKSDnXF1NKddnb/DzAc6wX2dgm3BCdxZyMPGpyH4Nmjeet0ygAo8k
         MJRCd0zqrqFvchlwhFAEWn/y2pyOmzqOuEPpP/2wtUa2XvEOflC3uB2CrFmNlgVnEo0t
         TTZpYP1VB6BHb4/EC5E0aq9PB8Gm6IpwRNp8BbbAxhPWsumL/iZ0pu5K3+7lPwfTOMKE
         rNOBoGYL7hx1z4aUy9Ws+L9RGdgK39v96A6QtQ880vPjib4v9jW0nfj3dg5VauiiJsgj
         EQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699818828; x=1700423628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFh6+GBVb0Z9uHw00TBpOMCzVc3LQjABYyyVDDrhDfQ=;
        b=kfT6We2mSt8FjRG6N+vwAvmSJDxAV2KMDYfhVhBsy0BHjwqYmrcEFi6LNsemZV6kph
         Es67PgosotTbqqocBHUVirAsY1TahvOeTd4F6RF9H54SpBJd8lgyZcISIIUyy6SXdhE3
         Hs782f2taJs529DStBjPWz//RmT6mNZdQX6Th1NEjSh/gxEVmiHrrYFAz3dAhiHAEybP
         GzUsv5NunFk687BPxSDUA6aeeHfEE3NaGCyZ5fSkOAl0FrhBmRySibWPBuRM3u+KSrVa
         4qwE8Tlr3nj//cvUF7ADWBeAzz7NteeBtj3AOG3dPr6OaDeyArwIeOtGYqv8UFCj0son
         xgoQ==
X-Gm-Message-State: AOJu0Ywl3HMbS5kMdEKFiS44UdV2a0Kz3xxk6drVZi2vbmkxmRQ82+wL
        1MJCKlAcmJnPA0UrKYeMkOxsVPKBEw4I4+/SVs8=
X-Google-Smtp-Source: AGHT+IE2OyWSPXGTuZg7S0BiGGG5pxE4Ap/5JqIfOmY7skWJhSa00Y3VdxgSeFDv/DcWaVxpIIVZlgi7FDs8UHyNHag=
X-Received: by 2002:aa7:d84a:0:b0:540:fd21:b32d with SMTP id
 f10-20020aa7d84a000000b00540fd21b32dmr3423043eds.36.1699818827438; Sun, 12
 Nov 2023 11:53:47 -0800 (PST)
MIME-Version: 1.0
References: <20231112095943.19353-1-emmanuel.grumbach@intel.com>
 <20231112143620.36619-1-emmanuel.grumbach@intel.com> <875y26ajks.fsf@kernel.org>
 <CAHk-=wgyG-8ehCc4C4V-b-8rBtfyd9ApDeQSx-5BKRaHywhVpw@mail.gmail.com>
In-Reply-To: <CAHk-=wgyG-8ehCc4C4V-b-8rBtfyd9ApDeQSx-5BKRaHywhVpw@mail.gmail.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Sun, 12 Nov 2023 21:53:36 +0200
Message-ID: <CANUX_P0kDV6PC5=+oxgnVetMR+kERqCMsVju22mBqcW5bED8sA@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: iwlwifi: fix system commands group ordering
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        pagadala.yesu.anjaneyulu@intel.com,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= 
        <pinkflames.linux@gmail.com>,
        Damian Tometzki <damian@riscv-rocks.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Nov 12, 2023 at 9:39=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 12 Nov 2023 at 10:54, Kalle Valo <kvalo@kernel.org> wrote:
> >
> > Linus, I suspect it will take a while before we make a new wireless pul=
l
> > request (there's currently just one commit in the wireless tree). So if
> > you want to take this directly to your tree please go ahead, otherwise
> > you get it via the normal route in a week or two. Just let us know what
> > you prefer.
> >
> > Acked-by: Kalle Valo <kvalo@kernel.org>
>
> Ok, I just tested it in my private tree, and it fixes the WARN_ON() as
> expected, so I'll apply it for real.

Good to know - thanks.

>
> However, now that I don't have that big warning in there, I do note
> another iwlwifi issue that is new to this meger window:
>
>   debugfs: Directory 'iwlmvm' with parent 'netdev:wlo2' already present!
>   iwlwifi 0000:45:00.0: Failed to create debugfs directory under netdev:w=
lo2
>   debugfs: Directory 'iwlmvm' with parent 'netdev:wlo2' already present!
>   iwlwifi 0000:45:00.0: Failed to create debugfs directory under netdev:w=
lo2
>
> and looking at my system logs, this is new.
>
> It looks like it is probably due to
>
>   c36235acb34f ("wifi: iwlwifi: mvm: rework debugfs handling")
>   e9dd25550770 ("wifi: iwlwifi: mvm: add a per-link debugfs")
>
> but that's just from looking at the patches (ie no bisection or any
> real effort).

Don't bother, we'll take a look.

>
> This is after the system has come up, so I assume it's when
> networkmanager or whatever actually is setting that wireless thing up.

Most likely the network-manager brings the device up several times or somet=
hing
like that, but let's not blame them before we check what happens internally=
.

>
> Again: I actually don't *use* the WiFi on this machine - but from a
> quick check it does seem to work. So this is just an annoyance and a
> sign that somebody didn't do all the details right (possibly triggered
> by odd user land behavior, of course, but still...)
>

Oh, we know the rules :)

>                 Linus
