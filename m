Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021734220E7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 10:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhJEIjW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 04:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhJEIjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 04:39:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3ABC061745
        for <linux-wireless@vger.kernel.org>; Tue,  5 Oct 2021 01:37:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id bm13so25197335edb.8
        for <linux-wireless@vger.kernel.org>; Tue, 05 Oct 2021 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaLsFCnleig7EzZnkwnd8K4iW8JYfGTZW2bwlrxQE5A=;
        b=WDRj/somzKRBsBuyPXTW2RpdH3uZDcj9IiX9BgXez9ag075BBlq8JGWTp4OtnT6CwZ
         Jempw5i46hG2th44npBM2sdI8Gne4Fm7dVao4JI1GAkS7mesJltrG99WAdXaSBtMks+e
         h4x8fMgBsGoFi43W6n7jq4hsZX2SwZexwaCwStA8m9kgM8bV43m5/m0eSNycRdhPns5t
         BcVSGJl10O0VeKx3LluJQpuCai8UrE+mG2bjT913u6E6R6OOm0Pn1sw+ujhO7CV65zpI
         Ow/AiZRy2EqPbbpVHliFQb5WXlR1Tq31HCJ/z8plZAKrzdUZf8X//gvNE4eYXP3YdWe4
         ke9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaLsFCnleig7EzZnkwnd8K4iW8JYfGTZW2bwlrxQE5A=;
        b=zL+b2uzNTZPK08COShoROl9V2QwmFMLMDYjXvcJaE9kq7lAa0H5oX3v1l2Av0m2ECA
         QubEUwlvVMGjZZ0FTQLYaZWV6TqS60ZAkj82rkoWIFO4X1A20zbCsi73uItNpsG+oozi
         hIOaMyXVErmT3LE2pdmU5gGSJwQHKamKmHJVuoXHwQgDF3wW2t5k7T7HarFbR8GGxuKM
         YFaCqI0byt7+98B+av9TM/0gyumTzabb3uUqsJSijZiNliuQd3Eu24X6U/6fEz8nuFKl
         nUR0/0nelQ+cnzRrYWyFmqgkazv0rzQy8QVgOLI5rsyBfxDd62ltwgzWT1vt73P3J8KY
         nGGw==
X-Gm-Message-State: AOAM532Ine6jA63e1CiamuY9p7UhJli2CgflM1EaZTcqya9PhDPeHTdj
        TY88lBPzKt2MXN0CJONEU3i6/zhWKcnST2JyrHE=
X-Google-Smtp-Source: ABdhPJyrbibPE7jcS/rXP3JNUQp/OmMRsKA1BWTrf97ug6P9y64NW4lzeKlj7qdyBTt0tMPXjFBZBoZ851B/pANr67s=
X-Received: by 2002:a17:906:9401:: with SMTP id q1mr22956405ejx.313.1633423049379;
 Tue, 05 Oct 2021 01:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211003160325.119696-1-hdegoede@redhat.com> <87fstgghhr.fsf@codeaurora.org>
 <43e39a93-fed1-acbb-517e-94cf0d6d739c@redhat.com>
In-Reply-To: <43e39a93-fed1-acbb-517e-94cf0d6d739c@redhat.com>
From:   Arend van Spriel <aspriel@gmail.com>
Date:   Tue, 5 Oct 2021 10:37:18 +0200
Message-ID: <CAJ65rDyNR+a-4=eY=MFXLgXueaTX7yro4bpEnKtOOEYiWCdcbg@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: firmware: Treat EFI nvram ccode=XT the same as ccode=XV
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 5, 2021 at 10:02 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Kalle,
>
> On 10/5/21 7:36 AM, Kalle Valo wrote:
> > Hans de Goede <hdegoede@redhat.com> writes:
> >
> >> In some cases the EFI-var stored nvram contains "ccode=ALL", "ccode=XV"
> >> or "ccode=XT", to specify "worldwide" compatible settings, but these
> >> ccode-s do not work properly. "ccode=ALL" causes channels 12 and 13 to
> >> not be available, "ccode=XV" / "ccode=XT" may cause all 5GHz channels
> >> to not be available.
> >>
> >> ccode="ALL" and ccode="XV" where already being replaced with ccode="X2"
> >> with a bit of special handling for nvram settings coming from an EFI
> >> variable. Extend this handling to also deal with nvram settings from
> >> EFI variables which contain "ccode=XT", which has similar issues to
> >> "ccode=XV".
> >>
> >> This fixes 5GHz wifi not working on the HP ElitePad 1000 G2.
> >>
> >> This was also tested on a Lenovo Thinkpad 8 tablet which also uses
> >> "ccode=XT" and this causes no adverse effects there.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> > To me worldwide compatible settings mean that channels 12 and 13 should
> > be disabled, so I'm quite hesitant about this patch.
>
> The X2 setting puts channel 12 and 13 in passive / listen-only modes
> and only starts using them if there is an AP on them.
>
> AFAIK this is the same with the XT/XV settings. The problem is that the XT
> setting results in 5G not being available on some boards even though the
> hw supports it.
>
> Also note that we already use the X2 setting for any EFI supplied nvram
> files where ccode=ALL or ccode=XV, this just extends the handling we
> already have to also patch ccode=XT.

I am not overly excited about this approach that is already in use.
AFAIK these worldwide codes are tailored for specific
devices/customers based on their RF components. Using it as fallback
for other devices in such a generic way could even result in exceeding
regulatory limits. However, I do not have a better solution for this.
I am surprised to learn there are nvram out there with ccode=ALL as
that is for internal use only, but if these devices has SROM than the
nvram value is ignored. Hopefully, that is the case although given the
fact that changing it to X2 helps suggests otherwise :-(

Regards,
Arend
