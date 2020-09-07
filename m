Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDA326026F
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgIGRZk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 13:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbgIGRZe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 13:25:34 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF04C061573
        for <linux-wireless@vger.kernel.org>; Mon,  7 Sep 2020 10:25:34 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id p81so3804494ybc.12
        for <linux-wireless@vger.kernel.org>; Mon, 07 Sep 2020 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wewuNiWfC3+VcD7XitHx4kJB96Pupcst/n2VBO7spuc=;
        b=QGI4gjlDfckcgjSDRAVGr7u7ISedvmWmOFQ6k8RSBPQoFlbGuUZZc5mXX/tPWckuR6
         VKmHilWolHX07J4w26JjsRkjaqxoSFPUl+ZaSDs29DVjfkeJNFjJDzFs1Fd7jz6+1dfX
         B8b6Z3lkI6VsbdU+rQp4QjYLR72QJgFBEefzqJth0t5Yq9xoF2EKj3LanQNN6LsgoaKs
         mYxvb8SscEZ0T0LuA3PMq0BXZjqyOiipPllsT0/5kcJldnrXubnqeg49KCdhyBm8BRZi
         3xsvAHPlA76HWmnpf3TfbLyzO7gCAfLb7QwBZ8k5hxJNu9VplIhDQ9/+UHkHWRzLYTI5
         Q0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wewuNiWfC3+VcD7XitHx4kJB96Pupcst/n2VBO7spuc=;
        b=CtSGs7K73jcS9Jcso371GsEaoMblHeHEZxbFvHPWvzRenDQiMr/rMcO8yAxVYVmE1o
         amCgH9TZ+HeE56r7yICQskXWasz6775mRavvZqpljKIrkNgHk4waVk9AnEKvzOOTfJRT
         0tgQbzhZvQq6Wvd0+qza2enpFeRxl/8PFbzKErt8Vi8F0KaDw4/45PU3Z+IJbIqV9oE6
         QfWKg7HTl/HdXgVD56cABUqw/yv1x2Rlt5VmzWutigQofWUlJO5AgVNJAYTg4UFJVe7n
         a5JBRdAZv93sJICpRM9cMpbmRusMYYSgYiisdUaw1aoBy7Nxwt1apdz1ALrugOb5T3Fl
         Eo5Q==
X-Gm-Message-State: AOAM532gcsXE9zmE3gTk9RHEB2Cxd7Wi+3xWr18stBRWuecIKfnzhwxa
        GWkDSqgYh663JwhLS6TXCSsqhRhXp5ArgQZweOj9wmVPL3U=
X-Google-Smtp-Source: ABdhPJxAkS0GGipRUHUSSTxKzlYHyqS3F6IMte5kXSvkOH8vCablqC09sgO59baMiIqbTfqEnLGRH0wb7QRPqQUyKbk=
X-Received: by 2002:a25:a081:: with SMTP id y1mr29458416ybh.370.1599499533171;
 Mon, 07 Sep 2020 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <04HAGQ.ASDIWY4TQH8H3@crapouillou.net> <55e3de67208c2120857102d13a896553fbf223b4.camel@sipsolutions.net>
 <CABPxzYLAYaXDfEewA5XR+y2Z0N1yLbEQwQM4FNytamHeZt3ySg@mail.gmail.com> <b7aaab23072e4c06c3cb245a3ea83f11e9ca9e7f.camel@sipsolutions.net>
In-Reply-To: <b7aaab23072e4c06c3cb245a3ea83f11e9ca9e7f.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Mon, 7 Sep 2020 22:55:22 +0530
Message-ID: <CABPxzYKKayOzCt8VwOuV4uysoMVCZ9Ka01yqJnVZ=nyFHhYjqA@mail.gmail.com>
Subject: Re: alternatives to screenscraping iw?
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        linux-wireless <linux-wireless@vger.kernel.org>, od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Sep 7, 2020 at 10:22 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Mon, 2020-09-07 at 21:52 +0530, Krishna Chaitanya wrote:
> >
> > FYI, We have open-sourced our internal library which takes care of abstracting
> > Netlink attributes, just need to define commands and event messages in JSON,
> > https://github.com/bluwireless/py-genl. The initial port of all
> > messages might be an effort but extending it would be easy.
>
> Nice.
>
> I wonder if the netlink policy export I wrote for the kernel could be
> used to generate attribute descriptions? Even if it means just running a
> tool in a latest kernel VM to do it.
Can you please point me to it? But yes, auto-generating those should be handy.
Probably can pick up the header file from sources in kernel.org
instead of booting
into a VM (depending on how your tools work)?
