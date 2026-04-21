Return-Path: <linux-wireless+bounces-35192-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2De8LmoE6Gl2EQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35192-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:12:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B544074A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19D2A3010B63
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392C1372EF0;
	Tue, 21 Apr 2026 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWlr6zMq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84938A706
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813160; cv=pass; b=GPCKW4fCstAReJGu48avXxNkUz65n88oc3sv2DRLEFaFK+BTC8YTRKC0M1IhCGf7WDkA/sKM+sQxfVffJ/Fo6h4DhM8ByoQaAHARTr/iUqEYtQTPpVeBTxGm4AkYUaWd0uX7TWFR9u4oro3HxujqNVAXiWwdRVsAHKSFQ/kBOJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813160; c=relaxed/simple;
	bh=kEqeOOMJL0MyuLpaUxwclHIgWXv9VRMqv4q5M1RKiok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XO+3ort6uBjLCOMbcZLfFd/Aw5D0T4/E0kZWF61EF6LtmM++GiGzVighxttTmTArmX9EzxL0LOSb68i3FhzznLGWmpWVIXAxMVOD21yD93DHyqcbnmuGOT4L5NMh3EBUNnEufWH42yzvri2AJsuWFnXGxpeq6Sgfnq2KqRM9ERc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWlr6zMq; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-670f6ae9c7dso6514855a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 16:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776813157; cv=none;
        d=google.com; s=arc-20240605;
        b=TfMc9SZ1xYghBLbu+vRu35z6VoYQFpXl632cPY51bb5duKP/lU/iC5+DyrHCLTR2Fa
         ioZTVnMUKirtSlYDcMhttkEPkTD4t8rLyjMEUU0raXoBO5ZzAoSbIi1j2Uwe2AOCeddR
         dFtsYZCPn7aDCtxQuB9coDLRPtC5/Wy/Leg+o7maqmsy4PmdmgSbx9uZCug8xESvXgIL
         HpvMm8kjijMo61gXQf+2V/dEVc75fqie4PICsp9vH1Tn/T+Od/57S8eSYtEBjCoirSEm
         pkKtABzTJ2b4vIY0JRnM4kRgpY1CYBShn0xfCf6VraycIJqUujhnQGfNLioWWeVeW0OK
         /rCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kEqeOOMJL0MyuLpaUxwclHIgWXv9VRMqv4q5M1RKiok=;
        fh=KfHnF6BDBSSROQb704KaDmjb7Nuu5vmtmU4npgKmYyg=;
        b=M+Ss8GwWVnLpJpLSeKv3IlyCJOCb0ADL2E+PdniCV1Z9V57nB5dOVybB2WrgezAzBP
         xo/bl3eTamiUEVA2+2/sXq5sUWbBL5YIk3+a9ybE+JlPcft3BMDNmMcAMVDy/Et5vh8B
         K9rueCjgbFG15/qSZgKDJ2XlTegRr7Yj57FCl8iyi42fvMhlohbKsrgSO+IobVU4BUzL
         H1fS4SU6l2HDZIhyKQij4EIHlIzkmH99nBnkF9Qxz1VuPoZ14MnLsDRyi2CT9G9CSIlM
         3fNmTW5TG0kUZ4n4V95d+w+6lqsfxHbYz/awUTFelU3PFJawP1W+Ti8SV5ePXyeCzBf8
         XD/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776813157; x=1777417957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEqeOOMJL0MyuLpaUxwclHIgWXv9VRMqv4q5M1RKiok=;
        b=YWlr6zMqeGj0Caw8FxwX9Htw3VYPgUrscs6b5bHq0fdKoca3ogRO0SvAfyZAZ0Ic77
         b3rltOI2tU842gMqO3q456usKvVPDl7xXyvHf+dQQD+iYuqZXhvq1aJaaxzAD02FJh0Z
         QVfhrVE3Iy+Ek6zyWdUQgrQFQJuTY3HZMWABiPlWZ0+xt64AOnyPlzPCzcmIcgdTso9j
         PxBDwEMtlXJ9DFJtDfli6CWWFRlO7RVp3c38bzT3ff3L6+6s5YYPE9QNlivg8cNp/0MH
         JIg9+UU71y1ubgeSpivxU6ury5CuEUkQGLzMragZ6uLQEszxPUuqdRWiVvAV8b6pe8Lx
         OnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813157; x=1777417957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kEqeOOMJL0MyuLpaUxwclHIgWXv9VRMqv4q5M1RKiok=;
        b=c5ZrUESLm6CFVC3Vh8ETmkt4rSsm0379SFSlmA8QhdjctFCpq85/iTsPL87Ce0xCkZ
         Ho5AEE+sxeoaxSkZHDQFzjZ/EO1b/W2dvPfH7IQfXdUMwXcQdHQOD5IDSJvYm86udwLw
         v5RlxiGM3g1NjcYCvakO4es/HtLRotTOzr8c9pmwyWOPj4xCkNlDDvYqC+DxcOIX3dK9
         nwarzliI3GBsJU1bKFOwoTYlur1I+vcM6smoM7a2aC+3IjU6GfUeyVoLy06fnSELo1W/
         Fo/ysCaRXKkfHuIKZKctnG66flXDMvyhLnefsTpU5FnQb6YG30COCuQUf1dEGwZ9f+s/
         8HUQ==
