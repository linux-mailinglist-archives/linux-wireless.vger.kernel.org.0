Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31170105D27
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 00:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfKUXaa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 18:30:30 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38860 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKUXaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 18:30:30 -0500
Received: by mail-qk1-f194.google.com with SMTP id e2so4718449qkn.5
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 15:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TQDZIjgykgtSfuz9Cn5NwLeqCLZx6vX7HuzSqI42oo=;
        b=PU4f/rJn6dHEh4S4wqnSE3iSUucY6+RLuycFeBBCAU0gVGnRbekGLh5b1vQw6Zil5r
         NaKxXbJXUmV8+t3HPVtfdGnkIN/MyZrzoIAqFBfvBSA6lJtQaPGitGcd4K+o0ZD752pz
         61xYvQlnIsAX2wjg/5LBGJ4cP4rZSNhlIVH0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TQDZIjgykgtSfuz9Cn5NwLeqCLZx6vX7HuzSqI42oo=;
        b=QwMNLcxkTVE3XlYb7IUd/qFnbRjeAzuROTs95tw9R7ZIamMQvf13riYMDz9vNxRVOf
         9jgfdq4FtJXOeapTQDy3Evb1N24iR7SKysjlhv5EgGPYd+Nvpzca3j9YnWuPQEnAYv+t
         iNEGr/sc30oJN9Y1kFV+pJuDPoB/6kIAIirxzkYL9VG6ejhaahbjYigQ0zDAK/hKlzax
         ljiavGhnV/1mk9Dku1BdaZEE4WoxOn4yvFxblSq7QbOpwcHl8ASfq/7Eb/6nG3wsH9+J
         0CVcBsoterERqb4gAMRZwZGg38fr0iOBarAjDq/kq/8j3ruNWZhK6r2oaJjECb+7A1ln
         /EtQ==
X-Gm-Message-State: APjAAAW0pghhOkqn3MSi68OE1eq/4YbviBce92+L57LNd/UrrfSkCjxR
        aG+iBCQ5fCqIAiBylPXTpx0NKqCV4ms=
X-Google-Smtp-Source: APXvYqwOpN19L61+f/WHhK4XsjLeNQBosb8IVaHO2TYAuL0e6gwjmUr5yvnI1woIzADEp2Kn2zDi8A==
X-Received: by 2002:a37:6d41:: with SMTP id i62mr10584505qkc.211.1574379026993;
        Thu, 21 Nov 2019 15:30:26 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id i17sm2356731qtm.53.2019.11.21.15.30.26
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 15:30:26 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id b188so4744531qkg.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 15:30:26 -0800 (PST)
X-Received: by 2002:ae9:e858:: with SMTP id a85mr516546qkg.279.1574379025492;
 Thu, 21 Nov 2019 15:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20191121224139.58281-1-briannorris@chromium.org> <e86eb7a3-95e1-f9e1-4ab9-aa38a4f4481e@phrozen.org>
In-Reply-To: <e86eb7a3-95e1-f9e1-4ab9-aa38a4f4481e@phrozen.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 21 Nov 2019 15:30:14 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPZA5ObVJmhm11OQFP2ngeDZhsr_FAgxSz8P8QX+e7WEA@mail.gmail.com>
Message-ID: <CA+ASDXPZA5ObVJmhm11OQFP2ngeDZhsr_FAgxSz8P8QX+e7WEA@mail.gmail.com>
Subject: Re: [PATCH] iw: scan: fix double-free in error paths
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 21, 2019 at 3:24 PM John Crispin <john@phrozen.org> wrote:
>
> On 21/11/2019 23:41, Brian Norris wrote:
> > Hit when, for instance, I'm stupid enough to type an invalid scan
> > command:
> >
> >    # iw wlan0 scan -h
> >    BUG at file position lib/msg.c:572:void nlmsg_free(struct nl_msg *)
> >    iw: lib/msg.c:572: void nlmsg_free(struct nl_msg *): Assertion `0' failed.
> >    Aborted (core dumped)
> >
> > Fixes: 2f74c59cf11e ("iw: fix memory leaks inside handle_scan")
> > Cc: John Crispin <john@phrozen.org>
> wasn't me, nobody saw do anything
> try
> 367e7dd3 (Amit Khatri            2015-06-26 09:02:36 +0000  451)
>                 nlmsg_free(ssids);
> 367e7dd3 (Amit Khatri            2015-06-26 09:02:36 +0000  452)
>                 nlmsg_free(freqs);
> ???

I don't really care about "who", but it's nice to correctly note "what":

Your patch added 'goto nla_put_failure' in the DONE case (or
fallthrough from NONE), which introduced the double-free. Previously,
it was just a 'return', which meant we needed to do the cleanup in
'case DONE'.

For Amit's patch: note how there's a 'return', which makes his code
the only possible call to nlmsg_free() (i.e., no double-free).

Brian
