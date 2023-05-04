Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1736F7484
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 21:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjEDTvN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 15:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjEDTuW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 15:50:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14551150C5
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 12:46:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso159718266b.2
        for <linux-wireless@vger.kernel.org>; Thu, 04 May 2023 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683229543; x=1685821543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyTt7tGov3iBmFi/kzGDUemFQGYK+SpkwEhsD2aEmi8=;
        b=gpq2ciqVx8BSdPLw5JYIFMR5xyKVU2T0OpoSV1meZuIwNxp0A71GNHyqkmz6aQTruM
         cR4XpcLsBzFm6+2laIVTivInHfwAgcTYzomzSSXUg3ZlsF3V1yQ9sco9x7JXKPQRbXFW
         ul5orePYQy5eNhaDjfa7ztld38+QLhBB1nc2PLKYoOMAe1nhVLWmkWHlWYXYJrbaQFAn
         bWP32gi6i+5cQGfMv3StlnYzqbu++M1c7WdLj/qHPU2d1eGz54RKr5rai1SEQK3zGsBf
         tC0VRraulEsU0SYpqoFcgl/eQJOabISeFa6KW6Zqo7a+ty1gLh6i4cmF+dWj00vln1Io
         9qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683229543; x=1685821543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyTt7tGov3iBmFi/kzGDUemFQGYK+SpkwEhsD2aEmi8=;
        b=Y/19IWa841/+gCCYk8RBJB5HUH2Q4+2b5KCYXYGlAasuaiSxgabwqo4uA2652f9vwT
         PhgpPbLEVE2W8w0CSNPXq264yARpkschnWm+MWRONgiRT9yMVdpNrvf4arjf16z+r0gg
         Ig76EErHJAkvSEJOazqHdEB9Nw+gUm8FW0TxzabUkaUZMX8cTZhGkFlYgPSFbqVM7uV5
         L+iPa8cFmvX+bYs16mztr2lt/SIMembrO1qvVWeo2gCHfSui4SibQw7hxYifEV2pa46x
         6KrK3+jmYRN3ftUoHg0AfsLKldnT8r8ELh9KCrM7xHgum8nrstLIp8jbePs8/kz5c+vC
         KRmQ==
X-Gm-Message-State: AC+VfDzALSTqOF3ctyOiPZMYyUJyTB4p3KIKbXhV1Xns0tt9yhP7kZ8Z
        FUrkLoHtTeCF+tnURVdGASNrPVCUXI759CXvEPl86dEioUk=
X-Google-Smtp-Source: ACHHUZ6mBoHkh+nEEksxOImtonU0rw1s8jW9oaV7pdGgVDhXzYwdVIhAnZGQd/8EVx8Rv3qsZRWrRAQjNeAWamGkdfo=
X-Received: by 2002:a17:907:6d0e:b0:94b:4a4:2836 with SMTP id
 sa14-20020a1709076d0e00b0094b04a42836mr7087927ejc.69.1683229542539; Thu, 04
 May 2023 12:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <5930608.lOV4Wx5bFT@jernej-laptop> <813d74b8-6d9f-c7b0-40b4-c661fca13002@lwfinger.net>
In-Reply-To: <813d74b8-6d9f-c7b0-40b4-c661fca13002@lwfinger.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 4 May 2023 21:45:31 +0200
Message-ID: <CAFBinCB3xnCrLvEvqsFMQuDxL+xC9tkxnwubfC+xEMP3-ZXqSg@mail.gmail.com>
Subject: Re: Driver for rtw8723ds
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

On Thu, May 4, 2023 at 9:25=E2=80=AFPM Larry Finger <Larry.Finger@lwfinger.=
net> wrote:
[...]
> > Can you ask that user to test following commits?
> > https://github.com/xdarklight/linux/commit/
> > 3866a7a3702f7f24557f2c065b7d4088f7027466
> > https://github.com/xdarklight/linux/commit/
> > 66fd078556a6bf246337270b2e91d73c079fce2d
> >
> > Patches are trivial, but some testing needs to be done to confirm the d=
river
> > actually works as intended.
>
> Jernej,
>
> The user needs the rtw8723ds driver - the SDIO equivalent of rtw8723du.c =
that is
> used by the USB device. The riscv changes may be needed, but we are not q=
uite
> that far yet.
Strange, can you please elaborate what you are seeing in terms of riscv?
The two commits that Jernej shared are for an update to rtw8723d.c [0]
and the addition of a rtw8723ds driver [1]. None of these mentions
riscv (at least that's what my tired eyes are seeing today).


Best regards,
Martin


[0] https://github.com/xdarklight/linux/commit/3866a7a3702f7f24557f2c065b7d=
4088f7027466
[1] https://github.com/xdarklight/linux/commit/66fd078556a6bf246337270b2e91=
d73c079fce2d
