Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934E74725C8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 10:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhLMJqT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 04:46:19 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41116
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234417AbhLMJoR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 04:44:17 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE82B4005B
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 09:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639388650;
        bh=idfKXszTAq7jF3tCvMd5XR8JGhQDpTd0E5+Um0VFhrI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UAy1svR3zm3L9KWTLro7AdUqbbyO3Mys0T2Tq69ZbhBVxnHLlkY2bvNxb1lsZj5UB
         ogxhgdqI9WZxYfYKZpCStEx0roEhkvuG/1Igp5cVdfHxf4yjrtgjAy3U45r14IEgZF
         LKMc4zlW6HAEtXi2Wr5I9Ue43VIlbyUZ45Qu9awPlALWKYX9+nTPCDQG6F/pFvNXm2
         uDfBFd0yfuXal/OVxRsqTyuubttSDPCoSI87WtiCKusGyF5EcPkvP+sv3C+60K09Or
         lui3FuKlryfQMtNkiWmsVEsl4vVEjU7xl8ogWYWlyppfxHXRDowsHtIiStIDK0L0XN
         n1kvVTj4x9q5A==
Received: by mail-ot1-f71.google.com with SMTP id h34-20020a9d2f25000000b00579e86a64dfso5959487otb.5
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 01:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=idfKXszTAq7jF3tCvMd5XR8JGhQDpTd0E5+Um0VFhrI=;
        b=UMcbmCKUEhV7xN2LLJqoswrDTNfmYP9N1ktaGwfChzAQY1s6OznlPDsq8QcT+AiuUs
         g0Zzt4t/H3NcZQO4/QabE4nmXovZ0AIMrgQ1FyBrf61YVywzjjWhpkooXSZjPvuJSaYw
         0YP+c+XQquvYZ8Tkvt3czpRIsWuAk9aP9Wy1YtvwLGRLN47/GlkZRsgX87Mzbfh2zyhB
         o+TbCOEssHScahcqh3KMAJsrNAqse3jISATcDiTY7W5m7XUtYC1ykm2jF+FSQedd50mT
         Us5fztReU59FqLEsEEsgkCt4HXjnbdRV2+eaLpf9gKBi3UJvKUUVTKQqUViH5BGhk1fS
         xO6A==
X-Gm-Message-State: AOAM532PcUlABm94z/a2+li5/OeyfyizaMs4Ks3dmKUkHmjJus9ixHrP
        vYhStnNT6zk9gHagNB9Fg9W9q/JFR8PSovCaHYa/1uZs6MfgioS/lE563loRiqovpCXtq9BXjWA
        d1HUnfRK5uuHDbTl9ivWOSH0OU++IWzutYRWl3ENm7kCUOExr2nZ+6X3X5OUf
X-Received: by 2002:a9d:292a:: with SMTP id d39mr12154713otb.11.1639388649548;
        Mon, 13 Dec 2021 01:44:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2HU5a13xThIsfUH6/rXuvAX4BSKgBEypPvFTKpPMPIQse7/YYQ8PcuiPmmI2FTdWr/PGaesC8ebqUEUZdCa8=
X-Received: by 2002:a9d:292a:: with SMTP id d39mr12154677otb.11.1639388649001;
 Mon, 13 Dec 2021 01:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20211210081659.4621-1-jhp@endlessos.org> <6b0fcc8cf3bd4a77ad190dc6f72eb66f@realtek.com>
 <CAAd53p66HPH9v0_hzOaQAydberd8JA4HthNVwpQ86xb-dSuUEA@mail.gmail.com>
 <CAPpJ_efvmPWsCFsff35GHV8Q52YvQcFr_Hs=q3RtvbfVohY+4Q@mail.gmail.com>
 <617008e3be9c4b5aa37b26f97daf9354@realtek.com> <CAPpJ_ecqf+LqkN-Wb+zNGHbtJ3rKD8_kU3W0c2gTQGQqK1sUwg@mail.gmail.com>
 <e78b81f3a73c45b59f4c4d9f5b414508@realtek.com>
In-Reply-To: <e78b81f3a73c45b59f4c4d9f5b414508@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 13 Dec 2021 17:43:57 +0800
Message-ID: <CAAd53p5A01DiQH24BnEb=tEPNGSo8tyziyb59boapsY2ofeGjg@mail.gmail.com>
Subject: Re: [PATCH] rtw88: 8821c: disable the ASPM of RTL8821CE
To:     Pkshih <pkshih@realtek.com>
Cc:     Jian-Hong Pan <jhp@endlessos.org>,
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

