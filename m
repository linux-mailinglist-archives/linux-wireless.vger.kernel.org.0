Return-Path: <linux-wireless+bounces-31445-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG7yJQNngGlA7wIAu9opvQ
	(envelope-from <linux-wireless+bounces-31445-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 09:57:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC84FC9D6E
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 09:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1BFE300331C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 08:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7C2BDC35;
	Mon,  2 Feb 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kdbA89mX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343971514E4
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022528; cv=none; b=imbo32i4ju1MT7r7xHBG8eMlnxGtaxnfpI5MC0shmembrLTewu/GHmL42JBZYSZqEJzLg9NxkKOPwXPBVnU0K5sbO134KgYTg6VbU7rWNMeLV6tid6LLBc8c443wDeOPBlZCIltfZjrmjRt8v8DhsaniwwOjIHmZ6s8sBeF7jrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022528; c=relaxed/simple;
	bh=q3XedcE8sjsrBAE/qVbFdaNhMs8tAhh4KyA9hSsmp3A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b30yFuIKnRQk1+mnh7zKcu/d58mAwvMGw0HiI/v0oRfMjOZ+BRZm4SUolhxU8eLkAXw3gLwAuvVUe7FnSOmwdCV44awpXVWIyGYmwE3b8r13aCS/AWpAM6iRYIvBhPqbe1UE8jAPk/A0qBpk+0Wt3wfVPDjpAYscC0MfZwSQmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kdbA89mX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=q3XedcE8sjsrBAE/qVbFdaNhMs8tAhh4KyA9hSsmp3A=;
	t=1770022527; x=1771232127; b=kdbA89mXDcCqNDTCU9y7mRvwbxbO5oFhk3IzymPgZH1N3nC
	zqkIfZWULzFUXWYRvK2gfsPcYH9WPmzgfPAjW10QlrYRx0Z6GpN7v7vnVm3dlP9CZLzgfSnSHuaPH
	Ue4AydI1nrULNxoaciLEKHftSIHfzw/Ji+1xlyQagpC/4MkkTxRIKfUYDL9eMrG5Fc6srlpV3snr8
	KXOz6jegOieurT0zHwU5hyGPDOvSHtLbqNzVR+r+evdX6qkOq37xn7T0Stgi1UFeGeZg39rFY5clI
	OSptSfzVRWqFJ9lo+u/sI5QAaiZ6AkpOWRqtEVf8eZbMLABHLTQPHtiFAmLDh/sQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vmpiO-0000000BO0b-0mA1;
	Mon, 02 Feb 2026 09:55:24 +0100
Message-ID: <3b572ea74d648cb54a1712e2bedc23a07c827876.camel@sipsolutions.net>
Subject: Re: [RFC v6 wireless-next 4/4] wifi: mac80211_hwsim: background CAC
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Mon, 02 Feb 2026 09:55:23 +0100
In-Reply-To: <20260201161836.16506-5-janusz.dziedzic@gmail.com>
References: <20260201161836.16506-1-janusz.dziedzic@gmail.com>
	 <20260201161836.16506-5-janusz.dziedzic@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31445-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EC84FC9D6E
X-Rspamd-Action: no action

On Sun, 2026-02-01 at 17:15 +0100, Janusz Dziedzic wrote:
>=20
> +static bool background_radar =3D true;
> +module_param(background_radar, bool, 0444);
> +MODULE_PARM_DESC(background_radar, "Support background radar/CAC");

Do we need this as a module parameter? There's a general pushback
against those and while I guess it's not going to be _impossible_ for a
test tool, we are going to have to justify that...

Either way we should have a netlink parameter for it, which you didn't
add, but I think we can also just not have the module parameter then.

(Also, maybe at this point time to stop sending as RFC?)

johannes

