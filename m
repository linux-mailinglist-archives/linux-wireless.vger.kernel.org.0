Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7542D4BF3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 21:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgLIUdO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 15:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgLIUdN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 15:33:13 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6740FC061794;
        Wed,  9 Dec 2020 12:32:33 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id w18so1622398vsk.12;
        Wed, 09 Dec 2020 12:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYNuf9TPPL2Gkke0FwSu03mIQpNY4jdeufGJOa9M/LI=;
        b=GJRhejTNxoO780Y7N1nma/TzQy/hX/vBDRu51iQQsccHb2QeOVvzgIrDWAOa/IfsER
         D3vRJL42+IEqviXVNPEhyOEBajYapv9u+UJRTyx6pqd8xv3DQaqhLNESFtspOwzVIRem
         tAqDqheudP2DzgDis9g1hznOIdTkRU4UAMuhw1mPfB98fHqjttar/3gtq4p4hHQVo2db
         8t3x00d60P9q47MkDnpmdTSH0i4F0qi0xRK8rELf/FuVHr6ZggPjqvfQu+bbV1/mrHxL
         2FpAxY5eai25/2SkcEN8op9fTUHNOPqBDDe59CjUw6RpbuC+KQFfCBStx+eHbro4oHDM
         TB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYNuf9TPPL2Gkke0FwSu03mIQpNY4jdeufGJOa9M/LI=;
        b=mmvhadvdfto+RSZteixd5IWN/hubHVRF1IxlfgCPxv+HiIRW8zreJKNTLzdves2Dfr
         BN0sgPviHmYpaFkzrkY0Bq0C9YWl1ACU+eiXKaIW4H2GPhAPvoY5C1UsEXOWmhLZjQZX
         dF0sQPFNZxFMd0aZtx8GSPLMmjsdM/twzMteay7SCp6ifbwy5DFPF9aCZGIeEIKMizIK
         hHiJHP2qsqhQhuGf/O7hfe5fPOWTrzm8RLZgzTj799q71odA/0mQ2G1Lrv3xST8EPYDp
         1Hfk/hnfYiwxQI34otjAVsRoMpAlsnOQdagLaXL6fccFlB34b3XfVKUY6ZLajg7l4T8t
         /FkQ==
X-Gm-Message-State: AOAM531X4L6uzDA1Mrplo6u9Jn+K+3HfMtYV3rELnOPcxwk2miO+rVqv
        diIiuQG1LZsscLWW/G3Vcu4QwmZIoXz0hYs0vk4=
X-Google-Smtp-Source: ABdhPJxd3g5bh8C+kelYGzPd2siGAo7ulmCoOYes8dKSNmtiOXwxZW/g3H/hF0X+SgL5M4MP1fPCspVaZxK4joTn0wc=
X-Received: by 2002:a67:ad0f:: with SMTP id t15mr4175739vsl.24.1607545952601;
 Wed, 09 Dec 2020 12:32:32 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
 <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com> <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Wed, 9 Dec 2020 22:32:20 +0200
Message-ID: <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 9, 2020 at 7:19 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 8 Dec 2020 23:17:48 +0000 Rui Salvaterra wrote:
> > Hi, Luca,
> >
> > On Tue, 8 Dec 2020 at 16:27, Coelho, Luciano <luciano.coelho@intel.com> wrote:
> > > On Tue, 2020-12-08 at 11:27 +0000, Rui Salvaterra wrote:
> > > >
> > > > [ 3174.003910] iwlwifi 0000:02:00.0: RF_KILL bit toggled to disable radio.
> > > > [ 3174.003913] iwlwifi 0000:02:00.0: reporting RF_KILL (radio disabled)
> > >
> > > It looks like your machine is reporting RF-Kill to the WiFi device.
> >
> > Yes, that's an artifact of how I tested: I rebooted the router, the
> > Wi-Fi interface disassociated and the dmesg was clean. However, after
> > the router came up, the laptop didn't reconnect (and the connection
> > had completely disappeared from nmtui). Afterwards, I did the rfkill
> > cycle you see, and only then I got the register dump.
> >
> > > There seems to be some sort of race there that is causing us to still
> > > try to communicate with the device (and thus you see the transaction
> > > failed dump), but that will obviously fail when RF-Kill is enabled.
> >
> > I'm not sure about that, the card was already dead before the rfkill cycle.
>
> Any luck figuring this out, Luca? If this is a 5.10 regression we need
> to let Linus know tomorrow, so the time is ticking :(

Rui, I looked at the register dump and looks like you're using AMT on
your system?
Can you confirm?
