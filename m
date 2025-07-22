Return-Path: <linux-wireless+bounces-25870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36479B0E01E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8927A1D6B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D29F2EAB88;
	Tue, 22 Jul 2025 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CqvX0uVb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PfzaEWuu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACEC156228
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197239; cv=none; b=SpB7e8Npw0dcb2x6p8XGYF4ScvVtC+jSl+sR4XkfjfiY7hGWJfetJFAzct907KvEMyD0Wek7ASNY4yzBYixyxon/p7h1RI1uYCxanKx+rT29yhf6rhqfUmBZEBiTtTh6/QrctRxk1wQ3ohhZE6TOpp/hJml57rOv+NNqsg/AHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197239; c=relaxed/simple;
	bh=OmNzOMvSqXcTR2g0N6jn7tyNxctiax4/DQ/K1Z9ahL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAMPGbyKg72whx+VMJA5cM8vxYg50c/fcVhIY2hYUGNPdH6Mo52wfVXmuXWOV08Vjp1nJqsbLsRWy8UWKB7x5go4vZJDbWqhF3WdJA4P0vgHsKwDbyRgQDfqEIOwGXeIlr/T3oioyLHt8Nfzm+NjnXa3z3eX4JkSCJTGW9OUCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CqvX0uVb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PfzaEWuu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <76fa16a8-367e-4f05-9c50-c9ac08ee20ff@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753197234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQCV0AgeysR+MnfArdCzdx+N/7m9XWaScsuREv+qwNM=;
	b=CqvX0uVbrZqdN34sFSXAbgqAmpVm6SbpWY42hES0igroqS4jyZEoFXdOhP9OCN+MAYFXsy
	gtygoSXPDZ+sf5O9sqwLNMDINtw2il8uvW1HnjZChiOVV0nzwla75c+k6ZtVm1V6V55KFX
	Bb1dgdmmVm2kf2NpGJUblSairLyX12IzKErIBlJ1g4FboVgWyxDsBLB2kinT7HYbhw4X3L
	ZFEHgUulQosUYpFO1tVEauRukakjo3v/dWQ4RaRmeFz/ApcSjwCcKi6DpyecM84WOwO6TC
	OAnIStkdUvFsGSCXXT/2//mrKgFaMMbz1KaHtzhzf42YjR2h6bN3A+jO0VNNDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753197234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQCV0AgeysR+MnfArdCzdx+N/7m9XWaScsuREv+qwNM=;
	b=PfzaEWuuShpzWnZzIt5Zigd7uZkUtGetrXSH2Isll8Voac4GMjYEmKrJR2HcmvEOWdeCXi
	DhGjIHEvJYZbu6BA==
Date: Tue, 22 Jul 2025 17:13:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: WARNING check-sdata-in-driver in
 ieee80211_link_info_change_notify
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>
References: <a9de62a0-28f1-4981-84df-253489da74ed@linutronix.de>
 <f06f3b3e40e104cb9fcdb086d8f9fff146225330.camel@sipsolutions.net>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <f06f3b3e40e104cb9fcdb086d8f9fff146225330.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

Am 22.07.25 um 14:11 schrieb Johannes Berg:
> On Thu, 2025-07-10 at 09:47 +0200, Martin Kaistra wrote:
>> Hi,
>>
>> when trying to use monitor mode with either rtl8xxxu or rtlwifi driver I get a
>> "Failed check-sdata-in-driver check" warning in
>> ieee80211_link_info_change_notify(). Aside from the warning, monitor mode seems
>> to work fine. This might also affect other drivers, I just don't have the
>> hardware to test.
>>
>> I bisected and found that the warning started with c4382d5ca1af ("wifi:
>> mac80211: update the right link for tx power").
>>
>> I can make the warning go away when I add WANT_MONITOR_VIF to the driver, but
>> the real fix should probably go in mac80211.
> 
> Strange, I'm not sure I see the relation with the commit you mention.

Before the mentioned commit __ieee80211_recalc_txpower() returns false and so 
ieee80211_link_info_change_notify() doesn't get called.

> 
> Either way though, given NO_VIRTUAL_MONITOR and WANT_MONITOR_VIF we
> probably have to catch it in the code, perhaps like the below? But I'm
> not sure it handles NO_VIRTUAL_MONITOR correctly? Hm.

I can confirm that with the code snippet (with an added curly brace) I don't get 
the warning anymore.

martin

> 
> johannes
> 
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 351564360c26..bf338024b5d5 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -408,9 +408,20 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
>   
>   	WARN_ON_ONCE(changed & BSS_CHANGED_VIF_CFG_FLAGS);
>   
> -	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
> +	if (!changed)
>   		return;
>   
> +	switch (sdata->vif.type)
> +	case NL80211_IFTYPE_AP_VLAN:
> +		return;
> +	case NL80211_IFTYPE_MONITOR:
> +		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
> +			return;
> +		break;
> +	default:
> +		break;
> +	}
> +
>   	if (!check_sdata_in_driver(sdata))
>   		return;
>   


