Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF735F782F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Oct 2022 14:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJGMrD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJGMrB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 08:47:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58241144D0
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JV/tYPBys4mGp4tqrrp4AMORhCf69cqsxtjNZEPfDEY=;
        t=1665146819; x=1666356419; b=vgmTVdQ59VxXG9WQBZrxcaQNuPDyvZNuue5WVhI+2F3oQH1
        ZjgXv55bW5WAWSPBFFELb3dYjSpVffchdUVZKCK8dYOMqZFGZmZzA5V6FT0aN6+sVKnY6QozNG0f7
        wX8++j5djhu4h23qBbte3DXuKDb6zJEvhCk97sErfy5rTsvzIW/MZ7JKy6te8woVc6B9H6xjm+9/R
        sU/LEh7UEMZjfPL+67aegAz4gEx8ZTM1kSnRr+bA0VvWyt9G6J2J754e4V7OWUYiQR8m6LS+TrAnU
        qOXBD2OQx4YfFnuLOu5s/TekRnlvf+OegzaUNq5QP7JNdFItKhCRI5ZIsNwNfTxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ogmkj-000Nvh-0N;
        Fri, 07 Oct 2022 14:46:57 +0200
Message-ID: <162c20431069a5f81e93d36aec10fdad11f82aae.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix EHT issue in
 ieee80211_determine_chantype
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Fri, 07 Oct 2022 14:46:56 +0200
In-Reply-To: <20220929151638.9823-1-greearb@candelatech.com>
References: <20220929151638.9823-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Thu, 2022-09-29 at 08:16 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> The IEEE80211_STA_DISABLE_EHT flag was not enabled when it should
> be, so the bandwidth change failed, and STA disconnected.
>=20
> Use an OR approach instead of just assinging the flags, to

typo - assigning

> allow easier setting of certain flags such as the EHT
> one.

This *looked* reasonable, but doesn't apply in any way? Can you rebase
on wireless/main please?

> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  net/mac80211/mlme.c | 63 ++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 32 deletions(-)
>=20
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 011827137da7..9ac99f48c63b 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -167,7 +167,8 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_=
data *sdata,
>  	struct ieee80211_if_managed *ifmgd =3D &sdata->u.mgd;
>  	struct cfg80211_chan_def vht_chandef;
>  	struct ieee80211_sta_ht_cap sta_ht_cap;
> -	u32 ht_cfreq, ret;
> +	u32 ht_cfreq;
> +	u32 ret =3D 0;

Could keep that on one line still? Any particular reason not to?
=20
> =20
>  	if (cfg80211_chandef_identical(chandef, &vht_chandef)) {
> -		ret =3D 0;
>  		goto out;
>  	}

can drop the braces now

johannes
