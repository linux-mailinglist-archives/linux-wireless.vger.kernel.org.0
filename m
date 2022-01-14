Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF548F1AE
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 21:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbiANUuM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 15:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbiANUuM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 15:50:12 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74589C061574
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 12:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jnZxBWMMJWD7C24u3mzTa5R6XamoCCEzXJN78OLIieo=;
        t=1642193411; x=1643403011; b=iy2zzgo9CE4auahy8qKMEWzvwLiAK7lfAMBz/Jf9bjbMU37
        kSP98tMVFguzOgZQ86unki6dExOZ0IrHpsgy2aadXXXa1nTSwCb0zGrqTzgx1IKuiIBuzb9TCIVFy
        alDq9h8nyd6jP2XO/xzQYgNEvWNYwcUXcH5jrIfqIUx052fjJ/rHYjADjdD8HjOE7KbOOhRlZYOoB
        NCtMAwP0yt54LpvNsI8vPa4a6DPZ0+v//f9zyRKIo39BxT1FSFRL3O0R/P2NGJS2CByMqNU6xMQgw
        eOO9DPX8USFBo9AnQlsItf94CUEhG9nwNBUH6DY6keelbF/DKWnUCz0rqHc66P6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n8TWT-005hzJ-Rj;
        Fri, 14 Jan 2022 21:50:09 +0100
Message-ID: <fdda9c11506266bdaf7e922a92ef6a7981512324.camel@sipsolutions.net>
Subject: Re: [v13 2/3] mac80211: MBSSID and EMA beacon handling in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 14 Jan 2022 21:50:09 +0100
In-Reply-To: <661712f782228b735ab65364932bb18e@codeaurora.org>
References: <20211006040938.9531-1-alokad@codeaurora.org>
         <20211006040938.9531-3-alokad@codeaurora.org>
         <16a03353cee422340c8ac36240b1e088fd45802e.camel@sipsolutions.net>
         <d2c980b72af1488282f18e8b1814b56c@codeaurora.org>
         <ebb1ddc51e6e0eff436de50cbbddec77d61af495.camel@sipsolutions.net>
         <661712f782228b735ab65364932bb18e@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-01-14 at 12:34 -0800, Aloka Dixit wrote:
> 
> With that, what would be a better way:
> (1) Making it work with pseudo code, still using GFP_KERNEL or
> (2) Changing to GFP_ATOMIC but otherwise keep the code fairly similar to 
> v13 (preferably allocating an array instead of separate pointers as you 
> suggested)?
> 

It's a good question. I'm not really into the code right now, but I'd
say GFP_ATOMIC should be OK.

I'm not even sure the functions you're modifying are always guaranteed
to be called in a context where you can sleep? E.g. I believe the driver
can call ieee80211_beacon_get_tim() in atomic context itself, e.g. even
from timer/interrupt to get the next beacon?

johannes
