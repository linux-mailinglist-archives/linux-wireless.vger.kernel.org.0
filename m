Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B282A33AC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 20:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgKBTJx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 14:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBTJx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 14:09:53 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E57C0617A6
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 11:09:51 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b9so5260229edu.10
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 11:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyQx56zpnmxx8qbe0FMjn+/wJF9Lk5u+0ocSXSWohiw=;
        b=vYcB1TXNWeXSU3MmMr0xTQgtLtZ3WXo4DNh7jP6Bjyp9/8tRTnUEJb1Rp+CGHCRqBi
         2BjJWvSIaw4nVPoxR2WgWXxl1ibyqa3PHlfLG1k6z1qg6XRzjNmY3VNyzbcj/RUQ8rWk
         Y9m76+EwH5s4GuhK0W0g40xup5FwRShTOJO0VlyxQRGVxI5LvLFyD3Pwus4X8MK2DNkk
         i3ydRSm4TLyMfcWwFJHxxzMNg4Qhb8t7b3QB3Si709qznLC6rdK7PJPl6Lubf73QxzPz
         C51Ff16n8f/MN5LuDxs/imTP5UnQkx6H995nWfm/2iu4QGcm+TtOh3szp9emasIwyPJg
         VMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyQx56zpnmxx8qbe0FMjn+/wJF9Lk5u+0ocSXSWohiw=;
        b=aurcUUOBg5GHvR9YGe39+WzLEQlAUlN9+UsGhjryv0ZZky1PDJn0T4rkb9PPPVuP9f
         raJh34Qp2/Tx4Va3ByPBGy4dxbhB0ZeULph17YM21TtR7n3PsNiNOShDb8Sky8SHsw9e
         j41C41f9QQ+Ki641EGK+qzp6TYgknkG6P1bN0PArZWaDIRzG+Frvzbt8/NBlSzaizqyh
         JjbG9Q8Pt9hCoq8Xs+3fmjhmvsW04Z5xO/D8DlkDIwCFisMBPVo2rjcjgb/Uf4Ja8oXK
         jW/Hi+/Lm7Yy1JuogBJ+6K/U9Ak8UyIfXknGKPHVHpSsE1D7ge1BAAq0882l3boerRi5
         C+ZQ==
X-Gm-Message-State: AOAM531o6bqtOCkPvLh8GFpN5pP7jCzsSaVadeD/RT15HsKMA/arNnRP
        4WTWbxUUteNaSdg7nxIgmrdkKTXCza4z35anqwWPiQ==
X-Google-Smtp-Source: ABdhPJzqCyhqOILulAlOhBTc63ukZkd2z209AQVpzux7vhaDGNiF2ItKd1WBGdaNv2VA3MjECLsWHKkBAyISQVi7c/w=
X-Received: by 2002:a05:6402:22d8:: with SMTP id dm24mr9986102edb.69.1604344190357;
 Mon, 02 Nov 2020 11:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20201031022311.1677337-1-bryan.odonoghue@linaro.org>
 <20201031022311.1677337-3-bryan.odonoghue@linaro.org> <CAMZdPi8+_17YSOK3G+MX3dFb0vejeikBYarRR6EckysZD4G70A@mail.gmail.com>
 <53a8a962-386e-3af4-2caf-6ac74fc48a25@linaro.org>
In-Reply-To: <53a8a962-386e-3af4-2caf-6ac74fc48a25@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 2 Nov 2020 20:15:46 +0100
Message-ID: <CAMZdPi88=FX7TEkJ9c=nSggvYQMghT8trUyQ5dcaRdyO1q84RQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] wcn36xx: Enable firmware link monitoring
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 31 Oct 2020 at 14:01, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 31/10/2020 09:57, Loic Poulain wrote:
> > On Sat, 31 Oct 2020 at 03:22, Bryan O'Donoghue
> > <bryan.odonoghue@linaro.org> wrote:
> >>
> >> This patch switches on CONNECTION_MONITOR. Once done it is up to the
> >> firmware to send keep alive and to monitor the link state.
> >>
> >> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >> ---
> >>   drivers/net/wireless/ath/wcn36xx/main.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> >> index 706728fba72d..e924cc4acde0 100644
> >> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> >> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> >> @@ -1246,6 +1246,7 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
> >>          ieee80211_hw_set(wcn->hw, HAS_RATE_CONTROL);
> >>          ieee80211_hw_set(wcn->hw, SINGLE_SCAN_ON_ALL_BANDS);
> >>          ieee80211_hw_set(wcn->hw, REPORTS_TX_ACK_STATUS);
> >> +       ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR);
> >
> > The problem could be that when connection monitor is enabled, mac80211
> > stop sending regular null/probe packet to the AP (as expected), but
> > also stop monitoring beacon miss:
> > https://elixir.bootlin.com/linux/v5.10-rc1/source/net/mac80211/mlme.c#L115
> >
> > That's not a big problem, but that would mean that in active mode
> > (power_save disabled, non PS), the mac80211 will not detect if the AP
> > has left immediately, and in worst case, only after 30 seconds. Note
> > that in PS mode, beacon monitoring is well done by the firmware.
> >
>
> If you pull the plug out of the AP it can take up to 30 seconds to see
> it agreed.
>
> On the flip side, the amount of NULL data packets produced drops off
> significantly once we delegate this completely to the firmware.
>
> IMO you gain more by reducing the regular runtime noise than you loose
> with the timing out of an gone away AP.

OK, fair enough!


Loic
