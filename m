Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93076DF0D7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDLJqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDLJqv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 05:46:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14F19008
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 02:46:23 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id h198so17544410ybg.12
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681292782; x=1683884782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNuVbYyBnP1BcaPopnX8lztKblurkV7/rLoacjW6Njs=;
        b=yAaY1KHIpqwcoP5byyGOts6dHMQUhWaW8lZyTtgdsRUUgDlaAHH395rOIxlekGq55a
         bAxYgNjrF5/lwJqeiX2SZRIlVk2wO1odlGdLhDv9ZjZ2OumLC3qfrIiMQFHTAFqR25OA
         Tq4XhZxEjZAvYzp36dH5BRB6SW2vYxt8LosNPecG+dyOaNI09RB5a/JtDX8MusxhsSzW
         Byn8erPSpBIlhHXnSrZzqjRlaYIdmdM+8LkwtNvqrZmqhF8RoY5A57vLjejbupdPrGyj
         Win6bDULj8RGrz7JGPWkwlJEv6Gygsn0CLc+x8I+UaVtZentrbTSPAYiXwEANqQ3N8ED
         beMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681292782; x=1683884782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNuVbYyBnP1BcaPopnX8lztKblurkV7/rLoacjW6Njs=;
        b=4coYh1Qi2biakjKcsnr8VyMY0gtUSJRdlxDCzcl8c0PMb/Gj36fNeBPV7o0uavq7Wr
         tghMJ7f28DrH72Jbd37BUpymvonjgB1Y1JV87v1qq/PfYuKaXHjor9xfF1VdFljcqfq0
         3DphzVocjv4H4EdCVQ3V0XTZdCN9Ov5R/iS+9p/I8ekdgrkYQzGnLPcliLnE9sQKQ/2m
         T84jA8wycpoSGyRMN4Fq6GZeec0qkCa3TM/9uEgLABzFKM/qIFZ0tErz9AY5DxV7sh40
         qIzecFUIsLxgmb2rJs7BQKNV6OunPmYLORP7leq0FwHQ+rCW58AoB9Olukrxlz35/oCP
         m7KQ==
X-Gm-Message-State: AAQBX9eM99mg+M45Vot94QHFNUpNatNPkHUni3Cfj6s15rZ8HILSAdeW
        gWMoBtoirenSImsC3J3igyKw2XcXfn88nj756on6+2unn5CUO+xH
X-Google-Smtp-Source: AKy350bOIfX5NAzv6KgxUT2B1YGM2RvsdUbOEM86g0uqawtzMv77LJ92an89N0cSH4dLXjtnO5ExgpcLpL6DNZjWOTY=
X-Received: by 2002:a25:da8e:0:b0:b8f:3647:d753 with SMTP id
 n136-20020a25da8e000000b00b8f3647d753mr1197484ybf.9.1681292782236; Wed, 12
 Apr 2023 02:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <87cz4ia35m.fsf@kernel.org> <8ceeee1e-8828-69a9-facb-20c3787207bd@linaro.org>
 <87jzyh8mrw.fsf@kernel.org>
In-Reply-To: <87jzyh8mrw.fsf@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 12 Apr 2023 12:46:11 +0300
Message-ID: <CAA8EJpotq5KjbUAU+exR5uU9-9erFhdxPn_OTUJ58MrXM-Pngw@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath10k & ath11k firmware 20230405
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 12 Apr 2023 at 12:36, Kalle Valo <kvalo@kernel.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>
> > Hi Kalle,
> >
> > On 05/04/2023 16:07, Kalle Valo wrote:
> >> Hi,
> >>
> >> Here's a pull request for ath10k and ath11k. For ath10k we have lots of
> >> board file updates in multiple hardware families. For ath11k we have new
> >> firmware branches for QCN9074, IPQ6018 and IPQ8074. WCN6750 also got a
> >> firmware update and WCN6855 has board file updates.
> >>
> >> Please let me know if there are any problems.
> >>
> >> Kalle
> >
> > Excuse me, a gentle reminder regarding WCN3990 board-2.bin. It was not
> > included into this pull request.
>
> Oh man, sorry about that. I guess my installation script was buggy and
> missed it somehow, I'll look at it later and make sure WCN3990 is not
> skipped anymore.

No problem, thanks a lot!


-- 
With best wishes
Dmitry
