Return-Path: <linux-wireless+bounces-5393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7688EE85
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 19:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9601F35521
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 18:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89612DD8C;
	Wed, 27 Mar 2024 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzcAO3EW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860112A144
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565336; cv=none; b=Vhcp00yPL6bm3pVd/J4ensD104J5Orjz5D/6V8gTA8XU6Gl4YYjOiqY+vLE6087Tz8zPJL5ZKAe3Rsru7al69Pd2nS1M4Stnai6IaRRlqehNdLTXGNhJ44I+cF+mJnq9G2U/eiXCpBya8/qq2JMw0/te5DbH6f1GhPCApC1UoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565336; c=relaxed/simple;
	bh=PJj5tJI5Uq0v6Gm5m6XtsNrMIeh/6WHKpLNA5pIoB5A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FLszLUmHTdSA2HjuBZfghhTj2+q8I1TF6mthLJn1JLtDEYEYV/GDgePin5e9tIoTyV30ASv5NAjGRhmirfvicl+zfeOgvneM7EpcAGe2HK98MGGwL2TudA3Ra/7l5Um/g2JsgjS5RO6zyNkFA8zkEK1EQQjizLahY/EI9RjRibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzcAO3EW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8CDC433F1;
	Wed, 27 Mar 2024 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711565336;
	bh=PJj5tJI5Uq0v6Gm5m6XtsNrMIeh/6WHKpLNA5pIoB5A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JzcAO3EWJbcibtBQdyVXlE2JG9Tt32Rw3UqYyB6G+D6wIKya+59uV2LgKG0OY8kDR
	 6OMmNhpDSMPRt8UZRsUMgwcgtaUJ9O8epS1je1vBD5xOl6Z5+VLvk26Ms+1KkRt99g
	 RE6xausnsYZ3ZJJtOYkQq6vUQAXmX47sPgI0SvoSSkk1X9gGkaKCMJU4gGqCJUEG5N
	 ytyeg/9G0i6Rou2clV68jQ8b55Q74x5sJ5PzncArxPSeIyO6AtLIL8h7vRh95DCl53
	 LMuvfU9mNfrgTCsnwtWh3kDssetDD0ThlPLp3JAPVF7bdOzZi0/fUvfU5NbTJeiLaT
	 rJqQL0aLInu/g==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "Larry.Finger@lwfinger.net"
 <Larry.Finger@lwfinger.net>,  "s.l-h@gmx.de" <s.l-h@gmx.de>,
  "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	<2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
	<f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
	<66565618-3638-47e5-afe5-3530214da0c9@gmail.com>
Date: Wed, 27 Mar 2024 20:48:53 +0200
In-Reply-To: <66565618-3638-47e5-afe5-3530214da0c9@gmail.com> (Bitterblue
	Smith's message of "Wed, 27 Mar 2024 16:07:20 +0200")
Message-ID: <87ttkrzf1m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> On 22/03/2024 08:04, Ping-Ke Shih wrote:
>> On Wed, 2024-03-20 at 21:43 +0200, Bitterblue Smith wrote:
>
> [...]
>
>>> +DEFINE_MUTEX(globalmutex_power);
>>> +DEFINE_MUTEX(globalmutex_for_fwdownload);
>>> +DEFINE_MUTEX(globalmutex_for_power_and_efuse);
>>> +DEFINE_MUTEX(globalmutex_for_mac0_2g_mac1_5g);
>> 
>> The consumers of globalmutex_for_mac0_2g_mac1_5g are complex. Why do they
>> check mutex_is_locked()? Race conditions between two instances?
>> 
>
> I couldn't think of a sufficiently short name, like
> "lock_mac0_2g_mac1_5g", so I used mutex_is_locked(). That's probably
> a bad idea. It should be like this:
>
> 	/* Let the first starting mac load RF parameters and do LCK */
> 	if (rtlhal->macphymode == DUALMAC_DUALPHY &&
> 	    ((rtlhal->interfaceindex == 0 && rtlhal->bandset == BAND_ON_2_4G) ||
> 	     (rtlhal->interfaceindex == 1 && rtlhal->bandset == BAND_ON_5G))) {
> 		mutex_lock(&globalmutex_for_mac0_2g_mac1_5g);
> 		lock_mac0_2g_mac1_5g = true;
> 	}

Few quick comments, I haven't reviewed the actual patchset yet:

The mutexes look too finegrained and makes me suspicious about the
locking design.

Having global variables like globalmutex_power is a big no no. They would
not work if there are two devices on the same host, right?

Conditional locking is usually something to avoid.

I'm starting to wonder if extending rtlwifi is actually the right
approach. We have modern drivers like rtl8xxxu, rtw88 etc. with better
design.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

