Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EDE1D19DF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 17:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbgEMPsv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730745AbgEMPsu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 11:48:50 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD760C061A0C;
        Wed, 13 May 2020 08:48:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id p12so145695qtn.13;
        Wed, 13 May 2020 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a4M2yE/LvZzKzcdH/Vo/rs9OEGWzJq6qycWPQYwHrqc=;
        b=nsrZe/81FgA86nEtwq4HUuET2fgc4F0lgzeft+Vo0sFy2ULv5AnbdSf1l0U7mPmmt+
         Zoh8R6KZbRFsq8II4Gzgg415hdtj70YW7rogr8Bb1OF/FG89HcWVqAkY49y5NhEZ0hkW
         Qo3lTtemuQ4K5V6e7iPD63PPDgLpvunp+LEiarwew7fowa6hUkuGUB9QJgO+MjHrmefv
         z7GtyW3JcT+q2pQE1rHww0h/FHbnTjK5CC086hRV+7I7zKbA3TvFZnXbVNqq3+0eYOuL
         xTAZV0LSYJTvqaYA85YJ2ClpwRUrklrzAiZFYe07hMYhq8eDZDYs4q3FCDgJFX9fS1md
         TIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a4M2yE/LvZzKzcdH/Vo/rs9OEGWzJq6qycWPQYwHrqc=;
        b=f7oU2lfJHFzZIj9R3ivamyZxlPE3/j4WsX3M0dSQi3UUgXkeKKX/5M0Q+oAIaUncF1
         5G9wjlYxmtdjnopgcRy9qO+OoHySIid+jMuM3jaa6HohvXKMS8RvdlZwd3wRjF3oxRyA
         XzgaIpC+tQHziokL1p45CoYQ5PRuM1D6F63EpftGhT32cN1kuXdgXvXjocCAG6Um/AAU
         g7ir2CwAzFXdMOCzDkqJ20cUvaDTu3G/T9WPHemOH/uQxHuqFJXjcQ1YZNTe8Cah4r+5
         +xWoV2rYf8CHdCBWxQGvkxc78zQQ0tLzn+M/BdqU2/NDSMNWaDRcMj7gOKZrj7a1JQRP
         BbEQ==
X-Gm-Message-State: AGi0PuZ4EdbbPz5H3PWGTGPWRyhlxRHVkYWBET7LjIdtrVda+/KtgL1Y
        3WGqSLMpPL4Yo8DMQGnb3OyQkS05uQA=
X-Google-Smtp-Source: APiQypIsMUb5rg7kG03tZ/dd/Uii9pE6b9tqrAxaZZQbFYehQxT9OqSxQQSOin0jFmmu+h/4TaILeA==
X-Received: by 2002:aed:30ad:: with SMTP id 42mr27709261qtf.88.1589384929906;
        Wed, 13 May 2020 08:48:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n123sm175213qkf.23.2020.05.13.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:48:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 13 May 2020 11:48:47 -0400
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
Message-ID: <20200513154847.GA158356@rani.riverdale.lan>
References: <20200509120707.188595-1-arnd@arndb.de>
 <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 09:50:03AM +0300, Kalle Valo wrote:
> (trimming CC, changing title)
> 
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
> > Kalle Valo <kvalo@codeaurora.org> writes:
> >
> >> Arnd Bergmann <arnd@arndb.de> writes:
> >>
> >>> gcc-10 correctly points out a bug with a zero-length array in
> >>> struct ath10k_pci:
> >>>
> >>> drivers/net/wireless/ath/ath10k/ahb.c: In function 'ath10k_ahb_remove':
> >>> drivers/net/wireless/ath/ath10k/ahb.c:30:9: error: array subscript 0
> >>> is outside the bounds of an interior zero-length array 'struct
> >>> ath10k_ahb[0]' [-Werror=zero-length-bounds]
> >>>    30 |  return &((struct ath10k_pci *)ar->drv_priv)->ahb[0];
> >>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> In file included from drivers/net/wireless/ath/ath10k/ahb.c:13:
> >>> drivers/net/wireless/ath/ath10k/pci.h:185:20: note: while referencing 'ahb'
> >>>   185 |  struct ath10k_ahb ahb[0];
> >>>       |                    ^~~
> >>>
> >>> The last addition to the struct ignored the comments and added
> >>> new members behind the array that must remain last.
> >>>
> >>> Change it to a flexible-array member and move it last again to
> >>> make it work correctly, prevent the same thing from happening
> >>> again (all compilers warn about flexible-array members in the
> >>> middle of a struct) and get it to build without warnings.
> >>
> >> Very good find, thanks! This bug would cause all sort of strange memory
> >> corruption issues.
> >
> > This motivated me to switch to using GCC 10.x and I noticed that you had
> > already upgraded crosstool so it was a trivial thing to do, awesome :)
> >
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> And now I have a problem :) I first noticed that my x86 testbox is not
> booting when I compile the kernel with GCC 10.1.0 from crosstool. I
> didn't get any error messages so I just downgraded the compiler and the
> kernel was booting fine again. Next I decided to try GCC 10.1 with my
> x86 laptop and it also failed to boot, but this time I got kernel logs
> and saw this:
> 
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_secodary+0x178/0x180
> 

See https://lore.kernel.org/lkml/20200423161126.GD26021@zn.tnic/
