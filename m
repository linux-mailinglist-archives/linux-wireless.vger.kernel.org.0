Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827193979E7
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 20:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhFASSp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 14:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhFASSo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 14:18:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE3C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 11:17:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e7so5258850plj.7
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhC+qqznpymVevxrLR6Z+UkipRD5f1Y+ypPigsJs+ps=;
        b=pp52p7GZmPLk18tOqXz0Hyyn0mz95r+LTehp27dnodD6eEII+fLuAJircbZj7J5ssr
         XBzKw2ILQvLdAkjgFOr3IkC8ZslP/Ga645uIFXZ8g4IJmCCh8mJN5CO/ut6G5yTffEnz
         OR0SMpgBdmKLr30NHxMwbE4WOFJ45e1bXquALQfBbkyE8317kacKNLBmUHO/IIbaorJy
         VI9O20wQQi9AgG+0MfFAW8by/QGmTSSHl8vxC+pvpZ25T1v41SATxotO0qNdJvWtcB7N
         XyJd3A+Xa9DIkQftM0L7r2sbrPDsg2ByxaquJAY7g2Squq6IxEeidW6xCzGzUNY4blq3
         u9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhC+qqznpymVevxrLR6Z+UkipRD5f1Y+ypPigsJs+ps=;
        b=e4731lKXTmgByZoM3EPqz0iUZbx4DeEXSpFFe2yMIlhVIQxc2ANKgYH1l9//Q9eZC6
         hIQm2rGcK7XMFqExi5aSCz+ZtTWXVV1SzA/1RZLh7QUntBxzKyQ2Nc0L8PbNrmN4FhVx
         LhvgMKmmv9XvcqDD0ebcE6EZleAnMjlWdBW4t2JkouryHI7tRsmLQdAQWMb8z8nVdZxe
         l4t1Evv4bx6yVARQ302z+w/Xvsd9ZBs0v8YoJyKIMsh18w0KKXbWkotvLe6AVebrv4EV
         8qdhrMeNdSCAf/onuUbpVpwolExAXmp0Sa1DT9h9DYaPRlbwhqG3tlmTPV1J5MbQmgun
         WC0w==
X-Gm-Message-State: AOAM531WZLqeucmAsevD74Lv+JD2HTF8dC8riXikYYPn9hBuT0ssYNo7
        TEZ8GcXRR4gs5K3kPz4CFVdoXIZ5KBwzwmIkWvQ6KA==
X-Google-Smtp-Source: ABdhPJyRb4OruYjY14HMrzk3zjs0x1GZMf1Hf+F0AIg27mitO/hvsQ4WYq4Y7nc1SzEfN+ze/iVIovkvRBGszT+NkXE=
X-Received: by 2002:a17:90a:d590:: with SMTP id v16mr25863805pju.205.1622571421462;
 Tue, 01 Jun 2021 11:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 1 Jun 2021 20:16:25 +0200
Message-ID: <CAMZdPi91uOZoJEEaa7xbO=kfAZdn7DoYpAUFuqPsAMY6Z_e-VQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] wcn36xx: Enable downstream consistent Wake on Lan
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 1 Jun 2021 at 17:08, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> In both cases using Wireshark we see the target system receive an ARP or
> NS6 lookup and respond, followed by the host sending a ping or ping6 and
> the target system coming out of suspend.
>
> Similarly watching GTK keying on the AP when the device is in suspend, we
> see the firmware successfully rekey and when we resume, the host picking up
> the rekey material with persistence of the WiFi link during suspend/resume.
>
> commit 5336fad96e8f ("wcn36xx: Enable firmware offloaded keepalive")
> ensures that the link is kept alive in suspend, this additional set gives
> the ability to
>
> - Resolve ARP/NS6 lookups without waking the system
> - Rekeying in suspend
> - Suspending and resuming based on received datagram
>
> https://git.linaro.org/people/bryan.odonoghue/kernel.git/log/?h=ath.master-wcn36xx-fw-offload-suspend-resume
>
> Bryan O'Donoghue (12):
>   wcn36xx: Return result of set_power_params in suspend
>   wcn36xx: Run suspend for the first ieee80211_vif
>   wcn36xx: Add ipv4 ARP offload support in suspend
>   wcn36xx: Do not flush indication queue on suspend/resume
>   wcn36xx: Add ipv6 address tracking
>   wcn36xx: Add ipv6 namespace offload in suspend
>   wcn36xx: Add set_rekey_data callback
>   wcn36xx: Add GTK offload to WoWLAN path
>   wcn36xx: Add GTK offload info to WoWLAN resume
>   wcn36xx: Add Host suspend indication support
>   wcn36xx: Add host resume request support
>   wcn36xx: Enable WOWLAN flags
>
>  drivers/net/wireless/ath/wcn36xx/hal.h     |  20 +-
>  drivers/net/wireless/ath/wcn36xx/main.c    | 110 ++++++++-
>  drivers/net/wireless/ath/wcn36xx/smd.c     | 265 +++++++++++++++++++++
>  drivers/net/wireless/ath/wcn36xx/smd.h     |  17 ++
>  drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  14 ++
>  5 files changed, 412 insertions(+), 14 deletions(-)

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
