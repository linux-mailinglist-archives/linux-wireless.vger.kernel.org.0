Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B58F7E9267
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 21:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjKLUCM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 15:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKLUCL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 15:02:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D911FFB
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 12:02:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9e623356d5dso327042466b.3
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 12:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699819327; x=1700424127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hHzinFDvhQfCEmbllZpgf+nGVEeFpAyDqoTWQyqM2UU=;
        b=lVAjKMCmnzo1yMZoqGhDrv6B7ZXTzWuqdvsuG8uHsHmZtwf1Yvy6DJxC8V33qWnbC2
         XlNgfor6aPxzyrw2k5WX1m850w1xXxdMONdSjymMS5L16QSYLjPzSX3pU1t3UQsEiGRU
         or9Z01H1R4OPMUt0yyPx53528HSbNA6h3kjE5d8id5Zz+AEPSp9PycyBPlL7b30xK09X
         RVDExwy/ac6MpNhlFJvXBGPauIzpz6hs5lVM70GdYoShxAH+LvL+aAilDsCuAkXQynD1
         30aGsM4yCV9j+kjVMZ9FYPbuHQdLXscYwKqgoJrwSHZ733JwEPvEomL4FAVeerSbTLpf
         0f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699819327; x=1700424127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHzinFDvhQfCEmbllZpgf+nGVEeFpAyDqoTWQyqM2UU=;
        b=TAUhpKv3tKHIe8ppLqNQK/87tSB/FR2GgAIahJPp9g/1Fk4R21oS86Ul9m17BecSoV
         ZmQs1rypdoEscgBSe9ATxZuFWcH1ZNlr/VHg4/NVbijcRqe1aWFhZjKgaczg7rkH0Qsl
         qNAMuUgA/t/FeGSom9Bd9rjG1kqzYFTnId+9oUVkno3/a1sKFDjhnaKylYYiWrdZWL88
         z70+Y3eIGHdOTcxK857hRB+3izWJ1robpiVMLmKIuFcuFJkENdbkhcwgrYF0WJDCmg1D
         GIjdbhE9dxC6QlkgjCgkZKo7rbIsxf3KqptZCjKx3EBsmFR+8+tred/C8OAcfuTpm2Ev
         Pn/g==
X-Gm-Message-State: AOJu0Yyee79B0cSaNeQxl4ULsXWaBv4FzzCJJM5ljUitSRW/7lOy02r8
        6MhO4iHFOZtflcB1vLG1bYtv/ruAynVtLdQ+84U=
X-Google-Smtp-Source: AGHT+IGu7e1kyFwejfvWrFdXehMYNQxqtHwD6vcn7TMv2clCGO8Vb1mOj9rGFsW8VnRyo6XRqLWIKyvtRt2ievk4s7U=
X-Received: by 2002:a17:906:b817:b0:9e6:59d5:7aa6 with SMTP id
 dv23-20020a170906b81700b009e659d57aa6mr3430166ejb.64.1699819325900; Sun, 12
 Nov 2023 12:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20231112095943.19353-1-emmanuel.grumbach@intel.com>
 <20231112143620.36619-1-emmanuel.grumbach@intel.com> <875y26ajks.fsf@kernel.org>
 <CAHk-=wgyG-8ehCc4C4V-b-8rBtfyd9ApDeQSx-5BKRaHywhVpw@mail.gmail.com> <CANUX_P0kDV6PC5=+oxgnVetMR+kERqCMsVju22mBqcW5bED8sA@mail.gmail.com>
In-Reply-To: <CANUX_P0kDV6PC5=+oxgnVetMR+kERqCMsVju22mBqcW5bED8sA@mail.gmail.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Sun, 12 Nov 2023 22:01:54 +0200
Message-ID: <CANUX_P31JV2QDm=puUyNhJxArB5UGW2aBnwp-YMVnu_xfDjMHg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> >
> > However, now that I don't have that big warning in there, I do note
> > another iwlwifi issue that is new to this meger window:
> >
> >   debugfs: Directory 'iwlmvm' with parent 'netdev:wlo2' already present!
> >   iwlwifi 0000:45:00.0: Failed to create debugfs directory under netdev:wlo2
> >   debugfs: Directory 'iwlmvm' with parent 'netdev:wlo2' already present!
> >   iwlwifi 0000:45:00.0: Failed to create debugfs directory under netdev:wlo2
> >
> > and looking at my system logs, this is new.
> >
> > It looks like it is probably due to
> >
> >   c36235acb34f ("wifi: iwlwifi: mvm: rework debugfs handling")
> >   e9dd25550770 ("wifi: iwlwifi: mvm: add a per-link debugfs")
> >
> > but that's just from looking at the patches (ie no bisection or any
> > real effort).
>
> Don't bother, we'll take a look.

Miri sent me fixes that we have in our internal tree that have not yet
been published.
The fixes were made during the merge window.
I can send them here, but I think I'd prefer to let those patches go
through the regular
pipes. Also, I'd prefer the people who usually interact with the trees
handle that. Gregory
was OOO today and that's why I chimed in. Miri is still ramping up.
If it's really urgent, I can send the fixes though.

>
> >
> > This is after the system has come up, so I assume it's when
> > networkmanager or whatever actually is setting that wireless thing up.
>
> Most likely the network-manager brings the device up several times or something
> like that, but let's not blame them before we check what happens internally.
>
> >
> > Again: I actually don't *use* the WiFi on this machine - but from a
> > quick check it does seem to work. So this is just an annoyance and a
> > sign that somebody didn't do all the details right (possibly triggered
> > by odd user land behavior, of course, but still...)
> >
>
> Oh, we know the rules :)
>
> >                 Linus
