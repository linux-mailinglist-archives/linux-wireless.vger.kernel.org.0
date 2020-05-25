Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C940D1E0918
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 10:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbgEYIkr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgEYIkr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 04:40:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46991C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 01:40:47 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jd8f7-002aOs-Ig; Mon, 25 May 2020 10:40:45 +0200
Message-ID: <161e46b950828b275aafb09576bf70e977cf0526.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: fix p2p go mgmt send failure on DFS channel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Liangwei Dong <liangwei@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 25 May 2020 10:40:44 +0200
In-Reply-To: <1589446471-208-1-git-send-email-liangwei@codeaurora.org>
References: <1589446471-208-1-git-send-email-liangwei@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-05-14 at 16:54 +0800, Liangwei Dong wrote:
> Start Autonomous p2p GO on DFS channel and then trigger remote
> p2p peer to connect to p2p GO. P2P remote device will send
> P2P provision discovery request action frame to P2P GO on GO's
> home channel - DFS. But when P2P GO sends Provision discovery
> response action frame to P2P remote, Kernel rejects the mgmt
> frame sending since Kernel doesn't allow "offchan" tx mgmt when
> AP interface is active on DFS channel.
> 
> Fix by allow "offchan" tx mgmt if the requested channel is same
> or compatible with AP's home channel.

Maybe we should just fix that in userland?

>  	wdev_lock(wdev);
> -	if (params.offchan && !cfg80211_off_channel_oper_allowed(wdev)) {
> -		wdev_unlock(wdev);
> -		return -EBUSY;
> +	if (params.offchan &&
> +	    !cfg80211_off_channel_oper_allowed(wdev) &&
> +	    !cfg80211_chandef_identical(&wdev->chandef, &chandef)) {
> +		compat_chandef = cfg80211_chandef_compatible(&wdev->chandef,
> +							     &chandef);
> +		if (compat_chandef != &chandef) {
> +			wdev_unlock(wdev);
> +			return -EBUSY;
> +		}

We'll surely have a 20 MHz channel as "chandef", so there's not much
point in checking the compat_chandef for == &chandef, but rather if
compat_chandef is non-NULL we're fine?

Also, chandef_compatible() already checks for identical, so no need to
do that here before.

johannes

