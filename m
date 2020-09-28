Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3527ACB7
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 13:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1LbB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1LbB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 07:31:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA173C061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 04:31:00 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMrMx-00CS6v-7a; Mon, 28 Sep 2020 13:30:59 +0200
Message-ID: <f1117adbcd57f3481c215626cd2120b6aa5dcf02.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Trigger channel switch from driver
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shay Bar <shay.bar@celeno.com>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
Date:   Mon, 28 Sep 2020 13:30:58 +0200
In-Reply-To: <20200826131709.25530-1-shay.bar@celeno.com>
References: <20200826131709.25530-1-shay.bar@celeno.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Aviad, Shay,

> This patch add channel switch event from driver to hostap.
> same as can be triggered from US via hostapd_cli chan_switch.

(had to think about "US" here for a bit, "channel switch" totally sent
my brain on the regulatory road ... heh)

> using the already existing NL80211_CMD_CHANNEL_SWITCH.

I'm a little confused as to how this would work - did the driver just
*do* a channel switch? Or does it want to do a channel switch, and then
hostapd has to deal with it? Is it able to? What happens if it doesn't
do anything when this happens, e.g. an older version?

> Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
> Signed-off-by: Shay Bar <shay.bar@celeno.com>
> ---
>  include/net/cfg80211.h | 11 ++++++
>  net/wireless/nl80211.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index d9e6b9fbd95b..ae02d96eb8ec 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -7416,6 +7416,17 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
>                                        struct cfg80211_chan_def *chandef,
>                                        u8 count);
> 
> +/*
> + * cfg80211_ch_switch - trigger channel switch from driver
> + * same as is can be triggered from hostapd_cli chan_switch

Not sure "same as ... hostapd_cli chan_switch" makes a lot of sense here
in the kernel-doc, tbh.

Also, you say "trigger" here, but ...

> + * @dev: the device which switched channels

"switched" here, which didn't help my above question at all.

> + * @chandef: the new channel definition
> + * @csa_count: the number of TBTTs until the channel switch happens

though I guess this makes it a bit clearer, unless it can be zero? :)

> + */
> +bool cfg80211_ch_switch(struct net_device *dev,
> +                              struct cfg80211_chan_def *chandef,
> +                              u8 csa_count);

nit: indentation

> +       if (chandef->width == NL80211_CHAN_WIDTH_40) {
> +               enum nl80211_channel_type chan_type = NL80211_CHAN_HT40MINUS;
> +
> +               if (chandef->center_freq1 > chandef->chan->center_freq)
> +                       chan_type = NL80211_CHAN_HT40PLUS;
> +
> +               if (nla_put_u32(msg, NL80211_ATTR_WIPHY_CHANNEL_TYPE,
> +                               chan_type))
> +                       goto nla_put_failure;
> +       }

This a bit ties in with the "compatibility" question above - does older
hostapd even understand this? I'd suspect not, and then I'm not sure why
you'd include these attributes?

> The information transmitted is intended only for the person or entity
> to which it is addressed and may contain confidential and/or
> privileged material. Any retransmission, dissemination, copying or
> other use of, or taking of any action in reliance upon this
> information is prohibited. If you received this in error, please
> contact the sender and delete the material from any computer. Nothing
> contained herein shall be deemed as a representation, warranty or a
> commitment by Celeno. No warranties are expressed or implied,
> including, but not limited to, any implied warranties of non-
> infringement, merchantability and fitness for a particular purpose.

Hm. I guess I'm the "intended [...] person or entity" but I'm still a
bit wary about applying patches with that, I guess.

Thanks,
johannes

