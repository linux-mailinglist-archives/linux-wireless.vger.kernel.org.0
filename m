Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF144EB50C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 23:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiC2VIl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 17:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiC2VIk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 17:08:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF511890EA
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 14:06:56 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d142so15180487qkc.4
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EAqRIc9fT64ewsHGFESskdphI9pIsxJrpTtguJ8/Dyg=;
        b=fj4lMvN6rKaBuz6EjmSYruA1pk2DRqkImF1f/UDAr2yjOcBE0t/LXrgsp5D1tHiuv/
         uFRmPT/FtRWSNzy8bys6q1APr5tOfm04N6gxh0AzPVGmWoBFm8aGySQ9TmQi33PNKcCb
         rwynLXeqS0yAdHpEt5JWck4NM2sNdwOiOWgSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EAqRIc9fT64ewsHGFESskdphI9pIsxJrpTtguJ8/Dyg=;
        b=t6Edox9+XypKaY6p2Dpu3FLFjvJILdlM8uthTASX1VmI3GacUmy7Yy5O8jZ7ryX5z1
         Gq71s9rDAD0zDgDrXms2F0lwcW2D1BmB0ZBMwbMP5wpW0l6EG0bup5XoqYdBAKRjrz+7
         e3jtutefDSTcq4qfHnmG9laDw8zGfxVjFNXDjMlfbhtdXuuxnWQGaFxqJkrlt/JcCRlg
         q+Y6RDVHieOea38qH+0gqg04uBrj7tjhmCCK4fUohhRcBFREwezZ383TGPisf4V2EcJb
         dV8Bl2kPR0SfNh7WsHM/+WXx5B5Zh8bcSKwA1hlLIkl5kkC54YDUMfs4Lh1oiFBFC9Bq
         rwBw==
X-Gm-Message-State: AOAM530hXIajMN70ME6ogj4YzRAOqQ8WiOpIbDbePfl1rPWtQHuiFvHT
        4RQJhHweyzQj1ddgXZ7ca2GG+GxjDZGwbL2x
X-Google-Smtp-Source: ABdhPJzu3Ns5of6SoHy5wtTiSExWkz8cUHxwDe3zBkGthG6/arpBRVXk+5HRKd2msucS9C9B0BTtkg==
X-Received: by 2002:a05:620a:280d:b0:67d:2480:fdea with SMTP id f13-20020a05620a280d00b0067d2480fdeamr21634887qkp.157.1648588015040;
        Tue, 29 Mar 2022 14:06:55 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id i68-20020a375447000000b006809e0adfffsm10212204qkb.25.2022.03.29.14.06.52
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 14:06:52 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2d07ae0b1c4so196985127b3.11
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 14:06:52 -0700 (PDT)
X-Received: by 2002:a0d:df82:0:b0:2e5:ad6c:d9d with SMTP id
 i124-20020a0ddf82000000b002e5ad6c0d9dmr33485447ywe.17.1648588011807; Tue, 29
 Mar 2022 14:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <YSJ//ki/A1EgfLga@skv.local> <CA+ASDXNzv6D1PthjUU-CVw6amT+JHmJP2mNSL=LVJKGm0zkEXw@mail.gmail.com>
 <YSQC32TygIq2SHJR@skv.local> <CA+ASDXPi0RRd0gFYcON=XLu8ABwKKcRXf0j0QoCRnvDwGa0VyQ@mail.gmail.com>
 <4c44fdc2-8dde-8a98-8dd4-4b7e6b57a090@bang-olufsen.dk>
In-Reply-To: <4c44fdc2-8dde-8a98-8dd4-4b7e6b57a090@bang-olufsen.dk>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 29 Mar 2022 14:06:40 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOeC+S2d7g0b=aS_q9XxNtdayF1S5XE9T85NZrxXnK5KA@mail.gmail.com>
Message-ID: <CA+ASDXOeC+S2d7g0b=aS_q9XxNtdayF1S5XE9T85NZrxXnK5KA@mail.gmail.com>
Subject: Re: Revert: ath: add support for special 0x0 regulatory domain
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>,
        Julian Calaby <julian.calaby@gmail.com>, svp <svpm@yandex.ru>,
        "felix+debian@gueux.org" <felix+debian@gueux.org>,
        Massimo Maggi <me@massimo-maggi.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 24, 2021 at 1:00 AM Alvin =C5=A0ipraga <ALSI@bang-olufsen.dk> w=
rote:
> Numerous people - myself included - have cited sources clearly
> indicating that 0x0 =3D US, NOT unset. See the same post[1] for more info=
.
>
> I still think this patch should be reverted unless somebody can provide
> a source to the contrary, re: the meaning of 0x0.
>
> It's unfortunate that this is still affecting users, particularly when
> the original author of the patch even asked for it to be reverted.[2]

FYI, my revert was recently merged to Linus's tree and is making its
way into various -stable trees:

https://git.kernel.org/linus/1ec7ed5163c70a0d040150d2279f932c7e7c143f

Side note: it's a small shame that Kalle's scripts seem to have munged
the authorship date -- git thinks it was authored in 2022, when in
fact it was in 2020 ;)

Regards,
Brian
