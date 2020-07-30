Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4EA232C3C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 09:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgG3HIS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 03:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgG3HIS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 03:08:18 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96D6C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 00:08:17 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m20so9675623eds.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 00:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STumoN9OLZ9dN9n2DN/SPf/4kl6D1NnZLBRwQvJ1blQ=;
        b=pV0Z0YDl40Bq1xPyCPAH5stvQ6k98ixuXvdyap8XrjhVgV/jTw1IAd59YTwJtDMhiy
         Vw3/njTfwr2bEeFizTjlUVTeO2aWHMc1NWCcL8ErOZTqYP2Jgay5hWZvY73QdGdDmXGS
         /ng47KH3eGNQ3/InMqWOcumUrJ7ZDCUJFT6ODeSORlGmOz2jlmwApZVStZOBSMKOhqJC
         g1FCnZx7Oc+cjUHsuzqwhIqoOdOfnQknUAImHZfK1J+dyCI8Jyefxl01xpV0ZMsowKKM
         wekBGeiXtDfZRWLWTzbfzyFzXJmWP793zmz49j/evfrecTkualMZ4X/ABPBuoDAh8yjA
         vzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STumoN9OLZ9dN9n2DN/SPf/4kl6D1NnZLBRwQvJ1blQ=;
        b=nGcDqVYYgBsCnBAcse55/UArhmKf4hR0wsx+2+rlJwme7VlpqeEdISuSHd24sR2flT
         oieSFXZDe4JY/uOHzv17WwGFSLOYwc+xLE1j30QRbTFNfPIbF6v1FIbHvHlEsC3pWPJ8
         zVN46NZed06nq7PiSeu+Yw6o23uyjBAt3346HqYnQua7ALg5uhAuRzuzHmMd5Eg8LXN7
         wURtEY3n/iyyYpqCfOmAbAV91Ohk7X6rvt1v/UiwgxT1P3vkVrvMJSlWgS7R5kwog5E7
         Vfz1hKa9hqdqNPxw3cAhigyTACjO8XH/2lO5o0TSd+HKOl1eGS3d7CBe5XdFlbvlT1Cp
         bQpw==
X-Gm-Message-State: AOAM532R/vcCNeyd2xpz9qOsAkPkojHsBkwUXhfRLvOCVQGbk22vlrT4
        iuhZ+phq2qlrTuRQXbUp6Q0RAYeevPP96loPyraWIg==
X-Google-Smtp-Source: ABdhPJzGACPKMDjDcoOFL3cMJbd2eOE7mjgKoll7ttwnUkHyh+ALFrshmQbY1geljF1D1mv1U8NIzTrlIPbwxfsASUk=
X-Received: by 2002:a05:6402:1bdd:: with SMTP id ch29mr1340828edb.134.1596092895273;
 Thu, 30 Jul 2020 00:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200729231538.3965043-1-bryan.odonoghue@linaro.org>
In-Reply-To: <20200729231538.3965043-1-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 30 Jul 2020 09:13:01 +0200
Message-ID: <CAMZdPi-EF6=6f3z147DaRP6A+BrZta=_5MjnHJa4nVC4+VCM2w@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Ensure software scans scan on operational channel
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bryan,

On Thu, 30 Jul 2020 at 01:14, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> We need to ensure that the operational channel is scanned, because if the
> AP deauthenticates us for whatever reason, subsequent scans will not work.
>
> This fixes an issue I'm seeing on wcn3680 where my AP de-authenticates my
> device but on a subsequent scan of available channels the channel we were
> initially connected to fails to show up. In this case I either need to
> shift the AP to another channel or reboot the device.
>
> Ensuring the operational channel is scanned means we can never get into
> that situation.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index fb8978a3c11e..51fed732328e 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -416,17 +416,10 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
>                 wcn36xx_dbg(WCN36XX_DBG_MAC, "wcn36xx_config channel switch=%d\n",
>                             ch);
>
> -               if (wcn->sw_scan_opchannel == ch) {
> -                       /* If channel is the initial operating channel, we may
> -                        * want to receive/transmit regular data packets, then
> -                        * simply stop the scan session and exit PS mode.
> -                        */
> -                       wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN,
> -                                               wcn->sw_scan_vif, ch);
> -               } else if (wcn->sw_scan) {
> -                       /* A scan is ongoing, do not change the operating
> -                        * channel, but start a scan session on the channel.
> -                        */
> +               if (wcn->sw_scan) {
> +                       if (wcn->sw_scan_opchannel != ch)
> +                               wcn36xx_change_opchannel(wcn, ch);
> +
>                         wcn36xx_smd_init_scan(wcn, HAL_SYS_MODE_SCAN,
>                                               wcn->sw_scan_vif);
>                         wcn36xx_smd_start_scan(wcn, ch);

Interesting, on AP disconnect, the AP channel is preserved as the operating
channel, but since we are no more connected to the AP, the controller does
not report any received packet (beacon, probe response, etc...). So in that
case we indeed need to scan the channel as any other channel. In this
case your patch should work.

However, when we are connected to an AP while scanning, mac80211
interleaves regular channels scan with link monitoring in order to not
stale data transfer too long and prevent e.g. connection drop or latency
issues. I think this patch breaks connection monitoring in that case.

What could be done is to set sw_scan_opchannel to the current
operating channel only when we are connected to an AP and set
it to 0 otherwise. That should support both cases.

Regards,
Loic
