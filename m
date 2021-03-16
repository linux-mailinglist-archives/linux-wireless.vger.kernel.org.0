Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC4133D592
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 15:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhCPONi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Mar 2021 10:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbhCPONK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Mar 2021 10:13:10 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3EC06174A
        for <linux-wireless@vger.kernel.org>; Tue, 16 Mar 2021 07:13:10 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id f10so12779242ilq.5
        for <linux-wireless@vger.kernel.org>; Tue, 16 Mar 2021 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=RJm2IchCn9OrHAOUqZO9DoNOk/mru8d5FcBKxtEuzDE=;
        b=O+K6xgUJMLke9aVeLE/xkLszJQeQhG8r8KdEY5Nd4dG+z8GPRQK+31/bdrLEvGkRm7
         r2gS2Mt1lE43PhmdiyjABRyE2bdMAaAj55m/2o+2tpBT4T+q1M0ArOV0Bn3s3sD9c0rL
         G25gsGKkTbNn3qkB1p8IPZEHn9dFvP01P4IYwXKokd/jzFz9h37B0gorBbZr/K0aPrFe
         gnYlC1dZCeV93VwBa1yAiwRPjRtZf+19tWsM8pL8jLCoIndhdvOJUewcfuBl7IEBTBYy
         NHTFcTV7llReHISaTnstNwilQUofEDV1Kp14+yJz6ggXvCSpMM7t5ajW5bnKpyvL4QBF
         yn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=RJm2IchCn9OrHAOUqZO9DoNOk/mru8d5FcBKxtEuzDE=;
        b=uke2oSYgzIfjjSXzvtuUGQUNcoIzuWqsvmTalZTZPia8YLQWpopGSDagWxjsZUamVd
         K7Y4kNxsEpEdOUesT58UatEu92cFgeEs6qE6ITYtsjbNW0juFzg9N/Ya57uJu9UuExgo
         19pxRN97yDB2hE8qF6zrtpVKWU2x+EuL9XjM+tOj3SddT86ui8kpBxVI2eouaTXhFW+a
         xH+95G9GDub5XWT4Ij6JHt9Hgu5xSGcmfFkFLtlefMG7EIA4V41buFiZbeGRTb5DOeOK
         pVoLj4S9gGhtUC+AjaupcXZMhNDw4PhjEoNZOyeX9OP5sSrYY3+iv34ZQAjVy46+rf3G
         6STg==
X-Gm-Message-State: AOAM530EVEqU65tasHZsdgUAMUCs0XtlxnCE7/oucycwZ/avYsrZmR3M
        bwHh98uA0PalbzYmnk40CI6ypF5BGD3FdeK28qe3gfsmkxQfcQ==
X-Google-Smtp-Source: ABdhPJygOU7hinrHZ8LAD/J7OQK1NwOha0GGS34lX8mlSMR9FUvDNECPZpGz6MdqbNc1KI99HEpMyCLMX93BEB94xG0=
X-Received: by 2002:a92:c7c2:: with SMTP id g2mr3902448ilk.209.1615903989905;
 Tue, 16 Mar 2021 07:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRuZ0hACdwH1N23OZrxEVyM2W9gn_O4wZRcFSq_74Gkqg@mail.gmail.com>
In-Reply-To: <CAJCQCtRuZ0hACdwH1N23OZrxEVyM2W9gn_O4wZRcFSq_74Gkqg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 16 Mar 2021 15:12:33 +0100
Message-ID: <CA+icZUW-Ja4dDr8huyiwZrgCxf8vdxkYmP=tiueciJq5TAZsow@mail.gmail.com>
Subject: Re: iwlwifi, WARNING at kernel/softirq.c:178 __local_bh_enable_ip
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 16, 2021 at 2:50 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> Hi,
>
> I'm getting a warning, new with kernel 5.12-rc3
>
> [   14.156547] WARNING: CPU: 0 PID: 766 at kernel/softirq.c:178
> __local_bh_enable_ip+0x97/0xd0
>
> This is with Intel Corporation Wireless 8260, and firmware version
> 36.ad812ee0.0 8000C-36.ucode
>
> Bug contains complete dmesg attached;
> https://bugzilla.kernel.org/show_bug.cgi?id=212297
>
> Thanks,
>

Hi Chris,

can you try "[PATCH] iwlwifi: Fix softirq/hardirq disabling in
iwl_pcie_enqueue_hcmd()" from [1]?

Thanks.

Regards,
- Sedat -

[1] https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm/
