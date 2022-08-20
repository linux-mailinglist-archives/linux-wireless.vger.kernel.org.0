Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC259AF1C
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Aug 2022 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242940AbiHTRRw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Aug 2022 13:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTRRv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Aug 2022 13:17:51 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596EB183BC
        for <linux-wireless@vger.kernel.org>; Sat, 20 Aug 2022 10:17:49 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id p187so652865oia.9
        for <linux-wireless@vger.kernel.org>; Sat, 20 Aug 2022 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=oMiT5WAAOMj/UYuAONXZf9Dtn7cx074PEUg5rCYS5MI=;
        b=bqdfkx39R9tG/HMHTrcGfAI6nQFYWtq0TyqCoQDV8t7PYfrz/Omq9SUGUrWdtZ2FcF
         qf+QjR/EIlz3ilaIbYPgKRjflJl66yryjjA1FdaRr9Bt+Uqu36ldFX2EDcm1Typc0Zm2
         lrL774WsAOmuMSeZOhuas9FylQwd/O6pOeuppDbwOovHl+mCtEcMZfrGN5+s7eiHzZBT
         F3Uuk0AMeds4RJDsBpnJODCo7z5Fm3BnE5du34C2BU7ijgkUq11ek0ZCu2wnpg0oLlkI
         dzuAZFKq9IPn2TKOUJ8DXcWMsJ08869YaL7OzLcM7JH4oNRcVFIPjgkCmwCurH4CwEG8
         nHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=oMiT5WAAOMj/UYuAONXZf9Dtn7cx074PEUg5rCYS5MI=;
        b=2GnNJ3W3DUfLVHyXegwggJBMhamoxC+C2dcNuLxiwEEOKYGJXjFyq8fpHSzA/svZ2X
         ee/dfCy/BECYlE052svavqw3FzbGA0CmWb0GKwsWA/IBszsyaPsY2W6LefFjQkprJfZ4
         SY2MGo+VjgFlGCcYPTpwFABKVF0WtZe3JHPjG5ak6oPI3TqpJ0p4LYkt1qWQFSVluh7C
         TKQb5/YYGqukQW+WgMZ8XeyQJ/4+fCa/Jd/MgItGMFegyxUoR6yTBnGdkcNaGIFHi4LA
         jw1+0jWdFJvopcMPLAbYeF13hh+CPcembjR4tHYZOf3pMXSXl+ubziEA8Xbt3n9lzjkW
         T2bA==
X-Gm-Message-State: ACgBeo3glu4UWEZXxdkoRps0o3ZpuPx5flTu78uvBnuR1rPxp2HSIaEb
        D36uZJ6mYioJLb8q5O/zMu23P0Ay0lQ=
X-Google-Smtp-Source: AA6agR65cjDeWmHyVFhIuc8MO619+Mj7vG0pl6QK61QGImyILNvxJIAq3OLHuUjErBXmlamwYh31HQ==
X-Received: by 2002:a05:6808:238e:b0:345:3564:2a49 with SMTP id bp14-20020a056808238e00b0034535642a49mr2914079oib.221.1661015868610;
        Sat, 20 Aug 2022 10:17:48 -0700 (PDT)
