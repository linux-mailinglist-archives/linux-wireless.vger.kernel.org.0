Return-Path: <linux-wireless+bounces-28934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF86C59350
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 18:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AEE3503B1F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D8434164B;
	Thu, 13 Nov 2025 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K7gY2oIY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PUYGJC2E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE12F7AC9;
	Thu, 13 Nov 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054527; cv=none; b=Q47zQuoMwjNOd7WUHcqb87ywoZ58+N7bdR4NhoHGq4tY9HmqWjHAE3xPeR3BKZJ3YDajZzREmqDEOe0jR2qPfSSM2Nyt9o1atcugjBqTmD/RKg64mAyqjLqkp6HWq/jcj6IrIeGqRWQCbon1/H2Twyid4WW3bxdgNo63pjh4FJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054527; c=relaxed/simple;
	bh=gDGxPoImWOtItgifoiFHC4tQg2flME8hbVchoAWf8mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI3QVrPuj/JAiLPzYFd65RISLrLGK8zUpHKCMV1gE+B0whGC27ZrZAzsSag+/6L+wQPgjghg5uli6Z+Sq6ijIS4xADuLzrjG90bUgfT+48FQkjgLwF7fva1CROukm/bAAaKuW8OvzIMOLlkTbDpHIg1tnPxRQB4AjE9LAdsVkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K7gY2oIY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PUYGJC2E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 18:21:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763054521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ROMWpRRLugWsifaHPQePfDdfFY98GVu+EcHMapiLrY=;
	b=K7gY2oIYkYcBs5dO38P3m0foDjmg+o+fCt0qFWL8QY7mlF7S213vvjKLrsJSfNk0bXD6dM
	hMn9/1NMLBAC99pNeqU62L8tmNNLeUyIsLC4z0J+XnG9HHaq0YEA42o2mFh0ojOdfUUMHN
	LqNA9wPzolhzui7AysYr46Ni1zrHchBwGD3XgUiv4FJvxSY946li9dmiInNLSMMX6kdlus
	dXPKPUO6p6I/oUJMSyMgwFd7vYayj3C/IDApOXVa1YSMvr9gdWpDMJ6Hmc/guyqZRNp7PY
	mV+tgjAgXomRJRyYlmauhUZIjWVZwTYQZ6jL2uDavJ8u/LSWOLzzpwDsa4B6pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763054521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ROMWpRRLugWsifaHPQePfDdfFY98GVu+EcHMapiLrY=;
	b=PUYGJC2EESYvf8bFpEUt0jo8RMONXYylNuumTaQXVO5DnoN1j98HbVVeeoOM0MuhTXBWDL
	RJksfIC/OEi9Y6BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] wifi: wfx: add WQ_PERCPU to alloc_workqueue users
Message-ID: <20251113172159.a-yjqge1@linutronix.de>
References: <20251113160825.383883-1-marco.crivellari@suse.com>
 <2530603.TnzJ9iJZxx@nb0018864>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2530603.TnzJ9iJZxx@nb0018864>

On 2025-11-13 17:57:40 [+0100], J=C3=A9r=C3=B4me Pouiller wrote:
> > -       wdev->bh_wq =3D alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI, 0);
> > +       wdev->bh_wq =3D alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI | WQ_PE=
RCPU, 0);
=E2=80=A6
> BTW, this workqueue has changed multiple times. I though it was already
> unbound (and I believe it should).

It is not unbound. It can be enqueued on any CPU but the work item/
worker not migrate to another CPU should there be resources available)
compared to the CPU performing the enqueue.

> I also think the HIGHPRI is not required (the device perform better
> with HIGHPRI, but this is only because we steal the CPU of the other
> tasks).

HIGHPRI sets the nice level as per nice(2).
I did look a bit and one of the users is a threaded interrupt as of
wfx_spi_irq_handler(). This is already a thread with SCHED_FIFO 50.
You can sleep here or do anything else that you could in a workqueue.
This thread will be preferred to other threads in the system which run
usually at SCHED_OTHER including the worker.

Not sure if the requirement for the additional offload is to be able to
serve another interrupt before the worker completes.

Sebastian

