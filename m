Return-Path: <linux-wireless+bounces-27879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 799DBBC4202
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 11:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 120C44F25E7
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83D2F3609;
	Wed,  8 Oct 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="i2xD+Ri4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F92EC0B5
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914731; cv=none; b=lq/GPsfjk8wCmJ476jAJ/aqxt5yEyR4sbXm+b56PkPZNIjD/Peu4Lfz25CdBU2D3xFQVYj380GR3r6jgHXn5K4FQoAS4+q/GSFu54Jlkru2cwvBY0wC8ROiU3WWi4p+7ivztFNdhs8AKkT9P/mpnKNKfYA62B64YVvGvaQXJ7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914731; c=relaxed/simple;
	bh=K2i7tlJbWwCqGLACH6V+d2RelCEDWGlXAhO/jF3R7lk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iz8r16sYhvKk1V9LgQSMOqVUU2d0n5q8zAV8fUkzhYPOX6c0NtHEPcQYn9CjZUQtCIHfr3f2v4s8mEBPrQnnCRE91iVDAS9B3PC9hhWqKIizmSz2cLxYdBsxa+TYDbqCV068oTIfeiMEZ3UMSw1SzQf9MhM61GLcBXRFGVmT6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=i2xD+Ri4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yFcKqv6NENApTHDEgHun0uuN+uezqyHAhEFQCuoA28I=;
	t=1759914730; x=1761124330; b=i2xD+Ri4LlMnpWp7mTWMKD7kL4eEYpUjMic3UWq1d3yfGNa
	zHwWgYiMxgV3ZqnIJPgzmsMLtc+IfZWY59cZnJaYc6IvxcwD+hk3chuhr+30C9sOm7r10cfr1H02Q
	5Pqva+948io4ulOp+WSH65xpNwprr0+ohkNXe/pBxd+i9lYbok0q5GZnGlqwDS4yXx1xmUiNAM23F
	8Z7T2CfNkrWOlSDGgyISqqe/JkP2wu4oJN7lQ2nJwICyr7eU++j5/u369sAvErNqSOUnbyk8E2aak
	aiwknfEjkdHXcOPHadgcveAMNnIuaSxdOeZgXRH09lRmXA3NzNLkTAJOJEL4gm2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v6QDN-00000000FXv-1RFj;
	Wed, 08 Oct 2025 11:12:05 +0200
Message-ID: <d7eb196b01003a1de70456d5a31d9b4a37d555bd.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mt76: mt7921: Add PCIe AER handler support to
 prevent system crash
From: Johannes Berg <johannes@sipsolutions.net>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, nbd@nbd.name, 
	lorenzo@kernel.org
Cc: deren.wu@mediatek.com, Sean.Wang@mediatek.com, Leon.Yen@mediatek.com, 
	Michael.Lo@mediatek.com, allan.wang@mediatek.com,
 Eric-SY.Chang@mediatek.com, 	km.lin@mediatek.com, Quan.Zhou@mediatek.com,
 Ryder.Lee@mediatek.com, 	Shayne.Chen@mediatek.com,
 linux-wireless@vger.kernel.org, 	linux-mediatek@lists.infradead.org
Date: Wed, 08 Oct 2025 11:12:04 +0200
In-Reply-To: <20251008085916.1626952-1-mingyen.hsieh@mediatek.com>
References: <20251008085916.1626952-1-mingyen.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So ... yeah it's your driver, and yes it's already at v2, but ... this
still seems very much papering over a problem?

On Wed, 2025-10-08 at 16:59 +0800, Mingyen Hsieh wrote:
>=20
> Unable to handle kernel paging request at virtual address ffffffc01099eac=
0
> pc : mt76_dma_add_buf+0x124/0x188 [mt76]

Why does it even crash there?

> +++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> @@ -96,6 +96,9 @@ mt76_rx_aggr_reorder_work(struct work_struct *work)
>  	struct sk_buff_head frames;
>  	int nframes;
> =20
> +	if (atomic_read(&dev->bus_hung) =3D=3D 1)
> +		return;

And how does sprinkling this "magic dust" all over even do anything?


This sounds a bit like the driver isn't able to deal with surprise
removal, what happens if you e.g. rmmod it while running traffic? I
believe the effect of the error recovery would be similar, if you don't
handle it, so are you sure there's not a completely different underlying
bug?

johannes

