Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C7695BF5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 09:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjBNIFM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 03:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjBNIEz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 03:04:55 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE58126DB
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 00:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dptKNOPuEM0QsfAefO24+2bYzrvpzkZ2hHNZnxzUd/8=;
        t=1676361887; x=1677571487; b=Mwid5Tvb4Vu9sbeTiKHcB4wazrPDtjIL7bI+jjvn5fNirlR
        t0/zGuVZEFo2gY17mEVdWWZfOeoaMLW6yi/47aJnVeV+U/enYuQ4PjhnQQNb8YAwCxa+zTPytxdXX
        ZhWU6rolpGck+kZxIKuAgjh/eA4qO9yK/SNP+z80cXFHFOEYKQ4Xi5ge36fPHd9WOX+dq7msN5lhR
        hwgdQlSnp4h/ZJ+3XKP61gl6UcoZs1Ng62xjh++o3t+BmoWJxOqhQ3ozstydy8RF8OmaOTB0T93A7
        h7CfXhGYLDDfq4bz3noujPl+c8dj6/EA6V+kVGdxzggINeiQmUeV7b06c4seJreQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRqIt-00C27A-0p;
        Tue, 14 Feb 2023 09:04:44 +0100
Message-ID: <0e889e3be774aced1813152b18d505c0616fc110.camel@sipsolutions.net>
Subject: Re: [PATCH 04/15] mac80211: make channel context code MLO-aware
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Date:   Tue, 14 Feb 2023 09:04:41 +0100
In-Reply-To: <34121f87-4aa6-7f20-fb1e-4d5b02d06f28@quicinc.com>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
         <20220601093922.fb3f0f434c72.Icea7e695b0626177e27ab73bc8799202d623cebf@changeid>
         <34121f87-4aa6-7f20-fb1e-4d5b02d06f28@quicinc.com>
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

On Tue, 2023-02-14 at 15:57 +0800, Wen Gong wrote:
>=20
> >   void rate_control_rate_update(struct ieee80211_local *local,
> > -				    struct ieee80211_supported_band *sband,
> > -				    struct sta_info *sta, u32 changed)
> > +			      struct ieee80211_supported_band *sband,
> > +			      struct sta_info *sta, unsigned int link_id,
> > +			      u32 changed)
> >   {
> >   	struct rate_control_ref *ref =3D local->rate_ctrl;
> >   	struct ieee80211_sta *ista =3D &sta->sta;
> >   	void *priv_sta =3D sta->rate_ctrl_priv;
> >   	struct ieee80211_chanctx_conf *chanctx_conf;
> >  =20
> > +	WARN_ON(link_id !=3D 0);
> > +
> >   	if (ref && ref->ops->rate_update) {
> >   		rcu_read_lock();
> >  =20
>=20
> Why link_id must =3D 0 here?
>=20

The whole software rate scaling hasn't been adjusted for MLO yet.

johannes
