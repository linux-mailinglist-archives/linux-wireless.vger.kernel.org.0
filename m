Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FCB7243CB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 15:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbjFFNJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbjFFNJJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 09:09:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07E5172B
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lmyxv7+7isYt9PSouUuRbsXJENIDYltXBd0Mp7mOzoo=;
        t=1686056927; x=1687266527; b=O6Q7pMq1QNjN1muDiYv1u06oqMXr7EJmidYBfYInOKZ3lcu
        Drv+vWwftB8C9O4lhBprSf/DIgtkARn761xv4Y8ruzfc/9YpmXcJ+X7UuRU3sbgJ+X9AajvhUS0Ot
        n6K2nj976jTgTEX/96isVP7NWNuIedF+7np79PDq8r4KMufQaz3CS4ebQzvwUmfwr0zDXK+cHwOX+
        kXwH9iQeRaCOwWrWKuszwMODnXcC/8e95W4Np+HfGY+lA6X59qjXvCgqjaWmZvnA+PRJlAELk7Kit
        CCi68lLaj79lpygvQpr5DywfPD6XaM+TYekB2Zcq5qwsuLHFVtLNoHhf0z9VySPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6WQV-00FZn8-18
        for linux-wireless@vger.kernel.org;
        Tue, 06 Jun 2023 15:08:43 +0200
Message-ID: <efbe3759f234e626877f33638647855cb89cc30a.camel@sipsolutions.net>
Subject: Re: [PATCH 13/14] wifi: cfg80211: move sched scan stop to wiphy work
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Date:   Tue, 06 Jun 2023 15:08:42 +0200
In-Reply-To: <20230606144753.a7da451559cf.I25ad10960aeffdfab348f9e6590048bed6d64933@changeid>
References: <20230606124933.181107-1-johannes@sipsolutions.net>
         <20230606144753.a7da451559cf.I25ad10960aeffdfab348f9e6590048bed6d64933@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-06-06 at 14:49 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> This work can now trivially be converted, it behaves
> identical either way.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/wireless/core.c    | 6 +++---
>  net/wireless/core.h    | 2 +-
>  net/wireless/nl80211.c | 3 ++-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/wireless/core.c b/net/wireless/core.c
> index 3b37bbc4e8d2..56b7d4404eed 100644
> --- a/net/wireless/core.c
> +++ b/net/wireless/core.c
> @@ -365,7 +365,8 @@ static void cfg80211_destroy_iface_wk(struct work_str=
uct *work)
>  	rtnl_unlock();
>  }
> =20
> -static void cfg80211_sched_scan_stop_wk(struct work_struct *work)
> +static void cfg80211_sched_scan_stop_wk(struct wiphy *wiphy,
> +					struct wiphy_work *work)
>  {
>  	struct cfg80211_registered_device *rdev;
>  	struct cfg80211_sched_scan_request *req, *tmp;
>=20

In this function, of course, the locking needs to be removed, though
this other patch just changed it:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commi=
t/?id=3D3e54ed8247c94c8bdf370bd872bd9dfe72b1b12b

So need to merge back wireless or something first. Or maybe just live
with the merge conflict.

johannes
