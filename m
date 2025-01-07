Return-Path: <linux-wireless+bounces-17148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF59A04302
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0471882B19
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF81E9B31;
	Tue,  7 Jan 2025 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2rAlumJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B61F2365
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261160; cv=none; b=gSa1ZwV51NalIRWH7xHGrHtGSeJqWEwNJ2RFFGdNwA7lVBdSzBd/7aPOve5qldjY8zUI4C5DuLzMsVvvfsPzBQzLke+nZgKywl9+aajx3MImb/93SmhdeG/gTdb9pTopeZXsCXfKZSEI1/+9EZaqNm05fZK7saHm+2/sutSyMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261160; c=relaxed/simple;
	bh=JYTLhZYs01LPTbxTxKocXSvHBt53N+BWt217JHcmGHM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=p7dDjfu65ozvD3BjvvTYFmLefw033T7g6NNf8ZD35iR+j9nefR/Fwo7waXTlvVmdyJ3cotKWMJded/Er06CqrATYp8R31v3tVC2o9HqM2RNM1lPTvIcXcLiITlcvqNpjDBlNMgTCE7m1uNge0mm4uEppAhCfXMnwnGkE1135H5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2rAlumJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361f796586so161073025e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 06:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736261154; x=1736865954; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYTLhZYs01LPTbxTxKocXSvHBt53N+BWt217JHcmGHM=;
        b=l2rAlumJVGPZwPWl8VlnJqWKF0uMAP3AMQaNiNKIkF/VWo7T44epG2g4OZ3M/o0x0+
         h/YaURkkPNKfvCIaNC0f6vvWKW9d74/i3N6b6zvpfPNmlGws5aozA53gQpv1wCP3s8Rf
         9fJPICfoPDQ5wzuJNpN8uG7J+WLrJ//rB+/LPOPtCCTKL6BE/M6Mf9BCO+fLajmcxxo5
         xOhkhlTlAxBIGzdEdBxoZj9kb2ScPBJhDKmxdoY1/lYtQr1ljs8xlo2QWjsvxvCaJzCq
         45IHRiuljx5v40LLCtzss9iBrsRXQlcD/V0X/6UMHFwf8r70MrLG5GVzfPnrkpLRg02o
         SQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261154; x=1736865954;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JYTLhZYs01LPTbxTxKocXSvHBt53N+BWt217JHcmGHM=;
        b=lZK7iThtjHxP46xY4G0P5G/0IRKfV1tDR47pVG36OBdrxahqWE7HaY2+RfGY4YWhVK
         Y6Qc4HsGTBQIYpyoKpUNMvgDkKUj4sCNwnPU8yknwqC0xhzzR7GhmSGRxy552KY9AHPQ
         YlA2ylVedwudP+iBlGKBkqEcMeWZ3W0cz8RikkEi8GqMgO1EsL+eydSVGXS8bz8wNzc6
         N0gAV+P3LbnD/Vg1gGgj1HPVrSUZPdr1iiAJX3QuV6T6fEzmWqrhQ50QxrXIGu8rKgke
         pllQmkNFjtigaXtIdQZsxZLe5RrKZzdJ3+zXMbVePPqJKr9kvjHWHDA2C4AYdqCmh8ZW
         JaEA==
X-Forwarded-Encrypted: i=1; AJvYcCWt/yQhsXkW36rgymLyO4yUlvKpBYe9Kb4HRYLx1ulLhBBL/WvNYG0frLjIv5LuvyXH6ZQI6LO0FhPzHES7cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SsH31jN60+wsaumkqCSVNvInP2jC/VldBFEEIdZlUMdKuW9s
	XrX8eRkA7BYioiTAOJsSzBKfcuC//0s6N2Odrrsm3FXclZ9WGxuGYLYLlw==
X-Gm-Gg: ASbGncvNzm8xp5B4ByA7+4qBaiN6+zHPi/0ZHFvtd7TSQeKLQbOP0Yeh8p0p8Vl21c9
	4j5XZohCXabiRhE/QfSt9tK3kokscwghy2zVStNYj96Fqh6lSabz8g7i7bVm2NSjwsE9mW5NcKf
	fRXD3Lw5JLB54FRUeJYlpkPbQTxu6dH8FneKb+o9T4I/Tq/Rs4h3dTnJlEsXvZ9qFOkrmXtzUgD
	cr5JFF5aeTGyrQea8yO/e2rCab/Qkq3RD66rUjJJVkiHI2himpK7lvZmtHZWf+d3n+FbuCVHCs=
