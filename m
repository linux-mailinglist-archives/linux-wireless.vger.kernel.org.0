Return-Path: <linux-wireless+bounces-8799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B922903F31
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 16:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1F11C2342B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65A11720;
	Tue, 11 Jun 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WX9WlhBG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9910A3D;
	Tue, 11 Jun 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117453; cv=none; b=iT48zOac2fgYM4NKAI6MIDmmbe4eB4Gn05yNyj+SAp7Ka5GivlLT2uzlOy2Ora6Yndv/C5W4OZ+qNgPVsGELv1Bh/vtc3yCXkU7AmGub2Z9jKAluSaKAeopPUQB3Zo9Uc3Y7zVEuY6YHlF34J2RnVeM2KMq9zlfUdqDxD5z67xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117453; c=relaxed/simple;
	bh=Q+Vk2+eVANh0njy/hhC4ju9xNbv0AM9K21HHITFs+uo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cDjjvrrgVSLfvQhjHO8hGIMuxbNtlDUMl2l+dt3y7Llummjx0c3noGWHGCxM7RYV2U1LmkaPDLTpOJUXLw+PFebiKY16vQ145nZOscUZrvy5WECq5hBCPV+8qLYo5c/n2+5Y+iRN/0Dsynmoax+9tNUKJhg5YA/EqqB5wF6z7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WX9WlhBG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zWg8FBvRhKhB/8z85vkan77ET92XRIyEVF5H0gZA0zA=;
	t=1718117452; x=1719327052; b=WX9WlhBGmAwiHZB7UcSCng9lAFzOXlrOc/r9ibDjNvzS6j7
	JYjI3CCUPWwB53E5te7YAXA5a9N1YpzzYoC5R0HJFRKOaoHf/BOw+sdfAdLQCo8/qGsHkCfiTPQFV
	9y8BAdcCBDUX95NU5HimBbFbmPkPC/VUizGaeqQVXTGmHh9yyncsEIzbAMQG2f6dJuVlYjCwt9/EF
	0d2ub0E7q4UyDZzNk04C/GdXuad+qohgNl2JnYr025XABNvQAg5cxPA4rk9sK40mwZm9kJxR0SOtk
	wUatPa4HPFEGQEqvsXPzgFievygqwhjDGCX4vJPn5/FxDGM7ds0/+da7WNCxtX7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sH2pl-00000008l4a-1eEV;
	Tue, 11 Jun 2024 16:50:49 +0200
Message-ID: <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
From: Johannes Berg <johannes@sipsolutions.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, Jakub Kicinski
	 <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Date: Tue, 11 Jun 2024 16:50:48 +0200
In-Reply-To: <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
References: 
	<CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
	 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
	 <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
	 <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
	 <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-06-11 at 11:32 -0300, Fabio Estevam wrote:
> Hi Johannes,
>=20
> I forgot to mention, but the Wifi device I am using is:
>=20
> Intel(R) Wi-Fi 6 AX200 160MHz, REV=3D0x340
>=20
> On Tue, Jun 11, 2024 at 10:54=E2=80=AFAM Johannes Berg
> <johannes@sipsolutions.net> wrote:
>=20
> > > [    5.038174] rxb->offset is 0 trans_pcie->rx_buf_bytes is 4096
> >=20
> > so that looks pretty normal?
> >=20
> > Might be useful to see rx->page_dma too, supported_dma_mask should be
> > 4095 or 2047 depending on the device, but I'm not sure how you could en=
d
> > up with a DMA mapping for a page that's not at least 11 bit aligned?
>=20
> Here it goes:
>=20
> [    4.344218] rxb->offset is 0 trans_pcie->rx_buf_bytes is 4096
> rxb->page_dma is 4215433216 trans_pcie->supported_dma_mask is 4095

> I don't know what a typical rxb->page_dma should be.
>=20

It should be an address (so that's fine), but I don't see how it ends up
not being page-aligned if we request to map a page and 4096 bytes??

Is that platform "weird" with strange page size, or something?

johannes

