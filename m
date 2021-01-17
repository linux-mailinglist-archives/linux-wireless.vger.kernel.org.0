Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4AD2F94D1
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 20:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbhAQTPp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 14:15:45 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:33606 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbhAQTPT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 14:15:19 -0500
Received: by mail-qt1-f170.google.com with SMTP id z6so2824596qtn.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 Jan 2021 11:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M7lBAulJy8jpcjGvHmdUY3XtzXQTGPEj1weoI8emR5c=;
        b=D8ZlW58UrKuW7rAOVIjt0ymZNkGGXFYhezZNm1NonrkFFdPIu8uHMWWV1Ypbz8CZGP
         FpfFRwteZMi/nDfR4hu5vQrY6qAd/yc+ar3yGF9dOGD1h8YaANHJEqbWIIXgx05dk962
         N4R1T1MGbh9LXkbHwq7kG3wJjtGoJEVC3ObpGN5yhmgK1dYZqCm/OpsJmCtacwQdm5Gq
         b7b4TcIhqGnPmQQww+zWn8FxfN6EoxqOX7aR7djr9ZU2pSXa70o0zFp2mPBqO62+YBf4
         SFIahhBEDS4DJqAGHZaG1XFGMegcw7caUgRQ6Mr3QYVPXvnth4CSuKkhz+4kXso3hghi
         sKgQ==
X-Gm-Message-State: AOAM532tt2OEHgbWXYMjBwpNrnsvv6NnthHKhRD8KnKRuRlK+ULjeaUG
        alZks7MoJNeJqDndtGWYwKU=
X-Google-Smtp-Source: ABdhPJy7Uhe08V3AUAGf3KVrV/LNLCZVlZD/U36bJc3+fc7vRhskIxym25PSn9I94tN2n3gs++36ag==
X-Received: by 2002:ac8:5359:: with SMTP id d25mr20588019qto.132.1610910877239;
        Sun, 17 Jan 2021 11:14:37 -0800 (PST)
Received: from jumping-cholla (155-186-132-033.res.spectrum.com. [155.186.132.33])
        by smtp.gmail.com with ESMTPSA id s186sm9183228qka.98.2021.01.17.11.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 11:14:36 -0800 (PST)
Date:   Sun, 17 Jan 2021 14:14:34 -0500
From:   Geoffrey Mon <mail@geofbot.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: How to port rtl8xxxu to new device...?
Message-ID: <20210117191434.GA688839@jumping-cholla>
References: <20210117175533.ya3wcb6yyqfgwiln@medion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117175533.ya3wcb6yyqfgwiln@medion>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jan 17, 2021 at 05:55:33PM +0000, Alex Dewar wrote:
> Hi all,
>
> I'm currently trying to port the rtl8xxxu driver to RTL8822u chips (one
> of which I own), but I'm finding it hard to figure out where to start
> and I figured that some wiser minds could maybe help steer me in the
> right direction.
>
Hi Alex,

I am not very knowledgeable since I've only just started looking into adding
support for some older Realtek USB adapters, but another starting point for
adding rtl8822bu support might be the rtw88 driver, which is specifically
built for rtl88xx chips and which has support for rtl8822be (which uses PCIe);
in principle a lot of code can be shared between 8822b{e,u}. However, although
rtw88 includes some structure to support USB devices in the future, this support
hasn't been added yet. There is at least one project[0] that I've come across
trying to add that support. I'm not sure how active this project is but it does
look like they have some work in progress for rtl8822bu.

Best,
Geoffrey

[0] https://github.com/ulli-kroll/rtw88-usb
