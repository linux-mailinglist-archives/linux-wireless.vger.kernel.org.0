Return-Path: <linux-wireless+bounces-15866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FDA9E27F7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 17:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE48128A648
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A023B1FAC45;
	Tue,  3 Dec 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HP7WJfHY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3841FA84F;
	Tue,  3 Dec 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244346; cv=none; b=t4U2TH2LIrE3UFC6HAZr58cJcDKk4a9K11UkSr18ytOOBLpW3bCpZQC5gbxuDAgRIGDYn19k4o6CnyvvSXUoP2nDgasUklmjvGcRyhO6l+KnmXfSyMuZbojZ23viRpK5+eXSjNPkT04LTerbA8/Hn05kzjrmBCOIbvwr3xMWqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244346; c=relaxed/simple;
	bh=BA76lR64G5jRwbmzef8LeHyHC95CSwPtwI8o3wr8d7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KVuxDt8SvRdbrfvLlUUeDhTsZXXD2PZzeNeWDU6mdqwF1Ndmrt/bMPTCE7/IhrfOjBDeIkoIXNUEcNL5OzIiaPVy1ZjumcJIrobpjLuM3G8qpmP2W973ekDuZcPYGFjA1IYKW2nUubownMykDIC0e2IsaYCN+6a3/TB+V2wgGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HP7WJfHY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1kn7esNHtCHkPR0o4sIQLKTBnvYJD1ZCR1/40e9RrWY=;
	t=1733244345; x=1734453945; b=HP7WJfHYLdEgvw3B2UEcvhqocbS7w0bxsER1u/qJLQpfefd
	MjdpsUTtxuuNIGTKU1QHZzqipnRImGzrrJhSLpSUWaGhwzXuj7DvZS2kBmICFOWDyBys+FnKZ63jr
	y9aT40VmNZERooPO6tbmugA5386+8U5JwPp11CDsb+S+Xstvfqy9m73ecNGaHvQiDHEVVaA+l7wPU
	6aAhowpvX/e9QmtSgfTOBhzxjFbulk/ICwdL7dj1PJ17N5FIb6v8twBu11Q2yU4w2VnQ6kYJBHKQR
	oXIUSVLKcK6j0oOQ7MjYvVkm9IyA1Xwawee5MniDRQ49EMHr42asK/AMUubP53fA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIW1s-000000035wi-0cie;
	Tue, 03 Dec 2024 17:45:40 +0100
Message-ID: <dcbf9bee124097e131a11f744b32bbeabc250c98.camel@sipsolutions.net>
Subject: Re: [PATCH] net: wireless: sme: Initialize n_channels before
 accessing channels in cfg80211_conn_scan
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Haoyu Li
	 <lihaoyu499@gmail.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva"
 <gustavoars@kernel.org>,  Jeff Johnson <quic_jjohnson@quicinc.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 03 Dec 2024 17:45:39 +0100
In-Reply-To: <238df0b9-d1db-4f72-8238-828ea20ad1d9@embeddedor.com>
References: <20241203152049.348806-1-lihaoyu499@gmail.com>
	 <fa9ef37903db0f81654451104b1407f60f85ce5d.camel@sipsolutions.net>
	 <238df0b9-d1db-4f72-8238-828ea20ad1d9@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-12-03 at 10:20 -0600, Gustavo A. R. Silva wrote:
>=20
> "Right now, any addition of a counted_by annotation must also
> include an open-coded assignment of the counter variable after
> the allocation:
>=20
>    p =3D alloc(p, array, how_many);
>    p->counter =3D how_many;

Not sure where you copied that from, but quite obviously Kees didn't
follow that guidance in e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
cfg80211_scan_request with __counted_by"), otherwise we wouldn't have
this patch.

>   -- Built-in Function: TYPE __builtin_counted_by_ref (PTR)

Even with that though, we still have to actually implement it, and make
sure we use struct_size everywhere when we allocate these things... In
fact we probably need a new allocation function, not just struct_size,
but rather kzalloc_struct_size(...) or so.

Which e3eac9f32ec0 didn't do, and which anyway we still don't do e.g. in
nl80211_trigger_scan() because we have multiple variable things in the
allocation, so we *can't*.

That therefore doesn't even help here.

So that's not a very convincing argument. In a way moving again to "you
need the newest unreleased compiler" makes it *worse*, not *better*?

But of course if you do that now it'll basically mean again nobody is
running it and you get to kick the can further down the road ... I still
think it's a failed experiment. It didn't do any good here as far as I
can tell, and we've spent a ton of time on it.

johannes


