Return-Path: <linux-wireless+bounces-31226-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KILyF8K4eGlzsQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31226-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 14:08:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D71EE94A9B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 14:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A5563012274
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1309D2FE598;
	Tue, 27 Jan 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="o+q97kcq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5533554B
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519247; cv=none; b=Nwk/sJ8jQBYRqGgmxgbp3S/Q+pT3GOTvTjWwskKSnW2Br8eSgmMqEvdee8bmzSBbYR70CSDV2jr/2dfc8ss3h6Psln/wF9/oe0IzLZI9deH8Qam7PHy0GswlLSPFlmFaj5amQTtTJNdy2Jpap2dy4her/8iqgXfC+Fdt2wGjiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519247; c=relaxed/simple;
	bh=Q+vYmEyrOVtMWt0emvclk0q8208EBo6N1K1fSN4c0dI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNY00Nb2erCPHS5j6D3qItxwKGjkmoWN5gmXSHzhMwqs+O07NQaYU/MZ7zUkHzgkpVd+sevm+K4zxCkfFihY3QxZHsbw6RTOwTyCVejGqyCc2SweeU7Of/6IqoJtJj3LEJR7oFMxlKoE6PWzOdYFyrVc8yQXE8LNBAnrZNHwPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=o+q97kcq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hkD4L7L4Y6XmO7kDRoNZ5kNYkY2APBYGUGnB5ufnZ5Y=;
	t=1769519245; x=1770728845; b=o+q97kcqlW8g7/GPEmxhEEoKp2GCVAAc4WM9LOdSjmqwTyL
	ycdUDmnl8mCXv3gV5cBsYbmQ4nYKsO7GFcmDecREiqhxL9TICcs8O/JKPD5KNSAQmUA0cUGr8vURj
	EoEuG9WDNDXSqzcVveSz0AlJaWggj68xfLqwE7uXg45dMTnKGhR4V6LkpMSDLEpvzYbH8T+2NkIrk
	t38jgMqedOstsYQTV/FOfLhDfO/8zSdcOlJO6v+T6iQV7YBn5RSTEub3SHDKp3BOKncQAKerMwRZY
	Y5bwvCN3oHMAIFfFCWUP1rqt38NEQ9DmfAbHMpV/pscUUP7XEwQcn9IblpkVTw/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vkimx-0000000504S-20F0;
	Tue, 27 Jan 2026 14:07:23 +0100
Message-ID: <f19edf136407e6e4ff46c58e5497424538304cef.camel@sipsolutions.net>
Subject: Re: [RFC v5 wireless-next 4/4] wifi: mac80211_hwsim: background CAC
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Tue, 27 Jan 2026 14:07:22 +0100
In-Reply-To: <20260125160353.34102-5-janusz.dziedzic@gmail.com> (sfid-20260125_170411_232795_78492DFF)
References: <20260125160353.34102-1-janusz.dziedzic@gmail.com>
	 <20260125160353.34102-5-janusz.dziedzic@gmail.com>
	 (sfid-20260125_170411_232795_78492DFF)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-31226-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: D71EE94A9B
X-Rspamd-Action: no action

On Sun, 2026-01-25 at 17:00 +0100, Janusz Dziedzic wrote:
> Report background CAC support and add allow
> to cancel background CAC and simulate radar.

It seems that perhaps this should be optional, so that we can continue
using the existing code paths too?

> +static ssize_t hwsim_background_cac_write(struct file *file,
> +					  const char __user *user_buf,
> +					  size_t count, loff_t *ppos)
> +{
> +	struct mac80211_hwsim_data *data =3D file->private_data;
> +	size_t buf_size;
> +	char buf[16];
> +
> +	buf_size =3D min(count, sizeof(buf) - 1);
> +	if (copy_from_user(buf, user_buf, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] =3D '\0';
> +
> +	/* Remove trailing newline if present */
> +	if (buf_size > 0 && buf[buf_size - 1] =3D=3D '\n')
> +		buf[buf_size - 1] =3D '\0';

Perhaps simpler to just do buf[...] =3D {}, return an error if count >
sizeof(buf)-1, and then just copy?

> +	if (strcmp(buf, "radar") =3D=3D 0)
> +		cfg80211_background_radar_event(data->hw->wiphy,
> +						&data->radar_background_chandef,
> +						GFP_KERNEL);
> +	else if (strcmp(buf, "cancel") =3D=3D 0)
> +		cfg80211_background_cac_abort(data->hw->wiphy);

I wonder if this could be simplified by using sysfs_match_string(), but
I guess that'd require some enum or so and then isn't really worth it.
Surely though sysfs_streq() could be used instead of the manual trailing
newline handling, though honestly I feel it's kind of pointless anyway
since the user can just use "echo -n" instead of "echo" and not _have_
the \n in the first place :)

johannes

