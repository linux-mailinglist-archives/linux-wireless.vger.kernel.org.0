Return-Path: <linux-wireless+bounces-32229-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEQzNGG2oGnClwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32229-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:08:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD521AF77D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE8F63010602
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 21:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C152D39447A;
	Thu, 26 Feb 2026 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okPxQoNN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15628643A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140111; cv=none; b=TdVrR2jAZ6ZRqnw1v8JPQRoqXfNZ8+EtQxSuQswFQjFM8Cp3t1733h1/It+JKK9C+9go0P3k7Xktk7C1TEdsRYtIt0bOdgI0eIxGrQ61fn5DwWlHx5t/UwgaQO2jlQGj+c9oYM5Wi/OoG8n498jXXv9fDQUnaPYRfhBeSSR3yEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140111; c=relaxed/simple;
	bh=lvfOpg7Q8B6PQTUDRETaioIBfNXDdU4p85aEpRkDPOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8dcq1+4JSKdhxl1+fqKKxwLj8njKZYyZzxD04sGVCbmKxVnsuSCNSwNdRa2E5vL6X2GMuiBQiJzSzyRXzIB388+cC5MVn88HuJF6CkT1eOqZBP9YJOdWnAlZ8shtxkAuY9p+lIdfXepDw910c2VUzpGKPUm1xIDrMb5kzpxFd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okPxQoNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B353BC116C6;
	Thu, 26 Feb 2026 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772140111;
	bh=lvfOpg7Q8B6PQTUDRETaioIBfNXDdU4p85aEpRkDPOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okPxQoNNaXjtAHqbKapEVhYnnFPHYkR3E2EUG40wOSSEOLr4PJaNr1MRVGPG0qfG8
	 mBOH8D1uR19BK5b8TbcQRhDsWJx5vCtcOCPVOjLwxo4hDhgG6FLwmEhilXtdOsMkSW
	 vp+KM+cFo6ZxSiHQQtHsNkVhPCoR6BSsHtwaN7BtymqDcnDFoQ+2eYvWFuUU8TRInk
	 ZzyU5XdhN+nsFL9FP0pWzTv2pAvdiGzdXnK90vkTMRHhbRajsyoRewD1QxjZ0vGRbk
	 Q39H0419rUtEoySHeTIty+ybr0a71yLnBXAFS/jOM5cfaDe36b0cO2Wu1xvvnIbkuK
	 0Udtksr66NM7g==
Date: Thu, 26 Feb 2026 22:08:28 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	MeiChia Chiu <meichia.chiu@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>, Deren Wu <deren.wu@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Howard Hsu <howard-yh.hsu@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Hao Zhang <hao.zhang@mediatek.com>,
	Nelson Yu <nelson.yu@mediatek.com>
Subject: Re: [PATCH wireless 0/3] wifi: mt76: Fix possible out-of-bound
 accesses in mt76 driver
Message-ID: <aaC2TBksZcml-DDT@lore-desk>
References: <20260226-mt76-addba-req-oob-access-v1-0-b0f6d1ad4850@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S9cDFWTiBubiysDv"
Content-Disposition: inline
In-Reply-To: <20260226-mt76-addba-req-oob-access-v1-0-b0f6d1ad4850@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32229-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AD521AF77D
X-Rspamd-Action: no action


--S9cDFWTiBubiysDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Check mgmt frame length before accessing header fields in order to avoid
> a possible oob access for injected frames.

Hi Felix,

do you think these patches can go directly into the wireless tree or do you
prefer to get them into your tree?

Regards,
Lorenzo

>=20
> ---
> Lorenzo Bianconi (3):
>       wifi: mt76: mt7996: Fix possible oob access in mt7996_mac_write_txw=
i_80211()
>       wifi: mt76: mt7925: Fix possible oob access in mt7925_mac_write_txw=
i_80211()
>       wifi: mt76: Fix possible oob access in mt76_connac2_mac_write_txwi_=
80211()
>=20
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 1 +
>  drivers/net/wireless/mediatek/mt76/mt7925/mac.c      | 1 +
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c      | 1 +
>  3 files changed, 3 insertions(+)
> ---
> base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
> change-id: 20260226-mt76-addba-req-oob-access-848280920814
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--S9cDFWTiBubiysDv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaaC2TAAKCRA6cBh0uS2t
rHhKAQCot+MHK/5KIrSE0/KTRx1gyVUHvLhpk9gAlg/5EadIsAEA2JrMGDHYx42t
r5l7H27eW/uMNIW4K/jrBJ25uZ+dtA4=
=PxUT
-----END PGP SIGNATURE-----

--S9cDFWTiBubiysDv--

