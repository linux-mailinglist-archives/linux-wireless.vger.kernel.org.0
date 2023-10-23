Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0627D3CBA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjJWQh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 12:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjJWQh5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 12:37:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C63192
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 09:37:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9becde9ea7bso971036966b.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698079073; x=1698683873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct/gmOMoVVJtQu5z9djy0mxrQl9IOVEya9FqRFQMvVM=;
        b=lv80mSoh8YDoxFwvFtHcJtLnlCW70fQL+mMZuof8i7q6UEDSAY8LXtY2dAIXVaxqn/
         cKfqTEpB4p6/4Q0p50joGp3FSS7Z69eBrhJOsawSpXRPNaAZ+znom7ScFBJLWgcvhAWR
         D5psPv13jk+xXayPrElX4dHIxpMVpXe1fdqv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698079073; x=1698683873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct/gmOMoVVJtQu5z9djy0mxrQl9IOVEya9FqRFQMvVM=;
        b=XoZKnVDjto2f+6k6CzTMzYBXSJE1YJ7aD4dBV+hSA+YdEvbherJ49j8IRHMpHEyqc0
         peqAwn68O3IS3WEL41oSQDt9rbqcoYp4JDFoRPoLJ5gZMHIFOHYz75ZzJekQwio5B8dO
         wSMsWy0m1Eu682DmY46XQmcU/eOzZjA/qdo0h8ipaVPHaWkSbTz7vZ8Ny6heV42/y/XY
         jkeqSjRwex8l/xJKp9gNAY3v2YEe6Ln+rzYmEIl+eAWPP3c8IEH81UChBRGR7H0Diyup
         UBsoPGTkL1ju0fMzYKHMVdbl23qBW2Hv0J3N4bs+bLPd3s2cPcoR541zhqjEsc0nnNkV
         jSoQ==
X-Gm-Message-State: AOJu0Yy3RVCMnOHoPORvD70Xj+c+cbxzH0p99QY8jtZEg9S/5wooxEeB
        e3eEUB8jj5sgko6OARQpFTXmlg4+1qO6dVOIuzA=
X-Google-Smtp-Source: AGHT+IFVXPPbeooleSegOqp9rwwedo1WoIsFK+qVM99Ubz5QtnAHIAiYc1rODvqjWMoSEebNbf7RNQ==
X-Received: by 2002:a17:907:9687:b0:9ae:614f:b159 with SMTP id hd7-20020a170907968700b009ae614fb159mr11887218ejc.36.1698079073575;
        Mon, 23 Oct 2023 09:37:53 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id li18-20020a170906f99200b0099297782aa9sm6760628ejb.49.2023.10.23.09.37.52
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 09:37:52 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso26065775e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 09:37:52 -0700 (PDT)
X-Received: by 2002:adf:f446:0:b0:32d:8b05:c363 with SMTP id
 f6-20020adff446000000b0032d8b05c363mr9711303wrp.34.1698079072229; Mon, 23 Oct
 2023 09:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231020094654.33258-1-dmantipov@yandex.ru>
In-Reply-To: <20231020094654.33258-1-dmantipov@yandex.ru>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 23 Oct 2023 09:37:35 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPwwSvHFcTrV+PmpXMFxWaY+VyUS9qNFzHnMKxMXNnT1Q@mail.gmail.com>
Message-ID: <CA+ASDXPwwSvHFcTrV+PmpXMFxWaY+VyUS9qNFzHnMKxMXNnT1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: mwifiex: fix SDIO firmware read timeout handling
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 20, 2023 at 2:47=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> In 'mwifiex_sdio_generic_fw_dump()', move the check whether
> 'sdio_readb()' has failed for MAX_POLL_TRIES times out of
> the reading loop. Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

We've already discussed and rejected this patch, if you aren't
planning on doing any real testing with it.

Subject: Re: [PATCH] wifi: mwifiex: fix SDIO firmware dump wait
https://lore.kernel.org/all/CA+ASDXNu-CWa9V5Oc-01pLp72iMVRw7m46+bDdNUxVmfrR=
9PSQ@mail.gmail.com/

It's *probably* correct, but it's risky without any cursory testing.
