Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C40765A49
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 19:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjG0Rau (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjG0Rat (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 13:30:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0102728
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:30:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so2175048e87.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690479046; x=1691083846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZmBNPq0bcXUflBuXMJNXmIiGvqz8QlpNJrRgcAYdfY=;
        b=k1AoEeqnaDAhamA5/3mqdn9o9WLTG22yhIz3U9J5jwTK3toyvtph9Mf/0C0bKlgjSg
         r1OxHfUWrHoLj+UMge42IvP81qaA/x76m+f3oKamrpKEfCXzx035NddYa5NRX4Qscg/j
         qugtlwmkQ//IT3mRHlRVO/zaAzWWvjqRHM2Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690479046; x=1691083846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZmBNPq0bcXUflBuXMJNXmIiGvqz8QlpNJrRgcAYdfY=;
        b=AbNJQt+hxM7deg7jrdzLZkRJqtcPUYxCcp4io35yQG/lCijXBl8Zxa8c5mTJLTCrEZ
         8vE8Lq60y1RposwbgggXm3vbO2M/7xG4N7ftECr2ToXPlvYcMdz6mkRsWvAm1xV9h7l2
         gPURiVeVwDhqnIim/3Ycwaitfx7AMphGjdu+3liy3K/lLF0TIiOOtfkXBpebzcONMHn2
         nT6FF2vEe4AcUZDAQmaxUVxwnEcjNcH3wmuNWtGO7tfyF6Y0wdg8PW+hRcFf+ScYPo1W
         IdbTt9qPjg9gBQR8XDslGpw+erzetS8uGIPWn+1cqnvLKx8b2grRWveu7wkuA/SPAIiR
         3KCQ==
X-Gm-Message-State: ABy/qLYKAbIjAImGN9kMjUzaWbLZgp4T8g31Vnpk0vXHcEjcw23/RD1g
        eYIZyCpB9TLmk0eDpNj9TOpUiPa7iH/dYYR1NU174Q==
X-Google-Smtp-Source: APBJJlFn6DeLET9uLvGaWVtutZIAwzZo6NudxKTV2NZ2AsGLZGktLyC2eArwFseK4mJXIv7AiqitIA==
X-Received: by 2002:a19:e612:0:b0:4f8:752f:3722 with SMTP id d18-20020a19e612000000b004f8752f3722mr1752984lfh.5.1690479046182;
        Thu, 27 Jul 2023 10:30:46 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id j9-20020aa7ca49000000b0051873c201a0sm852312edt.26.2023.07.27.10.30.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 10:30:44 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so165715966b.2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:30:44 -0700 (PDT)
X-Received: by 2002:a17:906:3f16:b0:994:3207:cddd with SMTP id
 c22-20020a1709063f1600b009943207cdddmr2507999ejj.34.1690479044218; Thu, 27
 Jul 2023 10:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230710030625.812707-1-azeemshaikh38@gmail.com>
 <169047317161.2400214.15246406234885315012.b4-ty@chromium.org>
 <87pm4dz6js.fsf@kernel.org> <202307271003.BCF5F3597@keescook>
In-Reply-To: <202307271003.BCF5F3597@keescook>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 27 Jul 2023 10:30:29 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPak0M4zSwiTFpkRxw_WOmBmKJUTi9i5wCOY89fiP1vng@mail.gmail.com>
Message-ID: <CA+ASDXPak0M4zSwiTFpkRxw_WOmBmKJUTi9i5wCOY89fiP1vng@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 27, 2023 at 10:04=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Thu, Jul 27, 2023 at 07:02:31PM +0300, Kalle Valo wrote:
> > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.=
git/commit/?id=3Dcaf9ead2c7d06fd7aa4cb48bd569ad61db9a0b4a
>
> For the patch you linked to -- it's okay to have lost the overflow
> detection and warning?

It's a fixed constant string being copied into a larger fixed array.
It really doesn't matter functionality-wise. At best, the error check
would be useful for human readers or automated tools. So I didn't
bother complaining one way or another, as it took enough tries for the
submitter to get things right in the first place.

Brian
