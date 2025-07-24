Return-Path: <linux-wireless+bounces-25987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5021BB10577
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 11:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECEC16316D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AAE24CEEA;
	Thu, 24 Jul 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yHzGFVeX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D5149C51;
	Thu, 24 Jul 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348551; cv=none; b=XUpJNT/Oc3kfcaJo8rIF24+BTLKXhwhR2W7ObaGiM2+UnEfNkwaqg8LPV5hELJ90UCnZAgWanPYDXwGp8rg+Wv3wQGMEnHixNiH66zS8yMTYn+7mAIW++bju9hW9ObHjOyI+wAGBQyQK9901L8kUm3PwcoAKHjkSxmFa/eJ/A34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348551; c=relaxed/simple;
	bh=80+wbjMD9FfVVAhs27dUgjBYT6GHRV6gDCgwNv1spHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eu5YwcAGkaNIgQ4+a4HcVZ7KEYOX5alUVlb4n/1guKGE4yIuxUNQI3KxowZamhWSIwIjyYDlvpFnwv/PI4Vy8eAP156E27PA4cSkDsLtwrnHS4hTX+CuEYvircMX7WRalNrcvCHtpqoY6dX1JirrephwyvxuxM4iuI6+MDGHsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yHzGFVeX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dGsrKtEKvuazu4xKGZqWt075FdbvH1LGnCNvo/0iX6E=;
	t=1753348549; x=1754558149; b=yHzGFVeX82FUcUT/MZNfsO3F8igaFY9oW9IRO0AdbmioAAL
	hRo7kfTJGsWHRBdBAkQIEAUx+iNklFN3CceVbEgFRhk6expMX0VIYLGJM9G/GtIr0VuWa3GRXsWcK
	7kG+6rbA5pxd3sN/ZcyO9sQ3KZgiNielXJA2g2UyOsr7ek5g3XCy9tyCEABRwuzgwet0KkzmvDCwF
	bA0qFL1U5szCZOb81NxevpSTfr/T6qfyXydYPhYjtkiPeU2QkYd+vtm78CQJBvsDmN8OT8oSq2RlQ
	oRUKrz/whYg31Txs0Fp3BC2vmVQl9t8fcBAVMVe1rf0wgyMrUBOE81kIIiCGn5Kw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ues2u-00000005KV8-2Ygu;
	Thu, 24 Jul 2025 11:15:25 +0200
Message-ID: <432d50a2995dee6c421aad6bd21acceec191990e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: brcmfmac: remove 43752 SDIO
 incorrectly labelled as Cypress chip
From: Johannes Berg <johannes@sipsolutions.net>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>, Arend van Spriel
	 <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	wlan-kernel-dev-list@infineon.com
Date: Thu, 24 Jul 2025 11:15:16 +0200
In-Reply-To: <20250724084613.6336-1-gokulkumar.sivakumar@infineon.com> (sfid-20250724_104642_740228_7E0050AB)
References: <20250724084613.6336-1-gokulkumar.sivakumar@infineon.com>
	 (sfid-20250724_104642_740228_7E0050AB)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-07-24 at 14:16 +0530, Gokul Sivakumar wrote:
> Cypress(Infineon) is not the vendor for this 43752 SDIO WLAN chip, and so
> has not officially released any firmware binary for it. It is incorrect t=
o
> maintain this WLAN chip with firmware vendor ID as "CYW". So relabel the
> chip as "WCC" as suggested by the maintainer.
>=20
> Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> Fixes: f74f1ec22dc2 ("wifi: brcmfmac: add support for Cypress firmware ap=
i")
> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---
>=20
> v2:
>  * Relabelled the 43752-SDIO chip from CYW to WCC instead of dropping the
>    support for this chip as suggested by Arend.
>=20

Maybe update the subject now?

johannes

