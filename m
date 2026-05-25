Return-Path: <linux-wireless+bounces-36889-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePk/MNqjFGqXPAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36889-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 21:32:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1F05CE086
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 21:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E749F300683F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1B930C164;
	Mon, 25 May 2026 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zfy2oeke"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282A7E0E8;
	Mon, 25 May 2026 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779737560; cv=none; b=eix8QHl1mTdtiE6vsK6BzxyXwnWnD1mhDauICDf3z8tOK3V8wfCQ6gzGHUltk0gislhlaCzA9YEEOP1Ij3Tvx2HnrJuR0wLe51i05qVsGjbAxrK6MenLQpkbOozpjJ/mIglDSft3zWWXUhDqxG/d5A7tU4d9qFlE4U/rXSPyxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779737560; c=relaxed/simple;
	bh=qSmHp37VOdyX9WwozC4h7eTDtPYsaq1XUGZgGIE7NwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Via4mk7Kixhhg0HKDaK6gqwrqSarlo5LxSgHNycH/Sz3LASacO24a+n8LUYsgAhW4xLi2yQs8quAvbii8GW9JKIkjMBe41Kb5eZDSp86MVHOI/7HZ0OmnPLymr45ObX9sHNd4aDWe0JckyuHwwCG5ptjXpqFr3I94XuS8zlhNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zfy2oeke; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FB41F000E9;
	Mon, 25 May 2026 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779737559;
	bh=rs/+k/SNcrNdjiAQ3Szs2C/gb9LuRbjuh5plxoql5i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zfy2oekesQ0LB4glrPw2TR8NFwD/QDGLnLBbXA10Acok9KZh8LAOn+f1sJ2ONBSGI
	 sxO9CpbP+2Ib/40CH0mDCjr+22IkiC4YTzjW5gHYXMZznuqCWSmgbpNYf6zmGwzjyI
	 rK+6Yk68GPdI8J7KYDCZINDrmDKIYE6Lm/mfSBp0=
Date: Mon, 25 May 2026 21:31:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, driver-core@lists.linux.dev,
	johannes@sipsolutions.net, wenjie.tsai@realtek.com,
	mh_chen@realtek.com, charlesl@valvesoftware.com,
	sabae@valvesoftware.com
Subject: Re: [PATCH v2 rtw-next 1/2] wifi: rtw89: add dev_id_quirks to
 driver_info for per-device quirk control
Message-ID: <2026052558-handclasp-garden-b472@gregkh>
References: <20260525085148.35180-1-pkshih@realtek.com>
 <20260525085148.35180-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525085148.35180-2-pkshih@realtek.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36889-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6B1F05CE086
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 04:51:47PM +0800, Ping-Ke Shih wrote:
> --- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
> @@ -73,6 +73,7 @@ static const struct rtw89_driver_info rtw89_8851be_info = {
>  	.chip = &rtw8851b_chip_info,
>  	.variant = NULL,
>  	.quirks = NULL,
> +	.dev_id_quirks = 0,

Why are you manually adding a "= 0" for these when that's the default?
No need to do so, only do it when it is set to something, right?

thanks,

greg k-h

