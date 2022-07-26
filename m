Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD14581597
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jul 2022 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbiGZOmr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jul 2022 10:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiGZOmq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jul 2022 10:42:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168F27CC4
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5eImNlI6wDq/9vABSGgcw2zQ/FpvKUSzo/yYKvYnX4o=;
        t=1658846565; x=1660056165; b=XoV3zVZolRV559qchO8Cm2htH7/E4SHp9jgxLhL7vQIADIY
        aaiKdyrM6P9wmocfOOAB8Qp62ST1H/IZ0QETe1/jyvtRyVVXVBGm2tGyPEg43oShJ8w6HD+yoxjhd
        uIkkYttULYwpTHGNE+gBoyrJDFbhFna723aSUcaoZiTXFgzF644f5H3Sd3QLPaIwU1oO2CiPRhcoh
        7aAaUngfjfOdAVuk8mbQGrUQYam42dwoTh4DgxDzGK5EElU78seNrN/jIirMah16rA4bH/hnN8/R0
        p+digaeZGMiNBjKDANYnRkwUgOUwEAKqApZR9UwLYWdDxLaDJtZwrRYhWNv5vvQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oGLli-008jP2-1R;
        Tue, 26 Jul 2022 16:42:42 +0200
Message-ID: <5cdc7a91910a803ef531ae04ba330541476c0f18.camel@sipsolutions.net>
Subject: Re: [bug report] wifi: nl80211/mac80211: clarify link ID in control
 port TX
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 26 Jul 2022 16:42:41 +0200
In-Reply-To: <Yt/16E0ufa0D0Ziq@kili>
References: <Yt/16E0ufa0D0Ziq@kili>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
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

Hi Dan,


On Tue, 2022-07-26 at 17:10 +0300, Dan Carpenter wrote:
>     5885         rcu_read_lock();
>     5886         err =3D ieee80211_lookup_ra_sta(sdata, skb, &sta);
>=20
> For sdata->vif.type =3D=3D NL80211_IFTYPE_MESH_POINT then "sta" can be NU=
LL.
> Smatch doesn't know the value of sdata->vif.type at this point, and even
> if it did, then it doesn't split the return states up with enough
> granularity for that to make a difference.

Right, but that wouldn't matter anyway?

>     5887         if (err) {
>     5888                 rcu_read_unlock();
>     5889                 return err;
>     5890         }
>     5891=20
>     5892         if (!IS_ERR(sta)) {

Since this is all independent of the interface type.

>     5893                 u16 queue =3D __ieee80211_select_queue(sdata, st=
a, skb);
>     5894=20
>     5895                 skb_set_queue_mapping(skb, queue);
>     5896                 skb_get_hash(skb);
>     5897=20
>     5898                 /*
>     5899                  * for MLO STA, the SA should be the AP MLD addr=
ess, but
>     5900                  * the link ID has been selected already
>     5901                  */
> --> 5902                 if (sta->sta.mlo)
>=20
> Which Smatch complains about here.

Makes sense, should be "if (sta && sta->sta.mlo)" then I suppose. I'm on
vacation now, so if you want to send a patch as a reminder that'd be
nice.

I might clean this up later - it's not the first time the strange return
behaviour semantics of ieee80211_lookup_ra_sta() have gotten confusing
...

Thanks!

johannes

