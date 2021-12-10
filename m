Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548DB46FDD3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhLJJhv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhLJJhv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:37:51 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A06C0617A1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 01:34:16 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bj13so12501074oib.4
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 01:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C5610rni1qA1S97ONM74fivbTCLDtdb0GPqD2NdK+Cs=;
        b=KkpK0QwaC6Orez1MdmfJEhK+fZ0PtseO4yARtqs/MT4jnwN4cR9i47T8yjqlyOJiqF
         V3m132XCN8FY9dbmXxbvRl0fPTXmQOwN+gvRdhd8h3O8krS2wrw+u5xHnrxmZeyaZbQG
         7aVom0yR3Leu3tSDXbxG0LZkkPq+0SYJcghV27BLyTIl4f8fjxykp9qPfMFCGlfX4hra
         1lt6z4jMvyVrlQicJFiglNpDL3ehxqBV0PYTRW4yPsX11cSOy0tjUzO6VE1na9RpUZpy
         3lr18UAqVSIxSGbNDimw6a46CHMY0aiUu7qlYGVsti++Q6DP97BP6J9XCGBCOLBBaNRe
         AXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C5610rni1qA1S97ONM74fivbTCLDtdb0GPqD2NdK+Cs=;
        b=jGgHBTdfd2nPdHuZk3G9ZxAAO/ec+DSHiosqu/awgJPbxD6RfGId9qrQ91O/F2v1Pi
         pJrlmbJ15HTZcvB/JYnDWSJUrbqt+9nVjKdN06x6ZTq0zZsvujdDY/sk36yY4SXK0bhJ
         Gm249F5jxq3CnVUVZjk3vKXjm7MkVr7/S0bboVlOCwc2w49Iv3Tir74FU+Rc8tucwniM
         L0KZT/3uWmpZdc+pGqIH06tpYNNhVqDWzG6kan61q4FVYfCJqI5a12xUD/8RJx7M84k4
         aUzrctAWBrhVDJq2S8b4q5fHsBh6RPNda2C3SYuL/d8y91ID86CE88MPNUGp14nh8V10
         mnAQ==
X-Gm-Message-State: AOAM531PrnobRhX/pg+pw9GpAXLcfSqJ/S3jKAaztAa2EcQJyb6nIHbO
        hqz7B8MEryi2hjtCPcgjNB9ZAly6PF0kPaAIZ6Qv2g==
X-Google-Smtp-Source: ABdhPJwWBPx5Mqb40vNS33Uax+Ly8JSKNY9dFiEueiwRbh+hF0Yi79HGw5RU3xmsDwt7KtlUAyANOQExJKVLVFcNgQk=
X-Received: by 2002:a05:6808:14:: with SMTP id u20mr11260168oic.69.1639128855984;
 Fri, 10 Dec 2021 01:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20211210081659.4621-1-jhp@endlessos.org> <6b0fcc8cf3bd4a77ad190dc6f72eb66f@realtek.com>
 <CAAd53p66HPH9v0_hzOaQAydberd8JA4HthNVwpQ86xb-dSuUEA@mail.gmail.com>
In-Reply-To: <CAAd53p66HPH9v0_hzOaQAydberd8JA4HthNVwpQ86xb-dSuUEA@mail.gmail.com>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Fri, 10 Dec 2021 17:33:40 +0800
Message-ID: <CAPpJ_efvmPWsCFsff35GHV8Q52YvQcFr_Hs=q3RtvbfVohY+4Q@mail.gmail.com>
Subject: Re: [PATCH] rtw88: 8821c: disable the ASPM of RTL8821CE
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Pkshih <pkshih@realtek.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessos.org" <linux@endlessos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kai-Heng Feng <kai.heng.feng@canonical.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=
=8810=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:24=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Fri, Dec 10, 2021 at 5:00 PM Pkshih <pkshih@realtek.com> wrote:
> >
> > +Kai-Heng
> >
> > > -----Original Message-----
> > > From: Jian-Hong Pan <jhp@endlessos.org>
> > > Sent: Friday, December 10, 2021 4:17 PM
> > > To: Pkshih <pkshih@realtek.com>; Yan-Hsuan Chuang <tony0620emma@gmail=
.com>; Kalle Valo
> > > <kvalo@codeaurora.org>
> > > Cc: linux-wireless@vger.kernel.org; netdev@vger.kernel.org; linux-ker=
nel@vger.kernel.org;
> > > linux@endlessos.org; Jian-Hong Pan <jhp@endlessos.org>
> > > Subject: [PATCH] rtw88: 8821c: disable the ASPM of RTL8821CE
> > >
> > > More and more laptops become frozen, due to the equipped RTL8821CE.
> > >
> > > This patch follows the idea mentioned in commits 956c6d4f20c5 ("rtw88=
:
> > > add quirks to disable pci capabilities") and 1d4dcaf3db9bd ("rtw88: a=
dd
> > > quirk to disable pci caps on HP Pavilion 14-ce0xxx"), but disables it=
s
> > > PCI ASPM capability of RTL8821CE directly, instead of checking DMI.
> > >
> > > Buglink:https://bugzilla.kernel.org/show_bug.cgi?id=3D215239
> > > Fixes: 1d4dcaf3db9bd ("rtw88: add quirk to disable pci caps on HP Pav=
ilion 14-ce0xxx")
> > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> >
> > We also discuss similar thing in this thread:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D215131
> >
> > Since we still want to turn on ASPM to save more power, I would like to
> > enumerate the blacklist. Does it work to you?
>
> Too many platforms are affected, the blacklist method won't scale.

Exactly!

> Right now it seems like only Intel platforms are affected, so can I
> propose a patch to disable ASPM when its upstream port is Intel?

I only have laptops with Intel chip now.  So, I am not sure the status
with AMD platforms.
If this is true, then "disable ASPM when its upstream port is Intel"
might be a good idea.

Jian-Hong Pan

> > If so, please help to add one quirk entry of your platform.
> >
> > Another thing is that "attachment 299735" is another workaround for cer=
tain
> > platform. And, we plan to add quirk to enable this workaround.
> > Could you try if it works to you?
>
> When the hardware is doing DMA, it should initiate leaving ASPM L1,
> correct? So in theory my workaround should be benign enough for most
> platforms.
>
> Kai-Heng
>
> >
> > Thank you
> > --
> > Ping-Ke
> >
