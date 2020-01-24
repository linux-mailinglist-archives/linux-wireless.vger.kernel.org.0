Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975E91489AF
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2020 15:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbgAXOg3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jan 2020 09:36:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52878 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387432AbgAXOg2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jan 2020 09:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579876587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wj/1Np6tPiIHIdRkmXqH+0Q7Vx47Fnaoj8U+49DUvSE=;
        b=M7fhiPcm49PZ7LeJoVrRNwU/fe4LDai30qHF2bw0aF32jRGI4pzJ/NEqOqVtzQrAGxoymW
        RYroOKeC1kWKmmTqfZHmm+PdMFJ6yozI+fyM1mJc8opqUcIvxIje7pk54MCBozMNebVFTu
        er35tE+dygcwdKx/1COgUJwVmX6AgSU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-k3VuTjwfNSOHMDMD9f7JqA-1; Fri, 24 Jan 2020 09:36:25 -0500
X-MC-Unique: k3VuTjwfNSOHMDMD9f7JqA-1
Received: by mail-lj1-f200.google.com with SMTP id v1so709561lja.21
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2020 06:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Wj/1Np6tPiIHIdRkmXqH+0Q7Vx47Fnaoj8U+49DUvSE=;
        b=hy4dZpbjwEb4fO2K78JAma8B5xkKrtyKg6nR7jd0bxvwXDutuW/t5KSpXEPe+Ccmif
         KCB79sFSX1E8u1CSIsRoMFS97f/cYCVXh+WzEMKV2qKIN2CgWaJ1GIwwUiR645reksZ8
         5sO4EEuzzk9D+F/z8etoJBcAlUez3uPkZnLoJ6NOZugKxMTbsnMuEGkORfRh+1nQ+ek6
         /S4FLUxzqj8jNU1v+ySHrWrccm9pGWdilXiR9sT5hGqz16+b9M5xgRxclI49xwocX2O4
         y56+E0eBHkrlw02MbiLjHTsz6bRRs5BAT37VLPEXh2xO19qQVt7THc/40N6wMzVlHtWh
         gaag==
X-Gm-Message-State: APjAAAXQVIo3CGJyId+VjLYog2zQpLKAi0bxSK86+QVp5CcEGenr0/Y0
        OJO1gumoW/Ml4HVej+GF5iJJQbF+mmxCzsazSSZLM8/hAZpZ73SS72mmvbA2NzDqjYLd4aSwzEj
        25+qsEra7HMH1+8n2HqEFGMowDio=
X-Received: by 2002:a19:94d:: with SMTP id 74mr1465832lfj.144.1579876583878;
        Fri, 24 Jan 2020 06:36:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqznCkM+SnfubCMRf3++pc/n1dVTMwKmIt4aEhx4XEEmHCTRW135YSQE1CXbO/PlbROKBeBGGA==
X-Received: by 2002:a19:94d:: with SMTP id 74mr1465821lfj.144.1579876583661;
        Fri, 24 Jan 2020 06:36:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v5sm3136380ljk.67.2020.01.24.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:36:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 41623180073; Fri, 24 Jan 2020 15:36:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>
Subject: Re: REMINDER: wireless workshop at netdevconf 0x14, registration now open
In-Reply-To: <70df55a1da3e8a99c6d2fc3a479c9c0eed3b71a0.camel@sipsolutions.net>
References: <70df55a1da3e8a99c6d2fc3a479c9c0eed3b71a0.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Jan 2020 15:36:22 +0100
Message-ID: <87zhecgbvd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Hi all,
>
> Just a reminder. We will be having a wireless workshop at netdevconf
> 0x14 in Vancouver, BC. As far as I know, it's scheduled for day 1, i.e.
> March 17th.
>
> https://netdevconf.info/0x14/
>
> Since some people have asked: In order to attend the wireless workshop
> you only need to be registered for the conference, there are no other
> restrictions.
>
> If you have anything you'd like to present or any topics to suggest, let
> Kalle or myself know!

Won't be able to make it to Vancouver myself, unfortunately, but you
guys have fun!

Topics - Maybe trying to Tom Sawyer someone into finally porting the
regular mac80211 TX path to go via TXQs? :)

-Toke

