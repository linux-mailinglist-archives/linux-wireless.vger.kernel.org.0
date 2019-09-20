Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F16B99B4
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405556AbfITWdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 18:33:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34293 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405501AbfITWdh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 18:33:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id 3so8047153qta.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2019 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhLiIJuH0SGTBMO9tG834CM4qGoWDAVIb1x577qt9Tg=;
        b=oTl5KYVIwDytGG95Cdmiw73bbg3Y9rwJTRHhL/XFpoOlUimoeY3/LBXCoo4jeE7nat
         PfxB3s0E+p6yPFmENuBxiOWsBC+JqmyhClAKFrKkzGOctOjc8IEhU/3Wg7jzD6UH3I6J
         v5AsZaC3x8I11P7IhUzwZ74P0/jZwpH+yQGyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhLiIJuH0SGTBMO9tG834CM4qGoWDAVIb1x577qt9Tg=;
        b=QP7tWMdQ7te6w7NFWudFa1NLr/U/f0yYZzGpsd94nVX2NToc2pacaJ/Z8juGE2Mgjk
         zJHn1G4CQI672qTHbU4o5ybj34zqm1SjicnshSirPbztTX83Nz5ueZWUlT9sXeAv27hN
         QDKcCCG6urRVPQ5XH9NBJpUjoqT5YKmf4HgYCksj23hBb2eFw+EVHgPQo5nfjd0A0Ros
         uWB9KW470LIteebDfi+dA1Gsi4/AXs2paDozf06o2fljcDgQ4pW+cNgC3TUtGXEwQkhx
         8f5cinblWQYACCEJonQv0jcXWgevlkqiQZfyd4baB1ZZj+FOs0w0IWOCcrT7D+2y2Uld
         m/vg==
X-Gm-Message-State: APjAAAXouQDk14HTA3jSbfm0f8HYGWMoaqSQKlZWXZY9+G6sUb6pRfc+
        PGmKmNIhtrJa71M4PnPNqThw4/ITTwM=
X-Google-Smtp-Source: APXvYqx3yF9o/5jDyFCHbrj7iCwSU9uJ6EF16ga+6AFjcWfknx6dKgYRPHIsQogttchqMwfwwoOxjQ==
X-Received: by 2002:a05:6214:452:: with SMTP id cc18mr15275657qvb.41.1569018815672;
        Fri, 20 Sep 2019 15:33:35 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id j80sm1617136qke.94.2019.09.20.15.33.34
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 15:33:34 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d2so10501394qtr.4
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2019 15:33:34 -0700 (PDT)
X-Received: by 2002:ac8:2d0f:: with SMTP id n15mr5975215qta.305.1569018814060;
 Fri, 20 Sep 2019 15:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
 <1568617425-28062-6-git-send-email-yhchuang@realtek.com> <CA+ASDXOMao9uucGxa6C0Q99pFvAtKTptreeshbfKqiELDKUH0Q@mail.gmail.com>
 <F7CD281DE3E379468C6D07993EA72F84D18DC62E@RTITMBSVM04.realtek.com.tw>
 <CA+ASDXP_7FVEaQrE1V=rX0Vieu8GGWj+it7p4F_8XeRNniEWkw@mail.gmail.com>
 <87tv97ctsp.fsf@codeaurora.org> <F7CD281DE3E379468C6D07993EA72F84D18DFE56@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D18DFE56@RTITMBSVM04.realtek.com.tw>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 20 Sep 2019 15:33:22 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOipB=1j4aALa2FkWvqnYvVZgoNxqb9yKSycAqYxPCWjw@mail.gmail.com>
Message-ID: <CA+ASDXOipB=1j4aALa2FkWvqnYvVZgoNxqb9yKSycAqYxPCWjw@mail.gmail.com>
Subject: Re: [PATCH 05/15] rtw88: pci: release tx skbs DMAed when stop
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 20, 2019 at 1:29 AM Tony Chuang <yhchuang@realtek.com> wrote:
> > Brian Norris <briannorris@chromium.org> writes:
> > > Ah, I was a bit confused. So it does get called from "PS" routines:
>
> I thought you're talking about IEEE80211_CONF_PS instead of
> IEEE80211_CONF_IDLE.

Like I said, I was confused :)

On first glance, I just saw the codepath showing up in ps.c, but then
I noticed it's only for IDLE, not PS.

> Also if possible you should queue patch 2, that reordering will cause
> two H2C skbs not be released because HCI hasn't started, everytime
> enter/leave IDLE state (rtw_power_[on|off]).

That patch also looks good to me, FWIW.

Side note: it's a little bit strange that your driver can silently
misbehave so badly, just by TX'ing in the wrong state. Would this be a
good case to add some WARN_ON() or WARN_ON_ONCE() (e.g., in functions
like rtw_fw_send_h2c_packet()), to check for the appropriate "started"
state?

Brian
