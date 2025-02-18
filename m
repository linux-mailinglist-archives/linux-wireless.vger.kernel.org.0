Return-Path: <linux-wireless+bounces-19089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ED6A39115
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 04:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44141893B1D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 03:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6D1494A9;
	Tue, 18 Feb 2025 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnDg1xa5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE679475
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847772; cv=none; b=B7OmBlVMBleff7t+aAQKpiqzS9Pqgdn7lnw2A5Yl524BJRX2LrIloyqY/zBXfs10ZLAIOyPDcRkYqiGHTwNjXclXcby2XAsxKGeCUhZKnV6o2ewnwbSeR2afDJPnSCw8+KnJDymeOIMQGDX8E9oZ2QzCG5qsivONTjEtbdD6B88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847772; c=relaxed/simple;
	bh=rbrSE3b4myrVtCz0ihbcW84Qx58kmQ2pCGkaTwMhnFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFVBws72Dlh/wyeFp+9rOHjotbrBrx5kYkPhO6drDgAiyhVC+yEWWisRGgZ2zJnlwQRMlUmQOiF3p/Jq3zYoEfHBfD9kphhlE1UT0KrLdqYjH+DN+U2+Q/vlaCEbyaEGeIk7XDP5NL8z69dIbojDZ/Qmj48FqWj4ug94alKlTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnDg1xa5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so4825644a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 19:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739847769; x=1740452569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rbrSE3b4myrVtCz0ihbcW84Qx58kmQ2pCGkaTwMhnFQ=;
        b=bnDg1xa5CYmoFS6VxWHJ7sHwK5MZiAP4dnTjuBPPw5Vastxs3Hfy/8iakWiQhg78SH
         Fk2Fu4g0xPFE7yl2s7bT76lhes9SQSogYmDuguqMz4TsS7paK9CbnCmKsr0bbX4pzGcJ
         PgsowHgju7Zw4NR9rlke1POW+hUlO4utL2K/ERkAGsC7c/E4kdzw/ME4IeDBbznzZkLw
         HEKXjGwLMc0fxzIWeR4+7Ck36/WaPmqNMkA8P4SaSz6bgXiWJelhd1XF7DmrUQOQOUYU
         Lb1zhwkUQISwPDNzVIa+7Ar8BDduQ5uR73BAJ+x9hJom2sOpDX+02GJDIPG0vO2dUU/e
         A4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739847769; x=1740452569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbrSE3b4myrVtCz0ihbcW84Qx58kmQ2pCGkaTwMhnFQ=;
        b=ekAsv0HmzOcXV908tkZpxS8CoFaFkgUhQY/SJ/LhTdIb5ASt+JYSfmhYRdhYmXRc+A
         O+JxSlAXLJ2Wq0pTVJuTdXciTOmRVSzr4D6tdSgM6HPCDicPU1CUx2C4HVfCXoM3v1Fk
         9Wn1Oc/E60NdyEMQwbZm9c8oOlEHgkHux3/wBxYzn1IoMgtOPhR9bjwntNppuJEUB5pf
         BAxfWaDBQOlB5Fm0PXVWGvm85gE4UE+1T3MbeR65FIPPDshMWfiAz3HFGJbOx2HYL+29
         wrmEGlVtnWWyGIV0IdXlcOfodUQ4MJ20Djd+GyLOQU46I99apW7MiaOcNwy4210KiB71
         jwrw==
X-Gm-Message-State: AOJu0Yw6TRhjVvA5fUItwmrQ1fgB011/0ePPr0AfSj1fQaZFqESlGB/m
	BMZ3mcS8/aorfZHRPabp9XM+S4DVRjIwRzrdjrX0mOK7DuzY6etRHocU9ubX8EDGV3oG6by8oJW
	Eay3QxQNOJst9O7Qvv4tOHCsWbvJlXVypaP0=
X-Gm-Gg: ASbGncvom4RE/Gs+3w2wg6kmFFjBWzRMQ99tMP31ysfTCGhwYX2HjMjZx6jk2WiSWGt
	9tX0/4ZbCpc11HqmErgzCjyxSCZZN8GNbd1lIyqvgbgT1doTquZIzP/9oV4HjeLyRmmrHe+yF
X-Google-Smtp-Source: AGHT+IGQOuA3vSVfLjXQFCQLYawVRj5ioZOIZ0Nt4+/MD22rqWQc3SHuQqmcvKVrg2+GMaGILtSNiFD+6kS1kuiIoLk=
X-Received: by 2002:a17:907:d08f:b0:ab7:da56:af95 with SMTP id
 a640c23a62f3a-abb70921219mr1160197366b.2.1739847768894; Mon, 17 Feb 2025
 19:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9ccf5ba-c091-45c4-9283-970bfa4f1afe@mobintestserver.ir>
In-Reply-To: <c9ccf5ba-c091-45c4-9283-970bfa4f1afe@mobintestserver.ir>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Tue, 18 Feb 2025 11:02:37 +0800
X-Gm-Features: AWEUYZk-d4cFmEZ_LVY9v90r5Qq-m7sMi2NWFaSsR_SUjLlH1iOEdXURLn_2H0M
Message-ID: <CAHrRpun-cZJj29+0XFkzOzZMqpd2gCZCbaLhOWEKLCAjuFtQ-w@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Iran (IR) on both 2.4
 and 5Ghz
To: Mobin Aydinfar <mobin@mobintestserver.ir>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Mobin Aydinfar <mobin@mobintestserver.ir> wrote:
>
> Hi. I checked the wireless-regdb for Iran Wi-Fi frequencies and It
> doesn't have any source. I checked the local regulatory docs about WAS
> and looks like the regdb doesn't comply to it.
>
> The official link is
> https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-0050569b0899
> which is inaccessible from outside of Iran.
>
> A mirror version is hosted by me:
> https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-doc.pdf
> (The relevant table is in Page 8, The document is in Persian).
>
> A translated version of mentioned table is here:
> https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-table.ods
>
> I'm looking to update the regdb but I don't know much about Wi-Fi
> frequencies, So I sent this message as a call for help.
>

I made and sent a patch [1].

[1] https://lore.kernel.org/linux-wireless/20250218025957.13818-1-pkshih@gmail.com/T/#u

