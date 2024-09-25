Return-Path: <linux-wireless+bounces-13206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A05986541
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 19:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CAB1F23EB6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0491F94C;
	Wed, 25 Sep 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b="VNDvciX6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m101-out-mua-2.websupport.se (m101-out-mua-2.websupport.se [109.235.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FD1D5AC8;
	Wed, 25 Sep 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283626; cv=none; b=akiHT/vwZNihpMrsWJtBMBNOeVuDzNY8a38drrr4TK0hMlWRhoTHX+OHP6WY1/hD+3vHiXbBZfskCbSlnznxY6HY70jSgNGWAZ/aNsv+r1stX6inJADM0lUTbl8U2cszHHac77Aq3Hl3a4+LkjIYfW4RYTxZjNqm7jLI8w5V/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283626; c=relaxed/simple;
	bh=eAIWmxSIB/wFH+b+hWZW8MT1OROPOx/GVZI1Yx2S4VE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LyiaEcswYENSMACke7lxQf4YigjBt0TqhibtxgmcbyABum2FkvBlGayD5/wiespGzKRbq/ltMqw9yBiIWFFrVc+ZuOL/RsEeTiqWhPYHzNRJ6gzsbaApo1JECfWQvVVlCTu97xADYhXz9+qt1dPZOFMyiORNHbk15f/S1MdSQH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se; spf=pass smtp.mailfrom=technux.se; dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b=VNDvciX6; arc=none smtp.client-ip=109.235.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technux.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=technux.se; s=mail;
	t=1727283613; bh=QbAxxAUT7/ekJWsQXn9co2hKZ92a2vCXMCEDtmEY8F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VNDvciX6EkDFlP1Qnn8scL/mda5zRwMXB6db0WnyH91KrzhlBRFvI4xOPlb5o7+oM
	 k6Xqx2gFHAkGCh3dAmVwvFR/j9ympFOEG14dwtFKMKcm2Boa+TJ8RqaaEys5ppPAz8
	 Mpw5LjU5ji/CIuKRXYh4MjVEADxPM+I0Yqp1MsSGyW+ABj4+bqVncMOv/PIkhdi5C3
	 qN3gb7lHoqKI7fs6VdpcqzUqrlc6n5c1y9NUWPcD0gBCWmMxMR0oBevHAyjKAmziU7
	 fiZDNqAiS7j2WAOeEVPNIKUgCWUW41I4BXzL7f4MngDku7rP2vY4wAq/6jA8+RXj6i
	 ffKBjnpEhxjEQ==
Received: from m101-u7-ing.websupport.se (unknown [10.30.7.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-2.websupport.se (Postfix) with ESMTPS id 4XDNJY0f0Gz1ZvN;
	Wed, 25 Sep 2024 19:00:13 +0200 (CEST)
X-Authenticated-Sender: petter@technux.se
Authentication-Results: m101-u7-ing.websupport.se;
	auth=pass smtp.auth=petter@technux.se smtp.mailfrom=petter@technux.se
Received: from roundcube.ws.int (unknown [109.235.175.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: petter@technux.se)
	by m101-u7-ing.websupport.se (Postfix) with ESMTPSA id 4XDNJW6j6Yz110k;
	Wed, 25 Sep 2024 19:00:11 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 19:00:11 +0200
From: petter@technux.se
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 rtl8821cerfe2@gmail.com, morrownr@gmail.com, s.hauer@pengutronix.de
Subject: Re: rtw88: rtw8822cu: Kernel warning in cfg80211: disconnect_work at
 net/wireless/core.h:231 on CPU 0
In-Reply-To: <13c3221f0cf2c5586dc34e8dcf6758c9e4e6cd4c.camel@sipsolutions.net>
References: <80de30f72595480a2e061dc462191c9f@technux.se>
 <9d243087654c4f3492d0046b7444c6a6@realtek.com>
 <13c3221f0cf2c5586dc34e8dcf6758c9e4e6cd4c.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.6.9
Message-ID: <9e98937d781c990615ef27ee0c858ff9@technux.se>
X-Sender: petter@technux.se
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Out-Spamd-Result: default: False [-0.10 / 1000.00];
	MIME_GOOD(-0.10)[text/plain];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:41528, ipnet:109.235.175.0/24, country:SE];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	WS_IP_WHITELIST(0.00)[109.235.175.25];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Out-Rspamd-Server: m101-rspamd-out-4
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WS_IP_WHITELIST
X-Out-Rspamd-Queue-Id: 4XDNJW6j6Yz110k
X-Rspamd-Action: no action
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1598
X-purgate-ID: 155908::1727283613-C743DF5A-F3B00CA5/0/0
Feedback-ID: m101:technux.se



On 2024-09-25 08:19, Johannes Berg wrote:
> On Wed, 2024-09-25 at 03:30 +0000, Ping-Ke Shih wrote:
> 
> 
>> I think the cause is picking commit 268f84a82753
>> ("wifi: cfg80211: check wiphy mutex is held for wdev mutex"), and
>> cfg80211_is_all_idle() called by disconnect_work() uses wdev_lock()
>> but not wiphy_lock().
> 
> Yeah seems like a stable only problem (CC them), this is with kernel
> version 6.6.51-00141-ga1649b6f8ed6 according to the warning.
> 
>> I'm not sure if we should simply revert the picked commit 268f84a82753
>> or should pick more commits.
> 
> I don't see why it was picked up in the first place, so I guess I'd say
> remove it. We won't want to redo the locking on a stable kernel, I'd
> think.
> 

Thanks! I tried reverting 268f84a82753, then as you guys expected the 
issue is gone. So will continue to run with this commit reverted. But 
would be good if we can decide
how to handle this for stable releases (such as 6.6) and see if we can 
revert it their also in upcoming 6.6.53.

>> By the way, I think the latest kernel will not throw these messages.
> 
> Agree, that seems unlikely.
> 
> johannes
Sounds good. I will see if I can give it a try on later kernel also, to 
verify. It will require some work to get my device up and running on a 
later version so might take some time until I can give feedback. I was a 
bit fooled that I got the issue when moving from 6.6.30 to 6.6.51 + 
cherry-picking all latest rtw88 related changes for my LM842 (8822cu) 
usb dongle, but great that you guys figured it out so quickly.

