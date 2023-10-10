Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541A37C41BA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJJUm4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 16:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjJJUmy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 16:42:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA205B6
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 13:42:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9adb9fa7200so52192066b.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696970564; x=1697575364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cJ7qBg0sgvbtjbaMF3kiM4Gox7ddpQ2d3bhgQqglVpA=;
        b=gFC00mQBZQL3//LtS28NtLWz/c73+y5p57iKM5sFHBcg9WClYg9FTJ+u6X/aAk5r9G
         4EnydRMCIiBUsIKGXnWk217x8SqBbY6TZg5KJFvno0TIGWkLK6fcmPYnWduQbmMlIs8d
         0jUygBhADxdxObJr2ABABQhca4E0Tt/1QC2DGirRDpkd/h1BzqBxZJvuHCjYSzNkigHp
         6dEo9h5bJyq2qrFEQ/RkoU8zfhIdrwB1hdwyzmWLfBce1NELdpCKvY518L+/ZkOOKK3d
         EAsqLk5W41/d0mdVnWSjcIMbbkIDvSEmLGgeqIbngPqdP/5f786+L/TOlqGXjcHWgtog
         5iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970564; x=1697575364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJ7qBg0sgvbtjbaMF3kiM4Gox7ddpQ2d3bhgQqglVpA=;
        b=PfyQpSN8u+d/TmENWbYtyrsItpASW7Zmn9CO9o9rf4XLXwt5nHPbNHUYvCQ/sudevb
         Lxyply3Ibyj0p7BBBzvH5aAgz0fkChaVlfYH0i2XswMOG+fIitPVjeSkJo4K6VF2m8CZ
         PmNMGPsHb7ZiTxiFJKkBBdhV6i9Wtx0ivHSVHzCZcSidbddwAlFqlN2N04N2jscDmMLi
         ZzNxzILbAu16tcRSHv0NtZyZpqWw5ej9rCvuwrwo3+0/wYsZMzv5uoy+JDI8jbOtQuai
         BKVERwQ3bJXqb/lvIGECT8hS++ZincFqE4MXi3mpUI/C5rRYK2oH3+0ldEZDUsgrR9l0
         B5DA==
X-Gm-Message-State: AOJu0YzM8W8DYO29uLOuPWt0wY6V0dO96H0WYLmWGukQCyjGcKxaFCMg
        lUJeBn4tek6s1V+BPtW1B9tl8Kvk0YE2VNrKv3wq5zm0Ecw=
X-Google-Smtp-Source: AGHT+IHQs0RYTRUgFplgLXT7Y/u7cjVhknwg/TrHzyMF0tQdYRGWRAPEdxrD5vDBxD8tLAujiFxJ/gB8Kp+q7kXCGiE=
X-Received: by 2002:a17:907:808:b0:9b2:cee1:1f82 with SMTP id
 wv8-20020a170907080800b009b2cee11f82mr13004527ejb.7.1696970564116; Tue, 10
 Oct 2023 13:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMvbhGsA4A9qHrYdXcNXLzv7a7xZZq98f90Q-Btb-9vs9ayCw@mail.gmail.com>
 <CAAMvbhHo8wo924YVZqFrLKQko59iSiLMhVAzb=tdSvf_-v1CCQ@mail.gmail.com> <acdb4315780bde3481c44ba90fe341fea75a2929.camel@sipsolutions.net>
In-Reply-To: <acdb4315780bde3481c44ba90fe341fea75a2929.camel@sipsolutions.net>
From:   James Dutton <james.dutton@gmail.com>
Date:   Tue, 10 Oct 2023 21:42:07 +0100
Message-ID: <CAAMvbhHoAgqhCJhHfBLtO0q-E9GvN=-+pix8O93N=rCZ60c41g@mail.gmail.com>
Subject: Re: mac80211 bugs
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 10 Oct 2023 at 15:22, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Mon, 2023-10-09 at 16:56 +0100, James Dutton wrote:
> >
> > Looking at this, it can be one of two things:
> > 1) local->hw.wiphy->bands[band];    is NULL
>
> Yes, I think that's it.
>
> > 2) bands is an array of 6 items, making band valid for values 0-5.
> > If band >= 6, it would cause problems.
>
> Highly unlikely.
>
[snip]
>
> _Maybe_ change it to WARN_ON_ONCE(!sband || !sband->bitrates) there, but
> really I think we should prevent this in the first place.
>
>
> Is this, by any chance, a device without 2.4 GHz?
>

Hi,
I have the same device that is reported to be crashing. My device does
not actually crash, so I personally have not seen the problem.
My device is what I would call unstable (not crashing, just not
forwarding packets) though. My work around is to switch on/off
airplane mode on the client, and it continues forwarding packets
again. Some of the wifi device drivers have some not very portable use
of bit fields that looks suspicious to me, but again no proof yet of
what causes my stability problems. It is why a lot of access to bit
fields in the kernel correctly uses portable accessors like
STA_STATS_GET() and friends.

I have seen this though:
https://github.com/openwrt/openwrt/issues/13198
Which has reports of a few other people seeing the crash.
The device has both 2.4 and 5G wifi.
From what I can see, the band information originates from what the
wifi card received over the RF.
So, theoretically, it might be caused by a bogus wifi packet being received.
I agree that it is unlikely for "band" to get to 6 or above, but until
one of the users who are seeing the problem runs a kernel with the
extra printk or WARN statements in it, I don't think we are going to
know the cause for certain.
I think it prudent to put the if statements in to catch both edge cases.
