Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092D65AE494
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiIFJnX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 05:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiIFJmv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 05:42:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA475FD4
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=j6qYNPb0qFADyDa8+JWEUg6eJTWZ9Vkbb+BZqLNJ6Sw=;
        t=1662457356; x=1663666956; b=DXiWK3lZbbXiNvqkZ8zbuPOQTwe2UfSy7WhBsAq3k1lVVZO
        lacVZJJedCCHbAGU4jH/j6vby8AKDREq/D15UFw+nnQ6AvI7TAzsOVNI6C7UYAWdk5ZJacdMd55hc
        AVeWI7574sGcfXDrXyH2kb9m3Ewqhh/jEy56zLBL9nQ72cFmexeLmX0I5uVbp0+F4cudkMJzPq0fF
        bcyhYLgPH2XMXMm+0/+1I1g0qOouhPFK7EogyBv+Hpm+/lJqLzNWPQJZGAza/DnyXcoGCJlyrGb4O
        nPKRiap9k3Lg1410dhMZ3/r4R+hH8V7z3GWYh2HKsJwMifz2NLmn6YIc78hO1X5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVV6H-009Mgt-0d;
        Tue, 06 Sep 2022 11:42:33 +0200
Message-ID: <df1eda8a2e788800f71e77af60d3ae899a6d3d5d.camel@sipsolutions.net>
Subject: Re: [PATCH v3 04/12] nl80211: support setting S1G short beacon
 period
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kieran Frewen <kieran.frewen@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com
Date:   Tue, 06 Sep 2022 11:42:32 +0200
In-Reply-To: <20220906044812.7609-5-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
         <20220906044812.7609-5-kieran.frewen@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-09-06 at 16:48 +1200, Kieran Frewen wrote:
>=20
> @@ -805,6 +805,7 @@ static const struct nla_policy nl80211_policy[NUM_NL8=
0211_ATTR] =3D {
>  	[NL80211_ATTR_MLD_ADDR] =3D NLA_POLICY_EXACT_LEN(ETH_ALEN),
>  	[NL80211_ATTR_MLO_SUPPORT] =3D { .type =3D NLA_FLAG },
>  	[NL80211_ATTR_MAX_NUM_AKM_SUITES] =3D { .type =3D NLA_REJECT },
> +	[NL80211_ATTR_SHORT_BEACON_PERIOD] =3D { .type =3D NLA_U16 },

You probably want _some_ kind of range validation here, like "don't set
it to zero" at least?

> +	if (info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD])
> +		params->short_beacon_period =3D
> +			nla_get_u32(info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD]);
>=20

And maybe it should be < the long beacon period?

Actually the mac80211 code makes it sound like what you really should
have is a "long beacon period" or something, so that every N beacons you
send a long one?

Or are these really completely independent? It feels like probably the
intention would be to have a (short) beacon period, and then every N
beacons you send a long one?

johannes
