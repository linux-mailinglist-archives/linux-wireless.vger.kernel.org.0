Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2710B596
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 19:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfK0SXl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 13:23:41 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45065 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0SXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 13:23:41 -0500
Received: by mail-oi1-f194.google.com with SMTP id 14so20911567oir.12
        for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2019 10:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=No21v74ZDd0gu4iS4BF16mJtDpZ4NtcVzIGEBplrTU4=;
        b=lMlSx3bSH77SfuEYgSurI6NDVd3Tyutw1QAfeeJxQ3xsxGqdyDpGRLn+2Dh5VexG87
         iJeMb3pu9b6HIE0DdtluqX3rKn7oVZOMed/WDWBPv6OnPGyHKtEEzkmQ/j1o22MKoHE3
         mS+OmXCYQ0+/JhZcbjtApV8xkppGTtrGofIA/h8QQUE1lHbjgy5wvGqCo+Yv9ywzdI5Q
         8z/uWIRNLY5DyowbbI38ASzNw4AUb+Xy4wBrg2JIZ6m34cv8wfU2SJnHX3Z1JSSUsokm
         yD6Y4g0l6C7eFJRzdp3wCKXoGuVlXhf/KGH5zPThu9ibLBLPTl/zVrcvtgCEk9ncmENJ
         0Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=No21v74ZDd0gu4iS4BF16mJtDpZ4NtcVzIGEBplrTU4=;
        b=HOX3xx5DWg0pbfUIyszGnMs03xdpKDZOCMQioZvWSLqONelhZZJcaEij28TcpoLn7v
         gYrjkdeK5kaXKkiBHzLNlrTYe9auRGVS4EW1eizPMuxbbTIr5wV48sONo36pXOwfMGFc
         QFLn2Tu4qqGRqzOxzG8tl8bJLKfG4KZQJYhs4MgCx4Ah0i4lleeOpe8aItHCt6gmupIM
         emua0oE9LIN5FjnzvvFmls93voKeawfSE6T01Sd04SYEyal0e8F+oFyUQM6vSVKkrCxo
         Wz10F40vQ2n4rVqmn1sstzzHYY5zd40tlk3thvkUJk9w9TtRrPM4dk0KeLBf0BMI4/pq
         Pp7Q==
X-Gm-Message-State: APjAAAW76ajRZEyEgXOrHr8UVKe4lscJQCWQNGqOy9/bOc8sgLjAKirl
        rEhayDocPtzy8dq+Ms5Jtd8jKrd9
X-Google-Smtp-Source: APXvYqzqIrNgM9Nnp7n4d1g4I747RsYk9yZsBEIqGdlpB0dE4OyqPXdEj3Dm0Kg45eI+JkkH74ulCg==
X-Received: by 2002:aca:5a08:: with SMTP id o8mr5101363oib.104.1574879018659;
        Wed, 27 Nov 2019 10:23:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t61sm5129050otb.21.2019.11.27.10.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Nov 2019 10:23:37 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:23:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Philip Li <philip.li@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        kbuild test robot <lkp@intel.com>, huangwenabc@gmail.com,
        kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        linux-distros@vs.openwall.org, security@kernel.org,
        libertas-dev@lists.infradead.org
Subject: Re: [kbuild-all] Re: [PATCH] libertas: Fix two buffer overflows at
 parsing bss descriptor
Message-ID: <20191127182335.GA28398@roeck-us.net>
References: <20191122052917.11309-1-huangwenabc@gmail.com>
 <201911241536.lyRxx5Oc%lkp@intel.com>
 <0101016ea290854e-f5721fd1-1ca7-49ab-9c10-85277bc46c64-000000@us-west-2.amazonses.com>
 <20191125142952.GA4090@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125142952.GA4090@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 25, 2019 at 10:29:52PM +0800, Philip Li wrote:
> On Mon, Nov 25, 2019 at 12:36:50PM +0000, Kalle Valo wrote:
> > kbuild test robot <lkp@intel.com> writes:
> > 
> > > Thank you for the patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on wireless-drivers-next/master]
> > > [also build test WARNING on v5.4-rc8 next-20191122]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > > improve the system. BTW, we also suggest to use '--base' option to specify the
> > > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/huangwenabc-gmail-com/libertas-Fix-two-buffer-overflows-at-parsing-bss-descriptor/20191124-142236
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
> > > config: sh-allmodconfig (attached as .config)
> > > compiler: sh4-linux-gcc (GCC) 7.4.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # save the attached .config to linux build tree
> > >         GCC_VERSION=7.4.0 make.cross ARCH=sh 
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    drivers/net/wireless/marvell/libertas/cfg.c: In function 'lbs_ibss_join_existing':
> > >>> drivers/net/wireless/marvell/libertas/cfg.c:1788:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> > 
> > I was wondering why I didn't see this mail in patchwork:
> > 
> > https://patchwork.kernel.org/patch/11257187/
> > 
> > And then I noticed this:
> > 
> > X-Patchwork-Hint: ignore
> > 
> > kbuild team, why are you adding that header? It's really bad for a
> thanks for the feedback, early on we received another feedback to suggest
> for adding this, refer to https://gitlab.freedesktop.org/patchwork-fdo/patchwork-fdo/issues/21
> for detail. Since there's no further input regarding this usage, we keep
> that flag. If this is not suitable, we can investigate other way to fullfill
> both requirements.
> 

I second Kalle's comment; this is really bad.

Note that the above referenced link suggested to add
	X-Patchwork-Hint: comment
to e-mail headers. Instead, you added:
	X-Patchwork-Hint: ignore
which is substantially different. Also, the problem was with a _patch_
sent by the robot, not with direct feedback. On top of that, the
suggestion was really to add "X-Patchwork-Hint: comment" to _patches_
sent by the robot, not to everything. It should be fine to add
"X-Patchwork-Hint: ignore" to patches only as long as other feedback
is still provided and added to patchwork. That should meet all
requirements.

Thanks,
Guenter

> > maintainer like me who uses patchwork actively, it means that all these
> > important warnings are not visible in patchwork and can be easily missed
> > by the maintainers.
> > 
> > -- 
> > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> > _______________________________________________
> > kbuild-all mailing list -- kbuild-all@lists.01.org
> > To unsubscribe send an email to kbuild-all-leave@lists.01.org
