Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0977451422F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 08:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354415AbiD2GQB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 02:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345879AbiD2GP6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 02:15:58 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7070750E08
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 23:12:41 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ec42eae76bso75034627b3.10
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 23:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnXNRi3fgLseToL8emPAro3wD9fV8AutKcOTldnUHZg=;
        b=hlwtoZX5S8WE5hujcH3ZqSI1F6JaTPn+asutbPJcQCC2bbL5Kfg3Kg6RR0129B5hGJ
         0s0RPL0CYx/63UTzOvYhq6RBlIHCPY6i0WBpSXW6Y5CMbZAf0GkRCWsJFKgHUYb098et
         TZetDO80SdCHicgzkOGFwZecll7xmToAqGL1wJ+sLVf15/mMApvnCoR9qol0ahu36Iij
         IgHog0xdtRcxjG5RIu/lCjhIIggH2lzrKqsH+KQ67RF8nR9cSV8ZJ7JpkWod6jHGyJIl
         1Q2tHzNgW0wVgUJL8ydgUrWE+zASpoKSuyhmU6rilGsVZuyGCIEtpDXbuyDuEwYiwquW
         7/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnXNRi3fgLseToL8emPAro3wD9fV8AutKcOTldnUHZg=;
        b=BrSyHwHpIgRA92ADX3yptQJNRdaCc+0HNgaoEBxpfNXNqlwSaNY6fS8z3oMnuyLlnZ
         GM+qhHms2GetuFhy5Lh8/aSSY49ym22c7f/zgsAqFGQXz672UxGfvyDzijeyYJuMi1+e
         E4C8UmcvEIUSQyFSKhzkooPRbmCZFdnFfgCc3Qe+Qu3Tc9Q/zACEYsKIJFOGGGzJtj5s
         1On1lIOtVaAjPXpPVXGpWsXy+T8g7rrJZWV27nxBIt02nPRQX0bfxgWDksHJXaZ4v5In
         asirUy/P6cEREwtIedt9KrPObgvuGcowd+WBvxiAf75fK6vz2J1S78FnnxZJXzhfAFpp
         JbXQ==
X-Gm-Message-State: AOAM533QzDtyIe7afy+dpu9ARi4GI/BSxmWlyCZy8MjLFo1B72sxP+HX
        I/oNxeOEug2FPEszCDP2+qHCdknTLx8JiZAwyQzL/FjiXow=
X-Google-Smtp-Source: ABdhPJydCw7QruBmFPtNS1LGkkCjRGaFOawi7x7UIiIhGh/L6he7e8pCGYsHIflNa7QBcza34vr14ezR92EiO4/ypPo=
X-Received: by 2002:a81:492:0:b0:2f7:ce87:c324 with SMTP id
 140-20020a810492000000b002f7ce87c324mr28911207ywe.359.1651212760038; Thu, 28
 Apr 2022 23:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR02MB4567E377F14F272DFF48907A92FA9@BYAPR02MB4567.namprd02.prod.outlook.com>
 <332e62e5-b04d-3a6a-38fe-924d056bf0f8@linaro.org> <87k0b8fnpj.fsf@kernel.org>
In-Reply-To: <87k0b8fnpj.fsf@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 29 Apr 2022 09:12:28 +0300
Message-ID: <CAA8EJpr3Uxa-Tif5TyHfXL03j1--vrAb+DgT=0DY8KDpvHPjeQ@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath10k & ath11k firmware 20220423
To:     Kalle Valo <kvalo@kernel.org>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 29 Apr 2022 at 08:44, Kalle Valo <kvalo@kernel.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>
> > Hi Kalle,
> >
> > On 27/04/2022 11:32, Kalle Valo wrote:
> >> Add support for QCN9074 and WCN6750 ath11k hardware families. Also
> >> there are several updates to existing firmwares and board files for both ath10k
> >> and ath11k.
> >>
> >> Please let me know if there are any problems.
> >
> > I noticed that this pull request doesn't include the board file for
> > WCN3990. Is there any issue with it that we can solve on our side?
>
> Oh, sorry about that. I guess this is just a bug in my scripts, I'll
> include the wcn3990 board file in the next pull request.

Thank you! No problem, it was more of a question if we missed something.

> Linux firmware maintainers, please pull this anyway. I'll submit a
> follow up pull request later.


-- 
With best wishes
Dmitry
