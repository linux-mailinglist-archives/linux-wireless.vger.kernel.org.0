Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BC67B402E
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Sep 2023 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjI3MAK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Sep 2023 08:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjI3MAJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Sep 2023 08:00:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78245BD
        for <linux-wireless@vger.kernel.org>; Sat, 30 Sep 2023 05:00:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so5528a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 30 Sep 2023 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696075205; x=1696680005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GTxYazO7tslop+1R5e/LRP9/RgHOwT+uOuEWmbMhAw=;
        b=pgvcZ8ef40BgdU0/wa4IZYQOGSHDSmL37DODRGWXZtnj7bsPDfE6M8ax1GIBiDtXR9
         Ej9obkJsi30kFd+YUZdjoa9EEP6PNFbjk2uB4pbSpSkG6BXzf5ZWPFilqi+hO34PLCJj
         lQnSrQjOhJps62YAfONRjhhQvUlxfl0QXoTBr0/6J3SAjhzUgU+WB1FVA4WisH5U5Kfr
         9ADAMpn2MloFClbRxvf8VcGJU8hP7UlEyY17bIBhuAJjwyNSnlrPF67hj2auxGTXJTuo
         vSRtfclMtSYnEQg36j4X5Lu0I/439EotBkNLWCg4eQhk/16baSTP4ku4opYO6+Vep/4g
         cOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696075205; x=1696680005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GTxYazO7tslop+1R5e/LRP9/RgHOwT+uOuEWmbMhAw=;
        b=q7B9Btkgnjl6XS9XqBRMc3ARlC/o1Evo8Ha9z/1QY6N39csKf5UgkMM8/zuPUF1Yll
         6yZ+UwviSWL2GyAoYV7wJWz2hlVG6+I+sD9VBbnJM+Txk+a+fmpOofBEtx1nE9UQ//Tp
         xOGFqM6kx5V8gcsfNxWk+AfEDNhJ8PVtOFKU1DpgwPMidsVdMvaJiIoWfKRywXS4JTzf
         yngIw+DO8PRIqjfvNAGJjPW5NuxyVxK6WfFd/7+MbK1IjBbBRfitxn2TCb4wrzqy8a/B
         lkRiEJMk5pAO3ykTTSTp3Mgw72JocgeHsQBGap0Jyyr2Y3T3CkwgQXd/f0tA3uJkv1yK
         wzKQ==
X-Gm-Message-State: AOJu0YyfUz8hX/z/6nZSQEfVY3cDfSYVa5/57rBQGkkp7QZDbly3EzZp
        AL47+85oSunfkYQZOkMHvbxqLApcMkJbg7GNjJswhA==
X-Google-Smtp-Source: AGHT+IGdzCjX3EBgqb4QPmapoSPJsqAAEbYgJDuzEACgLn7JbDrTrmgIjPOsc2vqbMgvrU34OmWNrGJLKX84Jip4SOo=
X-Received: by 2002:a50:8d17:0:b0:52f:5697:8dec with SMTP id
 s23-20020a508d17000000b0052f56978decmr32444eds.4.1696075204644; Sat, 30 Sep
 2023 05:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230922111247.497-1-ansuelsmth@gmail.com>
In-Reply-To: <20230922111247.497-1-ansuelsmth@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 30 Sep 2023 13:59:53 +0200
Message-ID: <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
Subject: Re: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 22, 2023 at 1:13=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> We currently have napi_if_scheduled_mark_missed that can be used to
> check if napi is scheduled but that does more thing than simply checking
> it and return a bool. Some driver already implement custom function to
> check if napi is scheduled.
>
> Drop these custom function and introduce napi_is_scheduled that simply
> check if napi is scheduled atomically.
>
> Update any driver and code that implement a similar check and instead
> use this new helper.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb3/sge.c  | 8 --------
>  drivers/net/wireless/realtek/rtw89/core.c | 2 +-
>  include/linux/netdevice.h                 | 5 +++++
>  net/core/dev.c                            | 2 +-
>  4 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ether=
net/chelsio/cxgb3/sge.c
> index 2e9a74fe0970..71fa2dc19034 100644
> --- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> +++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> @@ -2501,14 +2501,6 @@ static int napi_rx_handler(struct napi_struct *nap=
i, int budget)
>         return work_done;
>  }
>
> -/*
> - * Returns true if the device is already scheduled for polling.
> - */
> -static inline int napi_is_scheduled(struct napi_struct *napi)
> -{
> -       return test_bit(NAPI_STATE_SCHED, &napi->state);
> -}
> -
>  /**
>   *     process_pure_responses - process pure responses from a response q=
ueue
>   *     @adap: the adapter
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index 133bf289bacb..bbf4ea3639d4 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1744,7 +1744,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_=
dev *rtwdev,
>         struct napi_struct *napi =3D &rtwdev->napi;
>
>         /* In low power mode, napi isn't scheduled. Receive it to netif. =
*/
> -       if (unlikely(!test_bit(NAPI_STATE_SCHED, &napi->state)))
> +       if (unlikely(!napi_is_scheduled(napi)))
>                 napi =3D NULL;
>
>         rtw89_core_hw_to_sband_rate(rx_status);
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index db3d8429d50d..8eac00cd3b92 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -482,6 +482,11 @@ static inline bool napi_prefer_busy_poll(struct napi=
_struct *n)
>         return test_bit(NAPI_STATE_PREFER_BUSY_POLL, &n->state);
>  }
>


In which context is it safe to call this helper ?

I fear that making this available will add more bugs.

For instance rspq_check_napi() seems buggy to me.

> +static inline bool napi_is_scheduled(struct napi_struct *n)

const ...

> +{
> +       return test_bit(NAPI_STATE_SCHED, &n->state);
> +}
> +
>  bool napi_schedule_prep(struct napi_struct *n);
>
>  /**
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cc03a5758d2d..32ba8002f65a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6523,7 +6523,7 @@ static int __napi_poll(struct napi_struct *n, bool =
*repoll)
>          * accidentally calling ->poll() when NAPI is not scheduled.
>          */
>         work =3D 0;
> -       if (test_bit(NAPI_STATE_SCHED, &n->state)) {
> +       if (napi_is_scheduled(n)) {
>                 work =3D n->poll(n, weight);
>                 trace_napi_poll(n, work, weight);
>         }
> --
> 2.40.1
>
