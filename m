Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF5D37A62B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 13:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhEKMAE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 08:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhEKMAD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 08:00:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D984C061574
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 04:58:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s6so22492513edu.10
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 04:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMmWfje5v/3ff5TxrfExV44yOnwHHQGbkmY9UwvICbc=;
        b=qlazqJx8p7NAApbYvdshN4VG71YhitATGaex9Ai4VS9GIlOZhmJQ+JzyCrpx3Aa26+
         ZYmtfwCGicEGwExsYADT+IGxABleiZYN4b/R/sj4qas11qtkCgheUbWwZf6iUwdIpoRv
         LCE71Og/DWHr3g3dagRV/xv+8F9uJNXc0r7jQnRDdaRvCzZ3DEkZj45Bw/nKXn/onfNs
         UDyF6c519XFkNSkpIHA+G6zREVq6KM1Kyet7rvYulqMwZuV4oFtjGJei3klYKcyEWW7r
         +Yhlyov9BOiBuauMhtpM/KsE90GlQ9sdviFg9nlZspiR89NXpm5qK0omkgxoAgxkEriE
         b17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMmWfje5v/3ff5TxrfExV44yOnwHHQGbkmY9UwvICbc=;
        b=bF1Rsr0Z5zIroRVv6hjI2PHHevi4adOnzdQlwUd5pI40NLNiqqnGHuMZQitkMc9Dtg
         SJqBG754/LfdD/fEd8UH3P6gfxdL1qfVXXDvT1ZeQW5hAyLbr5jOsCdLrKend470WebC
         bqpSsFvzjO0muaYO65jVwjr52IQGJZNfwnE0AKRzalaaclvOfROp3jY4xrEHjSSLdyBw
         Om/ZKis5o/24Ivn81Xx2nG4t6EBMiCFLzpzEqWBcvLfvNMUCEQ3gzI5NdZUSWJME8vxJ
         nDeE+qAFaejcn5VGzpl40b6695jqWMeGtOv1BEh1MIAG6AZBmLZlYll9csAfDEcGDrAI
         vtAw==
X-Gm-Message-State: AOAM531rNK7VLhK8OiZFuoUfd9x2bInhIh6CZ7rWZOCGKeFKTkv8+1qa
        1yzuGGqsrDB/VUpfzKBFtU6KDz5IWvQnQQC38w==
X-Google-Smtp-Source: ABdhPJwtCZlxKp/MTJaQSDl2pAFHHAsO7DjLMHNlPBjyIJirSPNtkL4sAv/po+j73D7RQ7afRYv6j0GAHVVL9L0u/mM=
X-Received: by 2002:a05:6402:17d8:: with SMTP id s24mr35481513edy.155.1620734335259;
 Tue, 11 May 2021 04:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210504212828.815-1-rsalvaterra@gmail.com> <20210505045044.GA735251@wp.pl>
 <CALjTZvYZ8Rr-UFyqFststt+vG+Ei1avUvPVxQwHe72QU0NEeKA@mail.gmail.com>
 <20210505092542.GA757514@wp.pl> <CALjTZvausPmK+AubwcV71b1Vi+JxN23fM-AfUr1+jRD+NbnW1g@mail.gmail.com>
 <20210505132513.GA759295@wp.pl> <CALjTZvaQjGDc2iO7gLvTzXp1xWs78UqFVFxdGVD9ta971bRYSQ@mail.gmail.com>
 <ab30bf35-b05b-685f-2b31-5d211f896e2e@canonical.com> <CALjTZvZje0BNj8Vjxjjn8Lmxrhj5N2-o8ZJJASd-0TZOBZZJFA@mail.gmail.com>
 <e0bd8f82-8c91-0d81-d340-8b87d20179bd@canonical.com>
In-Reply-To: <e0bd8f82-8c91-0d81-d340-8b87d20179bd@canonical.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 11 May 2021 12:58:43 +0100
Message-ID: <CALjTZvan+PDq4zHgS6-OaXTRYknUoaeiGkFhRwuZ79ocot+0QA@mail.gmail.com>
Subject: Re: [RFC PATCH] mt7601u: make the driver work again
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, lorenzo@kernel.org,
        kuba@kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, again,

So much for bisecting. Turns out, while trying to bisect on a faster
machine, I discovered my MT7601U adapters are also broken on 5.12,
with my patch. They're working on a Pentium D 950 and broken on an
i7-4770R. The only obvious differences I see are the CPU speeds and
USB controllers (USB 2.0 vs 3.0).
Since there's only a certain amount of weirdness I can handle on one
day, I'm stepping back on this one, for now.

Thanks,
Rui
