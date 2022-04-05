Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF504F53C2
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 06:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455932AbiDFDMC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Apr 2022 23:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454034AbiDEP5u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Apr 2022 11:57:50 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F3167F8E
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 08:03:01 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-d6ca46da48so14639600fac.12
        for <linux-wireless@vger.kernel.org>; Tue, 05 Apr 2022 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/WeqeqXC6BXYo1pJqD9CNBUUl9OFyWmWbFYxNLGDQHI=;
        b=bQukCczxFTy/nyTkXP0QiIbXJ65RiCMy2RGaZ2YF2bzbKJhyB8438iEcdN24lSV7WJ
         crzZJHtlCFdqB10/RaxDK8HCHc3gj9IG1QFkjyXFxVL9+uqMGfB2dwWBc7MrwwMJxoxz
         u09XT3dgTZ1beuRrNgb3DGyuJyXbCOBes9eWTkIM4en0hl4YEBynXGHCsp15XuKAGY2b
         /wVmYgjHEGD3EwviJIkkypHQzk4QqruU8zYY4YMsuQw1WHmdSNcJcZt/zY0ykKImJf9+
         NWy7hlvYRorDHLgtxFLQZB5y6svec40sethw88hoW5QNyunh+iVmjh3ztbGvZvMwJ45I
         Wmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/WeqeqXC6BXYo1pJqD9CNBUUl9OFyWmWbFYxNLGDQHI=;
        b=SILvHEcTHENHyxpqps2F5m2rzEI7THwYBkdmhsJUdue5eWjDQJ4Wer+nW6HURnkin8
         LHn2NhYA3iA9NGfLXptlgbpj2AFov7OLicxqHP0IHvLESLrDNabipUnbf9xY9EaKS7IR
         nj5O7rtttTY10BVFQoxxDnErytVy4kI/XEYrRpVg8R8ODGYGuMoTgIt9LJ+XUxaH7IPs
         ud3u1hsnJqFkCDRF9aCd5uMxMTRs7eLn89h+4/Fxzk2mtY5jeL9FVW2owEjpf0qxWM8k
         zWrdNHODUyi+RAVzUL7bqBB9NvyXI6KGjTheS76SZKmk3na9eegppB/hZf+iy+fyHFgT
         yXag==
X-Gm-Message-State: AOAM530rzImQ6vSeS3qb5wHyY0O+cbERdfWQsgztq1uOV5o1K8gCieEO
        aELqwixmFwt8NBxu0wCZAV0=
X-Google-Smtp-Source: ABdhPJx1RS2czUvlPYXgLqNNr0WKtbFxWTRwTbBUmMCYrGa7dlW692hqmrZE0kLTFVXtiqS5KTElSQ==
X-Received: by 2002:a05:6870:2184:b0:e1:e0bf:3436 with SMTP id l4-20020a056870218400b000e1e0bf3436mr1663789oae.156.1649170980851;
        Tue, 05 Apr 2022 08:03:00 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1004? (2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com. [2603:8090:2005:39b3::1004])
        by smtp.gmail.com with ESMTPSA id 12-20020a05687012cc00b000de97cc1beesm5586428oam.43.2022.04.05.08.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 08:03:00 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4032c417-fb57-c253-63e5-94a9c3f605bd@lwfinger.net>
Date:   Tue, 5 Apr 2022 10:02:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: rtw_8822ce wifi regression after kernel update from 5.15 to 5.16
Content-Language: en-US
To:     "G. P. B." <george.banyard@gmail.com>
Cc:     snecknico@gmail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, regressions@leemhuis.info,
        regressions@lists.linux.dev, tony0620emma@gmail.com
References: <CAFPFaMLHXhHMhuAuvXWHb3c-tX_9qRxsquEUHXY0fMxh_VsKtw@mail.gmail.com>
 <ba45934b-69ab-edfa-1679-2e8e00fac126@lwfinger.net>
 <CAFPFaMKpwmGqc_Cm1fv4psR6m+waax6YZO2ugOPhgmnG4mGJ4A@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAFPFaMKpwmGqc_Cm1fv4psR6m+waax6YZO2ugOPhgmnG4mGJ4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/5/22 06:39, G. P. B. wrote:
> On Mon, 4 Apr 2022 at 15:49, Larry Finger <Larry.Finger@lwfinger.net 
> <mailto:Larry.Finger@lwfinger.net>> wrote:
> 
>     George,
> 
>     I do not know of any regression in 5.16 with regard to the driver for
>     RTL8822CE.
>     Certainly, I saw no regressions in my testing of that driver from before it was
>     in the kernel up to the present. That said, I can only comment on the
>     user-space
>     part of openSUSE Tumbleweed, which is probably not your distro of choice.
> 
>     Are you using the drivers at https://GitHub.com/lwfinger/rtw88.git
>     <https://GitHub.com/lwfinger/rtw88.git> rather than
>     the ones in the kernel? Your posted errors that refer to rtw_8822ce indicate
>     that to be true. If the drivers came from the kernel, the reference would be to
>     rtw88_8822ce! If so, do a 'git pull' to get the drivers updated to match the
>     code in kernel 5.18. A lot of things have been fixed.
> 
>     In your system, please do a 'lsmod | grep rtw'. If any items refer to rtw88_*,
>     you have mixed drivers loaded. In that case, you should blacklist the rtw88_*
>     driver.
> 
>     Larry
> 
> 
> I haven't had time to rollback to 5.15 to check if this fixes the issue but I 
> have the following command line output:
> [girgias@fedora ~]$ lsmod | grep rtw
> rtw88_8822ce           16384  0
> rtw88_8822c           483328  1 rtw88_8822ce
> rtw88_pci              28672  1 rtw88_8822ce
> rtw88_core            167936  2 rtw88_pci,rtw88_8822c
> mac80211             1175552  2 rtw88_pci,rtw88_core
> cfg80211             1036288  2 rtw88_core,mac80211
> 
> Which if I understand your email correctly means I have mixed drivers?
> I personally did not start to use the drivers you provide on GitHub as I just do 
> dnf update to update my packages.
> Therefore, does this implies there is an issue with how Fedora is packaging the 
> WiFi drivers?
> 
> If I need to blacklist drivers, I imagine I need to do this at the package 
> manager level?

George,

No, you have the in-kernel version - the rtw drivers all start with "rtw88".

Your "regression" between 5.15 and 5.16 is that you switched from the GitHub 
repo to the in-kernel drivers. There have been many improvements in the kernel 
version since 5.16. Those are included in the GitHub version. One or more of 
them helped your system. I am not that familiar with fedora, but to get the 
kernel versions of the drivers, it is not necessary to "dnf" anything other than 
the kernel itself. All the in-kernel drivers come along with it.

Blacklisting is done by creating (as root) a blacklist file in /etc/modprobe.d/, 
not in the package manager. It is at a much lower level. On my system is such a 
file named /etc/modprobe.d/60-blacklist-rtw8822c.conf with contents of:
blacklist rtw88_8822ce
blacklist rtw88_8822c
blacklist rtw88_pci
blacklist rtw88_core

With this file, I am assured that only the drivers from GitHub will be loaded.

Larry