Received: from [10.62.118.101] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id f15-20020a056870d14f00b0010e73e252b8sm2092341oac.6.2022.08.20.10.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 10:17:48 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6c577187-7b25-469b-23d3-d95a869fe99e@lwfinger.net>
Date:   Sat, 20 Aug 2022 12:17:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: wifi problem
Content-Language: en-US
To:     bommy985 <turkenlurken@gmail.com>, linux-wireless@vger.kernel.org
References: <CAPwNHCEkdnXbp+EdJ0+e6AbwLy=fBiSnzHDwmOBezwMUd1dzfw@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAPwNHCEkdnXbp+EdJ0+e6AbwLy=fBiSnzHDwmOBezwMUd1dzfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/20/22 22:06, bommy985 wrote:
> I have a laptop with a rtw8852be wifi card, and i was using your
> driver to get wifi on my system, come an update, I was required to
> redo the installation in order to have it again. however, when doing
> sudo make install,
> make -C /lib/modules/5.19.2-arch1-1/build M=/home/bommy/rtw8852be modules
> make[1]: Entering directory '/usr/lib/modules/5.19.2-arch1-1/build'
> make[1]: Leaving directory '/usr/lib/modules/5.19.2-arch1-1/build'
> make -C /lib/modules/5.19.2-arch1-1/build M=/home/bommy/rtw8852be modules
> make[1]: Entering directory '/usr/lib/modules/5.19.2-arch1-1/build'
> make[1]: Leaving directory '/usr/lib/modules/5.19.2-arch1-1/build'
> cp: cannot stat 'rtl8852au*.bin': No such file or directory
> 
>   this is the only logging that is produced, doing sudo make install -B
> when i do a B flag
> [bommy@bommy-laptop rtw8852be]$ sudo make install -B
> make -C /lib/modules/5.19.2-arch1-1/build M=/home/bommy/rtw8852be modules
> make[1]: Entering directory '/usr/lib/modules/5.19.2-arch1-1/build'
>   CC [M]  /home/bommy/rtw8852be/core.o
>   CC [M]  /home/bommy/rtw8852be/mac80211.o
>   CC [M]  /home/bommy/rtw8852be/mac.o
>   CC [M]  /home/bommy/rtw8852be/phy.o
>   CC [M]  /home/bommy/rtw8852be/fw.o
>   CC [M]  /home/bommy/rtw8852be/cam.o
>   CC [M]  /home/bommy/rtw8852be/efuse.o
>   CC [M]  /home/bommy/rtw8852be/regd.o
>   CC [M]  /home/bommy/rtw8852be/sar.o
>   CC [M]  /home/bommy/rtw8852be/coex.o
>   CC [M]  /home/bommy/rtw8852be/ps.o
>   CC [M]  /home/bommy/rtw8852be/debug.o
>   CC [M]  /home/bommy/rtw8852be/ser.o
>   LD [M]  /home/bommy/rtw8852be/rtw89core.o
>   CC [M]  /home/bommy/rtw8852be/rtw8852a.o
>   CC [M]  /home/bommy/rtw8852be/rtw8852a_table.o
>   CC [M]  /home/bommy/rtw8852be/rtw8852a_rfk.o
>   CC [M]  /home/bommy/rtw8852be/rtw8852a_rfk_table.o
>   LD [M]  /home/bommy/rtw8852be/rtw_8852a.o
>   CC [M]  /home/bommy/rtw8852be/rtw8852ae.o
>   LD [M]  /home/bommy/rtw8852be/rtw_8852ae.o
>   CC [M]  /home/bommy/rtw8852be/pci.o
>   LD [M]  /home/bommy/rtw8852be/rtw89pci.o
> WARNING: Symbol version dump "Module.symvers" is missing.
>          Modules may not have dependencies or modversions.
>          You may get many unresolved symbol warnings.
>   MODPOST /home/bommy/rtw8852be/Module.symvers
>   CC [M]  /home/bommy/rtw8852be/rtw89core.mod.o
>   LD [M]  /home/bommy/rtw8852be/rtw89core.ko
>   BTF [M] /home/bommy/rtw8852be/rtw89core.ko
>   CC [M]  /home/bommy/rtw8852be/rtw89pci.mod.o
>   LD [M]  /home/bommy/rtw8852be/rtw89pci.ko
>   BTF [M] /home/bommy/rtw8852be/rtw89pci.ko
>   CC [M]  /home/bommy/rtw8852be/rtw_8852a.mod.o
>   LD [M]  /home/bommy/rtw8852be/rtw_8852a.ko
>   BTF [M] /home/bommy/rtw8852be/rtw_8852a.ko
>   CC [M]  /home/bommy/rtw8852be/rtw_8852ae.mod.o
>   LD [M]  /home/bommy/rtw8852be/rtw_8852ae.ko
>   BTF [M] /home/bommy/rtw8852be/rtw_8852ae.ko
> make[1]: Leaving directory '/usr/lib/modules/5.19.2-arch1-1/build'
> cp: cannot stat 'rtl8852au*.bin': No such file or directory
> 
> this is produced
> 
> 
> it should be noted that when trying to modprobe it
> [bommy@bommy-laptop rtw8852be]$ sudo modprobe -v 8852be
> insmod /lib/modules/5.19.2-arch1-1/kernel/drivers/net/wireless/8852be.ko
> modprobe: ERROR: could not insert '8852be': Exec format error
> [bommy@bommy-laptop rtw8852be]$ ^C
> this is produced
> 
> it should be noted that no errors are seen in the make process
> [bommy@bommy-laptop rtw8852be]$ make
> make -C /lib/modules/5.19.2-arch1-1/build M=/home/bommy/rtw8852be modules
> make[1]: Entering directory '/usr/lib/modules/5.19.2-arch1-1/build'
>   CC [M]  /home/bommy/rtw8852be/core.o
>   CC [M]  /home/bommy/rtw8852be/mac80211.o
>   CC [M]  /home/bommy/rtw8852be/mac.o
>   CC [M]  /home/bommy/rtw8852be/phy.o
>   CC [M]  /home/bommy/rtw8852be/fw.o
>   CC [M]  /home/bommy/rtw8852be/cam.o
>   CC [M]  /home/bommy/rtw8852be/efuse.o
>   CC [M]  /home/bommy/rtw8852be/regd.o
>   CC [M]  /home/bommy/rtw8852be/sar.o
>   CC [M]  /home/bommy/rtw8852be/coex.o
>   CC [M]  /home/bommy/rtw8852be/ps.o
>   CC [M]  /home/bommy/rtw8852be/debug.o
>   CC [M]  /home/bommy/rtw8852be/ser.o
>   LD [M]  /home/bommy/rtw8852be/rtw89core.o
>   CC [M]  /home/bommy/rtw8852be/rtw8852a.o
>   CC [M]  /home/bommy/rtw8852be/rtw8852a_table.o
>   CC [M]  /home/bommy/rtw8852be/rtw8852a_rfk.o
>   CC [M]  /home/bommy/rtw8852be/rtw8852a_rfk_table.o
>   LD [M]  /home/bommy/rtw8852be/rtw_8852a.o
>   CC [M]  /home/bommy/rtw8852be/rtw8852ae.o
>   LD [M]  /home/bommy/rtw8852be/rtw_8852ae.o
>   CC [M]  /home/bommy/rtw8852be/pci.o
>   LD [M]  /home/bommy/rtw8852be/rtw89pci.o
>   MODPOST /home/bommy/rtw8852be/Module.symvers
>   CC [M]  /home/bommy/rtw8852be/rtw89core.mod.o
>   LD [M]  /home/bommy/rtw8852be/rtw89core.ko
>   BTF [M] /home/bommy/rtw8852be/rtw89core.ko
>   CC [M]  /home/bommy/rtw8852be/rtw89pci.mod.o
>   LD [M]  /home/bommy/rtw8852be/rtw89pci.ko
>   BTF [M] /home/bommy/rtw8852be/rtw89pci.ko
>   CC [M]  /home/bommy/rtw8852be/rtw_8852a.mod.o
>   LD [M]  /home/bommy/rtw8852be/rtw_8852a.ko
>   BTF [M] /home/bommy/rtw8852be/rtw_8852a.ko
>   CC [M]  /home/bommy/rtw8852be/rtw_8852ae.mod.o
>   LD [M]  /home/bommy/rtw8852be/rtw_8852ae.ko
>   BTF [M] /home/bommy/rtw8852be/rtw_8852ae.ko
> make[1]: Leaving directory '/usr/lib/modules/5.19.2-arch1-1/build'
> 
>   this log is produced, which dosent look like errors on my end, but
> interpret that as
> you will
> 
> 
> please fix this...or lead me somewhere where i can, i use this laptop
> for school where i cant carry an ethernet cable around...
> thanks for driver
> bommy


That was my mistake. I removed the BT firmware from rtw89 as it belongs in the 
rtw89-BT repo that I also maintain, but I forgot the copy in the Makefile.

Do a 'git pull' and 'sudo make install' again. It will now work.

As to the error you get when loading a module. That usually means that your 
kernel headers do not match your running kernel, but you need to look at the 
output of the dmesg command to tell for sure.

Larry

