Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4494A5F7806
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Oct 2022 14:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJGMiX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 08:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGMiW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 08:38:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43456D0186
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oekvfKdZ5+JLCfO7EMXqb2XhL5ocen73EQr15ax3uHg=;
        t=1665146300; x=1666355900; b=pXu9CGd4ktJTAloltHOYGUwaSNqJKAFRFiLOjL6lPqMliOR
        rPU2ZoifOX1VEeI3D78Y2OigygfW6qZ6RH8lpRZYrlYlqsUOjBUu214G+VjHQbmSdA+aCn2xvg6+f
        UX7R2Wx/n8GhxEC2HRsKi5buwN31E/NcCWLLG1KtTTGsS9ezEocWGKjy7FIHeNZoedeqXgqDwCc0/
        IFH/dtHLiTwUeEJ+kxf5y2HCZuzUkOQmjyy79C0tp4gpm8Zj1q23ERBzb7d7MLl7S2gUCtN/RCoHh
        KBsortzTefy4T7MLXhLlT3qUEh08bDjWaZDiaeKtk7Zwp2y6RAIwQhX+lOxedeCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ogmcL-000NMS-0x;
        Fri, 07 Oct 2022 14:38:17 +0200
Message-ID: <972da18c889300252656aa53cc8d9e70d1e90174.camel@sipsolutions.net>
Subject: Re: [PATCH 6.1 1/2] wifi: cfg80211: fix
 ieee80211_data_to_8023_exthdr handling of small packets
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     Chad Monroe <chad.monroe@smartrg.com>
Date:   Fri, 07 Oct 2022 14:38:16 +0200
In-Reply-To: <20221007090509.18503-1-nbd@nbd.name>
References: <20221007090509.18503-1-nbd@nbd.name>
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

On Fri, 2022-10-07 at 11:05 +0200, Felix Fietkau wrote:
> STP topology change notification packets only have a payload of 7 bytes,
> so they get dropped due to the skb->len < hdrlen + 8 check.
> Fix this by removing skb->len based checks and instead check the return c=
ode
> on the skb_copy_bits calls.
>=20
> Fixes: 2d1c304cb2d5 ("cfg80211: add function for 802.3 conversion with se=
parate output buffer")
> Reported-by: Chad Monroe <chad.monroe@smartrg.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/wireless/util.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/net/wireless/util.c b/net/wireless/util.c
> index 01493568a21d..35f630c6de11 100644
> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -559,8 +559,6 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb=
, struct ethhdr *ehdr,
>  		return -1;
> =20
>  	hdrlen =3D ieee80211_hdrlen(hdr->frame_control) + data_offset;
> -	if (skb->len < hdrlen + 8)
> -		return -1;

Can't decide if I'm happy with that vs. just dropping the "+ 8" ...

On the one hand, we already assume at least that the header is in the
linear portion for when we access it, but on the other hand it feels
safer to keep the check?

> @@ -628,16 +629,15 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *s=
kb, struct ethhdr *ehdr,
>  		break;
>  	}
> =20
> -	skb_copy_bits(skb, hdrlen, &payload, sizeof(payload));
> -	tmp.h_proto =3D payload.proto;
> -
> -	if (likely((!is_amsdu && ether_addr_equal(payload.hdr, rfc1042_header) =
&&
> +	if (likely(skb_copy_bits(skb, hdrlen, &payload, sizeof(payload)) =3D=3D=
 0) &&
> +	    likely((!is_amsdu && ether_addr_equal(payload.hdr, rfc1042_header) =
&&
>  		    tmp.h_proto !=3D htons(ETH_P_AARP) &&
>  		    tmp.h_proto !=3D htons(ETH_P_IPX)) ||
>  		   ether_addr_equal(payload.hdr, bridge_tunnel_header))) {
>  		/* remove RFC1042 or Bridge-Tunnel encapsulation and
>  		 * replace EtherType */
>  		hdrlen +=3D ETH_ALEN + 2;
> +		tmp.h_proto =3D payload.proto;

As you can see on the last line, this is broken.

Double likely() also seems weird.

I think it needs to be

+       if (likely(skb_copy_bits(skb, hdrlen, &payload, sizeof(payload)) =
=3D=3D 0 &&
+                  (!is_amsdu && ether_addr_equal(payload.hdr, rfc1042_head=
er) &&
+                   payload.proto !=3D htons(ETH_P_AARP) &&
+                   payload.proto !=3D htons(ETH_P_IPX)) ||


but better if you check and resubmit.

johannes
