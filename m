Return-Path: <linux-wireless+bounces-18424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B74A27688
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 16:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088453A422B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD09215067;
	Tue,  4 Feb 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEydTaSm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90006214A65;
	Tue,  4 Feb 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684539; cv=none; b=WYJkmtCNAOEunEAig9tK0eu8MbWbJxrNfjFlq+AxfI504RDyQLGn3v5aCt2cy8QlQwEEjb436gkBAt+b97OqrKpHO4d5G1QXIbqkg2pZjJi4Xuu/WGgyP4YLXGlcCYyh3+XPcwpUb4PUv9Q5wEMNCtcf0zPantXqR4BDUoJsnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684539; c=relaxed/simple;
	bh=GndJEtpYdFqEDOd4Z8mTp5BDPpjjgXLx/u3RIQMRdow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnP5R0Q/9JtkItK0TlLUS1ALSvjuwPqIie3husvx5hZDSePNnhf8gwXl4/dMoMcnXYZWRA5zKLv1buqcMlmd6X1cx64m/8qpxVOBDCTeeWFVaTbLNULJGyAM1qgFgS86y6J/CM3Uyw/SpgqNDm35lFX2Sf2BV4Xf8l4Lpqa7Wrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEydTaSm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso35873305e9.1;
        Tue, 04 Feb 2025 07:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738684536; x=1739289336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GndJEtpYdFqEDOd4Z8mTp5BDPpjjgXLx/u3RIQMRdow=;
        b=iEydTaSm6NMKdgXjtWMown9Qe5WEdcWM06SdzecszpR4goWDYk4Chgzv0TWEXTyaNb
         NX19oHKc+X7reL4PcTSB8+FGs8uOs11/Y4l5ZFBTo9dyxiVVUYPlnGzFJgIuv/dStYP9
         Y7/oK4+5Rj32MfOIx/yKUodYjYb07TO5LQwAbxa26EZ4tf92Uroo7ZNjrpEyMI5s/12Z
         o+gx092I/U0EspvZesAACjmn335NrzHoaTKvDRQzce3ZPSjAVL7kwrNiokZgeUM8iDy/
         sB2OeVnKjOzxLMJCwTpPNz8lcikeVJnUB4QTTCoZLI6uqMp/ltWm7MoUTsrt6EZWaWzq
         y+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684536; x=1739289336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GndJEtpYdFqEDOd4Z8mTp5BDPpjjgXLx/u3RIQMRdow=;
        b=k0na3jOHIgZzuzcvxMAByodmUqsH6K/Q9ehTDTHvVqNNHE0zMzFXt0/dttjxZmP6ZT
         xHYkG3cuqxbjsxFG1ZuNtIpmQMMkZL8Ey2kP2txKLYw9AVPPoIR1BlQUyHNjGudQZnh7
         BWVLmVu65K0LfwXNLD3BuVHoojfZxEZ4j17Yj0tJaUeU2BoKAoByMOvKXc6DKV85cNUX
         SYoupAiTOij43kmfy/FsgU2K1jceY0ocbiu2iadxlyEMT59EBzshlG3McWFPMTPGTfpd
         yzNXqNjW2Xu/t76pp6nn28mwlQKbmDieRd3xdyM3DcLuXOZwxB/amKotY1nwDyPeXvMr
         Gf/A==
X-Forwarded-Encrypted: i=1; AJvYcCUo/mzoHV1IAxLDcGbTDywNfNGSOrhjQ/3+xCryGa5FWvuNZFgsT4pK5wfU6CcvuK5jsYs6OKt6ydroGkodi2A=@vger.kernel.org, AJvYcCWsNl9Y1jlDTNQuPooXlhRtDBCartBvwVdJElxfqjj/GmggdTNaLChpd56RSaABEhZm7MgCoC9T4fJkxliv2Yo=@vger.kernel.org, AJvYcCWvDr498hQ6wSN2+BO66lkkc+kYra5jwV2e3S08+jE2wnyo0OEkbFT1Bkkv/zqox9/ZgAzm984cIHyF5cUx@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJxvhr6mEusrhjqjhdh3EcmCIPFEol/T+vHstrUVyUsJJT+6o
	oMtd2X8o+yUlq6oL3yrFMLRZV+TXLPzlAgbxhl43Gw1pHLpiv2/8
X-Gm-Gg: ASbGncuDGlJbm+bHEhZMasubFE761uygNuirPfMuC/KDxzAhjZWxIEJXVXkYRI7XUIL
	7adswGr/xtXBNEnQORBwwiI8/WnqeMdaVsObAlGQRoL86ElTB6EZE84P2UsbVBPalJqxMZZqHMq
	pdFn9wN5011+oqVPeiht8wfAMYMrh484Aj/hjeRpkuz0b4zboIZDt2Lef4v0XG8J+tK1dnmKuA+
	lcnjw9avklSHMNmNPaRaSjT/y38Qw3c1Wq+e4NKCH+B3Ww/xXQRAqKdHqx6IeQhyOOBrA3iMZ6r
	qQxwmPy/fw==
X-Google-Smtp-Source: AGHT+IGKGruzA4wwdDq7Y2RpTmwsPaCmy5oTDCAJQDreSJXPZQcJrKJIeOVsRrar+qymm+QTF5yaFw==
X-Received: by 2002:a05:600c:15c3:b0:436:fdac:26eb with SMTP id 5b1f17b1804b1-43905f72ae4mr29643885e9.7.1738684535476;
        Tue, 04 Feb 2025 07:55:35 -0800 (PST)
Received: from void.void ([46.210.150.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23d42dfsm198278465e9.4.2025.02.04.07.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 07:55:35 -0800 (PST)
Date: Tue, 4 Feb 2025 17:55:32 +0200
From: Andrew Kreimer <algonell@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] wifi: rtw88: Fix a typo
Message-ID: <Z6I4dGqtAXGM8rls@void.void>
References: <20250203180913.5435-1-algonell@gmail.com>
 <59ace70567f544e3b0b9bd601e2a24b7@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ace70567f544e3b0b9bd601e2a24b7@realtek.com>

> To be clear, during commiting I will change subject to
> "wifi: rtw88: Fix a typo of debug message in rtw8723d_iqk_check_tx_failed()"

Noted, thank you.

