Return-Path: <linux-wireless+bounces-35343-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNgtEJMu72kI9QAAu9opvQ
	(envelope-from <linux-wireless+bounces-35343-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 11:38:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A404E470024
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 11:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB7D63022064
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0623A1D01;
	Mon, 27 Apr 2026 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yvrboc/z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD53B2FFB
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282675; cv=pass; b=uaB8G93VtB/xf5Jc+VpoZy5jv6wPnKTM77563miOOBczWcZWyuWA51Gv2NKj1Y0G30TWciKMkyvYASeci2eadcPWysiiLdhFJWeOARnsT006AZ73YvI1TQsdNCCAF0gBoUi255g8ZTXExgina8gwaeyq1FNq0X8s5sy15BL/Up4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282675; c=relaxed/simple;
	bh=khF6or3P7Ssf2kj43vsYhNI8CexRuRIQPUR2p95Zerc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sepi1CU7A4L4v+0Jxj6mhcY3eTmtZqj4QHr0fvFI5XYDeSyWGaJLZAJGifJvIWL/nwgVxvXrJHAdbzxLSONCvWz6ZlNk4YMzaNiQZ1EGnDuUvMAkno77HDd6GBhstDmnWQQS2iLSgyZWW28WomNIbJRA+VbFivEKKHN9+wmEQ7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yvrboc/z; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2adff872068so48126725ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 02:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777282673; cv=none;
        d=google.com; s=arc-20240605;
        b=bPFw7SpIF7g3HqEYVhA4Yi9e5xd0dEoInNwLfRK6gfPrkueydcyMMSwxa+Giz410yo
         aKs+CGp8sILPCjnhijVfnvSnAQfKuWWyJ1VQu/c4G12j3CoGFsx1ZsSvg50IDlrkl3iH
         nSzuht1VTufNKWRE2s3+v+g0SN+YLzZkgDc46BCaV89bd9mHxGky3zrZBprgsiprnJhr
         29sQ1TGQyC1wrCoTfKJ2sfftRDwZZy1JA18VlJsbqECo5I09iVSy6g0GarPNgx1FYwZP
         nvmonsJq2f0/JIDvKaVWODn2FURpC8mROHDEuGw0KjcGXaGXHh/OEsgV188DI57qxkW9
         +Vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kn6E9zoHRM2KLY1lbngZyriexLNgWW5A4g5dkFdwTns=;
        fh=5jvRZGsScH8L1qb1gYzxrBGI2ZoygVGhgXh+qHdlaWo=;
        b=HtUwmBxSmtsJH5AZ/Tw1jz6i2wl3l4ltkwa4LANa0RP4KzfirrcosmoLoAh4QC1rOl
         5Xhi8jfFlOwcspf5Hk38eZ3m7HhHRiZRyNtHeahvIEpF4KQ4qYkOH9pbi9aVX9aFDv8N
         8TORXWTgLzJHvxE+vLpTzlSHxOCd3yjiBk5X0hTGD1klK6nRPDCfx6g8kWMrMIeJasAS
         fmlzten0HcCuD3w6rthupYeEl5m9HU5UQEE/xIArNvTUpWPZ/cvIwlKDYDopcGhW+bIq
         ZSf97KPF+KwOCH2jxkMpyVmGCTqojQ3xux2aPvT8BcsAStQukKVubOxTbWoR7/O0sDb0
         G0eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777282673; x=1777887473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kn6E9zoHRM2KLY1lbngZyriexLNgWW5A4g5dkFdwTns=;
        b=Yvrboc/zkxGdplDhmWQRZkXBeVKRlUBeBm8CvRSCAsy5aIi+TYfZPIt0+qvyXr7+YU
         Rk5x0ZGYImqKqzqI2m6CuXo3YAyGGn0uC9ixTUCj6BmCRU/tWl5qXU5o6HP3xTUaoigs
         lVva3C34vewMxADKIcEaQFem5woqDuUNVGg0QFW6L6DVlEKlVKOKCq1YokrvLKAFtF+9
         yG22WZuiCvYakpf/shmOFGHNkmucmgc2DDaE62gE4S+5kOoWeQJYWu9an3syIYtYAjTD
         /fLCFcVYLebZAj89BwdtiGLM3IVHstyvfAIXB1EFUVQd08FsGXUR2zCvrc3wasOq9Usv
         8/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282673; x=1777887473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn6E9zoHRM2KLY1lbngZyriexLNgWW5A4g5dkFdwTns=;
        b=doRDf4xuGCxfB5Mk7LsA8A+zYkm7FqZcaUKi4V1BmhCKDrl7HVFRFDWIdRjsfS7PWM
         5eU+pLgVU8f4lscO9JyWKrDKSUjUYkKvQ3zJv8xgqsqlJQIG8MQ6zQq7UmzVLwzuXjOg
         Xlr/9Yn+TxxkCZACCfPuRuJ2NF7qJrcCJmYCEVhywH12GW7Dv9FyKkqoKjv+tENAImEq
         LvC008UcRzkfkDlG82KJ5Hlaa5CJFmBtsa2z3vv5/8zkS67b65JklJU0im3O/UVdAqzV
         +zz2xg+OGSxJqOlT8LGvkdooUGzRt5PTxBWnRL77NTVw6fcS5LVVecu3hH9zGKggsHOd
         jRqw==
X-Forwarded-Encrypted: i=1; AFNElJ/U62eH0Ld6oD9Q9Nl1WTNAdPE0tkwzzGGev4ZLZn605HiD3c6gkWQBVTvGYNsSd8tSnNCPSeuruivkCoLcug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDp1rbJ2InhDkh0HPx8Xu1zHNEY3nDY7nPJUYVNUVf/sq4Vt/f
	fzZzBizo0pfrfHH9XD78dWS/PAKovSt46QMxWBbkrW82Xm2G/LZqo7m6pnPzw+FOlE5i5gY+EKs
	r4oRD9XWBHMsecwXIzO8RYTyonuKm7dk=
X-Gm-Gg: AeBDiesF34w7tQsQOCg7zin+cU3K6h6OqJtu0YpRVkF1JvYwOUNE1yRL4/3J7itF9od
	pSLFaUzPVpt81qKPR6OfNRaUGzFP9KBHlZvbfwQo9bhVWo6HTE/SasLYu8l1vu69LEg5RqlZmDO
	KEqOMGZaAI3tahb8aunPhyTP7UQiH/Hvgo3UDOh1YdCLi/hQwP4KKajLsY7+ZVrVXi2rf6HSobX
	n8vd2Hs6jpojg7YZAU3+Of8ThtUwgFVqM6ntpsidnXmxE0VXQ2Lo2MnW8CrfwMY+ahb686Z/qOx
	wRH7nbQdmIXrjQ==
X-Received: by 2002:a17:903:883:b0:2b2:9f45:2266 with SMTP id
 d9443c01a7336-2b5f9f8302dmr320471305ad.21.1777282673433; Mon, 27 Apr 2026
 02:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422173846.37640-1-aha310510@gmail.com> <20260423041500.2020-1-hdanton@sina.com>
In-Reply-To: <20260423041500.2020-1-hdanton@sina.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 27 Apr 2026 18:37:44 +0900
X-Gm-Features: AVHnY4I1UFGxx0A28CvrdAM8FeQdsO0M2pXwCD2tOB76rFmHE8O7ZLuo4xDPRRA
Message-ID: <CAO9qdTGbB0YzvZYv1a4irM+i+P=GHYYVF=KwbYHKXr=f9rYUPQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: rsi: fix kthread lifetime race between self-exit
 and external-stop
To: Hillf Danton <hdanton@sina.com>
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A404E470024
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35343-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[sina.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,5de83f57cd8531f55596];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.com:email]

Hi Hillf,

Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 23 Apr 2026 02:38:46 +0900 Jeongjun Park wrote:
> > RSI driver use both self-exit(kthread_complete_and_exit) and external-stop
> > (kthread_stop) when killing a kthread. Generally, kthread_stop() is called
> > first, and in this case, no particular issues occur.
> >
> > However, in rare instances where kthread_complete_and_exit() is called
> > first and then kthread_stop() is called, a UAF occurs because the kthread
> > object, which has already exited and been freed, is accessed again.
> >
> Alternatively the race could be described with the regular diagram to better
> understand the uaf.
>
>         rsi_kill_thread()       rsi_tx_scheduler_thread()
>         ---                     ---
>         atomic_inc(&handle->thread_done); // set the done flag
>         rsi_set_event(&handle->event);
>
>                                 do {
>                                         something;
>                                 } while (atomic_read(&common->tx_thread.thread_done) == 0);
>                                 // exit after done
>                                 kthread_complete_and_exit(&common->tx_thread.completion, 0);
>
>         kthread_stop(handle->task); // uaf
>

I did not include the race scenario diagram separately to keep the
description brief. Apart from that, Hillf's diagram itself is accurate.

Regards,
Jeongjun Park

