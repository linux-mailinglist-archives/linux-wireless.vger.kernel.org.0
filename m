Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F925428AD
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 09:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiFHH5H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 03:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiFHHyr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 03:54:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD481D8187
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=N4L0Sfefht/aHjQ/qMxUsWKHqtsiJIkzwS2QERrAhBQ=;
        t=1654673035; x=1655882635; b=jMOD/VzORP9todGKiglRD3+iniCoSWifdesFHNzqwnyAlgt
        NT/afHeUtw45Re8aorCdtnpsvA6EGO0E3LkNfDNfI7d/yc1tjNoRFvYKYjmUjneVH5lZl1x52Ajbs
        qTE/ePCO7z4I2b1+vNQIjudenAP3FDjP6KSRPHOArxejhEskipjuZaPsZEk15KqwS4PCXItolgFtn
        5GWLPc+SQk6OdcxuU4SNLSUetjlOwU9rNQbgMYZPhFqjcqSfIsGwSDPDaJg1hKStyZR6DtNUnQJXB
        pJuvBWnfz7KG7ltCqxqixl4HdbgUjWlfEs9ONnY+DRit60jSIkF5TAPnkpeWEAOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nyq2F-00GpJJ-U9;
        Wed, 08 Jun 2022 09:23:24 +0200
Message-ID: <43dc2cc68300070b3727f63ea796fc327664174d.camel@sipsolutions.net>
Subject: Re: [RFC v2] cfg80211: Indicate MLO connection info in connect and
 roam callbacks
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 08 Jun 2022 09:23:23 +0200
In-Reply-To: <25ed0281-0880-1e8f-154c-53ee056e8879@quicinc.com>
References: <1654536690-12588-1-git-send-email-quic_vjakkam@quicinc.com>
         <25ed0281-0880-1e8f-154c-53ee056e8879@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
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

On Tue, 2022-06-07 at 17:24 -0700, Jeff Johnson wrote:
> > +		struct nlattr *nested;
> > +
> > +		nested =3D nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
> > +		if (!nested)
> > +			goto nla_put_failure;
> > +
> > +		for_each_valid_link(cr, link) {
> > +			struct nlattr *nested_mlo_links;
> > +			const u8 *bssid =3D cr->links[link].bss ?
> > +					  cr->links[link].bss->bssid :
> > +					  cr->links[link].bssid;
> > +
> > +			nested_mlo_links =3D nla_nest_start(msg, i + 1);
>=20
> why i+1?
> if you don't want to use 0 for the first entry (why not?) then init i to =
1
>=20
> alternately since this is the only place i is used, use ++i or i++ as=20
> you see fit and remove the i++ later
>=20
> ultimately we should only need to calculate i+1 once
>=20
> these comments apply to nl80211_send_roamed() as well
>=20
> (BTW I do see this pattern in some of the existing code, but I also see=
=20
> 0 being used for the first record)
>=20

Yeah, we're not very consistent with this ...

The background is that this ends up being an attribute, so the structure
is

NL80211_ATTR_MLO_LINKS =3D {
  1 =3D {
    NL80211_ATTR_MLO_LINK_ID =3D <integer>,
    ...
  },
  ...
}

so the "1" there is an attribute. Netlink says that attribute number 0
is invalid, and that's enforced if you were to try nla_parse_nested() or
so on the data of the NL80211_ATTR_MLO_LINKS attribute.

Now, nla_for_each_nested() doesn't care, and that's almost certainly
what gets used in the parser side of this, since the attribute number
doesn't even matter.

(We could use the link ID as the attribute number, but 0 is a valid link
ID and technically documented to not be a valid attribute number, so
...)


So I can see where this is coming from, and I don't really think it
matters. The compiler will almost certainly emit the same code anyway,
or at least I'd hope so :)

We probably have this pattern a few times ...

If we ignore the documentation further, we could even always use 0 for
the number, nla_for_each_nested() still won't care... but then we _try_
to do the right thing, except sometimes probably get it wrong with 0 vs.
1 starting.


Anyway, I guess it makes sense to just write it as

	int i =3D 1;
...
		nla_nest_start(msg, i);

instead, and we need a [PATCH] resubmit of this anyway I guess.

johannes
