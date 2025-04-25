Return-Path: <linux-wireless+bounces-22080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0391A9D044
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF85B4C333E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B0215F5C;
	Fri, 25 Apr 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yRQ3/tSM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EC215766;
	Fri, 25 Apr 2025 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604689; cv=none; b=BqV4NziIjitIc8ZnpRjckGzN+UdRPReh04oSffI2WzclQ/uBOHpbUaAuZGnfNlmwR3SCCl2G5GilG7yH4XP6OUToabFxIhmpGoNfN30bD9PhSACTd9gsaNd3tOS1FqLe1Yu+9M2aIZDgBXfiCdebPOifvvBwmMzrqC8mz2sP5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604689; c=relaxed/simple;
	bh=AcQ06o3liKLfIzDuJGETHa8EaWX8bopIoU8BfIQJTIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tVcJHm8Y38T62HY5t8niSyrJ7nIXX0uYkTpbsYAN93jrAT//kIPPEvaeBDfFTVSrEwkCW4bUqgjLyGZ3EgLjTC9CAqxSoiRxZ1abJ1s9rxsnwZOHx+2+09tt4dzAvlMF4FcRQKloyjUZMTZ18M30eYF14iitwWw7OF1s7jvPnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yRQ3/tSM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aY55hDS7Z/BNIFuppzqO/uQ5XIZa82l2hzhC8Y0TibY=;
	t=1745604687; x=1746814287; b=yRQ3/tSMqWpEbmhYwhRCAIRioStPW2rKKBMW7fKi7+ZcSOs
	vBG6WzcFqut4KdA1Js6X9N/oGw8b/qEXWswG+94pNl3DeOdYMrM2id+VV4HLY4gGFSso3EFYAn7UR
	dMESjxqBRJjmQI45jE2O9qeDimhvUVE4220SdEqwKh3jH2SQbcu/Bl4TvfEC2KGDNf30NvtxX/TeS
	xLnnEMgp3r6v3mI5qEWgTYTmo37jUULOhtonQv11G7X1/mpIRu/N7M6lfDlDPZkzSHgPu5eCr2TfP
	Xqo7veQvgr1VtdnzSnDHj0mmccqb9FYwz0Z2QY/NHvaq3KJACr9fmHLhIsrm133Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u8NWF-00000002FhA-3yCP;
	Fri, 25 Apr 2025 20:11:24 +0200
Message-ID: <4854f6a248fdc501d4157339fdb21f9a3ca3097d.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 0/2] wifi: Nordic nRF70 series
From: Johannes Berg <johannes@sipsolutions.net>
To: Artur Rojek <artur@conclusive.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood
	 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer
	 <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Klama <jakub@conclusive.pl>, Wojciech
 Kloska	 <wojciech@conclusive.pl>, Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Date: Fri, 25 Apr 2025 20:11:22 +0200
In-Reply-To: <20250422175918.585022-1-artur@conclusive.pl>
References: <20250422175918.585022-1-artur@conclusive.pl>
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

On Tue, 2025-04-22 at 19:59 +0200, Artur Rojek wrote:
> 1) Nordic gave us permission to upstream the firmware blob [1] required
>    to use this driver. As that needs to go through separate
>    linux-firmware repository and is subject to different licensing,
>    should I try to upstream it in parallel with this series, or does it
>    need to wait until the kernel driver gets in?

I have no idea. Chicken and egg, I guess.

> 2) In AP mode, for each connected peer I maintain a pending queue for TX
>    skbs that can't be transmitted while the peer is in power save mode.
>    I then use a wiphy_work (nrf70_pending_worker) to move the collected
>    skbs into a single hw queue once the peer is able to receive again.
>    This means there can be multiple workers putting skbs onto the hw
>    queue at any given time. As this scheme relies on the wiphy_work
>    workqueue, can I assume that multiple workers will be able to run in
>    parallel, even on a system with a single CPU? If not, what would be
>    a better solution to the above problem?

wiphy_work() is fully serialized regardless of the number of CPUs, it's
guaranteed that the wiphy mutex is held for the work execution, after
all.

johannes

