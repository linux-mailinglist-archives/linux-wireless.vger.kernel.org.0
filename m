Return-Path: <linux-wireless+bounces-8797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B3903DFE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E69D1F24C0C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2AA17D371;
	Tue, 11 Jun 2024 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g0320USq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286F17D35F;
	Tue, 11 Jun 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114062; cv=none; b=im2qvnihqdpsCC0DMIvkfj+TkJGJ7wz+f+DzAcdChkYox5doJv6AZY1XTUlRa1JQxLhf/IEjIIyVc8pEmU+9PZ53owb7xmjtUCdwbNnFxfuQ6Jyw/idw8s7RoWMWmKa4cTqL2uVfsB4PHPJ/H0fCsFyUqxTFhj+G/xu6IX+Tbs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114062; c=relaxed/simple;
	bh=2UrUxNi+bMQB1JygFOWiEiOyAXps9fRZhWY9jaLZb8c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcS52XwRU4L0rvIgNoElXiNIEqYZJGlTHrXCe1rcuH6ewhd56NZrWibVBBDBHS+nzw58XVB5NtrqxFuojXcaR3PEkTObpglE+HbBvBdFyM7EIhzal3Rw62zFOZgeUUia6Ylicele9pmUAdXKXDKUovdgkk90cSvYa3OAPadAvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g0320USq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tRijnAHcosKtI4xo+uB32Jb7iLe726hGK7jy+SHjT44=;
	t=1718114061; x=1719323661; b=g0320USqhdrXiF0suv82ucQB0mzvJDPqKEev29gN6jz/C0y
	P35a2kiQOJlriGy0eacKl0Y0Aq8xc8RsDhtZ0RxWliFV5U6PCExrXGrst2waGq+5E4MQThW4JHP0y
	pp4BGHpZ2Kzn5okm22aCPfQwWnvyW/jTidkwugJrwn3DRjpCaG4kkTssRm4HhneJYtxcTrHyGi6kn
	ACMdnePRaQWwyOs2Kk28qB0pbLYL46YoZTYVdKqnY2rfmMk1Lawc80RQOqCmWpitim1Wn+Ytt4NM7
	fyKcuvbW6Pgpht1QP1hylsWZHQyjjBxlpXvI8/VOk4Ze7uHmK6S/CLx4o9UC8+VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sH1x4-00000008h5l-00Ha;
	Tue, 11 Jun 2024 15:54:18 +0200
Message-ID: <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
From: Johannes Berg <johannes@sipsolutions.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, Jakub Kicinski
	 <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Date: Tue, 11 Jun 2024 15:54:16 +0200
In-Reply-To: <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
References: 
	<CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
	 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
	 <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
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

Hi Fabio,

>=20
> I did as suggested:
>=20
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> @@ -266,7 +266,8 @@ static void iwl_pcie_rxmq_restock(struct iwl_trans *t=
rans,
>                 list_del(&rxb->list);
>                 rxb->invalid =3D false;
>                 /* some low bits are expected to be unset (depending on h=
w) */
> -               WARN_ON(rxb->page_dma & trans_pcie->supported_dma_mask);
> +               WARN_ONCE(rxb->page_dma & trans_pcie->supported_dma_mask,
> +                         "rxb->offset is %d trans_pcie->rx_buf_bytes
> is %d\n", rxb->offset, trans_pcie->rx_buf_bytes);
>=20

> [    5.038174] rxb->offset is 0 trans_pcie->rx_buf_bytes is 4096

so that looks pretty normal?

Might be useful to see rx->page_dma too, supported_dma_mask should be
4095 or 2047 depending on the device, but I'm not sure how you could end
up with a DMA mapping for a page that's not at least 11 bit aligned?

johannes

