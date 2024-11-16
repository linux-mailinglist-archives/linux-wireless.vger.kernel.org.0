Return-Path: <linux-wireless+bounces-15401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50649CFD5D
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 09:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C8FB2791F
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797728FF;
	Sat, 16 Nov 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D3Jx7mTH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EDA63C
	for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731746008; cv=none; b=H8hKjSPh8C+oivgecD9yCUswmt5s24CJ/vnXZjfWBgC0qylOOPERNDDkaKSQkHNmdciVo67TIuw5tRm0oyz+hemUCuymCP6MQKOqY3xNP0PgqD3jKDgY0wF/z+6xboCMKySIvjhSDFspjRHdDLmk6vn2NTolweeTd1JWvftMULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731746008; c=relaxed/simple;
	bh=SZ+rp0CTt6YYQftu7p/yV48To+7GzMlUfwrbZ3IjSrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rA3m5ARIIwxHwNVYBxo81PtkZZJDxVKFUsCcwAklnPbMJ4xYJkSYjRWDRsPs68ff4rMvfPBMOMNL/s5TFQr4nPPfDGZ+DhwIS5TmHHICyQvZYqqrcPfjO4rvmqMiPnzoNxeFWvIiFYsuMAz9aOFRpw5e9cbWGfGUY4b/6NEmlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D3Jx7mTH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SZ+rp0CTt6YYQftu7p/yV48To+7GzMlUfwrbZ3IjSrk=;
	t=1731746006; x=1732955606; b=D3Jx7mTHuBDervoALj9ohs6+y984WIPcQ6GH0WLSxQcPK6a
	Chf299rIkgX8GVUwz0eqzswhFr47Jp87ggQNj7woXPIK4QpRC32/Zmv2mODG9lWqwS9w88ubp6ZRC
	37DxIrHL/4DonwSOpQD5ONdBWFpCPugnNHXQIkHtZiPTFCQB4vWx3WfgnHfsnq0nbC6UdWdYKK1kE
	tz+alVmrRSgFmt9nudUHwRgjrjTwEN0Yy+TZlL4nVGHgEOli9RSxo6mNFM65Q1zgulquzNIiMRAvD
	he4Zum449prPqdZV8uYt/tHR6feBjudUc/pA8nZgK4nx9AP/ubZgefzJxfvmaHfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tCEF9-00000006Jnb-42R3;
	Sat, 16 Nov 2024 09:33:24 +0100
Message-ID: <ca8e16a2dbc9c38e5bf2f3e426a2132393b381be.camel@sipsolutions.net>
Subject: Re: [PATCH] wireless-regdb: assert and correct maximum bandwidth
 within frequency difference
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@gmail.com>, wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
	combuster@gmail.com
Date: Sat, 16 Nov 2024 09:33:23 +0100
In-Reply-To: <20241116082417.8720-1-pkshih@gmail.com>
References: <20241116082417.8720-1-pkshih@gmail.com>
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

On Sat, 2024-11-16 at 16:24 +0800, Ping-Ke Shih wrote:
> From: Ping-Ke Shih <pkshih@realtek.com>
>=20
> Since kernel will reject max bandwidth being larger than freq_diff in
> is_valid_reg_rule(), as well reject it ahead.

Not sure that's generally true, if you have AUTO-BW I think it should be
OK?

johannes


