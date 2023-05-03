Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED16F5257
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjECHw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 03:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjECHwg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 03:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8EB2120
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 00:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F21A560BD4
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 07:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12240C433EF;
        Wed,  3 May 2023 07:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683100354;
        bh=IEdCIHikHXx2e9SyXy2ThDRVxCAUufbXsMGMgDOZltw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7qIvGllWz3Q34wiJctzYz4ItgbAbYmpVQofRnNRExBZkZNDLIhiri4RhNAoukwhi
         DPbWK8XnZTXKob4+OHibLQ47KZxFY+duiEfehtflKl+Kb0WHqSUTDF562RVEVOPwf9
         dtN37InflT0pgxihw0ZtJ4YTj1Eo3fK6nr1+ro9/BkCPG/+7V3x5eF1MN8leFQcazh
         ebr8RPI/xPD1A6jNV17kbTW62J0WdnLHyewgtLYgPJfYhNu+VyQux6lepoKWCElV+t
         9ZexEAbwzhMe6WNTBXiaHN7SYG8uMhnlFzYEYcZ9rRRVaQhGlROOu+d1mkAF3WKAB9
         /l0KVABraHAGg==
Date:   Wed, 3 May 2023 09:52:30 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: mt76: mt76x02: remove WEP support
Message-ID: <ZFISvk7QzpqVkV/L@lore-desk>
References: <d560f1a16c9024b6e4029bd0baf53384f4552f5a.1683020788.git.lorenzo@kernel.org>
 <871qjyosnd.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EsNC/2K8zetZ9mc4"
Content-Disposition: inline
In-Reply-To: <871qjyosnd.fsf@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--EsNC/2K8zetZ9mc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Get rid of WEP support in mt76x02_set_key routine since it is not longer
> > supported upstream.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> You marked this for wireless-next so should I take this directly?

it is not a fix, "wireless-next" is just the default subjectprefix for my
git tree, sorry for the confusion. I think it can go through Felix's tree.

Regards,
Lorenzo

>=20
> Does this fix something or is just cleanup? It would be good to mention
> that in the commit log.
>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--EsNC/2K8zetZ9mc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZFISvgAKCRA6cBh0uS2t
rDnfAP9a+JJVv3SE0AME3xzi761cvox8GmzPcW+TgvhZrbdV5QEA0DCJ5ODLeoO3
zmxwKx27kNY7PLPOta/ntYJ7wf163go=
=vZhj
-----END PGP SIGNATURE-----

--EsNC/2K8zetZ9mc4--
