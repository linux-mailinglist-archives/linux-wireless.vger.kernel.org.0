Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1604F5348
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 06:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456296AbiDFDM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Apr 2022 23:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573152AbiDESDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Apr 2022 14:03:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07970EBBAA
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 11:01:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c15so26109ljr.9
        for <linux-wireless@vger.kernel.org>; Tue, 05 Apr 2022 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UtPjO+bxq+tkrbVKUaDcJXid+W/QeCc20ZhEe/m6WHk=;
        b=Xq6IZspRICfswBPKfRG9/rkA8zzqUrYc8AEaIS7BqLjxD8XxrJt/TSd6TeV+PoOh+x
         TWLTo87XR/66DLc3P6r3wOUKYiKC5VWuBkx+6ER1S5fqR8uVVLbE/Mnt/gH1EKOF0zMl
         EMq7iQ4CLUD2xX1/ZT+FGVsskv4zGNk9k0kI+FnwBzf1dA/sQfweLGYAVlAZk6QClzZ1
         nobRJrADpU/Tz+gYnl+iHQu9q539LiyMt0IlZ6xFi6lJArxzxWE3TK8eslO84swXM4xa
         I4CGW7Vw9/WAuQl2A2SW1HyL4qebDsG468bz3mFPIUYcQxmjKImFm9B12ojvWxmqxxY5
         SfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtPjO+bxq+tkrbVKUaDcJXid+W/QeCc20ZhEe/m6WHk=;
        b=MdGkrLS5W7A/qnPsYMspNGnoS+DxZ6S4RykcHjjQYSTrcw7K+Tc9cfv39aNgmZmoXN
         reOfnX2+HacRFCvJJNbx1RX2Rww9R9+e6IxVeaEk2kW3jkBTfjP/uKYQwctruVYXrrmI
         S96dluD7KBByc7LDkLCVUWMA6kpt/Fe86X8AP6XZExA9jHHMHu0IXGGA7pzgWLjeqH3P
         6O7zEOq/Q7Bs+ZkjtS/LR7gVYcZYeZz0DJXNWsgmOXWeWFNr+FomNX4m70px99QfpRuh
         HfoFrHfiI5W48k7Kzge07u9ClmUWLGYOgyWKuCwTNP9aTWdXEzZaBostNSl49u9npm/O
         dSrw==
X-Gm-Message-State: AOAM533c1/yA9IR1wO8X0NquVkTDa+O3oosRHLImYey4r9qwaXa0Pkyn
        rc0bkOwK+sc0yT5LJSbnjVjZoTtK9lFRommNxjhyxg==
X-Google-Smtp-Source: ABdhPJxmwIX/bZD6HHeBC8Mgm7SLI3AbupPtrtLQAue+dvE6QpFk1/V9rIQtTW8xUGyHm5vacR8kUrbKGxc6La1y6Es=
X-Received: by 2002:a2e:b70d:0:b0:24b:11d8:8e63 with SMTP id
 j13-20020a2eb70d000000b0024b11d88e63mr2819981ljo.472.1649181704075; Tue, 05
 Apr 2022 11:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220401233802.1710547-1-trix@redhat.com>
In-Reply-To: <20220401233802.1710547-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Apr 2022 11:01:32 -0700
Message-ID: <CAKwvOdkkfdjuNLzWimi+Q_PSD9T4ZxumBb+28g1vDbUX0VQVcg@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: fw: move memset before early return
To:     Tom Rix <trix@redhat.com>
Cc:     luciano.coelho@intel.com, kvalo@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        johannes.berg@intel.com, mukesh.sisodiya@intel.com,
        mordechay.goodstein@intel.com, matti.gottlieb@intel.com,
        rotem.saado@intel.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 1, 2022 at 4:38 PM Tom Rix <trix@redhat.com> wrote:
>
> Clang static analysis reports this representative issue
> dbg.c:1455:6: warning: Branch condition evaluates to
> a garbage value
>   if (!rxf_data.size)
>        ^~~~~~~~~~~~~~
>
> This check depends on iwl_ini_get_rxf_data() to clear
> rxf_data but the function can return early without
> doing the clear.  So move the memset before the early
> return.
>
> Fixes: cc9b6012d34b ("iwlwifi: yoyo: use hweight_long instead of bit manipulating")
> Signed-off-by: Tom Rix <trix@redhat.com>

Conditional initialization in a helper is a pretty dangerous pattern.
How about we move the memset to the two callers of
iwl_ini_get_rxf_data?

> ---
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> index abf49022edbe..666de922af61 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> @@ -1388,13 +1388,13 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
>         if (!data)
>                 return;
>
> +       memset(data, 0, sizeof(*data));
> +
>         /* make sure only one bit is set in only one fid */
>         if (WARN_ONCE(hweight_long(fid1) + hweight_long(fid2) != 1,
>                       "fid1=%x, fid2=%x\n", fid1, fid2))
>                 return;
>
> -       memset(data, 0, sizeof(*data));
> -
>         if (fid1) {
>                 fifo_idx = ffs(fid1) - 1;
>                 if (WARN_ONCE(fifo_idx >= MAX_NUM_LMAC, "fifo_idx=%d\n",
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
