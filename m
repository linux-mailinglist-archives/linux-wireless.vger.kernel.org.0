Return-Path: <linux-wireless+bounces-33228-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG+KHvumtGlvrgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33228-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 01:08:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5B828AD64
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 01:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D7C03010717
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 00:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A251B1DF254;
	Sat, 14 Mar 2026 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvSTOH67"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490DE1D5178;
	Sat, 14 Mar 2026 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446900; cv=none; b=i1fY4SR+DNoL3Bjs9aQxWSQ+YYIhBeH7YAGlm7HfaExHqqd/GXDs10O3SZ3Bn6vylvQw7gYmD3YSQQPpE3mibkLoZs6ISsWyuf2bsBmdAtsHfe6hZuHs6kmTX8o8DPJ4dG99f0FfCOa3DPG+hRRYhK+6mRNQWlsS0GBQulOlq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446900; c=relaxed/simple;
	bh=7gNCDydkgxUZvseLqPsVtxB6EjOzf+D38jXxxHFS1RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1kGu9jmi7k2nr1XvrhJ+QgbdH7V9yFYiYCkDQmSXWOn0SGuiZz6qHW91XF7+2bcu/bzUSqstFtqOlOBgENsFadq5V8ndUkBh+Dtk5Qf9FGNnMPe6CSeqiyl9C08Py2lE+PZZrS9cV6+byHHk4PZADIrBuhuUmjMTwDUsOyeNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvSTOH67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E686C19421;
	Sat, 14 Mar 2026 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773446899;
	bh=7gNCDydkgxUZvseLqPsVtxB6EjOzf+D38jXxxHFS1RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvSTOH67VHiMLz2VR34KszR3m2sZfJb/89XLPZOiVu6ezSidZMe1YYywy7Tsq470i
	 DgvP3Ktwbgdyiiks+MeQJWchthxll7aFbehD//QQP1UbB1pHYjELIiHiJlAcqnEmiv
	 pkJ/8rn25WN+/qLGjie4Km3GY+By7D9LetSXDAaGve/vjib5QWvzWPRr8y30CRt0/R
	 rQQ0EVzjJG4jB/t/tftsxgoTEEF+mM83fRWWs2dzu/fXETiK5z7xBSiptBBUvZQLjR
	 0qap7XMOxQjnH3Y2S8tjZGyXaLEf0YdeYrfKQGA3CYRhcBg13zBGJT3rT9sS5vSr5y
	 FlHJKrVui89Yg==
Date: Fri, 13 Mar 2026 19:08:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: briannorris@chromium.org, conor+dt@kernel.org,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	johannes@sipsolutions.net, krzk+dt@kernel.org, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, Frank.Li@nxp.com
Subject: Re: [PATCH] dt-bindings: net: wireless: marvell,sd8787: Relax length
 constraints
Message-ID: <177344689795.3706356.13043407533958417879.robh@kernel.org>
References: <20260311194531.70441-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311194531.70441-1-festevam@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33228-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F5B828AD64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 11 Mar 2026 16:45:31 -0300, Fabio Estevam wrote:
> Commit 31ed9d9d71ec ("ARM: dts: rockchip: Limit WiFi TX power on
> rk3288-veyron-jerry") added calibration data for the rk3288-veyron-jerry
> platform. The commit message explicitly notes that "the length can vary
> between hw versions", as documented in the original text binding.
> 
> The current YAML schema enforces fixed maximum lengths for calibration
> data arrays, which causes dtbs_check warnings for rk3288-veyron-jerry.dts.
> 
> Relax the constraints for the two properties that have
> variable-length data in this platform by adding minItems based on the
> actual data used in the downstream kernel:
> 
> - marvell,caldata-txpwrlimit-2g: 508 bytes (from rk3288-veyron-jerry.dts)
> - marvell,caldata-txpwrlimit-5g-sub2: 744 bytes (from
> rk3288-veyron-jerry.dts)
> 
> The original maxItems values are preserved as upper bounds to maintain
> validation for other platforms while accommodating this specific
> hardware variant.
> 
> Fixes: 25f855413885 ("dt-bindings: net: wireless: convert marvel-8xxx.txt to yaml format")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  .../devicetree/bindings/net/wireless/marvell,sd8787.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


