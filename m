Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA75B88A8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 14:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiINMyO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Sep 2022 08:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiINMyN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Sep 2022 08:54:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129007757A
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 05:54:12 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l65so14807199pfl.8
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9MTarLD/Pz82hkgDPc4VnnqjhN28FjyaD0E3mX82COU=;
        b=K/yaOWTGsX8o27gyE0RR60UFSMA65Kzwajuwdp516iNGY6z1R8XtcZbJdd96vUr4yP
         neYMOMw+7cc/G1vjcVdKraDInzHbpDgfBp+q1uqaUKWETRLfEBSRjCrf/9jRnWxKJO6e
         i82f8AyMDeDK7HiOSrIRl5slCmkV9UB+R+UxrmAnIVtnQoUUZqy9+nYVdn4YwEUzbQft
         STZtvjxXCIcX81KfBTwEEBnj7+AIQxo95yYDRV+4IQ3/+fQCKMT0IbhmY4dde9oIoCJe
         WO1gly0NYceIRmcWnFUEVHgWtVUxPunSE089xAwD6RRQRBuglqeog/BR8qzjluMEnGjh
         6fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9MTarLD/Pz82hkgDPc4VnnqjhN28FjyaD0E3mX82COU=;
        b=5ADu/VAm12DWetpOcbUWo/wAgXE99mZNAcwBTJDVzONb56pTUYWug3G6ChiqzJUFfp
         L/eWtFksNVItCp9j05D2vmvkMsCvYyIhCbA0CJBMhIbfKAoj6/gyP85zGepcNkYEijN6
         K/y8N81v+4NksDg3V7glxAaG+fLcyV5aaKn6a2t0fEm9MjCvdDkeXqpQGdys6sqRdzt0
         343+zeBfL1no6qv8RWoG9eVhTa01l6NzqSA/MPPJSGPwm7QAjV58UoJ36tAN6P1pusTx
         ufaQgEm6z0VKOxoloqmO+Kr9FMvqJueRx8iOy+mdK4hPN2L3t1YwcMQ7DwfmCjjXDVzS
         jySw==
X-Gm-Message-State: ACgBeo3mRAGPWRo08OY6EpQrmKMsOsyiDPG4qv2cvepIYawY09p+SmAo
        c7sIbcglLfJCR0EVUlaYMnth6hIu2PYWGgrt2EZJzg==
X-Google-Smtp-Source: AA6agR4hp9rR+sKtlF/YqE667eNWP1KTTveHcsyJDzlTL+f/ZXSzspIvUqKVDh5hIlUaSVLeICMzb6Cd9/HyJFIU0Pg=
X-Received: by 2002:a63:e07:0:b0:429:8604:d9ad with SMTP id
 d7-20020a630e07000000b004298604d9admr31265919pgl.586.1663160051459; Wed, 14
 Sep 2022 05:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220913174224.1399480-1-bryan.odonoghue@linaro.org>
In-Reply-To: <20220913174224.1399480-1-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 14 Sep 2022 14:53:35 +0200
Message-ID: <CAMZdPi_jZEHSz9+WaR3N-MANU7YdYK0zqO7VXNwAcES=YkNaxg@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Add RX frame SNR as a source of system entropy
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
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

Hi Bryan,

On Tue, 13 Sept 2022 at 19:42, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> The signal-to-noise-ratio of a received frame is a representation of noise
> in a given received frame.
>
> RSSI - received signal strength indication can appear pretty static
> frame-to-frame but noise will "bounce around" more depending on the EM
> environment, temperature or placement of obstacles between the transmitter
> and receiver.
>
> Other WiFi drivers offer up the noise component of the FFT as an entropy
> source for the random pool i.e.
>
> Commit: 2aa56cca3571 ("ath9k: Mix the received FFT bins to the random pool")
>
> I attended Jason's talk on sources of randomness at Plumbers and it occured
> to me that SNR is a reasonable candidate to add.
>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/txrx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
> index 8da3955995b6e..f3b77d7ffebe4 100644
> --- a/drivers/net/wireless/ath/wcn36xx/txrx.c
> +++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
> @@ -16,6 +16,7 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/random.h>
>  #include "txrx.h"
>
>  static inline int get_rssi0(struct wcn36xx_rx_bd *bd)
> @@ -297,6 +298,8 @@ static void wcn36xx_update_survey(struct wcn36xx *wcn, int rssi, int snr,
>         wcn->chan_survey[idx].rssi = rssi;
>         wcn->chan_survey[idx].snr = snr;
>         spin_unlock(&wcn->survey_lock);
> +
> +       add_device_randomness(&snr, sizeof(int));

We store the SNR in an integer, but isn't it reported as u8 (or s8) by
the firmware? So maybe we should just inject the LSByte since the upper
ones will always be 0?



>  }
>
>  int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
> --
> 2.37.3
>
