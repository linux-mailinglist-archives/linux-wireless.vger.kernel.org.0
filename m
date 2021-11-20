Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A7F457A10
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Nov 2021 01:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhKTATw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 19:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhKTATu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 19:19:50 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C16DC061757;
        Fri, 19 Nov 2021 16:16:46 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id k83so6838497vke.7;
        Fri, 19 Nov 2021 16:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDjafyM9XoUKTQu0bLhImEMbQzcwNVRdVAghZ4NG51E=;
        b=RPkBqMr/avR5YL9/Y1NEnHje4VLopd3IPscNzZWwTCjydizd7ZecF0tp1kkSNGljCF
         hUjUGUJZGxkfuGXT67OpQdheEg8PG/kyvVK1pub27ay/K9HUCEtLmORZRxDJfXqZ4w2w
         EpijSqEvpcgCnLilXHpPEFvLS9Ss6TZIxqMLTLVclg32/NGSs7VKGMidRs43nY8IbhNq
         FoTIndQBoAITLXOv3mYBo9IH/W/elPXsA45QcMRhJAANCv11KLqOmNYUE0WzIoKiP6BK
         K3AMSIdupEubPMlwTA+yAL/o/SfRbfqS5xMXJ6tAdOa9xxj/DkVUln46iIrG/qlA7xt4
         xaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDjafyM9XoUKTQu0bLhImEMbQzcwNVRdVAghZ4NG51E=;
        b=eIe5F9C/hlRLiZgkz2avQehSGvkTBou8VvsiXe71XEBT/mRxDQ1i9vK70JoXB1tfvW
         mhzl3TMlxmfRBZ4A1hr/ERWLYJEeNHeuBuMye/8KaeY9oXGBQfULOMLvvWf4gzoHtw25
         GuuM0dRAEMMVUgK84AS+NQ2Y9Frp0SgjnHnHvmZuDKvd9k6hCPwcbGp/ZB6rtWoLWVfM
         hP+yvgGx3wJIuVgp3TT8uGnCV4OaewVOJ6KJE12k1GbDWzBJMS4Kb9no8G4OOGPWHPYN
         oY8LoalDz6lqalfkXiXr7FA7aKJ56c97TZzKtms1+vKZweRy1jlCUSmzbR8bXIX2+UP5
         LM6g==
X-Gm-Message-State: AOAM531vACSTm2mye6xDFzY3xv0akljKpxIgvJle8FREOuMrpoTnMVrA
        lg/YwTPMdlXks0ECm6rwdUMFTHmCdSaOUz9XcGM=
X-Google-Smtp-Source: ABdhPJyEZqvr7KpCYWkNDymJxnNqyMbRXh09Vn6NtqXovMfLf+UCE19UaNarjTzcCElW/luuVEUHwnDIyCaRT3CaZQc=
X-Received: by 2002:a1f:18cb:: with SMTP id 194mr125262568vky.16.1637367404498;
 Fri, 19 Nov 2021 16:16:44 -0800 (PST)
MIME-Version: 1.0
References: <CAA=hcWT_dmKU1Uj4YmJ_rxZ+HsCVOEYJLSH-h3B3qqNhC1xi-g@mail.gmail.com>
 <CAD=FV=V3n95DNXFd4mHpkAAKapCs5UWZXUkw=1vWpfn6oXfouA@mail.gmail.com>
In-Reply-To: <CAD=FV=V3n95DNXFd4mHpkAAKapCs5UWZXUkw=1vWpfn6oXfouA@mail.gmail.com>
From:   Jupiter <jupiter.hce@gmail.com>
Date:   Sat, 20 Nov 2021 11:16:08 +1100
Message-ID: <CAA=hcWS91uL4kRK8r1uJ_2YLXi1ZuB067ACVPTDZKnF53jgrRQ@mail.gmail.com>
Subject: Re: mwifiex reset buggy
To:     Doug Anderson <dianders@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Brian Norris <briannorris@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Doug,

Thank you for your kindly response.

> I think I blocked most of this stuff out of my mind and it's also been
> over 2 years. ;-) ...but any chance that Bluetooth could somehow be
> involved, too? I seem to remember that things got complicated because
> we could have both functions going at once. I think I advocated for
> keeping it simple and always doing a full unplug / replug of the card
> to reset it, but from notes I guess upstream landed it so you need to
> handle the two cases (just WiFi vs WiFi+BT) in totally different ways.

I think the main issue is many of you tested the mwifiex reset on
Marvell card (or BT?), unfortunately I am using uBlox Lily module
which is a WiFi only no Bluetooth, it is a iMX6ULL custom design, MMC
and SDIO are based on iMX6ULL EVK. I don't think anyone tested mwifiex
reset on that card, to make it worse, I am new to mwifiex, I might be
able to assist with debugging, but certainly not in the position to
contribute to fixing it.

> It looks like there's ongoing discussion going on in
> https://issuetracker.google.com/172214846. Maybe something there would
> be helpful?

I am using mwifiex on kernel upstream v4.19.75, does that include your
fix? Do you have a patch I can add to my Yocto build? Should I make
comments to the discussion at
https://issuetracker.google.com/172214846?

Thank you very much Doug.

- JH
