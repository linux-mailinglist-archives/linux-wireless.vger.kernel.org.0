Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE478FA90
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbjIAJTq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 05:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIAJTp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 05:19:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9D10D4;
        Fri,  1 Sep 2023 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=uQgxTxph2lJhFNPVlzcNyVzmzrhmG5BzV33mv8A+0Wc=;
        t=1693559982; x=1694769582; b=PGY0OvK3fZagdnKlvNF9UBpyvFrE43iBISyZEduD6FjzP5Y
        Omd4j78u1ANElRjM6zXopFKwcMmkIkM5z/NkK+7IWpHJilKNky+cL2p9lVTz4nVnuqLlRsDwqjyRl
        ma52JB4slzAa1pM3RhwlhVuB6hBDqiAQVQHF80lk/VrMPi0n0lL2jmSPuQuUlhQNld9OKep/+VUhG
        HuJ9FjNuAkkBibpUADNL/7m2EJJq8bf4TxMED+Toa3uyKaFoNwYRiRd0GueYvVjRaFnWxtkFiU8Ru
        EyYEG0rVe1YB2BJRcq7ex7Xd11lRvoJF7lV3ADgBXcOCvTXuMIxvwCpWZkEvGGyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qc0JU-006miJ-1u;
        Fri, 01 Sep 2023 11:19:36 +0200
Message-ID: <4e96e981f58ca5bccf71952f76efe5e08a88f11d.camel@sipsolutions.net>
Subject: Re: [PATCH net,v2] wifi: mac80211: fix WARNING in
 ieee80211_link_info_change_notify()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     shaozhengchao <shaozhengchao@huawei.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     weiyongjun1@huawei.com, yuehaibing@huawei.com
Date:   Fri, 01 Sep 2023 11:19:35 +0200
In-Reply-To: <abb4efba-90b4-da14-5683-3cd96819a5e0@huawei.com>
References: <20230901035301.3473463-1-shaozhengchao@huawei.com>
         <7127fe5a4f2cfcdc3a55269f0a427477e264fabc.camel@sipsolutions.net>
         <abb4efba-90b4-da14-5683-3cd96819a5e0@huawei.com>
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

Hi,


> 	Do you mean it shouldn't be allowed to set mcast rate when dev
> is stopped,
>=20

Probably?

>  as in the following code?
>=20
> --- a/net/wireless/rdev-ops.h
> +++ b/net/wireless/rdev-ops.h
> @@ -1229,7 +1229,7 @@ rdev_set_mcast_rate(struct=20
> cfg80211_registered_device *rdev,
>          int ret =3D -ENOTSUPP;
>=20
>          trace_rdev_set_mcast_rate(&rdev->wiphy, dev, mcast_rate);
> -       if (rdev->ops->set_mcast_rate)
> +       if (rdev->ops->set_mcast_rate && netif_running(dev))
>                  ret =3D rdev->ops->set_mcast_rate(&rdev->wiphy, dev,=20
>=20

Certainly not. Please don't do random patches without looking at the
subsystem as a whole. If you don't want to take the time to understand
how things work in wireless, then better don't send patches at all.

johannes
