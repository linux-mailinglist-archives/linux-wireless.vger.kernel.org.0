Return-Path: <linux-wireless+bounces-26693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5DCB37EFB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 11:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E401BA4253
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5793431FC;
	Wed, 27 Aug 2025 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Rm9oVbhe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFAD279324;
	Wed, 27 Aug 2025 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287423; cv=none; b=mt6xPo3qJ8h6ZZOlSl0Jgi0Eo/M0FROtFdFkKimNkGJ1DicWLDSku9jXdcIZL/rtriuxF2qs4wOaL9p6dFf9zK0DnuQOP7KR5BqoYxZKxKuA2sXZBn9+16uBLlmIIFoYhePSiS1ZVkDXa7Te1wJotgrf17TOhuDpUqAA+OJ/9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287423; c=relaxed/simple;
	bh=qdPbayitjWUO7btP9BcKFqJauAQzvLr/f26usdfMC4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F0fUn0Mlnu4iK4rmIIyB1xxDtaE6ZZra7UT9HbVtC6TqfD97I3dGt/kOjJBkvMaBsTI0CUlrAPWVPmbHUei4kNWIivLZSVeUQ9P2AFvWlsrmOMKUxNDq0DOMjurrs5efmS8CBO7jC42YL+uQaUNzgxxF4uji53+ll015alfFbL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Rm9oVbhe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qdPbayitjWUO7btP9BcKFqJauAQzvLr/f26usdfMC4o=;
	t=1756287422; x=1757497022; b=Rm9oVbheXw+1Bm1ZKigmOiJzDOoQGP5XSxFjPRZJmbA0PK0
	+OiBv/ScN92ZKOu3BMlN7lSg75FFZ6DwBTo/9qCXvnUPLCCGUpxG361QN8gSQoEHXFsdvXCqcNCk1
	gZ9wZA9DDErfM+gSAy84jrVaS/GFYc1wdx6ddyvLzms1Quh2Ko8L/2nmnP3BcQYbhfQRH8pYxceZH
	qGgwKJGKmSMoBh70C5Ai/BUAfcS+3nLWVmMztnSW0Re+H3+W1hM+DId/v4qZ/pgYR0JW0Bva8/Qe5
	gk++d2kYmLvt/ApPEYLKkIfOzFaVPkIKNdXgUWlE8sxuLYFrnPRmKnjNmuN6a/fQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1urCaR-00000005MRO-1CT6;
	Wed, 27 Aug 2025 11:36:59 +0200
Message-ID: <0ef7587b7ae57d9363312ca130980707a68a3f7e.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlegacy: Remove unused structs and avoid
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva"
	 <gustavoars@kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Wed, 27 Aug 2025 11:36:58 +0200
In-Reply-To: <e0aeda2d-931c-49c6-b0d4-dd097e87eae6@embeddedor.com>
References: <aJl7TxeWgLdEKWhg@kspp>
	 <e0aeda2d-931c-49c6-b0d4-dd097e87eae6@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-08-27 at 11:25 +0200, Gustavo A. R. Silva wrote:
> Friendly

I contest that. It's been two weeks, while it's still summer with
vacations etc., not long after the merge window closed, with weeks to go
until the next release comes around. Why are you impatient?

I will take it. Eventually, the more you push the less I want to. And
it'd help if you actually followed our conventions and used 'wifi:'
prefix.

johannes

