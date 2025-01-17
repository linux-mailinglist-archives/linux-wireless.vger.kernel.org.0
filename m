Return-Path: <linux-wireless+bounces-17663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2892CA1580A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 20:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877693A23DB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 19:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5135199FB2;
	Fri, 17 Jan 2025 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgBTFLdN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFD25A62F
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141427; cv=none; b=b5cwygd1TwxA3iLHhOKPnPIkfUIfaKZ15JIEI4Fnx4SP5ShXlb0Un5zObDrF7lWk2n6CQQCs+421rjgcZOmWCxKE3eB9aZH56IiHWk67PU87xT2zuElT4iC/1W8GMzrUzjY/58RbuDU6rRRBAFm6YzaAwg5HEKzx8Pk9L8WGwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141427; c=relaxed/simple;
	bh=9cxvKQU5tEuWef2ZR6szSgBQXshTqPB/bp6pTKZegRY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Yesp2RCoiwZy2DvMgFrxtxmUe268hz+L35KDeoBGg8SCExe1tpldqn9/UDtfFX55FM8SX+o3k780a6VfLLWIVB1V4b+tYeFh6JKMYKuhmLnME6yV6zZMduN4hhaOtxLaeDFfkVQ3HK4uIqycgR1WDFdLraghu9XllFztfMy0xMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgBTFLdN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436a03197b2so16826755e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 11:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737141424; x=1737746224; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cxvKQU5tEuWef2ZR6szSgBQXshTqPB/bp6pTKZegRY=;
        b=PgBTFLdNsFzGhP+TSf8i9f9tR1geiAd1p0D/l5iITY7nCbOxywiuahaERRLSV4Evk+
         14/EbFEIZ0FP+s9sbQVFnHByTYngOmzHhwiOTyj0I90hbjxL6/XA6xMRk4aAbYzc0RNk
         Sd2y9s/aCP76me1NvCiscxrGoDouD6MYFlW85udEUPsJlJxVzBcJu5h6INuIjEMN1pRN
         8uxORIsBsTICBC54D5LAwRXTggbmLEE38QVFC5vvSOcinj6H95auXgDkpJfqJ6ackA8N
         hD4gw32+otsWVTI4zNbU2ctXRTMF5ebUsPhhcBXI8zyfLA0BXu8TjA1W5Jj/PC5XKVKo
         hEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737141424; x=1737746224;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9cxvKQU5tEuWef2ZR6szSgBQXshTqPB/bp6pTKZegRY=;
        b=bOEvcnl79uC8SX78E02f14ZxLnUJqpcgrxRzebVeZhxyOhiPyGNTPfdi6Ld1fR1pMU
         fQga3GFUTyE4rqaBLAR0rgNdK9quRgIfADupLccSlspUedBNpwcZYvnVyt5x1Qf2h/IR
         YNTBNWGQ3dN6lqUszvBTYOdRzuuDUbYqPA76D24lvxy7TEdrwupu4TMSmSlzwGF4P0Tt
         qul+HDB5P1nw8Cmt0aU54bDT2Y6QssjyVitoZCl9zyAiB2grvoiXBPWZLRSxinfbOBy7
         VRfcSq7pWksaKxjomucc635oJ9RRA3FT8BpQRrsYtW1suC7WltgInEzsRBXaQz1dTFgt
         BCGA==
X-Forwarded-Encrypted: i=1; AJvYcCUdxe6TVzkbD8VLjgpEGeH9bVHYS5/ajj1I1kvQ9iARRIa0IejWrXYW/2zdBq49k2W8aKFcIVZEIL5haXyYBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82Uq7la88UjjYFkWVZicifl/QO2k4MwRGtr2tWGF8J2qSpSjx
	KpOypenoV/JqaqZyepuXbJnje5m/aLU55EVQYXKUnmvP673+3Zos
X-Gm-Gg: ASbGncvDHIgMZoOyZi1Y7QSMz6iybTGEeboSy25B/D89hzETx/2G8Wb664NhHPro9Km
	P8xESme8wAxbeTr7zYFMzjTkv294pX3WJ2/xajOy7Koo9FL/siyGACzRV82MmjBWpxsax6BnWSq
	1AwWXwSXQOnbKUU4V292SFHLBIOMjsSrdNVnUBcXj3/Op7NRN5oKXjrru7y+SGNLQUUKCSy2Enj
	MCdbkGOuZE3SoBUHwN5BGiR7+xAWAaNmrn/NVh1J61jRWu8xDwPeTBJlmkpVJTRYZI0T2rUmUM=
X-Google-Smtp-Source: AGHT+IF/3Pew53rNIqs/RtMzp/qLGa4PToXW9cQ2P+5l0NX7kQf1/hu+Lld54hUYFKG/9d7bC+IZDA==
X-Received: by 2002:a05:600c:3b29:b0:434:fe4b:be18 with SMTP id 5b1f17b1804b1-438913ef951mr41355125e9.18.1737141423938;
        Fri, 17 Jan 2025 11:17:03 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041fec5sm43798465e9.19.2025.01.17.11.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 11:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 20:17:01 +0100
Message-Id: <D74L8O64EGM3.2CXM7VKQA8O92@gmail.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>, "Steffen
 Moser" <lists@steffen-moser.de>
Subject: Re: Potential Broadcast Issues After GTK Key Exchange on ath11k
 with IPQ8072A (QCN5024/QCN5054)
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Kalle Valo" <kvalo@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de>
 <Z2Q9POuV-6MIdzRf@pilgrim>
 <b18ede18-0c33-4d14-a7c5-0066cbec39c9@steffen-moser.de>
 <D6VX7M6MGZQB.3LU3FBYJK6CZH@gmail.com> <878qrkdsr7.fsf@kernel.org>
In-Reply-To: <878qrkdsr7.fsf@kernel.org>

On Thu Jan 9, 2025 at 2:25 PM CET, Kalle Valo wrote:
> "Nicolas Escande" <nico.escande@gmail.com> writes:
>
> > On Sat Dec 28, 2024 at 11:13 AM CET, Steffen Moser wrote:
> >> Dear Remi,
> >>
> >> thank you very much for the pointer to the patch. Sebastian integrated=
=20
> >> it into DD-WRT. Now the DynaLink DL-WRX36 runs absolutely smoothly, th=
e=20
> >> WLAN links are stable, the packet loss is gone. No weird states anymor=
e,=20
> >> independent from the group key exchange interval:
> >>
> >> https://data.saps.uni-ulm.de/index.php/s/NLNpWqjc8iGsaEM
> >>
> >> So your idea was a direct hit! Thank you very, very much. Several mont=
hs=20
> >> of debugging have come to an end...
> >
> > So this is at least the second time this commit breaks a setup.
> > =20
> > @ath11k why isn't this pushed to mainline ?
> > This seems to be a clear regression, so even if there is no need to rus=
h things
> > in the long run this still needs to to reverted mainline right ?
>
> Good question, I don't have an answer to that. Could someone (also
> outside of Qualcomm) send a proper patch ASAP so that we can solve this?
> And it's good ot include the link to this discussion and describe the
> symptoms the revert is fixing.
>
> This is the patch in question:
>
> https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win=
.wlan_host_opensource.3.0.r24/patches/ath11k/350-ath11k-Revert-clear-the-ke=
ys-properly-when-DISABLE_K.patch

Not sure if I did it the right way but it at least is here :
https://lore.kernel.org/linux-wireless/20250117191455.3395145-1-nico.escand=
e@gmail.com/

