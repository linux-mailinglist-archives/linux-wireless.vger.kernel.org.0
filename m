Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCF245ED47
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 13:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353056AbhKZMD1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 07:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377225AbhKZMBZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 07:01:25 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE07C08EACA
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 03:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UAIJPVntmFykLw04yJI2R12o6PQQ/E7lvfyrfj0iMr0=;
        t=1637925798; x=1639135398; b=GLE+8b+sxs+4P1yLZayx98RB8eog1jT+q5H/dkz5DwecZvx
        RGwoSVCnuJcMRh+GH6kU2xlujQuLQG2R4fdYa/alPvkd3M5bK2kZjLKPosCjVXhfYTPIjUYXv9NcY
        KaokzRvI2ccamSueWh6o2mNq3knEiTWb5QAA8eab6thOKARKM41cu1qnweolakBz6NagDmuZnOzmX
        jTpWM7FWieU3PRnbwo+sSa8GLXZfu/HND15FerkSo1uUWIbyqEwR6nkcUmGc+GDK+Xw+CCqM6uw7J
        kIJ93Zt4t/meE0vNNj8hNdZYn4TBKpyQk6IZSl2jHn5X509BhPlpIjUOwC8h7lgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mqZK0-0039np-8F;
        Fri, 26 Nov 2021 12:23:16 +0100
Message-ID: <16a03353cee422340c8ac36240b1e088fd45802e.camel@sipsolutions.net>
Subject: Re: [v13 2/3] mac80211: MBSSID and EMA beacon handling in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>, linux-wireless@vger.kernel.org
Date:   Fri, 26 Nov 2021 12:23:15 +0100
In-Reply-To: <20211006040938.9531-3-alokad@codeaurora.org>
References: <20211006040938.9531-1-alokad@codeaurora.org>
         <20211006040938.9531-3-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-10-05 at 21:09 -0700, Aloka Dixit wrote:

>  
> +static struct sk_buff *
> +ieee80211_beacon_get_ap_mbssid(struct ieee80211_hw *hw,
> +			       struct ieee80211_vif *vif,
> +			       struct ieee80211_mutable_offsets *offs,
> +			       bool is_template,
> +			       struct beacon_data *beacon,
> +			       struct ieee80211_chanctx_conf *chanctx_conf,
> +			       int ema_index,
> +			       struct list_head *ema_list)

This function is called from ieee80211_beacon_get_ap(). That's called
from __ieee80211_beacon_get(), under RCU read lock.

> +	for (i = 0; i < beacon->mbssid_ies->cnt; i++) {
> +		struct ieee80211_ema_bcns *bcn;
> +
> +		bcn = kzalloc(sizeof(*bcn), GFP_KERNEL);

Therefore, you really cannot GFP_KERNEL allocate anything. But I really
only saw this because I went back to my comments on v12 where this was
still more obvious.


Given that we're already in v13 of this patch, let's take a step back.
Much of what I've pointed out in the reviews really is automatically
testable.

Can you please add support for this to hwsim and hostapd and add a few
tests to the hostap hwsim tests? Given the complexity of this, being
able to run the tests for it myself would give me a lot more confidence
in it.

johannes
