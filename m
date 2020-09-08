Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8675261D02
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbgIHT3w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730914AbgIHP71 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 11:59:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F190EC061798
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 05:02:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so18836382wrr.4
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fHKZGBn8DYDZmUzkcQdtFyocASRnUskXF0G0c14zQIY=;
        b=I49U5h01ldadqbGBSJ+JPwaa/XpVL1RHekltbw+5yb9vJdeb7HlxO2SH/MxU+AXAwy
         mFX3smUOgYMCiRiMYtlhJgNbB0x45bfB59AcCGTmRd7oJw5HUypGbJ+wDCYeJroaA4or
         rnyPXVVdanOQ2bOVqv7iQHTy8xceM8lkCF844=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fHKZGBn8DYDZmUzkcQdtFyocASRnUskXF0G0c14zQIY=;
        b=ovVQ0yIZFBQlBmgIC4RcaFQby6xGa86tHZgON195pz0Kc3YNoutR2U3CaBSDTL2xCy
         EkwvOk8mhXIWb09gZrSWX20qBFy9caULWFN8ED4sfTZNvDH6wg9W/hnvRnx7xrTrPAB6
         Vcok5pRKsc0+g57scahJl4L/QYrjlrggGBQ1jc/as6b74ct1pz2wlGgxI0/UD6OAp5EH
         7IMrA+QJyXTlc0tF1nyFe+ngjtgSUfW2uQrdeKjFBqpmrv67IPi/pbs+JYHWKEK7mZmg
         nU2Jc9BNH3oaO6JlYXMIpkl42A1fQF4eXu8zpx6wI5K3g0a1mDWJX2BTMwfYESlDfkDx
         umZA==
X-Gm-Message-State: AOAM531kFrCKQhYSoiL5YwXmHVGm/orKXa9A/ezReEynAGNiLqs5NVqQ
        QIP4r0blWBudu2YU+wwvSYiP6IwoWokSX8vcWu0W/Q==
X-Google-Smtp-Source: ABdhPJxLDgBM+s6ZLA0Xk5AyltkUhSxI4KJM4wlm9qfxvCvlS9XOiwZ2ahmKEQRp2PPZaiGtIw02aY3u8gSTeR+ZTXc=
X-Received: by 2002:adf:eecb:: with SMTP id a11mr26936125wrp.356.1599566568481;
 Tue, 08 Sep 2020 05:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <bad4e33a-af2f-b44f-63e5-56386c312a91@broadcom.com>
 <20200908001324.8215-1-keitasuzuki.park@sslab.ics.keio.ac.jp> <c13ee142-d69d-6d21-6373-acb56507c9ec@broadcom.com>
In-Reply-To: <c13ee142-d69d-6d21-6373-acb56507c9ec@broadcom.com>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Tue, 8 Sep 2020 21:02:35 +0900
Message-ID: <CAEYrHjmG-R4RHn=59AGK8E0jKDXE5sbxQj49VpBvDMvBuBGiig@mail.gmail.com>
Subject: Re: [PATCH] brcmsmac: fix memory leak in wlc_phy_attach_lcnphy
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Takafumi Kubota <takafumi@sslab.ics.keio.ac.jp>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list@cypress.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thank you for your comment. I am relatively new to the Linux
kernel community, so I am more than happy to receive comments.
Please let me know if I'm violating any other rules.

> > Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> > ---
> ... changelog here describing difference between previous patch and this
> version.

I will re-send the patch with the change log.

Thanks,
Keita

2020=E5=B9=B49=E6=9C=888=E6=97=A5(=E7=81=AB) 20:18 Arend Van Spriel <arend.=
vanspriel@broadcom.com>:
>
> On 9/8/2020 2:13 AM, Keita Suzuki wrote:
> > When wlc_phy_txpwr_srom_read_lcnphy fails in wlc_phy_attach_lcnphy,
> > the allocated pi->u.pi_lcnphy is leaked, since struct brcms_phy will be
> > freed in the caller function.
> >
> > Fix this by calling wlc_phy_detach_lcnphy in the error handler of
> > wlc_phy_txpwr_srom_read_lcnphy before returning.
>
> Thanks for resubmitting the patch addressing my comment. For clarity it
> is recommended to mark the subject with '[PATCH V2]' and add a ...
>
> > Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> > ---
> ... changelog here describing difference between previous patch and this
> version.
>
> Regards,
> Arend
> ---
> >   .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    | 4 +++=
-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
