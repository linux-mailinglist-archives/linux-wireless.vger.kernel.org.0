Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883401E7816
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 10:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgE2ITZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2ITY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 04:19:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8025C03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 01:19:23 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeaEb-005OxZ-R5; Fri, 29 May 2020 10:19:22 +0200
Message-ID: <8dc9a15d50a28aea21cf452b5abe8487a542ae8e.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: adapt to new channelization of the 6GHz band
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <j@w1.fi>
Date:   Fri, 29 May 2020 10:19:19 +0200
In-Reply-To: <cbc3a214-db0d-18d4-b878-80277c210956@broadcom.com> (sfid-20200529_101700_188014_3D00284C)
References: <1590053692-237138-1-git-send-email-arend.vanspriel@broadcom.com>
         <cbc3a214-db0d-18d4-b878-80277c210956@broadcom.com>
         (sfid-20200529_101700_188014_3D00284C)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-05-29 at 10:16 +0200, Arend Van Spriel wrote:
> The 6GHz band does not have regulatory approval yet, but things are
> moving forward. However, that has led to a change in the channelization
> of the 6GHz band which has been accepted in the 11ax specification.
> 
>   	case NL80211_BAND_6GHZ:
> -		/* see 802.11ax D4.1 27.3.22.2 */
> +		/* see 802.11ax D6.1 27.3.23.2 */
> +		if (chan == 2)
> +			return MHZ_TO_KHZ(5935);

I think Jouni said this was operating class 136?

> +	/* 6GHz, channels 1..233 */
> +	if (freq >= 5935 && freq <= 7115) {
> +		switch (chandef->width) {
> +		case NL80211_CHAN_WIDTH_20:
> +			*op_class = 131;
> +			break;
> +		case NL80211_CHAN_WIDTH_40:
> +			*op_class = 132;
> +			break;
> +		case NL80211_CHAN_WIDTH_80:
> +			*op_class = 133;
> +			break;
> +		case NL80211_CHAN_WIDTH_160:
> +			*op_class = 134;
> +			break;
> +		case NL80211_CHAN_WIDTH_80P80:
> +			*op_class = 135;
> +			break;
> +		case NL80211_CHAN_WIDTH_5:
> +		case NL80211_CHAN_WIDTH_10:
> +		case NL80211_CHAN_WIDTH_20_NOHT:
> +		default:
> +			return false;
> +		}

If so, isn't that missing here?

johannes

