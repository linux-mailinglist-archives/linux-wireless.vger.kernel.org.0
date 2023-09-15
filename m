Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6B7A12EB
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 03:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjIOB24 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 21:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjIOB2z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 21:28:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D2A268F
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 18:28:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502b0d23f28so2702717e87.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 18:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694741328; x=1695346128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBGNOe9gI9NaJRPLZ/Vx8tqTgrMHNSFjAjNWZOJ75IE=;
        b=Rr27jgz8dPVH1USNBqahqqKWCNA3PkYZ7vrKkBuk6VgBRo6od8DZy982nAK4s74AJZ
         ljH+r9WTPFT17s8sgUwNXKKwpuFytM9nOhut1LPr8DP94+VMjpwIgk4mSCh6l1cx3fhy
         ahlNzJIqoX21W/8hH4Bd5GcqBNz51TfUZUI24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694741328; x=1695346128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBGNOe9gI9NaJRPLZ/Vx8tqTgrMHNSFjAjNWZOJ75IE=;
        b=BscyT52ScGdml9/bvQEugxb9WzyKgU3YE3rfrj2InDdii08pSzHZ1D458nkS27AWPt
         pvcSQH5Y3vkDJzan2VmgroA2Vu+f4T5Qv9q1zVvK/v07we2FMyHj3gL85xmrl66zZbiy
         7lnls22je3tylDUlC6OIo74WAnJYIJkJVP5OG+4uxO1rfaD4tHrf7jpICWqp77pWAtaw
         /5XSTf7WXNO01rT/73qSVb4sDuWLke0B18Sx72uSg7+wbT8asBBfIW5Usi1elSf97/eb
         LU5fxAD3gPwISBnjvYm4MF9Pe4jFD7oE8fbzbr0pldF/07Na8k1+0ySPCxVgvHR3YncT
         Ve7A==
X-Gm-Message-State: AOJu0YxlqxAFmB5Ra5GkuPXV5drskDmLbdeBIX4YooT9qonKpMrGrols
        OypIyZ2K39vEfvlXOXo4uopFbKNEMl0SgcZajhY=
X-Google-Smtp-Source: AGHT+IHD+fSj04mVDZzTiyO1sIs5ARDT8bN/p7bpEwVywaeFyhCtIvsvjFTdr/IzYGHNBQNRsGY8LA==
X-Received: by 2002:a05:6512:3c95:b0:500:acf1:b42f with SMTP id h21-20020a0565123c9500b00500acf1b42fmr322088lfv.53.1694741328035;
        Thu, 14 Sep 2023 18:28:48 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7da47000000b0052e9b50dafdsm1575836eds.33.2023.09.14.18.28.46
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 18:28:46 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-98377c5d53eso204399866b.0
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 18:28:46 -0700 (PDT)
X-Received: by 2002:a17:906:3191:b0:9a5:d899:cc36 with SMTP id
 17-20020a170906319100b009a5d899cc36mr143392ejy.2.1694741326159; Thu, 14 Sep
 2023 18:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <PA4PR04MB9638B8753EFD81E174E55BC3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96381E2BC08BD1B636067413D1F7A@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB96381E2BC08BD1B636067413D1F7A@PA4PR04MB9638.eurprd04.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 14 Sep 2023 18:28:31 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP9rytcdS1Ao4RbfEULU2kwm4fRiu1MC1H59HABWGPdEg@mail.gmail.com>
Message-ID: <CA+ASDXP9rytcdS1Ao4RbfEULU2kwm4fRiu1MC1H59HABWGPdEg@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Patch History
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Francesco Dolcini <francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 13, 2023 at 11:42=E2=80=AFPM David Lin <yu-hao.lin@nxp.com> wro=
te:
>
> Hi Kalle,
>
>         Patch v4 (https://patchwork.kernel.org/project/linux-wireless/pat=
ch/PA4PR04MB963838F12BADC1B9FD377CB7D114A@PA4PR04MB9638.eurprd04.prod.outlo=
ok.com/) for host mlme had been submitted for a while.
>
>         Current state of this patch is "Deferred". I wonder when can this=
 patch be reviewed and merged.
>
>         Is there anything I can do to speed up the acceptance of this pat=
ch by upstream?

You still haven't sent this to the correct maintainers (i.e., me) for
one. I also thought there were outstanding unaddressed comments from
Francesco. And given how much Francesco looked, I'd appreciate getting
his Reviewed-by when he's actually happy with it.

(Like I said earlier, I'm not exactly happy that y'all are failing to
maintain this driver, but then insisting the community review and
accept new features. At least if your paying customers will help out
this process, the bargain is less-bad...)

Brian
