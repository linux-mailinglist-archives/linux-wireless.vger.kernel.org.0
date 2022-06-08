Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9883A5429A6
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiFHIlh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiFHIkR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:40:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E02004E0
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 01:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=26ojpPxNab7H0qDQpSzG+FFUiYlSf7UGWq76CWD6uSA=;
        t=1654675413; x=1655885013; b=IjZXJL0/nGhLQ5F+oACh/+fQS1/koED1Fs6GhE9Tt51XH75
        PnVrD4GWcj8gLoGjWe37s3YtzphdBFNU9RNHLb9PcAOLJacGw06/8kHBhdbESLdf6FXGNMeF6P7iR
        lW3K5k28QmNNHbPa6o8Nemy+xmqoeZdo6WaOzpONyjbzoC6B3+VXchylsAaGFvY8AEk4TO7q0zMah
        NWQzGSdhGVd0dl/ry3JcI2GM3D8T4Dzz1xC+WZQQ0SsWFsNJ4EwR7KpJpq6HKq3vJx+gPYywIBEq2
        /qTfqzUGNSUjRTPKv0oA2yM+GjBa+1QcdV6xQ4V1BbaciYBXkBfRi5YS6X9lt82w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nyqb3-00GqEb-Oj;
        Wed, 08 Jun 2022 09:59:21 +0200
Message-ID: <3fa8911111ff380615ca5b3ffcd61644fae5e8ea.camel@sipsolutions.net>
Subject: Re: [RFC v2] cfg80211: Indicate MLO connection info in connect and
 roam callbacks
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 08 Jun 2022 09:59:21 +0200
In-Reply-To: <e75ddf50-348b-eaf2-4033-6a32ef65a41c@quicinc.com>
References: <1654536690-12588-1-git-send-email-quic_vjakkam@quicinc.com>
         <a2cc93f959394a3430755d4664d9f2abeabb3ab7.camel@sipsolutions.net>
         <e75ddf50-348b-eaf2-4033-6a32ef65a41c@quicinc.com>
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

On Wed, 2022-06-08 at 13:15 +0530, Veerendranath Jakkam wrote:
> On 6/8/2022 1:01 PM, Johannes Berg wrote:
> > On Mon, 2022-06-06 at 23:01 +0530, Veerendranath Jakkam wrote:
> >=20
> > > +	if (cr->status =3D=3D WLAN_STATUS_SUCCESS) {
> > > +		for_each_valid_link(cr, link) {
> > > +			if (!cr->links[link].bss)
> > > +				break;
> > > +		}
> > > +
> > > +		WARN_ON_ONCE((!cr->valid_links && link !=3D 1) ||
> > > +			     (cr->valid_links &&
> > > +			      link !=3D ARRAY_SIZE(wdev->links)));
> > > +
> > I will say I'm not super happy with using the link variable after the
> > loop, that always feels a bit magic to me, especially if the loop is
> > hidden like that...
> >=20
> > But I guess I don't see a lot of alternatives here, other than open-
> > coding it, or keeping track of "how many BSSes do I have".
>=20
>=20
> Since we need to WARN even if single BSS is not present I think we can=
=20
> use "bss_not_found" flag?
>=20
> >=20
> > Actually, for the MLO case, is this even valid? link[14] could be set,
> > so you wouldn't break, ending up with link=3D=3D15? Or am I confused?
> In MLO case the link value will be always 15 after loop completes if=20
> bsses are available for all valid links since the check is only for the=
=20
> valid links
>=20
> so, In above case also when "link=3D=3D15" the condition fails and WARN w=
ill=20
> be skipped right.
>=20

Ah, indeed. I was thinking of the 'break', but you only get there for
valid links and the valid links should indeed have a .bss pointer.

OK, so I guess let's leave it as is, that way we check both cases
accurately.

johannes
