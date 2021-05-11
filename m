Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490BC37A461
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhEKKO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 06:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhEKKO1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 06:14:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C825C061574
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 03:13:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l4so28911405ejc.10
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mHSBQXCOCzoWDoIGp6giREC+3XoMpZFoY0SSULtjYsQ=;
        b=O3gOeCPQ61uxJreFnSz2K6rj8r8NcXEeJU2gkM6fOxdy4qRUFmo/zCWLW6xtr+YKAD
         iujfjlhvHvRou8/x0GdnlR8FFMp2xU865qNADM/55ZHuXw3KLGbZ4ViCW+2yO06jwBei
         qHA9E8nnLZe8dVj7yU3ne2leQJdcfY4OVW6bjvXvdyVxJgRC91FtOMxWAwOh18a7YRUA
         XR9DKokbmlDXK4o91Vpffy5vQ5uc/GuRNVsUbDj6FIwSLKOnRT+Ej5n84/HYzMj5SzXV
         tBCIpl/+IBwkT8dZuwF/F6sYaL5+QW/AlhBhBQ7Ue/o/KPljmZwPyLI4wxxFWVENh071
         zeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mHSBQXCOCzoWDoIGp6giREC+3XoMpZFoY0SSULtjYsQ=;
        b=svs8h45klj61Kx/IWvHQ//na6DTAxYV/6YC8NiWm96Vvix/o6LcSYlI7UGyipORmff
         D4DJHgSsj57q3X3rC27f8eHKAaxrjgeFPcqNunY7y42kfUgfCH7nnaavuNkqAo/vLn5m
         w58yBdT5/oq3jWGNi18KseAFepy5TlFJof59IAdXHrmfzZVv4jPaRLz48rAFkQGLpGhE
         rip8lCifoDw6Xi1Lv5+CTmXZ/Ycp4+TBk6GGEI/sS6Smr5cKCwFIgatsouFQwA7f9M8y
         krNw+UQ9T0czLmLQi7EZN6+0a+WPNybs0YmiR2CSOWmsao5PlUk7iYzDHTV5lut95K6+
         E3Nw==
X-Gm-Message-State: AOAM530sodsxrXSOgFh2NvPytsFGVl6KGcJXzXnpylBx+K0JVrYvYgPZ
        w4px7YakrDbVsuQnpRhjqvbIy5a/vDkQADlCYw==
X-Google-Smtp-Source: ABdhPJx3QYC47hJhqjR3NEn35hBN/fPX7EdIYAZe1Xn0KxJggrzdc5D9Gp1pTYXFeFKR0VNn98dNeasDoeWrWVawiGw=
X-Received: by 2002:a17:906:2746:: with SMTP id a6mr30505161ejd.265.1620727997292;
 Tue, 11 May 2021 03:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210504212828.815-1-rsalvaterra@gmail.com> <20210505045044.GA735251@wp.pl>
 <CALjTZvYZ8Rr-UFyqFststt+vG+Ei1avUvPVxQwHe72QU0NEeKA@mail.gmail.com>
 <20210505092542.GA757514@wp.pl> <CALjTZvausPmK+AubwcV71b1Vi+JxN23fM-AfUr1+jRD+NbnW1g@mail.gmail.com>
 <20210505132513.GA759295@wp.pl>
In-Reply-To: <20210505132513.GA759295@wp.pl>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 11 May 2021 11:13:06 +0100
Message-ID: <CALjTZvaQjGDc2iO7gLvTzXp1xWs78UqFVFxdGVD9ta971bRYSQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mt7601u: make the driver work again
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     lorenzo@kernel.org, kuba@kernel.org,
        linux-wireless@vger.kernel.org, colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, again,

Well, this was "fun"=E2=80=A6 I rebased my patch on top of 5.13-rc1 and now=
 my
MT7601U adapters are broken again. I tried different combinations of
mine and the the last two upstream patches [1][2], but the result is
the same, so now I have no idea of what's going on.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/net/wireless/mediatek/mt7601u?h=3Dv5.13-rc1&id=3D87fce88658ba047=
ae62e83497d3f3c5dc22fa6f9
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/net/wireless/mediatek/mt7601u?h=3Dv5.13-rc1&id=3D670d9e53886c942=
b7f29c475b2b494278e586921

Thanks,
Rui
