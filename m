Return-Path: <linux-wireless+bounces-30509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE9CFE70F
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 16:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9B053019575
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A93F357A5A;
	Wed,  7 Jan 2026 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="B7zU+UF9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D634B69B;
	Wed,  7 Jan 2026 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797991; cv=none; b=GpbQsJZNJfmDXTFNKb/BX5NZknBPJIEQB0SCuPmKlu5j0gw6HBjxaVrLaB3ccMhMw+mV/OaNeotCp9GjgnEeXxD5ajWGWRomyOSkgbAIL1fkMvzc9zA8SdLsYNlCyjyZLm33Zp6AgfuBdeZFoy9eFfT2rGuvUhW6kHV6+SLmWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797991; c=relaxed/simple;
	bh=GrqwaVxJit4I+3H3NeOdXRRa2eK5ehxcCZyYjmwwaR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAejFc20ruckRWSMQZIgr9zYYKScpjixWo8nm9wjtUWX9wFn+8eZ4iOmYDbWsUIZ5P8xrGoZ1NxvV4EvheDU+JYSjByQPxdWDcScE2iS21uuo94/cBHfAmG//KBZZIfLhxavhmI8Kh1kL1JHOY7kCnEn4SYc2/UF2noRqH6MPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=B7zU+UF9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 29C5D1FCF8;
	Wed,  7 Jan 2026 15:59:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1767797985;
	bh=U+WG1uqp/mIp/jw01xLWkBFkADo2dKW6MLb9zwqaoqs=;
	h=Received:From:To:Subject;
	b=B7zU+UF93+NgfPvU/awOLkcXnG8bGCNBAFS9B8SUUCF25s5e6QK8L5PS7rSgu8XJ1
	 ifkB16yaYydEPI6Ljijcc6MK9KhZEdcKCrqdIt+lzPYqMKMnDdm/PZ4orAm+rJV78m
	 pB90Wo+mSJCf/yC03DK7Bpmewq2aXimVMRT+roU9cy/6gBg531VvFakT+ByWn81Sz6
	 CK0NObXvE4TBKnLKcFVKfPXlku51IpX9V7XMv2RCnXS3KQB2zIIQaYvz8/4DLGX5JY
	 819j6F6pB5Qt1hbwmgiruYCf2GMxQRuD6gnHxBHg8QdFd2Zisik84V3dHvKv3OMqNF
	 BgFrqyEBzOpXA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id D84787F9F8; Wed,  7 Jan 2026 15:59:44 +0100 (CET)
Date: Wed, 7 Jan 2026 15:59:44 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Allocate dev name earlier for interface
 workqueue name
Message-ID: <aV504ARc3u-4lRL5@gaggiata.pivistrello.it>
References: <20260107092744.1131314-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107092744.1131314-1-wenst@chromium.org>

On Wed, Jan 07, 2026 at 05:27:40PM +0800, Chen-Yu Tsai wrote:
> The interface specific workqueues are allocated with the interface name
> as part of the workqueue name. However when they are allocated, the
> interface name has not been allocated, thus the "name" is actually the
> pattern for the name "mlan%d". This ends up pretty ugly and could
> conflict if multiple interfaces were added.
> 
> Allocate the device name earlier and use that to allocate the
> workqueues. Also tweak the workqueue name patterns to add a separator
> between the prefix and the interface name parts for readability.

Is there any impact on this approach when/if the interface is renamed from
userspace?

Francesco


