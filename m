Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627017EC82F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 17:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjKOQLJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 11:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjKOQLH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 11:11:07 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F44CAD
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 08:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wU8SrcGPkVG992ZUXyISdAuOEnuagtsLx7Rwp+JN57E=;
        t=1700064662; x=1701274262; b=jwy9AE5tKwnYsolr5SSxwd8ZlZyWrjf2ESqGm7V+rDog2Y/
        5E72wReonDPVA4locQEyOYBm/t5rV1hXH07h/rFrIyOSgyvdfBsUy5j3LO0ZwjBPGrsTVXG1eSa13
        lJyEKBlSJomTuKzj5NtRU86gYFy/2hhYfCCaTL5ZMLXfLUFpB9r7rIIO/N5cEBaZv6I4hrgisAed4
        4QZaqEIZNiJziC6ZTj15tP4SHABNqS0NgOBtyjLKsnl7f86aWytrUqsMYbjIeXbqQTDtSECLTsBTa
        n63tZQahzwJlMHb2BBkLwooPvieCRte64kY64062wqU3fhHop/E59MirdjkUqDaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r3ITj-00000009HFv-3lld;
        Wed, 15 Nov 2023 17:11:00 +0100
Message-ID: <8693a54d50f05a7668b11518eea2de46dd13952d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: Add debugging around scan failure
 warning.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 15 Nov 2023 17:10:58 +0100
In-Reply-To: <7a76305b-dd42-b866-f64f-93b7c8811f97@candelatech.com>
References: <20231114212309.2180281-1-greearb@candelatech.com>
         <9574407e2be4c97b1ef2d9f73b5eecb08791ff56.camel@sipsolutions.net>
         <7a76305b-dd42-b866-f64f-93b7c8811f97@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-11-15 at 08:01 -0800, Ben Greear wrote:
> On 11/15/23 00:57, Johannes Berg wrote:
> > On Tue, 2023-11-14 at 13:23 -0800, greearb@candelatech.com wrote:
> > > From: Ben Greear <greearb@candelatech.com>
> > >=20
> > > Provide additional information that may help debugging why
> > > the WARN_ON is seen.
> > >=20
> > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > > ---
> > >   drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/=
net/wireless/intel/iwlwifi/mvm/scan.c
> > > index 75c5c58e14a5..ec24ece7c877 100644
> > > --- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> > > @@ -2356,7 +2356,10 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iw=
l_mvm *mvm,
> > >   			link_id =3D ffs(vif->active_links) - 1;
> > >  =20
> > >   		link_info =3D scan_vif->link[link_id];
> > > -		if (!WARN_ON(!link_info))
> > > +		if (WARN_ON(!link_info))
> > > +			IWL_ERR(mvm, "scan failure: Cannot find link info for link-id: %d=
 active-links: 0x%x\n",
> > > +				link_id, vif->active_links);
> > >=20
> >=20
> > It would make sense to put the data *into* the warning, rather than
> > separately? Though I'm not sure I see so much value in the long string
> > (vs. just the data).
>=20
> I assume IWL_ERR will provide some extra context in systems with multiple=
 radios,
> so more useful than what I could easily put into WARN_* directly.

That's true, though not sure that helps so much more? You could put it
easily into the warning though :)

Anyway, the point is that bug reports from the field often don't include
the full log etc. so putting things _into_ the warning really is usually
more useful than putting it after.

> >=20
> > But honestly I'm not sure this really even is a problem at all? Some
> > confusion can happen during firmware restart here, and not sure we can
> > really fix that. Though maybe with the new locking we can.
>=20
> I see the splat, not sure why.  It would be nice to know if link-id is
> corrupted somehow, or if active links is zero, etc.

Yeah in this case we'd really need more of the dynamic information to
really debug it, I guess.

johannes
