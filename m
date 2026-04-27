Return-Path: <linux-wireless+bounces-35337-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFgjOt4J72n14QAAu9opvQ
	(envelope-from <linux-wireless+bounces-35337-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 09:01:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3BB46DFA3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 09:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F3F6301876E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94336F418;
	Mon, 27 Apr 2026 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/UO8nr5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2072949E0;
	Mon, 27 Apr 2026 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273233; cv=none; b=eZaHhYGQOiHz4fXdNgEe5p2M2YEfCUs1dBicQbrjw6qprWrj3abhF56jcrZNMNOeIyRvZhlkiklbmrRLsL3RE4Syz7JFA0Q/6x4I4cvWNF9QzEbBnlLGqS/J6Onk8I+TcMAUMT6z5maTEIVzpLFPzXm4koCQjeUg16ZAkywZiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273233; c=relaxed/simple;
	bh=hscgZXrH/5hlVlI4joz/OwlsC/ItzGkqY+r3g/tMh6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/jOnALYSNxnCTEtifFIBqo/tpRhGzeo9PPVrPmCS3oULZniRMne/N7rG7vjU51aOgmj4JGSPJL5/EHB/W8H6D6/lAMDv+PbGOhIAAtSafGXuPs7YLlzgTGEMjIs/sPfE5QaJ10pLr99X4HJGkiWdkhg5jx239miPEDt+FTjFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/UO8nr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A383C2BCB8;
	Mon, 27 Apr 2026 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777273232;
	bh=hscgZXrH/5hlVlI4joz/OwlsC/ItzGkqY+r3g/tMh6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/UO8nr5TQ7PliWjUKlAZqvmtgQU+FEMkbRmmSgrIX7+9ZgK/HIdX4NYWVZ4rngKw
	 PLBQ0/wMFxTjBXytc8sMx2PcAaIJUCNUNus9UpAS0DhvvpIolB2CfnSbt8y6g3u783
	 4e6eNxqixT4kTNhHFlxBIuqeVX3NZhfdHxj4Z+nudtcjnondSnBuoupFAF3EdjoALF
	 56TK9X9uH+Uv7gDR6L3FJ17myhK+nPEb2Xzx7pPVYCMqiKLog4QTEgJPM54KXGoI5h
	 b0RP6hj3HJCTnvpSJs4bTwtNGexQKcRoLqkpcafByY/22j7sIulWa9Q1ER6iZY0/q5
	 ceI/MVWjDbmJw==
Date: Mon, 27 Apr 2026 09:00:30 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH wireless-next] wifi: mt76: fix of_get_mac_address error
 handling
Message-ID: <ae8JjhGXn4RmHSF1@lore-desk>
References: <20260427051746.954704-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VmDJMRbZHv0Lzy9p"
Content-Disposition: inline
In-Reply-To: <20260427051746.954704-1-rosenp@gmail.com>
X-Rspamd-Queue-Id: 8E3BB46DFA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35337-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,gmail.com,collabora.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


--VmDJMRbZHv0Lzy9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Check return value instead of is_valid_ether_addr. The latter is handled
> by the former.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wi=
reless/mediatek/mt76/eeprom.c
> index 93d91264687f..0f6ccf6ed53d 100644
> --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> @@ -93,7 +93,7 @@ mt76_eeprom_override(struct mt76_phy *phy)
>  	if (err =3D=3D -EPROBE_DEFER)
>  		return err;
> =20
> -	if (!is_valid_ether_addr(phy->macaddr)) {
> +	if (err) {
>  		eth_random_addr(phy->macaddr);
>  		dev_info(dev->dev,
>  			 "Invalid MAC address, using random address %pM\n",
> --=20
> 2.54.0
>=20

--VmDJMRbZHv0Lzy9p
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCae8JjgAKCRA6cBh0uS2t
rBXWAP9XbNiVEDpyQr3wYwK6yy95P7sLbl7oGeiTS3olm3X2sQEAn6TCQaIm/1uu
vNVMiJbIVrmUHHeTG560ExFWwjBmTQQ=
=lAlv
-----END PGP SIGNATURE-----

--VmDJMRbZHv0Lzy9p--

