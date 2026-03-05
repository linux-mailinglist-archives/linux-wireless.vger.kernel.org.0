Return-Path: <linux-wireless+bounces-32566-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDi4BO6yqWkZCwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32566-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:44:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96722215889
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 531853035F7D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC973CD8CA;
	Thu,  5 Mar 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JPep7WIg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5713D7D64
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729064; cv=pass; b=IQ0ZJwc1HM49oPTEJxvNjx4kGOXIH1JGjNCntfJXGmyz6VxEd+cXz5TF8SkTf74Qux4+YhBW6WoSBCTXHVlX6YKAnvGeF4CZ2KeSsUbJxLroyYaAWTjcf4yIMxJ6V0Msp6Vq6sZMA/B8YARDaOeScj9hnRXU6fqsZ8wnHHrj21s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729064; c=relaxed/simple;
	bh=jw7rPzJaw0jpp4omD8ibMqUnPeX0yTiYUFSzoP3G6wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtzuAOyILy3N30LcGqsidtcPihqqWLRP4I5bWjqVGk+qqnkUrAl5QW7+EatByau1kVK5R+mb3/7SUZyOlrvyFGGiDkBoGQVa5q7xO18fSOtq6y+PxpYo1oH49oo2cZgk/v+37ccX6tCasSj92VQRJpDiy0CyVi9qekCX7aiIJCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JPep7WIg; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a12fbbd9d2so1046711e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772729055; cv=none;
        d=google.com; s=arc-20240605;
        b=cRFiqG0DJPzDbPj4jykiDpQf6hkobjxGjpOTxiafYqiSf4OoKjNT6WLYeGSuQ27LQG
         yInwT+Uc4GnfSLVwT7NohEpq10vdje1CQnzNROpUtIMchLJpqSU/416oSkuLSMF46Qv/
         eyN0UVzsWDtQQWUduWBH8ChRJNj3q3G8DAiijYOR3SQo0k1jOJ1IpqgApUhrfpKx6tSS
         LAKKN/WkassASYb65ApGhVXrqKY9uCPxJ8pYGFwNGPPFd89czJSQZNebzWsox07QU7WY
         OmoRM9zxBH+lC5xqFc1VBpURpI1RfbD5wyLeO96XuHOvFBdB1V147t/tYO2WRU1/rAvy
         BMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gday6PXWiSStbW+wQY+pFXsEeMQFha+jnlkFCWPbeVs=;
        fh=dpFG1Ku7RhT8OS5p5C/ceHKsNUYs2kuh0WAKBMCtWmE=;
        b=bwXA9MnZuP4VbGTNV4fH0ALKc1idtK3uvqmPo+ULydMUKh0adIkJtr5N3ySCbidTS7
         Bx6XUC0PWr48CAWMX+RRP/Zl3idTEin5mWwJkZdpm9TDA1QqId1jEHD9tiMIf+6/X+4z
         k3lkrE4ZUZA5Xb8fGwbRmD5Zl4Wv24D+B913wBF8cL1K22+O8COaoJdrkMTAUWF7QL1V
         W45WB9daogZuhNdpcROcwnSukW3uac7LyZvOAc3Rz8APsCjJLgq2nHrXmGxBegPdbBlw
         mu4T4LX5O3DV+Wwge8gudHUemdiiWnGHOGxQ7yNKFO0HtqQomZveizSMGwrFvJHWrhFv
         zE0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772729055; x=1773333855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gday6PXWiSStbW+wQY+pFXsEeMQFha+jnlkFCWPbeVs=;
        b=JPep7WIgKTkQwmUSCMu5kGvocu+fy5x9MjHGYYnM/t8qP4Ml5RX5e6GzG5jRKAtd1y
         07q8kCn7+4fQNMNgjjVJLSt7OJEyK6eaccWmBpxJPH/5TtdvRCPfWuJQUDxzj+R1Yzq4
         ibkQEnxjHQTpTPA14YwhKyDnw3geAV1oFJEMt7OF8hG5y54UYpjvwgl1KNCLOjq/4UBZ
         S213QdYqPGr6jYJ9teIW/qtLTivtOZNHCEbLARdPMYuhUfQrPKq/6edVP3HyMGg97o1S
         l0Fl8dSmyROU7EKjLxlTmXsArQP3G5Qss/FoiRyeds0lmIIuOROJtGI3Vw/ziqRx3slC
         obGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729055; x=1773333855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gday6PXWiSStbW+wQY+pFXsEeMQFha+jnlkFCWPbeVs=;
        b=o12RfDAUTlSbBA9idOpd2930LQ4yZO99z1RKqp2M1sxZ0lqfr3wvYjju/UoBuKadrf
         cQ9gJQngE4boB8m0kpk+V0eqCxx0o0S5j/NvmVwwWAvDTwuZN1chyRuYOAmVh5FO55sE
         X/9UquYDnbGst3VykBPJGWe0Gmsh8ph19O0OhiWTb3NB+bVxsX5BYRdnlA+eYb2+1tQd
         Xc/boCg6cJiOEjNCHra14Fn3V1y/D/VtIVGRnrGopJ43/a+u9Qth+s+vmzQOJQr80hIb
         QyFFfVF7oRsXvitB/EDQlh1hRFCBP4s0Q0Ivo39GXXoKQKXj+9+LG6RsY8TDfIPYmMq/
         tHPA==
