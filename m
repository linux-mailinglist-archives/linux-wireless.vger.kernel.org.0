Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B6A0BA1
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfH1UhD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 16:37:03 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42394 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfH1UhC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 16:37:02 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i34ge-0000YN-DV; Wed, 28 Aug 2019 22:37:00 +0200
Message-ID: <adff8812a50ca03f22fd0b3573a19ca42481c009.camel@sipsolutions.net>
Subject: Re: [PATCH] mwifiex: Fix three heap overflow at parsing element in
 cfg80211_ap_settings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     huangwenabc@gmail.com, linux-wireless@vger.kernel.org
Cc:     amitkarwar@gmail.com, nishants@marvell.com, gbhat@marvell.com,
        huxinming820@gmail.com, solar@openwall.com, greg@kroah.com,
        kvalo@codeaurora.org, sashal@kernel.org, mrehak@redhat.com
Date:   Wed, 28 Aug 2019 22:36:58 +0200
In-Reply-To: <20190828020751.13625-1-huangwenabc@gmail.com> (sfid-20190828_040827_580483_8289AFC7)
References: <20190828020751.13625-1-huangwenabc@gmail.com>
         (sfid-20190828_040827_580483_8289AFC7)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

First of all, the subject doesn't make a lot of sense?


Secondly, for a fix the code is fine I guess, but:

>  	rate_ie = (void *)cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES,
>  					   params->beacon.tail,
>  					   params->beacon.tail_len);

consider removing struct ieee_types_header from your driver, and using
struct element from <linux/ieee80211.h> instead.

This also comes with cfg80211_find_elem() that returns a suitably typed
pointer, so you don't need any casts.

>  	if (vendor_ie) {
>  		wmm_ie = vendor_ie;
> +		if (*(wmm_ie + 1) > sizeof(struct mwifiex_types_wmm_info))
> +			return;

and using it here would be a whole lot easier to understand too :)

johannes

