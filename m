Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61D179FD1B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 09:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjINHSV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 03:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjINHSU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 03:18:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C189E66
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 00:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7Ouu/OFTHZYOeIna0cKrHiyeWcjYkLwXQViorNeFews=;
        t=1694675896; x=1695885496; b=rf9ThMBifoV7exgSxzHtipTbM2h6iF16t4IGh0VA91Dz8N+
        QzPHNEvm6gtNCSXWtD/Ha6TT72Ixva9kIl1VwrwObJ8egGU3gb/FonOiWylAbW2JTmurkzSuUHZ8M
        ZDwoiCgZ8TfSiWC9+DWABVz6UZXAobv2AjVB0PiZfNUZj6MB+ZCqrwM80Oiu1f6LksS4VNqInJuu8
        QmxNFUBgRFwdCPWZCtAsUFM6qpvNPh0lQ0b8ggV+c6JtzkLl1UCN4uHwZiEE3LhPZz1PuCzWnopYL
        3klpbJkNR3ccs7mvn1/JtcXi2hMODo9VmDZD7Vu/uOA4VSbKf10FCobLA6LHo0Jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qggc9-00Gin3-2M;
        Thu, 14 Sep 2023 09:18:13 +0200
Message-ID: <d7d6cbf5ea15bca1aa2a127029e249e154eb863a.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/9] wifi: cfg80211: save Power Spectral Density
 (PSD) of the regulatory rule
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Thu, 14 Sep 2023 09:18:12 +0200
In-Reply-To: <e79cae30-0d38-1d01-2ab2-943ad191149a@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
         <20230315132904.31779-3-quic_adisi@quicinc.com>
         <4cb3e92530d3f4db3b414e2a7536a0f01b765c4d.camel@sipsolutions.net>
         <e79cae30-0d38-1d01-2ab2-943ad191149a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-09-14 at 11:45 +0800, Wen Gong wrote:
> On 9/13/2023 10:58 PM, Johannes Berg wrote:
> > On Wed, 2023-03-15 at 18:58 +0530, Aditya Kumar Singh wrote:
> >=20
> > > @@ -8650,6 +8660,14 @@ static int parse_reg_rule(struct nlattr *tb[],
> > >  =20
> > >   	reg_rule->flags =3D nla_get_u32(tb[NL80211_ATTR_REG_RULE_FLAGS]);
> > >  =20
> > > +	if (reg_rule->flags & NL80211_RRF_PSD) {
> > > +		if (!tb[NL80211_ATTR_POWER_RULE_PSD])
> > > +			return -EINVAL;
> > > +
> > > +		reg_rule->psd =3D
> > > +			nla_get_s8(tb[NL80211_ATTR_POWER_RULE_PSD]);
> > > +	}
> > Wait ... I'm not sure why we've been adding stuff to this recently, but
> > anyway, this part should only be used by CRDA which is deprecated
> > anyway?
> >=20
> > So I'd say we shouldn't touch any of the code under #ifdef
> > CONFIG_CFG80211_CRDA_SUPPORT any more since CRDA will not continue to
> > developed with any updates here.
> >=20
> > johannes
> Oh, I will remove the change in parse_reg_rule() in next version, because
> you asked me to add change in 2=20
> functions(nl80211_put_regdom()/nl80211_msg_put_channel())
> below, but I added change in one more function(parse_reg_rule()).
>=20

Yes, we should have visibility on the output - but I don't think we ever
expect the input to carry it this way via nl80211 since that's long
deprecated in favour of the kernel loading it as a 'firmware' file.

johannes
