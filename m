Return-Path: <linux-wireless+bounces-12020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D989602F9
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB661F21C13
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B964414F9FF;
	Tue, 27 Aug 2024 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sI/9j7bI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381834CDD;
	Tue, 27 Aug 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743519; cv=none; b=CzrquXABso3RufIaC+O3CIHr9+cl0kxVSrkCOdwVyUZIsx/dfUSTy6+sV0sf1a7RB9x/J456RSPGtUXk7FDwAwJq5qSXSyhMX+avGCdBCxSpn2cX+jyvdqv61sVLZv0Zazxm5oVIDrjGqB2B48cP2zT/Fz7R3hiLJA9tUROwvdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743519; c=relaxed/simple;
	bh=lFu8Xy0AadSA83deTBUNRaPIxmGztI0Kt/toGETt0Vw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2Bw9IwP9N2ALT+WoL0Sth3ooSvbFwP9ANDKlrpldlOnwxVlIk5TdmDIR81Kg8xD15pbRs+o/YtK7gULRCw557Z5JRWaqhOh8QVzdfmDMlJa0MzqriQLSyLUozoGqNUIODVEpON6IajdRddDbtYhgeHY5XlXBWdtVaWFQVKAp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sI/9j7bI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ouPPEsM5lFbFHUfqqzQ96D0RrlBvg+Eh6eaOM1zINbY=;
	t=1724743518; x=1725953118; b=sI/9j7bIdvIYkRuZJl5xv9XYgG1OezEtArmExCWDbyERNlF
	7QetUpeZF0RXhkKKxvN4ILgWf1qBRv8rO03SmtJbsCczSjptuTQuzzhhLhju4LYQ56kGGCJWYAI57
	1pRx0Z+wUZQinVaQLV9NNqkUVWm1dAsy9i7t0Jmvb5r3+DRwJFgK65bnlK9Qr7hSHZnu2f69jFl+9
	aVsZHq8eL5ly/0Qm3SHS+m8NOrazMGGTJqtiK9WTxu74Uv0Hb5KLsRsU42M36iLkRK5BLtEawnKzu
	Uca7qnczom5pikMo22Rxwa1hpfTeiQoXvMoWR4wu7JXuSPegsmv94TqQB3SXodIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1siqZf-00000004PMq-0lpI;
	Tue, 27 Aug 2024 09:25:07 +0200
Message-ID: <d5f495b67fe6bf128e7a51b9fcfe11f70c9b66ae.camel@sipsolutions.net>
Subject: Re: [PATCH -next v2] wifi: mac80211: use max to simplify the code
From: Johannes Berg <johannes@sipsolutions.net>
To: Hongbo Li <lihongbo22@huawei.com>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, pabeni@redhat.com, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 27 Aug 2024 09:25:06 +0200
In-Reply-To: <20240827030302.1006179-1-lihongbo22@huawei.com>
References: <20240827030302.1006179-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-08-27 at 11:03 +0800, Hongbo Li wrote:
> The following Coccinelle/coccicheck warning reported by
> minmax.cocci:
>     WARNING opportunity for max()

Yeah well, maybe sometimes we shouldn't blindly follow tools ...

> Let's use max() to simplify the code and fix the warning.

You should explain why.

I think only one out of four changes in this patch is correct,
semantically.

johannes

