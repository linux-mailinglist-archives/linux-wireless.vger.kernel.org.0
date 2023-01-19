Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D62673ABF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 14:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjASNwZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 08:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjASNwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 08:52:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2BB75F
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 05:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OYaztwbDjJ1zliWadywF2Ok5tW1vKI1JRqnRQkYB+Tg=;
        t=1674136342; x=1675345942; b=Zf/68+PZWdQ0ARE6agbHK/IZyhHwS6pdLyR3q7pl1h3uL5E
        FIPgmutiVcz66nCKYnTC+SdiJ1ZreUUC4XtQ/yLJlNyBrk1ReG/r3MWFpBYVyRLZH5+pfGO+P67UA
        0zBFoMSj2LZjPm3aUPFZtzfAl8J5XB2H8P7TErqQ8Tb1JKmZp5OUAaYj8plVG1Bby+zd0hqYTPN+M
        DM+oM5r83C3HAQUcNqaMROCZZ4GMxOkQuZ1WWku4eyENN6xnpQNNg3LUzGpw2ZDhTMQ3fv1ZFW+lC
        G9EdFVYFZd36GftpjD3vSS1uWCJ3GecWsYLUmDJrb01VyQl6xaL3SFF8Q1u1mXQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIVKx-006WwJ-2P;
        Thu, 19 Jan 2023 14:52:15 +0100
Message-ID: <0881ee1d0ae43ae18ab4b71ec8b5fd62263bbb69.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: call reg_notifier for self managed
 wiphy from driver hint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 19 Jan 2023 14:52:14 +0100
In-Reply-To: <20221214093937.14987-1-quic_wgong@quicinc.com>
References: <20221214093937.14987-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-12-14 at 04:39 -0500, Wen Gong wrote:
> Currently the regulatory driver does not call the regulatory callback
> reg_notifier for self managed wiphys. Sometimes driver needs cfg80211
> to calculate the info of ieee80211_channel such as flags and power,
> and driver needs to get the info of ieee80211_channel after hint of
> driver, but driver does not know when calculation of the info of
> ieee80211_channel become finished, so add notify to driver after
> reg_process_self_managed_hint() from cfg80211 is a good way, then
> driver could get the correct info in callback of reg_notifier.

Seems reasonable - but maybe unexpected to some drivers, perhaps it
should be opt-in?

Though I guess not many drivers actually use this infrastructure in the
first place?

> @@ -3095,6 +3107,13 @@ static void notify_self_managed_wiphys(struct regu=
latory_request *request)
>  		if (wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED &&
>  		    request->initiator =3D=3D NL80211_REGDOM_SET_BY_USER)
>  			reg_call_notifier(wiphy, request);
> +
> +		if (wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED &&
> +		    request->initiator =3D=3D NL80211_REGDOM_SET_BY_DRIVER &&
> +		    request->wiphy_idx =3D=3D get_wiphy_idx(wiphy)) {
> +			reg_call_notifier(wiphy, request);
> +			request->wiphy_idx =3D WIPHY_IDX_INVALID;
> +		}

Why set the request->wiphy_idx here? Should this even go through
reg_process_pending_hints() at all?

> +	driver_request =3D kzalloc(sizeof(struct regulatory_request), GFP_KERNE=
L);
> +	if (!driver_request)
> +		return;
> +
> +	memcpy(driver_request, &request, sizeof(*driver_request));

kmemdup()?

> +	queue_regulatory_request(driver_request);

But again not sure you should do this, rather than calling the notifier
directly?

I mean, you could just do reg_call_notifier() here, it's already async?

johannes

