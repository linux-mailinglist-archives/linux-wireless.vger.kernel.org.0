Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39FE603B3C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 10:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJSIPx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 04:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJSIPw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 04:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E722C748DE;
        Wed, 19 Oct 2022 01:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85ECC6178F;
        Wed, 19 Oct 2022 08:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6536C4347C;
        Wed, 19 Oct 2022 08:15:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D+ZvL1k/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666167346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nAmr2UAHuPsXegfCTI97bmAUTMlBsKIt74vgLb/46NU=;
        b=D+ZvL1k/WanrhMOeR+CGRXuPU/IX9UV+tXpP0nBmAVeKqBZq0aZV7xPZfPG2OiONIW0mx0
        xAkhMgP84/WjI9ijS4Wnf95X8rq3fF0LQJLvQkv8gUa2x29/gdGw9MUIgvDJ/9hk12uHjs
        0LuPLiRK3yUgkt+hfZRwt1lYiSItt8c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0df47019 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Oct 2022 08:15:46 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id a2so16976788vsc.13;
        Wed, 19 Oct 2022 01:15:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf2h1lD+Y/wK7jmgNLtwWP2tbpd+1Qi4zhxbrhBlpzVr3uWlWFYG
        JcZ3cjzW7jWmoFK1nV0KgSoDdkRUA7qXD50M1D0=
X-Google-Smtp-Source: AMsMyM67WQuIFDSYsk+FN+WbsP3JkTTE10px/GF5LeSzwj0Zm8Srjifse7EFqjgFDwdSBmVrlKmmcEzev2nVJIhpyHY=
X-Received: by 2002:a67:c297:0:b0:3a7:5f0c:54c4 with SMTP id
 k23-20020a67c297000000b003a75f0c54c4mr3705224vsj.76.1666167344375; Wed, 19
 Oct 2022 01:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <202210191553.vO9rtKe5-lkp@intel.com> <87pmeol020.fsf@kernel.org>
 <CAHmME9qFKMLJiZa=pg9bnBWHSfbgP-+yimteL_t4sxuepQ6bAg@mail.gmail.com> <CAHmME9ocXJMTmCQfi1NY+zOw-r5VCe_Z48q5VJCZxR4Hj=1oZA@mail.gmail.com>
In-Reply-To: <CAHmME9ocXJMTmCQfi1NY+zOw-r5VCe_Z48q5VJCZxR4Hj=1oZA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Oct 2022 02:15:33 -0600
X-Gmail-Original-Message-ID: <CAHmME9oeHMPjg5aCdv4d5pY_ue9ufgaS4FQkYRRWAX_E0zFtfw@mail.gmail.com>
Message-ID: <CAHmME9oeHMPjg5aCdv4d5pY_ue9ufgaS4FQkYRRWAX_E0zFtfw@mail.gmail.com>
Subject: Re: drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9439:15: warning:
 result of comparison of constant -7 with expression of type 'char' is always false
To:     Kalle Valo <kvalo@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        =?UTF-8?Q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 19, 2022 at 2:02 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Oct 19, 2022 at 1:59 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Wed, Oct 19, 2022 at 1:55 AM Kalle Valo <kvalo@kernel.org> wrote:
> > >
> > > + jason, linux-wireless
> > >
> > > kernel test robot <lkp@intel.com> writes:
> > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   aae703b02f92bde9264366c545e87cec451de471
> > > > commit: dab902fe1d29dc0fa1dccc8d13dc89ffbf633881 wifi: rt2x00: add TX
> > > > LOFT calibration for MT7620
> > > > date:   4 weeks ago
> > > > config: arm64-allmodconfig
> > > > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project
> > > > 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> > > > reproduce (this is a W=1 build):
> > > >         wget
> > > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > > > -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # install arm64 cross compiling tool for clang build
> > > >         # apt-get install binutils-aarch64-linux-gnu
> > > >         #
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dab902fe1d29dc0fa1dccc8d13dc89ffbf633881
> > > >         git remote add linus
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > >         git fetch --no-tags linus master
> > > >         git checkout dab902fe1d29dc0fa1dccc8d13dc89ffbf633881
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1
> > > > O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/
> > > > drivers/net/wireless/ralink/rt2x00/ drivers/staging/media/
> > > >
> > > > If you fix the issue, kindly add following tag where applicable
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All warnings (new ones prefixed by >>):
> > > >
> > > >>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9439:15: warning:
> > > >> result of comparison of constant -7 with expression of type 'char'
> > > >> is always false [-Wtautological-constant-out-of-range-compare]
> > > >            gerr = (gerr < -0x07) ? -0x07 : (gerr > 0x05) ? 0x05 : gerr;
> > > >                    ~~~~ ^ ~~~~~
> > > >    drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9443:15: warning: result of comparison of constant -31 with expression of type 'char' is always false [-Wtautological-constant-out-of-range-compare]
> > > >            perr = (perr < -0x1f) ? -0x1f : (perr > 0x1d) ? 0x1d : perr;
> > > >                    ~~~~ ^ ~~~~~
> > > >    2 warnings generated.
> > >
> > > I believe this patch should fix it:
> > >
> > > https://patchwork.kernel.org/project/linux-wireless/patch/20221018202734.140489-1-Jason@zx2c4.com/
> > >
> > > Jason, is my understanding correct?
> >
> > That's a different bug caused by the same pitfall: assuming char is
> > signed. I'll send a patch for that function too.
>
>
> Actually, maybe I should fix the whole file? Patch incoming.

Okay here's a v2 that handles it driver-wide:
https://lore.kernel.org/linux-wireless/20221019081417.3402284-1-Jason@zx2c4.com/
(Might take a few minutes to hit lore.)
