Return-Path: <linux-wireless+bounces-35561-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLJwCzaf8WkojAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35561-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:03:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D56A848F9A2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5598F3014693
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2CA31F9A2;
	Wed, 29 Apr 2026 06:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="j7vl5XRm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5C15539A;
	Wed, 29 Apr 2026 06:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777442608; cv=none; b=Jyft9DUsX7r8q6a9iOhhpo4Ij6CHHHtjv+dhJavw2NQ0g4DxFDEc43IkYWKZCiI6MsYQK1k0ZrtKjZmDRjMbYGxoyy4OJuYCM9qHbFLJqH4hb9EZtKZhLWC6t+hWzjDeENJzO5gSOP1xmyK4cSp7FaInLQDq+jU4VuSm48pqXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777442608; c=relaxed/simple;
	bh=BTBuiucOOgRSl7o953zK8iWZLj6M9ZRsWQZDJMlhRp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw1ouAQAI5gDKqZ+Tn7VjfZktfXsLTtq2oGua4tZctrY+HUNJwubTZHx3EVaFbdziundld94T4TEMGa63tTV7lK+0i0eYh7OhdRn1FX6M2DYQKVpiBriRpU925BXAd+uj8ByOa5ZOnol/W2GNDLnsfB8gCeqWjvdd/l56YjKHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=j7vl5XRm; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (unknown [185.12.129.178])
	by mail11.truemail.it (Postfix) with ESMTPA id 10B2C1F9E1;
	Wed, 29 Apr 2026 08:03:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1777442596;
	bh=iqYArevJ9226utXgvE9SFYuo51RIQeAFVZCGGvwOP6E=; h=From:To:Subject;
	b=j7vl5XRmHqq6TsU5WSI1QtU/UaB2Og2v5Rpjn9y/oX8psBLMD21gG6JQqg0esHDz3
	 lJOqh4Cgp8nVB6KtU8Nuztjt2/noPBsl+6bbHHGNAo/zvvv76yUv8YC2vLWOaC+lFb
	 24KxZpBZkKgZxxOEF6RkS5F2ExglnG1GGZrIpvuhrWheqoFCMxcvJ7ijZp4fPbXjMz
	 8cTnYyu8MRgu0ndTmQqdSX11p2a1c0+Yk9/J37pJqtt/D1B68gFBDz+rMgxOVC1njA
	 UmJMpNW5Tcr6P0SYTzW3woQPZ9qm7n4aywxKcd8R9Tuvqghvx+oCE/jhVs2JbjXS5G
	 44XSrg2xRFHNg==
Date: Wed, 29 Apr 2026 08:03:09 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, johannes@sipsolutions.net,
	francesco@dolcini.it, wyatt.hsu@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v11 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <20260429060309.GA9739@francesco-nb>
References: <20260428194021.785252-1-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428194021.785252-1-jeff.chen_1@nxp.com>
X-Rspamd-Queue-Id: D56A848F9A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35561-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dolcini.it:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dolcini.it:dkim]

Hello Jeff

On Wed, Apr 29, 2026 at 03:39:59AM +0800, Jeff Chen wrote:
> This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP
> IW611/IW612 chip family. These chips are tri-radio single-chip solutions
> with Wi-Fi 6(1x1, 2.4/5 GHz), Bluetooth 5.4, and IEEE 802.15.4.
> Communication with the external host is via SDIO interface. The driver is
> tested on i.MX8M Mini EVK in both STA and AP mode.

...

> Change history:
> 
> v11:
>   - Added MMC core support for NXP IW61x base SDIO card ID, ensuring that the
>     MMC_QUIRK_BLKSZ_FOR_BYTE_MODE quirk is applied at the card level rather
>     than from the SDIO function driver.
>     This addresses the IW61x SDIO identification behavior, where the base card
>     reports one ID during initial bus scan while the WLAN function reports a
>     different ID, and aligns quirk handling with upstream MMC architecture.
> 
>   - Cleaned up legacy ioctl-style command usage in cfg80211 paths by removing
>     direct nxpwifi_send_cmd() invocations and routing these operations through
>     explicit driver helper functions. This reduces duplicated control logic,
>     clarifies command ownership, and aligns nxpwifi with the expected
>     cfg80211-based control flow.

b4 diff 20260428194021.785252-1-jeff.chen_1@nxp.com is not working for
me, I guess because you renamed the series, take care of this in the
future, thanks.

Francesco


