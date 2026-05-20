Return-Path: <linux-wireless+bounces-36714-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM1ZLVDaDWrE4AUAu9opvQ
	(envelope-from <linux-wireless+bounces-36714-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 17:59:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527F5915BF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF828308F239
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FF822541C;
	Wed, 20 May 2026 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCmG18Z+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A57233722
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292147; cv=pass; b=fCvGCIQy1AfgisIs/hL0hJtNC6egj5XJmojQ9B7MxRVitgDaBF/nlXspSQDtFHSAVu8kHzzmOBmQp9XM1l+n4DAoi9lD4wftin+58dKqEiZU2kkj1cC9twF+kpfp7tmXR6g1+F6aU/pcaSwZQxR3Uvj5MtDtPHEtVS5+BLdchI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292147; c=relaxed/simple;
	bh=WK+Vcfxjzj3dp6dqoGw0o16RV2DCuBdKYI+8+EM/S70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+TRrYVPly4CiEiQVUnn9um+UsX1IDLUwPtJpfaj5W4SvsMHqTVK6stidvKMjjiqGq3E2MXWsE0LjrW4ry4MJ6wl3UrbvfbIPX22ctohzlDl+sd2PphU0F71Hbi6YPP24t582XG8iUsbY86uknvHzlFfwDWjCDC9sxj3WvSTbl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCmG18Z+; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e568ab0bc5so5692616a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 08:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779292145; cv=none;
        d=google.com; s=arc-20240605;
        b=SGpOPGMLcZW7sL6QzjpgRT7qbciYEOZ6Q2oJJU8AWK+oQrfqTts6dI/8dydYR2T+IU
         zenMIlN2OdHWXVdDjT9of9FPRPLVyrSzO1zqJC4QkVl5Snv4kYg5AOpi25HvsE0DsnLZ
         LoDtnTgoLaJdgeDrXmX+eKKUWkhtyxqWbx04I51ziwLxiTaASk7XOFNV5JY9SsYp5mez
         KshNvcwHhrtxcBwgC+jjTcfOsYyed0zSD9vWWko1xFBM4VKgtqL7AXUsWg0f5LTcgU+Z
         aXA+JuspSglmqLcc3/elD7dBS979MFiunbH4OQaKJffMUvfnPo8UK787okTBFxu0gwBr
         n/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WK+Vcfxjzj3dp6dqoGw0o16RV2DCuBdKYI+8+EM/S70=;
        fh=eE01mNjt8UjS+CA8KEnETPQCKHecU3/TI/JYOj6Om8M=;
        b=BxnbBFlx06Xesg4V9m9qo7OKHvxzbomJoMW3EFoyMhJS0RIM8K6/hmAFfYjLFSIRyt
         kCPbUCXKQjAny4Z2hObUvq89GEWpeIrL8YazaqTcgZGZ7fjANPkMsBzpiBgAxl98UEAM
         47VFsEhjvuTUqIg5wM4wLbi3fdR4cdMAzo7mEexYDW1rj0BN7NoqaueqX0sj4ReeqWyT
         ODPNAjU9PHx82C1BbsIY8JE8WMEp6VOryZ37X7Rl0k2NaReB7tbMJyXTJpIdxL+KP/bj
         UptJdE84sTJcHnaN8pp3+YawVRiOXr1TVZXIpUtaJ2zsiaIKyxl5XaXFtSOW2Aai2KN4
         A8FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292145; x=1779896945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WK+Vcfxjzj3dp6dqoGw0o16RV2DCuBdKYI+8+EM/S70=;
        b=NCmG18Z+ueacEQoph52d5YthAwKOdR6LMMFKL0dDApFA+39akgY2QzkoKMChOSO4wS
         uD9rfQP2QlG/FOEMKjSuBb6LvDAjuuW0hqCFcd1DejGeGmnZmmM5lP5nOGWd+OctUOBZ
         NeK/1/wdW9xA8z6TyE7M9PneayM4EfCBGulxL4a22zGIKYWP8Q5wvGdsr9y9OtOERCWx
         lxb6tehZSxr6Y6qypiXUf3UFdVQsrSfrFi6F9WL7E5EQ3rltG+0m6H9U4koL6h/KjCNm
         iOYGjIvuuLyktqpqfqtST+XsfIgnPYlYHPIXCsxGQU7eKDFzz95v/s9O0JJtGRBMJuFw
         n/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292145; x=1779896945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK+Vcfxjzj3dp6dqoGw0o16RV2DCuBdKYI+8+EM/S70=;
        b=apkmkSOI4+RfcRGqOmKT4GiHPjI3GjK54/c5qlxKf866Roh9Z5++SFUoFwk5pPpWZR
         PXY9RdIWzHWSEBW9jBq36T1Gk1xYb+N+OyEa2cOIqa0so4DMjg5asLh3IHg+NdAnnr/0
         MjY5207XJABN3ML+UPqQtjM1VfbMv43b0wrDXfhNKrHW+K5N7MiPN8XdKqEoy3BXz3ZN
         1HSE/1dVC+AHt3bd4Fz/rkdBkNvHuq/YlX+LoW4KCB7KESKocrzZGFWZcYyh3+2rKKOV
         8t7QEujhKyYTo0xILByzY6M1o92FApu00J9LN7ZtqcetWwvXf+whhUUTSwx+Qov92F3g
         D46Q==
X-Gm-Message-State: AOJu0YyZTo/HxlQZqI+Vit9W5jooI+ITbwiC+S4ggZuaN+TMgEp0i46O
	eLQJD0Nh6CoCV3ac9oyB8iPN0UhujuPqXVRtOCTTmtYnfYF1/uXIyn5zHnPnh6r2sqm31/v10fg
	Vt1DhjOPpNGS6iGfiOlA4yIQJINv9EwG1Yn3RicFtWXRj
X-Gm-Gg: Acq92OFz+gNRLzWHC/wNGEmIm0WgsKK52D3wlD06V8waYrCnYq55iGgeBoxQOhv0xlQ
	1p24ckINMcsIwBf/rVaz9W+KQtgQ38m0ve6VzoTYRntw7qTBZcG0ake5wd7B205WM2IX+6eJ49j
	dA1asy7VtpLWQcKBiE6Z3hKIAf3d6GFqJnHvr0KGgZOfrBpyCo/UpulpB2oCdH1a48iN/bRyCYx
	wvR/0CmrT8Zh4qTr1n8WD9hM4ldN5efm5OLciIzUROFbjZCc17FEDqeEVn+oqc2v0JYu3Sl9bkQ
	Ka/xqsnZyWCJp2sh7/EQap/vIlu/z047VgkMF5euiW4ZRAeNFrVwsxFWRQ==
X-Received: by 2002:a9d:400a:0:b0:7db:d6c8:a21a with SMTP id
 46e09a7af769-7e5e62d40e0mr31918a34.3.1779292145220; Wed, 20 May 2026 08:49:05
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5bfecba3-8a90-4e0f-9558-af5cd8a14975@gmail.com>
In-Reply-To: <5bfecba3-8a90-4e0f-9558-af5cd8a14975@gmail.com>
From: Oleksandr Havrylov <goainwo@gmail.com>
Date: Wed, 20 May 2026 18:48:29 +0300
X-Gm-Features: AVHnY4LPW1c08QSiFEkVj2cm-EUHevYvgiYjZLeP00fb3i4tPdrMSXd4KsaVpw4
Message-ID: <CALdGYqS_wo+0kiUJPTgSGNWkhYpCHtGn7jxDaHxDX3O5RnSqbg@mail.gmail.com>
Subject: Re: [PATCH rtw-next v2] wifi: rtw88: Add more validation for the RX descriptor
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Fiona Klute <fiona.klute@gmx.de>, 
	andrej.skvortzov@gmail.com, anarsoul@gmail.com, 
	Zhen XIN <zhen.xin@nokia-sbell.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36714-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,realtek.com,googlemail.com,gmx.de,gmail.com,nokia-sbell.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8527F5915BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

Tested on HP Notebook with RTL8821CE [10ec:c821] on openSUSE Slowroll,
running kernel 7.0.7-1-default.

Applied the v2 patch to the out-of-tree rtw88 driver. With the patch, the
driver successfully drops the corrupted RX frames without generating
mac80211 kernel warnings or causing connection instability.

Tested with a 10-minute continuous download stress test (peak speeds
around 200+ Mbit/s). Throughout the entire test, dmesg was continuously
monitored and showed zero VHT/descriptor warnings, zero connection
drops, and zero mac80211 errors.

