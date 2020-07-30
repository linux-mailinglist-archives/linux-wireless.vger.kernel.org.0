Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC68233494
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgG3OiD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3OiC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:38:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C26C061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 07:38:02 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k19h2-00DaDx-9q; Thu, 30 Jul 2020 16:38:00 +0200
Message-ID: <3a608bb13f7115e8b019eea770691239a769dc24.camel@sipsolutions.net>
Subject: Re: [PATCH V2 01/10] nl80211: add basic multiple bssid support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 30 Jul 2020 16:37:59 +0200
In-Reply-To: <20200706115219.663650-1-john@phrozen.org>
References: <20200706115219.663650-1-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-07-06 at 13:52 +0200, John Crispin wrote:
> 
> @@ -3761,6 +3765,16 @@ static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
>  	if (err < 0)
>  		return err;
>  
> +	if (info->attrs[NL80211_ATTR_MULTI_BSSID_MODE])
> +		params.multi_bssid_mode =
> +			nla_get_u8(info->attrs[NL80211_ATTR_MULTI_BSSID_MODE]);
[...]

Oh .. missed this completely until I got to the iw patch :)

Why are you adding this in *new interface? IMHO it would be more
applicable to "start_ap"? I don't see a reason why an interface couldn't
change the role here regarding multi-BSSID while it's down?

That might also address some of the whole "cfg80211" vs. "mac80211"
thing I raised previously, since now cfg80211 would have a lot more
knowledge about things if the interface is already operating, i.e. it
could track and validate more of this?

johannes

