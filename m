Return-Path: <linux-wireless+bounces-18490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BF1A284EC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 08:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFDF3A6AC4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CF52288DE;
	Wed,  5 Feb 2025 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hgpyXItA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F362228387;
	Wed,  5 Feb 2025 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738740386; cv=none; b=nEoYccG6U6Qz5KHsyjbU6Un5HlgwCc0CovSEsiF1gQ67TzS/xftatWGavhFbQKFfXWusDnmv1+lY4h9KxBvFMrepgrsLXD2PMM7bT59p27gjxDX1VbXRGshcN9//J4vqoFp/FzFJk8WahRCVD6RpxukLPI52fX8HJxdHZBbn7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738740386; c=relaxed/simple;
	bh=ZXw3cZSH5PWK8y3e8y6gpVJYCFx9eZq4tClHzqdTihU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZKtDmHvf2uwXXZR+sm1tV1oDXL+aPgyOJ78hTE2EX9tc0UprKNRJwodWwggjWVZX41rrxwXD2eAAyFMP1E/4wBwp4eCPMSEl80jOBWRgAmxMXveAyQuTXpuUj4yIlYsRXEBv1MwOo0QHLC5scz3bFCCJWeQ9227pLO19IN4JGso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hgpyXItA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZXw3cZSH5PWK8y3e8y6gpVJYCFx9eZq4tClHzqdTihU=;
	t=1738740384; x=1739949984; b=hgpyXItACWjLpf3R3ZkeMdepWGNWTsrdbficyuv3Ss9gCws
	tXUipL++mYakGcWMMdpGJRXfypSVTs1qID+O74hRLytMgzD+CmRPtbLmaGbRZItp3wyS/pNGyTI9P
	npee74JC1AQrqhURLWdxFsHdrzsNsGcGz8FkgtgdsBHketCYY5ohbSmQnZNZ6jaETzEkUu1YmlMyI
	PrILUKkCZthX2fvkTyJAmcmm5Pdjb8kyQlOtQW3JwiaFTqWTy2deYaCkqEU8dGZsnRwixNAuJL/Qj
	F67nW0AwcKrP/LiX/Aep8oipCpkboLajQP8r4wf0ujHky8Fosj/ihNF/PFfroPuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfZnA-00000003gM4-0j6f;
	Wed, 05 Feb 2025 08:25:50 +0100
Message-ID: <5d70ec0708ec351efb530a53f0a2c6ad0503bcbb.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] net, treewide: define and use MAC_ADDR_LEN
From: Johannes Berg <johannes@sipsolutions.net>
To: Uday Shankar <ushankar@purestorage.com>, Breno Leitao
 <leitao@debian.org>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=	 <rafal@milecki.pl>, Simon Horman
 <horms@kernel.org>, Andrew Morton	 <akpm@linux-foundation.org>, Jonathan
 Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org
Date: Wed, 05 Feb 2025 08:25:46 +0100
In-Reply-To: <20250204-netconsole-v2-1-5ef5eb5f6056@purestorage.com>
References: <20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com>
	 <20250204-netconsole-v2-1-5ef5eb5f6056@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-02-04 at 14:41 -0700, Uday Shankar wrote:
> There are a few places in the tree which compute the length of the
> string representation of a MAC address as 3 * ETH_ALEN - 1. Define a
> constant for this and use it where relevant. No functionality changes
> are expected.

True ... but is "MAC_ADDR_LEN" really an appropriate name for that? Just
plain reading the subject, my first thought was why you weren't going to
use ETH_ALEN.

Would seem nicer to me, at least, to have something indicating a
*string* in there, e.g. MAC_ADDR_STR_LEN or so.

johannes


