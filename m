Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8DE76872D
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jul 2023 20:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjG3Sy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jul 2023 14:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjG3Sy7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jul 2023 14:54:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB7E10F0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Jul 2023 11:54:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bccc9ec02so602329466b.2
        for <linux-wireless@vger.kernel.org>; Sun, 30 Jul 2023 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690743296; x=1691348096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CsgxYeVNAKqq0TkBmv0SJwbSdxKX+1Op5moF7xjxno=;
        b=ICEWleaKt5pmDbCbbzautteIbSdR7cWlO0bquHlQ3p8fqx/9jlNI8PswJnY3DB5SVQ
         afu/z7EEMO7z2YByKU5pZBD/xOOx26IZhVFw5BmCOxIB1Uy/3MApIOp8VjjhwAFxjR37
         O8Ghg+iEkGJ8rIE1fAhCHx8x+xW4giKhrMjWSRxXLYM2KNuNi9C4gy61BpHCOtMb5h11
         eqCXV5ApDz6hoShOckCVWEIqDleX7idSqcey5GR+8WKtx5wfUuLzQsHB08IAg6vHq/zW
         MCqlXlYR0pmf2CjkwQmwBuJgZ7jiVoVR8CHolTL+FZjVGChZU26p0tGOkywZbRelsSJK
         YCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690743296; x=1691348096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CsgxYeVNAKqq0TkBmv0SJwbSdxKX+1Op5moF7xjxno=;
        b=g1W3iX9Qh8meb+CmI+Jcaq+9zTkeH5idAM0t4ZWdlzhoF2TEJMDzo/PaK5XmkpRGiA
         n6rAUF6fFGD1EGnxXpBguMI8ebMVshwqkb0aAoenuzypjfKNjohsWoBV6lutfkF6oE6A
         1RtpprD3V2S8kS3Fhti3oW+nCK/jMcpz9g6S7+Kw86OTtGRrWmdhs6KcUIgFyR4mIWvd
         PzRYsN7XpcJKUs/EgI/KoX1SbUfCH6P5OUsP5i+ivQYmz/i5XN3hsKIxuoO+joKMk4oY
         ctdFsnepP+28KyyjB95gcmwTO9hUwUVSm5HrXw1p1b2NMjv63rdFNAvbBRYAOircThTO
         6EKg==
X-Gm-Message-State: ABy/qLaBbTgWTtBL55EdIzhObTQoQ5Cmiqz3zK+96TEy2gS2RlHFyARQ
        9aOtJ9binwbABPdOzX7eVsZu+veGKPJ8ri6UuiFUyHDM
X-Google-Smtp-Source: APBJJlFtN7KPAarPw8vVM3+cFx6iW8B/EC5Oe7L+TwN340/0NyQHctQqSXRp357zGRjGfcv8Nnc183djept2YaHwWos=
X-Received: by 2002:a17:906:2258:b0:98d:fc51:b3dd with SMTP id
 24-20020a170906225800b0098dfc51b3ddmr5999177ejr.41.1690743295713; Sun, 30 Jul
 2023 11:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <52233a6e-e880-5160-7042-5a0dcce21b03@lwfinger.net>
In-Reply-To: <52233a6e-e880-5160-7042-5a0dcce21b03@lwfinger.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 30 Jul 2023 20:54:44 +0200
Message-ID: <CAFBinCDgJM65WC2JenR46OEcPsW=4+3L5ei_Kr_88kGNrTT-Bw@mail.gmail.com>
Subject: Re: Problem with rtw8723ds
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

On Thu, Jul 27, 2023 at 2:41=E2=80=AFAM Larry Finger <Larry.Finger@lwfinger=
.net> wrote:
>
> Hi,
>
> I am trying to help a user of rtw8723ds. The original problem was that th=
e
> vendor driver was causing a spontaneous reboot. As I have no interest in
> "fixing" that driver, I steered him to my rtw88 repo.
>
> The driver loads, and then nothing happens. [...]
I have a few questions here:
- is the wlan0 interface present?
- does "$ ip link set up dev wlan0" do anything?
- does "$ iw dev wlan0 scan" work?

Also do we know more about the host (e.g. which MMC/SDIO host driver
is involved)?


Best regards,
Martin
