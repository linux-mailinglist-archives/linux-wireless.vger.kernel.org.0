Return-Path: <linux-wireless+bounces-30352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 452AFCF2F38
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 11:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04E8F3012BF0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0472F5A08;
	Mon,  5 Jan 2026 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g4TDLaRR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402C22FDFF
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608258; cv=none; b=L5VFbEF2sjBlqk0ZUL/o3GX0U4WLIzdjSqO+ChLipc4XgPkNixx9Yey6DAGlljfugpmVzvZYFumxAmUhPQyQ/mheNnDfq1dFdL+3Gp0ZISRUuezPPDW803t9yDwxPP5hXyiTQaWHK0K21L4dc1YK9z/+BXHL+XeJ58O1KJPkK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608258; c=relaxed/simple;
	bh=wIBaafGcOC+oRc4eOKe8RTVwjF1sDJrp9R0lYlLXOyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jcBWkuyh70SK46Vhtqxwn+xxBLZP+CMeqEhWlA/iP92i+7SZDEIaB6/JxXhA042K4PVXSMigb9wqGPUh2pCuqB8dk+EBK7ByitasId+CEdy+nftfH7KLoTRcLKKYaBvlsQ3FdK6XGQpbfUzG0BTEjMRFOftuDOJBWAD3IYD617s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g4TDLaRR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Gm4KjzqKwBTIdAdqCbIDFda0alfq47tJ1ARqdipfTcE=;
	t=1767608256; x=1768817856; b=g4TDLaRRrwgSJ19Qot8stQGSbiKUoYeJ8iax58aLGY5bv+v
	eEfdoyF6S/Z3vlUzDoOHVU/A+Xl9X80px9fc3QFjTlqg+oj43095Wb554GtSJiun2NkYy4hjjWKZJ
	89fIVeJoq/sy8GLfqkUDV/VnBEJrW7ArEnahGRlipq82x8EduFti5sKnLGZTKB5RTeAoRDh2Hzz1J
	85ffbe7A93udLUlySTG+IzqdmSGlGKKQJGLiSWM5NiUJoasmxsNeTw3QACMiyGC9klY5obaNK4dGG
	Gqex51dtb/EunqXWlYdQagXgli+gR1HCP7VpKSUU8oegt9PNqhy0BwYEZRhsrrwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vcheR-00000003lwQ-1s8f;
	Mon, 05 Jan 2026 11:17:27 +0100
Message-ID: <7092990c23a205543890beb4eb1e2bc96acbf194.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 7/9] wifi: mac80211: add support for
 EPPKE authentication protocol in non-AP STA mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Mon, 05 Jan 2026 11:17:26 +0100
In-Reply-To: <20260105072415.3472165-8-kavita.kavita@oss.qualcomm.com> (sfid-20260105_082526_350968_2DC1EE94)
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
	 <20260105072415.3472165-8-kavita.kavita@oss.qualcomm.com>
	 (sfid-20260105_082526_350968_2DC1EE94)
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

On Mon, 2026-01-05 at 12:54 +0530, Kavita Kavita wrote:
> For EPPKE authentication, the Multi-Link element (MLE) must be included
> in the Authentication frame body by userspace. If the MLE is not
> present, reject the Authentication frame.

Is this true? It seems mostly orthogonal whether or not EPPKE is
enabled/allowed and MLO is actually used?

Clearly if an MLO connection is requested (we see this outside the frame
by including multiple links) then the MLE must be included since
otherwise the calculation would be invalidated, but if an MLO connection
isn't requested, then no MLE would be included by mac80211, so at least
in theory we could trivially support that, and I'm not sure I see why we
wouldn't?

>=20
> @@ -1103,6 +1103,9 @@ void ieee80211_send_auth(struct ieee80211_sub_if_da=
ta *sdata,
>  		   !cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
>  					   extra, extra_len));
> =20
> +	if (auth_alg =3D=3D WLAN_AUTH_EPPKE && add_mle)
> +		return;
> +
>  	/* 24 + 6 =3D header + auth_algo + auth_transaction + status_code */
>  	skb =3D dev_alloc_skb(local->hw.extra_tx_headroom + IEEE80211_WEP_IV_LE=
N +
>  			    24 + 6 + extra_len + IEEE80211_WEP_ICV_LEN +

This is also kind of a bad way to "reject" it, it doesn't - it seems to
conclude but then doesn't send a frame so you get timeouts or something?

I think should just really reject it higher up even if that means
duplicating the cfg80211_find_ext_elem() maybe.

johannes

