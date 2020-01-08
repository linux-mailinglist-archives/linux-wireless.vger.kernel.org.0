Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC6134081
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 12:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgAHLbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 06:31:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32219 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbgAHLba (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 06:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578483088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/OageDLG6RxUzUD9TkM1rFJAKj/7G8+QteYbgN68XfI=;
        b=Z4nww/utnTM0fDo2T+OL7o/v0oRyM5Yh62YI0TczXAIwtF/mKQ6/zXqf/e7ZLxQAFdZ9lF
        +G7fZtFKKhbzqQHKCLA+D6lsusuXiEKOGbMf0pB36UC+4K+NSGlENL4Uh9ujDF4iexyM98
        ewWWxELhrx5wJ9xzUICbruPPV2232UQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-yKchjcM9OmOTqZXksLpo2Q-1; Wed, 08 Jan 2020 06:31:26 -0500
X-MC-Unique: yKchjcM9OmOTqZXksLpo2Q-1
Received: by mail-wr1-f70.google.com with SMTP id j13so1304608wrr.20
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2020 03:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/OageDLG6RxUzUD9TkM1rFJAKj/7G8+QteYbgN68XfI=;
        b=tf8t/nmPP/021nfsQ/eqLGsRL3ysFS8GMBh6cm61S0IbiGAe3hiNJOmpCVCWQaYoJX
         fRb9zqKsYBx8dH371h44nrd6GJ61Rtg/7+p12vmLiNCD8JohUYxcLbFqMZoX6BOecpFr
         1kxtn21IWxe70J93GWbfCQEIhoFzHlIrkzxCMbMPPiAbsyLFcUX7Ho5BVpzYyRI2oPAr
         L8qPFKX/j1xil+vg3Y5nWOc4df/hZK9O5/pzydCaG/C3pXNUC8LUrCwiD7nKWN17igz7
         0JRJm1W3Fy4S6FxEVJywwsiO14WZUMTsQ85U/er5Zp9rnskrwJEtoorhj0I5fmrCkITD
         mFiQ==
X-Gm-Message-State: APjAAAWUfnMkTEoq3JRW2i/oMMVhD84F3hkQFuNVKAFmevzZz07+9QEr
        JgNX6qS0Yf1871FOCnqRam5qWr9v2WQWjjXT7AnISoRZbI9+DioidylgyC11g2xXmVgFiiOq8e/
        O1tDRK1go2T2zkN260LUSOcBYh0k=
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr3756690wrr.215.1578483085474;
        Wed, 08 Jan 2020 03:31:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxnyhVvM1qxOyT6o22YoHnbJyuSgKx5ARe0pjQgUYQ/msryfsiIFlJWyzmn/XVugpWCzMPLQ==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr3756671wrr.215.1578483085267;
        Wed, 08 Jan 2020 03:31:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t131sm1413947wmb.13.2020.01.08.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:31:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F1C4A180ADD; Wed,  8 Jan 2020 12:31:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Justin Capella <justincapella@gmail.com>,
        Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
Subject: Re: [PATCH 3/4] mac80211: fix low throughput in multi-clients situation
In-Reply-To: <CAMrEMU8qoD=-45sePbp+W+F+5mQmviMQaZjzXe_Ph2cNjan+OA@mail.gmail.com>
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org> <1576221593-1086-4-git-send-email-yiboz@codeaurora.org> <CAMrEMU8qoD=-45sePbp+W+F+5mQmviMQaZjzXe_Ph2cNjan+OA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 08 Jan 2020 12:31:22 +0100
Message-ID: <87sgkqgp6d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Justin Capella <justincapella@gmail.com> writes:

> Is there a risk of division by zero?

No, weights are always positive.

> I'm curious about IEEE80211_AIRTIME_QUANTUM in this multiple sta
> scenario, should weight maybe be the depth of the queue or something
> like that? Using real time delta I assume is not performant?

Eh?

-Toke

