Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA7C303E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfJAJcZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:32:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39767 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbfJAJcZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:32:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so20723024qtb.6
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFYZf47XM4r0xE8wHoVEHk7v0YQ69pCu6pGafD2jwco=;
        b=iDAM+R9ANcbzIjKCTN6ZYSi+Aksa0PboAWyf4s6tXCRILXfjN3srMVk9rzXdIqonNN
         C9tv2GNLMLTLlcZF4RTX407fQQa7EBvmm2QK21l9IcRLfczMl3ma6kDFRqqyBPouORRx
         JZ/RhDpKYXtEX30EgeQ56tCgIuBlcbFg9y2srZkbkZX+E7tUi8PYPAYd2r/N17AWhvVG
         s4Et//tI2AlllqkmYdaS8QVYEKC15gqaZ4bH6rNd9y/yNi15b2pDCdtRFyPfJjHI46yl
         sGHyzAzz7QTQhSZLZoWbeNkX5FWMhPnhPPCFNgYOPGekKsGpB5/ZkIhxmOuO4a8p+QWr
         jTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFYZf47XM4r0xE8wHoVEHk7v0YQ69pCu6pGafD2jwco=;
        b=jUhfH2oap5sspYB2Eb06PbHaglne/AOQGCZMBSJpTKO5jzJ8X4yfFWPZSU0jNtQQlo
         jWABaca1JvopT0BYB7jqEluVraLDYE43kOKWY7SagLlXrX1hLRFuLnm1kVAYZUwrJWk7
         InsPBbU7CBYLpuwduZxEBUecEyZ1kALkqIoikroHrliyVtqeCBzrtZK3Deijm7rdTVNR
         rIEWKQ8ICzGLTZdImnIhbLbGgiOgvNet/SLFmeBxBMLbzV8rOPmAIBshrIj9AEGm8rdF
         frB1R4BRG9TlNEBh/snzE0hekQKWAEmvNURcqqL5wDhpPE3d/54tXGgnvkXFBlxTRdWz
         /V0g==
X-Gm-Message-State: APjAAAWhXRlhYv617M8+FWdKxctvYikTt1jZsLo73OiWL1TB3clP2UJZ
        E6U1bQdgEKNSkp2o6NZzrWogd1PbDLr34V01geyj5Q==
X-Google-Smtp-Source: APXvYqx/69O5IdHsZutFRVhhkJCSDgmYpJbh7WyfugO2INdJv/xpqNfiengrZJKHyEPhWEsJ/6sllro9UJLiTLagBoI=
X-Received: by 2002:a05:6214:30d:: with SMTP id i13mr24557854qvu.101.1569922344454;
 Tue, 01 Oct 2019 02:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190911025045.20918-1-chiu@endlessm.com> <CAB4CAwcs4zn4Sg0AkFnSUE-tbkdrHE=3yYeF8g+-ak5NyPBkuQ@mail.gmail.com>
In-Reply-To: <CAB4CAwcs4zn4Sg0AkFnSUE-tbkdrHE=3yYeF8g+-ak5NyPBkuQ@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 1 Oct 2019 17:32:13 +0800
Message-ID: <CAB4CAwdO5evU8K5qjGe0rXJPmQA8gSd0tLkN6nh-EzyATU9aOw@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: add bluetooth co-existence support for
 single antenna
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 19, 2019 at 9:44 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Wed, Sep 11, 2019 at 10:50 AM Chris Chiu <chiu@endlessm.com> wrote:
> >
> >
> > Notes:
> >   v2:
> >    - Add helper functions to replace bunch of tdma settings
> >    - Reformat some lines to meet kernel coding style
> >
> >
>
Hi Jes,
    I've refactored the code per your suggestion. Any comment for further
improvement? Thanks.

Chris
