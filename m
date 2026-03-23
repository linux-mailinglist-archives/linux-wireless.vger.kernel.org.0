Return-Path: <linux-wireless+bounces-33734-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBziGlqcwWmFUAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33734-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 21:02:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C92912FCCC4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 21:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E37DA31A807C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 19:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEDF3DD516;
	Mon, 23 Mar 2026 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZgJ219e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18EC3DBD51;
	Mon, 23 Mar 2026 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294716; cv=none; b=QM1lTr8+2SSnvn8O4WJEC9NCD6FpMLgno0oLx+GYQNSj/8EEVJfkZDmkxYtmZ7ExWyxKHr0Kd8GgXj1yVeVYS7waDvCfyTYy7Wng+Tvr/sGgr6mdGr5Pdbg4NsabTON3gunP+dcVHJ0T1F38Wz8bczdpJH9ZIWpDMhziFuxsSfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294716; c=relaxed/simple;
	bh=zjx39ilZrLD9eegnvZBoM728RyH1At0AzI9UWm21L4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4hdSizHp/QLxDHfSUseKJUQyJY3nycJjP5CLyNoRgfaLBDK0fRIz6iKqbOUVV+9TmbjIxsUwQKrfAGs1GIBcc+lydPzWA0eVHUvbXpd+v7w8zrcRjbTrlWzgG9GRQIzbxLcnmGgp6ZbENqwh/jlgV0ZWy9yiFBXiVWcsGG8120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZgJ219e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFE6C2BCB0;
	Mon, 23 Mar 2026 19:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774294716;
	bh=zjx39ilZrLD9eegnvZBoM728RyH1At0AzI9UWm21L4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZgJ219eSO1BluKKrE0/F78/wIPyFIUlg3b1vY41BTYDdRyXHEdZg8+eiRHHgY9UX
	 VgmNCe6IBbjAHJ6zs3NPZENOLtDPeIKm3EKFsnc+y9bRDhFkpCaGvoXhqXdy5pGS2W
	 2g5gcwt53jQe6NjG1itfP1o0k+1ADBg7PGZZXLwgMs+OF3XclYBRjwfsSSu15888iT
	 F5Ew36jMz6PAm54ZE/qr8+gXSld5EYHDxbzhTh3wv76epi+Q2fEpLzkQYqS3GvRVo3
	 QXdnRXu3XuHjnPygiDXkY5FPUFM+ZGO0Ed2Enkzxvf9DNn9t65+YDJjMAYPkvltcPq
	 1Wj/giAuEfTew==
Date: Mon, 23 Mar 2026 19:38:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	van Spriel <arend@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 2/9] dt-bindings: mmc: amlogic: Add compatible for T7
 mmc
Message-ID: <20260323-unlikable-crinkle-cc31999aad5a@spud>
References: <20260323-add-emmc-t7-vim4-v3-0-5159d90a984c@aliel.fr>
 <20260323-add-emmc-t7-vim4-v3-2-5159d90a984c@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l1GQQw0YeXOQe55v"
Content-Disposition: inline
In-Reply-To: <20260323-add-emmc-t7-vim4-v3-2-5159d90a984c@aliel.fr>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33734-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linaro.org,baylibre.com,googlemail.com,kernel.org,sipsolutions.net,broadcom.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C92912FCCC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--l1GQQw0YeXOQe55v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--l1GQQw0YeXOQe55v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacGWtgAKCRB4tDGHoIJi
0tYqAQCrWwcbdjUSvcfyVvddjQQ9LY+4jSz9SafZfg0an6LaGgD+JMXZKODbZhL5
cE/+52VOplJVr6pGlNoUkQdovcgiVwE=
=r7oK
-----END PGP SIGNATURE-----

--l1GQQw0YeXOQe55v--

