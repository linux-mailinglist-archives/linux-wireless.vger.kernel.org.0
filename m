Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F174E3B2F69
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhFXMyZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhFXMyY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 08:54:24 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C85FC061574
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jun 2021 05:52:05 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id e7so2140390uaj.11
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jun 2021 05:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k84byIFNAq5WgQyx8dF/SSFvAhbbwQMFhFrcX8AVavw=;
        b=UG6EWDb2TV7d5gADiTEYkatGXPspezWDrq2uNFNn70t3mmaY1e/a/SHGAN68T6fHfN
         KeQL0YT6dIBRQXHiu59BWKfsLfD92H/fNnXWMqO8BfeL5MkonZtqDTEDfPKk9pMEZOIR
         1WLWL+zsDEmAuEq8VHsLN3YJs8RQ9yqPNknxF3uvbicL91EaIs3JMCRwSn3hJdvMBTLv
         hdB487dsKt/vf1YjW3iEheskfFJZrnSz9pvKVP9wZ6wD7FD27WywXfGfSh8/9vybiMDT
         KOktVTx9w3v0RX6ISrJNNNbBKkS9xu1gkI2pcHoEXQrtXD8lpdW6UdhtAv+dHDnbD9Ul
         8zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k84byIFNAq5WgQyx8dF/SSFvAhbbwQMFhFrcX8AVavw=;
        b=fW7CmaeTr0OhQzV9aKc1bKSkn0AGmfYvogkx7xFR8LESylZyTViTyJYm12zSx6GDuB
         G7yR8lwEMkZ0OOz+M4sM7BGMdlvNPZK41fNdyhhb43P/rgxQLK/Y4YJi3JzkhvN1WHyk
         IuMFbDXupQztxhzaEsEN91CTvtLtaXK7Tg2XHyU0KHjCE1tBmpGWK9uEm42B44Ar8XWO
         rMDiSymrRV3pAxD/rlePg0Hi6u97FgX8awH/liVqRbU/arsQn2etVPKDCqlvq33Mlk3A
         Wc1yWcj29gwoAR95lRCgxkaf8882A5NtKCcb6oO07wiYxPTKGt1VPbl8N8jresyazTvI
         wrUg==
X-Gm-Message-State: AOAM530EkUWmmE/WEejIj+0yrg1vpR0qRRSfy/u2W4Dm5lxMsbEosd4H
        iej+veYjpGzKaFlQxIVUtUONDWe4H9f68DOKeQM=
X-Google-Smtp-Source: ABdhPJwjVwUCugqyvMybXTnrtWgtgUfwWSt9K+yhNvDrzvku7Zv6UN2XfpZaAyGqV67b621AlYbLr7W1NJv+PD82K+g=
X-Received: by 2002:ab0:6797:: with SMTP id v23mr5074842uar.71.1624539123338;
 Thu, 24 Jun 2021 05:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
 <20210623141033.27475-3-emmanuel.grumbach@intel.com> <45f7ca548cb62180f90b9960c63c0a1658047da7.camel@sipsolutions.net>
In-Reply-To: <45f7ca548cb62180f90b9960c63c0a1658047da7.camel@sipsolutions.net>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Thu, 24 Jun 2021 15:51:52 +0300
Message-ID: <CANUX_P1nJye6dCbfPQ7pKsK0y9=fipyNa1Be1fbXqJA6zezpXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] nl80211: vendor-cmd: add Intel vendor commands for
 iwlmei usage
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 24, 2021 at 3:48 PM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Wed, 2021-06-23 at 17:10 +0300, Emmanuel Grumbach wrote:
> > iwlmei allows to integrate with the CSME firmware. There are
> > flows that are prioprietary for this purpose:
> >
> > * Get the information the AP, the CSME firmware is connected
> >   to. This is useful when we need to speed up the connection
> >   process in case the CSME firmware has an TCP connection
> >   that must be kept alive across the ownership transition.
> > * Forbid roaming, which will happen when the CSME firmware
> >   wants to tell the user space not disrupt the connection.
> > * Request ownership, upon driver boot when the CSME firmware
> >   owns the device.
> >
> > Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > ---
> >  include/uapi/linux/nl80211-vnd-intel.h | 80 ++++++++++++++++++++++++++
>
> This was supposed to be submitted separately [1] so people see it more
> easily, so *bump* - everyone take a look please.
>
> johannes
>
> [1] https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#=
vendor-specific_api
>
>    Patches introducing such commands shall be submitted separately, not
>    =E2=80=9Cburied=E2=80=9D in big driver patchsets. Give them a =E2=80=
=9Cnl80211: vendor-cmd: =E2=80=9D
>    prefix to make them easily identifiable.
>
> Though I guess we can debate if this is a "big" patchset :)
>

Thanks Johannes.
I have a few typos in the commit message so that I can re-send this
patch if needed.
In that case, I'd send it as a standalone patch.
(Although it'd make the kernel build bots unhappy).
