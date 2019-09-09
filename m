Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659FFAD9C9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfIINPd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 09:15:33 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37838 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbfIINPd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 09:15:33 -0400
Received: by mail-yb1-f194.google.com with SMTP id t5so4587217ybt.4
        for <linux-wireless@vger.kernel.org>; Mon, 09 Sep 2019 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ShzV6sE+FHwBgPYo4HneWQclwQ4A3p6MfIbRnOSiJ08=;
        b=rMIyGNnog02e8T0HRPMwaQva4DkVfVQ3uwJ90aOSuwiMBukTjyGVt0+bJRrn0zPCbE
         L+gBOmQViR4zXORUv7UNO4G/ZiEik2ZEbAYcdUbXRI9ZL/m1+b+lT3jJnh/GABSNA8Mm
         V4wkVP6/QYEFBssKDy1Dtx9hxprcZ/Ey2CYDjsgM2aMVPjsmJxr7NKKEgs7xtNaOEyJ+
         Xjf8rERm6QBSEeNsFUToRjJdqTGiTrzNuuR11TZhyhwkEUOUKNaWUbKbh8qOAC4MC6gD
         oxC13UBFQ+6cjJ1+Vui627ihTmuP1WwP67ODDOl5FrUEap6uvLvq4yeE2GxHUlm4ce6R
         A9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ShzV6sE+FHwBgPYo4HneWQclwQ4A3p6MfIbRnOSiJ08=;
        b=fwZBUjhxIB2bm5/zM8gvSqoUq3EZtjQDZpza7gxZmaDPKJDGwmbiel6qkicCqUpWH/
         JH2JMvpABug/VlGZ18JMksV8G1DgKeJIpY3WoQe2QQTjLtGWdRcrXb0njBxZt6BjbKkr
         uCyhjZIthMVAZu7hLcrhRh3NwTRGDwVT/ziWdTJpRg3xcnPGHj9f3r48Fi5HTGO0Iho8
         M7ri7dPvnoLL6iwO/uM7xjopCWqmM6HAjJ9DXMXQb6p9tCBOP42b8xYIJYbtnLPJ3Z2i
         sGXxpTKj5G74nckLsUwaYcYILkflGBw4pbJ41hNEKGuFK+6D3wpjiNqj86Ft+xfOo9ZN
         f9aQ==
X-Gm-Message-State: APjAAAXlqvxFRrePKj+gnKsWWgw3V75TiRnB/22fDm4WedI/bkj8w8D+
        pM26JX+3DVv9pDCX0KIYIJz5RaL9J8d/PoC59pA=
X-Google-Smtp-Source: APXvYqx8jT8MgUT7S9ZnvFoJbxu3CaIb9RmoYtMDawysPfHwVN3skLly8GfUPqLf88rtcqQ2DZkSxRoYEsWH+3zdb5c=
X-Received: by 2002:a25:3242:: with SMTP id y63mr15916170yby.455.1568034931171;
 Mon, 09 Sep 2019 06:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190903042928.18621-1-zajec5@gmail.com> <20190903042928.18621-2-zajec5@gmail.com>
 <527c6f46-bad4-58ac-afce-ca62ddda7c5b@broadcom.com>
In-Reply-To: <527c6f46-bad4-58ac-afce-ca62ddda7c5b@broadcom.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Mon, 9 Sep 2019 15:15:20 +0200
Message-ID: <CACna6ry4TXRQb4Ls1TSccKLDrNictuk3HNQf7LKp6C-=DJTbVw@mail.gmail.com>
Subject: Re: [PATCH 1/3] brcmfmac: move "cfg80211_ops" pointer to another struct
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
        <brcm80211-dev-list.pdl@broadcom.com>," 
        <brcm80211-dev-list@cypress.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 3 Sep 2019 at 20:59, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
> On 9/3/2019 6:29 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >
> > This moves "ops" pointer from "struct brcmf_cfg80211_info" to the
> > "struct brcmf_pub". This movement makes it possible to allocate wiphy
> > without attaching cfg80211 (brcmf_cfg80211_attach()). It's required for
> > later separation of wiphy allocation and driver initialization.
> >
> > While at it fix also an unlikely memory leak in the brcmf_attach().
>
> Always good ;-)
>
> I recall there is some fiddling with the callback ops in cfg80211.c. Is
> that broken by this reorg. Need to look into that.

I don't see how this patch could break that. It still calls
brcmf_cfg80211_get_ops() and passes settings as an argument.

--
Rafa=C5=82
