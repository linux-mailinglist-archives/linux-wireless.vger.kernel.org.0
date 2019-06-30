Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DF45AFB7
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2019 13:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF3L0I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jun 2019 07:26:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37875 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3L0I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jun 2019 07:26:08 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so22301853iok.4
        for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2019 04:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2xGhLIhJxzYJmK6yu7KIASy2vAPUF+ecm7xk4TshZk=;
        b=dyWFcu4z41Ggefsi0usueNNxDR3Fh+Zf6pJCxX52P8kLIzq5uFkC8l+02dww1JQsCO
         mxpxmzQy+d+kD34SjUi948AEz7rk0ZPHuWEvSceI3TIBkzTliiS8kofPcFq/G7C7J+Hx
         yg5Whn6hMrmr+Xe41WXofr9WNrDFh4OQFJR7JmttT7L7HFusoANBRWRL/ROH+qGt+iI0
         7hZ0l8N1GFLhfimTkoNj/60ES2G6g92qphvlSreDikLNiwC5lHhLYaTidkVOWTFlhDzA
         URgixqkOJTKqvVDhv6koqRVPJKIqaYqiOxsgN6TOc75o8dS+PaS3j42Kk8hOEzb05A3K
         Q32A==
X-Gm-Message-State: APjAAAV3OhU1Ai2N1areiqdhWagUbgrM2PxWQIP/+ptJFwmzIChfbP73
        zb96aV6CO9V/aQZiWj0JW4YNQepsm4FK8fKXfAqSkyQl
X-Google-Smtp-Source: APXvYqyAve6LMjTFF8zRF1u/ktRRPUtFWVU3eq4DsL0xT3DU0J0fGkHMEArMzUrWp/voAK004HTXQz2GPQ5ZUvrQ5w4=
X-Received: by 2002:a5d:8702:: with SMTP id u2mr11733362iom.228.1561893967594;
 Sun, 30 Jun 2019 04:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561804422.git.lorenzo@kernel.org> <33184e0b78983fe7c79fa70c5fbb21042aafa4f5.1561804422.git.lorenzo@kernel.org>
 <87muhzs9qv.fsf@purkki.adurom.net>
In-Reply-To: <87muhzs9qv.fsf@purkki.adurom.net>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 30 Jun 2019 13:25:56 +0200
Message-ID: <CAJ0CqmU6TLhFa4ZJxWHBzvpx+5g5E4-WkSPECx47F9d3T=5YjQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] mt76: mt7615: unlock dfs bands
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>
> > Unlock dfs channels since now mt7615 driver supports radar detection
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> > index 5dc4cced5789..6d336d82cafe 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> > @@ -152,6 +152,12 @@ static const struct ieee80211_iface_combination if_comb[] = {
> >               .max_interfaces = 4,
> >               .num_different_channels = 1,
> >               .beacon_int_infra_match = true,
> > +             .radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
> > +                                    BIT(NL80211_CHAN_WIDTH_20) |
> > +                                    BIT(NL80211_CHAN_WIDTH_40) |
> > +                                    BIT(NL80211_CHAN_WIDTH_80) |
> > +                                    BIT(NL80211_CHAN_WIDTH_160) |
> > +                                    BIT(NL80211_CHAN_WIDTH_80P80),
>
> Isn't it questionable to enable these without any testing on real
> hardware? Getting DFS to work correctly is hard so I'm very suspicious
> about this.
>
> --
> Kalle Valo

Hi Kalle,

unfortunately at the moment I am not able to run any tests with a real
signal generator so I just ported the code from vendor sdk.
I am pretty confident it works since the radar pattern detection is
done in fw/hw so I guess it has been already tested in the vendor sdk
but we can postpone this patch and apply just the rest of the series
until we have some test results.

@Ryder: do you have the possibility to carry out some real tests?

Regards,
Lorenzo
