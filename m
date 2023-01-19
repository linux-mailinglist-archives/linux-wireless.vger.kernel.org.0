Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E3D673700
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 12:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjASLfk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 06:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjASLfZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 06:35:25 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF49358A
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 03:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=235eAbZ6B5JVCOG1wbXIGVXTgqb3hdaMElKi+F0BcH4=;
        t=1674128123; x=1675337723; b=ekgO77q9XX17Gm6szPpAh51enQi72wOWPXmVQj19SCfvnc1
        1DtHCRvOWPCcnl88LSRPxyl+k+mcV5BukKDhjXbV7XA/HLMQm6ssyxDgFSEhuHn+qn0jRG81h6iOm
        pGkiLjYoIz+dfllDVJ9MTyGxtvRgycvisffmk5oihHRAB5WL1KbSPprKy24qjasiBuAsr1PPWxOq2
        xBzsFea6NReGRy/f7fM6taXX7jD1rBmeMPFIoAcp2vkNKgJD8jYRzm8WCfJn+JFYA8NtlkeTtOcLs
        4MPmHnBwdp9wXtusfJaPu/21D56E/f4unieYkOL/XhXFhu9WbJpviDoBrr6a1Now==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pITCS-006UX5-0K;
        Thu, 19 Jan 2023 12:35:20 +0100
Message-ID: <f364ace23f73e90f9cf62b5c8238e78599b6b7ab.camel@sipsolutions.net>
Subject: Re: [RFC v2 4/6] mac80211: add utility function for tx_rate -
 rate_info conversion
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Date:   Thu, 19 Jan 2023 12:35:18 +0100
In-Reply-To: <9AE44A41-6357-4F3A-BF75-8E3B0A381E9B@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
         <20220920104032.496697-5-jelonek.jonas@gmail.com>
         <64731257b957f50b0f66e4d2fcd8c24dea8d70ff.camel@sipsolutions.net>
         <9AE44A41-6357-4F3A-BF75-8E3B0A381E9B@gmail.com>
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

On Thu, 2023-01-19 at 12:31 +0100, Jonas Jelonek wrote:
> > On 12. Jan 2023, at 11:26, Johannes Berg <johannes@sipsolutions.net>
> > wrote:
> >=20
> > > +void ieee80211_rate_get_rate_info(const struct ieee80211_tx_rate
> > > *rate,
> > > +						struct wiphy
> > > *wiphy, u8 band,
> > > + 						struct rate_info
> > > *rate_info)
> > > +{
> > > + 	memset(rate_info, 0, sizeof(struct rate_info));
> > > +
> > > + 	if (rate->flags & IEEE80211_TX_RC_MCS) { /* 802.11n */
> > > + 		rate_info->flags |=3D RATE_INFO_FLAGS_MCS;
> > > + 		rate_info->mcs =3D rate->idx;
> > > + 	} else if (rate->flags & IEEE80211_TX_RC_VHT_MCS) { /*
> > > 802.11ac */
> > > + 		rate_info->flags |=3D RATE_INFO_FLAGS_VHT_MCS;
> > > + 		rate_info->mcs =3D
> > > ieee80211_rate_get_vht_mcs(rate);
> > > + 		rate_info->nss =3D
> > > ieee80211_rate_get_vht_nss(rate);
> > > + 	} else { /* 802.11a/b/g */
> >=20
> > what about HE/EHT?
>=20
> ieee80211_tx_rate uses an s8 for rate/MCS index, so only up to VHT
> rates fit in there.
> For rates above VHT, rate_info is needed, thus are are no HE/EHT rates
> occuring in
> ieee80211_tx_rate. Same applies to your comment on the hwsim
> conversion.

I guess I should've read the commit message more closely ;-)

But please add kernel-doc to the function; both in general it'd be good
to have, and in particular explaining that this is more for older
drivers I guess?

johannes
