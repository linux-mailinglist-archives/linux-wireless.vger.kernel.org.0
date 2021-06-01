Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F3396FEC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhFAJIJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 05:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233336AbhFAJIH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 05:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622538385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TC49diZ8yvtNeRfoDHho9BsiKWB6WeW1SJE0j6cAKdU=;
        b=dYX25Y4Iqimh5oLvTA6qBEDPuntB3jBavsXxjHvSlcaU1blU8u2/SbmeDglxWPuUvHwMD3
        ML+MbARBY+wKoTMBaf0Y2OJNLc/MSBOk197GMxcmBd1lFyUmMn3bcuBSxcbRpL2lUDZyMf
        ekd0tzoSY6UNY8fF8R324/SjWK/eKH4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-dMn7G792Pbm8ZTXO8-vCVw-1; Tue, 01 Jun 2021 05:06:22 -0400
X-MC-Unique: dMn7G792Pbm8ZTXO8-vCVw-1
Received: by mail-il1-f197.google.com with SMTP id n18-20020a92d9d20000b02901d7b2ca03e6so8305457ilq.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 02:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=TC49diZ8yvtNeRfoDHho9BsiKWB6WeW1SJE0j6cAKdU=;
        b=ZN6qbz6Al+LAp4ogncEYkvOmWXHlrn2NOC+nVwIZfOKJreQWWvRvW+oxP6k2sknP2F
         Emjp4zJK+qnriC/QINJTPkABMqV3VEWjdr33sa70KFvJyBaQ6xFWO2uh39kmN5k1ZsSV
         KUyiWtwrWQC0W3jflMQrq2k6c9JS8XweVFA3FcET5K6R0toB0rc+0oraDkWeYTq1KqKz
         6eCnqkLpK92LnXuyTychOMZnAilvl4+E5SJHN1wikeMJ44+vnHnOiOSKFZn0lwdy5gWo
         WCfXG9I4tAFWpX2rL9damG21wjiTk516ocG23cHFnkc+KbXFauvI8hFMY1ed2CyCRj2T
         W6Uw==
X-Gm-Message-State: AOAM530AYh0JUJSBR25MHIZrsCbFD3FMKH92yKfVImeeJOG9+T9yh+WL
        nBEfpRNRcG426BnsJAKYnKkWRx41b7xs9BpmCW8iJRbiKxEUIOq+hq6t002OuZcQvcEKy5OFUVL
        q3+t1cMEG4CEeM9Knpj93ckOjZg9H4dqQpqSBFvCByRY=
X-Received: by 2002:a02:384b:: with SMTP id v11mr11232995jae.90.1622538382158;
        Tue, 01 Jun 2021 02:06:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZQ8URK5CiJvEC5yEjY6vdL8Z9nhAdkHGrPEoD8pjNhf2DMrUcABocCKqqN/gaPUGnJjPa/rOI/2sHGIkGGqQ=
X-Received: by 2002:a02:384b:: with SMTP id v11mr11232977jae.90.1622538382042;
 Tue, 01 Jun 2021 02:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210511070257.7843-1-ihuguet@redhat.com>
In-Reply-To: <20210511070257.7843-1-ihuguet@redhat.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Tue, 1 Jun 2021 11:06:11 +0200
Message-ID: <CACT4oufayruhjHdog6UKyjYrCQS_SVkAearf1RdamQhSraa=BQ@mail.gmail.com>
Subject: Re: [PATCH] BRCM80211: improve readability on addresses copy
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 11, 2021 at 9:04 AM =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>=
 wrote:
>
> A static analyzer identified as a potential bug the copy of
> 12 bytes from a 6 bytes array to a 6 bytes array. Both
> arrays are 6 bytes addresses.
>
> Although not being a real bug, it is not immediately clear
> why is done this way: next 6 bytes address, contiguous to
> the first one, must also be copied to next contiguous 6 bytes
> address of the destination.
>
> Copying each one separately will make both static analyzers
> and reviewers happier.
>
> Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> index 763e0ec583d7..26de1bd7fee9 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> @@ -6607,7 +6607,8 @@ brcms_c_d11hdrs_mac80211(struct brcms_c_info *wlc, =
struct ieee80211_hw *hw,
>                         rts->frame_control =3D cpu_to_le16(IEEE80211_FTYP=
E_CTL |
>                                                          IEEE80211_STYPE_=
RTS);
>
> -                       memcpy(&rts->ra, &h->addr1, 2 * ETH_ALEN);
> +                       memcpy(&rts->ra, &h->addr1, ETH_ALEN);
> +                       memcpy(&rts->ta, &h->addr2, ETH_ALEN);
>                 }
>
>                 /* mainrate
> --
> 2.31.1
>

Hello,

About 3 weeks ago I sent this patch, just with a small style change
proposal. Any feedback would be appreciated.

Thanks!
--=20
=C3=8D=C3=B1igo Huguet

