Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8F66963E0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 13:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBNMsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 07:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjBNMsh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 07:48:37 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448261E5F2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 04:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DJlfvWqZkHA78ZbY8Kd9jvF+E3dnYPZRKts+/kv0MA8=;
        t=1676378910; x=1677588510; b=lw6+wgZgpJEbI3bwajKPDlP0OoxNuxr/ZyyER2nRqyol/9S
        bw8V5PtcGhwrQzEMMKV0cm6Bnt4uw+NG04Eqq9H1Ak5UHnvNvBdM5OMUrgM4UsJ4gRvxjjmipJSVY
        0W1m34FIu2bP3vxnPK+LKhwtbLB8xqFrlMxdDIfBU20vTWvqoyX7N2iu8uhSxf28WpbB3ZvXwlhKB
        Uu6l7AgIZkEIWekYZ/PjlsveBarqUkRfIdHwuM68BLX4VbjxEPx4LFLanlswfbzhjmnnCdrVhcjpw
        1dBCIZTw03BagF9RSq7dtNLAdJ5TBMe2WFWS6xh5j+9lMVpQhhSCUZmoN64zO4oQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRujT-00C8sE-2x;
        Tue, 14 Feb 2023 13:48:28 +0100
Message-ID: <16d922bd32b30e1a4282dc5941c6fff3b23908ca.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: update rx nss for the link sta
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sriram R <quic_srirrama@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 14 Feb 2023 13:48:27 +0100
In-Reply-To: <20230119221201.24287-1-quic_srirrama@quicinc.com>
References: <20230119221201.24287-1-quic_srirrama@quicinc.com>
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

On Fri, 2023-01-20 at 03:42 +0530, Sriram R wrote:
> Update nss info for the non default link stations
> which gets added during ML assoc when link stations
> gets added. For the default link sta which was added
> during auth time, the nss would be updated in the usual
> flow during set station post assoc once the capabilities
> are available.
>=20
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> ---
> v2: added wifi prefix in commit title
>  net/mac80211/cfg.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 72df8c708a2d..0fdf92e1428f 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1754,6 +1754,15 @@ static int sta_link_apply_parameters(struct ieee80=
211_local *local,
>  						    params->eht_capa_len,
>  						    link_sta);
> =20
> +	/* update nss if not done already for the link sta,
> +	 * for the deflink the nss will be updated once the
> +	 * assoc flag is set through set station. For the
> +	 * non-deflink sta we would reach here only during assoc,
> +	 * so we would have all caps to calculate the nss.
> +	 */
> +	if (&sta->deflink !=3D link_sta)

NACK on that check. Please find a better place, or change the existing
code as well, or something.

johannes

