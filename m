Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323843737B4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhEEJkI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhEEJkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 05:40:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7E3C061574
        for <linux-wireless@vger.kernel.org>; Wed,  5 May 2021 02:39:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a4so1845409ejk.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 May 2021 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGsxxcLWIt9rn4XQtZ2d26Fl3RzCKqpR2PfknQIsGp0=;
        b=CHVgsJxsZrBTjOnAPO9k0MZNcdWBtFmR5bnzPFix4LOFSKMqdEaQax221Zp6kRMhZS
         W98BZBtgtYbbyepr5wbQINPpNaNWhTdp/r8WXBw/3D54ZiVbec8nVk08xW1h/4Ew2Qsu
         3n+i59YlO7QN8+j3wVqtdKs2hchriDBmNiDI4DA8uZZgfC0jGwSp6eJnAmGJbYv+lnoJ
         A1meY8ZCNh3qn0D/Tjg6vEQrElq2lQgxZtbOZuIZI35N+sZgFHTu6fo/v+7DUd5cuQbU
         ZLWLLAQPmFa1gD4xHHK1DVkgCPXn4l+M/jPkJu9WwSFWmSrG2Qzv+P4G1D0o1xhFMwN3
         ye9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGsxxcLWIt9rn4XQtZ2d26Fl3RzCKqpR2PfknQIsGp0=;
        b=PehLoEuTCui8xw6YZeUOlHPkzixG+VkP80Xsn/QRYLmyW+tM+1Oju0Gl3fZbLaDTDW
         2zAO/6qt9byj+VWBWFPmRqMRV6Qks39ZghgbH2TnkYAw5YlbMSCdVnjf6pkczRQucilx
         9oGokNlyKUk+z8zYtsR8xh3GaSYiOCed6j4mD47dfLKtBhPUqvIk+8aRS7CZ+50UqiPo
         BLWowF9GhsBxcKkm8/p1x70nxWqrN+gOC5NihRYgn+kUSqxV/aDtHq2ZVrZ39kDapQ8g
         RZCH/DbYqydG6s0OCOwsy6CBM45G04Likl87wY8nhO4B9v5aon7Sqn7qhAeEKvPb0/Zc
         KHSQ==
X-Gm-Message-State: AOAM531Wfo7ozrG2URgBbgo+GZ8Z8AMF5MGhucsF7kY700UXKs4ni9zB
        UZzot3hmQsdok1jMc5iZ2Tzmr5ujjK1/B1RgvA==
X-Google-Smtp-Source: ABdhPJzC+A8pCOvW6EaWHld07TPyhTIbwP0GTfz+XMJ6ZjKMwEM+ll4LTDUgNUioRa/yYERKDOZJNrL3UfwzmXJBdhw=
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr23725902ejc.231.1620207549287;
 Wed, 05 May 2021 02:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210504212828.815-1-rsalvaterra@gmail.com> <20210505045044.GA735251@wp.pl>
 <CALjTZvYZ8Rr-UFyqFststt+vG+Ei1avUvPVxQwHe72QU0NEeKA@mail.gmail.com> <20210505092542.GA757514@wp.pl>
In-Reply-To: <20210505092542.GA757514@wp.pl>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 5 May 2021 10:38:58 +0100
Message-ID: <CALjTZvausPmK+AubwcV71b1Vi+JxN23fM-AfUr1+jRD+NbnW1g@mail.gmail.com>
Subject: Re: [RFC PATCH] mt7601u: make the driver work again
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     lorenzo@kernel.org, kuba@kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi again, Stanislaw,

I was meanwhile wondering if we could try and unconditionally drop the
DPD calibration from the driver, and see if anyone complains. You said
it yourself [1] the vendor driver has DPD calibration under
conditional compilation (I don't know which conditions, though, I
haven't looked at it). As far as testing is concerned, all my devices
are 148f:7601, so it would be nice for people with other USB IDs to
test them.

[1] https://github.com/kuba-moo/mt7601u/issues/64#issuecomment-479801642

On Wed, 5 May 2021 at 10:25, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
>
> Yes, those u32 quirks are used to change behaviour of usb-core module
> and we should not interfere with them. We need quirk for mt7601u driver.

Right, thanks for clarifying.

> Ok, please correct the topic of the patch when you'll be posting next
> version.

Will do.

Thanks,
Rui
