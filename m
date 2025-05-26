Return-Path: <linux-wireless+bounces-23418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E411AC3CFC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F902175F11
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810B1E5B7D;
	Mon, 26 May 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Fvg1+4DL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456B1DDC22;
	Mon, 26 May 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252120; cv=none; b=sfjjfJiqmteqK0qyNoR2khSX4ISz6Mmgsq5zlavfOQ+uICxt4nIDqAIZ70lawNVRktwycixYmZnTsmEf4kAbktlE5BrbH7ZT7NLXGJYv5Y6t0zUnRUuBbTN6ZXl5KXmGEw8Q8VLckcpZUDX/XLe45UfXJPe1BDu203bUzdqypxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252120; c=relaxed/simple;
	bh=ESs2Tkwvxa0/EdI9x4qaDjcXYmuoRc2B1eVIQNnSOSA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NOMeFQUywUFULzN9xcWgQEbBru4ueaoEhQG0+IHPG9EqJ+mNR4UCa14hb1x+EkTkWQmy1ZAoJ3kr0prB5xA1CVL8mASp9YO2iWUFWaTHU/VXlVZzWHWy8mVdLcYCY8ddXSAWJ947lUNHqWJEP+MGCW+NZi3b9mnFP/oyB5w6ooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Fvg1+4DL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ESs2Tkwvxa0/EdI9x4qaDjcXYmuoRc2B1eVIQNnSOSA=;
	t=1748252118; x=1749461718; b=Fvg1+4DL4ZdomdZv/drO9fAsMKkmbnJyVWY+q7je9hgDUrW
	yoCpI8COYfOW5y/45r5cJsJXpyBjW0q12fN0y6AChapysTMC6IFNKNaK4v3cQz0UTFRRAVkT7zpWb
	6lv2hWk/fLUirejtvfFWS+YmHa041eZ4O1YIJ/rabZx2DAfjuyXLzy9/JM0etzM7bps3+7r42EGDF
	skdcsdsraTuwLBq2PQgL8/DJQUr7kzc76vyQb5LwuJG2wET+02aRJWf83h2rGEH+xCU7rzPYJx4/4
	sLIsM3awLHZOLV5eAAjNDJqZNWcm3D2W44YON5/1+0jRKrhPjMcbKN7Z7ukHRLBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uJUEk-0000000DcRc-3hXI;
	Mon, 26 May 2025 11:35:15 +0200
Message-ID: <2d5b450b8b7b9bfa5771e371a9addc3dce19891e.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: Add null pointer check for
 ieee80211_link_get_chanctx()
From: Johannes Berg <johannes@sipsolutions.net>
To: Wentao Liang <vulab@iscas.ac.cn>, luciano.coelho@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 26 May 2025 11:35:13 +0200
In-Reply-To: <20250526091903.587-1-vulab@iscas.ac.cn>
References: <20250526091903.587-1-vulab@iscas.ac.cn>
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

On Mon, 2025-05-26 at 17:19 +0800, Wentao Liang wrote:
> The function ieee80211_chsw_switch_vifs() calls the function
> ieee80211_link_get_chanctx(), but does not check its return value.
> The return value is a null pointer if the ieee80211_link_get_chanctx()
> fails. This will lead to a null pointer dereference in the following
> code "&old_ctx->conf". A proper implementation can be found in
> ieee80211_link_use_reserved_assign().
>=20
> Add a null pointer check and goto error handling path if the
> function fails.

How do you propose it can fail?

johannes

