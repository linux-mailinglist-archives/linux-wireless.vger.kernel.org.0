Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667A03A4457
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jun 2021 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhFKOtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Jun 2021 10:49:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33057 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhFKOta (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Jun 2021 10:49:30 -0400
Received: from mail-oo1-f71.google.com ([209.85.161.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lriRW-0002cs-2b
        for linux-wireless@vger.kernel.org; Fri, 11 Jun 2021 14:47:32 +0000
Received: by mail-oo1-f71.google.com with SMTP id t19-20020a4ae4130000b029023950cb8d35so1650480oov.6
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jun 2021 07:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HM/OpCdDbXxCKOPzELJHKGAfyo0GFyK7Y/hjzFUi874=;
        b=UMhyZ3deS1i05A4CclDVrsYsqFdVgRU9w4neJ8jetunbuXRKxULQIh3I7B35nkMpTm
         ejSfQbWKRGtvTbjC0NP36CU6ZrGAEyrKpVaKv0JAnisjhy7JeiCllpQhQKk1xiGrxegY
         YmSXAylS2PI5iJFlHhQ0pttSjBmOZx6hzTDF6ZhDXofJKg63MazfNyfh/isVp1QWcNtU
         mzQ21yu2HIoSEeZNtDSMotW44fGZRFNwEasxNHdFOXugm0OAY3Y2hDv6BCYoRUQPFpWl
         IXDDWPnL7eBG0ZnDpS0nkeihRDfNEPZA9EcVoRNo5yibtW7R6M0lZK4atYrp6sYsP+Eq
         jkmA==
X-Gm-Message-State: AOAM532VSuMb4YtLOtjD6qBcobgs76W3+YW/YAKhF115OTpk0GVNTzcT
        Nf+tskkGckIbq4F0V2C7SUB2UO/BCZmZNsa5P4hV3s38DZO2SWEyHLoS56zW2Y4yAZ5DlLA1vzw
        OdNBK32QKVS8eR+NuwNtgnlC12Oxy3i9pggY55kSPj/tZ62giXt9zqWZZ6TF7
X-Received: by 2002:a9d:12eb:: with SMTP id g98mr3366597otg.303.1623422849086;
        Fri, 11 Jun 2021 07:47:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNIqId8/saV2hUMjH0y78sNNvpCYY0s9FH5nbvC8+V2xmzfp1e0A6YmUWsCKSiUf4p5z17PA3fUc3Qcn3WFMA=
X-Received: by 2002:a9d:12eb:: with SMTP id g98mr3366582otg.303.1623422848860;
 Fri, 11 Jun 2021 07:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210603120609.58932-1-chris.chiu@canonical.com>
 <20210603120609.58932-2-chris.chiu@canonical.com> <5bb08a2db092c590119ff706ac3654de14c984fc.camel@sipsolutions.net>
In-Reply-To: <5bb08a2db092c590119ff706ac3654de14c984fc.camel@sipsolutions.net>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Fri, 11 Jun 2021 22:47:18 +0800
Message-ID: <CABTNMG0Q6Oh8T_sqW-b3ymdbepYmMRQALGozo6pXiKg=r-ndxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rtl8xxxu: unset the hw capability HAS_RATE_CONTROL
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        code@reto-schneider.ch
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 11, 2021 at 4:18 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi Chris,
>
> > Since AMPDU_AGGREGATION is set so packets will be handed to the
> > driver with a flag indicating A-MPDU aggregation and device should
> > be responsible for setting up and starting the TX aggregation with
> > the AMPDU_TX_START action. The TX aggregation is usually started by
> > the rate control algorithm so the HAS_RATE_CONTROL has to be unset
> > for the mac80211 to start BA session by ieee80211_start_tx_ba_session.
> >
> > The realtek chips tx rate will still be handled by the rate adaptive
> > mechanism in the underlying firmware which is controlled by the
> > rate mask H2C command in the driver. Unset HAS_RATE_CONTROL cause
> > no change for the tx rate control and the TX BA session can be started
> > by the mac80211 default rate control mechanism.
>
> This seems ... strange, to say the least? You want to run the full
> minstrel algorithm just to have it start aggregation sessions at the
> beginning?
>
> I really don't think this makes sense, and it's super confusing. It may
> also result in things like reporting a TX rate to userspace/other
> components that *minstrel* thinks is the best rate, rather than your
> driver's implementation, etc.
>
> I suggest you instead just call ieee80211_start_tx_ba_session() at some
> appropriate time, maybe copying parts of the logic of
> minstrel_aggr_check().
>
> johannes
>
>
Based on the description in
https://github.com/torvalds/linux/blob/master/net/mac80211/agg-tx.c#L32
to L36, if we set HAS_RATE_CONTROL, which means we don't want the
software rate control (default minstrel), then we will have to deal
with both the rate control and the TX aggregation in the driver, and
the .ampdu_action is not really required. Since the rtl8xxxu driver
doesn't handle the TX aggregation, and the minstrel is the default
rate control (can't even be disabled), that's the reason why I want to
unset the HAS_RATE_CONTROL to make use of the existing mac80211
aggregation handling.

And the minstrel doesn't really take effect for rate selection in HT
mode because most drivers don't provide HT/VHT rates in .bitrates of
the ieee80211_supported_band data structure which is required for
hw->wiphy->bands. The mac80211 API ieee80211_get_tx_rate() will
return 0 when the IEEE80211_TX_RC_MCS is set in rate flags. The tx
rate which is filled in the tx descriptor makes no difference because
the underlying rate selection will be actually controlled by the
controller which we can set rate mask via H2C command. Unless we force
the fixed rate in the TX descriptor, we don't really have to fill the
tx rate. Reporting TX rate of each packet will not depend on the rate
from the minstrel, drivers have to handle it by itself. I'll also try
to address that in my next PATCH series.

Chris
