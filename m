Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DDD6DD7AB
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 12:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjDKKPo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDKKPn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 06:15:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158392
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 03:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oW1jk8i0Jy2kglxnjc/4bhznUy5RshboGFIWf/WyeI8=;
        t=1681208142; x=1682417742; b=nBpjhj0b3bT0T7No1DKi1v2P1Hyo3jlU8/dkIOZKnRzIGNi
        4xk/JZMx8hqzQZpQN/tgTrKr2YhuiJ35GtTsS2EkHS0P/6N0FRgE+zcwj3vZmox7edXgmTvTvvXy3
        8DFgdfZAcr8BZq+05afVTI0OWb0dYdLyXgCZ5PHqUf5MAbCUTVwP/qWNHeMPAcCUw+eIFpu2RfZrv
        27/wN/OcqUFkKrc+eXyyWVgbMSowdHGfK6fRQXnEs5Nymwv0oPFK+Vb59fTk33JFd2qrnv7Y8H6gS
        rZdwD7XzsOarYhJcxxkdFkjtOgDgLNECLKBpl8B55LuDW8kPlXIuHrroakGrBmYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pmB2J-00CgEk-0T;
        Tue, 11 Apr 2023 12:15:39 +0200
Message-ID: <67d681751d9af226fc84c533649d620ea1bb7664.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Add support to randomize TA of auth and
 deauth frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 11 Apr 2023 12:15:38 +0200
In-Reply-To: <bd40816c-9759-a0af-9075-cc684f81fd70@quicinc.com>
References: <20230112012415.167556-3-quic_vjakkam@quicinc.com>
         <20230307102225.74883-1-johannes@sipsolutions.net>
         <bd40816c-9759-a0af-9075-cc684f81fd70@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-04-06 at 18:47 +0530, Veerendranath Jakkam wrote:
> On 3/7/2023 3:52 PM, Johannes Berg wrote:
> > ---
> > So this is the patch I ended up with after some cleanups, but
> > then at the end I noticed you didn't unset the temp address
> > when the remain-on-channel expires, and wasn't sure exactly
> > how that should be handled, and you probably have the better
> > test setup right now too ...

> Apologies for the delayed response. Thanks for the cleaning up the patch.
>=20
> Regarding the comment on clearing temp address, I think the temp address=
=20
> should get cleared with below changes added in=20
> ieee80211_roc_notify_destroy() when remain-on-channel expires. Please=20
> let me know if I am missing something.
>=20
>=20
> > diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
> > index d78c82d6b696..74d2b826916a 100644
> > --- a/net/mac80211/offchannel.c
> > +++ b/net/mac80211/offchannel.c
> > @@ -187,6 +187,12 @@ static void ieee80211_roc_notify_destroy(struct ie=
ee80211_roc_work *roc)
> >   					 roc->mgmt_tx_cookie,
> >   					 roc->chan, GFP_KERNEL);
> >  =20
> > +	if (!is_zero_ether_addr(roc->sdata->vif.cfg.temp_addr)) {
> > +		eth_zero_addr(roc->sdata->vif.cfg.temp_addr);
> > +		ieee80211_vif_cfg_change_notify(roc->sdata,
> > +						BSS_CHANGED_TEMP_ADDR);
> > +	}
> > +
> >   	list_del(&roc->list);
> >   	kfree(roc);
> >   }
>=20

Huh, yeah, looks like I just missed that? Sorry about that.

Seeing that though, I remembered another thing - don't we have to adjust
the merging logic in ieee80211_start_roc_work() and maybe also
ieee80211_coalesce_hw_started_roc()?

johannes
