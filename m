Return-Path: <linux-wireless+bounces-26455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1DEB2BE90
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 12:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71191889C86
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEEC315762;
	Tue, 19 Aug 2025 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvZw2pXH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qHGT7Lwf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5C311C1D;
	Tue, 19 Aug 2025 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598208; cv=none; b=F10nr9FLCRTiI7ZdLSFK92VFj0Y0JIWImfUHMwiHYBKTyUZWCfnNOynYSNmAXtNFhjhJW9flcy5Y9vXcQWDfV2iygbv8FaObaD5Y+EfSfl68afEwwkuw2EP7e23VXOrg0aya6yRbaMc/wvbs1+FHZJXjGvydWxsNJbDAYdNPuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598208; c=relaxed/simple;
	bh=b28O4cM8czlKLsEeTCDRHg2eOg7qxUCHyWCHVaA07c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etdscjhYgfR9RKeRmvhGRh+NCQyELT2EkWSa/lpg79ehBXrL2OHFpLzc5JDX+Gpr+HUXI1FGIBOu13pGBiRZygzbrP7VgjAHhjGsyIYolASgqbMp5w2HQCT19i8Is/xFN13MCJmZ5DW6OYLGy8zNkqYRmbPazAd4jtGhIyM6cOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvZw2pXH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qHGT7Lwf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 12:10:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755598205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T2XqfuRHWWMDxLgluu3oBnEeC+aaLkkbJZTHhHnP40Q=;
	b=jvZw2pXHJ8qbbxAVEQUJelrl5zQhbMflP+OEwJuWjxp8yBeh8wM+mwWLsJJzJizxlf7I2j
	npMa+3/gZxvIwGD8ept2U3Pnj9KDdb2kVVxEgKAD4yGk0BZ2TgECCfT0htE37KSFw1SKpK
	JRbyACqJ755uREnlIc0NdFMaqw1+2WTaUMSFwwC8YSA3hmdBCKH7b+7RT2kDrboWJ1efAO
	FHp6QLTbhpkT6e/yu7CkEdOEVqIr6dJLD1lycSZkx0L0I1sEe93jXKFybF+cG5T5m0uSrd
	s1zEQc0I0MZkslZK+ah/kK1tKbrlwVoUkzwzC+ER8d8qnpouCQlSiu6tknTCTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755598205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T2XqfuRHWWMDxLgluu3oBnEeC+aaLkkbJZTHhHnP40Q=;
	b=qHGT7Lwfz/qTnYrsiG4G4mur2On57CSaDx0bSVDlt6Z34zMPisRgQAE7UFJOvCJ2f1LRre
	HhxZTP/75c0MfbAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>,
	Aaron Hill <aa1ronham@gmail.com>,
	Lukas Redlinger <rel+kernel@agilox.net>,
	Oleksii Shevchuk <alxchk@gmail.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-wireless@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mac80211: Potential sleep in atomic context in
 __ieee80211_wake_txqs
Message-ID: <20250819101004.KB4KbEO-@linutronix.de>
References: <c15a819a-51de-467c-93fd-c321dd2e8ec9@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c15a819a-51de-467c-93fd-c321dd2e8ec9@kzalloc.com>

On 2025-08-19 01:56:00 [+0900], Yunseong Kim wrote:
> Hi,
Hi,

> I found a potential PREEMPT_RT issue I noticed in __ieee80211_wake_txqs()
> 
>  static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
>  {
>      ...
>      local_bh_disable();
>      spin_lock(&fq->lock);
>      ...
>  }
> 
> This sequence of local_bh_disable() followed by spin_lock(). On an 

As explained in the previous mail regarding for
inet_twsk_hashdance_schedule(), this is fine.

> Best regards,
> Yunseong Kim

Sebastian

