Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDCC47323B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 17:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbhLMQtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 11:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhLMQtv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 11:49:51 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A576FC061574
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 08:49:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so53960889edd.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/epOCxL1dYFsUthpYZJekNbI7Df3awc1mycCpxkh7Dc=;
        b=LPxDLsNk9La3dwaKbzk7neuQNEl+wMS4lDTogXkoh2WvpYPpbbjH9HvIK3t5it0uuY
         9rPbLc0x17c5y5gMmLzBDEEnFJLNy9zn5tWBjonwgTAJYdMGe1xAgxA/TEsQ+czJO1g0
         gtJS0II59XMFT5SvkCtjAAFJfcoBVj7puinYrnpZSlBliZVrli6ZblyefY/5qZWa8k8e
         +46mklcnPmIVrFzXImf28V6cGg7Tq+wX1uzBbrAeTngzc1czyyNrRNZGN4eu+V/sUG+8
         IV0+0tXI8j8VDpb9Yn5Ti6J3cG3lEOu/dUKO2DCksz6k+BRpEvnnr/Qo3YsLhv8/+vH2
         cOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/epOCxL1dYFsUthpYZJekNbI7Df3awc1mycCpxkh7Dc=;
        b=omlCMCqpL8Q54fWM82lW8G7LmeqS7CRBSsfdLn3ewVVqKy4eDPnREq9QLElMmogDXm
         cUMs9uVRMZVIF4xBMkfmYyh3Ph+AaURwBDSJK58KifJWntUynHRxiBmWFkJd8CSWlu27
         ckTJt9XjcmkD/6Ayh6nPbhxa5/LN7ozMGN/2tjJp5cV3lOsabIuhhKNyINTDh3g500Qd
         1XE3r2M3UieZcUY7nSSeLuwf4HEKjMfDVRrTsCB7ByL54Q61poIZ2kACSwWNVCf2L3Bv
         71b63LdLBR5Ey0BWsZqNH7lrwI1+21K+mpJyXEDPw3c3NurPjYHerpnKn+pZf5ydbu9T
         FMXA==
X-Gm-Message-State: AOAM533HWU0ORelfe46aYHQswDhbQk0++BIC7FUtNWoGs0i33ceujOQe
        SZZbcfMPMD5SkPiEFZmTHxWzYP9YU9S6FagQUId8Zkkh
X-Google-Smtp-Source: ABdhPJzPmVR4XNPlOqRPgsjycZaQjdbsibwN78OEzWXyxNxjsH1/03Z8t8C2WIAvVtrYgB7MnDE6tmBlPcuPaZMOkJ4=
X-Received: by 2002:a17:906:c14f:: with SMTP id dp15mr45113107ejc.283.1639414189249;
 Mon, 13 Dec 2021 08:49:49 -0800 (PST)
MIME-Version: 1.0
References: <CAKkT90b_C+B-2RY2BDO9tiQJh_Vv8y95JuVGADhc+ML-bSqxmQ@mail.gmail.com>
 <4481549.kEIK8Ajiyv@ripper>
In-Reply-To: <4481549.kEIK8Ajiyv@ripper>
From:   Roberto Riggio <roberto.riggio@gmail.com>
Date:   Mon, 13 Dec 2021 17:49:38 +0100
Message-ID: <CAKkT90ZoMA-FYtMqqu9hm8W--g1Wj1RpkkxzT=OO4zE7VaVP=Q@mail.gmail.com>
Subject: Re: Frame injection on ath9k
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks Sven for the follow-up. Do you know if besides on the ath9k
driver the frame injection is supported also on the ath10k driver?

R.

On Fri, 10 Dec 2021 at 09:27, Sven Eckelmann <sven@narfation.org> wrote:
>
> On Thursday, 9 December 2021 15:41:03 CET Roberto Riggio wrote:
> > Could somebody be so kind to provide me with some pointers about
> > where the frame injection at arbitrary rates from a radiotap header is
> > implemented now?
>
> Not in ath9k - it is in net/mac80211/tx.c. The function
> ieee80211_parse_tx_radiotap will inspect the radiotap header and set the flag
> IEEE80211_TX_CTRL_RATE_INJECT if it was able to retrieve some rates from it.
>
> And ieee80211_tx_h_rate_ctrl will just not try to calculate new rates when
> they were already injected by the radiotap header (see
> IEEE80211_TX_CTRL_RATE_INJECT).
>
> Kind regards,
>         Sven
