Return-Path: <linux-wireless+bounces-21217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446D8A7EF5B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 22:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797F73AE4D3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 20:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA802185AB;
	Mon,  7 Apr 2025 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="U4J+JGhU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885F20B7EF;
	Mon,  7 Apr 2025 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744058073; cv=none; b=hpa3QBLXsADbdKVFTGjxE7XQaP4TsaNt6pQPU7pjz0gA+B8VSFRV6fH82QQoz4Ysn4lFX9vIMmrFORFF6QB4t07++lUFPOISl3ki3G518iEpUFQCuQqoXsXpl7K1WgqubdrcW2jZzUr4pvOU8+evaqmf7MUFA0ByEjp5k/7a3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744058073; c=relaxed/simple;
	bh=tVR/F/NSylUgcJzbs2HkaEZkdZzrltsI8ghKO/ofRos=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=th4X4dXd1FI01Fpxr0IYFOlJIE7RklLwVSSpG2gHg9nFexwZzdBFwl3XsTWeTG3srFf5wCEFBQSq1Jgsh+De/ePA37Dg3NMvAc9dB+pjsUQ+PjTDkU/2O5osqZ5sKAL7sPZ2nLt98kBnSwE9NocmCUERxz/dx3GVfptgwCigv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=U4J+JGhU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oWjWmgLlKk+RYLGY1FfRtNeoSaBDNtMsU7hUod6knVg=;
	t=1744058072; x=1745267672; b=U4J+JGhUrATF8K3jl/7txnBLNfBaBCUtrCLLI56okFxEWfU
	AndkBr98q7CFzQal8w+zFp6AgnN8ufB5ERpH+jblGVnRfUuWJ4/S0mTX9f/k7D9xaiOVTfxFrgSx0
	ePUQFhBMPIealVlxRpodU+uYi1raJfqaXEefchch5pBQpEUFRd1YVmy0/OGYICxaDYs7fXDEfIfbl
	LLduYBX7JY6hISjaW7DX2W8YamWYqG/wPFgIbgbml3u7CIGe387G+nDhtqCKMQcwTbVJ01BdI8hdY
	GRH/aD3kZCEGdtTmBYCsx6pMYwQkUlPWYYoR/0r2QaXij0jRZswvaLQawryLWLbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u1tAq-00000002jo5-1yq9;
	Mon, 07 Apr 2025 22:34:28 +0200
Message-ID: <7f16ef040821818a0ac8f35b5636877eb7041bd8.camel@sipsolutions.net>
Subject: Re: [PATCH][next] wifi: iwlwifi: mvm: d3: Avoid
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Mon, 07 Apr 2025 22:34:27 +0200
In-Reply-To: <202504071310.17CBF96EEA@keescook>
References: <Z_FxXjiMvG5u73fi@kspp> <202504071310.17CBF96EEA@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-04-07 at 13:15 -0700, Kees Cook wrote:
> lots of quotes

It'd be really good if you could trim the quotes a bit ...

> > +		wkc->mac_id_n_color =3D
> > +			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
> > +							mvmvif->color));
> > +		wkc->num_keys =3D 1;
>=20
> Looks like struct iwl_mvm_wep_key_cmd::num_keys is the counted_by for
> struct iwl_mvm_wep_key_cmd::wep_key?

No no no. I'm still burned by you adding this to various places
elsewhere in the wireless stack, let's not.

Btw, Gustavo, I think it was probably the other iwlwifi patch, but
please also make sure kernel-doc doesn't start complaining, we are
trying keep it that way.

johannes

