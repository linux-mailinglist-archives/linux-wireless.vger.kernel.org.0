Return-Path: <linux-wireless+bounces-9928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C20926205
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 15:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8D71F23C8A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0712177981;
	Wed,  3 Jul 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frelon.se header.i=@frelon.se header.b="lfMTdvme"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072C17A5B0
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.3.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014313; cv=none; b=LP10L6fenRn6MINyPw8nqgTTn0gUIZsqoVJPuNGnD5ENnDqjmlomrPaD9OiJpFbZfUk5hoHHj701BroZ9tWuKGHyOn83pQj5Mub/To6vTYZLdPyhknjFoWDhZKEV4pgIB95spGWLijXLVV5/jrITHsht4bLJhyRwqbREXTyziY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014313; c=relaxed/simple;
	bh=z/PohDnoI6AtSuLHfAV4Bz4K6RLhnwV8d03C9CWrYU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2fT5NayKJeaQjoM/cyw4HNj/M3/Ymz7X0ueazjSqIRx0ns9E/lXYnRb8bgyWtEoDsi8Vp4meE2n42M4Xi/kilmogFCYkaQKCDKzszibwnYDZX5diopUuESgZ9HJJ5cgxhBDOwzFxp06S7Q/2bmAJTjq/f2ALJON2/veCC+mGp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=frelon.se; spf=pass smtp.mailfrom=frelon.se; dkim=pass (2048-bit key) header.d=frelon.se header.i=@frelon.se header.b=lfMTdvme; arc=none smtp.client-ip=93.188.3.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=frelon.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frelon.se
Received: from s807.loopia.se (localhost [127.0.0.1])
	by s807.loopia.se (Postfix) with ESMTP id 087BD301F929
	for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 15:45:00 +0200 (CEST)
Received: from s980.loopia.se (unknown [172.22.191.5])
	by s807.loopia.se (Postfix) with ESMTP id EC2EC2E2957F;
	Wed, 03 Jul 2024 15:44:59 +0200 (CEST)
Received: from s471.loopia.se (unknown [172.22.191.6])
	by s980.loopia.se (Postfix) with ESMTP id EA06922015F9;
	Wed, 03 Jul 2024 15:44:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1.2
X-Spam-Level:
Authentication-Results: s471.loopia.se (amavisd-new); dkim=pass (2048-bit key)
 header.d=frelon.se
Received: from s981.loopia.se ([172.22.191.5])
 by s471.loopia.se (s471.loopia.se [172.22.190.35]) (amavisd-new, port 10024)
 with LMTP id n1Za47ZELwDk; Wed,  3 Jul 2024 15:44:59 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: fredrik@frelon.se
X-Loopia-Originating-IP: IPv6:2001:2042:34bd:7800:4e1d:96ff:fe79:894d
Received: from carbon.stuxie.se (unknown [IPv6:2001:2042:34bd:7800:4e1d:96ff:fe79:894d])
	(Authenticated sender: fredrik@frelon.se)
	by s981.loopia.se (Postfix) with ESMTPSA id 56F3222B170C;
	Wed, 03 Jul 2024 15:44:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=frelon.se;
	s=loopiadkim1707342414; t=1720014299;
	bh=tBZC8CpWlHR7m9iCwiMFOPFQO67wLgiBqnPE94Zdhfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lfMTdvmeyT9r1Kflw03bHBBs9FiGt+TE3/9KGKRVzEwFpE6j2tQIsIMw2+Nady93d
	 Q2QPVLD/tY5NSYufVt+HeRRkmrjFXjJ+qkzaLlad0RMeEptkSQ2bIesIa1mF9WlxET
	 OuG9Xw9zPHniNuK/WsMT2sPpVeptYJbIVNdo+bEReTPbTB42OtL3ZmIGi/Ivsm84hh
	 8T4+njy0oV+eWWsm+RNRpZoum6JY82auGzfATve8wZ5BjVBkqq9AjulrL2sXnWF4pQ
	 6F1rJv3oqALxf7lOwbGH1mGer/sRf2IZvq2Mg0CPdOXSjnot8euP5im+vvvHmerSBU
	 heRxEDC9uDNjA==
Date: Wed, 3 Jul 2024 15:44:51 +0200
From: Fredrik =?utf-8?Q?L=C3=B6nnegren?= <fredrik@frelon.se>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtlwifi: fix default typo
Message-ID: <ZoVV0ynwsWKZ7QrV@carbon.stuxie.se>
References: <20240703070627.135328-1-fredrik@frelon.se>
 <afdfd27b079d460c8a064d91d1aa99e2@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afdfd27b079d460c8a064d91d1aa99e2@realtek.com>

On Wed, Jul 03, 2024 at 07:13:05AM +0000, Ping-Ke Shih wrote:
> Fredrik Lönnegren <fredrik@frelon.se> wrote:
> > Subject: [PATCH] wifi: rtlwifi: fix default typo
> 
> Generally subject of v2 patch should be "[PATCH v2]" and need a changelog.
> But no need resend for this patch. 

Thank you, I will keep that in mind!

> 
> > 
> > Change 'defult' to 'default' in comments in several rtlwifi drivers.
> > 
> > Signed-off-by: Fredrik Lönnegren <fredrik@frelon.se>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 

