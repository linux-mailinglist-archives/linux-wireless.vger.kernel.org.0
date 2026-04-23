Return-Path: <linux-wireless+bounces-35241-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCSFMJS86Wk4jAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35241-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 08:30:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 231B044DA20
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 08:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9F6A301A910
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8883138656C;
	Thu, 23 Apr 2026 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w4KhrPwX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r5n5Mr5b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658330171C;
	Thu, 23 Apr 2026 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776925831; cv=none; b=fqbEE4vj+9fuv7mNdqJQRjNKX2GWdo+b2ixA8CouTW8pfCvRwqlJgTHHQLvtrz6dq7kkQEUTjlI6RqZVMgsP99fZI0XH2cBXZS+1zw1uKV4iVYVtlpIs0LTwltYIXArVAcxEjjiTIjAqeGAymTlj7TZ8RbLcwJf9vxxQCNrBhAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776925831; c=relaxed/simple;
	bh=yVfTfQEXTPdiF8Lo12suFm1UgbZWGxxplKmzis9sCHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC7ASEyLpeZMox1dEq5BiC2/Kx9nAaofzDAVbJXiNPzsV0H4Bt3cfi0PSlsL3EnGZ/hA7tbiq01aubjRZmIiCTmzMqvzOb2glB3tA28Q/3wcs0xV3oFT8i2dUeil6rB8X/k92aL3S7jmwh8c9cDa97YH1cPww27o/SJnULw4lcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w4KhrPwX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r5n5Mr5b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Apr 2026 08:30:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776925821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QK/PQSL7AlydxKgd+pW/m6kHp0nO/nGLtQp9B/reZs=;
	b=w4KhrPwXGbaoDowx3GqDG5eHQAYS6ILllFxfRwUqJ61ar+WdAlXUtIR0AJBqk9yBpJGk0U
	ylVax1x8o64yWs9PCKo+KZNJcfEh15vw/Ow8TQAUe+UFAfUPNfqe8puNc3Dh3uCQgBlXiI
	BqoKGQtDSPOK53nSQbtHLBTjdh6XJFJq7HAaCYvXdYUaCIz3HJgGZ/kYuG9/N0W6la32FA
	YibSRIuTJedz7lvxdQSzeGCgAS/88RnnwJEut/IKDRy8pu7oKw9VUnNkCrBbEx+x6kqpfe
	MsGUMxK2z771y2EeNJgL0Q+j9uF1qBBxB73Eca9QrLV6uIeeWJE1WQ94cakjXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776925821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QK/PQSL7AlydxKgd+pW/m6kHp0nO/nGLtQp9B/reZs=;
	b=r5n5Mr5bOSF6htPlcUxw4k6WMRVkCoHdAeBNqa7vGYUuyVEfzqrHUCPBtbvcaIbIYCQ9P7
	K5jLWTkrTlk+s5CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3] wifi: ath12k: use lockdep_assert_in_rcu_read_lock()
 for RCU assertions
Message-ID: <20260423063020.NAero6Rz@linutronix.de>
References: <20260422180814.1938317-1-asas1asas200@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260422180814.1938317-1-asas1asas200@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-35241-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 231B044DA20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-23 02:08:14 [+0800], Yu-Hsiang Tseng wrote:
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_S=
ILICONZ-1.115823.3

This could written in plain english as in "Tested on =E2=80=A6". Not sure w=
hat
this "convention" is but anyway.

The change is okay.
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Changes in v3:
>   - Use lockdep_assert_in_rcu_read_lock() instead of RCU_LOCKDEP_WARN()
>     for clearer intent and more precise semantics (suggested by
>     Sebastian Andrzej Siewior)
>   - Reword commit message: this affects preemptible RCU in general,
>     not only PREEMPT_RT
>   - Move Tested-on before the official tags per ath convention

Sebastian

