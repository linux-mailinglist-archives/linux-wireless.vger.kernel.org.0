Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F127C782506
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjHUIBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjHUIBr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 04:01:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0003AB6
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=80azTiCRpTvKKCX7fWK8znRBwbAvsl/aHZiVJTGKhcY=;
        t=1692604905; x=1693814505; b=S5YFhaz4JN2NAiLnGImG9nUv44y74iCz2OY9MImUrrYD0K5
        h0PLFx9Urg4I/rO/cn57vD+IJa6Eicm7wy5ABd0g8HwLQc5mfOb6JHmDGSl3MRtqSQdkVaN843bv9
        Ep6h5jsNBqkArWl6DBGcrRLBEXZ8f1lWy0lHKmW82JN/avoUQHACqlQFWfGd8aHN+mntV7185YhLg
        XJB0G1Q4tPUaVPF2Xcl6UkVEmGN4NSLdfXoItScIUmunXAE6y2DPJlHuetDpN3gBS7iwbH0PZwRMT
        AwFYRoandO+oaj/sKgmCg14Lix8s4A6UhENqPbEEEsNJJGxDGSZIGD0SKH0I8Riw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qXzr1-002s1d-2F;
        Mon, 21 Aug 2023 10:01:39 +0200
Message-ID: <cf1327bc62debc1772170b5f84ae09125bafa553.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix cfg80211_bss always hold when assoc
 response fail for MLO connection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 21 Aug 2023 10:01:38 +0200
In-Reply-To: <0a264e30-af70-a6ff-eb2b-c3862540ee1b@quicinc.com>
References: <20230821061355.18168-1-quic_wgong@quicinc.com>
         <5c072b0a45ad29dc03b989fbd9a9fd974ae0c23d.camel@sipsolutions.net>
         <0a264e30-af70-a6ff-eb2b-c3862540ee1b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-08-21 at 15:48 +0800, Wen Gong wrote:
> On 8/21/2023 3:40 PM, Johannes Berg wrote:
> > On Mon, 2023-08-21 at 02:13 -0400, Wen Gong wrote:
> > > +++ b/net/mac80211/mlme.c
> > > @@ -5429,17 +5429,22 @@ static void ieee80211_rx_mgmt_assoc_resp(stru=
ct ieee80211_sub_if_data *sdata,
> > >   	for (link_id =3D 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id=
++) {
> > >   		struct ieee80211_link_data *link;
> > >  =20
> > > -		link =3D sdata_dereference(sdata->link[link_id], sdata);
> > > -		if (!link)
> > > -			continue;
> > > -
> > >   		if (!assoc_data->link[link_id].bss)
> > >   			continue;
> > >  =20
> > >   		resp.links[link_id].bss =3D assoc_data->link[link_id].bss;
> > > -		resp.links[link_id].addr =3D link->conf->addr;
> > >   		resp.links[link_id].status =3D assoc_data->link[link_id].status;
> > >  =20
> > > +		link =3D sdata_dereference(sdata->link[link_id], sdata);
> > > +
> > > +		if (!link) {
> > > +			/* use the addr of assoc_data link which is set in ieee80211_mgd_=
assoc() */
> > > +			resp.links[link_id].addr =3D assoc_data->link[link_id].addr;
> > As I mentioned before, this cannot be done - it introduces use-after-
> > free since assoc_data is freed after the loop, and the
> > cfg80211_rx_assoc_resp() is after that.
>=20
> So I want to change the "const u8 *addr" to "u8 addr[ETH_ALEN]=20
> __aligned(2);" of struct
>=20
> cfg80211_rx_assoc_resp and copy the value, then no use-after-free, is it =
OK?

Yeah I guess that works too.

>=20
> > > +			continue;
> > > +		}
> > > +
> > > +		resp.links[link_id].addr =3D link->conf->addr;
> > >=20
> > Also, I don't see that we need to use two different assignments for the
> > two cases.
> Then I will change to both use "assoc_data->link[link_id].addr", is it OK=
?

Sure

johannes
