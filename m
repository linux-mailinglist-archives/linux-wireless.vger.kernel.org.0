Return-Path: <linux-wireless+bounces-24503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B7AE8EE7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 21:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C074C4A4FA1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC902DCC12;
	Wed, 25 Jun 2025 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYJF6ZrI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215502DAFDF;
	Wed, 25 Jun 2025 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880632; cv=none; b=SneNSIC2hqtPhJ5BzWAL5yZe+SDwOEMlQIRD+f2KslOEH94LAF+CoG1ZGiLfAW/oRl6V9uQfJc/Svdo4o/prr218cEHsgNymlDBnkMOhtzLjtghgSjjCTFSUbD1YGw0Cf9atkTibTp7sKk7wWhACWO0QvgQoJj8bQyFM+f9c2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880632; c=relaxed/simple;
	bh=FQ+2YiIDDX9scLGt0YxJPyj9uRJhs7aO0tAyrIhhXmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1uZJjyHuWwZKv4hLc8TycW38Hjq5qKTfIpIV+ftRuObo1KQeICI0PcfCK9bC9W6ZDDRbzdn6KlaPSrbDI9L3Ma5rWMzpWgoaz6trGa4Anyn6kaTIQzyDQkMJl7TzMIYGpVPQuLAs12EFgnizkVYrmGPlLk4gyGFe2511xAI37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYJF6ZrI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73c17c770a7so430762b3a.2;
        Wed, 25 Jun 2025 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750880630; x=1751485430; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cO3PBcARXLOd/sYmktk+SQ6pShkzV36dVIEfKJix4Xw=;
        b=NYJF6ZrIQuNe8rIDScuqzragsQpbtYNfO1+xnvjdZKOIstK7kOLMF7gLEOgjLdhVHO
         Oy+nnOkmbIQTRSXq7NTf77f4MSTBVAVwzPCnTYsn1n2dcdMjhipSlgRCCp63flvyEc7v
         g8MUZ9Am3prJZvKlI5mBlEvR/wwlmuJymeFf0gPql0/T2PMBsIZ9VJqMed30BDC+UxyO
         MCJT+mU9bDxTlrYZXVTuajbOVtwukta25toSUOHcDTZWURc67GowsLmHUXzAkJ/z30ZF
         RmZhODwnVoxfmxN67V2HXDBX1r6EuI/eakk7TPOHh+lJs6XIOkhzwYsxqr+TfNVC1ofJ
         DW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750880630; x=1751485430;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cO3PBcARXLOd/sYmktk+SQ6pShkzV36dVIEfKJix4Xw=;
        b=QlNg2GG+pkIVfGOhEDY1WBR7rzhHSa5rmsU/BXQzjW7+JYV+pLQQKqKm7fQxiAhinN
         dM700i8EPbKC4HeG7E2HicpS1DwXMe7/42gDA8FZmq/Y9IQKkWmo+utsB4qTjhvsCbkA
         LNqueD8s6hOEM5nXbH2C1gl3rFW+vSS3HJ3dsQcqijkuDyA2NQsbZAZWJzFN4/mM17SD
         1n/y7rY0Y3FLWIOcBf18OR++wSGuHtiXPnKBrRNcOENGpns5tZu1dPGt1Xo9n1EwWVv2
         w9x8ZPLx8p13ht7MkyZ7ouPvEtF1vM57H2yq5bfaXbrt40zyTtINYJE+ilPk+AVSaMd1
         EptA==
X-Forwarded-Encrypted: i=1; AJvYcCUBIXdCSpL7RywfqWqgyuGatKA/o6hIUm4p2542jmstBa1k5aLV0xoWqYQzkBHN6huu451zHdiP2BJr+nI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtg542B95SBeevHMAdGUB9aPASY9GnfNp6Gxm4TCI0GSddJUO5
	TnkZin8JLhXEmN6iTgiZEyUr6vKK9Tum+Yiex87vjn+Id46SR3uqxe6/Fo/YCQ==
X-Gm-Gg: ASbGncuEfsd8+VOKMRxu85Ho+QPxhUxNGr5BJZw33NoFOow7PxbqBqVYinHmDmnYDbW
	SyWdLHjguJ7WNlN1eOeYiynSaBzZNLcSDu3449Gs371xkrBZLy+ObXKTThYxZvzwWfUxhytDFDt
	inmYIOAHU7G7ZLJW5Cq1l2olgBSShiUnHV42+ZM3qjLlK0Tud72F54beZZLZHOWr/Cim75uL0L8
	uzRGMqHrumWQbklOtO98pxXE9aRv+Cr1To2x0dPHBa6JwCw4avnSdBF3+V4WnYO0eAYvNVwdXKp
	CQH8bzn6KOeq+GfeJC1pBF5Z7qS4jZPdoIxBgZcHAEkX68Fx3hrCs2O8ny0ltP4AqhGHe2cyD9n
	jk49WoPmDX1o=
