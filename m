Return-Path: <linux-wireless+bounces-8564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F6A8FD10D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 16:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F65B25361
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88321224EA;
	Wed,  5 Jun 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="i/FA784p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D919D8B8
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598656; cv=none; b=KR2m84t8UCCyVx4canBn+8EUuH9SyTXxaEBYTQHLaKJdsPTjcgT63kMjgib/E0r6J4CYdqXH7ULJMYR0z8xFmlX1tV7QlbFXiMUpFdifuhET77lyBwt5r1L5XB9S+G4pEeyvhyYT4iPO+rrixOU52ctRG6k67mYOz/Bg85/k/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598656; c=relaxed/simple;
	bh=P/NbBW47QRxkj80+OynywEc2sofxJ90pmMeEWGpxzrQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8nINpe0yVoLOrKoNLqYbC0ROZisZmp7eCukYWjZpFaBeiAKs7f4J1XDcS2WO9ALIWfD6Un9WYwznvbxIz71s+H5OW8ILt+yKeqMmYakNzLci8Ru9HdUVRzj2nw6lPSjmUnoakrA34WNg3F6xcq9uPYiFIjVyP9rcopzEocY5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch; spf=pass smtp.mailfrom=protonmail.ch; dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b=i/FA784p; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1717598639; x=1717857839;
	bh=P/NbBW47QRxkj80+OynywEc2sofxJ90pmMeEWGpxzrQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=i/FA784pfL/90T6+MJQQBi54pyfNyQ3MqNyemH7cCOIOQuCI5ebNTr+VR4S4U7jIH
	 uRFtrLkgF6VNTwRE3+j14jAiA/YEfNeN36EcgQEa5aMdNyhyqlO6tFRt2AeblDCCcF
	 uCcstubyIZvbsvEDA08q66tRvK7PMzZm45tmqk/jfRiwed95ObOLRW7JP6k17V7wEV
	 s/YfGuXAsm8idgUEepZDadIEppTd85bX/8nRJEd5J60T+2I8/UR1j95+mR1kELESs8
	 FNyU7cSZqEdKsPIf6pMXN0r/MuDJNfPLWvWroYicQIeSOKa/DFTpV1F0c5ihtCAgMB
	 iYMJNkB3zD89w==
Date: Wed, 05 Jun 2024 14:43:53 +0000
To: Andreas Kemnade <andreas@kemnade.info>
From: =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Cc: briannorris@chromium.org, francesco@dolcini.it, linux-wireless@vger.kernel.org, linux-firmware@vger.kernel.org, lukas@wunner.de, yu-hao.lin@nxp.com
Subject: Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the firmware git
Message-ID: <_pNnwoI9WHlb2EY635KdIv6t_goU-ZYp9Vav31jkFOCf9fCE9EeKdyCea2m-L8pgfsKIQvODlnQLhQqmWSYip9e6FFZwaJHL5-u5rdOS_kY=@protonmail.ch>
In-Reply-To: <20240605160013.6bea8d4d@aktux>
References: <20240605160013.6bea8d4d@aktux>
Feedback-ID: 53029:user:proton
X-Pm-Message-ID: e7b701913f9657947b93d4972ca205ffe7695c03
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Excellent point. Please note, that btmrvl_sdio needs an SDIO BT FW. So, mrv=
l/sd8987_uapsta.bin should preferably be a such a combo FW.

Unfortunately, to my knowledge, none is available publicly. Also, after the=
 acquisition of Marvell IoT, NXP regrettably decided to develop mwifiex dow=
nstream, here https://github.com/nxp-imx/mwifiex.

It is what it is. Due to licensing, the FW binary should come from NXP. I c=
annot arrange that.

Kind regards,
Tamas



Tam=C3=A1s Sz=C5=B1cs
tszucs@protonmail.ch


Sent with Proton Mail secure email.

On Wednesday, June 5th, 2024 at 4:00 PM, Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:

> Hi,
>=20
> I am a bit wondering, but there is mrvl/sd8987_uapsta.bin
> referenced in the driver, but apperently it is not in the firmware git.
>=20
> https://github.com/nxp-imx/imx-firmware/blob/lf-6.6.3_1.0.0/nxp/FwImage_8=
987/sdiouart8987_combo_v0.bin
>=20
> seems to apparently work. How to proceed? Should the file be renamed and =
added
> to the fw git?
> The uartuart8987_bt.bin needed by the btnxpuart driver is there.
>=20
> It is just nasty to have a driver for a device but some manual matching o=
f firmware
>=20
> BTW: there is also https://github.com/nxp-imx/imx-firmware/blob/lf-6.6.3_=
1.0.0/nxp/FwImage_8987/sd8987_wlan.bin
>=20
> Regards,
> Andreas

