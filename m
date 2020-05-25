Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7861E0CA1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 13:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390113AbgEYLPI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 07:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389897AbgEYLPH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 07:15:07 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83789C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 04:15:06 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id l15so9736407vsr.3
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 04:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugyPrFzG1rfZou/QUc1j+oRqX/v9DVxAr6O8y12ShO0=;
        b=fYpsteLqeWgjjB1TqnOAlzxvzWwjeGUQW0ipRWAJlSW5dJ2LfC6HKsIW8YyPor5dLA
         caMrLhwfVZlpOs01pCpfbjNmpzdXMy+GgDFqdUzev9KIp/KEVu2de1fNkPDY+nccFPr9
         K0BzZt39i5XqF0kDJbjq3pbu9oA78lEPq6rBdwo03ojTd030TPWjRfcu/CyOq+tikq9j
         9duOZEWYBkrzWNy14bsdoWjLUOMKP+R56Oi6haQawXjb11ZgD7aki5to+U2/je9VYqbM
         YYlxWwbRs4wFnW1g9wdL5ZQOGuGp0ELuBoW1+QCO5fQmmtgLoDIyw9p9m1IMM4q5yC86
         +JQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugyPrFzG1rfZou/QUc1j+oRqX/v9DVxAr6O8y12ShO0=;
        b=DNVW5zxdBZ7hVxqwJH9BFNKf6xUzzHG6zWVgFucX4DDGhJLk1pCLVtVIFa0LlpOCUf
         pm97vYgf4sqw4U3HAcI7fRFWXE547VqsUab1YppLUr4hvX4dYzqfO4sRvt1ssPvxYXgk
         zrEXJ9s56KtahWV7EjjfBe+rz/IvuFPYmByXBbMR/GPnB+5HQJ9snZihNYlB+ry74jJj
         GU1nkqrMQ+rleKKwezdSrkZ4DwDsYMddV8xOKvkIlNMQGzXLzD5mW12VYQM7+00YGdMN
         0mtFE3bA7BmAejEUPuVxo13wDICVrxDVVGW6oXJrPIUbOchbK5gqKADz0DeBbU2cjXyz
         ddZg==
X-Gm-Message-State: AOAM532DocyeiPcLhxd2mBjb4Jnus7GjcRPxZcAszxLyu2zi7r+OVOzs
        Y8meNrjqRByULHY+F3RlPac4T4XmpEX/crHq0Q==
X-Google-Smtp-Source: ABdhPJw7RMlBhsNIP5qI4buxoWzYjrWv2AoHevEZQqJu5CmPUQ2D8kSSf/ZK+KPwgYns5fwaSe344SXxAvuVB0f+qj0=
X-Received: by 2002:a67:f313:: with SMTP id p19mr14130713vsf.63.1590405305645;
 Mon, 25 May 2020 04:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200524094730.2684-1-rsalvaterra@gmail.com> <20200524111751.GA914918@wp.pl>
 <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
 <20200524123931.GA915983@wp.pl> <640c254edb9fdaec2fd8987d1f2d345bd1d9276c.camel@sipsolutions.net>
 <20200525093142.GA926004@wp.pl> <9a8da74898b68fb63f65567068de0fcb2b5a57b0.camel@sipsolutions.net>
 <20200525105814.GA926693@wp.pl>
In-Reply-To: <20200525105814.GA926693@wp.pl>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 25 May 2020 12:14:54 +0100
Message-ID: <CALjTZvY0qPXxS=VPG3Ma6CCdtWo2g2XC3Cnks6jnNSFzqz-HAQ@mail.gmail.com>
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Julian Calaby <julian.calaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Stanislaw,

On Mon, 25 May 2020 at 11:58, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
>
> Yeah, and at least without nohwcrypt=y we can still use HW encryption
> for non-MFP stations.
>
> Rui, feel free to repost your patch with additional sta->mfp check.

Sure, will do. :)

> If someone is willing to implement mt76 approach to have HW encryption offload
> for MFP+CCMP, I'll be happy to review patch. From other hand, most people will
> use MFP with modern ciphers anyway, so I'm not sure how much need is for such
> patch.

I've been having a look at how mt76 solves the problem, but I haven't
fully understood it yet. I feel it's out of my league, since I only
started looking at wireless drivers very recently (I don't grasp all
the concepts and the architecture). But one thing that also bugs me
about software fallbacks is that for most of the older CPUs we don't
have SIMD implementations of the required crypto. So, not only we fall
back to software, but we're also stuck with scalar C algorithms on
CPUs which are already slow.

Rui
