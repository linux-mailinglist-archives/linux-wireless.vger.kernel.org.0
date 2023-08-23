Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B871786101
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 21:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbjHWTts (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 15:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbjHWTtr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 15:49:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B8E67
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 12:49:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ff91f2d7e2so8684081e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692820183; x=1693424983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4WSprjBGosihTJ3FnjKhpL7H8uWI7MD97EU3sDPTuI=;
        b=NRlisAwQNvj+Fer9/CBiJBqwnEPeDfYZp9ytGw+L3N4ca1HMrtw5lNrSLg/Yx/HyS1
         9juaxd0oLemhIx9HNfOO1eVjnLK6+zSEjeBUW5Rq+rIu7IdIrf6yq5+Tw0JMVmZZpVbl
         EDW3Way00EPjjPz9tVmPDPwKfoMXuEKA8mImQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692820183; x=1693424983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4WSprjBGosihTJ3FnjKhpL7H8uWI7MD97EU3sDPTuI=;
        b=VHxguins0J68u2XKRcgxQrRP33tNlZ6dgh+FS2qH8YH4g9uZP4LXxOmrfD/+ljaI3n
         HCq/7I4SSOiCWKOQ9c50/ExyISqFL99587vTuPKNkiHkpPnAZkXebWPhpfC6CUOKgX7h
         QFMXruCxLpw/HK2H3FyU3jWb8PNxxRMru1JAKlgrMMjtOUBQqd962zPVJB126fiJwrh9
         5aVmjSEpLBL6/te9BWhwtEB5Lu+eO3LujpBdifL7SLfH9Vr4n36aKbHBM6X3ESojEEmD
         t0fipYDjAofQ+37u8oYCDXJixV76KrmN/CzR8gCmT23asHBI8WbvQzml9i4PS1/YPXZ+
         29tQ==
X-Gm-Message-State: AOJu0Yx1WHduZMwotFT/ihKl3FR/zDyWMQNO6T9u2NSiAwpu+YwOM/Oe
        eekcOeRvrLq5DFm38lLgi8sKDoSBBh5MbFaiB+M=
X-Google-Smtp-Source: AGHT+IEX6YluBCtCUSRPQQ4hbnDo/MxxJ5wHpVvDiIVitTdbpwJAhRdSpd276HQqLAr45shAmX0CMg==
X-Received: by 2002:a19:4f0d:0:b0:500:7c2a:30da with SMTP id d13-20020a194f0d000000b005007c2a30damr6750591lfb.60.1692820183144;
        Wed, 23 Aug 2023 12:49:43 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y17-20020ac24e71000000b005007fc9cccasm1637297lfs.94.2023.08.23.12.49.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 12:49:42 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso63402331fa.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 12:49:42 -0700 (PDT)
X-Received: by 2002:a2e:958e:0:b0:2b7:4169:fcf5 with SMTP id
 w14-20020a2e958e000000b002b74169fcf5mr9893140ljh.37.1692820181518; Wed, 23
 Aug 2023 12:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230802161049.89326-1-dmantipov@yandex.ru> <169278633096.1133515.976396654998983133.kvalo@kernel.org>
In-Reply-To: <169278633096.1133515.976396654998983133.kvalo@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 23 Aug 2023 12:49:28 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOTyRtMgNc47v=Qy28Y+grCh=xwL31qZM9YXVjkbwGC0Q@mail.gmail.com>
Message-ID: <CA+ASDXOTyRtMgNc47v=Qy28Y+grCh=xwL31qZM9YXVjkbwGC0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: mwifiex: simplify PCIE DMA mapping management
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 23, 2023 at 3:25=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Dmitry Antipov <dmantipov@yandex.ru> wrote:
>
> > Simplify PCIE DMA mapping management by eliminating extra copies
> > of {address, size} pairs to/from temporary data structures. Map
> > and unmap operations may use skb fields directly via introduced
> > 'MWIFIEX_SKB_DMA_ADDR()' and 'MWIFIEX_SKB_DMA_SIZE()' macros.
> >
> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>
> I assume these patches are compile tested only so I'm very reluctant
> take these.
>
> 2 patches set to Changes Requested.

That's fair IMO. These kinds of patches put a much larger burden on
the reviewer to make sure they make sense. Thus, I had this in a
backlog to review, and haven't gotten around to it.

If Dmitry can prove out some proper testing, maybe the status can
change [1]. Or maybe I'll feel charitable and look/test them more
closely.

Brian

[1] Although, I don't think I have permission to change the Patchwork
status, so it still might be lost to /dev/null without a RESEND.
