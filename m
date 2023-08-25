Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9218A789279
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Aug 2023 01:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjHYXj5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 19:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjHYXjk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 19:39:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3381F2736
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 16:39:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52a4b62c2f5so1995515a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 16:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693006749; x=1693611549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARAkvhj7ZJCGS7HKCILL6B4n+8Rbnyk4X5Sfz208Kk0=;
        b=QVGmFqsF4/K5NVoJoJF+dUyFvy7vxGVJw/2VXZ+2uZidyZ4CawnajEyf4nSeJ43ACl
         zsm3vqdDdSaMDQDB8amtxmHw3u+uXWhKayeIGMmRXZoMlA7C18saeGyS87eVkzoPloL3
         R7KuHQ7vtbPQRhiN+GormH5u385wcE4qcpoNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693006749; x=1693611549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARAkvhj7ZJCGS7HKCILL6B4n+8Rbnyk4X5Sfz208Kk0=;
        b=j1DJaAPkeNJihftgbei0LZXdBnFn4vKhR/VuzaJe0myQUoqnDLr6st8iv2XbinRk1y
         tBTxsw3OgX5CEMyxThIkyuGnhPYh+Jmd3/EArNugFtR9S7u4d6Pz3dF0viYRq8LVQzBe
         IQojLAiuNExHaxM+rtWlSDyHJR5NfjaH3M+/upMY7iVjKBJotGOhnJvNvML0BnnlthZR
         4qir5EEXh7p86ZHSIkd/8/Q/i8fqKSRQjjLAChUc4eRyJflrH298mXn6l72zuuQkzqqL
         zsJiZrSxZdMbcuVIAWH5rYnGkFNl6+8kjcjH1WIJf3/EBCzI145I0hqHB88MmngPKZiE
         J19Q==
X-Gm-Message-State: AOJu0YxFwvovnYt7K1qfORx6lJhTCzP304NaQsGvX/7eZv05svTX2DkU
        xzsc4BnHAXAwd3xS1jSF4Wy/bCIE/8xexmNgj2w=
X-Google-Smtp-Source: AGHT+IHALzM8Twq+HAMnRlCcpUfWzKbWRglJf8Nx/Bm2hcF/NOk7qWxJudU9CJZUO27YoQIJYoPX7g==
X-Received: by 2002:aa7:d502:0:b0:527:3552:7504 with SMTP id y2-20020aa7d502000000b0052735527504mr15468418edq.32.1693006749605;
        Fri, 25 Aug 2023 16:39:09 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id k8-20020a05640212c800b0052a3b212157sm1483949edx.63.2023.08.25.16.39.08
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 16:39:08 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-986d8332f50so182463066b.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 16:39:08 -0700 (PDT)
X-Received: by 2002:a17:906:59:b0:9a4:88af:b82 with SMTP id
 25-20020a170906005900b009a488af0b82mr2214834ejg.77.1693006747785; Fri, 25 Aug
 2023 16:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692931954.git.gustavoars@kernel.org> <d4f8780527d551552ee96f17a0229e02e1c200d1.1692931954.git.gustavoars@kernel.org>
 <202308251410.8DAA6AC5E@keescook>
In-Reply-To: <202308251410.8DAA6AC5E@keescook>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 25 Aug 2023 16:38:56 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNxYZsxFcF2iiKidBr4znsS5ejjmQKU_pdNpsrAqyeXEg@mail.gmail.com>
Message-ID: <CA+ASDXNxYZsxFcF2iiKidBr4znsS5ejjmQKU_pdNpsrAqyeXEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 25, 2023 at 2:10=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Thu, Aug 24, 2023 at 09:10:45PM -0600, Gustavo A. R. Silva wrote:
> > +                     mwifiex_dbg(priv->adapter, WARN,
> > +                                 "TLV size (%zu) overflows event_buf b=
uf_left=3D%d\n",
> > +                                 size_add(sizeof(tlv_rxba->header), tl=
v_len),
> > +                                 tlv_buf_left);
>
> With the suggested change to make this a warning and not dbg:

mwifiex_dbg(..., WARN, ...) *is* a warning, not a debug message. Or at
least, that's how it's used throughout this driver, even though it
actually yields a dev_info()-level message, regardless of the 'mask'
arg:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/wireless/marvell/mwifiex/main.c?id=3Dv6.4#n1811
