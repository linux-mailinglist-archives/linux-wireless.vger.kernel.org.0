Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F327E444
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgI3Izz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 04:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3Izy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 04:55:54 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC2FC0613D1
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 01:55:54 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id m12so1100645otr.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SU/KZorwRWRL3VQ/bnlD6zatox7adu+Yzz6+KkwnCJ4=;
        b=mIcjvw4QfPXdUpHHnDQd2EAF6em28m/w0TxKUY/pOQ531f69qetZxMfu85C+jGWUx+
         RsGzSYepT7f8uhBpkZZ1SCTrxtFwTbWIfA9rHPEXull4DiUBLfmy+hWoXW26PKZ9F6PA
         swu2asF31NZ0HYAUD117T6orWgKSEb3f0NPq4PK/zFCfb4sndcQ4sEsDuEa5Yurqo3ri
         9z4DCbmtoE4xwFXV+suegEt2nsLs9sSKS3gzKOZElpOPtpuMPseWeATEtL6kaHWdRBy+
         PVa+1PXyoImzTYl9jYGoUb5qciN9iYEVmYWL3TwBNIb5H8c8vhm6bLBl/Hrm/N3PLdNe
         L7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SU/KZorwRWRL3VQ/bnlD6zatox7adu+Yzz6+KkwnCJ4=;
        b=PmG+UgY6guEaG0au4guoeAZQL19jcTFLfqS1tBgK6YvXGc2kkGlMfm9MUE+KS2/mK0
         YcOlGVGqxfOGcwmIsuTwd8pdLRzvcJbSDRO51ZgRfJkwz3M0v9MJhna6VNvGR/+XobME
         l7NIrFF2drUjH9j1fHwSrn3eeNntq6iXhBDBL2e2XeevIcxLRsJSQ05ZgE66BsAh9AYA
         2WrF1JJ9Kyue4f9NiW+wP+qYFGC7/t6JDXoTPp8nl1qkiTzGTE37Voxpf/HSF+jZ9Exx
         l4s1sLS0q1iBKRBouwJP56gq55M0IMc46iSBn/HIoEN3aiqdjFWJZ16/IKfO7WidBj3R
         4x5Q==
X-Gm-Message-State: AOAM531uf4Vg/ALlpcLp4Xxk9OwOO75pFYndtqs+ToXVcscTfhxgZIAP
        Dh1v+jbxzpJ5C7jnp14vSr2D2Fcf//jrZHXOaSwMKA==
X-Google-Smtp-Source: ABdhPJyDoZDpk7jo3S5AcUdSP5wfMgSpjwWhzEylMHlaBm+m7Q5JKHnzC4yoydYe5dk8pehl1CiDx7Ygo2Kgzjpi6VM=
X-Received: by 2002:a9d:1:: with SMTP id 1mr898289ota.81.1601456153412; Wed,
 30 Sep 2020 01:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPpJ_ecS3LOYUMdrodMoxMRQ_4q4M06uyGzBBf+W8MrjP08-EA@mail.gmail.com>
In-Reply-To: <CAPpJ_ecS3LOYUMdrodMoxMRQ_4q4M06uyGzBBf+W8MrjP08-EA@mail.gmail.com>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Wed, 30 Sep 2020 16:54:16 +0800
Message-ID: <CAPpJ_ec_Xwf8qwdb1XVDkhwFOQr=oNGOoCevAic5yJVZLKEGjQ@mail.gmail.com>
Subject: Re: [QUESTION] Enable the wireless module on Pinebook Pro
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dan Johansen <strit@manjaro.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I forgot to mail to Dan Johansen as well.

Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:15=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> According to the preloaded system Manjaro ARM on Pinebook Pro [1], I
> found the firmware files in ap6256-firmware package [2] enable the
> wireless module, including WiFi and Bluetooth.
> If we want to redistribute the firmware files to linux-firmware
> repository or other distros, which kind of license should follow?
>
> [1] https://www.pine64.org/pinebook-pro/
> [2] https://gitlab.manjaro.org/manjaro-arm/packages/community/ap6256-firm=
ware
>
> Jian-Hong Pan