X-Google-Smtp-Source: AGHT+IEhUydBkMoqI3UZUfhUfnDyHW1/OUO1X1n4XWiTV71XwTKd4PIn2fvv0TFfc2VJ1kRP3Ilscw==
X-Received: by 2002:a05:6a00:1883:b0:740:5927:bb8b with SMTP id d2e1a72fcca58-74ad42d4316mr6489404b3a.0.1750880630052;
        Wed, 25 Jun 2025 12:43:50 -0700 (PDT)
Received: from tx3000mach.io (static.220.227.itcsa.net. [190.15.220.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08d1csm5185779b3a.13.2025.06.25.12.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 12:43:49 -0700 (PDT)
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To: linux-wireless@vger.kernel.org, Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Date: Wed, 25 Jun 2025 16:43:36 -0300
Message-ID: <13830882.uLZWGnKmhe@tx3000mach.io>
In-Reply-To: <bde434a6-68b8-4c5f-8ec0-6c41dd1b6558@gmail.com>
References:
 <20250625142541.44795-1-yakoyoku@gmail.com>
 <bde434a6-68b8-4c5f-8ec0-6c41dd1b6558@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3037379.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3037379.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Date: Wed, 25 Jun 2025 16:43:36 -0300
Message-ID: <13830882.uLZWGnKmhe@tx3000mach.io>
In-Reply-To: <bde434a6-68b8-4c5f-8ec0-6c41dd1b6558@gmail.com>
MIME-Version: 1.0

On Wednesday 25 June 2025 13:01:04 Argentina Standard Time Bitterblue Smith 
wrote:
> On 25/06/2025 17:25, Martin Rodriguez Reboredo wrote:
> [...]
>> As of now only rtl8192ex devices have their P2P_CLIENT and P2P_GO wiphy
>> interface modes ensured because those are the only ones I can test on
>> my rtl8192eu card. The rest of chips have them set from what I've seen
>> in a cursory Internet search, they might or might not work.
>> 
>> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> 
> So... does it work with your chip? How do we test?

You can test this feature with GNOME Network Displays, that's the only 
userspace application I can think of. KDE doesn't offer anything yet and 
there's no other software out there that uses WiFi P2P, not even for simple 
file transfers. Maybe utils could be written like what was done for Bluez and 
be part of a known package like NetworkManager or a thing by themselves.

With respect to my case I say it's listed by wpa_cli and it gets detected by 
Network Displays, but I cannot do anything further than that. Because I don't 
know how to use wpa's utility properly and while I try to share my screen or 
see another one, I get no dice there. Maybe this is due to an incompatibility 
with my Samsung mobile or that for proper P2P support more functionalities 
need to be added to rtl8xxxu, I can say that as of now.
--nextPart3037379.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEoKWxm2R3rrCyIqCZhYg+G2pbUccFAmhcUWgACgkQhYg+G2pb
UccwNBAAmsV9jX+ADJ2yI04UQQBoH4Zxwed3fXp2G8ZFM3wuqsGiOmjJRxEHjJWE
nAzKLVgYCVjLJwX/uu1uOcmoV71wavSUq8T2NAskdYz3zbLTRFHT6PBgzYcBS/d7
2P5TIlydSgbYMtxsrr6SK8pVpA4SSIU9xiHI0NAnWEE+AtPuu1zxQRSug6QUv1yz
IDwXB4JBlgcT5TFuMAaDDZ521EGuEguh1R/P7aiUYZ8QRofFRVND3bt/1HPpQwxr
LDLqMHx6aU1N+o+d1PMKYIDYgy9FG7HepPZSO5hAJtg82mvmy60EVbGkzBtVCBEQ
UAVFa6G+Jy/qxaNPT8OR4fn6xFiwFQ521GoeVOFoqXFmqR3QHNFyYQpMOvB/vWcC
2NDSa5QGfrfPS4Uwx7ePQq+T70JmIkGwfGE7Bq0hh4d70WWz64d4ZGR1kEXUL9gw
8ACzKGKBzwSBmXyNTm9EXU15ibRzL7XgFswhXvOW35DzeGmKU+StWcZ2kwanGm28
3iwsXDJUvGaztTiOL5BEGw+kuZ3mc4P2RgHEXUYeTVT2nQ05bGSowgJDpbOidgJI
gPVSm2KTmZuHJvnKyx8XuNDbkyT0cYs67sN9is/BUfVkIxGe5Hk3AxnNTebeymZG
klMyA+uKhNeVarjBf2QozZl2nNTZAXKW4wNFF0iwFNpSKx+0ZL4=
=MBvp
-----END PGP SIGNATURE-----

--nextPart3037379.e9J7NaK4W3--




