Return-Path: <linux-wireless+bounces-18618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01934A2C0B3
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 11:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CAD3A7A08
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866C1DE2C5;
	Fri,  7 Feb 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="pfdLBQY4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1141853A7
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924650; cv=none; b=KXgbSyY35OXdnq8nz+wiDBehDlZ7YU2V1DXR4HiVbIHbI0KH/bRBRy9lc4hqISIz5WXDhgIGVtv2uF7GEXXR1sZcmWyVJmKnQSDrMDbf8hnGoQaV2V0hBb47u3rru3DQXWT+lLeYAZki/XIHymhuBdKfKoHep3AdkmJjQ6exwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924650; c=relaxed/simple;
	bh=kNmqsjH+63UUyTt9uiIWhTvu8IDk9I0nm7HgR8OYXLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kFzNWMFFilBZxXHWzxgckQWS7pII4TMKDTcKrVaQssVirnrKZ3bEN3scGVjVPZRn4B1409X4UQUbN+RfhdIpXKBHFN9jJXBwIxGvtTUCd2hkk5M4VDBL89Njo0llu/MltQCe4dpnuQ4v/lAliZkAM/S10v0PR1tUUOML4JoJSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=pfdLBQY4; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with ESMTPSA id 125B44132AD7;
	Fri,  7 Feb 2025 10:37:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 125B44132AD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1738924638;
	bh=3RyfsLlkcsrE1Uipd0bPj1sExIJ67ckgF2rKuv54jMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pfdLBQY4BVYEbLmhLqntEpr/ypiE2KJ8di94jMQVdLH3vOGzeS+/ZGYxzW18SFOOr
	 ixm73muHcYIj0k/3Xplc4u4vZwQy1Ta/4OFBIqdZ9MiQE21yO9N+CpAZ7WfwxEP+2b
	 Gv7W+TP9/ufSQ7pnVOHyzB0b+c6ZaKY2SBlYZtlo=
Date: Fri, 7 Feb 2025 13:37:17 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alexander Wetzel <Alexander@wetzel-home.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Subject: Re: [PATCH 1/2] wifi: nl80211/cfg80211: Stop supporting cooked
 monitor
Message-ID: <rk6oogifmfbtboifgyzluw7cu2t6i3xdtf7qtrt2suil7t7nay@binkah2qe22o>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250204111352.7004-1-Alexander@wetzel-home.de>

Alexander Wetzel wrote:
> I first tried to just refuse setting the flag in mac80211, but that
> triggered a warning in nl80211 when rdev_add_virtual_intf() got the
> error after green-lightening the flags in nl80211_parse_mon_options().
> 
> So we could add some code in nl80211 suppressing the warning when
> MONITOR_FLAG_COOK_FRAMES is set. That would open up drivers to refuse
> cooperation when someone tries to use the flag.

Is that the same WARNING which is being fixed at [1] or something new?

FWIW, I think the current series would not go to the stable trees (at
least there are no Fixes ot Cc: stable tags), while [1] should go there
to suppress the currently observed and triggerable WARNING regarding
setting the outdated cooked monitor mode mixed with some other modes.

[1]: https://lore.kernel.org/linux-wireless/20250131152657.5606-1-v.shevtsov@mt-integration.ru/

