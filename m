Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE30367F0E8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jan 2023 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjA0WIj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Jan 2023 17:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjA0WIh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Jan 2023 17:08:37 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9CD7FA2C
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jan 2023 14:08:36 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id k3so889609ioc.10
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jan 2023 14:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=al9oy3E79ODPhEjXEHhJKk/A8XmQzAwjko7z1WJnZkc=;
        b=NPwfv5aXAsscvOxtwXtO9484xYSoDmyOBMRHaq6lKLS61CV1IWSbgh14Mvd5VHqR4X
         bwh/qNckPyHJ3rRfcMqtRB0SQKEsB2IPGnJT/H4kwO7OemTtVM4iRqS2UZSsGlDbjn/Y
         nkENSjnV/+noRbM4zBn6bygihOczkHMzXE/os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=al9oy3E79ODPhEjXEHhJKk/A8XmQzAwjko7z1WJnZkc=;
        b=Pajt/8TAi59xKhZyajxNcU9R+6rrd25Hx3ZsWMYHf3kv3AD6+m6aN5ezJsaak59BY6
         MJi3Sv+DCiCq5wv9KAbwxT9s/wsxoqsFMQQzls7YnsSQ1nIAboTRnbq+ZGx12y1jI/Xc
         vDcNXY0PA6rD8D+MeMohU0PsgqoHTwfFg84gs+e1g7buALm2gUD1bbrYG/s4CkVfRfls
         K/aV6nGCsI17l3aAkT/69QMd2TDr5uOcXiFNLy6C5AqQ1BRwpGG8XUXiqeDiDj+3vURh
         E+1GOukWbTj3LlL+AFuZaiupPzIEPLEV+RyhYXfF66WO03XjQ4ZpMO9fKCqaLOPJ0/IS
         Fjzg==
X-Gm-Message-State: AO0yUKU/DDxcfIRxd7PmfX40Y/Wdn8j0YipVRJTzoqqYGLYlPhNvBIjO
        lrNvFoc619i5SkpU7VNmZcBslGLmSS5jwPUSycyUkGvw1jogfvod
X-Google-Smtp-Source: AK7set/q2kaa+ypIxOjsL1soOvTsxLlm1mLlh4dFrILigvfOQioehJJTu0K8nJ8YHs49B/9ZVlPODT+AvZNEaOu5JHQ=
X-Received: by 2002:a05:6638:10d4:b0:3a9:6f3a:4b55 with SMTP id
 q20-20020a05663810d400b003a96f3a4b55mr805907jad.6.1674857315411; Fri, 27 Jan
 2023 14:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20221220075215.1.Ic12e347e0d61a618124b742614e82bbd5d770173@changeid>
 <56d4941a-ad35-37ca-48ca-5f1bf7a86d25@quicinc.com> <CACTWRwt7oQrCyHf=ZF6dW8TtRhOfa14XMZW39cYZWi4hhszcqg@mail.gmail.com>
 <87tu0wcb3l.fsf@kernel.org>
In-Reply-To: <87tu0wcb3l.fsf@kernel.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Fri, 27 Jan 2023 14:08:23 -0800
Message-ID: <CACTWRwvhRUFvdv06YkQEgnz1Zyig_FqCeJU06VypT0Lvzv5OXw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: snoc: enable threaded napi on WCN3990
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for all the comments. I will call dev_set_threaded() directly
without HW params and rollout a v2 soon.

On Thu, Jan 12, 2023 at 2:15 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Abhishek Kumar <kuabhs@chromium.org> writes:
>
> >> > --- a/drivers/net/wireless/ath/ath10k/snoc.c
> >> > +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> >> > @@ -927,6 +927,9 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
> >> >
> >> >       bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
> >> >
> >> > +     if (ar->hw_params.enable_threaded_napi)
> >> > +             dev_set_threaded(&ar->napi_dev, true);
> >> > +
> >>
> >> Since this is done in the API specific to WCN3990, we do not need
> >> hw_param for this.
> >
> > Just so that I am clear, are you suggesting to enable this by default
> > in snoc.c, similar to what you did in
> >
> > https://lore.kernel.org/all/20220905071805.31625-2-quic_mpubbise@quicinc.com/
> >
> > If my understanding is correct and there is no objection, I can remove
> > hw_param and enable it by default on snoc.c . I used hw_param because,
> > as I see it, threaded NAPI can have some adverse effect on the cache
> > utilization and power.
>
> WCN3990 is the only device using SNOC bus so the hw_param is not needed.
> It's safe to call dev_set_threaded() in ath10k_snoc_hif_start()
> unconditionally as it only affects WCN3990.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
