Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A361E79DE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 11:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE2Jxc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 05:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2Jxc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 05:53:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229B6C03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 02:53:32 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jebhh-005RJN-By; Fri, 29 May 2020 11:53:29 +0200
Message-ID: <19c8ea7e8b0f78036cda9ecf55484755582cf6bb.camel@sipsolutions.net>
Subject: Re: [PATCH V2] cfg80211: adapt to new channelization of the 6GHz
 band
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <j@w1.fi>
Date:   Fri, 29 May 2020 11:53:28 +0200
In-Reply-To: <edf07cdd-ad15-4012-3afd-d8b961a80b69@broadcom.com> (sfid-20200529_114146_502376_6F982EE1)
References: <1590744414-55473-1-git-send-email-arend.vanspriel@broadcom.com>
         <edf07cdd-ad15-4012-3afd-d8b961a80b69@broadcom.com>
         (sfid-20200529_114146_502376_6F982EE1)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-05-29 at 11:41 +0200, Arend Van Spriel wrote:
> It also fixes a missing MHZ_TO_KHZ() macro for 6GHz channels while at it.

Yeah, I actually saw and fixed that earlier, but whatever. I can fix up
any issues.

>   	case NL80211_BAND_6GHZ:
> -		/* see 802.11ax D4.1 27.3.22.2 */
> +		/* see 802.11ax D6.1 27.3.23.2 */
> +		if (chan == 2)
> +			return MHZ_TO_KHZ(5935);
>   		if (chan <= 253)
> -			return 5940 + chan * 5;
> +			return MHZ_TO_KHZ(5950 + chan * 5);

So this can return 5950+5*253 == 7215

> @@ -119,11 +121,14 @@ int ieee80211_freq_khz_to_channel(u32 freq)

>   	else if (freq <= 45000) /* DMG band lower limit */
> -		/* see 802.11ax D4.1 27.3.22.2 */
> -		return (freq - 5940) / 5;
> +		/* see 802.11ax D6.1 27.3.23.2 */
> +		return (freq - 5950) / 5;

and here you have no real upper bound, which is fine

> @@ -1662,6 +1667,40 @@ bool ieee80211_chandef_to_operating_class(struct 

> +	/* 6GHz, channels 1..233 */
> +	if (freq == 5935) {
> +		if (chandef->width != NL80211_CHAN_WIDTH_20)
> +			return false;
> +
> +		*op_class = 136;
> +		return true;
> +	} else if (freq > 5935 && freq <= 7115) {

but here both the comment and the code say 7115? Should that be 1..253
and 7215, respectively?

I can fix, no need to resend.

johannes

