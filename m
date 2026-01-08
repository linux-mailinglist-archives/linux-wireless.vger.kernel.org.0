Return-Path: <linux-wireless+bounces-30558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 678BFD045B2
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705AB323D9A3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AC54A4D82;
	Thu,  8 Jan 2026 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Y7UFxxMc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE14A4D72;
	Thu,  8 Jan 2026 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873980; cv=none; b=nk4tAGv6DoTasg/pketUz4tDAMWQpGh9UbzwnCdnvJVBccRLp+PnxkAsCpga9lTMMjWhyeOkYsm9SIf6Na3UP6utQ/qjQAYnOcuaKbJcORD/vUuQyPSYGnIO7IDHY1uqplSvniS8ijN2G88jRXu3X8z7utAHkAMNMeAQ2SFUFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873980; c=relaxed/simple;
	bh=Wr73RokSiv/yECX5WjG/LPaS+/F2DTG8cG8IcbGay5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8+098UazTous4w4s02vCFVShP2qZlwjFkIFHRVcVOvUh9/xIaIkMRYNK5G6z2sT5eO2cb1q0LdOaRtlKrhwKu8NQ8nOuOw0Q8l0MjzCCgsTLXxBOWoQYOVyLvE1HAiiSSJgHmJxpz3m+3QWieIuHHvwDc0ez8HamsP/aPdXGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Y7UFxxMc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Wr73RokSiv/yECX5WjG/LPaS+/F2DTG8cG8IcbGay5A=;
	t=1767873977; x=1769083577; b=Y7UFxxMcR6PYwG+8tr3mf9iq7deKKA8a4H5E3OSw7SYVZG/
	Azlt3JtUBeH7UIoXrl+GWRRKhzZf8B3wo6PN1LLMK7QBjOFogLx3hNuvmeDdBpsIjdoHxiKWbQH/j
	7SHBOGFmzTIl46UKmURiZypZ9GFlx4R1qC2h0VUrOR23LtJr9Wn4h8cb9jGLotyU1b/5k7J0r2Go1
	9N3Tzed4Tr6qSd/0g71Jn0brrug9fMTNUjEGkU3vYVg1iR1xN5JJkyX3mrv6HX4LP8BkKJ6cwatTy
	vI4UaVkP8eng3RUGHdYWV3mTH/fXnhXgu7KQAhcjHRN76OKtE4j+oN88d79SVb4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdomH-00000006U8p-1BSs;
	Thu, 08 Jan 2026 13:06:09 +0100
Message-ID: <2411c0044b97dbab4183c03c18fb3f487f6b8f9f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Fix use-after-free in
 cfg80211_shutdown_all_interfaces
From: Johannes Berg <johannes@sipsolutions.net>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: "John W. Linville" <linville@tuxdriver.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Date: Thu, 08 Jan 2026 13:06:08 +0100
In-Reply-To: <20251223170452.75358-1-d.dulov@aladdin.ru>
References: <20251223170452.75358-1-d.dulov@aladdin.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned


Hi,

Not sure why you CC John these days.

Please fix the subject to be more specific. I also think the cancel
should be during unregister, because drivers would not otherwise expect
callbacks any more.

johannes

