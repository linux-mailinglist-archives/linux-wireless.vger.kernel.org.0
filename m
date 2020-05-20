Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631771DC0BC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 22:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgETU7n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgETU7i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 16:59:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ADAC05BD43
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 13:59:38 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so5564783ljj.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/Xdk+2Qjc16LzOVa9lnuQqAqYFbaHhJYfbPjyOMWM0=;
        b=jAMH1927IOAoBJgvE2Gbj2cFEfC8mJsV3BVmnk97PIGu2VwPko5fwcFleC8sU0XF/G
         ITqIoW9YRkeABtk+sSwOOTV+vC5TF+URq5GRPfWFvNrh9ZDc41Ack3poVNcJGSL2iOnv
         ExgXaWUZCNd7yo8NhRoyf0iALymd6I61WzQ9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/Xdk+2Qjc16LzOVa9lnuQqAqYFbaHhJYfbPjyOMWM0=;
        b=IzMVEIG57Aoe3kJ+mQk9uyk4RaIO9e2kNIY9owm8ztFGDbUP35PemRbZFEp6WTZ1zl
         zFP9qRsjum+pk1oZV0bYsuXUSkchxOzPaGhkobjrKmo3rKTTm2zg5H4Lcv6cQ6CVb6Sq
         lpO7zRn8pNjkvOX7Guq6H215C9ShcbUD8UfjALDvnblKU3WkwSCJ88y2Po1gs9LJ6Jsd
         hBR39WOg8xJV0qzO1N7h/aFKZ18h8ISUS0HkjMmx6Y1jmnRnsIU/CFQdeU2242FU2QWb
         +1fSwa5pDfmIky611maYt85+H+Ud9oDtEUo2AAb4WIpRfo/eZE9HtrgYDsPMzoHYjbF/
         bycw==
X-Gm-Message-State: AOAM530rmDI+A8vV0H8RMx2yKI19i5E36vcJD0WPezYoT5G00/UOqaYg
        wZkCZauqelGSfbGB/e037u4E4KMUHMI=
X-Google-Smtp-Source: ABdhPJyIIsAFYnVwuCGXJ3yPYj1trc8uhwmXCZxgOcDFC6yAj4LEKgZzdTaDEH+zPD2Hi28UXhbAtA==
X-Received: by 2002:a2e:96cd:: with SMTP id d13mr3311384ljj.219.1590008374785;
        Wed, 20 May 2020 13:59:34 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id g6sm1279691ljj.78.2020.05.20.13.59.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 13:59:32 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id q2so5494152ljm.10
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 13:59:32 -0700 (PDT)
X-Received: by 2002:a05:651c:3c6:: with SMTP id f6mr3496652ljp.138.1590008372306;
 Wed, 20 May 2020 13:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190906185931.19288-1-navid.emamdoost@gmail.com>
 <CA+ASDXMnp-GTkrT7B5O+dtopJUmGBay=Tn=-nf1LW1MtaVOr+w@mail.gmail.com>
 <878shwtiw3.fsf@kamboji.qca.qualcomm.com> <CA+ASDXOgechejxzN4-xPcuTW-Ra7z9Z6EeiQ4wMrEowZc-p+uA@mail.gmail.com>
In-Reply-To: <CA+ASDXOgechejxzN4-xPcuTW-Ra7z9Z6EeiQ4wMrEowZc-p+uA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 20 May 2020 13:59:20 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM6w-t85hZWcbTqTBA8aye0oka3Nw5YYZH2LqixO-PJzg@mail.gmail.com>
Message-ID: <CA+ASDXM6w-t85hZWcbTqTBA8aye0oka3Nw5YYZH2LqixO-PJzg@mail.gmail.com>
Subject: Re: [PATCH] ath9k: release allocated buffer if timed out
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 12:02 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, May 13, 2020 at 12:05 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> > Actually it's already reverted in -next, nobody just realised that it's
> > a regression from commit 728c1e2a05e4:
> >
> > ced21a4c726b ath9k: Fix use-after-free Read in htc_connect_service
>
> Nice.
>
> > v5.8-rc1 should be the first release having the fix.
>
> So I guess we have to wait until 5.8-rc1 (when this lands in mainline)
> to send this manually to stable@vger.kernel.org?

For the record, there are more reports of this, if I'm reading them right:

https://bugzilla.kernel.org/show_bug.cgi?id=207797
