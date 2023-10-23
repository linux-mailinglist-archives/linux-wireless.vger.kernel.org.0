Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A3C7D3EEC
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjJWSRz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 14:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjJWSRu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 14:17:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F77D10E
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wkF647sluMMaNvH4wxoE5Xcr+ldiO84/Q6AvbVamnZc=;
        t=1698085068; x=1699294668; b=dSGvkjnXXLeJTMsPS8wQ9LdRwUbpv11kkRl0dwQASX8eKFh
        /A8b9KakEY27YRhZujmYBT2uvCpB/POnVB5UomJALNIKh7Wkgc8ATmqhWMXlkU+M413G9QKg3oiTb
        ZbMcPoOIPdzynfkpirt+Kbz2LvrusfSiDdtCT/+7SSrpp98qG0SXDo84Zcqx+5pAZO/sti6TY4Vat
        zXCdrHNMQPUoyGBatDyPmfv9MTfigYjNng10jNpuxVrAk0pAitsyOkZppJulFG2q0xMB4Y06OzQ6/
        kgzYHnFjFL9KRL3oLY7AUwLdPJj4Nxmrixvs5sWTsqlxOtVC1pfOKN33j1FNgElw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1quzUn-00000000Opm-0LLB;
        Mon, 23 Oct 2023 20:17:45 +0200
Message-ID: <08a47f34f85bb64be720e473d5a43193412185a1.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211:  work around crash in mlme.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Mon, 23 Oct 2023 20:17:43 +0200
In-Reply-To: <20231023175738.1686631-1-greearb@candelatech.com>
References: <20231023175738.1686631-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Mon, 2023-10-23 at 10:57 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> Protect from NULL ifmgd->assoc_data in ieee80211_mgd_deauth, crash
> was seen here fairly often in a 32-station test case utilizing
> mtk7922 and be200 radios.  I'm not sure if radio types matters
> though.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>=20
> Patch is for wireless-next tree, bug was likely introduced in
> this release since this crash was not seen in earlier 6.6-rc testing
> nor in 6.5 or earlier.
>=20
> There may be a better way to fix this...

I mean, you're not *actually* suggesting we merge this patch, right?
Right?!

> +++ b/net/mac80211/mlme.c
> @@ -8185,13 +8185,18 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_=
data *sdata,

I don't know what you did there, but that file doesn't even have 8k
lines for me.

>  			   "aborting authentication with %pM by local choice (Reason: %u=3D%s=
)\n",
>  			   req->bssid, req->reason_code,
>  			   ieee80211_get_reason_code_string(req->reason_code));

So let me get this straight ... this is the "aborting authentication"
(!) case, but

> -
> -		info.link_id =3D ifmgd->assoc_data->assoc_link_id;

your code is accessing the assoc_data? I'm not surprised that crashes,
but that's in no way what the upstream code looks like?


> +		if (WARN_ON_ONCE((unsigned long)(ifmgd) < 4000 ||
> +				 (unsigned long)(ifmgd->assoc_data) < 4000)) {

You complain that it takes effort to get stuff upstream, but at the same
time this is what you post - you can't have really bad patches and a
fast track into upstream at the same time...

johannes

