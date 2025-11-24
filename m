Return-Path: <linux-wireless+bounces-29290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CCAC8162B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 16:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E481A34316D
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7B313538;
	Mon, 24 Nov 2025 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MUQegNZx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550133054CE;
	Mon, 24 Nov 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763998690; cv=none; b=ZuOl67rZTrl7XpqlHS4A2Ribf1XEJijRTKYIk+HHzRTIa96TSVtN6/Z+Nn3pCLed+HFfbD0bLbooxPXdRtY+Y9JvJRNbMGtvf/aWIRJzhKWx2Kvrvw5MeWxZIqxGKRG50qt3UYpg3N01argFGfX8GoTox/knUeJJt94dJZFENkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763998690; c=relaxed/simple;
	bh=OkzpCes8k/0YPelpPkLjQ3hl/YKaYWSLFrR8H2wVxyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3kFxjTdkp6unb8ZovzqTCzhgtly6t+tUIjcQkd7VBIBijF93GUrUOLj2KEj9cBjFBxf3O3OSYHLdK0EAezAjsJ9txHMRo0vP+p/4zDBDfQmw8Er9mZj+H0+65r841JqnsGmfVWUaTAcoed1ZEWEheK+Pke8pzo+cfThCXnQTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MUQegNZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F95C4CEF1;
	Mon, 24 Nov 2025 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763998689;
	bh=OkzpCes8k/0YPelpPkLjQ3hl/YKaYWSLFrR8H2wVxyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUQegNZxt2dnxkt2nBnt72DZvEZkQWQqaqC8FEht2o/MdEacEd0WjFIVOb/SLJnTG
	 lF5oA2dYC803d9mlhNY/baqjw3/tzIAY+3N6zksFNBqIzgLnglM8wgztaZ0RBPG7Ht
	 K80rzanXMOQkz2K7HfOrRA5VLdY+U+HBoiImY+wc=
Date: Mon, 24 Nov 2025 10:38:08 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ally Heev <allyheev@gmail.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND iwlwifi-next] wifi: iwlwifi: mld: remove unused
 variable in d3.c
Message-ID: <20251124-terrestrial-mule-of-kindness-d8c4f5@lemur>
References: <20251121-aheev-remove-unused-var-old-keys-v1-1-6c2565c77ef7@gmail.com>
 <a9e12ace-dc0e-4bac-9775-72cd7d477169@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9e12ace-dc0e-4bac-9775-72cd7d477169@kernel.org>

On Sat, Nov 22, 2025 at 03:18:20PM +0100, Krzysztof Kozlowski wrote:
> > Best regards,
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iHUEABYKAB0WIQQBFRpOLrIakF7DYvaWPaLUP9d7HAUCaRLyowAKCRCWPaLUP9d7
> > HLG9AQDZmggT93tMLv32pq5myG3e83t12KWON9efOBg//lH4vgD+Ppw3KoTpdYtJ
> > 20VDaWuqUVj9KLqjx9hblfEiB7s9gQw=
> > =A6F+
> > -----END PGP SIGNATURE-----
> 
> You should switch to patatt instead, not signing emails. We don't use
> that, I think at all, unlike patatt which is being actively checked by
> toolkit (b4).

It's even more curious. The patch was sent with b4, but I'm pretty sure we
wouldn't have put the PGP signature in like that, so I'm curious how that even
happened.

Ally, can you shed some light on that?

-K

