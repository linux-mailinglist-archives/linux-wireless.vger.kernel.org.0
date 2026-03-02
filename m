Return-Path: <linux-wireless+bounces-32344-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB1yELZIpWlj7wUAu9opvQ
	(envelope-from <linux-wireless+bounces-32344-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 09:22:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 966951D4941
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 09:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3EFF300A8C7
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 08:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1F0375AD1;
	Mon,  2 Mar 2026 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rTqEFYsL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A873644C1
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439731; cv=none; b=ujpdGSN3k1ndYtREmLpacALksi3xdqg1JrqfUT7AWmJbDUkBeqfHgn4UzXAwN1VMI2rK8E5dcD9dkAvMmZfshecvPGtfcGQltj3eUWgXELz4sjC7zCMvtx8uRsP6KXtLLFAze35bHZPa31TrNedUaPHV2FVNynO25URGdHl/FfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439731; c=relaxed/simple;
	bh=BI+G5u+eD5lLuWlGrngLWW+ZyNh2kFX5p/rO5G2xIsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mui+m6vfZ3U5P6gpi9dWaf9UfhWJh4FL5wxjADadNw9ekrY2V1vZ8yumxl6z8gN61JZP1kwivbOlpYqvkcSZeHciiX0bLTMCP9SMPQcTcavCc7pT1PRuA6pULaiyGP+Jj81EBcRruIEqypgHpnEF7PjrhjPABsMFsawdTWzOB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rTqEFYsL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2NmqQrdJS2CKP3hU63iyds5UHLT4KbCHh5Pa2shd0Cc=;
	t=1772439730; x=1773649330; b=rTqEFYsLfNvSkVKU2w1Ef9pgRmrNCZn59XrYl341MhwFhAR
	iLBO7FvIJr/NK2dbze9tI2OMQhj4rzD3E7Xanw1IbpNfI3jJGxl+6yZPdfE40J3NPcUAuppP6XdkQ
	Fv75wQr5VQQR2Xq1d08dHJusH6ygTk40RN0vKV/hshqS0TseOARSH6DtqtQK+7oJ64D1OLVhHRhPj
	ma6wKR+T3Os0FgzP5amDLbPGFiUjsh3Hy8nl06I4hATFwiRY8jx3VP+M6AuHsGLvSDqp6gmVA3tud
	tL15tn/zCA67mXAcvQu0v7KUgLO6KI8v7DaA1Xy/GhUtu99+Pt6dIDlh/j6KIn8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vwyXW-000000061CQ-1fLh;
	Mon, 02 Mar 2026 09:22:06 +0100
Message-ID: <f33a53b5de9d5c04328c40307b120e77b81ab03c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v5 2/2] wifi: mac80211_hwsim: add
 incumbent signal interference detection support
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <amith.a@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Aditya Kumar Singh
	 <aditya.kumar.singh@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 09:22:05 +0100
In-Reply-To: <20260216032027.2310956-3-amith.a@oss.qualcomm.com>
References: <20260216032027.2310956-1-amith.a@oss.qualcomm.com>
	 <20260216032027.2310956-3-amith.a@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32344-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 966951D4941
X-Rspamd-Action: no action

Hi,

FWIW, I'm applying patch 1 of this.

This didn't apply now due to some overlap with the radar patches, but
that's not really the issue.

> +static ssize_t hwsim_simulate_incumbent_signal_write(struct file *file,
> +						     const char __user *ubuf,
> +						     size_t len, loff_t *ppos)
> +{
> +	struct mac80211_hwsim_data *data =3D file->private_data;
> +	struct ieee80211_chanctx_conf *chanctx_conf =3D NULL;
> +	struct hwsim_chanctx_iter_arg arg;
> +	u32 freq_mhz, bitmap;
> +	char *sptr, *token;
> +	char buf[64];
> +
> +	if (!len || len >=3D sizeof(buf))
> +		return -EINVAL;
> +
> +	if (copy_from_user(buf, ubuf, len))
> +		return -EFAULT;
> +	buf[len] =3D '\0';

If len =3D=3D 64, then you have a bug here. Need to further restrict the
length check, e.g. by using sizeof(buf)-1 above.

> +	strim(buf);
> +	sptr =3D buf;
> +	token =3D strsep(&sptr, " \t");
> +	if (!token)
> +		return -EINVAL;
> +	if (kstrtou32(token, 0, &freq_mhz))
> +		return -EINVAL;
> +
> +	token =3D strsep(&sptr, " \t");
> +	if (!token)
> +		return -EINVAL;
> +	if (kstrtou32(token, 0, &bitmap))
> +		return -EINVAL;
> +
> +	if (!freq_mhz)
> +		return -EINVAL;
> +
> +	arg.out =3D &chanctx_conf;
> +	arg.freq_mhz =3D freq_mhz;
> +	ieee80211_iter_chan_contexts_atomic(data->hw,
> +					    hwsim_6ghz_chanctx_iter,
> +					    &arg);
> +
> +	if (!chanctx_conf)
> +		return -EINVAL;

This seems overly complex? You can init "... arg =3D {}" and then you
don't need the freq_mhz or chanctx_conf variables, just use the "arg."
versions directly for all of the code.

I also think it might be nicer overall to use sscanf()? I don't really
think there's any reason for allowing space and \t, after all this is
specific userspace for testing, it can be made to write the precise
format the kernel expects.

johannes

