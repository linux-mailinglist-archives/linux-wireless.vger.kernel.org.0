Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B0C439A97
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhJYPi3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhJYPi2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 11:38:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58514C061745
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 08:36:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m26so11114675pff.3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7I3mf4otn1IS4JK7DtNC8qk/MkWqhKGjoq8SJXtvT1M=;
        b=UcNMN/LQrUBLH6y3zqM1DmCyFvmnroIQoE/yvSYOpfIPWRQ+TkctP8XKu5IbHm4Wfl
         EF7bOzWWpbKvcUMKQLlUphuZO5/wLYP930WWunPGL3sr9G7d6dQMVgBiN+UlqJHb7pZT
         oPeVgxv5O3M6BOA6nj/cqHHTayKQsKiAopyHWbECJTPYcQipglBS7yA3yvmuy/rnHEuU
         HxNUwYAeflqoLPkIt8z8yLsYw+oL44LsAPP7wS23m9MnBxynHZfZ97UwPLMX7eGNGKr2
         6wp4OaCHD0QW8l+GOAzWj+IceIUqmvoS8hFwlo/M7jojcBJSa9T4cU/RTNnronr2eQJH
         ma8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7I3mf4otn1IS4JK7DtNC8qk/MkWqhKGjoq8SJXtvT1M=;
        b=3jZlOzMLXWSHIYtU+wRKxmuDkzx9Dphs0wJXKlcnYFqzcpruAuwLymThC9PMZFUAAZ
         u43tYxAKjm4cZYzJwUviLEwJaAxuOfhA8OL5G87+Q113EhfVsjzaJqpBw857Wa1IFSKL
         TWiv+vLnTf/mEk/7yKVmzi6yscz/inENrx6tprFmPT38jiw+ka5xC0X8SKpduEY0iWWj
         lrJfwZ1YgCoFWj8RfhO/0PQMCACTVCOOeWwvn/zkgUzUNxgy2F+aXk1ngJDfajIfKiXn
         ktKw7HCcx7JAuhl37n39Y6zZL5FgccVHwe02ADuFVUxRiK/DEPZ55EO+ZScP9TGZ6c0V
         z40Q==
X-Gm-Message-State: AOAM531er+RQP4a2zxICDiGvbHTaDdT8gM2DxSlE3290mXAhuvUWdR0h
        06C4NzbHqFvM4O8zpI03YzvjN7By3sdL+PbbjUya9rMrgGrOlw==
X-Google-Smtp-Source: ABdhPJyM5MRpbJnduW4TtmWRFvBrlXgYjm+xXJ6iAI0XNmOZNinZVfESMUoLpGItisWIs3u52L55ZVSvnZCPQyZvv70=
X-Received: by 2002:a63:6e8b:: with SMTP id j133mr14065147pgc.48.1635176165734;
 Mon, 25 Oct 2021 08:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <1634557705-11120-1-git-send-email-loic.poulain@linaro.org> <163516812328.10163.3396652728924346112.kvalo@codeaurora.org>
In-Reply-To: <163516812328.10163.3396652728924346112.kvalo@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 25 Oct 2021 17:46:58 +0200
Message-ID: <CAMZdPi9uUXiQZjLLu_ccG6PZgdvdgEKtZQDspEoM1=tXdS0ggg@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Add chained transfer support for AMSDU
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Mon, 25 Oct 2021 at 15:22, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Loic Poulain <loic.poulain@linaro.org> wrote:
>
> > WCNSS RX DMA transfer support is limited to 3872 bytes, which is
> > enough for simple MPDUs (single MSDU), but not enough for cases
> > with A-MSDU (depending on max AMSDU size or max MPDU size).
> >
> > In that case the MPDU is spread over multiple transfers, with the
> > first transfer containing the MPDU header and (at least) the first
> > A-MSDU subframe and additional transfer(s) containing the following
> > A-MSDUs. This can be handled with a series of flags to tagging the
> > first and last A-MSDU transfers.
> >
> > In that case we have to bufferize and re-linearize the A-MSDU buffers
> > into a proper MPDU skb before forwarding to mac80211 (in the same way
> > as it is done in ath10k).
> >
> > This change also includes sanity check of the buffer descriptor to
> > prevent skb overflow.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> Loic, what should I do with this patch? Bryan is hesitant but I
> would be fine to take this. You have to decide :)

So the point is that we had some skb overflows reported in the field,
likely due to wcn36xx_rx buffer descriptor parsing, and possibly due
to the A-MSDU split. No such issues have been reported since we
applied that change. But I've not validated myself that the A-MSDU
re-aggregation procedure is functional (though it's mostly copied from
ath10k), since it can happen only in very specific cases, i.e when the
MPDU (including the A-MSDU) size is larger than the 3872-byte DMA
buffer and smaller than 3895 bytes (which is our max VHT MPDU length).

But it's better than the previous situation IMHO, since we check the
buffer descriptor to prevent skb breakage.

Regards,
Loic
