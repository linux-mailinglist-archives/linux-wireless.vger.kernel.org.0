Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1646D8D2
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhLHQu7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 11:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhLHQu7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 11:50:59 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1F6C0617A1
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 08:47:27 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g16so2559745pgi.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Dec 2021 08:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yadbYYphFkEkfaAMFSiwX6tBmEtXMdLAWERdCpzSK/0=;
        b=jQMkMK66s/0BgRILqucClTXqF8O+0Qjea7LTFuSMjbuqVetp15hcKsbaEKSdq/I8cF
         IvQWYSr0rZBEvvXpk5wVKgCkLjOXrexpJzom86MjCBE1kVx1lzFhP1zUfPOW4g8THKB7
         cOx4x+/4zNuweACT9WZGnSk/MmJ06gQQneF7zswtM1lrzqetQ7EKt+pcEdMuv5ivfTrf
         druRn3bQk43YjOBg3yROxZdDgTAMt4tttC0sPINrPh/3/Rxk7/pTEUQvBu5hGD/jQz1d
         MnA/K9qLKIPk/VzmbIv4TpIZJwtIRdunAdSqLwAcZ884VwzQrevfJfzmoaSD0JT+LQgY
         FvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yadbYYphFkEkfaAMFSiwX6tBmEtXMdLAWERdCpzSK/0=;
        b=SkdQhpyB0yFgKslqZWuwCqKedFUVS7fUQobFEX6xR3pNojeTPdMBEROx0TabQS6HL4
         lX/fmw5/34cmyKj0MxqhRroPan/N9nwCt/QEUyYdPXH0NH0tZT59ZAx/HAs/s3s8JZDu
         xI616zLCRLxjC5vOn0uZJ+03CWPdtErxVygMg6WH8vThz/LExVR1ZbK+Zic6KlknGpbG
         GNFWn8Y3nIB93Y6f5ar39tWuf3FGfBDtTmdrTnMiJL8dYX3azVQ2C+hk/Ylp71gPTuB5
         F4bM1Gkgm2zlSeNYV+GID02hcJccxOT096k8ioYzm9pUsbGZeIoDA/vz8dvzGkcbG3++
         /vgg==
X-Gm-Message-State: AOAM5314tXfZG7skqHY019TIB5m4wHsf3GkkxqUMT1+a9xESeNMyZfK8
        +3uqwbHNhiRI4y6/jnFZD78EH2nP0iVik3KxESlTzg==
X-Google-Smtp-Source: ABdhPJwzkn6jgReZid3pPHGyOZLvSi3hh+F4o6LJiDVTTB1ADFCEftNSVVYuNzbHixZBTydhGJidfyVM0u9zTKyDOLI=
X-Received: by 2002:a62:84d4:0:b0:4a7:e068:2521 with SMTP id
 k203-20020a6284d4000000b004a7e0682521mr6754159pfd.79.1638982046570; Wed, 08
 Dec 2021 08:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20211207144211.A9949C341C1@smtp.kernel.org> <20211207211412.13c78ace@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87tufjfrw0.fsf@codeaurora.org> <20211208065025.7060225d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87zgpb83uz.fsf@codeaurora.org>
In-Reply-To: <87zgpb83uz.fsf@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 8 Dec 2021 17:58:58 +0100
Message-ID: <CAMZdPi9eeVCakwQPnzvc-3BHo8ABv6=kb3VJj+FAXDZbz4R6bw@mail.gmail.com>
Subject: Re: pull-request: wireless-drivers-next-2021-12-07
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, Luciano Coelho <luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Wed, 8 Dec 2021 at 17:21, Kalle Valo <kvalo@kernel.org> wrote:
>
> Jakub Kicinski <kuba@kernel.org> writes:
>
> > On Wed, 08 Dec 2021 10:00:15 +0200 Kalle Valo wrote:
> >> Jakub Kicinski <kuba@kernel.org> writes:
> >>
> >> > On Tue,  7 Dec 2021 14:42:11 +0000 (UTC) Kalle Valo wrote:
> >> >> here's a pull request to net-next tree, more info below. Please let me know if
> >> >> there are any problems.
> >> >
> >> > Pulled, thanks! Could you chase the appropriate people so that the new
> >> > W=1 C=1 warnings get resolved before the merge window's here?
> >> >
> >> > https://patchwork.kernel.org/project/netdevbpf/patch/20211207144211.A9949C341C1@smtp.kernel.org/
> >>
> >> Just so that I understand right, you are referring to this patchwork
> >> test:
> >>
> >>   Errors and warnings before: 111 this patch: 115
> >>
> >>   https://patchwork.hopto.org/static/nipa/591659/12662005/build_32bit/
> >>
> >> And you want the four new warnings to be fixed? That can be quite time
> >> consuming, to be honest I would rather revert the commits than using a
> >> lot of my time trying to get people fix the warnings. Is there an easy
> >> way to find what are the new warnings?
> >
> > Yeah, scroll down, there is a diff of the old warnings vs new ones, and
> > a summary of which files have changed their warning count:
> >
> > +      2 ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > +      3 ../drivers/net/wireless/intel/iwlwifi/mei/main.c
> > -      1 ../drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> > +      2 ../drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> > -      2 ../drivers/net/wireless/microchip/wilc1000/wlan.c
>
> Ah, that makes it easier.
>
> > So presumably these are the warnings that were added:
> >
> > drivers/net/wireless/intel/iwlwifi/mei/main.c:193: warning: cannot
> > understand function prototype: 'struct '
> > drivers/net/wireless/intel/iwlwifi/mei/main.c:1784: warning: Function
> > parameter or member 'cldev' not described in 'iwl_mei_probe'
> > drivers/net/wireless/intel/iwlwifi/mei/main.c:1784: warning: Function
> > parameter or member 'id' not described in 'iwl_mei_probe'
>
> Luca, please take a look and send a patch. I'll then apply it directly
> to wireless-drivers-next.
>
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3911:28:
> > warning: incorrect type in assignment (different base types)
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3911:28:
> > expected restricted __le32 [assigned] [usertype] period_msec
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3911:28:
> > got restricted __le16 [usertype]
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3913:30:
> > warning: incorrect type in assignment (different base types)
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3913:30:
> > expected unsigned char [assigned] [usertype] keep_alive_id
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3913:30:
> > got restricted __le16 [usertype]
>
> Loic, your patch should fix these, right?
>
> https://patchwork.kernel.org/project/linux-wireless/patch/1638953708-29192-1-git-send-email-loic.poulain@linaro.org/

Yes.


Loic
