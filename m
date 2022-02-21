Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD234BD7F9
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 09:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiBUIQQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 03:16:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiBUIQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 03:16:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D0E13E39
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 00:15:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso14878201pjl.4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 00:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCMFZ1ObGRig15tyTu88rTtsxKXlSOJnhDbMsM3o11A=;
        b=aC2WbzoDwzo53ITq/Crucnqd1RgUMblO4+fef9vofdV+S6f1wA2IcoTIjXcBkznw5G
         0J0/307ObK3ulR191AeJyKvfOOKs5U1BHefROXvi7gcuvGVGssS0Ixn4fP7YZE11rA8/
         HqWIqOT6/s1YYZ7nd5tpBxX1QAvWWbs7grA7U+hhM6YynIM+1pnz9qABisLUhWN5oFxy
         7uwVbBOA2k14IbcSf/L31Q/LP4hjBomDfecNhvdT8VtpMjuRQUdcgPu2AL2fZ4TsLxrd
         msVnbsF1OSijaiPNwhVCDtFTWDsT5KHc5wTx6JhDJVRRSh2ftaupZI5uC2ww7+l7yKxN
         7wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCMFZ1ObGRig15tyTu88rTtsxKXlSOJnhDbMsM3o11A=;
        b=MbKLnaHWZuFQtCo1zOouztYLdZSuZDepghdq7WaFSgoukEzSOctaj20qWgdDE3YZ9u
         MhYrk+eWTA94yJeWk2nQL6s2lVkmR53tsAhquYO8QLbBFs9oGFlBuUkMKAr9b5eNktIW
         eW0ruVHp8I+OI5OjSWemouD3DRtekKMzUZmakc+RQ8ADTJWfzjByi149C++nrTdd9nVb
         VZ+FI9Ar34Yz1qNB3qHOPsDYv/jATh40VNG2RgnXRuy+fa77Ihqx9VIAZ7lBnDWZXib/
         3Q73qiLOPa0mhqY+7se+e8hobUrWgvpZo7YFjkrZF6x+1XJU5IAJg6Fqac6xhmc26JCh
         +qnw==
X-Gm-Message-State: AOAM531Cg/raLdVP6o+08/FepF+toUhTZajJpnM3oTrv2QvwoJ88cnm2
        M6Y8FS1Rg2QcT7A/ykU3O14BUs8sU3xIu3y0y54Inw==
X-Google-Smtp-Source: ABdhPJxqC8IntWTGIkwxaSbzZlf/e1TQHc/VvskdwImTwOoOP/5GwmVmHHvTd974hpZ3kK5UHqfiBwsHYiMShNsWHfQ=
X-Received: by 2002:a17:90a:b785:b0:1b9:d80e:5f55 with SMTP id
 m5-20020a17090ab78500b001b9d80e5f55mr20294119pjr.209.1645431351860; Mon, 21
 Feb 2022 00:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20220219152912.93580-1-jrdr.linux@gmail.com>
In-Reply-To: <20220219152912.93580-1-jrdr.linux@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 21 Feb 2022 09:15:16 +0100
Message-ID: <CAMZdPi_t3__yRNJLZ1k-KO5ZOunfmcsX4_zSp5-9QbrFcgYY0Q@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Initialize channel to NULL inside wcn36xx_change_opchannel()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     kvalo@kernel.org, davem@davemloft.net, kuba@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        ryan.odonoghue@linaro.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 19 Feb 2022 at 16:29, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>
> Kernel test robot reported below warning ->
> drivers/net/wireless/ath/wcn36xx/main.c:409:7: warning: Branch
> condition evaluates to a garbage value
> [clang-analyzer-core.uninitialized.Branch]
>
> Also code walk indicates, if channel is not found in first band,
> it will break the loop and instead of exit it will go ahead and
> assign a garbage value in wcn->channel which looks like a bug.
>
> Initialize channel with NULL should avoid this issue.
>
> Fixes:  d6f2746691cb ("wcn36xx: Track the band and channel we are tuned to")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>



> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index 75661d449712..1a06eff07107 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -394,7 +394,7 @@ static void wcn36xx_change_opchannel(struct wcn36xx *wcn, int ch)
>         struct ieee80211_vif *vif = NULL;
>         struct wcn36xx_vif *tmp;
>         struct ieee80211_supported_band *band;
> -       struct ieee80211_channel *channel;
> +       struct ieee80211_channel *channel = NULL;
>         unsigned long flags;
>         int i, j;
>
> --
> 2.25.1
>