X-Google-Smtp-Source: AGHT+IEeZKbsBO+G3cgcfYMD2OZWP3GMAhV7N+MZFaoinUVOiq0tXKzD3AdtqBUUiZQFh+Be4iiDVA==
X-Received: by 2002:a05:600c:4f49:b0:436:6460:e67a with SMTP id 5b1f17b1804b1-43668a3a334mr476528105e9.25.1736261154086;
        Tue, 07 Jan 2025 06:45:54 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661200abesm597380345e9.18.2025.01.07.06.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 06:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jan 2025 15:45:52 +0100
Message-Id: <D6VX7M6MGZQB.3LU3FBYJK6CZH@gmail.com>
Cc: "Steffen Moser" <lists@steffen-moser.de>
Subject: Re: Potential Broadcast Issues After GTK Key Exchange on ath11k
 with IPQ8072A (QCN5024/QCN5054)
From: "Nicolas Escande" <nico.escande@gmail.com>
To: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de>
 <Z2Q9POuV-6MIdzRf@pilgrim>
 <b18ede18-0c33-4d14-a7c5-0066cbec39c9@steffen-moser.de>
In-Reply-To: <b18ede18-0c33-4d14-a7c5-0066cbec39c9@steffen-moser.de>

On Sat Dec 28, 2024 at 11:13 AM CET, Steffen Moser wrote:
> Dear Remi,
>
> thank you very much for the pointer to the patch. Sebastian integrated=20
> it into DD-WRT. Now the DynaLink DL-WRX36 runs absolutely smoothly, the=
=20
> WLAN links are stable, the packet loss is gone. No weird states anymore,=
=20
> independent from the group key exchange interval:
>
> https://data.saps.uni-ulm.de/index.php/s/NLNpWqjc8iGsaEM
>
> So your idea was a direct hit! Thank you very, very much. Several months=
=20
> of debugging have come to an end...

So this is at least the second time this commit breaks a setup.
=20
@ath11k why isn't this pushed to mainline ?
This seems to be a clear regression, so even if there is no need to rush th=
ings
in the long run this still needs to to reverted mainline right ?

>
> Thank you very much and all the best for 2025!
>
> Kind regards,
> Steffen
>
> On 19.12.24 4:35 PM, Remi Pommarel wrote:
> > Hi Steffen.
> >=20
> > On Thu, Dec 19, 2024 at 04:02:30PM +0100, Steffen Moser wrote:
> >> Hello everyone,
> >>=20
> >> I've encountered a possible issue in a DD-WRT [1] setup where broadcas=
t
> >> packets stop being delivered after a GTK (Group Temporal Key) exchange=
. This
> >> issue occurs on a system with the following hardware:
> >>=20
> >> =C2=A0=C2=A0=C2=A0 Access Point Hardware: DynaLink DL-WRX36
> >> =C2=A0=C2=A0=C2=A0 Router Software: DD-WRT v3.0-r58819 std (12/13/24)
> >> =C2=A0=C2=A0=C2=A0 CPU: Qualcomm IPQ8072A
> >> =C2=A0=C2=A0=C2=A0 WiFi Chips: Qualcomm QCN5024 and Qualcomm QCN5054
> >> =C2=A0=C2=A0=C2=A0 WiFi Driver: ath11k
> >> =C2=A0=C2=A0=C2=A0 Firmware: WLAN.HK.2.12-01460-QCAHKSWPL_SILICONZ-1
> >> =C2=A0=C2=A0=C2=A0 NSS FW version: NSS.FW.12.5-210-HK.R
> >> =C2=A0=C2=A0=C2=A0 Kernel: Linux WL-AP-EG 6.6.64-rt29 #1791 SMP Thu De=
c 12 16:41:51 +07
> >> 2024 aarch64 DD-WRT
> >>=20
> >> The behavior is such that after a GTK exchange, the AP can get into a =
"weird
> >> state". When being there, broadcast frames like ARP or mDNS are no lon=
ger
> >> reliably delivered to connected clients while unicasts come still thro=
ugh.
> >> In this "weird state", the channel quality (active time vs. busy time)=
 goes
> >> down and latencies to the still reachable WIFI clients rise.
> >=20
> > This looks a lot like an issue we hit a while back. There is this patch
> > [0] from Qualcomm's wlan-open repository. It is a revert of [1]. Using
> > that the issue was never reproduced. Maybe this can help.
> >=20
> > Also adding ath11k list.
> >=20
> > Regards.
> >=20


