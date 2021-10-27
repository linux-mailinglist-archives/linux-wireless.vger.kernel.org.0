Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC143D0A8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 20:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbhJ0S0V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 14:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243490AbhJ0S0U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 14:26:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0A4C061767
        for <linux-wireless@vger.kernel.org>; Wed, 27 Oct 2021 11:23:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t40so3349725qtc.6
        for <linux-wireless@vger.kernel.org>; Wed, 27 Oct 2021 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dU5i2rPAA1rWa1tBZegagA5UHnsbTclU/Hvls+bm6w=;
        b=LnRRS+MmzvGJTLZ4cdjuzpaM79iMGNZvfqRkeBYT+/VV6Zxo3dkTmrRHfLbM2Y/Cw2
         1+b0r9rHhreWhKzLcucFILGrNT9TEqlx0EM0ljZnye2h5Xduc1sS5dWHE1Xk3PzU3B1L
         3RQhu5MNmGTwvqi8CZObzmDLH4GSQbKTFjuwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dU5i2rPAA1rWa1tBZegagA5UHnsbTclU/Hvls+bm6w=;
        b=opU7pIIZJ78jMn8blHedkSwZ03yVIyQUUuQoLPXVv6SKRM3B9Sj5SmAkZKaG5BO+Jt
         P+CCy5IWGBEULCK4hnr1PLEEH8uhnwYvSOo3524icewFTBNa5+XkUllZKb8CyHtVq1M6
         eRzkojeY1MqSPSm+oQoTUP667r6GP8wUJ9uJh8eO6wd3W9W2wEXp2qjS+CWKnZfTlrFp
         9CmruZsrugcP0l9fy+Y8NzfkCBcArOZQWl81c2qqn5+jN9E1S/nsNOljH/gwWe1Divaa
         qcSYtmqU1mkWUvoz7RGpmXbUPruQQfhVeSe2Cn0V5ImH2CHeeOvE4kVqQalLARnCdstW
         Akjg==
X-Gm-Message-State: AOAM530rfU/hRfNnD/IldOWn06zYNejnerU2YMIw0Ai3NN2ACGkz2BMd
        A2Q8LdQCFihSWOZSA83Pu9MkKt71dmTJvg==
X-Google-Smtp-Source: ABdhPJxuXAJ9Jhh6hDNCwv4eZLDv3PhkYBqBVBVtLxTLL8tGfLw/FhCo1JWbqNt/rZoATv109XMIjQ==
X-Received: by 2002:ac8:42dd:: with SMTP id g29mr33531541qtm.168.1635359033581;
        Wed, 27 Oct 2021 11:23:53 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id n2sm444528qtk.8.2021.10.27.11.23.52
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 11:23:52 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id a6so8551565ybq.9
        for <linux-wireless@vger.kernel.org>; Wed, 27 Oct 2021 11:23:52 -0700 (PDT)
X-Received: by 2002:a25:b851:: with SMTP id b17mr32814544ybm.301.1635359032208;
 Wed, 27 Oct 2021 11:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211026095214.26375-1-johan@kernel.org> <20211026095214.26375-3-johan@kernel.org>
 <CA+ASDXNbMJ1EgPRvosx0AbJgsE-qOiaQjeD=vCEyDLoUQAgkiw@mail.gmail.com> <YXkCVLJrQC7ig31t@hovoldconsulting.com>
In-Reply-To: <YXkCVLJrQC7ig31t@hovoldconsulting.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 27 Oct 2021 11:23:41 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPGDOmZgCV01xAAgyOei9sSyNe_VUDWK7pkC_VLs4K8JA@mail.gmail.com>
Message-ID: <CA+ASDXPGDOmZgCV01xAAgyOei9sSyNe_VUDWK7pkC_VLs4K8JA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mwifiex: fix division by zero in fw download path
To:     Johan Hovold <johan@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Amitkumar Karwar <akarwar@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 27, 2021 at 12:40 AM Johan Hovold <johan@kernel.org> wrote:
> On Tue, Oct 26, 2021 at 10:35:37AM -0700, Brian Norris wrote:
> > Seems like you're missing a changelog and a version number, since
> > you've already sent previous versions of this patch.
>
> Seems like you're confusing me with someone else.

Oops, you're correct :( It was only a week or two ago someone else was
trying to patch this, and I didn't remember the "From" correctly.
Sorry!

> I'll send a v2.

Looks better, thanks.

Brian
