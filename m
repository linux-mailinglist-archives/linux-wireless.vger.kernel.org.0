Return-Path: <linux-wireless+bounces-30741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C41CCD1866E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 12:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C07CC30123F7
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4805036CDFA;
	Tue, 13 Jan 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gPKtIxHe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342B34EEF4
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303020; cv=none; b=HNT6YaEMKkTik43qMPTMogLr/jsdybQbYDRYWONy7RZhTRMAMnvakdJbp8fh+pvV1OLMr8xw0thpElS8i+g0+EgnOr39icTio8HG9ABs83EtFTiG8HeTOzln3anKCgOpDPhicPllae4jT8aLNYPpSs6TpB1erLWbGPZeBZ/53X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303020; c=relaxed/simple;
	bh=IXaKCDRtiCmFL/jsZIkQQPTfjbU0yreqCg8V2cgUgog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw0pXGhd21RwWssENxJ9RwJbRQN2lLGQkofgdHAqJgaSSvYnR2WQ4Q+O9MyTnT6Of9+7FZu4FtMl3nqKVM8iysjk+Zo+/wZtlmrAPJjVpXRjIKMxW81B6hPEYPxCGqhXqD937lTK03avAxxBPjTSWVres+KZ6bhC2Gm5CLQ0dQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gPKtIxHe; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b6f04cae6so6080984e87.2
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 03:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768303017; x=1768907817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXaKCDRtiCmFL/jsZIkQQPTfjbU0yreqCg8V2cgUgog=;
        b=gPKtIxHekanhpmp8k5CPeHPwwFU4+llxCu13eMc3J9t3AtDlwIdd4BAjZZYyIe0BYq
         GcGVDu844BFGG9J1niAfnl3k06/MVqrJUPpTRSaxBv1z0h7SDtOPGljpeVZBkrjuQRPL
         ewvGbLi0XImTpeEs/QbrYBYEsp/SnG4aC48z4/Pqbk98wVWEf96vLF2ZSI8bhvRp7NaN
         +D5nfyoZgSJDjDGbNuw0Ir2M2v9vjEB2IXKH3LM4m+H+pMfSYtoqJTzlkDiA93ywQ30S
         w0Srk0XYIA8JtcTP56QvjZfmoDkzbALS4mykaUOUtAD10Ci3TcVVuJQvgvsThOKjeSC5
         cndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768303017; x=1768907817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXaKCDRtiCmFL/jsZIkQQPTfjbU0yreqCg8V2cgUgog=;
        b=Ve5EWhamlDbFNcPLFC/bKhgdUFnIp7nD5agjCBZht7qk7to2WNbDgzfuFXumA5NwA+
         dOulHj/T31RqQYQlH8j0vdeqTsGRaY82GVo6Rfn1KKlM4svayis5FbjjPc85gtdsfQis
         JFKo/9waXjHk2ifLNXDw49nQPwoSMqPPJZ9VboWs/W6thpHLBLekJ7BtbpWY1cv05eyK
         8U46jA/jGQbqN70sOZS0DBr1BzGZ0Vh6WrZ1ljk24Cjmx4DvtblRLy6+zpEFIbHLjBla
         wE3JgUbEkoD2I3JCpVzmo2cgvnbH9xW88Rm2/aCQ6I20mSbXpGH0kx4rR+AKK1ZyOnHo
         4QQw==
X-Forwarded-Encrypted: i=1; AJvYcCW2s4s4QCYSk4ua1ArumYNk+nApKQKfG9TjEzE887MlDvktbRxHnyAWAzWr5CIyAYwzd9zMKoAqmdETsJxYhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwlIjpb7FbFLxwZVLi8OrVIt96LxVEBACp13TFqZQf27OVNQCt
	MucmEM95VHzdejEMyqxZu+5OeJbn1TxRZSuY/2+pUyz4Ytji7hnwuRlVH8JK8jUaIppgZ99Bu/7
	vdjhUcPUYtpuNnNyYp1pSQuTD9jamvGEO6h6r4/H+eX3u8Xy2n3+Qk68=
X-Gm-Gg: AY/fxX4fM/6cOfknuhNap3T5YzPAprUMovvHyQVUgUoPtMnp6PaVI6LbHld6EPv6+4M
	f7treBtm8IWGj6Xm8v29wVkLiXokOlLWeh8Lifkak9kVXqYqm1EnxMlS/NfdxGPQN1oSaLiSmFi
	1OVZxqr3q6Ku6xYEVsmuKIraWckhazoMNWdh/mO303YhrV76PgKK4IxK6owqb9lq5Z66F6fEZG8
	iL1qMcoIQskeGhUcGM9F+5gbxK2ySes40bTo5IArLfWfmXHdyMKoW5aqf0719EXe/taWz1anafj
	R+VmGy0xTIJz8YzxD83NvZPz/Fc8
X-Google-Smtp-Source: AGHT+IHt3d2u8B5HGegQht0R2ADB5XFc9sCNv04MoQ1Q8200kUV12VgWMukW+18YkL5qhnGPZnX2PeDKZ4zE0fIRZT4=
X-Received: by 2002:a05:6512:3ca4:b0:596:9bfa:91a4 with SMTP id
 2adb3069b0e04-59b6ed1349fmr5211371e87.2.1768303016873; Tue, 13 Jan 2026
 03:16:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113162032.394804-1-marco.crivellari@suse.com>
 <CAAofZF5yenY8Q92taaJW2-=kenDVuc6ABEtbVT5+yzM_pBVZsw@mail.gmail.com> <2f4c22558d20b42615adde772551c1bfb346da47.camel@sipsolutions.net>
In-Reply-To: <2f4c22558d20b42615adde772551c1bfb346da47.camel@sipsolutions.net>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 13 Jan 2026 12:16:45 +0100
X-Gm-Features: AZwV_Qh1i7DLhmAWyBkO4PNlzkT5IoTkbhOvQ0LGPYPoIob524QKGFcRjIDbXy4
Message-ID: <CAAofZF4Ptjmo=7taHuw_rdya-kGhEZGqXbQn8yPCi1pgA24mkw@mail.gmail.com>
Subject: Re: [PATCH 0/3] replace system_unbound_wq, add WQ_PERCPU to alloc_workqueue
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 12:05=E2=80=AFPM Johannes Berg
<johannes@sipsolutions.net> wrote:
> I have none of these pending now - if I didn't accept them then they're
> lost. I did try to apply another similar one yesterday but it was
> already there in a slightly different format, so maybe things have
> gotten out of sync?
>
> johannes

Hi Johannes,

That's likely.
I rebased now on v6.19-rc5 and I can only see in my branch:
"ath6kl: add WQ_PERCPU to alloc_workqueue users".

The others seem already applied.

Well, sorry for the noise.

Thank you!

--=20

Marco Crivellari

L3 Support Engineer

