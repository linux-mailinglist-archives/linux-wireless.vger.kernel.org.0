Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EEC5E6CEB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiIVUSy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiIVUSv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 16:18:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56FD110B2F
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 13:18:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sd10so15188594ejc.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 13:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=NDO0U2UAkxom6B/vKmGU6leLU1q56zq7MbA2ldNi6o8=;
        b=EofDMRLPGnmrn7D2aMk2jnEyOUnqXxod4YuTMi74m9AdGAGIwnK6JMCkahvBdYeDPY
         8p/+T38ry7VqjEEwvfs5/XBVWYVUUTVWDvrPnHqYaWNzhQuZqQOb4nV1pFqjqXGvD7rw
         f2lukCsQAHY9XlEhDXo9VPx/8WycDhB19QE4Q1YCBkUJz7w+Abk4Zwp/z44cRQJXuV70
         4VpC2s1FiHuWEcY3eGEpa5O4UkxwM7bK30XBMH5DUxVABHVk0k9EJKMFoYPQe1IZ7kEJ
         VnOC6B+TKFx42PPcmrYUHr7DsDzXkFx9Gxz8nTtsMeeU7FOwGKXsp3nmyJRAhZMqd9a7
         SAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NDO0U2UAkxom6B/vKmGU6leLU1q56zq7MbA2ldNi6o8=;
        b=icuipXevQ8EFb8V2bxLUZxk4tWwc4QI4xDpYpFz30Qs+13rW4My+m//mpCsoUhUVfk
         vAuI98uLDCC1jVRUiQfQtlf4elOmL4Z77yhnyn7Is5TPcU43k/0YkairI9dvfxSq2uyo
         HApqcxli5+g0pjx1bWwK162CEVxty0KPuvUM1sXYvsY618SJkMFFjFxrShctFDK6nKp6
         RTf9XjYvCEa+0tdvWsWALiBNvulyj/PSuWSM2YNcGFUkRA0Aob22VnAKPjmpkHYWEiFL
         eFJlD7fmd6ZDENFbr/arS7srNvayPX+6ZEWg+ojH9WOZ4TcyQJuOFusSi1yMo1JNcBl+
         5STQ==
X-Gm-Message-State: ACrzQf0c9tIA9r/2AlfEM4G/YOdvE15RfIIeEaKJxMwypkqew7CDyN7X
        D0SS649J2XAGHbVpwu7NGolH/GnSaQEbozX0Juu9Mg==
X-Google-Smtp-Source: AMsMyM7BcrNg51Tr7q/VG0RhxQhzc7nQIizTaXOmikiRdK1UFJHN93ZpgyKsrarbFnUiA6hdfRJyFfcSBJiKI7HEnU8=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr4232898ejc.440.1663877926361; Thu, 22
 Sep 2022 13:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220921001630.56765-1-konrad.dybcio@somainline.org>
 <83b90478-3974-28e6-cf13-35fc4f62e0db@marcan.st> <13b8c67c-399c-d1a6-4929-61aea27aa57d@somainline.org>
 <0e65a8b2-0827-af1e-602c-76d9450e3d11@marcan.st> <7fd077c5-83f8-02e2-03c1-900a47f05dc1@somainline.org>
 <CACRpkda3uryD6TOEaTi3pPX5No40LBWoyHR4VcEuKw4iYT0dqA@mail.gmail.com> <20220922133056.eo26da4npkg6bpf2@bang-olufsen.dk>
In-Reply-To: <20220922133056.eo26da4npkg6bpf2@bang-olufsen.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Sep 2022 22:18:34 +0200
Message-ID: <CACRpkdYwJLO18t08zqu_Y1gaSpZJMc+3MFxRUtQzLkJF2MqmqQ@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: Add support for BCM43596 PCIe Wi-Fi
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Hector Martin <marcan@marcan.st>,
        "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "martin.botka@somainline.org" <martin.botka@somainline.org>,
        "angelogioacchino.delregno@somainline.org" 
        <angelogioacchino.delregno@somainline.org>,
        "marijn.suijten@somainline.org" <marijn.suijten@somainline.org>,
        "jamipkettunen@somainline.org" <jamipkettunen@somainline.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
        "Zhao, Jiaqing" <jiaqing.zhao@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Soon Tak Lee <soontak.lee@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 22, 2022 at 3:31 PM Alvin =C5=A0ipraga <ALSI@bang-olufsen.dk> w=
rote:

> I would also point out that the BCM4359 is equivalent to the
> CYW88359/CYW89359 chipset, which we are using in some of our
> products. Note that this is a Cypress chipset (identifiable by the
> Version: ... (... CY) tag in the version string). But the FW Konrad is
> linking appears to be for a Broadcom chipset.

This just makes me think about Peter Robinsons seminar at
LPC last week...
"All types of wireless in Linux are terrible and why the vendors
should feel bad"
https://lpc.events/event/16/contributions/1278/attachments/1120/2153/wirele=
ss-issues.pdf

Yours,
Linus Walleij
