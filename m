Return-Path: <linux-wireless+bounces-13222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98DA9873ED
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 14:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9185A1F225ED
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A965B18035;
	Thu, 26 Sep 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="YpSjNKKe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E9712B73;
	Thu, 26 Sep 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355369; cv=none; b=YKglIKwuhiNXh+qZ9PnMFqjveRgoso2VBlvKifCexpHKxTcpQXmJYRF5tPP1u4BnLhJ5ikqYygQf3uc4pHoWcB1WOKRSM0t10N6+RfIGyrwJcZVQroSDS6wrhcWsgQkcm50f7l6X6Ti7KxZ/96W30kWEuO6Dx/MMHG6dTXt+ihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355369; c=relaxed/simple;
	bh=Pgw05YNsAcMe/Ex72yusBrrrRiMTYpRCUiIhvzeDrz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu2Xfxo7l6Z9TMXNNPL4WR6Q8F2zDbKSIy2nPdY5iw9KVvX5gk8G/pxIV6zgPfFR+5bA07ecDf8ltM5Gp0AfReUWrh4BverNrsqzz7zVD2HRpFCNJNinCNpouWJenWC/tTXYTlVM76IhJIAneuHdxEF6xKfbjyjAm+Hx0OTAF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=YpSjNKKe; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id EFF5240769D4;
	Thu, 26 Sep 2024 12:56:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EFF5240769D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727355364;
	bh=kzCP6gCWqEbVq/wqivZZeB6QattMUigWibOG/rUDeEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpSjNKKeCpz6XllMr5Wg/hGoC17hlWl9Oi1TspcXLZ3ZySB5Pl+a7WATEy56yAZdr
	 t1v4N/DMfgKPIYcYZ/hxGApirZZ2+9bW/uBYGe/irjGLpyiBhO94OxDpVhiMyHpZUg
	 1QrUd8Gp1fCOqRpu29Cm/MoRL09RmEyUnKx9IDA4=
Date: Thu, 26 Sep 2024 15:55:59 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>, stable@vger.kernel.org
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6] Revert "wifi: cfg80211: check wiphy mutex is
 held for wdev mutex"
Message-ID: <20240926-e996eb88183b3fc4a05bb4eb-pchelkin@ispras.ru>
References: <20240926-0b7fe990233f57538c94891d-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240926-0b7fe990233f57538c94891d-pchelkin@ispras.ru>

On Thu, 26. Sep 15:32, Fedor Pchelkin wrote:
> The patch was also backported to 5.15 and 6.1 stables where it's causing
> the same splats.
> https://lore.kernel.org/stable/20240918-d150ee61d40b8f327d65bbf3-pchelkin@ispras.ru/
> 
> Need to revert it there, too. Should I send the explicit reverts to the
> mailing list?

And I missed the In-Reply-To tag so that the context is missed, sorry..
Please ignore this one.

I'll send the reply to the suitable mail-thread and will prepare the
explicit reverts.

