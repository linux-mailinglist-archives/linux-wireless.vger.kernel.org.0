Return-Path: <linux-wireless+bounces-29315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4903C8353D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 05:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EE4C34A477
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 04:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF5284689;
	Tue, 25 Nov 2025 04:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="fWePp824"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DED283FDB
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764044826; cv=none; b=RZDXJHDkrvkZTAyug9Ot2enlQ7JuyYQTgacExjd8G4X8YdQt6EaApA2BD/vCtJj1UgJAHgnkeGaLIT8aaiwarvhX4PRZWXMtFa11n0mMRxC0yLSxNQdSagw9pdlUTh/d7TE7+sHX5GnbaXMCGpOApERfMBE1wUDU5UMinA8Atas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764044826; c=relaxed/simple;
	bh=7EetVQsiB20SFtZ7PhaSVdZQDFr0ehMgJgC5Wd+OHXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CamdZ8t3xZyF5qcz5MwYlcBAa6LbXDUg7F9XlA3wpw+Ypt4xpdJSjj7uNmKzhgNsiuWt/a6AkcPJ9D2NzxScuH3xgHx8h/kIDu5kdj/wU3lkrPK1Y7GuU3Bc+3YcJcO5/Ku8woaMxiQEkvxWO78Bo2P9wu/goGHCvMF0/w+Vp4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=fWePp824; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2956d816c10so59072985ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 20:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1764044824; x=1764649624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GokNTQlkTo57Ckl+RTVoVAFTAmeIH8Ju3nmDqOtNMJA=;
        b=fWePp824bUevPX9IRFyCxyMWHGGk/rSiT2cOEETmpysMXfxu+P92j8ODpdPRSSV2mw
         mOVV7ltQVKhfC12CYbiUCeoK1689SwUIYoD0JPqLWDKMMNnPCiu8jK9dcvcjJRTlkrl3
         TS5paaFHb2uzoScGCEl1xNXs0xupk3N5kVLXKQh1HTgf0pcbCetJhYz1P5Rr99KqlT1i
         VvswyYv7hxLHi1aUtPIlSQtI6bAcWUrJxzcKdm5dL5C9TlsNXjj7KF3sPa42/TgrwxuS
         jojXCucXneU/JolxyP+t6LxcmbS3fD12PPEc/7Qj2IxxWXbumAX8WflUDvhjoVInMS62
         X0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764044824; x=1764649624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GokNTQlkTo57Ckl+RTVoVAFTAmeIH8Ju3nmDqOtNMJA=;
        b=pb590n9OiCU60v65FGQKNZlBZD9IbedTV1IuL1CfLmX51Kx5TjDHjr1FVsgnsQUU45
         RvC8rSvIKZuC44kyJm+GI6wPR54tEMcvEygUAtJtYwricoWHd3kZ7+JTvFozkDy1Kk1R
         uhP5WCHTamHhZsxksUvjsXbYt+XBJkCX7sx7ePhXvbiGh18uH39/iz4nAP8C9Iv2QK5k
         1EXk3uuXBLHPXZxz06qPP7ML+5xZlUqkN3sLfcl4yjPiU+gW3lEeoynWsooN0k6ix7uT
         Wpi7YdwZl7LXAa83VI+FUDVGqn+8eYNLmoY2IZdSmmI/7NobptTBdICHHqJwPqXlHktn
         MF5w==
X-Gm-Message-State: AOJu0YxC7BRE4erV500sCkqNHhySq9LsfhtzkEH/f8+l25UEVcb6U8vB
	FNSpu0F1NEI2tlFuLPqSyr2cocURGAQkGzPA7Uc7KQLfPv5LeItSWzTi+BsQuSlV4ww=
X-Gm-Gg: ASbGncue3WWD7NUeLSdx4QXHgSY+tdJeZZhGhcUKRfVTmmPfUdCRz5pZA4OUgT5JDDb
	Y5FhzxnZhdOhpddpaynZ58RpqM1aldOyD+ArE1h1qRB3zi8WffEYJt8+kgtGko9cGmq2oblWYJV
	Tw+K12F6AuiVzbi0Jfe1vI//+4/W+d5QvUSPPeSyiHcm5FPLue4kjsxB4u7ffGe7lz++6wJOi5c
	DIke5vZKjuMB29WDAg+b3DeqLBkjE5DGlr+/maGshsl9d+DfoVvKwIIDglS0mn88F59XGRxipEk
	40fpna4C/89jgZ4zhaDIfiqjSrRmJPyUE2wzAPacN0EleVjkHNSHe8f3qfHYocLgC0j5+KYXKqA
	v5bQFIdvuiaTAhFt4958xk146IgFZ8HBEtzKr8e8nCvnKM8/BEYMLXnrfTUK7Y+9tRgS2VokLDU
	XgF6txi2DzhcNDV0GA9ddCaLJ95JNyzGeNJW4r7SCeJ+qrc9OVTN+hGyRhZhwh+73RHkfA8v9ww
	DaxYSYW3lebaX8RP/Snaw==
X-Google-Smtp-Source: AGHT+IEPaX7x56/fvJL+tBeltNcH0nD2hadDPe/+UaJdRsjQ/R7KiXpSy2or97HFeM3YI8ENGJpXkw==
X-Received: by 2002:a17:902:f78d:b0:295:57f6:76b with SMTP id d9443c01a7336-29b6be90a42mr167671995ad.7.1764044824132;
        Mon, 24 Nov 2025 20:27:04 -0800 (PST)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25c104sm152034405ad.54.2025.11.24.20.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 20:27:03 -0800 (PST)
Date: Tue, 25 Nov 2025 15:27:00 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211: allow sharing
 identical chanctx for S1G interfaces
Message-ID: <xlfvt7pu454mthb7nrowheibslqqlxifawkfx7kltaur2mztdh@laxm3mnd64qf>
References: <20251125025927.245280-1-lachlan.hodges@morsemicro.com>
 <20251125025927.245280-4-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125025927.245280-4-lachlan.hodges@morsemicro.com>

>  	switch (chandef->width) {
> +	case NL80211_CHAN_WIDTH_1:
> +	case NL80211_CHAN_WIDTH_2:
> +	case NL80211_CHAN_WIDTH_4:
> +	case NL80211_CHAN_WIDTH_8:
> +	case NL80211_CHAN_WIDTH_16:
> +		/*
> +		 * mac80211 currently only supports sharing identical
> +		 * chanctx's for S1G interfaces.
> +		 */
> +		if (ieee80211_chanreq_identical(&ctx_req, chanreq))
> +			return;
> +		WARN_ON(1);

The robot not happy with this as I forgot a break / fallthrough.. 

	if (ieee80211_chanreq_identical(&ctx_req, chanreq))
		return;
	WARN_ON(1);
	return;

The above looks a bit ugly.. did you have a preference here before I
send a v2?

lachlan

