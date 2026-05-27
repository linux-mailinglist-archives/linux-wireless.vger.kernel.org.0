Return-Path: <linux-wireless+bounces-37017-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBykN1UgF2rw5AcAu9opvQ
	(envelope-from <linux-wireless+bounces-37017-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 18:48:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7315E7FBB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 18:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32A3A3004DBD
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415C3BF69C;
	Wed, 27 May 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="ECVApaaa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7DE2EDD78
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900497; cv=none; b=pl2nMMM+b34bZmgtGic7EnRu72Sr7td9I6Ke6EZCEHpSz/rEcnPC5b7ZvYo0ZPVElP8hzU8pnz/BMjT9KCqnfwRiABIMsDs6FUrJNpD6HJxPp7ddZYz7sdd7sFKa+ObHYl5XF22u/j0qmQzDSHQtcKKAlt+dlE2SkrO72GuZVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900497; c=relaxed/simple;
	bh=dTSUv/kugN/MCztqyIiZ5u0wWMgO4/vSMWNPA+RuO6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWY1N0DIqzEqhPbbq4EY4G8L+3HukOGaRfDW2UNnobqT2S1phlGc61rByg2YikXaIGnCCyKjzL0ugnJCHGFlx743RCM1efQQUphdbFsF7eWD4pbF3mdJQ/enIK5OQC6LXgaWNdphXVqHSGilDc31MEeamaTELZyNXC/bbiY5a6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=ECVApaaa; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:d44d:0:640:ae2:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 538C98285E;
	Wed, 27 May 2026 19:48:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (smtp) with ESMTPSA id 2mcWaU3gGiE0-cSGhRgBu;
	Wed, 27 May 2026 19:48:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1779900484; bh=FJ+5+D/z50/Gvo+sPM7L4ltowM8cM8zEDvekqbXrS5U=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=ECVApaaa7o6a9jV0OWJag3FLlkc8Eqgg+QRyk3Ss6LEsFHuh3IKsxT5PHUuTl8YEF
	 aC3qchMX8E9yQuqOgbINjnVdFGUkFeOuNbuG+EICyR7ET/pJRPqHnJSfD2ZvzdxFb/
	 o4LJgwKD77NT+4nAJ1Jpvbm24xnz5uQ5q4B3aWnE=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <d18d4ba0-9fc6-4585-8161-610ec42fdab4@0upti.me>
Date: Wed, 27 May 2026 19:47:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wireless-regdb: allow 320MHz channel width for Russia
To: Chen-Yu Tsai <wens@kernel.org>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org,
 Louis Kotze <loukot@gmail.com>
References: <20260428093058.3672383-1-me@0upti.me>
 <177751439231.3356117.7542785326182742344.b4-ty@kernel.org>
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <177751439231.3356117.7542785326182742344.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0upti.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[0upti.me:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[0upti.me:+];
	TAGGED_FROM(0.00)[bounces-37017-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@0upti.me,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,0upti.me:mid,0upti.me:dkim]
X-Rspamd-Queue-Id: EE7315E7FBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> 
> Applied to master in wens/wireless-regdb.git, thanks!
> 
> [1/1] wireless-regdb: allow 320MHz channel width for Russia
>       https://git.kernel.org/wens/wireless-regdb/c/62d72c287e99
> 
Hi, can we get a signed tag with this included?

