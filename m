Return-Path: <linux-wireless+bounces-39155-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VbT4BIyWV2ovXgAAu9opvQ
	(envelope-from <linux-wireless+bounces-39155-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:17:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6999275F440
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:17:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dolcini.it header.s=default header.b=qXOfj4L9;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39155-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39155-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=dolcini.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E155301D32E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589DE225413;
	Wed, 15 Jul 2026 14:17:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D15243376;
	Wed, 15 Jul 2026 14:17:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125063; cv=none; b=BK0gmWq4e+JrAAMtdpQz0VgN2dJ67t4FP9rgpXmW/slq/hUWIl+XJjAUqh1QU94AWUaGsUSCiLWmxyHd2HwYqTFx6NJh4Je9vgf7t2njgP0a9gY91FNQrtJoHj4AqM/OmUeR0AhM8R4KX41oBHKuMYeQhlAegpi2pamgbJqhM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125063; c=relaxed/simple;
	bh=eUsxV9weROURKJhWM7sZwb363sk5RJ6P7JOi+awgSAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKl//EMkhm9ULOSZtAap6KWStJngDy9hRYio08oYRyvSu/V/3/e0YqRE4Oz2xiOY2QM3FJmeJZrXBHXJAs64v4DwCz+qQEndXxwUNdCgnpkPPzBEawJf/uuy6pQNazonEjK8bk8CENOGTrUYCQ/4eTL8d1X5v3KkuFpfEsh0Sb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=qXOfj4L9; arc=none smtp.client-ip=217.194.8.81
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id EB6F42231A;
	Wed, 15 Jul 2026 16:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784125059;
	bh=RjDzoNblLRiJ5ZY8XoYVhbx1+13946VqvT4TZc/ReNY=; h=From:To:Subject;
	b=qXOfj4L9g0w0KlJpa9AcOx+AgttUdP7L3kISiZmxEKsGSxGrX31jGEOV3F0U0Vi9Z
	 RHYjKUtCJpLlk9BH1s703GiGPZ2APbolLGqY8kkXIUzafPK1mgaH/WyKrzHJpnwzA3
	 HEw8ckkf03XiQsZqLTXNR78C6a1cW9Y79J6Axcgg1X8pAxvntDocZskxAFnmqqbNUu
	 8QNEQLCCGZEJI6bGurfb+oBKWauXbkonlCZNRjk9L7PDPBh1533ImzoxMnLo7mIayz
	 pNpkuMCNtnR/toEG4O/ODAPRbYr7g8i52+52Q2htqe9loOzwELH79Z1qAI23ISngpX
	 SCmNm8eMjj3XA==
Date: Wed, 15 Jul 2026 16:17:37 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: validate scan TLV result arrays
Message-ID: <20260715141737.GD56330@francesco-nb>
References: <20260706092654.79403-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706092654.79403-1-pengpeng@iscas.ac.cn>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-39155-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:briannorris@chromium.org,m:francesco@dolcini.it,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,dolcini.it:dkim,dolcini.it:from_mime,francesco-nb:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6999275F440
X-Rspamd-Action: no action

On Mon, Jul 06, 2026 at 05:26:54PM +0800, Pengpeng Hou wrote:
> mwifiex_ret_802_11_scan() indexes TSF and channel-band TLV
> arrays by the reported number of BSS result sets.
> 
> Ignore TSF or channel-band TLVs whose payload length cannot provide one
> entry per reported BSS set.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Was this tested?

> ---
>  drivers/net/wireless/marvell/mwifiex/scan.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> index 97c0ec3b822e..7416756ada3b 100644
> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> @@ -2165,6 +2165,15 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
>  					     (struct mwifiex_ie_types_data **)
>  					     &chan_band_tlv);
>  
> +	if (tsf_tlv &&
> +	    le16_to_cpu(tsf_tlv->header.len) / TSF_DATA_SIZE <
> +	    scan_rsp->number_of_sets)
> +		tsf_tlv = NULL;
> +	if (chan_band_tlv &&
> +	    le16_to_cpu(chan_band_tlv->header.len) /
> +	    sizeof(*chan_band_tlv->chan_band_param) < scan_rsp->number_of_sets)
> +		chan_band_tlv = NULL;
> +

If something like that happen we should return an error, and return from
the function

a few lines before we do

	if (scan_rsp->number_of_sets > MWIFIEX_MAX_AP) {
		mwifiex_dbg(adapter, ERROR,
			    "SCAN_RESP: too many AP returned (%d)\n",
			    scan_rsp->number_of_sets);
		ret = -1;
		goto check_next_scan;
	}

why not doing something similar when this buffer from the fw is
corrupted?

Francesco


