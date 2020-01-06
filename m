Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDD613151B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 16:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAFPsE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 10:48:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46276 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFPsD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 10:48:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id f15so36644911lfl.13
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 07:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JwvXY9tqurF7UPby/hKiLmI+vwuu8lkFlUh/uN9hNic=;
        b=Hn/cweu2M6FZ7choq4dMiPWtJyJuTvwAJEut5S/zWR7D76XVoe1o4aHzIHoRGb+Lhe
         J4i8qcwRd75Ym7qIE37Ea4qyGi5rfgC09+/aqsAKU/rU3yRMvV2betpz5YQJFV77FyKQ
         XW3wn6r/x+J7DwvThnbpQCxWVdTu0LsOENniHwIVVEFMa19FDZOQir6pC3jE9LyFMRAt
         O9BSAKhak8dp3zAU5wduF7V72mT3WEmMoWTlSNHjB1MF2mlC7QpKV5YQN8GvFjbywvPu
         YP2M1QCA4IxM7cFeE6O4U/LsHpa4xyv91L0jbx2QTs8nj6jzg3wymqqRTwoHH6Jv2yxh
         3BCg==
X-Gm-Message-State: APjAAAWBphkSSyDzPuGCTH5U3cXxrDx8VHtipjPgDqlQrSiONy/tw47/
        RZ6M8gs4nyG1tBl/FcQ2nfBQgZpavz5jAELVfHs=
X-Google-Smtp-Source: APXvYqyTWafum5/XkiZoK50r7/V3XLCnT7RlSIH/YbG5hRKZYVIx4AimrqeY9c/ej7J5q+gsYO2EKptimTOzgAz1c2Q=
X-Received: by 2002:a19:5f05:: with SMTP id t5mr57935506lfb.149.1578325681927;
 Mon, 06 Jan 2020 07:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20191222172423.131033-1-toke@redhat.com> <5bab549a72d526f4fd0f708f14b49a7af6e2c0b9.camel@sipsolutions.net>
 <87r20ck3x9.fsf@toke.dk>
In-Reply-To: <87r20ck3x9.fsf@toke.dk>
From:   John Yates <john@yates-sheets.org>
Date:   Mon, 6 Jan 2020 10:47:50 -0500
Message-ID: <CAJnXXoiyWKSLHqMzMcSzHBM-HhfYtcURW1hYd-3Yf7K00NTqgQ@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH v5] mac80211: Switch to a virtual
 time-based airtime scheduler
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kan Yan <kyan@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Yibo Zhao <yiboz@codeaurora.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jan 6, 2020 at 10:20 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> Or do a middle ground thing where we use 32-bit arithmetic
> for the per-station weights, but go to 64-bit for the weight sum? I
> don't really have a good grip on how much of a performance impact we're
> talking about here, so I'm not sure which I prefer...

Double width accumulation is very common in many applications.
Double width addition and comparison are _much_ cheaper than
double width multiplication and division.

/john
