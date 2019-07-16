Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76FCA6B0F4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2019 23:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGPVSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jul 2019 17:18:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38584 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfGPVSq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jul 2019 17:18:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so10750925plb.5
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2019 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wditBe2WB9aM35K3GMrXkW9Eb3mbuaueCJdBg7RgTqo=;
        b=X9K+xYg/Mr3ClCkR3CqDxuRhAzJyF2hHI6uosX6UijK+QI06Ijuw9XKokVXcOns5YS
         IDW+xteWCZXWXOtj7Gs++wOEc+ERSgctlejLoSisHd+FOfZPmU34VmuoC4skJ/vsTT/d
         Cc4B8isndGmLenQdVh9wcJj61CqhS56ozkkaI2zDd0/EkNHOzfDOLH3HCSKbNtFbhmtS
         KACTj0ANGZPgztZIaj4N/J6hb2sHuEEyvH0vtJ355dX7UnDjh+ZVKrMJe0bFADBjzk6Z
         Oy8eHGeyeZt2W7zeGitJMtYPSW4WfO3z1/rjeIncFZs8kGN2YRKAy0C4DAJ5nyu4fyZs
         xWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wditBe2WB9aM35K3GMrXkW9Eb3mbuaueCJdBg7RgTqo=;
        b=tLAB/VNo95zc3ZGI4TcCONNBhtfg1eaKHZ3D5YGwBiblHO3pyT3L0D9gf5M5n/Mjau
         C9JZJyFetHhRYAEefvlw5WhU4+f4FBgTkOcp747SoGPuzAMR4jyXarzshG6SPMxVoXVj
         72GFfXmNhPtPN9EKpE6Ky6Q8h03tJpdPJ0IQQQBO8WVP4mcuOM45WKyyEF31JTOcbVGh
         CCm80HXhxmMZimw1gLQ7KbbpfjP1/rf1LMpcTMMSouOTLjwhRpry43eel5Rx1lD6zOah
         ep50twqum7DmbrJ36FN91t+iF+QCUKCx3GbCvN+AfHxVmWeLxc6yc2it3sx1HPadP1od
         a8Ag==
X-Gm-Message-State: APjAAAX2GaA03mAIQu3Y8d21BO79RpD5UeQ7ToULnWHjR0/SeyAi3roS
        oJ/VvvSODekLwXoOdocMaTP8ol5otzI5qkOsVmxppw==
X-Google-Smtp-Source: APXvYqwnrM8Dl51SpyXviMrSa+uzxfaYffLjasQcMHtS4jfkOiBYk4on4eI7l3qvvzGgbLP0rZBUES5yd9h3RCu6nVk=
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr37579561pls.179.1563311925137;
 Tue, 16 Jul 2019 14:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190712001708.170259-1-ndesaulniers@google.com>
 <b219cf41933b2f965572af515cf9d3119293bfba.camel@perches.com>
 <CAKwvOdkD_r2YBqRDy-uTGMG1YeRF8KokxjikR0XLkXLsdJca0g@mail.gmail.com> <da053a97d771eff0ad8db37e644108ed2fad25a3.camel@coelho.fi>
In-Reply-To: <da053a97d771eff0ad8db37e644108ed2fad25a3.camel@coelho.fi>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Jul 2019 14:18:33 -0700
Message-ID: <CAKwvOd=YjXANsb7FNP03u8gMYs=WD9N_kW23j7kk1Xe6uqzVbw@mail.gmail.com>
Subject: Re: [PATCH -next] iwlwifi: dbg: work around clang bug by marking
 debug strings static
To:     Luca Coelho <luca@coelho.fi>
Cc:     Joe Perches <joe@perches.com>, Kalle Valo <kvalo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 16, 2019 at 2:15 PM Luca Coelho <luca@coelho.fi> wrote:
>
> On Tue, 2019-07-16 at 10:28 -0700, Nick Desaulniers wrote:
> > On Thu, Jul 11, 2019 at 7:15 PM Joe Perches <joe@perches.com> wrote:
> > > Better still would be to use the format string directly
> > > in both locations instead of trying to deduplicate it
> > > via storing it into a separate pointer.
> > >
> > > Let the compiler/linker consolidate the format.
> > > It's smaller object code, allows format/argument verification,
> > > and is simpler for humans to understand.
> >
> > Whichever Kalle prefers, I just want my CI green again.
>
> We already changed this in a later internal patch, which will reach the
> mainline (-next) soon.  So let's skip this for now.

Ok, but this has now regressed into mainline and is blocking Linaro's
ToolChain Working Group's CI, so if you could send a bugfix ASAP we'd
appreciate it.
-- 
Thanks,
~Nick Desaulniers
