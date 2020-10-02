Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA52280F28
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Oct 2020 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgJBInc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Oct 2020 04:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgJBInb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Oct 2020 04:43:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458CAC0613D0
        for <linux-wireless@vger.kernel.org>; Fri,  2 Oct 2020 01:43:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so383911pgi.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Oct 2020 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cyHevURfALJho8shvXMDJIZsswbuCyj+aZofUCdEJYo=;
        b=TeVQCifS+EQjq2pf+B8/nZMe0RvyOoGFt0XIUVKPaZTNYTgZd14oQ+yy0VrqSMS80J
         wtOukbUMHc2+vYpAzGvumsbiEB++qcfijrmiInxc2BfJKeDudFOD8QwwHU1xmbsgj5gZ
         m64Skz2zLaqG/vnqdXjmYbH+F7kqYT1aTMtNhB8+kjAlRJlB+nSpH1TPROyGm0DxkVxf
         6LbzPORCLHruqcOG4x0FzTicT2uJAISyf/Ss0TW0jdtJOgo9h5s0GSRAZpwvlT2ueJKl
         F+9R873BGv0rZn03GnSUI6vgLQqMeGLZohEB/r6/KWvy5uLuXMImyURNS3ouYTjdDoNA
         +v8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cyHevURfALJho8shvXMDJIZsswbuCyj+aZofUCdEJYo=;
        b=dU6HUvN7U6+Ll8Q/x+F0MsSK37HaVvCLQr1HC8MhxILMwu23g7rx1W6xQ0K8P1blx5
         hzG5ZG+hfdtyZFFe8Co6OF3vxK+T3D8SLwByNxK3cy67IIxTxLoxFcZ0zDR3logzKIL3
         RC8sGj6dRm2Hnw6dEYalDJ3DYZC8MyB35bdsElVfqSQdF0egPqByJsX5tXZzKuEH/exJ
         ud4/pHKWTMjYNo73bnoOVUf3kJdqaf2UWu5d1vvx2bxzOztOA2eKk/pFHqa0+2VXLZnB
         u/U9rRL18mSRctwHRQOK10I3a4o8r3u9JTiRFRwyA+N/kv1WNuS1VhKj/I9VSuukCBGJ
         QKKw==
X-Gm-Message-State: AOAM533VlH2dzImmnR+QA7ioKeM0R/5Ysat/fMO6N1UjRJnYN4SkMbla
        ycHUAegmSxmRJxQLUwBpimgPMj6Zi3zcHw==
X-Google-Smtp-Source: ABdhPJy+yIgnfOixlcz3dfhKMxRupnLpin829liDur3ARc5gs1NKJe/f34EIAHoad9OdcD8Q2RW6Bg==
X-Received: by 2002:a63:c54a:: with SMTP id g10mr1160695pgd.316.1601628209677;
        Fri, 02 Oct 2020 01:43:29 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id mt2sm900411pjb.17.2020.10.02.01.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 01:43:28 -0700 (PDT)
Date:   Fri, 2 Oct 2020 01:43:26 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     tehuang@realtek.com, yhchuang@realtek.com,
        linux-wireless@vger.kernel.org, clang-built-linux@googlegroups.com,
        arnd@arndb.de
Subject: Re: [PATCH 3/5] rtw88: add dump firmware fifo support
Message-ID: <20201002084326.GA2013042@ubuntu-m3-large-x86>
References: <20200925061219.23754-1-tehuang@realtek.com>
 <20200925061219.23754-4-tehuang@realtek.com>
 <20201001190641.GA3723966@ubuntu-m3-large-x86>
 <87d021cae2.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d021cae2.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 02, 2020 at 11:14:29AM +0300, Kalle Valo wrote:
> + arnd
> 
> Nathan Chancellor <natechancellor@gmail.com> writes:
> 
> >> +int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
> >> +		     u32 *buffer)
> >> +{
> >> +	if (!rtwdev->chip->fw_fifo_addr) {
> >
> > This causes a clang warning, which points out it is probably not doing
> > what you think it is:
> >
> > drivers/net/wireless/realtek/rtw88/fw.c:1485:21: warning: address of
> > array 'rtwdev->chip->fw_fifo_addr' will always evaluate to 'true'
> > [-Wpointer-bool-conversion]
> >         if (!rtwdev->chip->fw_fifo_addr) {
> >             ~~~~~~~~~~~~~~~^~~~~~~~~~~~
> > 1 warning generated.
> >
> > Was fw_fifo_addr[0] intended or should the check just be deleted?
> 
> BTW what is the easiest way to install clang for build testing the
> kernel? For GCC I use crosstool[1] which is awesome as it makes the
> installation so simple, do we have something similar for clang?
> 
> Just supporting x86 would be fine, as my use case would be just to
> reproduce build warnings.
> 
> [1] https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Unfortunately, we do not have anything for clang right now. It is on my
TODO list but being a hobbyist, I have less time than I would like...

If you do not mind building it from source, I maintain a Python script
that tries to optimize building LLVM as much as possible by turning off
things that the kernel does not care about so that the build is quick
and it does not intrude or interfere with the host environment.

Something like this should work to give you a stable clang toolchain
that should work well for compiling the kernel:

$ git clone https://github.com/ClangBuiltLinux/tc-build
$ tc-build/build-llvm.py \
--branch llvmorg-11.0.0-rc5 \
--projects "clang;lld"
$ tc-build/install/bin/clang --version | head -1
ClangBuiltLinux clang version 11.0.0 (https://github.com/llvm/llvm-project 60a25202a7dd1e00067fcfce512086ebf3788537)

The script by default does a 2-stage build for optimization purposes; if
you cannot spare many cycles, feel free to add

--build-stage1-only --install-stage1-only

to the build-llvm.py invocation. The toolchain is installed to "install"
within the tc-build repo and it only requires a few external
dependencies (outlined in the README) that it lets you know about before
doing anything. Feel free to give it a shot and let me know if anything
is broken. Otherwise, as long as your distribution has clang 10.0.1 or
newer, it should be fine for compiling the kernel.

Cheers,
Nathan
