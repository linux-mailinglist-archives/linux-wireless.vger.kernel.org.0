Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C5E45EE4B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 13:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhKZMz1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 07:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbhKZMx1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 07:53:27 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764DC08EB3B
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 04:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=n4Fm1DoCuwM+FHb+/LNaJokXU/GZLmeqzCZCy56FLcs=;
        t=1637928532; x=1639138132; b=HmUQR+mU1nn8P+ZPjTeOZkd8jcsclTjqPXKXLj0el2cTzwV
        27ykxSC0EhC0lHfW3OXNFR8PnoG9bGYyQqrkjm/cCBEhNPyh77TXDHKTn2BuPnzsGQkyQNugKvy7V
        w0n++KBqtFdqAYpfX6GncQfre0vuDrsQa2XFURFgt53VoK5heWfRlIREl9Ow0tkVnVBKJmsfIvvur
        XQax1UuSOrD72qyBdcK72Jy20g+CdVb5CvseAxsCrYwSR3EUiU0odDc0Fq1yjz8S1T+YsOtElnRXx
        iWNHJuPUsed35gazv7j9dc8L4v2knpElTT7rZzkpN7kePSI9iDmaz3PM5tghwphw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mqa26-003Aat-Ef;
        Fri, 26 Nov 2021 13:08:50 +0100
Message-ID: <e870c4f0c0c04b3e4c95252b2d4722bf5dcba064.camel@sipsolutions.net>
Subject: Re: [PATCH v4] nl80211: reset regdom when reloading regdb
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Finn Behrens <me@kloenk.dev>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Nov 2021 13:08:49 +0100
In-Reply-To: <20210526112418.cdwkn7ed4twctimc@imap.mailbox.org>
References: <20210526112418.cdwkn7ed4twctimc@imap.mailbox.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> Sorry for taking so long for a new version. The mail provider my company
> is using had some major problems connecting to the LKML.
> This is why I now are using my personal mail server.


Did you resend this? Did I lose it before? Or maybe the list lost it and
I had a copy? Confusing ...

But anyway:

> @@ -1113,6 +1116,26 @@ int reg_reload_regdb(void)
>  	regdb = db;
>  	rtnl_unlock();
>  
> +	/* reset regulatory domain */
> +	current_regdomain = get_cfg80211_regdom();


This really is just

	rcu_dereference_rtnl(cfg80211_regdomain);

so it cannot be right that you just unlocked the RTNL and are not under
RCU protection here?

I guess we can just keep the RTNL, since ...


> +	request = kzalloc(sizeof(*request), GFP_KERNEL);
> +	if (!request) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	request->wiphy_idx = WIPHY_IDX_INVALID;
> +	request->alpha2[0] = current_regdomain->alpha2[0];
> +	request->alpha2[1] = current_regdomain->alpha2[1];
> +	request->initiator = NL80211_USER_REG_HINT_USER;
> +	request->user_reg_hint_type = NL80211_USER_REG_HINT_USER;
> +	request->reload = true;
> +
> +	rtnl_lock();

we acquire it again here anyway? Just need a new

> +	reg_process_hint(request);

out_unlock:
> +	rtnl_unlock();

label there.

> 
> @@ -2683,7 +2706,8 @@ reg_process_hint_user(struct regulatory_request *user_request)
>  
>  	treatment = __reg_process_hint_user(user_request);
>  	if (treatment == REG_REQ_IGNORE ||
> -	    treatment == REG_REQ_ALREADY_SET)
> +	    (treatment == REG_REQ_ALREADY_SET &&
> +				!user_request->reload))
>  		return REG_REQ_IGNORE;

That could use some nicer indentation :)

johannes
