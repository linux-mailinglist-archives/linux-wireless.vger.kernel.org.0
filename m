Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DA3695C9B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 09:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjBNIOc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 03:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjBNIN7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 03:13:59 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A998C234FE
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 00:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tdl8Afzo/5nj1GUDEcur43kVytqMgV+uo3iYN5r7wWQ=;
        t=1676362429; x=1677572029; b=l3QI3ptP8o9umlYSAZmGZ48AY0d2k+1jegN/jSMUx5H9gZa
        QWd8XLLrafvuYkoEDZnarSjD/JJl1XfxWFt/2qAhm/QtypgJyTyihVZkHQFPe2DAr/Al6oHHLiT7J
        0Ny+4PbFo5t5NgvCgDNQd+CgAcDp24GtmpEa9tHRwzQdCe3V+Fme5ACVhJ7/03mZZ9PsTHbQfZWfg
        o1OlOfcb2z77f9V3tLULooccSzf7mRvnyg4BtJ0N+2uCDj3f0MUeXtMYWZ800vxE6vvG0Yf2PGdsz
        jQiLJIWaga2YUC/HEVVRW1w1eM1HrKwX1tTY9cU+LCbbobFWu1NmJXsjzlnRRhWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRqRf-00C2MK-1X;
        Tue, 14 Feb 2023 09:13:47 +0100
Message-ID: <734b2b563c7cb52604aa1c2e5080bfe438f9015c.camel@sipsolutions.net>
Subject: Re: [PATCH 04/15] mac80211: make channel context code MLO-aware
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Date:   Tue, 14 Feb 2023 09:13:46 +0100
In-Reply-To: <0c15bfd6-819e-3e76-391b-f2ab70eb7eba@quicinc.com>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
         <20220601093922.fb3f0f434c72.Icea7e695b0626177e27ab73bc8799202d623cebf@changeid>
         <34121f87-4aa6-7f20-fb1e-4d5b02d06f28@quicinc.com>
         <0e889e3be774aced1813152b18d505c0616fc110.camel@sipsolutions.net>
         <0c15bfd6-819e-3e76-391b-f2ab70eb7eba@quicinc.com>
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

On Tue, 2023-02-14 at 16:09 +0800, Wen Gong wrote:
> On 2/14/2023 4:04 PM, Johannes Berg wrote:
> > On Tue, 2023-02-14 at 15:57 +0800, Wen Gong wrote:
> > > >    void rate_control_rate_update(struct ieee80211_local *local,
> > > > -				    struct ieee80211_supported_band *sband,
> > > > -				    struct sta_info *sta, u32 changed)
> > > > +			      struct ieee80211_supported_band *sband,
> > > > +			      struct sta_info *sta, unsigned int link_id,
> > > > +			      u32 changed)
> > > >    {
> > > >    	struct rate_control_ref *ref =3D local->rate_ctrl;
> > > >    	struct ieee80211_sta *ista =3D &sta->sta;
> > > >    	void *priv_sta =3D sta->rate_ctrl_priv;
> > > >    	struct ieee80211_chanctx_conf *chanctx_conf;
> > > >   =20
> > > > +	WARN_ON(link_id !=3D 0);
> > > > +
> > > >    	if (ref && ref->ops->rate_update) {
> > > >    		rcu_read_lock();
> > > >   =20
> > > Why link_id must =3D 0 here?
> > >=20
> > The whole software rate scaling hasn't been adjusted for MLO yet.
>=20
> Got it. Thanks.
>=20
> So I guess this WARN_ON will be change later.
>=20

Since you're running into it, you should probably think about addressing
this ... I'm not going to, our hardware doesn't use this code.

johannes
