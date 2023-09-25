Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489C97AD8A7
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjIYNK5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjIYNK4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 09:10:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298783
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bLmtIzwtk8udWwWT2yPFc4aTEqJvV1RIdddP9rsnvIc=;
        t=1695647450; x=1696857050; b=CqVugkKsYp6GrK9Zq0jmv0Cw1ymfAnpWwt7yBSPiUAAfG/G
        1mphUoJ6yObpAbuwZ5MdrM8PzscHrzoaLVXhF6av8Ij0NdNWP/9w1zEls6EVLE8TMvMNbRWqoiI19
        1mQPIeH5BnVmYb1XOI1zLVBK4XGSu4L2inWhnsh1lE8+qOJMrGhRGv+f373KcN6MPAA2jpKtYCCAk
        pQ2zbYapQtv83t1V3OgMm4TSFMWLVzj06PotxIbljMyd3IHw9t2O+leDBSsz/2uILFVKBjQabmPD1
        Pr6gGqBb47sECJYki/6nucrFa8XGwzgSft3J4/oCbdmyOMZBjcjKXgzA4emf6oFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qklMN-003cdc-0G;
        Mon, 25 Sep 2023 15:10:47 +0200
Message-ID: <af4a763b624363543a37140c2106fb7a05800977.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: add support for AP
 channel switch with MLO
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 25 Sep 2023 15:10:46 +0200
In-Reply-To: <20230925115822.12131-2-quic_adisi@quicinc.com>
References: <20230925115822.12131-1-quic_adisi@quicinc.com>
         <20230925115822.12131-2-quic_adisi@quicinc.com>
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

On Mon, 2023-09-25 at 17:28 +0530, Aditya Kumar Singh wrote:
> Currently, during channel switch, deflink (or link_id 0) is always
> considered. However, with Multi-Link Operation (MLO), there is a
> need to handle link specific data structures based on the actual
> operational link_id during channel switch operation.
>=20
> Hence, add support for the same. Non-MLO based operations will use
> link_id as 0 or deflink member as applicable.

Much of this commit log really applies to mac80211 - perhaps make a
simple cfg80211 patch first only?


> +	link_data =3D sdata_dereference(sdata->link[link_id], sdata);

We should probably use wiphy_dereference() now?

Perhaps we should just get rid of sdata_dereference() entirely, after
all, it's the same now, just the arguments are switched for no good
reason.

> -	conf =3D rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
> +	conf =3D rcu_dereference_protected(link_conf->chanctx_conf,
>  					 lockdep_is_held(&local->hw.wiphy->mtx));

Hm, I guess that was an artifact of the (mechanical) conversions - but
really that should probably be wiphy_dereference() as well now?

johannes

