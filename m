Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD01D6C47
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 01:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfJNX6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 19:58:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38072 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfJNX6S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 19:58:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id b20so18311753ljj.5
        for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2019 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPvtAhVgHaqjs/EQbN+HHGKZb04AFtR23CWG2J/pYzg=;
        b=BJXFZaoaOEFudxdPwrAxofTfRLkpnPWPJeiWWKuTGp6VJoxGBpbQIwoa9yAw0ETpOR
         fUqWkUB2yKwREvl4aFh7E8dCUd6uvQa5j1M2ajhez0YC4t84HRFKrFMGe2CJ1HLyRgHe
         t1sAvNxmPRGMV4GaVU+YX30tBlmyR3YL8Yqrm4WsB+cSLCFQ4nwqEr7JvxJQVSjabjsI
         7mxRSVQrdLcw/VX4JDXWFPEu8u65ca8Ton/fO/Q6WwuzB0Nao6fkqz7hu1ToXUnAar2s
         NuQW/zAS16U3yKH4rdjaPOUo8Hto0zkaiRbCgOyxZO2l8fdfLDDCoOzUVtvz5UILL+X3
         0GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPvtAhVgHaqjs/EQbN+HHGKZb04AFtR23CWG2J/pYzg=;
        b=n7lhCAicddgx9ZBNaZRdDE5J8z5+NN2o6d1IUz1jTlQuwfhdsL0BwRgZcn8AxPlSE2
         qz7NSWJGOurnd5HmGUVXEC4OKyHsQdNkmkEC7odwQjojVjLx3gUoiiForfTybv+dN2r/
         Dqgp+IxZ6Jwv5KYS1jbsGcttRu5X1cZfghIDZCo8TQqIXdpQ3NFUfhh9LR+KsB1apSoS
         4olivy+prm3utLWkxIBIFhCi79j+K1G+ze9P00F+qnichX6C37JCdOsC0DGcS3/9leg4
         ZlrWfhvJbWZe1tact3N2xTrqJJMj4DT2isP2mBFL1KirixTO+MXjHH1uHAPrmEMV6rHs
         PUgw==
X-Gm-Message-State: APjAAAV+oAURtRuBQJGk4UK2AS0Fyc6bVAEK5FetDiqY5/sq+BoysHD/
        VR6a+Uk44q33mMX8r6CUNgamEcOY41dOrApfrZR4hA==
X-Google-Smtp-Source: APXvYqwTYFbJV9swRZOOCbryRgaI72elPIj0s6C4+0Lirr86n5yZSHudIeTWAaUCYwEcefjmsTfd0Zn00oPouTLhXtQ=
X-Received: by 2002:a2e:9759:: with SMTP id f25mr9634973ljj.173.1571097495738;
 Mon, 14 Oct 2019 16:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191011022413.176208-1-kyan@google.com> <87wod7y9ui.fsf@kamboji.qca.qualcomm.com>
 <87sgnvy9c2.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87sgnvy9c2.fsf@kamboji.qca.qualcomm.com>
From:   Kan Yan <kyan@google.com>
Date:   Mon, 14 Oct 2019 16:58:04 -0700
Message-ID: <CA+iem5uLYFVQjPaE1QDKc6c+eKz8Xd4LbwczYXOBKP3q+HHdBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Implement Airtime-based Queue Limit (AQL)
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     make-wifi-fast@lists.bufferbloat.net,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Yibo Zhao <yiboz@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Thanks for the help and tips.  Will do that if I need to submit again.

I believe Toke will integrate this with his version and move the
estimating pending airtime part to mac80211, so maybe in the next
version, ath10k change is no longer required.

Thanks,
Kan


On Mon, Oct 14, 2019 at 2:18 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Kalle Valo <kvalo@codeaurora.org> writes:
>
> > Kan Yan <kyan@google.com> writes:
> >
> >> This patch series implements Airtime-based Queue Limit (AQL) in the
> >> mac80211 and Ath10k driver. It is based on an earlier version from
> >> the ChromiumOS tree[0].
> >>
> >> This version has been tested with QCA9884 platform with 4.14 kernel.
> >> Tests show AQL is able to reduce latency by an order of magnitude in
> >> a congested environment without negative impact on the throughput.
> >>
> >> [0]
> >> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1703105/7
> >>
> >> Kan Yan (2):
> >>   mac80211: Implement Airtime-based Queue Limit (AQL)
> >>   ath10k: Enable Airtime-based Queue Limit (AQL)
> >
> > Please always include a change log so that people know what has changed
> > since the previous version:
> >
> > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing
>
> Never mind, you actually had the changelog after the signature separator
> ("-- \n" line) and I automatically skip the signature :) So instead I
> recommend moving the change log up and above the signature separator.
>
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
