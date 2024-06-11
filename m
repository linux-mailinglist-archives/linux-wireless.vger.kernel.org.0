Return-Path: <linux-wireless+bounces-8791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02E2903C41
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 14:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F572826D3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F517C213;
	Tue, 11 Jun 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dCoHoGKq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2431E86F;
	Tue, 11 Jun 2024 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110382; cv=none; b=aCzMoJr3O8K4lhCNNVVSpJLQWg9ozr2+TJerXGgoCiU0Tzv7huTBERk1SC7iXcpb+/VnSX32aCaSNOj4av09JWgLaRBalK++cgC2DgrjD6iiATPUgD4L3i+Z1Ex0F8Hd47ii54idHJWsT39RX93nlB8vUArRo4sTWON0GUe6mY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110382; c=relaxed/simple;
	bh=8k4aFEn9epFLsv4dAaMi9hR0KShNd2EEmHko2bR3L6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ti534gIlFaASTenXkR0YXxS5cw3HjbMaqfHLcrdI3s/2twIt910C87J7ZoyEdpeQzs9/AZ3smGdmMOXv8rKF9EymryKI8GpmrlZB9dzSuWGbnJ4j5zHN5MxFDcql1NyKsc+nFIRWFlDsL5vgnUB1JJad8RObZaooz7+q3cfZacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dCoHoGKq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5H77y2Cip2lYrbGUhjSBMLsUT+K5goNmlMChYCYRyG4=;
	t=1718110380; x=1719319980; b=dCoHoGKqyZ/o6poBfcAQEwbMULV8cHclXvW2uJwQ2ngfUe+
	aUR0WmizEnlPudv3+YdnvaPsz5BdJh/R+uJxVly7InyXHT0myiKcM5I4Uw+IAhwHbCMYO0z/LDWTa
	FPBlREhRwpfYZL4Wy+lafzEq0mOIyZeWXsDQrRj0bL8qBfxR3nLpqqwcCs82z7JvDbKXPwaR+Yqxq
	4YMfd7nWI0d+/54kaQjo6FuWYS6sh3hYpX/hDVxhQIM52yAYff+KepcTpDMYrCEUhnUgm50MGvKjh
	VfpNWcn9fnlYm8r89ttyZEiCLJwe6MWSyastVuNNhGMvX+5Fl+MQl38PfGt2EU+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sH0zh-00000008cuV-2mpS;
	Tue, 11 Jun 2024 14:52:57 +0200
Message-ID: <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
From: Johannes Berg <johannes@sipsolutions.net>
To: Fabio Estevam <festevam@gmail.com>, miriam.rachel.korenblit@intel.com, 
	kvalo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, linux-wireless
 <linux-wireless@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Date: Tue, 11 Jun 2024 14:52:56 +0200
In-Reply-To: <CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
References: 
	<CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
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

On Tue, 2024-06-11 at 08:46 -0300, Fabio Estevam wrote:
>=20
> [    6.995391] ------------[ cut here ]------------
> [    7.373564] WARNING: CPU: 3 PID: 136 at
> /drivers/net/wireless/intel/iwlwifi/pcie/rx.c:269
> iwl_pcie_rxmq_restock+0x158/0x178 [iwlwifi]
>=20

This warning happens if DMA mapping/allocation returns a page that's not
page-aligned??

                rxb->page_dma =3D
                        dma_map_page(trans->dev, page, rxb->offset,
                                     trans_pcie->rx_buf_bytes,
                                     DMA_FROM_DEVICE);

(or similar places), where rxb->offset will always be 0 unless
rx_buf_bytes is set to 2048, but that can only happen if the amsdu_size
module parameter is set to 4 (=3D2k) but that's not even supported any
more?

Maybe make this WARN_ONCE(...) with a string that has more info on the
addresses.

johannes

