Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A41DFEB6
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 13:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgEXLnF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 07:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgEXLnE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 07:43:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F00EC061A0E
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 04:43:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l15so17475029lje.9
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7e6eM1FBeYVnOJfEDd6TIE/YEGJXg0bheJ3ywRIWRco=;
        b=m7iRQIM2kVwRtKy7BOj18uCNIjFDEuXOi25U6DuL7bWzUWVZebZwUbMrnoyrcWvoUz
         I2zyOsRn91RhXm/IuseQaLnC8dzoZunaQ/ZuzMAMn0WExQZIBIcYGDXfNsbH4/FzDM6m
         5vu6jDXxt46410GEYJrU39SYharAgWaN7679nNKFLqsPg1hldXViIU8TQ7F34eGYbJNn
         ka007s8CfpI2DuooVIivrIxjvEfdhpZ8VjpHZyrKXIUUJ7GaaztPkNUDc7jRkX4L8nTU
         quWZGt/N/JPz+qIdr5ZY5OsKKo9pO49U0LSZYt+c6Go78DOiBKgL9FgiEbzwEcsP+Fcs
         W48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7e6eM1FBeYVnOJfEDd6TIE/YEGJXg0bheJ3ywRIWRco=;
        b=Bks8ME70ezRHM51du/n7/wGGyh80INrhO7nRFcpUm4KnafYvZi2S4rfHmVXk9pTtv8
         pj9g2rpxsM9TsvrZMjMexWJ5F+Sp86TLLvO93vxFFSEtzV47Q/QGF6OWfm5jfaIOPQLk
         R8oIyOOtluLtnwdG3jqmz0rm2RedV6RHKmVUV9TXWLPcF+8tsN/8r5KYr/lvovzGfK5J
         ZAPAUtuo7+lKRZJPiqOZQ8DbELjPIFRqGbyPc0FBBPdya9t2v2Ttdx8eSd2GBEu4WZ1O
         pL9vYO55Bu7sX0wrTN+pSj+cPq1wcpb/HLgleW9osAg9IPQuL2jqsijBIjmbnabr2RRq
         XM+Q==
X-Gm-Message-State: AOAM532+vfyhFAt4Djj/e1M6pSJW839LDcadcswq5YDlyawmmJ0rl1mu
        3XhdqU/GK7GicuUcMA1zPri4KqE4HkIO48Xvgf0PBw==
X-Google-Smtp-Source: ABdhPJz0oktSazM4OS2VUpGXJFD+XA3T/FYwbIIsh9rhlKCiLcY9BGs/8mKskxVchwIJf110eoCIANDrpVZZP3vYxfo=
X-Received: by 2002:a2e:7c17:: with SMTP id x23mr8914467ljc.307.1590320582824;
 Sun, 24 May 2020 04:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200524094730.2684-1-rsalvaterra@gmail.com> <20200524111751.GA914918@wp.pl>
In-Reply-To: <20200524111751.GA914918@wp.pl>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sun, 24 May 2020 21:42:51 +1000
Message-ID: <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Stanislaw,

On Sun, May 24, 2020 at 9:27 PM Stanislaw Gruszka <stf_xl@wp.pl> wrote:
>
> On Sun, May 24, 2020 at 10:47:31AM +0100, Rui Salvaterra wrote:
> > According to Larry [1] (and successfully verified on b43) mac80211
> > transparently falls back to software for unsupported hardware cyphers. Thus,
> > there's no reason for not unconditionally enabling MFP. This gives us WPA3
> > support out of the box, without having to manually disable hardware crypto.
> >
> > Tested on an RT2790-based Wi-Fi card.
> >
> > [1] https://lore.kernel.org/linux-wireless/8252e6a1-b83c-64eb-2503-2686374216ae@lwfinger.net/
>
> AFICT more work need to be done to support MFP by HW encryption properly
> on rt2x00. See this message and whole thread:
> https://lore.kernel.org/linux-wireless/977a3cf4-3ec5-4aaa-b3d4-eea2e8593652@nbd.name/

Am I reading this right: rt2x00 offloads some of the processing to the
card which interferes with MFP when using software encryption, so
therefore we need to disable that offload when using software
encryption with MFP.

So if mac80211 knows that this offload is happening and that we can't
use hardware crypto for MFP, could it be smart enough to disable the
offload itself?

And once mac80211 is smart enough to make those decisions, couldn't we
just enable MFP by default?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
