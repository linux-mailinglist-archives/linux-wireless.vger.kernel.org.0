Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81188771AA3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Aug 2023 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjHGGq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Aug 2023 02:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGGq0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Aug 2023 02:46:26 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB882BA;
        Sun,  6 Aug 2023 23:46:25 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-586a3159588so42734717b3.0;
        Sun, 06 Aug 2023 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691390785; x=1691995585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OPit1TdQvpFj3vYGEVAqTQWDvXp1/1QOmkcsDpd8W38=;
        b=ILJh7rXRaJz3ooIMWsI3lHaN4X/pCel7zgF9Tzav2ru5xmBrnGaH3Hylqhqtemeqgw
         /dWMvhZXb9DogIng32ZgzBQJrI+Fl6ye/GJ3SkrlqnrAQnNZHlRVlfIvj1fabzzXQmQW
         rfLLGc1/reBK3YXrHMFh999VQo1mKv2hksNKDTSp6WKsfwxKSLl23HsX3yPfUZ3Z8Nd6
         dv9lMlyL6O9CP1m1aHBkvaKrq8dn/zIHcMi/FevX7V2VPbDhUtPYIEPCYY2m5fbgMvQz
         pDUQwu12gSQbuoCJBh2UMtgZJvjQr0hwDTWemXQhbAXrAwokHmi9bdtKg5QRBYvo+1GM
         Po0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691390785; x=1691995585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPit1TdQvpFj3vYGEVAqTQWDvXp1/1QOmkcsDpd8W38=;
        b=VGhVXa8WuoqghzWv9iFiz2JulctxAv9lnZNfueGVElepBUFzXEtG30tQmBFJCDQ7nw
         2wnnPUPTTZHQcYOaxW9+z1sqVsPa3Kqzo/+W+IpxH7rSOqDpqLECQq+UbrxlLL5n4qE6
         zfphPkdVbv+EYAMF07kyFw5aQJXGIR2ufoKI9Pq+UQbwiB6GGgSf7NNOeQDNC2nC3ZO0
         oy3YDSQpW3XPfWcW+y0ts2F0ICUUaEcnReIjxZ14epev3QZus3Qz1n0NleeSjL4kT7ke
         d0Yujl01bxzwQ222Ea3sNferFZntmpId5MEayURfB7O73d3n0eI4YT+mRhRf1yZMTh15
         HQLw==
X-Gm-Message-State: AOJu0YzJcDD0tOHjTu2beWrYov0gpufvwPSOqTPSPxjOTciMVVdATz7O
        yZJQ1i1HqdQ+OObYUSIY0MWPVmYmkRGYnOwhPhw=
X-Google-Smtp-Source: AGHT+IFCDztwAJGLGjIDLeUYS/lu8SHmjnsSxHAiVh9defMQ3X8ec4icZClubo2kh3HfOO2I9qgQZQ4phO4OaotTxAU=
X-Received: by 2002:a0d:d7cc:0:b0:56f:fd0a:588d with SMTP id
 z195-20020a0dd7cc000000b0056ffd0a588dmr7365675ywd.8.1691390784862; Sun, 06
 Aug 2023 23:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230804105002.5781-1-pkshih@realtek.com>
In-Reply-To: <20230804105002.5781-1-pkshih@realtek.com>
From:   Damian Bronecki <bronecki.damian@gmail.com>
Date:   Mon, 7 Aug 2023 08:45:49 +0200
Message-ID: <CAEvXze=dbg9iR2Ym2YVKcph+6QG1rx+fcQeJSdqgPN6Jrqy=8g@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw89: fix 8852AE disconnection caused by RX full flags
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@kernel.org, Stable@vger.kernel.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> RX full flags are raised if certain types of RX FIFO are full, and then
> drop all following MSDU of APMDU. In order to resume to receive MSDU
> when RX FIFO becomes available, we clear the regitster bits by the
> commit a0d99ebb3ecd ("wifi: rtw89: initialize DMA of CMAC"). But, 8852AE
> needs more settings to support this. To quickly fix disconnection problem,
> revert the behavior as before.
>
> Fixes: a0d99ebb3ecd ("wifi: rtw89: initialize DMA of CMAC")
> Reported-by: Damian B <bronecki.damian@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217710
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

This patch fixed connection drops for me. Thanks!

Tested-by: Damian B <bronecki.damian@gmail.com>

> ---
>  drivers/net/wireless/realtek/rtw89/mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index 1efa4da3cebc..cebefa3b1db3 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -2524,7 +2524,7 @@ static int cmac_dma_init(struct rtw89_dev *rtwdev, u8 mac_idx)
>         u32 reg;
>         int ret;
>
> -       if (chip_id != RTL8852A && chip_id != RTL8852B)
> +       if (chip_id != RTL8852B)
>                 return 0;
>
>         ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> --
> 2.25.1
>
