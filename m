Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89236995B3
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 14:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjBPNZT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 08:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBPNZR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 08:25:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050C955284;
        Thu, 16 Feb 2023 05:25:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9216961FB7;
        Thu, 16 Feb 2023 13:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59C7C433D2;
        Thu, 16 Feb 2023 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676553916;
        bh=uHtnhWLsn2Hd9jpxap1Di2ofv0wWPnKj0G7sCTRuaFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qn+bH7b9qPf23owDpFfK6jr/LyLh5edvLARebuXfAFd1VxLWIRELfo3gt8PIlJ9Rf
         RbtlyL0xXOAVEUINyu2HRyNdrNweygWtTTo0xgjnEnLy/kMk1ileE++wMFL5zo4YSj
         tUMPcac2HgwOu8NGsX/qNTVZ0jXjGCNBlIQAYenyoWhWcrkdShtL5c1J/p+cMeQE6S
         rOA9xPxTFW2HQVFyh4uZOuq8e8lZnvCQEg3VdxTN5fiuOFu3ZHFdtlM+DhTdobjsQt
         JSG2HTSQnQPslDl7LeqbaQBdwS+ntQiSipKOScD9f5aA4nbU/OQxaj7LkLTjA4omDs
         5HTdRbZAAuaPg==
Date:   Thu, 16 Feb 2023 14:25:12 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Howard Hsu <howard-yh.hsu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Bo Jiao <bo.jiao@mediatek.com>, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7915: unlock on error in
 mt7915_thermal_temp_store()
Message-ID: <Y+4uuOiVKegnfrq/@lore-desk>
References: <Y+4eSSqaHCpfK1EG@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xTNt1ROkNg+Crel6"
Content-Disposition: inline
In-Reply-To: <Y+4eSSqaHCpfK1EG@kili>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--xTNt1ROkNg+Crel6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Drop the lock before returning -EINVAL.
>=20
> Fixes: ecaccdae7a7e ("wifi: mt76: mt7915: rework mt7915_thermal_temp_stor=
e()")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/init.c
> index 1ab768feccaa..728150b35537 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -89,6 +89,7 @@ static ssize_t mt7915_thermal_temp_store(struct device =
*dev,
>  	     val < phy->throttle_temp[MT7915_CRIT_TEMP_IDX])) {
>  		dev_err(phy->dev->mt76.dev,
>  			"temp1_max shall be greater than temp1_crit.");
> +		mutex_unlock(&phy->dev->mt76.mutex);
>  		return -EINVAL;
>  	}
> =20
> --=20
> 2.39.1
>=20

--xTNt1ROkNg+Crel6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+4uuAAKCRA6cBh0uS2t
rFNFAP9hqG8m0lMLsz+ZVwJWSdLkAflxJ25xi4RlZDISOt85qQD+P9/K9GlAjh+g
hZTD6jjLdMJdd5+mX6ffbAnkcah/KQk=
=xAWw
-----END PGP SIGNATURE-----

--xTNt1ROkNg+Crel6--
