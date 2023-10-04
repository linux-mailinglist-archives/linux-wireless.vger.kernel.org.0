Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9BB7B8D7F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243847AbjJDTgh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 15:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjJDTgY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 15:36:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D3FA9
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LnhOXVDLLomVsMwt+u5YAe+yWz54aDiRcmXmw7Loxbc=;
        t=1696448180; x=1697657780; b=F+MLhq6aw1ETOL8X7XOmsei8ISrp5m3aiRnuFvUelZL7fj7
        c74CYdlIMtcqsfT9VLc1CTn4f6Tk7GmT3vknNDnMbg79VbyUg6GrYEjFRcWVHVfIeozAODla+oVDv
        8pWZjcGtlLf3cY+zhz6m9kjoUd8ISfKOrjpqOYsVDWSZBY7clBOEZi48tkPe+H8/3jXtPSQWG01un
        bWfE9VHQG2HPqCYBfjDdtCTudUFtqtZ2iO48lEILmQUByz26e8TcodurrKEqOr45HvYwF1ad51mxV
        0mKaf4zG4nzVrBOgovHtZ+iZ8kSWv/k/E78XVJr4EZ/LDEIqWn1ZACAXoppHvltg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC0)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qo7fO-00000004UZk-0oHA;
        Wed, 04 Oct 2023 21:36:18 +0200
Message-ID: <5b1aeb36dbc7316e5de0b0cfdf429b754c5cfd82.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211:  ethtool:  check link sta if deflink sta not
 found.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Wed, 04 Oct 2023 21:36:17 +0200
In-Reply-To: <20231003215839.981227-1-greearb@candelatech.com>
References: <20231003215839.981227-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-10-03 at 14:58 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> While testing with wifi-7 radio put into AX mode, link-0 is created.
> sdata->deflink.u.mgd.bssid was 00 in this case, so sta was not
> found.
>=20
> Use link-0 for sta if it is available to do a better job of reporting
> ethtool stats.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  net/mac80211/ethtool.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
> index 6bd7fba8a867..1b58304fc68a 100644
> --- a/net/mac80211/ethtool.c
> +++ b/net/mac80211/ethtool.c
> @@ -96,6 +96,7 @@ static void ieee80211_get_stats2(struct net_device *dev=
,
>  	struct ieee80211_local *local =3D sdata->local;
>  	struct station_info sinfo;
>  	struct survey_info survey;
> +	struct ieee80211_link_data *link;
>  	int i, q;
>  	int z;
>  #define STA_STATS_SURVEY_LEN 7
> @@ -128,6 +129,12 @@ static void ieee80211_get_stats2(struct net_device *=
dev,
>  	if (sdata->vif.type =3D=3D NL80211_IFTYPE_STATION) {
>  		sta =3D sta_info_get_bss(sdata, sdata->deflink.u.mgd.bssid);

Just don't even try this, link[0] is always valid.

> +		if (!sta) {
> +			link =3D sdata_dereference(sdata->link[0], sdata);

but link[0] is a bad idea anyway ... what if the AP only assigned link 1
and 2? Or you connected only there?

I'm not even sure this is really worth fixing, do you really want a
random link's statistics?

johannes
