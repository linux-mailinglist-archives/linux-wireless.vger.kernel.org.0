Return-Path: <linux-wireless+bounces-12740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BE4972CFA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAE51C2479B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3B188014;
	Tue, 10 Sep 2024 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="BSOBTfkc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06F17E00A
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959309; cv=none; b=kW8R8yQaQSR0KINeIXtaiz5TpslCNzSknilTHrt5/Qvf7g1L03hi+C76L+7Wb94JiWP2C+TZWhB1uNS+FGv3zpK7k8xQtHE39nwAYXikieDpu10KicMw9A0uCYES4vi453eXarT7rgBwV5m/FONaBfCDPXqX7B/ckb/KOsusHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959309; c=relaxed/simple;
	bh=3MlfUCNCizxM+vaowacNNmhThJDVKWE7xxtYAlgjY/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3yVVLwryZpJBkawuFaRoKYAPRhZNqDi8t9qoCmXa+r87uKv+pX4r2JTKITPrEvEhyKD4/7W/T8NaGzw+AhLhZ4LDExxhvif8B+RRPiCj5q4FHHPsG9mK+xVVo9FcSwbCepuKSbrGDubpu3nwF9co3CCd4ivU0EjN1K5zUUQn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=BSOBTfkc; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1725958858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sM+7PPwYWN07NlwtJn7Vg3Kbt0LlTirc1KeW5XQhyvw=;
	b=BSOBTfkcS6PsWA+UZr7YHUMUdR7mx3phmN6MaayXimpKGNiHCMIayJnWSpnqeiDsqo3riA
	mVWPOJHvLQ5kRj/XXsldlPJdbc2mzwHzEv/N+UEWIOCvfD/8AviIh+u75RFW8690nBlw5g
	xoXRyBWOgAiDTIEME0KUmyk1TKxi9/8=
From: Sven Eckelmann <sven@narfation.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, ath11k@lists.infradead.org
Cc: ath10k <ath10k@lists.infradead.org>, ath11k <ath11k@lists.infradead.org>,
 ath12k <ath12k@lists.infradead.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Kalle Valo <quic_kvalo@quicinc.com>, Robert Marko <robert.marko@sartura.hr>
Subject: Re: New staging repos for ath1*k firmware
Date: Tue, 10 Sep 2024 11:00:52 +0200
Message-ID: <3772134.MHq7AAxBmi@ripper>
In-Reply-To:
 <CA+HBbNFQ+25u_PK2j3vYtiCZwv+shVAVeAHKqQCwhyCopORt4Q@mail.gmail.com>
References:
 <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
 <CA+HBbNFQ+25u_PK2j3vYtiCZwv+shVAVeAHKqQCwhyCopORt4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1945126.taCxCBeP46";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1945126.taCxCBeP46
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: New staging repos for ath1*k firmware
Date: Tue, 10 Sep 2024 11:00:52 +0200
Message-ID: <3772134.MHq7AAxBmi@ripper>
MIME-Version: 1.0

On Thursday, 7 March 2024 09:39:26 CEST Robert Marko wrote:
> Can I please ask for IPQ6018 firmware to be updated to 2.9.0.1 as well?
> 

I've asked them via their support platform. They closed the ticket after Jeff 
uploaded the 2.7.0.1 firmware (which was given to him by the firmware team).

I will ask again...

(Btw. thanks to Jeff and Kalle for managing the new firmware repositories - I 
just hope that you get better input from the firmware teams)

Kind regards,
	Sven
--nextPart1945126.taCxCBeP46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZuAKxAAKCRBND3cr0xT1
y8lKAPwNsSwdxLSmTikf4A4zjnUCpxxZhriK+7u8hhJ+kTvhrQD+K4pV0rseDTTc
JqCq029XRTiTr4WcIPL8mUWrOeGZTww=
=7gwb
-----END PGP SIGNATURE-----

--nextPart1945126.taCxCBeP46--




