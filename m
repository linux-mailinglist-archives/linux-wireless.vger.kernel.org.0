Return-Path: <linux-wireless+bounces-18730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3071FA2F9A9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 21:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8698A1883C82
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 20:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BBB19D06E;
	Mon, 10 Feb 2025 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFjzBAYR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7125C711;
	Mon, 10 Feb 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217688; cv=none; b=byxu1UDhfRmfZdCQejG2FK7nl84qzv/9/9LuZ24RG5mlxamHuAhs472FAY/xxXSQOxkl4xUomlSV1DJx2Hn41kuInEdVltCX9IWRwUwT+gbkZX9I40CBNoomeC9FOFOs8G3ELMJYA0p2WRw14k1PgxsTZFBo3tBqX9ZxaODl9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217688; c=relaxed/simple;
	bh=+jrpp41z+YtDR/dn1tbp4CQyYs0XILLfyycd7ZxUoB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Igj6MDL9UeIZfWct+Ahl7yfb2O1lLWDh/3+eEZXqrStdrAerMUbwI5sNohf2IN6AWxtuYMKpI4a/rKTP8iPkbi0HBg1bbq2MYBfPzdFw5673jLh43C8fe99q9Mim1MP0mbufv0Y05c3POk+Sz7w5wsJbaKuFy+EM9Dp+lSS3QHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFjzBAYR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-438a39e659cso33020885e9.2;
        Mon, 10 Feb 2025 12:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739217685; x=1739822485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ9Q82Rn5xAeR5ILneKt8HT+/+8kNs7Yx9TglAX5fLw=;
        b=dFjzBAYRxip46xLSeP41ersQbcIxSG9x9ll8v92+PQl/k8pLHsMuM9g1aeIJ3mkVop
         FS9MH/QF7xtqKDIseJBocNehOsAi0tsFAoWV39xFrkYiKFkGe5DrgstdcWuR5uX6dwLv
         SYkRe1eir1ofuyoo6vQwCiBJytQj3waM3MUZu3uY1fNtX60OcCM8dyZacwjVYY+jr7z4
         lUIFaxuWwv/suvOFdC2+8KlyAB0fv1rLzt1C2zBscruJ1bpDcu+Rz19JqkiMl9FD54RC
         LxirnmxmKri1nNgELS/4jCvVvB2SYBx77yvqlBrINIs3QElLo50ebDAxqWt2l2tKQOTb
         2wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739217685; x=1739822485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ9Q82Rn5xAeR5ILneKt8HT+/+8kNs7Yx9TglAX5fLw=;
        b=V0cLRcOjxetlPlCQOIe4U2xOdElXMTVgSKliRZl0Oqdr8u05fwKy+kZvCuZveLivof
         tAwoUY1ivWFtnywV8P4S82HbKF1X+UfxqXyg+4xE06yBoiaEF+1Z9kkae8Hu5bReaoUs
         Tg0GH4ZsTy/csdYNPCHvFmgThgolVMF4RQcORvFu3FHsPIJRZJpYc3fI9+xpTU1202sJ
         gxLAeXlLbL0hIuLzxv1V6+jsOlonJqONZxJhZ2KSQuxU1F9FzGQerkaRC7MYGRpiokt9
         mQ2Yrmlht0au1Y56Boa9FY6R/rFiF1i7XDGfHsqinkvcWOShgSbSSe3kA69guvwBQiXb
         DSJw==
X-Forwarded-Encrypted: i=1; AJvYcCVA7WBxYOYnZoh6odt1Wxrk8muiMw5JoQPHVWZoLVFaraVc6whD7ZljEdJryo3VOjHvppWrzjEqlXAZ2UO9o7Y=@vger.kernel.org, AJvYcCWDO4V9ddYCpVzWOI9fwyK5nDo9OG3uFYQBQL3pCjDgMLA/IeT/78fuPmj9DAlCa8goDyMr0wKuOANSEzY+@vger.kernel.org, AJvYcCWKsjcrdbqpjUgNMtSz4m2C4pVxV37WnoaJ52G+I5A2u59alMxdQwuyKOpaASyeIFXufWr7fXelpAIAiK+TILA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzvO7xhPytRc3xjqK8H09HAtPtVncTAfckNIfCLAjHz07I+F5l
	MP1xOxM2EgydI1uB+yLPKF2F1qHz0qeoWYJ8Zwx4dqfsxkDt56dh
X-Gm-Gg: ASbGnctIdmmWwYjmLSgDT8Vvao3aE4kxa6tgMlXmswim7Uo2c57jxqyh6qSsA1Xsgsb
	MKLvTyIT2wa7IDBKP7Dbo6UOQyJu/UxuRM32s1Zq6xg+P5qEE8CWbmyywS9P527IXJ62fM0Dr2/
	RkkP5CoTYRC4Oe2V5kyH+DWfN2sLCkRccP/3KMlQuLepkb7VFccoQzi8+DdOzisUbV9VcIXOR8I
	zQJFmx9kl05XDZ3Z+cfRphv4EYYHNPUxxxRSuRUtWS1APSoreAsU4+p4tWGROl1GJIVxSY3BYGx
	UzVJCgJypw==
X-Google-Smtp-Source: AGHT+IG+Gds7nLUN3pX8Qvyrwd0mTiclY92fHM9qKjkBliJDsIAfgsimAGqz5HMkoO5BEYxclKKy0Q==
X-Received: by 2002:a5d:588d:0:b0:38d:da11:df22 with SMTP id ffacd0b85a97d-38dda11e141mr6124430f8f.37.1739217684961;
        Mon, 10 Feb 2025 12:01:24 -0800 (PST)
Received: from void.void ([141.226.13.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde1dfaesm13244759f8f.90.2025.02.10.12.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:01:24 -0800 (PST)
Date: Mon, 10 Feb 2025 22:01:21 +0200
From: Andrew Kreimer <algonell@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] wifi: rtlwifi: rtl8192de: Fix typos
Message-ID: <Z6pbEUQoJxtKmaG_@void.void>
References: <20250206082457.9148-1-algonell@gmail.com>
 <d525ed7b3b564238b25b0f3653f20067@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d525ed7b3b564238b25b0f3653f20067@realtek.com>

> To be unique subject, I will change it to 
> " wifi: rtlwifi: rtl8192de: Fix debug message typos of phy setting"
> 
> By the way, patch goes to wireless-next instead. 

Noted, thank you.

