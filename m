Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C99F6B9ED2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 19:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCNSmy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 14:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCNSmw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 14:42:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36D46AD
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 11:42:51 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id c11so12496964oiw.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678819370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQZdm3Qt8HI/pCzzQC1iTxrg7CqI+Nk8HHkdN6ICxfg=;
        b=Kx+i42drI06qWbfEBnAJ5SenOPvBn5Yyw7cwQRos5iBZbTLQUhA+hG3uL2MNmv15fl
         04Fyjf95xYpl44J3NSJF5Ns5d732HSwmHH23Gj0gbHskcdmVeAqF7XA+vbhWIhuzB2Up
         Zj+/KVUECtQsZQiny8dWsM1O+1a4iCBFmqDEZ/H6irOIigHiLHgASFyRNmrKhv3Q+bs+
         XjOQNox2yYL1MSbLkPXb61U4/CLJuHaX8DIk4nU+4S2c3GvVwt24Yyvd4vdqjHAIOsmJ
         E6NQKzRGzPeAwBK40/MKno63QiX4Ze+Y52zq3oY2m94abxwssQcukjZ6fWhTeVvcC59R
         /oQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQZdm3Qt8HI/pCzzQC1iTxrg7CqI+Nk8HHkdN6ICxfg=;
        b=WjhmeN/SdHdlCBynloLwhe5RUsWvMTNdk3TMt3W0YVTgn7hlp+zoo4bGYkIgv+IKrr
         sB4p07LSQltJEmQRxqaQbcCZ9YWAegx6XT+P9SxPZ9+sdy7FEgwqKntcnL4XINe5ss9F
         1ceqMx9kVIssHUoa1B3oYHnpN0YFXdKM0lDjEBP9vTOPepIEpnxkk52KhDuuyTyMhPFM
         0k6d6o6Sfh9pVeaWuINkrmnvmOFKFdlvwKWrixNxHFkg2No/qWCfKbUqqZlIbORLEPC+
         qazMwof7cvKerMHYP8K+oxykKFUeaDVASfVxa8+dgLNcxiGT5SqB4ZSPAt+DEgamZ8FC
         D48A==
X-Gm-Message-State: AO0yUKWP66+YaSWhkr6R/2VluDGK6/zVp7Gc+dAx+vGOEHCpvJhpp2Ld
        mLHSwHP4D0kUsSbUmQFXsPqNGNEkdO1ZO9VrGa+23w==
X-Google-Smtp-Source: AK7set/GTyWucztbb4fOhjq0dgZFCI5u3Ap4JlWaVtkYFTvM7NFFWEoosSHH/f45RCvapGK8jFdSfFb3hJFzv+vrzmc=
X-Received: by 2002:a05:6808:355:b0:383:eace:e858 with SMTP id
 j21-20020a056808035500b00383eacee858mr26706oie.6.1678819370396; Tue, 14 Mar
 2023 11:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230311150647.22935-1-sireeshkodali1@gmail.com>
 <20230311150647.22935-2-sireeshkodali1@gmail.com> <CAMZdPi_uBLutBejSV1fz5p9GYqHYd75VTAePtndUnsu=JypdTQ@mail.gmail.com>
 <CR6AZI7T6X51.AX26VA80VSUW@skynet-linux>
In-Reply-To: <CR6AZI7T6X51.AX26VA80VSUW@skynet-linux>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 14 Mar 2023 19:42:14 +0100
Message-ID: <CAMZdPi8NJbKcn1i+bAq4RtWhDwE-Og5x631myW57i0ZHVvsDxA@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: wireless: ath: wcn36xx: add support for pronto-v3
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
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

On Tue, 14 Mar 2023 at 19:04, Sireesh Kodali <sireeshkodali1@gmail.com> wrote:
>
> On Tue Mar 14, 2023 at 2:19 PM IST, Loic Poulain wrote:
> > On Sat, 11 Mar 2023 at 16:07, Sireesh Kodali <sireeshkodali1@gmail.com> wrote:
> > >
> > > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> > >
> > > Pronto v3 has a different DXE address than prior Pronto versions. This
> > > patch changes the macro to return the correct register address based on
> > > the pronto version.
> > >
> > > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> >
> > Acked-by: Loic Poulain <loic.poulain@linaro.org>
> >
> > Could you also submit a change for the new 'qcom,pronto-v3-pil'
> > compatible in the related devicetree documentation ?
> > (bindings/remoteproc/qcom,wcnss-pil.txt)
>
> The changes to the device tree were only recently merged
> LKML link: https://lkml.org/lkml/2022/9/30/1502

Perfect, thanks.

Loic
