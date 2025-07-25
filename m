Return-Path: <linux-wireless+bounces-26021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC6B11F79
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 15:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BEC586B67
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 13:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBC01FC0E2;
	Fri, 25 Jul 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fRxLJVuj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+pvNvBZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4A41BF58;
	Fri, 25 Jul 2025 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451074; cv=none; b=EOtMik/8+iOsCTy8ihPaOhItn3LLpSswUV0dXopMwv5WAaq/v5l1Ua3c6a3Ro2k4KegDTSBjltqjMZIbJY6ceAWCa6mX7HMaR981wZQ3YsQZ2KI9XnkgF6uH9AUl+4lGNtu0VaqpWh2HhrmqCIqK0JUGrJCNKcXBPnwQ0s4YI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451074; c=relaxed/simple;
	bh=7UapUeq5Jeg23Aje7yiaOARnPtY5NkKIcx547+JX4To=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hHDub24YJnUkkrljPMO5HQNMPNBiahkA8TMvGb2aZM/XkNO56FCoR/u0K/Nhox0OCv9V/15E7PXkWVh9MbiHzFP9wLYJegw7atCOklFgZ1HWYF7Pr/pTgEyoERNTY8sXLWQ5x/Wbs9x09pSjxbvX7nNGq9B5ft2xmN3589Tn90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fRxLJVuj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+pvNvBZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753451070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BYGvncf/spwdj7dChYLNyY1VFlkcNcsSw6LytjOMpU=;
	b=fRxLJVujmgmFWkRQhn0DKEkM0Jlfl5+Rq5cLSUhPyqFNWQcoYeON4oMi1wZnIjbXYbjZxS
	EVAC14LL+YhkuihrPh77qr83jU+MtccCc5H1MtDtyAOSpxi9+9cSpWMtx8GUmXr3feUa4j
	2ISVTudY7xgnbZ7OuKqbb9Ok4Hcins2Yqz1aeH10tw+fa65zfCAGphGE9tcecexg0XMi/0
	N5Z+kHuv+3qDqKvdmgwR5fscekbIFMw1ZTpDKOkf/goZYUUPanqyHKsSieBYWv+xV1YXzZ
	q6eIv5AqXgMk2I8QwQjlLkxmroKUkB9GfaA8qsvBQiN384PjD7bUhCFsucf90w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753451070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BYGvncf/spwdj7dChYLNyY1VFlkcNcsSw6LytjOMpU=;
	b=F+pvNvBZx2piOPkf5SIqgglhZvxVOwwqGMlDUpwLyBmrp+T7DPYk0eHB8PVLVXKbo4bl3B
	OGayNN8wfqy+zNAg==
To: Waiman Long <llong@redhat.com>, John Ogness <jogness@linutronix.de>,
 Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
In-Reply-To: <6a27ffeb-a79b-4623-9ad3-392973a1fcce@redhat.com>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <848qkdtlsl.fsf@jogness.linutronix.de>
 <6a27ffeb-a79b-4623-9ad3-392973a1fcce@redhat.com>
Date: Fri, 25 Jul 2025 15:44:29 +0200
Message-ID: <87y0scpepu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 20:16, Waiman Long wrote:
> On 7/24/25 3:45 PM, John Ogness wrote:
> I am sorry for confusing conole_owner_lock with the console_owner 
> lockdep map. Yes, this lockdep splat should be a false positive. You do 
> need to put the mutex_acquire before printk_safe_exit_irqrestore() to 
> avoid this splat.

No. The printk code is absolutely correct as it is.

Did you actually read my analysis?

The lockdep splat is triggered by the raw_spin_unlock_irq() in
__flush_work() as it makes console_owner unsafe.

Again:

  printk()
    local_irq_save()
      acquire(console_owner);
      con->write()
        vt_console_print()
          hide_cursor()
            vc->vc_sw->con_cursor()
              fbcon_cursor()
                fbcon_del_cursor_work()
                  cancel_delayed_work_sync()
                    __flush_work()
                      raw_spin_unlock_irq()          <- FAIL

The initial report from 

cancel_delayed_work_sync() _CANNOT_ be invoked from atomic contexts,
unless the work is marked as BH work. And for BH work it cannot be
called from hard interrupt context for obvious reasons.

Marking that cursor work BH is not helping either, as printk() can be
invoked from everywhere.

There is no way to legitimately invoke cancel_delayed_work_sync() from
the legacy console write() callback ever.

No?

Thanks,

        tglx

