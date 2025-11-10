Return-Path: <linux-wireless+bounces-28720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 556DCC453A5
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 401244E857E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE172EBBB4;
	Mon, 10 Nov 2025 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FMGw7e+O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFC2EBB87;
	Mon, 10 Nov 2025 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760180; cv=none; b=cgaGpYPMxocACi6TcUNOeJUyJouk9cN3xqJUg3BxegdTRx2P7dPTGz9L1Iybs426HwgCdzzXXK04TDZc2ZUIirGUh1rjVkVpKtntUY+91q1kqBIjXONFvDZPlV8MyVayb0wSxiz9wWk0MkwclBVKy2eV5aAs9w5qdLJYf1mGF+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760180; c=relaxed/simple;
	bh=nHgdQJhh3qGAN7bMip7XjynVr8WuQqSOo/b0cQJPQDo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T3yn5Wg0lsNtGcnVfZoKvrVtFWb2LimRLO7mjXpk//yESGATg4FZPJiOuyKQnXtXimgf4VAoz9LTlklY9algWx9+4C+CIQ/AciDGMkYToKdUSUorq3V0L9vwPQiW1pWfK4zxTxEjX9GH6F3nofVUIkQsHf8Ompva5o4Xv/lUHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FMGw7e+O; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VeJSuMmYtYdReQErdsDSeVOQsotd8G6jtSTIcmmRuRw=;
	t=1762760178; x=1763969778; b=FMGw7e+O7K2qkjWdAEPOMqZO4dE06/GRif5Vh9ztOZLgB/U
	mt85drLkaRk1oWKgagj5iUrbhglLPoXUetmesbJ5l3MAOHa+3aCpmGy2vIv0SJfsdqzaElmxBTi5v
	4BFsxqq2SS14/h2P+VLenWc8U8yMpyGxdeQyssqbQnX2wgZlCKPhBn7NU732Idxm78F6XL0fnqSPz
	gNmWa19Vmog7OIoG4Msm6Z28nGF7c8+mr+QVMY5TBXX2IJCRbxMSocxRAtpNkzTRfozmVDGXDNXUK
	NvPgemXWdQdtEdMFwojDX4fLR9AW+fgbA8dI1BQ6cP9sZwjkUKzdEglJ4KiYyz4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIMRk-0000000AqqQ-0y3r;
	Mon, 10 Nov 2025 08:36:16 +0100
Message-ID: <f27e024e442078b51d70ce5cfdbe2beab9b822c4.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: mesh: tolerate missing mesh RMC cache
From: Johannes Berg <johannes@sipsolutions.net>
To: Sayooj K Karun <sayooj@aerlync.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 10 Nov 2025 08:36:15 +0100
In-Reply-To: <20251109114321.10120-1-sayooj@aerlync.com>
References: <20251109114321.10120-1-sayooj@aerlync.com>
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

You need to fix the subject.


>  void ieee80211s_init(void)
>  {
> -	mesh_allocated =3D 1;
>  	rm_cache =3D kmem_cache_create("mesh_rmc", sizeof(struct rmc_entry),
>  				     0, 0, NULL);
> +	if (!rm_cache) {
> +		pr_warn("mac80211: failed to allocate mesh RMC cache; duplicate filter=
ing disabled\n");

A message after an allocation failure is almost always pointless since
it's already a really big scary warning... Maybe there's a way to
supress the original warning in this case (not sure) and then have this
message.

johannes

