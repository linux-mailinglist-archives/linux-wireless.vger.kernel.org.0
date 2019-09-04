Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABBD0A7C3F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 09:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfIDHEA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 03:04:00 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33860 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfIDHEA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 03:04:00 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i5PKd-0008GG-Mb; Wed, 04 Sep 2019 09:03:55 +0200
Message-ID: <582e0a7eef96bb7d97fee4bae340ded97fda86a2.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Store max_mtu in ieee80211_hw
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 04 Sep 2019 09:03:54 +0200
In-Reply-To: <1567577743-27684-1-git-send-email-wgong@codeaurora.org>
References: <1567577743-27684-1-git-send-email-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-09-04 at 14:15 +0800, Wen Gong wrote:
> Make it possibly for drivers to adjust the default mat_mtu
> by storing it in the hardware struct.
> 
> +++ b/net/mac80211/iface.c
> @@ -1877,7 +1877,10 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
>  
>  		/* MTU range: 256 - 2304 */
>  		ndev->min_mtu = 256;
> -		ndev->max_mtu = IEEE80211_MAX_DATA_LEN;
> +		if (local->hw.max_mtu)
> +			ndev->max_mtu = local->hw.max_mtu;
> +		else
> +			ndev->max_mtu = IEEE80211_MAX_DATA_LEN;

It seems (slightly) preferable to me to just initialize the value in
local->hw.max_mtu in alloc_hw(), so the driver can override it before
register_hw(), and then use it here unconditionally. Any particular
reason for it being this way?

johannes

