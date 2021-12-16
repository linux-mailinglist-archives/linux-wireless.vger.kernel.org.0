Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F76476848
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 03:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhLPCqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 21:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhLPCqx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 21:46:53 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D01BC06173E
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 18:46:53 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q25so34556863oiw.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 18:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6bVzvpheVBBIcY1ce58sxKYXE1wOehY4K20Ojvv4pk0=;
        b=tvP/tqXZ5k2rFm+NIJh9lCHtTQIfkuLu8y2SdXjslo1QUBihcxdowh5DV+3N0M/Nw0
         Qsh1/jI485BGm0NMimK0uN1TdBOAW0Ey3iHemyd2lQJ6V6JXk47xhcEk+yRXq8fI4Sms
         9sORp4pnRH4bn9D+F/KnXKL9NXCx21JHIsdPHtRxdqNrr3rgDVHkai9Zea9YBvqJUInL
         lbw47ZgWf2FFJ73IoR0IM1Syozs9u5QFgwvgWsTMQeZdk6GdTah+QbMrYu9lEFgIEdLB
         d0jjVtpWrwGBv6+CT5udoQDdnSxHLnp0X/RJqmjRIttmUR3DGUXTxdzAaWcS9dTC5CyU
         AiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6bVzvpheVBBIcY1ce58sxKYXE1wOehY4K20Ojvv4pk0=;
        b=SkeTRt68metu9hMsbeF3HnXAOxWJkgmCeYab7IhaKDRQhWh/14a04vRjV8B6aULI55
         0oyGtcAHMbSQDtP1CHaSm4MkRKsAHTDQfm6NIAjGkOQofrV5UoOA0EOKX4wx7tl8DgcE
         UHZeoWULiLMHa/N8IOIGVTWVRQDf4F7kLQ7J0QHCo/hn6HanQaq1ifWaoEha4L4zM120
         02zN+F7nVRSb8sy9R8M0lE37zDWmTqHJUx4H/odRNalNNSQ/3dSRq/5IuANYLHM9CdYn
         PVsTNXhIQW4L06k2r4LBAY9VNDOzawxDtupGBq9HHEvJGB2f7BJITlv4BMNYrhXKOr9z
         1jdQ==
X-Gm-Message-State: AOAM531Z+kl9Axf2q75ORE32SN1POsm3FWW8RUG/dqSoiG6gX2O3uhj+
        4r+PTY2IYnuRLGcqqASVc4V1/yAJea5AVGGvDHsU3IMfj/Q=
X-Google-Smtp-Source: ABdhPJy5KawtFidrvy0PFM5hXDFslMGNOj7QgkQ9XL5FdUUcGwFlx2VhiS+x0TXfg7Qx9As1kud+7KGGNqlKKDYU4EQ=
X-Received: by 2002:a05:6808:d1:: with SMTP id t17mr2498324oic.161.1639622812691;
 Wed, 15 Dec 2021 18:46:52 -0800 (PST)
MIME-Version: 1.0
References: <20211215114635.333767-1-kai.heng.feng@canonical.com> <d2ddfaa035315ca91a2a05a8188810ff50db83c8.camel@realtek.com>
In-Reply-To: <d2ddfaa035315ca91a2a05a8188810ff50db83c8.camel@realtek.com>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Thu, 16 Dec 2021 10:46:16 +0800
Message-ID: <CAPpJ_ecgPDniiBWnZLfDuQSiW4rvHJ1f4++SsZ3=aTjy_B0Fjg@mail.gmail.com>
Subject: Re: [PATCH v4] rtw88: Disable PCIe ASPM while doing NAPI poll on 8821CE
To:     Pkshih <pkshih@realtek.com>
Cc:     "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jian-hong@endlessm.com" <jian-hong@endlessm.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=8815=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 2021-12-15 at 19:46 +0800, Kai-Heng Feng wrote:
> > Many Intel based platforms face system random freeze after commit
> > 9e2fd29864c5 ("rtw88: add napi support").
> >
> > The commit itself shouldn't be the culprit. My guess is that the 8821CE
> > only leaves ASPM L1 for a short period when IRQ is raised. Since IRQ is
> > masked during NAPI polling, the PCIe link stays at L1 and makes RX DMA
> > extremely slow. Eventually the RX ring becomes messed up:
> > [ 1133.194697] rtw_8821ce 0000:02:00.0: pci bus timeout, check dma stat=
us
> >
> > Since the 8821CE hardware may fail to leave ASPM L1, manually do it in
> > the driver to resolve the issue.
> >
> > Fixes: 9e2fd29864c5 ("rtw88: add napi support")
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D215131
> > BugLink: https://bugs.launchpad.net/bugs/1927808
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Reviewed-and-Tested-by: Ping-Ke Shih <pkshih@realtek.com>

Acked-by: Jian-Hong Pan <jhp@endlessos.org>

> > ---
> > v4:
> >  - Rebase to the right tree.
> >
> > v3:
> >  - Move the module parameter to be part of private struct.
> >  - Ensure link_usage never goes below zero.
> >
> > v2:
> >  - Add default value for module parameter.
> >
> >  drivers/net/wireless/realtek/rtw88/pci.c | 70 +++++++-----------------
> >  drivers/net/wireless/realtek/rtw88/pci.h |  2 +
> >  2 files changed, 21 insertions(+), 51 deletions(-)
> >
> >
>
> [...]
>
>
