Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E97434C4C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 15:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhJTNpW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhJTNpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 09:45:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230AC06161C
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 06:43:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s1so14354430plg.12
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPKzGBdS5B7HbtMHdcnVaXbklcsdBx0omuReMhmPdTs=;
        b=K9j3O8/DL72aKJ9hVi0lYC6EvDm+BLrwJfSVK5AgWVF7eneMotAK6AzPkx3m9rBGdQ
         G4QBzGFg5KAkqHQjcK8FJKQJhey8amtSEnmvJAX/fUecsdkWdl017bh4EOmFDnlCNIIN
         Y14YZTgIj5TL5nnx5kTkdVyddm008J1ImD2T2rrhKKKba1jeQkOpxfOeOpN65y6KjfLE
         SIMaS1H6+e2TYYcoLuBaNLKfjlLmPAhfwrlLpODPgAiJL85NrqwatNRXjnb6BejO7252
         61LV0k/77PPHcXSq+zgVvboTTVdgVeMjNzOwd7XxYWCNnTRwTrv7Zgt4EwaGDKw/tT+w
         oCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPKzGBdS5B7HbtMHdcnVaXbklcsdBx0omuReMhmPdTs=;
        b=7l44KAvUm3vWCn4bX0hKMaH/FOqNmKSnGtRI15yl1T8R1wKl7+3FHm4MDnA14aBFCb
         uZ7pMIAO7hhBFMzaCd+ZzGZakTYAeZgU/sbkxoXuTaiBaabaW6QX8QfUPeAt/70etmSB
         XkpPXQ8uLRLeIduQM7swlShr+v9Yc0W8zalcAjFMODrt0JllpT2+yAUXfl1PDXDn3d36
         ddtPp4MSBaHTVDad3xAeF0YvqWHdyqQju61VnfUnhNPHQKmX0CBt+X7PN3hTFCKbNz1p
         OT4WFSwLRqhLdD0UAwLjWUT6r6CSN608fwMCAWSKlVsJxZqrO8xOnNhjQtPF03gVcYw2
         UTZQ==
X-Gm-Message-State: AOAM532rGNHJt8RO8PeOFyK+O9LrAwV2MoJMKv6HVK23At+y0/qcOYjd
        znU59lqF+p89vuyUkb4lgc3iHseVNh0gGlJPVreliWZQM24=
X-Google-Smtp-Source: ABdhPJxzsRYqMH41m8mIVBlGhVlnYRdnWL4qFueM5t0VS7PxQjkMPON87RxjaFtX9jaBFj3b4vOHPOVQTJorarutfxk=
X-Received: by 2002:a17:90b:2404:: with SMTP id nr4mr27159pjb.40.1634737384377;
 Wed, 20 Oct 2021 06:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
 <d2128789-646f-1e02-0dd2-a9ac14b37cf7@linaro.org> <5a325d84-0d02-237b-a0a3-9eddd2e481de@linaro.org>
In-Reply-To: <5a325d84-0d02-237b-a0a3-9eddd2e481de@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 20 Oct 2021 15:54:03 +0200
Message-ID: <CAMZdPi8Mh+pN=xExhY1TFYJYTKCDJmVApNG3oOMFtF5nLu770A@mail.gmail.com>
Subject: Re: [PATCH 1/2] wcn36xx: Correct band/freq reporting on RX
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bryan, Kalle,

On Tue, 19 Oct 2021 at 02:26, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 18/10/2021 23:51, Bryan O'Donoghue wrote:
> > On 18/10/2021 11:57, Loic Poulain wrote:
> >>           ieee80211_is_probe_resp(hdr->frame_control))
> >>           status.boottime_ns = ktime_get_boottime_ns();
> >
> > I think this is dangling in your tree, doesn't apply cleanly for me anyway
> >
> > Other than that
> >
> > Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>
> Hmm.
>
> I'm told by a colleague with access to a router that has channel 144 - I
> do not BTW - that 144 is not showing up with the firmware offload scan.
>
> We should probably hold off on applying for the time being :(

So the missing channel 144 is due to a different problem, and is now fixed
in a subsequent patch:
    wcn36xx: Channel list update before hardware scan

So I think we can go with this change :-).

Regards,
Loic
