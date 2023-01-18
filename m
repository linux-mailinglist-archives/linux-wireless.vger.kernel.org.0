Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1ED672189
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjARPlY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 10:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjARPlX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 10:41:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3208110DA
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nB1VYM+SzJalbH/+wMLTKCI3wub8ZHtdM0Tjlqrkb0U=;
        t=1674056482; x=1675266082; b=BjQ4CrfVCPR8c15xvmPbI6rJ1RPQFs45QrVjAD8rxX4JLHH
        PUYrFSOG00S73eQ4J6uX9DK7rSAduED7XC8atoBfouOXvIv1jF20ax7IgayoD3Beloanm8F04gOUi
        13ywwTbW6wvDxUp/GtCvji+PZAe4JjO8y0JnStZgkfeMbzliV7wT8vRm91657fypKBZDAZ7QFLHAX
        VF3pquujuqqI+SXvdNNWjl5/92KOnprLHbqXQr5ikbT2/VTIannUmlgO+0PGNv93wYcIbMmGVpAdL
        +WUmN2YaC2NF2CAWnpeD+ey4Blw9ehpg4QpcBzxDL0UZy+88gVdV7Y+3MfM/mDSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIAYx-005eJK-0r;
        Wed, 18 Jan 2023 16:41:19 +0100
Message-ID: <f6a13b05feb05eb648dbd4b6f91932d75b353fbf.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] wifi: cfg80211: Extend cfg80211_new_sta() for MLD AP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 16:41:18 +0100
In-Reply-To: <20221206080226.1702646-2-quic_vjakkam@quicinc.com>
References: <20221206080226.1702646-1-quic_vjakkam@quicinc.com>
         <20221206080226.1702646-2-quic_vjakkam@quicinc.com>
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

Hi,

> + * @mlo_params_valid: Indicates @assoc_link_id and @mld_addr fields are =
valid.
> + *	Drivers use this only in cfg80211_new_sta() calls when AP MLD's MLME/=
SME
> + *	is offload to driver. Drivers won't fill this information in
> + *	cfg80211_del_sta_sinfo(), get_station() and dump_station() callbacks.
>=20
> + * @mld_addr: MLD address if the station is an MLD. Otherwise, set to al=
l zeros.


> +	if (sinfo->mlo_params_valid) {
> +		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
> +			       sinfo->assoc_link_id))
> +			goto nla_put_failure;
> +
> +		if (!is_zero_ether_addr(sinfo->mld_addr) &&
> +		    nla_put(msg, NL80211_ATTR_MLD_ADDR, ETH_ALEN,
> +			    sinfo->mld_addr))
>=20


It'd be invalid, but now you could have mlo_params_valid =3D=3D true &&
is_zero_ether_addr(sinfo->mld_addr), which would lead to a very strange
situation for userspace, it would see a link ID but no MLD address.

With the documented requirement that
	mlo_params_valid =3D=3D (mld_addr is valid)

wouldn't it make sense to just remove mlo_params_valid, and lift the
is_zero_ether_addr() check to the outer condition?

johannes
