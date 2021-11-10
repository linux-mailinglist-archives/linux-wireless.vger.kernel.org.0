Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F110344CB5F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 22:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhKJVmo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 16:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhKJVmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 16:42:43 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F2AC061766
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 13:39:55 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u25so5244527ljo.12
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 13:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fhwG8JiKxShnSZ6QQTuDODf/U79N+SImDenfsND+wk=;
        b=oUscIYcAOyGNfe6068weJD3o7F8eiMzWJsLWdyJHFlZkjw33u5QetZpv4QE+Mhla9O
         8GpEs73hv+7Loye8oARnHeEIJcEswipTkyEy3noPdsFodzIQ+no4YZidLUFNbWMdoeIB
         gkJrvz1KBAPbbzQ8mYtWRjJzMz4kcqqiEzV/hYqavmrOrvgkNdNYtraJLkLld6CHOfiq
         EMhssthtLoIuiVgdCYXNfKHUAWX/uP6uqWcQmDQl+idQ6TT9YPc/FtTlyAh5mnZssFgb
         rHtix1iiFGKrSvaAYhKv8R21On0pjmXxfWLnAY6WPfdvKRtgWgMOQv0u3xFItqU8Xt/a
         zC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fhwG8JiKxShnSZ6QQTuDODf/U79N+SImDenfsND+wk=;
        b=Kr1AILwhwAJc4PS22StT1Bps4rNs5ce7hUiT8mOosCZtFdTdubhvCOw5QSV/oDgfT8
         OoIYxcUHj6+d2mJI2jjKaLP6OI5NfT4K8p6El4oUR59IliFrRhoVGXFNIQfTyugy2I1C
         uF7hzGky2rSfMh6YlnwNzb62La7nVdBGSiFTI1dm5AtpTBBgzzoLuEaNPfbDtGpuO4UD
         UfMJYOz1FiFx81uGbXzVEE9nwGOEPM1aaP/uLEb7rayjEFc91+9z5anYWycqLzwy/7HX
         OoNgGd4AmmmsLLttvGyCrGPMDRIrChXDaEIVW7lX4g/X9N3bCQkl+ky+L+4KeBDsZGgR
         op/Q==
X-Gm-Message-State: AOAM5305OxU2EtcCUHLHZa5eTotvQH80ctNM6Bk79cdTIKRto79rfYjD
        Ni8wF2ZTD1TTghaaNZE7M6xTG9sB8BXcjs8SYdVKIQ==
X-Google-Smtp-Source: ABdhPJzUIhrOS4hmYH9FaPKnAudImegiTctFFSRfcQrJlee75A8HV4vHD3JDgxaGjvxmuKS9yUY/zPoQiH0ftQbO2FU=
X-Received: by 2002:a2e:9a8c:: with SMTP id p12mr2167251lji.526.1636580393318;
 Wed, 10 Nov 2021 13:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20211104133735.1223989-1-arnd@kernel.org> <CAKwvOd=vrUe7xWohkPZkfui2BM-uP2Q79v02NzTJs9XJJ1CTjw@mail.gmail.com>
In-Reply-To: <CAKwvOd=vrUe7xWohkPZkfui2BM-uP2Q79v02NzTJs9XJJ1CTjw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Nov 2021 13:39:41 -0800
Message-ID: <CAKwvOdm1zU8nhp-KVNDwQK6SfxzwZQgkWvPwpbzn_a-VzVbkXA@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: pcie: fix constant-conversion warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Yaara Baruch <yaara.baruch@intel.com>,
        Matti Gottlieb <matti.gottlieb@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 10, 2021 at 1:38 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Nov 4, 2021 at 6:37 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > clang points out a potential issue with integer overflow when
> > the iwl_dev_info_table[] array is empty:
> >
> > drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1344:42: error: implicit conversion from 'unsigned long' to 'int' changes value from 18446744073709551615 to -1 [-Werror,-Wconstant-conversion]
> >         for (i = ARRAY_SIZE(iwl_dev_info_table) - 1; i >= 0; i--) {
> >                ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> >
> > This is still harmless, as the loop correctly terminates, but adding
> > an (int) cast makes that clearer to the compiler.
> >
> > Fixes: 3f7320428fa4 ("iwlwifi: pcie: simplify iwl_pci_find_dev_info()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Also, looks like 0day bot reported as well:
https://lore.kernel.org/lkml/202111070825.gigxmmDq-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>


-- 
Thanks,
~Nick Desaulniers