X-Gm-Message-State: AOJu0YyZRJgWHakCFMNITWUm2fVhAajMMlZxQEWaSOy8KXGc/q4rWAbD
	DvsLFbtt7Qr0ZgOdqXQn+DFAGVUNYGshaaML+beWvzycZ5qbykU78jMVwXM5cXmFlES0A5XVo3c
	rApCWBUhtr7jOnXQTeQ6BM99n7LRvmQk=
X-Gm-Gg: AeBDiet9IeTBq8ZLTCciSFQALm84fy0WwZa2eeVdGGI6G6W5iJfuZQnXVM+E69sKXPu
	9w6yI6m5pI2/MDt+iIOcEwKIcmUOL7s7YBPPjHmWVLbWJUlLJW28IilvvwTSOMEAY7xwMJkHl+L
	P60QvRNDK+Z80hlccI8jAx7bNQG0LUUgAT2b1PNOLQgy7khHhPIzF44dLNQfWBIUowA+KNlphJm
	/psDccE5iH/JpgJIq99sK2MPJGM3KE0FjGCmPsAtffmicSXblLMLE93HOVr083vk0ktSMBW6X4N
	t3YDCHG/tBGy9YhFN6U7B+o8FfwD1kNihLLSNUev0hMU0ZYp5VAB1/d+F/3R5GymGjiaCqXvLV5
	RP4mnVxSzJPmwDHBbW7gU5DhacDfbcZQpu4AWh0q8zjZk6+ll
X-Received: by 2002:a17:907:3f16:b0:b9d:6d06:b78a with SMTP id
 a640c23a62f3a-ba418985765mr855604466b.17.1776813156675; Tue, 21 Apr 2026
 16:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313001608.118294-1-rosenp@gmail.com> <ebca61af-7873-4a6a-aae7-151e81b328e5@oss.qualcomm.com>
In-Reply-To: <ebca61af-7873-4a6a-aae7-151e81b328e5@oss.qualcomm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 21 Apr 2026 16:12:25 -0700
X-Gm-Features: AQROBzBcYSBBxPxgApn-xQFzTqpKuD71x22LJW6s29Kys3ic7Z6oH4hLyooD4wY
Message-ID: <CAKxU2N--N9psvqkoHetoz+o49ipBxfTT_gP23zA5Wd4p=+nDhw@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: use kzalloc_flex
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER" <ath11k@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-35192-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D8B544074A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 4:03=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 3/12/2026 5:16 PM, Rosen Penev wrote:
> > Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> >
> > Add __counted_by to get extra runtime analysis. Move counting variable
> > assignment immediately after allocation as required by __counted_by.
>
> can you update this like you did for the ath12k patch?
Done.
>

