Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6840672198
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 16:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjARPnE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 10:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjARPm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 10:42:57 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DA62F79E
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bhVvsVyx3YYeGLUYSEqu6Es6wW7tWwoDmZu0xPZL5GY=;
        t=1674056574; x=1675266174; b=fXyjnei6X564o3DySfbww5aJuqOcQ7W+H+S2s6MUp1+ADZr
        178WC/RJUKUlE8/XPrH+tJJ18sQk0eeWFNqZPRM0vvV8bORxqnf9/u3jSABXu/Hv4gZXEnBMlqNxr
        oEHf9pXm+pcDVi0i/ckhwMmN9MYyzxmK9agHc6aXqOgqfCGVxKCJoeWcPYrYJccqqpqPhbML2jXjZ
        3vvcaP5A3CY5j2UEY5FE/Bu0OC6v3vSD4Srlo8syJAukW45IK0lbXNay2R/JaykXKavgXIo3X7ru3
        yYKQ9WM6K5GGk3nXQz1PEQeckdvfy0xD7x3sxIR28oPJ9MEUuTXGeWHBUQCJrbYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIAaS-005eLr-1Z;
        Wed, 18 Jan 2023 16:42:52 +0100
Message-ID: <47838da1d6563d10ba3a2fe0e747c59eb4ae75b3.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] wifi: cfg80211: Extend
 cfg80211_update_owe_info_event() for MLD AP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 16:42:51 +0100
In-Reply-To: <20221206080226.1702646-3-quic_vjakkam@quicinc.com>
References: <20221206080226.1702646-1-quic_vjakkam@quicinc.com>
         <20221206080226.1702646-3-quic_vjakkam@quicinc.com>
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

On Tue, 2022-12-06 at 13:32 +0530, Veerendranath Jakkam wrote:
>=20
> + * @assoc_link_id: Indicates link ID of the AP MLD link on which (re)ass=
ociation
> + *	requested by peer. In non-MLD AP mode, it will be -1. Used only with =
OWE
> + *	update event (driver to user space).
> + * @peer_mld_addr: MLD address of the peer. For non-MLD peer, it will be=
 all
> + *	zeros. Used only with OWE update event (driver to user space).


Similar here - why require setting assoc_link_id =3D=3D -1 if
peer_mld_address can be left zeroes to indicate non-MLO connection?

That'd save you from updating the quantenna driver too, and

> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -19776,6 +19776,17 @@ void cfg80211_update_owe_info_event(struct net_d=
evice *netdev,
>  	    nla_put(msg, NL80211_ATTR_IE, owe_info->ie_len, owe_info->ie))
>  		goto nla_put_failure;
> =20
> +	if (owe_info->assoc_link_id !=3D -1) {
> +		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
> +			       owe_info->assoc_link_id))
> +			goto nla_put_failure;
> +
> +		if (!is_zero_ether_addr(owe_info->peer_mld_addr) &&
> +		    nla_put(msg, NL80211_ATTR_MLD_ADDR, ETH_ALEN,
> +			    owe_info->peer_mld_addr))
> +			goto nla_put_failure;
> +	}

here anyway you have that condition, so you could just lift the
is_zero_ether_addr() to the outer if?

johannes

