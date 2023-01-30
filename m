Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C99C6807AB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 09:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbjA3In0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 03:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbjA3InZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 03:43:25 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296C17CE6
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 00:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=41aLsVAUYCh1JfjjZhisDFRiu7nyXeHg2S0BWoUhRPI=;
        t=1675068203; x=1676277803; b=O+YaI+YM3763PiJxNzJ1PnqLjKMHvIMqJQe+XXo+r41RKfV
        5I4fBBXVPBRlU7wP0PZeJPoZzk5f+KPMK5HdPwDX7+SrDECRveNDM+i5dj4VUKlEWPohUROtjTq0h
        dGd8uKlZr1ZIgolAa7X6WFxuy3wOApTPYnbTEH2v+5vhIphTXetFexuEhPMxA3mz860qcwpTGu8FY
        IMYTOA15av3WYa63GRz7nggmQky63/R0J62bxk8qhPd/NIzKHrS986sr3PrTypfOvC+VOZo++N3Rl
        pS+qN197Ye0vJv5yQxY6ZNuH5bLCJIC6XvH+L6bB9Wi71BTE5H/13Me1aknS+QCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pMPl2-00G1GZ-1m;
        Mon, 30 Jan 2023 09:43:20 +0100
Message-ID: <80942093ceebd3978dea562de42f618c7d9d5450.camel@sipsolutions.net>
Subject: Re: [PATCH v3 3/6] wifi: nl80211: configure puncturing in
 NL80211_CMD_CHANNEL_SWITCH
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 30 Jan 2023 09:43:19 +0100
In-Reply-To: <20230130072239.26345-4-quic_alokad@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
         <20230130072239.26345-4-quic_alokad@quicinc.com>
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

On Sun, 2023-01-29 at 23:22 -0800, Aloka Dixit wrote:
>=20
> + * @punct_bitmap: Preamble puncturing bitmap. Each bit represents a 20 M=
Hz
> + *	channel with lowest bit corresponding to the lowest frequency. Bit se=
t
> + *	to 1 indicates that the channel is punctured. Higher 16 bits are
> + *	currently unused.

> @@ -1384,6 +1388,7 @@ struct cfg80211_csa_settings {
>  	bool radar_required;
>  	bool block_tx;
>  	u8 count;
> +	u32 punct_bitmap;

again internally I think we can stick to u16 for now

> +++ b/net/mac80211/cfg.c
> @@ -1297,9 +1297,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, =
struct net_device *dev,
>  	}
> =20
>  	if (params->eht_cap) {
> -		if (!ieee80211_valid_disable_subchannel_bitmap(
> -							&params->punct_bitmap,
> -							params->chandef.width))
> +		if (!ieee80211_valid_disable_subchannel_bitmap(&params->punct_bitmap,
> +							       params->chandef.width))
>  			return -EINVAL;

That got rebased into the wrong patch maybe?

johannes
