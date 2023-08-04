Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222EA76FE92
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 12:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjHDKdw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 06:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjHDKdv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 06:33:51 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9585A46B2
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 03:33:50 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58451f0fefeso22431837b3.3
        for <linux-wireless@vger.kernel.org>; Fri, 04 Aug 2023 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691145230; x=1691750030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNrJ1HOAbiZBfVR0yPv5HkzEwWdU1S+Y3YLuwqkaxX4=;
        b=gl4Nse/NngXGPKBpTA52zVvyYeENNIR/0/eer0RW2AcBiRcTWQZCpq/emo+ql/IVrP
         oSlzrobH3xHdOUudmOCu3s2lHxsAQWUVLjAmPxFCx2FlrTgRnNEwb3/0kKo23CW1d14B
         WoSxdXrX/qolXgaxetPTXgq/Kfzja9NwlCc8QPVmQFI5Nc1nr8txsYakORX3ub3Vtptq
         Z/dmOWim6NhIefFKmSRmlgOqTez16xfAo+HsjuTKH3s+dQ7n9XAAOhd98ijShDZufcko
         2d/h872fKz6KiyyEGorfkoNvDyeU4PfyHNqsxaB0hUccVJhsk2GUXgYCMNvT8lUW/gaK
         LziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691145230; x=1691750030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNrJ1HOAbiZBfVR0yPv5HkzEwWdU1S+Y3YLuwqkaxX4=;
        b=EfrscOAFjYDYqTg0VoEYzzAhyCY5FzY4eg2FFihjuBaduSwSwpqRFetiTSQ16xohdH
         uH6Yy8d0nqvA43Hh7cLsEuVGJrE8O+38VTfAIWw/qDsDDXX0/pD77NzFfEAWL3tXvlLX
         qROAyM8Lcfo29OLjSaqJN+i7ikPPXlL4ZlSx7o4T9poHeWTAD9S6mNeqtxNK6fjsN3ON
         o8QOw5wFpysoyDJNBi8p0sB4TDyh5sSn+hmIjrriRUJivyaXeoCYadvcF5lS42RSeyQl
         pl8YWNhAliSNsVxtIwOOx1c4jaWb7JVz/aGB7XZkLzBV9wJu5u8nx2w/8M7h9Y0n5Zrr
         Hqyw==
X-Gm-Message-State: AOJu0YyiwEQgXv16bHxD1t+dVSWf9lClnZHNqT674MVal1HdUm/5W43j
        DDvahPDwaDFKXn9XYeO3x6yzFhGNYUT1fmvH+AI+oN1+
X-Google-Smtp-Source: AGHT+IHGZi+tAsUsFcGRJ8AJMJr4ApwVYBL46H7w4p4cG/StaRGDULPOegoYrSePo+qTikAycyYJg1L/yJ5vrRxh01o=
X-Received: by 2002:a0d:ca89:0:b0:583:9018:6fbb with SMTP id
 m131-20020a0dca89000000b0058390186fbbmr1264511ywd.37.1691145229780; Fri, 04
 Aug 2023 03:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <d42463c65334bc1799648b116b9e0daecf57c844.camel@realtek.com>
In-Reply-To: <d42463c65334bc1799648b116b9e0daecf57c844.camel@realtek.com>
From:   Josh Boyer <jwboyer@gmail.com>
Date:   Fri, 4 Aug 2023 06:33:39 -0400
Message-ID: <CA+5PVA6LkCGWCRS71d6GoZQ-LaZpGTs6ukzwiW4HJrCb2FsJ2A@mail.gmail.com>
Subject: Re: pull request: rtw89: 8851b: update firmware to v0.29.41.1
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 1, 2023 at 10:46=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi,
>
> Update 8851b firmware of rtw89 driver to v0.29.41.1
>
> Thank you
> Ping-Ke
>
> ---
> The following changes since commit 253cc179d849fc82489773b2b553a49858d872=
5f:
>
>   amdgpu: Update DMCUB for DCN314 & Yellow Carp (2023-07-31 11:22:02 -040=
0)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git HEAD

Pulled and pushed out.

josh

>
> for you to fetch changes up to 29f185d75c45ab96473b4ee06bc82c0b3ff966b5:
>
>   rtw89: 8851b: update firmware to v0.29.41.1 (2023-08-02 10:41:59 +0800)
>
> ----------------------------------------------------------------
> Chin-Yen Lee (1):
>       rtw89: 8851b: update firmware to v0.29.41.1
>
>  rtw89/rtw8851b_fw.bin | Bin 1090544 -> 1161008 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
>
