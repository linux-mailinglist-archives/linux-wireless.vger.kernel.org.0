Return-Path: <linux-wireless+bounces-37831-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n/mDG2PQMGpwXgUAu9opvQ
	(envelope-from <linux-wireless+bounces-37831-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 06:26:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B029668BE12
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 06:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=uLg3Kmfa;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37831-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37831-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 226F430F4C50
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 04:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270473C8C62;
	Tue, 16 Jun 2026 04:20:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EB3C8C52;
	Tue, 16 Jun 2026 04:20:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583653; cv=none; b=isfl7PhuEpa0vejlmeODwgb2o8LM6B0rYFS4OT7y32gjpieiv8mFaupgyq5eYzMpx0f1YIt/CTDiir55F8s2WmP9V7WUWqHec7bDuoVU4lPewRPXNwgCVPdhja5WUJS2u14VIE8C5257PYj4TTGUzYaeDYsHKzn3ePfWCc2FE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583653; c=relaxed/simple;
	bh=kuYuyJlyFwP8rCqtF/iLW97jrlFHOoBJ1HFbaTgxsXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU2FAxNTaUOOQalwfmKP5tJezlcYdjreGfNmF0aFhqCPNua4KU16KZ9Xd/UXDb7iXIQwzaSSi/VyTdZcc0sUqekd13AjB4GZZMpldYIZb7fFOJWstoAJ/mKbbHTp+DRbklOnO6e/b5k8oxWiQuPI0t6TA1UNJDEq18LdQL0uhvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uLg3Kmfa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF06D1F000E9;
	Tue, 16 Jun 2026 04:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781583651;
	bh=7Tcg+1GJwXzaapcROEHo1QViH6YgQaoh9TZcwcgDtXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uLg3Kmfa84/3RSsI1lUf+rX7a8j3lgAAZZuYjSLc2q5mJoClAF27W/DR0/EQzAl0s
	 I7B3S64w4UmstIAdPeJuxqO5L/zkPaF3QNgCgaTetUuxf6mBMw4wkUuIxoGR4UOzvX
	 RVrrFG5cXVU3cpjvz6nteEyzEqAxj12Ax8Oyq5XQ=
Date: Tue, 16 Jun 2026 09:49:47 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nazar Kalashnikov <sivartiwe@gmail.com>
Cc: stable@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
	Kalle Valo <kvalo@codeaurora.org>, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.15/6.1/6.6/6.12] wifi: iwlwifi: fix 22000 series SMEM
 parsing
Message-ID: <2026061636-alike-triumph-743d@gregkh>
References: <20260615122100.137560-1-sivartiwe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615122100.137560-1-sivartiwe@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sivartiwe@gmail.com,m:stable@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:kvalo@kernel.org,m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gregory.greenman@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:luciano.coelho@intel.com,m:kvalo@codeaurora.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37831-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,gregkh:mid,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B029668BE12

On Mon, Jun 15, 2026 at 03:20:58PM +0300, Nazar Kalashnikov wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> commit 58192b9ce09b0f0f86e2036683bd542130b91a98 upstream.
> 
> If the firmware were to report three LMACs (which doesn't
> exist in hardware) then using "fwrt->smem_cfg.lmac[2]" is
> an overrun of the array. Reject such and use IWL_FW_CHECK
> instead of WARN_ON in this function.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Link: https://patch.msgid.link/20251110150012.16e8c2d70c26.Iadfcc1aedf43c5175b3f0757bea5aa232454f1ac@changeid
> Signed-off-by: Nazar Kalashnikov <sivartiwe@gmail.com>
> ---
> Backport fix for CVE-2026-43172
>  drivers/net/wireless/intel/iwlwifi/fw/smem.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

This breaks the build, how did you test it?

thanks,

greg k-h