X-Forwarded-Encrypted: i=1; AJvYcCU5vqyrtLMSWXai7kRzWKDkfOIjYfEdRqZA4H9wL22RdLRMo9AfBRdJ5mnatH2VgdTGGME+2iHMjFUZSLVkGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4Ntn1KPl66uSV9Ve993rOmu9eRNkDZmHGfdvxlR65udvUBiT
	5ie6dwlGoqsbi/jpAhDW1k+1Wcurh4zTPPEVdsPnx1smV0YDxC61gdlW2aFY+jD8cLeONmb/9Ml
	xCtPpro/IcYvTfX7pbVr3FW6IjWMmFaK1fpL+voFfZw==
X-Gm-Gg: ATEYQzxg2RivUwcmbVELBgw8AZQ2axcQVsgHjdm5PoysVUpyxADN8phm5IyY/L2KUh+
	HP4qhQrO/BHUaqErcYM5hCwAI5BwycQUuPeHQvFWDymIUjj4M+xt3B4YcOZdO/fpZQdhyplyS02
	CHj16xWfW49dSrZHmShP9ijvTGRL+0WTI7X18Sv1i5OToEUpLWex0/yqvS1/7X44pP2e6+grMDy
	/0Zd6oPtilUIJB3svBoPunZ6CJuEynRa8VSZzjEShNIucW48GJncP+AVJBm1QPtXU5xoyzTINkC
	qWDbdxu4uiPf3Ft+5RUCZmGwPDs5TmDMfU93Okj8
X-Received: by 2002:a05:6512:3190:b0:5a1:1e11:7532 with SMTP id
 2adb3069b0e04-5a13817ce39mr36737e87.24.1772729054737; Thu, 05 Mar 2026
 08:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113161248.387964-1-marco.crivellari@suse.com> <20251113161248.387964-2-marco.crivellari@suse.com>
In-Reply-To: <20251113161248.387964-2-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 5 Mar 2026 17:44:04 +0100
X-Gm-Features: AaiRm50xPuCgI1yMT1byYRLrmHf9DeZAqxLzJ83txdRYD9IP_EJBG3o5O-PG5GE
Message-ID: <CAAofZF5oAd18VV6ipoJDjiWvCeRxUh5KtdEZvPQ_DS71X_Vkzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ath6kl: add WQ_PERCPU to alloc_workqueue users
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Kalle Valo <kvalo@codeaurora.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 96722215889
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,codeaurora.org,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-32566-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Action: no action

On Thu, Nov 13, 2025 at 5:12=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> Currently if a user enqueues a work item using schedule_delayed_work() th=
e
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
>
> This lack of consistency cannot be addressed without refactoring the API.
> For more details see the Link tag below.
>
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
>
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they=E2=80=99re need=
ed and
> reducing noise when CPUs are isolated.
>
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
>
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
>
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU.
>
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> ---
>  drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless=
/ath/ath6kl/usb.c
> index 38bb501fc553..bfb21725d779 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -637,7 +637,7 @@ static struct ath6kl_usb *ath6kl_usb_create(struct us=
b_interface *interface)
>         ar_usb =3D kzalloc(sizeof(struct ath6kl_usb), GFP_KERNEL);
>         if (ar_usb =3D=3D NULL)
>                 return NULL;
> -       ar_usb->wq =3D alloc_workqueue("ath6kl_wq", 0, 0);
> +       ar_usb->wq =3D alloc_workqueue("ath6kl_wq", WQ_PERCPU, 0);
>         if (!ar_usb->wq) {
>                 kfree(ar_usb);
>                 return NULL;

[ Cc-ing Andrew Morton ]

Hello Andrew,

This file is orphaned. Can you help me in order to have this patch merged?

Thank you!

--=20

Marco Crivellari

L3 Support Engineer

