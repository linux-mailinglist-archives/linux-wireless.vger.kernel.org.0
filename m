Return-Path: <linux-wireless+bounces-26007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C2B113ED
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 00:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC083BBA6A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985DD230BD9;
	Thu, 24 Jul 2025 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRB416c5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DTyyiHY+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052B3F9D2;
	Thu, 24 Jul 2025 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396322; cv=none; b=JUJne3NR9zDUT4bzaN+N+bpTefuFxpToIKfjS7rIubZqdb/epwt+Jpo1sGDmJlcoTgt7uL6JpQUIeX5bLeu5rUUj9L5CGbNQhxdjHmcw4rSzvqYX86k1QAhAPZ13CDTjFfQuKNCN9I+7SvzJFFlRZcEAM9P4Sf5kXlTfsX9GF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396322; c=relaxed/simple;
	bh=pcnZW3F9uTDakvHvcPDUBnMGWeagJX+vB5mKU+gIzD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=thsXiIwaNIRMhNyaiv2+eLwygAkmX33oGbx/dJsOTWV2RK3XoAjZjbGW6flV7ATy03yf/p7GzP8AjKAG5/Kfi3bYlaXnGZ0876HcYUvdgotLDzb2BN2cmB+7EGLJKy1B5rO0iFflu7ECI0oLRu9ZJ++Luoet4E26qDqgYVH7p5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRB416c5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DTyyiHY+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753396317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ajBC721i9uvRmstQMJyJxXoWUpQ/NzRczfA9a2dF84Q=;
	b=JRB416c5XB2uG787BVz3uoFjbx8k+4z8w6LmVCgc+zuQLSBmp8KTkOcRxzpUKvaLbZgVBo
	axvJDmg1CZteq4nHnAKxn3xdSIEd5APcYRjJ7LRp4rxfbGUS+Ll8MvZOSy4kTSNSc+H0/o
	SbWpPNibWJCMNNXVMimJmfHf7QtN3vsLIpS30j3hU8HNsM8sdQgIpCJTghGeMYiir1cpg1
	ETAbHOSirQAKKMDO8ZxC8Ckuka/rFFfI7x8hq9z1Eu/t+ZPYRaxTS9/6jTgTwExfhMPP1q
	Xo1bY9rdJwYaF1m4OA4+k7o0dVTxL6uP1nk60MmJDPurVhfpm/U48aAnt0NaEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753396317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ajBC721i9uvRmstQMJyJxXoWUpQ/NzRczfA9a2dF84Q=;
	b=DTyyiHY+9wlDLT4XH5w3UlItUXawwQRr6b6SS5dZOup4i7HZwSLyBg2VE1T8bDkVJl/Ica
	j7y/vb1Vn5EXByCA==
To: Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Waiman Long
 <llong@redhat.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>, John
 Ogness <jogness@linutronix.de>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
In-Reply-To: <6c5e70a8-2db2-4fa6-8a42-35033e480293@redhat.com>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <aIKEfIjYBPzlE7y7@duo.ucw.cz>
 <6c5e70a8-2db2-4fa6-8a42-35033e480293@redhat.com>
Date: Fri, 25 Jul 2025 00:21:16 +0200
Message-ID: <871pq5qlgj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 15:22, Waiman Long wrote:
> On 7/24/25 3:07 PM, Pavel Machek wrote:
>>> The lockdep warning just means that console_owner_lock is acquired both in
>>> softirq context and in task context with interrupt enabled. That can leads
>>> to deadlock. So the remedy is to always take console_owner_lock with
>>> interrupt disabled, i.e. with
>>> raw_spin_lock_irqsave/raw_spin_lock_irqrestore.
>> So you suspect problem is in the printk code?
>
> This lockdep problem is likely unrelated to the IRQ flag problem 
> reported in the original email as it shouldn't affect the IRQ flag.

Wrong you are ... :)


