Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D226807B2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 09:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjA3IoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 03:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbjA3IoW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 03:44:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1644E199F6
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 00:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lc8scgfsSmP1/Z/ihenx0w7HRnTEJbbQvXK7KO2eJkw=;
        t=1675068262; x=1676277862; b=HGZRoHiMiJtmPRFrIJYWQz5lbpm8S24FS3w6vI4COjLiW3p
        lOmME5mM83mZE/vrRZN614WADtfQw60TLQArx5hSL/vUxkosY3zvECyiuVNVPG3jV8KbIyJAbfeoi
        glvfWvnXsrWn1QGeuHJxpbTFNU9qrD5F5AqN3sxWKlqL+J16E1xP778oxFdXCTulktsN2phQRhlt7
        XGUFnJuk85Dg8B2VaY0fnIXMjcOcTNew5tW6B/03ciZB4T1I0lwqY+GLj3zhG3UMv9DiKD/A73Yrr
        PADOwsgmv120jjDtJeiJOiRbO4b2Q5vXk3CRm2+r+oJRAASz/qEwbmUAAIu+7q8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pMPlz-00G1Hr-31;
        Mon, 30 Jan 2023 09:44:20 +0100
Message-ID: <a48bbacf2fe68fb796db2541861e0afb550647f3.camel@sipsolutions.net>
Subject: Re: [PATCH v3 4/6] wifi: mac80211: configure puncturing bitmap in
 channel_switch()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 30 Jan 2023 09:44:19 +0100
In-Reply-To: <20230130072239.26345-5-quic_alokad@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
         <20230130072239.26345-5-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Sun, 2023-01-29 at 23:22 -0800, Aloka Dixit wrote:
> Validate and set the puncturing bitmap in bss_conf for new channel.
>=20
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> ---
>  include/net/mac80211.h |  3 +++
>  net/mac80211/cfg.c     | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index b1c17c7ac044..87db6055d331 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -645,6 +645,7 @@ struct ieee80211_fils_discovery {
>   * @csa_active: marks whether a channel switch is going on. Internally i=
t is
>   *	write-protected by sdata_lock and local->mtx so holding either is fin=
e
>   *	for read access.
> + * @csa_punct_bitmap: new pucturing bitmap for channel switch

typo: puncturing

>   * @mu_mimo_owner: indicates interface owns MU-MIMO capability
>   * @chanctx_conf: The channel context this interface is assigned to, or =
%NULL
>   *	when it is not assigned. This pointer is RCU-protected due to the TX
> @@ -741,6 +742,8 @@ struct ieee80211_bss_conf {
>  	u32 eht_puncturing;
> =20
>  	bool csa_active;
> +	u32 csa_punct_bitmap;


And one more ;-)

I think u16 is enough for now

johannes
