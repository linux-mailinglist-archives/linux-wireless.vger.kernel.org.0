Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2024B45E310
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 23:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245145AbhKYWqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 17:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243877AbhKYWoE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 17:44:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52176C06175C
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 14:39:03 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g19so7055354pfb.8
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYv14kZYE4AF2Ym5Xu7adceQk8b7SUuJqwMzSpHa+bY=;
        b=G9DMCRuIAhqctvDmi0s7ct7CsY7nrMePWH70kkq1/XNxBC7q5P3KBl5mPk1V6VcKhD
         sv8UtouU6ZLAs5Rxsc6DtXsAZW9GlRSqH98k00R8BP+KckjGt4kFIF4a3zb94OKos/oQ
         vOASqSEsN6FD5sI9qSQReXK4KM+AExJzqwDdMUzlO9UTBnL+BGhmfTBrY+XaoQFE3he+
         dquX4l2tUk2Q5GrVFE4PWVMNGkFLJcWIDwLR3lC8WqAGVoX6DJPb6munRkF/AGGFLSh5
         Ve8B4R5JiPd+7KeWS9QNu0rAqyf19ZtIs/LOQBqmW7u6MkRuL6ANu9nvMPa+pnYQr34q
         VfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYv14kZYE4AF2Ym5Xu7adceQk8b7SUuJqwMzSpHa+bY=;
        b=frj3cG/vz1PHb0HEqYqawdK8bd4Xxfmz0KVG8A37JdvklYQQnoaHmAMs1sdefMEgRt
         iw2SEYzo4AogeI8ymNW3CgeRKIcfEoAgW9cg8Yu2MJEyj+wynImCl2pLT5DhdBuljpcC
         lshLXVetXo0R7BNOlPevwnOZzuSRYa79xGaBhx05KGrW6X9aBlIeGf75loSkRDYkq+/i
         0PH16dy/sg/m2ni3pqDGthnPUHUL7E2t2WQ1VCaWOZYkD/yw+/e1PsGmeHnCDu55mopi
         s2sbR7T4lsUflndrPU+XFBhVHJowFqkMGV9i+5PMjNIBUVR1EhiHr0jPLa4h7NbYX9r/
         tmcA==
X-Gm-Message-State: AOAM530lRsM8LAQvNNI4b6aJ13Lv+5OmnmL6rX0fYSUD/CmW8UTFt2P4
        25KiuD1IZEEpDoibuhdZjh7qm1e9ZRQFOYc7U/U=
X-Google-Smtp-Source: ABdhPJx7kiGLhfcVAfJFOq/wYRMvo3nUxlq4MXgPiHV5bmqEtLiVzWSU9vpBeEf6MNIRp+p4YSMxnWYRODwh1IPYj/w=
X-Received: by 2002:a05:6a00:230e:b0:44c:4f2d:9b00 with SMTP id
 h14-20020a056a00230e00b0044c4f2d9b00mr17054324pfh.24.1637879942841; Thu, 25
 Nov 2021 14:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20211125121652.6073-1-jelonek.jonas@gmail.com> <878rxcb4q2.fsf@toke.dk>
In-Reply-To: <878rxcb4q2.fsf@toke.dk>
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
Date:   Thu, 25 Nov 2021 23:38:52 +0100
Message-ID: <CAChE-vT1UMw2iadzuzsUPEcAopi=86N4GV_b4=chZbSvap3x=A@mail.gmail.com>
Subject: Re: [PATCH] ath9k: switch to rate table based lookup
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org, nbd@nbd.name,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> What's the practical implication of this? Performance benefits, better
> rates selected, or what? Got any benchmark numbers?

We're planning to annotate and implement 'transmit power control' per
packet / per MRR
and to improve the rate control API in mac80211 to support newer hardware.
SKB->CB is limited in space, tx power annotation also does not fit in
there. Future
perspective is that rate control won't use SKB->CB anymore, neither
for normal rate
setting nor for probing.

The new rate control API (introduced with commit
0d528d85c519b755b6f4e1bafa3a39984370e1c1) allows drivers to directly
get rates from sta->rates. This is not used by every driver yet,
ieee80211_get_tx_rates performs the
translation/merge for the drivers.
The call to ieee80211_get_tx_rates and subsequent calls in ath9k can
be avoided by directly fetching rates from sta->rates. This may also
improve performance.
ath9k does not expect rates in SKB->CB, therefore table merge does not
need to consider this
(except for first rate in SKB->CB for probing).

> You don't generally need a co-developed-by for yourself, and your S-o-b
> should go at the end when you're the submitter...

will fix this in V2.
