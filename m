Return-Path: <linux-wireless+bounces-29240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA0C7977B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 14:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07EEB365EAC
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101630E823;
	Fri, 21 Nov 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U93X8Dhx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5433506C
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731752; cv=none; b=etSElXvh4kcHmHi2gtCXIqrz4PV+bJhO78D9ODmGGO/nacLsenjqzn53BeWlbzsRTVMVgtcN0DcHRwuGAXX1ZdU2N74CrwOmw488VoSh/cRXmoHb748xkP7Kme1UUCA20WX2EzYAeD3MIpwkNkSwiadh4+wWxIZiWp+LZDVmVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731752; c=relaxed/simple;
	bh=4E4qgWLZbJvc0nks66Kf2sl/KD3LP6StGpvCGYDfDXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfGIikv9rTJADe0tvFMVD8BF+Akwz8AD6vc5c5OcBooMlCU+QMSqb4KR4p426Xbwxs+WgRYMO3o5Kgpdp6ua9LUR78OB45LrHW3UZJoCFhL2oX2Xq7j2atyT/Z2lnuUN2DXDP5KvRYQE5Qfv5/Iq8m7MQfFWSQhdJJQ/Bik1hMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U93X8Dhx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso3431473a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 05:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763731749; x=1764336549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E4qgWLZbJvc0nks66Kf2sl/KD3LP6StGpvCGYDfDXY=;
        b=U93X8DhxDfs5Dv0AlQfSfpdDSk21V63mR1DU9kJnl0He13V6NgKFxMYJNgbtS7oJdK
         DWAr4qNKYW2HXXf+qbXROEnBIhctC9xMdQjSefK8XZ0K78TT28XB+Gnb1IzaENOd8Ea6
         e+VAPw+nExuLr7NXYCbP9I1BFEvPWvwe8KgxEoNHVxDEchXnbF4gZCNDE6lHRzoZgV9E
         kF28bbTzEoioiw0Ogz91HeM3yKzsakkoLw1sYsJUB4CXoVivmU0qUS6tco107qpOCZEn
         OyoOOOXGyKwFCUt9XYbKj5d1O6tOHCjMX2nO+lamHL/OT/GZ3S0FDmWB5pZuzBuqL7D5
         jhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763731749; x=1764336549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4E4qgWLZbJvc0nks66Kf2sl/KD3LP6StGpvCGYDfDXY=;
        b=doZ7u8M4JWnAqV34btbkl0HmpV39KJ86j/wCvVpW8QCQhpCAufh3+5RH9IlO04myrQ
         f5JD6RS02JR3weZVfQmbQtFPHTQlppLUFYBmh7uYhfN3aohBYivJx66xtEEDzSynu3ew
         1IRBe9MqFytWRL6tjOqjFNOHlDEFhAn5zuhQdvgy/No2vlrmKsavS2xhT2JAsH5sp7fM
         EFImryEe516XIrDZbl6bN4Fg5cTWGtETVlXiINNXvUYjoFq9dq+hf+NEejmAqsL6y3hI
         HkVxT97+FppmHMO6d6NLFygr+AxW0JfbfnLtWJZMq4XmTpoU/+bzgOn2D09UB/yvEe5U
         uVwg==
X-Forwarded-Encrypted: i=1; AJvYcCWsT9EJy9Fc5SVsYLugxHQRUN2/NhF3hPXxV1s3qe/vVIVyRCFQM1V48SAMvQzcC/41PNSAAMkYbupBRuGr4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9AtRJFHPXmcXYi+SpQHdetAdOGxK6GEjscMzmqgKNOIG3iuL
	ufVrTvxKUC6kxoUbCe4PAjYJzRw6a9leRqWbNGma/n7evRSRDqeXAQg=
X-Gm-Gg: ASbGncvfv55R8Sdzu/DzZpjho5rr8c166bBAKcjzHXsQk74DPGkpGIw8B16ZsotKqJB
	JqHPOVqAbbRPIwv9RJYLhnK6Rpu6w4uNLsrvfhqrKFo8tpw2sEsG3GHC1XFNQNWJ509YyAzj4Pu
	HiLNArH5fy6rXjEX7PhBiFtIVCFCkRKdv10Axjb92aJRMrOTMZ4ylWW4wMI7dONKnF3HoMPEXq0
	u2BEvl1XM7BjKycLs1AT0kEtrnzIn1XVsgsyCsGNAmW8cAZ7XdngqJ2sENIn+l6I6gdtPXNES2P
	gSmGhQpfnXPJIFNtyQE3rYOAjkFMv1cVl0Qiw+MHwBHH8WUZ/L8hZVqVF25P6EyN6hTdpSmh8a/
	iV4NfAWFIs8ZIsuc7m0WJH1Vjd860gVKnCJmuZ+54tRfBGKFfNk5okreWM48j3Yog1JYEhQwmve
	P55hynvQ2UoyA3Yveuc2gEauLS/r++waVGaApn1iYzc5garvY=
X-Google-Smtp-Source: AGHT+IF+fRHUXtIbFHexbW+bX7vS6xhtJysRXvMNTGrbcAbQOhcG/TSSGP78YliQlRoGmwcWofF6oQ==
X-Received: by 2002:a17:907:da4:b0:b73:3ced:2f66 with SMTP id a640c23a62f3a-b767159eea3mr272040066b.14.1763731748949;
        Fri, 21 Nov 2025 05:29:08 -0800 (PST)
Received: from frutis-latitude7490 (public-gprs376887.centertel.pl. [37.47.103.120])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b7654cefe53sm459963266b.13.2025.11.21.05.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:29:08 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	ath10k <ath10k@lists.infradead.org>,
	ath11k <ath11k@lists.infradead.org>,
	ath12k <ath12k@lists.infradead.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Kalle Valo <quic_kvalo@quicinc.com>
Subject: Re: New staging repos for ath1*k firmware
Date: Fri, 21 Nov 2025 14:28:25 +0100
Message-ID: <20251121132825.1663248-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
References: 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, is it possible to release the new firmware version (2.12) for the IPQ8074?
There's a problem with the latest ath11k driver on version 2.9:
https://lore.kernel.org/linux-wireless/CAKEyCaD8RMqPvwZOxgwAT4G=h-M94ToxoSdYwCjfvZMiM8mB-g@mail.gmail.com/

Regards,

