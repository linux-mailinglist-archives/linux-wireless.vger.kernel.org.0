Return-Path: <linux-wireless+bounces-17062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9C7A00F2F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 21:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654C83A045D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 20:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4881B85FA;
	Fri,  3 Jan 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9+3jllG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7941474D3;
	Fri,  3 Jan 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735937632; cv=none; b=PbvOn+g9Br3z7ZRdRZ5pOs/wcmV35PC1wfxVuMw3lYbs1BZI4EPCBfEQ8kHpLTRY5PBkj3YPa7/Ymjhie5wy9yQTXX+rjacWIGAaqyNAilE4FHwWjfQYIxMSLPVEOPgsMbNFneJAMsL8ybs9flK+o1+TddN0iz0l3pvH2lMjWq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735937632; c=relaxed/simple;
	bh=LjZp/2wqGf5D8JxMeOkFstgJMxRSFN6wsOte5grZdIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aOilfrTVoEt1mMPr4tlof6GkzNSlj3t9ojEomSkm7j1OCX4kwYDC0muGOsk8DI5HHnX4NGxf/ZrIqUsisaUnLWvCe4SmePTOhd2DuzX8juflWBPWHUWnAYlPnzdKCq/3GxDDBPg6mh5KUJ0mPSj45djELPxkDl3f0a+DT5VD1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9+3jllG; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2a01bcd0143so8772510fac.2;
        Fri, 03 Jan 2025 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735937630; x=1736542430; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjZp/2wqGf5D8JxMeOkFstgJMxRSFN6wsOte5grZdIA=;
        b=j9+3jllGCwyRxy/9vAO2rAXacyXLJZSIzMAuIL/jTukzYe/BKQHLIHcHYzmxSnPI+7
         mAoHt+BRcn5oaalTrasl5WPmPs7V83Wv0ELFpag7oe2reTbzltE+udCihK1IWOmpGur/
         HsIY9rK3U8OE1Gfohg0hLm40c/ZOLAV9RA3CHeavMwgK1peBghi57Vtx9C4PXPOD0Zyo
         ZVkItz2Gqa2faPzmaOtccieIvy/+EAMRq5+T6GS5Y/oaNZljbkdh4V+a4cbF1dzl6UsY
         AjbwPhQ81RXlpsy0I6LOEhP05K+OqqFy/xyKYoSTEnoxCugvhEJNq+/NShmlNocmU3Hb
         WDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735937630; x=1736542430;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjZp/2wqGf5D8JxMeOkFstgJMxRSFN6wsOte5grZdIA=;
        b=UpO7qaOMGmD8Zg0TBMnLNm1iPJjRB88FhcITHxCGI9ke05Oen39XAcN8j+eH2O1ido
         Ed6e9A03EGAzbgauEqQE31ujLuWfMcG/Z9geIcaO4LN0tfb+Vlh2ZxzD/XtChvMDQeMU
         NRPpZwUSlPQG7CtYN8t5ONkdMfT3pSeE+1bMC+ma07NTEnGb11KdL2uYPOgD9CZFCOn9
         i07NI0i9K7Z/OfoS6mM9GneKPtsB3A2J+GJOZ5LDxohZSJFBtdWtpC90Xcp4s7uDH7GK
         trCGX1mcB0puTbsKH9ZxI1yGbBpghumR3stTbXS8x9X+QYv7ocvVdviZwHBIDIToMg/N
         2N8g==
X-Forwarded-Encrypted: i=1; AJvYcCUwY0eeDmdLbPT3RX946Olqhcw1hOYD04ahz131uPqS8aAXi5wEc782/gJFwzYivxRBtV+Rw+6d@vger.kernel.org, AJvYcCWvw05v6pPF1Ee+1XErn2/Gq7xRHRuftsVx2lJhcp/1AOksVdpmeuSz83AW0dshk3Hupf5yjnHczvI6K6Pn0OM=@vger.kernel.org, AJvYcCXxyV4Pc9bvnyz4+IvSp9zyDe/RLmsXq9euNjZQYj1CBpWaZL5CbvkVFEhdyRr+BBYj4FbYgyJUVijBYqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwSOaK2sscepCE0J+uttmTOj9s63FjmJKmLg3gOMfF0HOf0uOZ
	Z9rz5NX2DFfTqbYL6dDoDT13pcW7XCWxs6x6/XwGDk8/NdOh6gapDQLP0MgbHloesjltCshgBTf
	wnwoHpCtgn4ICQmklypGifju5e8ujIQ==
X-Gm-Gg: ASbGncuq5fpWexYpbUVy15UGi1FVwG8rXq+cc5Z84SzloXmahOAMl8CeSb7ovbNDwkd
	7wB0fgnehCDiqf8rJJV2evBeqoFUT0A0IaHScNT2E1gAbGbU905T0gC3U1uFrwSMqi7AbD7mB
X-Google-Smtp-Source: AGHT+IFobYdMrk2/Z6iD/X3HX2j8f6MDsu481VgYCNW2jwvZ7pWEKomsQfINvnwLk1MXg4eGENOJ0uv+QZcLLTRYRvA=
X-Received: by 2002:a05:6870:3c10:b0:295:ed0a:8061 with SMTP id
 586e51a60fabf-2a7fb553bf8mr26846440fac.39.1735937630062; Fri, 03 Jan 2025
 12:53:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103075107.1337533-1-anarsoul@gmail.com> <Z3g0MLOJlLsPnF1m@skv.local>
 <CA+E=qVcmHzLkH9eijPqw0_o-pOZEhXpWoPGmRmzLRFGaZiNnwA@mail.gmail.com> <Z3hGZLKQUvT5-8Al@skv.local>
In-Reply-To: <Z3hGZLKQUvT5-8Al@skv.local>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 3 Jan 2025 12:53:23 -0800
Message-ID: <CA+E=qVf2ig48M4o8zotq7fsRvPsw_aPo0niTMVNs9Dx92hsp-g@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, 
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, Fiona Klute <fiona.klute@gmx.de>, 
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 12:19=E2=80=AFPM Andrey Skvortsov
<andrej.skvortzov@gmail.com> wrote:

> Here are more detailed testing results:

I was able to reproduce it with an AP located 2 floors away.
Basically, in perfect conditions rtw88 is able to match vendor driver
performance, however when signal strength is low, rtw88 is ~2x slower

