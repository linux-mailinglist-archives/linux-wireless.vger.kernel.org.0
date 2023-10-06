Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE27BB58E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Oct 2023 12:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjJFKoT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Oct 2023 06:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjJFKoS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Oct 2023 06:44:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578EF93
        for <linux-wireless@vger.kernel.org>; Fri,  6 Oct 2023 03:44:17 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso2150781276.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Oct 2023 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696589056; x=1697193856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF4qlKwd4w+smxnMgZoL2HwYCcs47lIJaGMxJKpzeU8=;
        b=IqdSNqB/Zzrws6wk+i4bDDlQxPPgllPCdptweN5CLNg4XNcV+MMoTAgLstclVUXyt7
         TJf8HvzjpB8ImV0po2/H98zHwBwiOinY+8ef3ZdY8jSzTDNHf+v3LdlUCPyIZ+VIr1sk
         0VIfbVIwoMnK72SmI/qxCjkfjhI5NCDdu2Uny6ubWrx2N5QiR2TrF0tF2Z6+cI6Is+Zf
         MMfmSXEJRRMXEwIU7Ks5+RyQ/mSCbTes6wRndSQtZoN0pZCQhjp6WcptQuvLaAi8ujb8
         VI3Hc8q24Q9xPekEAJC9DqdEYZd1zF9tti5T6UANJEHnnTWrPdbUDhxRMIy2Z5NTW2ch
         xU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696589056; x=1697193856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZF4qlKwd4w+smxnMgZoL2HwYCcs47lIJaGMxJKpzeU8=;
        b=piN8MTpZc9TT9oa2Ji7YaTR080+EIaOZKR0wqwqBK3vI2AAp+GZHwAvA/WpeJK8arO
         UqI90XMsJJBcMzGRljuhinYkTgx2b5htBG/fNC342BRHcMxRrxnELNQ3ozscCRNIZhk1
         D+SNiMqOh6RiXYUyhKolNvlNxSMJcGRozSsSlWfcfmBBt18ARBLgKJzbraxltugWzQgX
         N9Em9GAYGApFACSsxkz89HVrYIrnC4HNzBIWVrIu/b2JpjxNK9p2aV/SPP7LQaiBtM9x
         yFG7y4+O6U7XTHsWATXCWIIoathzKa7cx7NAhUaPLUKvUeRQj+6yHhLfd0tZXSJnpAlz
         hYug==
X-Gm-Message-State: AOJu0YyoyYNLj2/bhYRio19thGexpSRs7imQNSTWvhQd5/3AelcktFkc
        43jwJoGRfhbI6TnY4WKBAxTj+jdwlwhew/quCHM=
X-Google-Smtp-Source: AGHT+IElmr7ARN4PVlJkPOGiLC/UM0SYicz+oB5cBwjSWPT7rSUI6DGw38GoqFYWHgPINNw8PgJlwqxFTKip2v6bZDA=
X-Received: by 2002:a5b:ec7:0:b0:d81:504f:f883 with SMTP id
 a7-20020a5b0ec7000000b00d81504ff883mr6679893ybs.8.1696589056415; Fri, 06 Oct
 2023 03:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
In-Reply-To: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Fri, 6 Oct 2023 21:44:05 +1100
Message-ID: <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
Subject: Re: On brcm80211 maintenance and support
To:     Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com
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

Hi Dmitry,

(relevant people and lists CC'd)

On Fri, Oct 6, 2023 at 3:16=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru>=
 wrote:
>
> Kalle,
>
> what's an actual status of brcm80211 driver? It seems
> that the relevant MAINTAINERS entries are no longer
> useful, and [1] states that Broadcom is just "disappeared".

Arend hasn't posted since February:
https://lore.kernel.org/linux-wireless/63f72045-e51d-d9a4-a0ed-c221bcdcee03=
@gmail.com/

Franky is still reviewing things as of early August:
https://lore.kernel.org/linux-wireless/CA+8PC_evb-6Y3dKnAN4BN=3DODEVxY5-cDb=
6Lc72u0j1WBtx7p1A@mail.gmail.com/

Hante hasn't posted since 2018:
https://lore.kernel.org/linux-wireless/4f6223b8083ed69432493a37d4f45b69@mai=
l.gmail.com/

Hector Martin has a bunch of Apple-specific patches downstream in the
Asahi Linux kernel and has been looking for guidance on how to
upstream it without any real answers:
https://lore.kernel.org/linux-wireless/181af6e9-799d-b730-dc14-ee2de2541f35=
@marcan.st/

There's also speculation that the Raspberry Pi people have downstream
patches too, but I haven't been able to find anything concrete in a
very brief search.

Finally, the Cypress / Infineon people appear to be uninterested in
discussing the driver.

I think it's pretty safe to say that this driver is nearly
unmaintained by Broadcom, definitely unmaintained by Cypress /
Infineon and Arend is unable to answer questions relating to anything
beyond the code as-written.

Kalle, should this driver get orphaned?

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
