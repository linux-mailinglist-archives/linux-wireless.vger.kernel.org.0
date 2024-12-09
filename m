Return-Path: <linux-wireless+bounces-16116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9637F9EA013
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 21:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CE8282802
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAFF1993A3;
	Mon,  9 Dec 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpTDpgru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB01991DB;
	Mon,  9 Dec 2024 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774911; cv=none; b=CRgzeDZqGsuJYWdx2DpOXH6A9pukXC/+rYyohsiiYyQc9bkKtnrjuHENn4FIAT6p5/d5XMbnoIbbh5/WilSQgKQduoSMIa8fX+arR79CV5VXzawvAtYNQ0UUAdATF9GvxDiILfPJ2/a/Zk8YBMNNoHiGkRDhs28c8XHALejjxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774911; c=relaxed/simple;
	bh=/eyyrQhI6CrTR4nLtLXh0b7NqouJwLAL2kJDuVkW1JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Af6FDlVpKsM4ucZravlQSPALJ83YoJybCDvJLbdBPjc35IlLpzFbVXBcnsPExBKtC80pVlrDgM2R6m9oBUL7SAyDyIGn7nBXmGVLOtfOOGl0B670WGisDjqSaHLiUkbr7VeRmBxd9mrGqLgQR7VeMByiaVkypfB/m8YnWTrclTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpTDpgru; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29e585968a8so2852095fac.3;
        Mon, 09 Dec 2024 12:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733774909; x=1734379709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpSA3c70868rkQa80zun5/bralELYwg5L0qKNBXu8ME=;
        b=MpTDpgruum9st6/h5yhmPuj8qIkvefHf1wIlRpepCyyh9WAaP+c3LS1HSKQl23GfND
         RWHAmecf7hs+/6OfUR45NDDRwLokE1KAVlXV2EesZ9eRXE7uOTvPVZqlbiZBmStz1+qh
         jHdAyTRkyKImhdyTi1pZJ/nr9Wm5QUf4Q5OiSYO/5SrqOEpIdXoG7Hpa+L0EqsdngWgM
         cMJI5u4/E8Du4r/6bPUyFi96J4KsFCqZkGbOqKmcb41kNaPkh4GTyHqkyUWt6g8jG6lT
         ZiwocOpMKh5fFLwBPwDD3J4WKT7Dc1/DUCFEbrtMR31iCxDru0+Z6GwLqJVc4LZjOKoN
         +zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733774909; x=1734379709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpSA3c70868rkQa80zun5/bralELYwg5L0qKNBXu8ME=;
        b=pGWnuQ8eRM9QRaxq/TTrEWC1+cB7IS8Z0f5xeAc+2xlcEf6rPw7k8cB3tCRKkRRGD7
         WqfxomdCcNnR1Rbb/x1dCmaaQZdx4IWOSIeHVNN8xQCxRdflHgpzP8HE1iymmMlEDZYs
         0o+s85jwq57u5STvWHW5LqQCY3F3cAZAEdJS/NCkyKD6FbHBp1P6PfyY0cn88+Ft+T0i
         GEGYzFmJ6gKc4xhVEBGJ/lWq/rp0qP/txSP/OAHmCTSfVou2YafToLjzu77hdOjrM5bB
         eeUkIzPzwTDajd1FcsAee+5AXZa6RHJZGokb7tp+ayNobx8MioZSvjdkMZJh14/LZGCC
         dKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfX+r2SRqyMStu+6SRyvTnVisSAM1VP+zqYlKGDKMm1n4msU9vUlRku24EVV6di3m5i+7o5wHRmQfExrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKiW487IuAvhCyWTXemZBjsshNXQoA1e5JnwGIJGwtjXXD31QR
	5HMTC09Y6MbJB4gi/CCU5qCHDyxj5s2zrI7dY3E5IVmFT3w019jrhhKzy7vFxot7FMbgjus+vW0
	ITrCh0/XPRuwwXrWrAjfSh6LZXkc=
X-Gm-Gg: ASbGnct983+dDx+2Vr5yiozkE+M7zxquPRpCyYyxQkhAAdYzPR2OPc+J8Hb1uKoFpBq
	XyEEpWiMyzL/ms/2NUWuqI51J8ZkquwVG5g==
X-Google-Smtp-Source: AGHT+IFihdqariqJEvsKT4cJi4EG8LL6wAtWLTw19Zq3KExJrPDPu+4WUJifbf9vT6jNFqnOM7IAdMTRH98ocBd0pHM=
X-Received: by 2002:a05:6870:be89:b0:29e:6c6a:e7e7 with SMTP id
 586e51a60fabf-29f733478a9mr11363826fac.21.1733774908875; Mon, 09 Dec 2024
 12:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122180435.1637479-1-alexthreed@gmail.com> <be2f054e-5ff8-4fcb-ad50-0dc0d5c03bf5@broadcom.com>
In-Reply-To: <be2f054e-5ff8-4fcb-ad50-0dc0d5c03bf5@broadcom.com>
From: Alex Shumsky <alexthreed@gmail.com>
Date: Mon, 9 Dec 2024 23:08:18 +0300
Message-ID: <CAF4oh-NtqAX6gqz3DnLes6oR3RhZyOEvSfOk=rPPPm=1XzGAWQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: remove misleading log messages
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Kalle Valo <kvalo@kernel.org>, brcm80211-dev-list.pdl@broadcom.com, 
	brcm80211@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 2:02=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 11/22/2024 7:04 PM, Alex Shumsky wrote:
> > Currently when debug info enabled, dmesg spammed every few minutes with
> > misleading messages like:
> >    brcmf_netdev_start_xmit phy0-sta0: insufficient headroom (0)
> >
> > Do not log this when headroom is actually sufficient.
>
> Thanks for your patch. The message may be misleading, but it is actually
> information that we need to cow the packet. The zero value indicates
> that this is needed because skb_header_cloned(skb) is true. So it is
> still useful in my opinion. If you want to make the message less
> misleading for that case I would be happy to ack the patch.
>
> Regards,
> Arend

Thanks for the review and sorry for the delayed response.
Do "%s: clone skb header\n" rephrase make sense to you?
I have no deep knowledge of this code, and if you think the original messag=
e
is actually useful, I'm ok to leave a log message as it is.
Initially I had guessed it was an unintentional log message because it has
misleading text and logs spammed every few minutes - too rarely to consider
It as a real performance issue.

