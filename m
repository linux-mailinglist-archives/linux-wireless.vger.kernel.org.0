Return-Path: <linux-wireless+bounces-3365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC06984EE6C
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 01:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149F61F272F0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 00:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA34632;
	Fri,  9 Feb 2024 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="rMmQuBWx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03AB36E
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707439053; cv=none; b=aNxkBM7552YxwyS8Dhsk1kmwILwzigMNbjdmWIFq6B0AWMEpAXpKJ6lJiZWVUDvX4GcQmzlPBWiKLWof0fq7FDsNAZNPxQ0rlaLiGuKPhTCQ4xwdqdDzlF+OFpwqeaBJHlyW/0+eHji30LLmEvUmNGvc/f1J4xWbULEtngFRFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707439053; c=relaxed/simple;
	bh=hmyOdNnUDL/YlmDjhd9yrgpkHtpj1CIQBse+05BEdFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5LEsS7fhIvE0mVcbA+NJ5RER0riiwnOSnA7jDhQHIv8vOsonMvfSRFhLp2Exjf2BivxM+WWMQliTUwZpB0ys+h9sMgs/81HzMnBv72yylzciMf4agsfEVUTdQqicwkXaEwHrQVyJkKUDwViXAK1r1iZOn1kRu+e01qqw6oOe6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=rMmQuBWx; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=egauge.net
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c029beb8c9so14339839f.0
        for <linux-wireless@vger.kernel.org>; Thu, 08 Feb 2024 16:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google; t=1707439050; x=1708043850; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fk9kGSOJsvNx87l79TKVIJZQD8LP/JuhD3Yt3rSceMc=;
        b=rMmQuBWx9tnP+44fDRkQKqEifKw76V6l9+itA5XUbHOMhTmjUfzye6+1fhuhXxImn/
         vbbEabSfK9D9QWruPaVa71QoekwABqGFfYOEDAFwJi0gVTz9ncvX6cc6mzn9UPPOf/Hj
         SVxgVc3xuQARDn+OtZ7339dCGmbKQBnyFOP4m0v49V9bVevuNTbJ/axv9Oe6Dnob3HZs
         Kb5XGZvQLNp2gkUtK/e0//hh3y3E0uy9nkD9Se7BNRMzp3cxgVUOUdp3ozZ2LagfUBGX
         LuwBZyA4kUKtI3ofuyG/jfqWGaq/Yenm7XJFDv2n47JofrX8wUhZGDXDMtru7AxfrQZA
         lRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707439050; x=1708043850;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk9kGSOJsvNx87l79TKVIJZQD8LP/JuhD3Yt3rSceMc=;
        b=QdtXWv1wpw9I15Ld0s58pWKc4u6znWwTEY1VWo9T+YUbSvJU3Ia4nv5EfM/v6cH7BW
         NaJH5naEwvAHT6I1IiTKEwIXQgQg/Rm1qxO4Q39vZHz4eD1WbwJfbwTXa76Hp/c+lKHF
         oncuRtVeCNXRVITsbajy7juO9uBWasI0Kx6c2dKrI9/bT1W1+yJhRpGqT2Mgx6qwt5/R
         HMCkf61KDc5qylyRS5jPrNFkH3446Z3vyhnxqFL/vLD0QnB0WK4go6Mb9PxOngKIhBTm
         SIhv6Zaiuu/1uv2dE/ZeDICGsKsN2oBFZXkelxb/aUtbwzfl3sp+mJgl193xOozB55Xf
         1Qdg==
X-Gm-Message-State: AOJu0YyZzNQvWA23A4m4O+W3SVejqIQgB7UV8MfdIUT/UCZuLVCvVCt0
	TxOYxeFanyfoZ9JKTZ/myijJGvJhCnurU9aLHfWA21WgY6nyATEPqdY2oqVeF9fYuyHE7kzOV+4
	=
X-Google-Smtp-Source: AGHT+IHuHlONEm5Y7qtxV1eRgOr1oxmzuLM+gxZ+qvUFrbLLesTiQrIgjC5Q50K1fcrExyXpZV9XPg==
X-Received: by 2002:a6b:6f12:0:b0:7c3:f162:670f with SMTP id k18-20020a6b6f12000000b007c3f162670fmr278147ioc.15.1707439050631;
        Thu, 08 Feb 2024 16:37:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbbUSqSv5c6zifmEQWgMAr6ZgUd1BiIU3CK9liXuXDM9LobMAWSJ/PGnhoP89jbV8n8f9lgjNtnf7CQXmREUlmH7Sob+mL/hlWeMdwt2oFvOF+Dwn9kZ2R4VhAZlBh0ik=
Received: from ?IPv6:2601:281:8300:a1:5d8a:622a:58d5:54e0? ([2601:281:8300:a1:5d8a:622a:58d5:54e0])
        by smtp.gmail.com with ESMTPSA id f96-20020a0284e9000000b0047125936322sm140065jai.80.2024.02.08.16.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 16:37:30 -0800 (PST)
Message-ID: <0eba8b05e38c5767caf291a77bd88f5306e8a89d.camel@egauge.net>
Subject: Re: [PATCH] wifi: wilc1000: correct CRC7 calculation
From: David Mosberger-Tang <davidm@egauge.net>
To: Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Cc: alexis.lothore@bootlin.com, kvalo@kernel.org
Date: Thu, 08 Feb 2024 17:37:26 -0700
In-Reply-To: <563535fa-964c-480d-8e6d-1678de5e057c@microchip.com>
References: <20240207050736.2717641-1-davidm@egauge.net>
	 <563535fa-964c-480d-8e6d-1678de5e057c@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ajay,

On Thu, 2024-02-08 at 20:57 +0000, Ajay.Kathat@microchip.com wrote:
> Hi David,
>=20
>=20
> On 2/6/24 22:07, David Mosberger-Tang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Document
> >=20
> >     ATWILC1000/ATWILC3000
> >     Baremetal Wi-Fi/BLE Link Controller Software Design Guide
> >=20
> >     https://tinyurl.com/yer2xhyc
> >=20
> > says that bit 0 of the CRC7 code must always be a 1.
> >=20
> > I confirmed that today with a logic analyzer: setting bit 0 causes
> > wilc1000 to accept a command with CRC7 enabled, whereas clearing bit 0
> > causes wilc1000 to reject the command with a CRC error.
> >=20
>=20
> The change looks okay to me. Just curious, if the command CRC7 failure
> is observed during the wifi operation or it was created by explicitly
> clear bit0 in the code. Often I have tested with enable_crc7 enabled but
> didn't observe into any command failure.

Yeah, the module doesn't seem to always reject CRC7 sums with bit 0
cleared - otherwise I think we'd have noticed this error sooner.  I'm
not sure what causes the WILC1000 to either ignore or pay attention to
bit 0, but I have definitely traces captured where CRC7s with bit 0
cleared resulted in status 0x03 (bad CRC) whereas it always seems to
work with bit 0 set.  Since the documentation also says that it should
b set, it's probably safer to go with that.

  --david


