Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5F9230755
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jul 2020 12:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgG1KIg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Jul 2020 06:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgG1KId (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Jul 2020 06:08:33 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBC1C061794
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jul 2020 03:08:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so14340476edr.9
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jul 2020 03:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ici1nNo6rNlYQpg1lc3t6UQAXO9yQYAF7LL5FlZGfwQ=;
        b=YyLJcW54k2hJ89sDuOn1bpy9EOzlrivuo8+6oeZt9PkLpMd6Jz0kQdktu3ONK1sR7B
         DKZ9zQLCY+15o4drTygZt5FSF+GLVSqxgVu9oI8Jpvkw5okjEg2p4liG6lj+ptLJ9QdG
         27J33pKlOLHRC09IVDj4mLsVbJNMeGWs8sKu8a34I4LHxBegXPwjrfBqohTeJ+d8wPcj
         kBoKaka2uVK7NN9891Fmv5klhkqt8IuYhrzxxUQ5FqIYOlne6Sgw7R7jRrr1Kdq5Rt4W
         pn9qpebKe5+zob1vPMxlFmkgVrVOHh8wk9QH/Z/vCesER17NitRb1B8ZZ5RbWe3aVrmV
         Deyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ici1nNo6rNlYQpg1lc3t6UQAXO9yQYAF7LL5FlZGfwQ=;
        b=S5kODEDiAnj2eEq7IEO8RjQJ4pVclP0A5Cy0YzUlHt0NB8zEmMYIPRPMJw5ZvUJExT
         fNSroa7G4JNXSkIJkBB7j3XI0Fs62aJlwp5h8Cnv/jororfblL310rt44snA/nTktOOx
         SJFpnjB7hQyk2Vyhh/Jv1Z9wPtxoHDPQAMOhXFzELoMN8oxhI8kVYEr18ykgThGafWbB
         SqYrcUpx5rJvThKSigFr4CW5IIqmh7zk0sGZw0d3MB2kxrwT0e3IA8hfdsDcTBV/dwI/
         gTbdeKgR8Ss3bUxrgxAvsdllSD4GfMUjU5TvygT3362O8zVkjkGluLagvt2UIiwzYGFo
         vhpQ==
X-Gm-Message-State: AOAM531ukgUVmO8hbEyL9aG/3pGsf526frNDrwO7ogMbh/LRMK4bvu7v
        h868CKL/RaymKB3dxpjaySMGmAJNihJk7JAN4Cknzo2d
X-Google-Smtp-Source: ABdhPJwZiyJUzjxf5hpf8toFvfspU8ITbdpv6E0VstGqONdvtSMs9fH09mvSgJg33PZ7IKAtgdknJwKppDzCiAQeBJw=
X-Received: by 2002:a05:6402:cb3:: with SMTP id cn19mr26309144edb.368.1595930911947;
 Tue, 28 Jul 2020 03:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
 <CA+Kvs9mV39gndidkDjMHswQGii74MH4cTDr9az1HLNOtW6PZTA@mail.gmail.com>
 <CAMZdPi8jgoYsWd6d90WE-sGD8P5LMKO+YAHoP5-xRBV+vncy=A@mail.gmail.com> <CA+Kvs9=0mJ4-6bZUkB3EG-R6ju8UrwJWo3_6aRxzn1tnrGiq-A@mail.gmail.com>
In-Reply-To: <CA+Kvs9=0mJ4-6bZUkB3EG-R6ju8UrwJWo3_6aRxzn1tnrGiq-A@mail.gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 28 Jul 2020 12:13:19 +0200
Message-ID: <CAMZdPi9XiDutLKQbLzwnG_3LkFkpCoOh4yJKnENfSSqYEkvs2w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] wcn36xx misc fixes
To:     Ramon Fried <ramon.fried@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ramon,

On Fri, 24 Jul 2020 at 20:51, Ramon Fried <ramon.fried@gmail.com> wrote:
>
> On Fri, Jul 24, 2020 at 4:57 PM Loic Poulain <loic.poulain@linaro.org> wrote:
> >
> > Hi Ramon,
> >
> > On Fri, 24 Jul 2020 at 15:47, Ramon Fried <ramon.fried@gmail.com> wrote:
> > >
> > > On Fri, Jul 24, 2020 at 1:15 PM Loic Poulain <loic.poulain@linaro.org> wrote:
> > > >
> > > > This series contains various fixes for the wcn36xx driver.
> > > > This has been tested with wcn3620, wcn3660 and wcn3680.
> > > >
> > > > v2: - Move TX retries change into its own commit
> > > >     - Additional patch for sequence number assignment
> > > >     - Reword TX ack commit log (timeout detection)
> > > >     - Fix checkpatch issues reported by Bryan
> > > >
> > > > Loic Poulain (6):
> > > >   wcn36xx: Fix multiple AMPDU sessions support
> > > >   wcn36xx: Add TX ack support
> > > >   wcn36xx: Increase number of TX retries
> > > >   wcn36xx: Fix TX data path
> > > >   wcn36xx: Fix software-driven scan
> > > >   wcn36xx: Use sequence number allocated by mac80211
> > > >
> > > >  drivers/net/wireless/ath/wcn36xx/dxe.c     |  57 +++++++++-
> > > >  drivers/net/wireless/ath/wcn36xx/main.c    | 172 +++++++++++++++--------------
> > > >  drivers/net/wireless/ath/wcn36xx/smd.c     |  59 ++++++++--
> > > >  drivers/net/wireless/ath/wcn36xx/smd.h     |  12 +-
> > > >  drivers/net/wireless/ath/wcn36xx/txrx.c    |  57 ++++++----
> > > >  drivers/net/wireless/ath/wcn36xx/wcn36xx.h |   7 +-
> > > >  6 files changed, 241 insertions(+), 123 deletions(-)
> > > >
> > > > --
> > > > 2.7.4
> > > >
> > > >
> > > > _______________________________________________
> > > > wcn36xx mailing list
> > > > wcn36xx@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/wcn36xx
> > >
> > >
> > > Hi Loic,
> > > What about upstreaming the fixes for several TP-Link AP's ?
> > > The WCN36xx is not usable on those networks and your own tree patches seems to
> > > be working properly.
> >
> > Which ones do you have in mind?
> I didn't inspect each patch, I just took your tree and everything now
> works as expected on  my TP-Link setup.
> I did notice this patch -   "wcn36xx: Fix power-saving with some APs"
> that was missing.
> And there are some patches in your tree that hack the mac802111 core,
> Do you think there's a way to upstream those ?

Indeed I've additional fixes in my tree, but they are either not
strictly required or I need more time for proper testing.


Loic
