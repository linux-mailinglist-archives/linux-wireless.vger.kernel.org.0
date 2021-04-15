Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E138361034
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhDOQb5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 12:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOQbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 12:31:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EA8C061574
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 09:31:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so14945010wma.3
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTZ2La04M2sh5ZKGnn2vZEtRsqLZJonoYjzxF0RLs2o=;
        b=ZcgtVQ6lOI0Cqag3hElZuKl9WbV5bWaB7IX17W9RXy/hmCgzdcDaRB0eMEYrs67MqO
         8SKR2wQpB0KohIyeyQh6uwUwimydmbIxRm6uzTMexY9zIZp9WtokrtXHZU5SmYooqlLE
         /9V1Dp+ezBNIB9T4VX36oyprn2+BHqT78zJHy5ovI849L+YnUM5/JmXnb+D0YRm0KtD/
         lsKhw1+FhwLUNyWtjpyZLh586HZQ1jA7VprNLbwLN22Mqok7vgNWoJGbb9JsdqlN0SCU
         nKOrOV7gU3t00UJXy77hKCm4L/EiZLuCMewB4U0SjJYtvHp3hSxO53XGFY6qFGUf2jxu
         v0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTZ2La04M2sh5ZKGnn2vZEtRsqLZJonoYjzxF0RLs2o=;
        b=kk5tS3zOrFDyvx1eOrm4bk1aK5riO+wLpsfvmL/DgJUvjndL96c9VEN2LXZCE/FXL0
         xlew8fPxYIuFxObqJmTo0VTxpPLEhGPcnMn4EuXfHt/Q3gJc6LVD+liyQZSQVa95ydqX
         Fok7lriBL0c7BVnU1wL/YHsB8Bb6ok0wjAT647NfTGRH8OQSEYtZy0++4IhdONkpLHFC
         a9YCoQZ9iqNIiJdqvRLuWRiQNIOuM4FnYQoHux7olOsyII4vcdxEJEoqTLrueIsQYeWi
         3nJgDWgodTkQBTxU6WkqpFoLL08lsLb7xVwhSxyQDmPlJfLVMyWU7HKj1d7T8R59ohF0
         IfBQ==
X-Gm-Message-State: AOAM531IEVhenWvDBK7q03jATIVosCaSAaSgts3+DkmB6bFyHB0Z03Da
        naBIN9CeDT6jyTa2/KAROJjGWFeKk3spjxuN2NxfN0EhSJt+r+dJ
X-Google-Smtp-Source: ABdhPJyTgub2WvfDBiYROzE0KFerept1jIa+hEPoRI5D5SLJh68s0P8NRr9EQ41SzkgVf9VphD+x9HWYzwLaQwmnHp8=
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr4059596wmj.128.1618504289224;
 Thu, 15 Apr 2021 09:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <9fafe866-6ff6-d1c4-0a04-493d863bc9db@redhat.com>
 <CAJCQCtRFqmioneenXeNEoBXnjGCrOeU-SthZKT60bQoMD84K2w@mail.gmail.com> <10faeb84-1232-f179-a687-35a148fb7a0d@redhat.com>
In-Reply-To: <10faeb84-1232-f179-a687-35a148fb7a0d@redhat.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 15 Apr 2021 10:31:12 -0600
Message-ID: <CAJCQCtQosH3Pc2O4yc7n8eTdAcF=7AiJYxh+y1tuEE2kxMGfrg@mail.gmail.com>
Subject: Re: iwlwifi Lockdep warning with 5.12-rc4 on 8086:02f0 (Comet Lake
 PCH-LP CNVi WiFi)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 15, 2021 at 6:04 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Chris,
>
> On 4/13/21 11:38 PM, Chris Murphy wrote:

> > Looks like this:
> > https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm/
> >
> > I tested that patch on rc6 and it worked so far.
>
> That patch has been added to rc7, so I tested rc7 and rc7 still has the lockdep splat in dmesg.

I'm running 5.12.0-0.rc7.189.fc35.x86_64+debug and don't have the lockdep splat.

[   12.502108] iwlwifi 0000:6c:00.0: Detected Intel(R) Dual Band
Wireless AC 8260, REV=0x204

> But good news, the issue is my wifi card uses iwl_pcie_gen2_enqueue_hcmd where as the
> patch you linked to fixes iwl_pcie_enqueue_hcmd . Applying the same changes to the
> iwl_pcie_gen2_enqueue_hcmd function also fixes lockdep complaining for me.

OK super.


-- 
Chris Murphy