On Mon, Dec 13, 2021 at 5:00 PM Pkshih <pkshih@realtek.com> wrote:
>
>
> > -----Original Message-----
> > From: Jian-Hong Pan <jhp@endlessos.org>
> > Sent: Monday, December 13, 2021 3:31 PM
> > To: Pkshih <pkshih@realtek.com>
> > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>; Yan-Hsuan Chuang <tony=
0620emma@gmail.com>; Kalle Valo
> > <kvalo@codeaurora.org>; linux-wireless@vger.kernel.org; netdev@vger.ker=
nel.org;
> > linux-kernel@vger.kernel.org; linux@endlessos.org
> > Subject: Re: [PATCH] rtw88: 8821c: disable the ASPM of RTL8821CE
> >
> > Pkshih <pkshih@realtek.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=8811=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=882:31=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jian-Hong Pan <jhp@endlessos.org>
> > > > Sent: Friday, December 10, 2021 5:34 PM
> > > > To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > Cc: Pkshih <pkshih@realtek.com>; Yan-Hsuan Chuang <tony0620emma@gma=
il.com>; Kalle Valo
> > > > <kvalo@codeaurora.org>; linux-wireless@vger.kernel.org; netdev@vger=
.kernel.org;
> > > > linux-kernel@vger.kernel.org; linux@endlessos.org
> > > > Subject: Re: [PATCH] rtw88: 8821c: disable the ASPM of RTL8821CE
> > > >
> > > > Kai-Heng Feng <kai.heng.feng@canonical.com> =E6=96=BC 2021=E5=B9=B4=
12=E6=9C=8810=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:24=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > >
> > > > > Right now it seems like only Intel platforms are affected, so can=
 I
> > > > > propose a patch to disable ASPM when its upstream port is Intel?
> > > >
> > > > I only have laptops with Intel chip now.  So, I am not sure the sta=
tus
> > > > with AMD platforms.
> > > > If this is true, then "disable ASPM when its upstream port is Intel=
"
> > > > might be a good idea.
> > > >
> > >
> > > Jian-Hong, could you try Kai-Heng's workaround that only turn off ASP=
M
> > > during NAPI poll function. If it also works to you, I think it is oka=
y
> > > to apply this workaround to all Intel platform with RTL8821CE chipset=
.
> > > Because this workaround has little (almost no) impact of power consum=
ption.
> >
> > According to Kai-Heng's hack patch [1] and the comment [2] mentioning
> > checking "ref_cnt" by rtw_pci_link_ps(), I arrange the patch as
> > following.
>
> I meant that move "ref_cnt" into rtw_pci_link_ps() by [2], but you remove
> the "ref_cnt". This leads lower performance, because it must turn off
> ASPM after napi_poll() when we have high traffic.
>
> In fact, Kai-Heng's patch is to leave ASPM before napi_poll(), and
> "restore" ASPM setting. So, we still need "ref_cnt".

I am working on the patch for proper upstream inclusion. Will send out soon=
.

Kai-Heng

>
>
> > This patch only disables ASPM (if the hardware has the capability)
> > when system gets into rtw_pci_napi_poll() and re-enables ASPM when it
> > leaves rtw_pci_napi_poll().  It is as Ping-Ke mentioned "only turn off
> > ASPM during NAPI poll function".
> > The WiFi & BT work, and system is still alive after I use the internet
> > awhile.  Besides, there is no more "pci bus timeout, check dma status"
> > error.
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D215131#c11
> > [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D215131#c15
> >
> > Jian-Hong Pan
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/pci.c
> > b/drivers/net/wireless/realtek/rtw88/pci.c
> > index a7a6ebfaa203..a6fdddecd37d 100644
> > --- a/drivers/net/wireless/realtek/rtw88/pci.c
> > +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> > @@ -1658,6 +1658,7 @@ static int rtw_pci_napi_poll(struct napi_struct
> > *napi, int budget)
> >                                               priv);
> >         int work_done =3D 0;
> >
> > +       rtw_pci_link_ps(rtwdev, false);
> >         while (work_done < budget) {
> >                 u32 work_done_once;
> >
> > @@ -1681,6 +1682,7 @@ static int rtw_pci_napi_poll(struct napi_struct
> > *napi, int budget)
> >                 if (rtw_pci_get_hw_rx_ring_nr(rtwdev, rtwpci))
> >                         napi_schedule(napi);
> >         }
> > +       rtw_pci_link_ps(rtwdev, true);
> >
> >         return work_done;
> >  }
> >
>
> How about doing this thing only if 8821CE and Intel platform?
> Could you help to add this?
>
> --
> Ping-ke
>
>
