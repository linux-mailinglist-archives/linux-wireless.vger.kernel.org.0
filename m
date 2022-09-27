Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5C5EBCFE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 10:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiI0IRP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiI0IQ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 04:16:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125CB88A3D
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lt58T8OIMugiOR5UFYQcfSir1o5soBodFGO73dakSh0=;
        t=1664266562; x=1665476162; b=bPcA/HHf9oPpdgnY+n0GkSC3XqtXhf766STHHw26qr5zkRE
        GmQG6VYzWbQX4bIrIoDEVxaFpewJ61PyPETtSVMrAr/M75ENjoiPIUWRqnLytlB0hkt0VZPBOg/vC
        6+/FB752Xi5wNryH5gdqZC3N3SMPUvfTbx3ArJ4e+TnrbpadCC/XRyt+pN4yBMoRqm+0nQXEDy6AK
        CFS+Us6DDRsEeqlV+gKxCGbasDDaV/CRVCIqaPn5j+MQTpYaFd/CczuqNJzxOP5Ai7Q/r+k4tSv0Y
        OgH+wgqROBHZE+QYzus85sicX24o/DOXkKzH30ZW4k2K6ZQx0tMe64Jk6lXeHn1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1od5l0-009VW6-0R;
        Tue, 27 Sep 2022 10:15:58 +0200
Message-ID: <3cd8fab9b36f5a263dfa0fa41d5dd827c3ea18e2.camel@sipsolutions.net>
Subject: Re: [PATCH 35/76] wifi: mac80211: mlme: use
 ieee80211_get_link_sband()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Date:   Tue, 27 Sep 2022 10:15:57 +0200
In-Reply-To: <509e18bd-3004-9db5-459c-1935ee4eba5f@quicinc.com>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
         <20220713114425.35973aa556f0.I1394dd82298f09c6cb452be538dba8ba13f11b01@changeid>
         <509e18bd-3004-9db5-459c-1935ee4eba5f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Wed, 2022-09-14 at 18:00 +0800, Wen Gong wrote:
> On 7/13/2022 5:44 PM, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > This requires a few more changes.
> >=20
> > While at it, also add a warning to ieee80211_get_sband()
> > to avoid it being used when there are multiple links.
> >=20
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > ---
> >   net/mac80211/ieee80211_i.h |  2 ++
> >   net/mac80211/mlme.c        | 12 ++++++------
> >   2 files changed, 8 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> > index 3e360bcaa03b..a0743c78d171 100644
> > --- a/net/mac80211/ieee80211_i.h
> > +++ b/net/mac80211/ieee80211_i.h
> > @@ -1539,6 +1539,8 @@ ieee80211_get_sband(struct ieee80211_sub_if_data =
*sdata)
> >   	struct ieee80211_chanctx_conf *chanctx_conf;
> >   	enum nl80211_band band;
> >  =20
> > +	WARN_ON(sdata->vif.valid_links);
> > +
> >   	rcu_read_lock();
> >   	chanctx_conf =3D rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
> >  =20
> Hi Johannes,
>=20
> Now I hit below warning here in ieee80211_get_sband() in my MLO test for=
=20
> station.
> Will you have more patch to fix the warning?
>=20

Yeah still working on all this, obviously ...

That should be fairly harmless for now, unless you're trying to use 1k
block-ack.

johannes
