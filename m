Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3130146B4C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 22:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFNUy3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 16:54:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36149 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfFNUy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 16:54:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so2119457pfl.3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKHkgrIbFIJQCw8wD1XxUrC5d565aFWlPJdUMDKpdyQ=;
        b=UYNvvqHsSN3OaOxZAwJbcHL/kAM6bZCt067wRLaW4K0iLAEnyEuF49dvaz4R2zUK11
         7rG44DxDakEJrq1wsGwvd3paGg/qc/a2juliCIwXm3mrmA0s+IpB93Q0zFwd5ntNN1JC
         DDiqbbQ4uHNrbwHy8I+7jSU82ex56I/A91uD186Frx7w406ZHmXMf69GhoL6OFtnBZfs
         81sTgsbYzCOXOuUJ9Ug6qekjUNk+wtcozA3VKnwDhvQO4HHPEoiS9x+4nftynLX3XOpu
         k/y7UnfgwWcCh0eMSL2wPUzWbe5Pl0H92YIhGvtJ6UTckOAUReRQu1mYr0xEqcVLnhXi
         i8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKHkgrIbFIJQCw8wD1XxUrC5d565aFWlPJdUMDKpdyQ=;
        b=gbJTzYFJtSYCGOp7VgEwLTN/YJW4olnCG/xOl2In8x7MUGo1jPmtgc2cnvv+XoG2EV
         /w3I2UDmgCaCRftN1+k139rn3EndO+q4QlLBJRylWZvuR6JTUf/Wsx2d+86mLw6uIab3
         9QoA8We4kPQBDf/ILdaWaU9WtVn5XxCto6lWextyEbRNMvuKvREQ4YDHm8x7A1S7hjS0
         Yeu/2mNPamAQ6R4eurYkawhoUHxLEyTO4OdpH7vkIEVrczpKBqTPk6jzJE+bTgd7WboO
         c1D+dRpzcqQVygQvvK5i1QQIFYFep70UhxtEs/Eut+fbCX1u28V2OVzQ2aE3RJjJr6DH
         aoLg==
X-Gm-Message-State: APjAAAWVIt5qe6tJI3j7aYBemxzav5RV/Bygp6R7llLBCFe7M6dZdTiX
        Kp6epEuMHIpwb+SUNmiiRf+z+2qXnjC2TzR6Zh71kg==
X-Google-Smtp-Source: APXvYqxJQiLj537BJ3ZR5Sc93ULFhtds6hlQxqUz2ekknc3TBei1vqS5haeJD3AIue6VRnuxGWBLCLJqsyCPEP1Wv9Y=
X-Received: by 2002:a63:306:: with SMTP id 6mr24636738pgd.263.1560545667771;
 Fri, 14 Jun 2019 13:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190614171713.89262-1-nhuck@google.com>
In-Reply-To: <20190614171713.89262-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Jun 2019 13:54:16 -0700
Message-ID: <CAKwvOd=jFYn=7NGPD8UDx3_g30qD+40bCjzmWJJSzmb6pNUusQ@mail.gmail.com>
Subject: Re: [PATCH] wl18xx: Fix Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>, eliad@wizery.com,
        arik@wizery.com
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 14, 2019 at 10:17 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Clang produces the following warning
>
> drivers/net/wireless/ti/wl18xx/main.c:1850:43: warning: unused variable
> 'wl18xx_iface_ap_cl_limits' [-Wunused-const-variable] static const struct
> ieee80211_iface_limit wl18xx_iface_ap_cl_limits[] = { ^
> drivers/net/wireless/ti/wl18xx/main.c:1869:43: warning: unused variable
> 'wl18xx_iface_ap_go_limits' [-Wunused-const-variable] static const struct
> ieee80211_iface_limit wl18xx_iface_ap_go_limits[] = { ^
>
> The commit that added these variables never used them. Removing them.

Previous thread, for context:
https://groups.google.com/forum/#!topic/clang-built-linux/1Lu1GT9ic94

Looking at drivers/net/wireless/ti/wl18xx/main.c, there 4 globally
declared `struct ieee80211_iface_limit` but as your patch notes, only
2 are used.  The thing is, their uses are in a `struct
ieee80211_iface_limit []`.

Looking at
$ git blame drivers/net/wireless/ti/wl18xx/main.c -L 1850
points to
commit 7845af35e0de ("wlcore: add p2p device support")
Adding Eliad and Arik to the thread; it's not clear to me what the
these variables were supposed to do, but seeing as the code in
question was already dead, this is no functional change from a user's
perspective.  With that in mind:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

So I'd at least add the tag.
Fixes: 7845af35e0de ("wlcore: add p2p device support")

> --- a/drivers/net/wireless/ti/wl18xx/main.c
> +++ b/drivers/net/wireless/ti/wl18xx/main.c
> @@ -1847,44 +1847,6 @@ static const struct ieee80211_iface_limit wl18xx_iface_ap_limits[] = {
>         },
>  };
>
> -static const struct ieee80211_iface_limit wl18xx_iface_ap_cl_limits[] = {
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_STATION),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_AP),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_P2P_CLIENT),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_P2P_DEVICE),
> -       },
> -};
> -
> -static const struct ieee80211_iface_limit wl18xx_iface_ap_go_limits[] = {
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_STATION),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_AP),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_P2P_GO),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_P2P_DEVICE),
> -       },
> -};
> -

-- 
Thanks,
~Nick Desaulniers
