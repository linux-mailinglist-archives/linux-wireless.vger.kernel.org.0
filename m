Return-Path: <linux-wireless+bounces-17263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472BEA08098
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 20:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739953A2E69
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 19:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A0F4A2D;
	Thu,  9 Jan 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM7o8nPQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506719C546;
	Thu,  9 Jan 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451230; cv=none; b=YCrZAdnzkBBkIvVxSOrslUGwvKvKJr/jvJ4MnFeU38Jf8XxHzEqlvulbR7gB3Knh+1qikGSXO5X3grvnqNpBcVJolumNIsoIjFSOlughksjsXRTF0tjhpzA3Yov5LiCRO7S0CjSqjUHnWOoRgDynUHqo4VlBF4kEyjm5m6lKzgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451230; c=relaxed/simple;
	bh=LiTghVlpVfqi+yIf9l+T+Iqs+l5ny2gEyu9m+DHHRPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuDqK2+C7fFl+jB3jmSyERfmSA8kQlnqmMjVmOygHpoA0kCzhP9tiaAMJ/a6XJe34pTpAgbNsJH681WvYNfw4ClgWvU+KnhiHuuYw40rulgK9v2+1uQO0rRqnm1xQ7pPX9rR8BeNxL0f3fFjOx2vr6NfVGm2X5W8DKKOy02CeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JM7o8nPQ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e549be93d5eso2238205276.1;
        Thu, 09 Jan 2025 11:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736451228; x=1737056028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dA3zIypL6Gwa2GIMgQQQTF7+x228hj9iS9snOP+jNU=;
        b=JM7o8nPQivwu1RF4nN3RvKsRGaodx14NfDM2HwumFEheXFXEotHgyu6fIVp3x8VTvX
         Qp75jzbQwcKuRTdAR3No+j3jW+k9VVA0OmzoMZE6dCtuH09Jx/SpTbRmKsNPuaTgC9im
         OP7G8kafqd+rp12S5dm3upyetAFIbRluG/XCnIqxf/Bqk3Mk5gkNZGzC9OQgRkH0Onxo
         OYChhVw6oGyPLsCY/YuaJdztznE3Bn6t7wRUIcCgvFve1VXxApZ7XvhJnWco2HtKRbCJ
         YacTGoG8BIwL2aQef+MESb5e4+s8p7nC4VgM3KqXnEap4YWqYNEHbcE7Q4GzNwJMCoP8
         G0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736451228; x=1737056028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dA3zIypL6Gwa2GIMgQQQTF7+x228hj9iS9snOP+jNU=;
        b=AsChLi8tJfUttm8aMaO3TsfCLIYhJrRxohxJJlrmcW/mYdHH2cJvCl/1TUIYcgWtsl
         9/ztZCiG8NFl9OKyx5NoZfLSUQFisU2pJUUnaqXbAfs3Ggzwg1O4wnX87Tov0k+hP/zt
         XJIbivvF4qj/njFKptPUuUy8uWDaileuP1XYwm3mDSr/wZ66qZFVlIq5KY+RNuW3pKX0
         15KmSuRdoD8cYypye8F9X9DG16yJ7GSYr1ulrdV9RsG5rE9XBZdnF1KUsRb3nx5MzKs1
         1tBpcgwNtk2zuBI8C8Rf08tFmCFEi1KrV9UyIfCgNtRx6uufmSIwCYRBnPsQU77ebNnO
         nfQA==
X-Forwarded-Encrypted: i=1; AJvYcCVA8uL7n3BJGPGZOobetXqrhUxIlDxGB5Y5+BZtL2MqTvHWdoAwjeFSXW5cvP0ZIkF+DJx2wbKe4YAtK+w3KA==@vger.kernel.org, AJvYcCWfr7lSnuhGRd5ygpknR+7NQou/SjK8lPLcDGRuSBtPlp4tIJynRzU6RcaHN1KquCiM6aNJiHFA@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRwHYDU2MBGPHWNwL47izEuZuTMYIjzvRgEjcLzbroHFtst00
	OrMHrWttiAYE59SXdfDGjjF42LFRbqBijsGeqUKT9KhoQarllSYuxap0KH98pE3h3OjjgcAGNWr
	nZW8dipG6sHq2XoG8r8l5Yauax6Ixaw==
X-Gm-Gg: ASbGncvzgm+MXAS1TV54OBe8o3Ir0rk9HwuwP7pg2wLy0XUILbr83U1e1JkyWngX0Me
	0B1e2BROdYhV3sh8i2GsFEt1gOXOjhdhR4Oql
X-Google-Smtp-Source: AGHT+IHbOmNz2pkwNtO4OWloFbUzTJ2jp9X88FbeQubBNrpy0kVpUrYMfFyHidoIE18PwrgyCgomNXPd05TB+PODS6I=
X-Received: by 2002:a05:690c:4b88:b0:6ef:c5f6:2ac8 with SMTP id
 00721157ae682-6f5312d6ec2mr65199397b3.27.1736451228115; Thu, 09 Jan 2025
 11:33:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109155201.3661298-1-marcel.hamer@windriver.com>
In-Reply-To: <20250109155201.3661298-1-marcel.hamer@windriver.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 9 Jan 2025 20:33:37 +0100
X-Gm-Features: AbW1kvYSfv8ts4rjWkKIR9MpLXva4s9JEBwSj4NBtRm-OisZz5sGorxlOdTNBVY
Message-ID: <CAOiHx=kVXbKB9VXCZzz-2vmBi+wRBdWGg6HUFcDf6j-aQMxoVw@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: NULL pointer dereference on tx statistic update
To: Marcel Hamer <marcel.hamer@windriver.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 9, 2025 at 4:53=E2=80=AFPM Marcel Hamer <marcel.hamer@windriver=
.com> wrote:
>
> On removal of the device or unloading of the kernel module a potential
> NULL pointer dereference occurs.
>
> The following sequence deletes the interface:
>
>   brcmf_detach()
>     brcmf_remove_interface()
>       brcmf_del_if()
>
> Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
> BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.
>
> After brcmf_remove_interface() call the brcmf_proto_detach() function is
> called providing the following sequence:
>
>   brcmf_detach()
>     brcmf_proto_detach()
>       brcmf_proto_msgbuf_detach()
>         brcmf_flowring_detach()
>           brcmf_msgbuf_delete_flowring()
>             brcmf_msgbuf_remove_flowring()
>               brcmf_flowring_delete()
>                 brcmf_get_ifp()
>                 brcmf_txfinalize()
>
> Since brcmf_get_ip() can and actually will return NULL in this case the
> call to brcmf_txfinalize() will result in a NULL pointer dereference
> inside brcmf_txfinalize() when trying to update
> ifp->ndev->stats.tx_errors.
>
> This will only happen if a flowring still has an skb.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> Link: https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gm=
ail.com/
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index c3a57e30c855..cf731bc7ae24 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> @@ -549,7 +549,7 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct sk=
_buff *txp, bool success)
>                         wake_up(&ifp->pend_8021x_wait);

Here is some additional potential ifp access, which happens if the
ethtype is ETH_P_PAE. Should this also be guarded? To me it looks it
might also break there, just with lower probability. Or is this
impossible to reach when detaching?

>         }
>
> -       if (!success)
> +       if (!success && ifp)
>                 ifp->ndev->stats.tx_errors++;
>
>         brcmu_pkt_buf_free_skb(txp);

Best Regards,
Jonas

