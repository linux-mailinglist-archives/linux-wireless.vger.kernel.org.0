Return-Path: <linux-wireless+bounces-29158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE0C731F7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93CAF3514B0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050B2701CB;
	Thu, 20 Nov 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fBPyW9Dd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4A13D503;
	Thu, 20 Nov 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630899; cv=none; b=EG50KsWEmKH+XTlkyygZPHh4hpPtY5yXsFPXwKoePf1/SGZQLav2AxDYdbaqNDbM7wreEoEql/tCdPO2PpeIFUOtllL477aJEFzwnFvOAHFhXabuHl/shL7UKRf35e4ylIGk4EI7ci4H7rkBHdmFNWAmcEvMteWK36via9sJBHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630899; c=relaxed/simple;
	bh=j8C31JjeX5D2cfyUNXtpe7gqeWiAv11RVgHHzCcwJO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gl6a4sejcskZI2KEvWNmNeXnMIOwfCa80TdD5+Kaaw8FZEUqV02QXHljk2K2UY8W59Rws+TZiFF9g7BrRKNPEcipf3crWCk76O989wUlVzfoxapHKxkPMfDtG0UGgNufDJvH6Tbi8e8EBF7d0mCO11nkN6Aziep0koh5TM3AePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fBPyW9Dd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gakq8wvDFOFiR4sO1dClU4UUplh2XfMx52plk9IsoKw=;
	t=1763630898; x=1764840498; b=fBPyW9DdxropwHtRRPwkAzQZucjzwXGxtmrOjDz001aHfh/
	Vc+M7Pm07oRTjjDkQZL004cIBOoUP82gn/soKZS+XwT625v+4tNSYSZMk+5HrbPJruTqu0/mxGjnf
	JySJpijNQYrIkOjTU2ULQ3Gp9hi420OlJOv+C0Z5El6QvkfdStgdysnLj/jor+lUZJkmL63JuZaTd
	JWrJySpjaO4DPpimO+/HeY6NQ6tFpSExGJEl6d9X3zDiFXtadlDnasAgKo/aDfJYht+gPtXkD6tPS
	29sT8ybM0iV782MSUzRwrjx65Y39DpJy4T4nV9th2c47hlJ0o7b+9rnUuDbtOhIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vM0xX-00000004XCW-2H8q;
	Thu, 20 Nov 2025 10:28:11 +0100
Message-ID: <f74e480c731a8ef0775a86021fc85482ab245217.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ipw2x00: replace use of system_unbound_wq with
 system_dfl_wq
From: Johannes Berg <johannes@sipsolutions.net>
To: Marco Crivellari <marco.crivellari@suse.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker	 <frederic@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Michal Hocko <mhocko@suse.com>, Stanislav
 Yakovlev <stas.yakovlev@gmail.com>
Date: Thu, 20 Nov 2025 10:28:10 +0100
In-Reply-To: <20251114095035.70765-1-marco.crivellari@suse.com>
References: <20251114095035.70765-1-marco.crivellari@suse.com>
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

The subject and this:

> Switch to using system_dfl_wq because system_unbound_wq is going away as
> part of a workqueue restructuring.
>=20

doesn't match what you actually do:

> -	mod_delayed_work(system_wq, &priv->rf_kill, round_jiffies_relative(HZ))=
;
> +	mod_delayed_work(system_percpu_wq, &priv->rf_kill, round_jiffies_relati=
ve(HZ));
>=20

johannes

