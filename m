Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0570D74C66F
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jul 2023 18:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGIQcJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jul 2023 12:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjGIQcI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jul 2023 12:32:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE53102
        for <linux-wireless@vger.kernel.org>; Sun,  9 Jul 2023 09:32:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9926623e367so473323666b.0
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jul 2023 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688920325; x=1691512325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6q+aOy2r+flgQCJZwvu7LKyLs8yIYN/+XSC8dA1GdM=;
        b=gAn+QFrFr5ulawjYCYTO7VmTQzHU5lgWSC5NEnzugmdYhNVwnmToW+MQ4reDvuq6l7
         PzP2nnDKMv8tyPbAMBaFVMjpeYKtX/i/KRcWvIp4fd9RpwmjkD31sHkkt+5HXaKSjBzT
         4EDltBMvryK/qN2k9UurMRUANtYKeMK9ETJQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688920325; x=1691512325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6q+aOy2r+flgQCJZwvu7LKyLs8yIYN/+XSC8dA1GdM=;
        b=jLzqN8oRCQrwDGji9GLFSnMtnmiJNiWQ7SKox2Kd2RP+1XNdH8PzRB0xYhKX8Q6DDU
         s6/2r0tAiQxu+ULlG3D30TmE0FBf/dqSbzknQQ9Ynt+D1UugzWblcZHFQDzLT0/qirHd
         YywzXMwec0VUlaaGfIdSEy99bnrCxbPVSzRqVQN8+Jp9/DJH8/9hWwHG9LP9cy0663rk
         C0LQ3iE+T3r2nt1Cw7vYVsaSX2EO+2GfAWGWl2oyZHjBcrNLTp8WJn9zkNhOcmEdJHTC
         0xjQp+5yo5iT0zRww6X/65X/xslShI94z+Ns4RtS/mBZgZzcFnYA72rmVuLjipCjNv6Q
         VejQ==
X-Gm-Message-State: ABy/qLY0494mtIZifg89651vF4UJqQ5tNa4w4WaNuO9ZCK2BGlZzLYbd
        OknlIE6WjOSp0ASyjtrIbDBmGDGpJuUTiIdUDaEU9dft
X-Google-Smtp-Source: APBJJlF44NJc/7C7R7ZuhHyjjOp84xQIsHKfLAdcVwn+1/mGX2BPc1p8CH+pl+2K2oa96zQgDEHFdw==
X-Received: by 2002:a17:906:9492:b0:991:e695:cb7 with SMTP id t18-20020a170906949200b00991e6950cb7mr8520745ejx.68.1688920325733;
        Sun, 09 Jul 2023 09:32:05 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906279100b00982a352f078sm4913567ejc.124.2023.07.09.09.32.04
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 09:32:04 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso38894315e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jul 2023 09:32:04 -0700 (PDT)
X-Received: by 2002:a5d:54c2:0:b0:313:f22c:7549 with SMTP id
 x2-20020a5d54c2000000b00313f22c7549mr8377726wrv.66.1688920324114; Sun, 09 Jul
 2023 09:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com> <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
In-Reply-To: <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jul 2023 09:31:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg23SdKRcn2W+BWWEfJ2Efp0sreJx9=iw0AsUPjW3qznw@mail.gmail.com>
Message-ID: <CAHk-=wg23SdKRcn2W+BWWEfJ2Efp0sreJx9=iw0AsUPjW3qznw@mail.gmail.com>
Subject: Re: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a
 ("wifi: iwlwifi: split 22000.c into multiple files")
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Baruch, Yaara" <yaara.baruch@intel.com>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 7 Jul 2023 at 03:55, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing the regression list, netdev, the net maintainers, and Linus;
> Johannes and Kalle as well, but just for the record, they afaik are
> unavailable]

So I will release rc1 with this issue, but remind me - if it hasn't
had any traction next week and the radio silence continues, I'll just
revert it all.

From a quick look, "revert it all" ends up being

  fd006d60e833: "wifi: iwlwifi: remove support of A0 version of FM RF"
  a701177bd4bc: "wifi: iwlwifi: cfg: clean up Bz module firmware lines"
  f4daceae4087: "wifi: iwlwifi: pcie: add device id 51F1 for killer 1675"
  399762de769c: "wifi: iwlwifi: bump FW API to 83 for AX/BZ/SC devices"
  31aeae2446d5: "wifi: iwlwifi: cfg: remove trailing dash from FW_PRE constants"
  ecf11f4e4950: "wifi: iwlwifi: also unify Ma device configurations"
  bfed356b4fc4: "wifi: iwlwifi: also unify Sc device configurations"
  3fd31289d5de: "wifi: iwlwifi: unify Bz/Gl device configurations"
  e3597e28a2fa: "wifi: iwlwifi: pcie: also drop jacket from info macro"
  0f21d7d56083: "wifi: iwlwifi: remove support for *nJ devices"
  c648e926d021: "wifi: iwlwifi: don't load old firmware for 22000"
  a7de384c9399: "wifi: iwlwifi: don't load old firmware for ax210"
  a13707f7c845: "wifi: iwlwifi: don't load old firmware for Bz"
  508b4a1baeb3: "wifi: iwlwifi: don't load old firmware for Sc"
  5afe98b2e299: "wifi: iwlwifi: give Sc devices their own family"
  19898ce9cf8a: "wifi: iwlwifi: split 22000.c into multiple files"

since clearly nothing seems to be happening on this front, and summer
vacations are only going to get worse.

But we'll give it another week. In August huge chunks of Europe will
go on vacation.

                    Linus
