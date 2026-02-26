Return-Path: <linux-wireless+bounces-32194-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAKDIbjEn2kRdwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32194-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 04:57:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591241A0B88
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 04:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03773036382
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B699F3876DF;
	Thu, 26 Feb 2026 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBRJ0YwT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943EB37A490;
	Thu, 26 Feb 2026 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078255; cv=none; b=tRkDcSlhwQpploAOnp4v/V8h9DED0Dzfn1H4QkHVEUp/MAxGfM9JcDtQ0FQGJ2WLYJ1UdDS564/wfxQzAjGahF9ZmTyl3YCOg6X8mg/pkZgXL5C6rrNthz4LvVzS1iqLt/g/Ss9tid/KawygXgjWoXyZGxOD4qgo0oaNl8PU5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078255; c=relaxed/simple;
	bh=i0sp9WLqxzYgI0+UUA6dgpyWXFQmjqb62PqojjSSXEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nu/o+Z461gDOL8ghbBP+q2jcMWIzJlkao5qrESAzd0Pf7mnCHGk8c4dftnmy/z+IlwetgeHekyUE+cSqqgSQLY3BMWJX4Ax3cULZWNWiGOxukBo9tld4NVh/Ig3UWK6tjizR4y9YicewL2kc/spRkx0lJl2HTnxq81HJElogCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBRJ0YwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056C5C116C6;
	Thu, 26 Feb 2026 03:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772078255;
	bh=i0sp9WLqxzYgI0+UUA6dgpyWXFQmjqb62PqojjSSXEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NBRJ0YwToN6AOXBGFx4gCo0gest+WGqyMNYmtOJAaHkWNYQxDVpO4KIFkEh5BoEa3
	 aumeCRZFSojpP+6a4Y8IfzJm9/P9w7D2j3/ODvC+lbLcU0P2zRF572I2pLy9AjWzTk
	 cjMxTKU/e+9BrjKA55MNfJm+IXZsFWoO1sGMvEtXV9Nn62m5E/LS5jSz56GyYbQziq
	 sxNcjSnL3hUFcnN/XOw1Z+C2l66jDgRHG3wfZhTgRVLOZS+FLb30WLhaUMoiKFrnzr
	 NHx/10UqLBJV2RbDr1wSt7KXFLCnLVG34+MnEpYj/duEE68vDqOLWZdzl0LwPCGkTW
	 CzG282HcbbOcg==
Date: Wed, 25 Feb 2026 19:57:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-2026-02-25
Message-ID: <20260225195734.1d789102@kernel.org>
In-Reply-To: <20260225113159.360574-3-johannes@sipsolutions.net>
References: <20260225113159.360574-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32194-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 591241A0B88
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 12:30:47 +0100 Johannes Berg wrote:
> So for some reason a whole bunch of fixes came in recently,
> including quite a few (potential) crashes and similar. Most
> even are long-standing issues.
> 
> Please pull and let us know if there's any problem.

Pulled, thanks!

