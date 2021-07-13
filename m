Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022A03C684D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jul 2021 03:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhGMCAm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jul 2021 22:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGMCAl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jul 2021 22:00:41 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A1C0613DD
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jul 2021 18:57:51 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id e1-20020a9d63c10000b02904b8b87ecc43so6995763otl.4
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jul 2021 18:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szaQnat46zYV33fbputUT6X67yS+PgSQo41go6dAtZQ=;
        b=IrVoZW/p0bCx9nGGhI+5mAAKFfAS6WbKL+ydkLbvjWK9JassROsePGVPYNdzqCY+Fk
         MZLZAQ6aDyoeq8whxTm55VEporZYC1nkTZWSX+7AX29XyKej0/uaYXDETZUYe9wdc9rv
         qh94MNoNQjWecHmaBWucv0KfWRUiTJ05/j75Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szaQnat46zYV33fbputUT6X67yS+PgSQo41go6dAtZQ=;
        b=hrYIwfOSRtEWJr2BmvzaC04hdlalCIsxIHUD/lRJGfsD+baH3d58c7MUF77hHtLod7
         x3+N4Of0F8Li0KAsYNM7Q9HxotzUH80ZLMe8Yllm5wHQuFYcmWu03aGCeUUPq/i6vDEE
         MgDE5B7gP+7+iAQr6UavcDAmpOL7fIbSJbYqA+tb4qf6oh0/CiyJzQt4z/rkbE0agB2O
         vYWYC6e+JlY0dg96L0P/5l3FA8nc2IcZ5KFpNmVFT8M5SRhB2HaFgRvAe66GAHAoLOWC
         YWZy8LG4p3Fx6KY3i1BCXI2VHa7lv2PNdSqz61BpbwGoNLt6j7bgpj7Hnqd2R29dXbqo
         6oEQ==
X-Gm-Message-State: AOAM533ftn67VYs/vB1wRvDzYWg9qQJAU5p7qcMuVSqkxLBFaLVLA0to
        /sOqzf/gdZRYjNPyohYQ1eA5BQCqmR4x5g==
X-Google-Smtp-Source: ABdhPJyXSLbJNzm9bU3IkFWZEHJ7BJ8dYZzHW9/zqoVxS/pI01K44ScCPLst2HYKJJrUn6aFjWnwMA==
X-Received: by 2002:a05:6830:9:: with SMTP id c9mr1607416otp.294.1626141470754;
        Mon, 12 Jul 2021 18:57:50 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id 186sm2498389oid.12.2021.07.12.18.57.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 18:57:50 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso20903078otu.10
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jul 2021 18:57:49 -0700 (PDT)
X-Received: by 2002:a9d:684:: with SMTP id 4mr1579814otx.203.1626141469456;
 Mon, 12 Jul 2021 18:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210618064625.14131-1-pkshih@realtek.com> <20210618064625.14131-5-pkshih@realtek.com>
 <20210702072308.GA4184@pengutronix.de> <ceb8911a8ca0465a9f243e1d84ab911e@realtek.com>
In-Reply-To: <ceb8911a8ca0465a9f243e1d84ab911e@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 12 Jul 2021 18:57:37 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMLLEM0aYKU5u6E-xQJfJz+HkqFZjgYKirq8po6HsYc3Q@mail.gmail.com>
Message-ID: <CA+ASDXMLLEM0aYKU5u6E-xQJfJz+HkqFZjgYKirq8po6HsYc3Q@mail.gmail.com>
Subject: Re: [PATCH 04/24] rtw89: add debug files
To:     Pkshih <pkshih@realtek.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 5, 2021 at 1:59 AM Pkshih <pkshih@realtek.com> wrote:
> > -----Original Message-----
> > From: Oleksij Rempel [mailto:o.rempel@pengutronix.de]

> > Based on this and other part of this driver I would recommend to use
> > regmap. It will provide to additional interface for the register
> > access. And typically for the network devices we have an ethtool
> > interface for that.
> >
>
> Could I know the 'regmap' you mentioned?

include/linux/regmap.h
drivers/base/regmap/

It's a driver framework and API for abstracting register accesses,
whether they are accessed directly via MMIO, or behind some kind of
indirect bus (I2C, SPI, etc.). It also happens to have its own debugfs
operators for doing various kinds of register get/set/dump. So if you
can successfully teach your driver to use it, then you don't need to
implement your own debugfs files for it.

I've only ever used regmap with Device Tree systems (which can more
easily specify syscon nodes, etc. -- see
Documentation/devicetree/bindings/regmap/regmap.txt). I'm totally
unfamiliar how to use this with ACPI (which I'm sure you want to
support). I'm sure it's possible somehow.

FWIW, search engines turn up a few basic articles about it, if you
find its documentation or code examples too sparse:
https://www.collabora.com/news-and-blog/blog/2020/05/27/using-regmaps-to-make-linux-drivers-more-generic/

Brian
