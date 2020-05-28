Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F901E6D9B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 23:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436540AbgE1V2M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 17:28:12 -0400
Received: from mail.w1.fi ([212.71.239.96]:54214 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436505AbgE1V2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 17:28:11 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 17:28:10 EDT
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id 9E5C011A48;
        Thu, 28 May 2020 21:20:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p-QJMllBd8SD; Thu, 28 May 2020 21:20:40 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Fri, 29 May 2020 00:19:13 +0300
Date:   Fri, 29 May 2020 00:19:13 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Ilan Peer <ilan.peer@intel.com>
Subject: Re: [PATCH v2 20/24] cfg80211: Update 6 GHz starting frequency
Message-ID: <20200528211913.GA1135@w1.fi>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
 <20200528213443.a08c02e0f9bb.If474d2bc528aa07610fef429ff83e8312079e242@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528213443.a08c02e0f9bb.If474d2bc528aa07610fef429ff83e8312079e242@changeid>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 28, 2020 at 09:34:43PM +0200, Johannes Berg wrote:
> The starting frequency of the 6GHz band changed from
> 5940 MHz to 5950 MHz. Update the code accordingly.

> diff --git a/net/wireless/util.c b/net/wireless/util.c
> @@ -94,7 +94,7 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
>  	case NL80211_BAND_6GHZ:
>  		/* see 802.11ax D4.1 27.3.22.2 */
>  		if (chan <= 253)
> -			return 5940 + chan * 5;
> +			return 5950 + chan * 5;

It would be good to update that P802.11ax reference to point to a newer
version that actually matches the changed implementation, i.e., IEEE
P802.11ax/D6.1, 27.3.23.2.

> @@ -119,11 +119,11 @@ int ieee80211_freq_khz_to_channel(u32 freq)
>  		return (freq - 2407) / 5;
>  	else if (freq >= 4910 && freq <= 4980)
>  		return (freq - 4000) / 5;
> -	else if (freq < 5945)
> +	else if (freq < 5955)
>  		return (freq - 5000) / 5;

What about operating class 136 channel 2 with channel starting frequency
of 5925 MHz? This would map 5935 MHz incorrectly.

>  	else if (freq <= 45000) /* DMG band lower limit */
>  		/* see 802.11ax D4.1 27.3.22.2 */
> -		return (freq - 5940) / 5;
> +		return (freq - 5950) / 5;

Same here for the reference.

-- 
Jouni Malinen                                            PGP id EFC895FA
