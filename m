Return-Path: <linux-wireless+bounces-8617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3DF8FE7FB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CC0282F3E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B820195FF6;
	Thu,  6 Jun 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="fQmuQ4TD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47361195FDA;
	Thu,  6 Jun 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680978; cv=none; b=DPJbcWvoYomC8JB0n1gtKegxwXfJyasoxcRkYcMei47lVnFBJsnHYuY9MMBy1GCV/+v8XDOasM4CKsbksuVKNKiN8FSLeU+rBPhibzP21uh9hRRRdEf+vdfF+Epccpv34B8vF+JsIxGvdUIMUivPayr2GzexMml/HnGTdgBLlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680978; c=relaxed/simple;
	bh=eQrKryJ+nnnD7E4StXoFl+JEF6d+daZeQoFmwO26xU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfRPk7k405IqcpyZo8jeoTrJnCmoXsiT/XnfCABPT+9xjnAa93ynWTYsC0RVAGhLTHgU+Ogvsl9Bt2qHy3SPOERgWnPybiR4WhlPYaUg6jKry3ioPTLPEK6/ytc/kM6Fu4/YaulwRNMO7NS40bjwe0UH6K5JQxFSfyoDQoeBe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=fQmuQ4TD; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=G+eMXZKA/CtMn1bPSHdZq3HzsanZxjFKvDXY3mierxE=; t=1717680976;
	x=1718112976; b=fQmuQ4TD/8bphVq7Eq4hXadEd7tVQDvFjNUxCoPpJL70GKodHocvZ2Xnvz9y9
	fJXtFQ9aannx8gP93oD+PQyW82EnuTvKUJ7EFw8A0HrGFaRbyw9S9kSyIGuQ9j3Lt9MX7VGKRE9T9
	N0hTR77Xk/15aho00vc/VgmPLZalYUamVObjur3o1YaGBkm4i7bLvT9KSxUMHiNZ78kYRKnnFN+ce
	MVo15Ifbn75i4PirLWG3MkWZwknzGpBITBY84J8DAykI8pptOQ1C3+9vxGQxuMP4PfrNO571Wo0xZ
	Jr8lvG2/MJ8w/jIuKzrEAGG+sSXe8wg6iAbLA99kvESCwpZKyg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sFDHo-0003T2-Bu; Thu, 06 Jun 2024 15:36:12 +0200
Message-ID: <ab97d661-9054-4053-88ec-1b3a8db698dd@leemhuis.info>
Date: Thu, 6 Jun 2024 15:36:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
To: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Savyasaachi Vanga
 <savyasaachiv@gmail.com>, Christian Heusel <christian@heusel.eu>,
 regressions@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>,
 netdev <netdev@vger.kernel.org>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717680976;44119e72;
X-HE-SMSGID: 1sFDHo-0003T2-Bu

On 28.05.24 00:01, Christian Heusel wrote:
> 
> Savyasaachi reports that scanning for other stations in monitor mode
> does not work anymore with his RTL8821CE wireless network card for linux
> kernels after 6.8.9.
> 
> His workflow was putting the adapter in monitor mode by running
> "airmon-ng start wlan0" and then capture the surrounding stations with
> "airodump-ng wlan0".
> 
> We have bisected the issue together in the issue in the Arch Linux
> bugtracker[0] down to the following commit:
> 
>     0a44dfc070749 ("wifi: mac80211: simplify non-chanctx drivers")

Johannes, Kalle, if you have a minute, what's the overall situation
regarding that commit and related regression fixes for drivers that are
affected by it?

Afaics it is like this:

One regression caused by that commit was already fixed with
2f7cf3b61d8522 ("wifi: mt76: mt7915: add missing chanctx ops"); two more
will soon be fixed once 2f7cf3b61d8522 ("wifi: mt76: mt7915: add missing
chanctx ops") and 819bda58e77bb6 ("wifi: rtlwifi: Ignore
IEEE80211_CONF_CHANGE_RETRY_LIMITS") are mainlined.

But there was no reply to the regression report this thread is about.
And Ping-Ke from Realtek even wrote "We have a draft fix of rtw88 driver
for RTL8821CE, but as mentioned some drivers are affected, so I don't
plan to send out the patch." So apparently Ping-Ke is waiting for some
statement from you how to proceed.
https://lore.kernel.org/all/0e65ca6b471b4186a370b9a57de11abe@realtek.com/

There there is another report about problems caused by this patch where
the user has a mt7601u -- but also broadly (and thus likely incorrectly)
claims that all drivers are affected:
https://bugzilla.kernel.org/show_bug.cgi?id=218884 (I mentioned that
report a few days ago in this thread already without any reaction so far
afaics).

That all looks a bit concerning (and makes me wonder if temporary
reverting 0a44dfc070749 might be wise). :-/ But I might be missing
something here, that's why it would be good if you could provide a quick
evaluation of the situation.

Ciao, Thorsten

