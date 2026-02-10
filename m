Return-Path: <linux-wireless+bounces-31695-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPF3LCYPi2l/PQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31695-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:57:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14815119E52
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A9D93039CA5
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 10:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F4360728;
	Tue, 10 Feb 2026 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GArKpJM6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B235E52C;
	Tue, 10 Feb 2026 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720900; cv=none; b=ldv7i3FtteLEczVuTBY8ZZGId2GJIDfXJpVZ1MyzNCcXvMviFirF4OJ/frdXu2d9Up4nJjIRqYE3bQBxKUUy1Cdu4Ly5njEZiuChS3Z8Sb7sIG2YC4rNpAj/+8eICPWz0ajuViDSZMdg9jrpus8QM+JFZoZx2rA4snEKwxJjXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720900; c=relaxed/simple;
	bh=ZIK1MxjudP32lWOlB2eyVrMNznSDmLrXc0BUkpOoyxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpKzJTpfb4sontraykqUvr25xxxyGitpOJw4VgadZsf5byUGrvKwR0WQOiXEgRoIsOr8Pj02HvteXpW6qZ7pAhZeRSl8+1uWT/mRnBcBz6iX5e3FakTU5DNuJwoHUyjjx7U3MA6JQ2nTKffqYY8s1SgQ9I024fwC4uTiWJxDq9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GArKpJM6; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B83F31FAC8;
	Tue, 10 Feb 2026 11:54:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1770720895;
	bh=i7vjOxZcvQGRYbjLfjHw2wPyqczQ5W6rO2/7Y8aFqpA=; h=From:To:Subject;
	b=GArKpJM67bTdrx08T3nU/MQLm4lC+9B0/zUtTmv3bV3PsqiQkHbcHFqvmM2j8mCtJ
	 0TsIbxF9MiOxnzqyWGtxk7FvyqNO4K/RnRCNLwtOmNTjsB7RsmMkJA1iN0/B+nuBaw
	 /VZ7PYVdXbtLkOyz8ilfaeTvjxCFHdLfOT/awkLwCK3Izcp0OCHIty3dG3hClrUh8B
	 A00JrPVhiweYUTweSstOuTUQJXzE38GLOUu9wD7H4NbRxAsf4PgIOgENUYRHssqBcL
	 0CXWHU76RyQjbSIdCKVmYjalqEiDI2B8uY8DBAZC7RytMD6y4brlLHks72IgZrvJzd
	 GsQcKGtIfx0cw==
Date: Tue, 10 Feb 2026 11:54:53 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] wifi: mwifiex: Fix dev_alloc_name() return value check
Message-ID: <20260210105453.GC214446@francesco-nb>
References: <20260210100337.1131279-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210100337.1131279-1-wenst@chromium.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31695-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dolcini.it:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,toradex.com:email,dolcini.it:dkim]
X-Rspamd-Queue-Id: 14815119E52
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 06:03:34PM +0800, Chen-Yu Tsai wrote:
> dev_alloc_name() returns the allocated ID on success, which could be
> over 0.
> 
> Fix the return value check to check for negative error codes.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aYmsQfujoAe5qO02@stanley.mountain/
> Fixes: 7bab5bdb81e3 ("wifi: mwifiex: Allocate dev name earlier for interface workqueue name")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


