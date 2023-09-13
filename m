Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7279E6E1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbjIMLe5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbjIMLer (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:34:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093032130
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7P8ZBdVthZodHjk5pLcBjmzAeDIMvDA8bxQQkyVc9+o=;
        t=1694604844; x=1695814444; b=JOubOO1hG+EKXezBxHBGKCaIQvxZL1QhkmB5eLWt5/SKgtT
        ocKDq6qENivjuXLi+KD9ReD1zmk15EgqgXk0O5a1aUS9u3yWVO0Psz8yWonGoP0i31IRI9NQQ15+s
        vPQB0DJt0k4kMNrbuMtyakrAgFXD6T/C1uG1dpt70urdbmyQE4IkRlaiVldhZieEJrxwDpcLhKiXW
        gTOWCWeQKB1pYYKKoESv5Sj91NslXjSM0Rwdus+PMuQ8+zSMceZTRs/6b9fuy0t8mHlXUbLJDz/sr
        mSbeFva7OYt7cyHAmabE0+TY8IBjgw3r+J+yUNBBmRODbxQu2z8MUheP0hBFCV4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgO88-00Er1e-2U;
        Wed, 13 Sep 2023 13:34:00 +0200
Message-ID: <b1d79a9547653b6eb41742716f5c352b97fbe9ee.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: support ieee80211_ext format
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Date:   Wed, 13 Sep 2023 13:33:59 +0200
In-Reply-To: <20230419042009.1058020-1-gilad.itzkovitch@morsemicro.com>
References: <20230419042009.1058020-1-gilad.itzkovitch@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Going through all the old patches ...


> +	const u8 *addr;
> +
> +	if (ieee80211_is_s1g_beacon(hdr->frame_control)) {
> +		struct ieee80211_ext *ext_hdr =3D (struct ieee80211_ext *)skb->data;

nit: can just use void * cast.

for reference below:

> +		addr =3D ext_hdr->u.s1g_beacon.sa;


> -	if (ieee80211_is_mgmt(fc)) {
> +	if (ieee80211_is_mgmt(fc) || ieee80211_is_ext(fc)) {
>  		/* drop frame if too short for header */
>  		if (skb->len < ieee80211_hdrlen(fc))
>=20

I don't understand the addition of this check in this patch.

ieee80211_hdrlen() just ensures that you have _four_ bytes header for an
ext frame. So maybe that makes sense on its own, but above you're
casting to struct ieee80211_ext * and then using the u.s1g_beacon thing,
so you need to ensure many more bytes are present _somewhere_?

johannes
