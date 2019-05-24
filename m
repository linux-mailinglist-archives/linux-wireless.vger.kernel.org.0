Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5429311
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2019 10:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbfEXI3O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 May 2019 04:29:14 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:51720 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389361AbfEXI3O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 May 2019 04:29:14 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hU5Zg-00082t-Jn; Fri, 24 May 2019 10:29:12 +0200
Message-ID: <6e162d98ba05a71577c623fe1e8e06a7051eb01c.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: mesh: fix RCU warning
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@eero.com>, linux-wireless@vger.kernel.org
Cc:     peter.oh@bowerswilkins.com
Date:   Fri, 24 May 2019 10:29:11 +0200
In-Reply-To: <1557958906-1432-1-git-send-email-thomas@eero.com> (sfid-20190516_002404_881630_27A31E38)
References: <1557958906-1432-1-git-send-email-thomas@eero.com>
         (sfid-20190516_002404_881630_27A31E38)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-05-15 at 15:21 -0700, Thomas Pedersen wrote:
> ifmsh->csa was being dereferenced without the RCU read
> lock held.

> +++ b/net/mac80211/mesh.c
> @@ -1220,10 +1220,12 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
>  	ifmsh->chsw_ttl = 0;
>  
>  	/* Remove the CSA and MCSP elements from the beacon */
> +	rcu_read_lock();
>  	tmp_csa_settings = rcu_dereference(ifmsh->csa);
>  	RCU_INIT_POINTER(ifmsh->csa, NULL);
>  	if (tmp_csa_settings)
>  		kfree_rcu(tmp_csa_settings, rcu_head);
> +	rcu_read_unlock();

This seems wrong to me.

Really this code is the *writer* side, so you should do something like
this:

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 766e5e5bab8a..d578147ad7e8 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1220,7 +1220,8 @@ int ieee80211_mesh_finish_csa(struct
ieee80211_sub_if_data *sdata)
 	ifmsh->chsw_ttl = 0;
 
 	/* Remove the CSA and MCSP elements from the beacon */
-	tmp_csa_settings = rcu_dereference(ifmsh->csa);
+	tmp_csa_settings = rcu_dereference_protected(ifmsh->csa,
+				lockdep_is_held(&sdata->wdev.mtx));
 	RCU_INIT_POINTER(ifmsh->csa, NULL);
 	if (tmp_csa_settings)
 		kfree_rcu(tmp_csa_settings, rcu_head);
@@ -1242,6 +1243,8 @@ int ieee80211_mesh_csa_beacon(struct
ieee80211_sub_if_data *sdata,
 	struct mesh_csa_settings *tmp_csa_settings;
 	int ret = 0;
 
+	lockdep_assert_held(&sdata->wdev.mtx);
+
 	tmp_csa_settings = kmalloc(sizeof(*tmp_csa_settings),
 				   GFP_ATOMIC);
 	if (!tmp_csa_settings)


Can you test that and send a proper patch?

johannes

