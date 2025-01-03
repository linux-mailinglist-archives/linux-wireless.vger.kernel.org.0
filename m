Return-Path: <linux-wireless+bounces-17064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F02A01066
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 23:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A6163653
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A57D17C220;
	Fri,  3 Jan 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3fGoyW+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23752E401;
	Fri,  3 Jan 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945060; cv=none; b=qXFTh2svzknMAYTIzNkjMKbMThZ/+OdyQJwiNb8IZu+eCrSGRVaKxUiqzGuUG7bal/HCFd/xfgnM9g1rZAV3lMbXtn/YFz0xYB/pep2Ne/fp6dC2fIQOvhNnvfYw5AqdB8tY1h2HLT3J6A7N6lC2l7NcS2wMyzvpAkQwrYDmXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945060; c=relaxed/simple;
	bh=ixjd2DQr/lsODi5OFC2ygCWre51K3Bv8GHaHULt9tHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db9oGVx80xcg2k0lo9y6uw/8x88HGH83GtpkC6UGVrS9e/UielWvIeCrFiLyy1tPZp5vnbfA5Tsu54YY9t+//FEZAVZY5dG/Mm+q6fSB+fVOJ0HzkfbQcmyTjwexHaA9EzT45f4x3vu6uCCVYO1aCmhG+Tf7nrzItcYpUbznyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3fGoyW+; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso175057641fa.2;
        Fri, 03 Jan 2025 14:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735945057; x=1736549857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nUee7pPrKPk0m11koHI0ErWRLElDWN258KawCg6rU0=;
        b=N3fGoyW+H6rcspcLOdNZMqFetEH/pEnYq58u929EeuPbdKNb8fjG1EERti0VIF+31u
         pIHU5NUwVRVKghWesqN55aJ9ZSoU0gZ4gx52HZz16V+fwGorC0iTPj/f5if52ut7w2J5
         /1DY1kvFVnFepsLNF5V52sadTXsaJHvrNKytPdU6k+zY36BaOMBxRk17Gfv3ypAN4bpI
         aLmOtUsUM0iI2Ciw77U1/smRQ47Ma3Hvn67oV6+cV21Fy2OJamFeeStH2kFnJ9baqQ4A
         PQoSKQf3h+FINzsrfUuGtoBbOsj0ofkpWQWnoVEJqh2Ddollq7FIrzD5a+P0Wlt3R1SI
         fDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735945057; x=1736549857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nUee7pPrKPk0m11koHI0ErWRLElDWN258KawCg6rU0=;
        b=XT9hhLX8JBP7Pzd0/rV2gF3+ligkE8Reg+vDAq8Rff7w0p3/g+dX67thRnSZ9uTmQs
         fHxd6rSu/C34AhPWQ/Kr2acsjX5G+lY+mDlubxZItbgDMIl2EpT5SnMZqfEyxo5oe6Uf
         3w/ts7UAXsX4J0Ww2uv0htY8Yy9yMF41YqDyvRy7x1qBNUbTT6EdKgfmkfxKQhRIULX1
         AdRYCcU3fW0uIP+v+qSfYxLxDDS0QAS3gMHEKJLklo0PU4ATQ1Me2mqz6vu97IEyue97
         i0IuFwkO1/ypqXm69sBZeaLPspUQ5mh8sid1GRKnAETkRbT+S1yZVkpQ4uJK/DRrJaSZ
         js+A==
X-Forwarded-Encrypted: i=1; AJvYcCUUGM9Lj/jYq1+EguSis5btbT9Yl3dXGAQCOUhwJxQkb7VvVZ+yMHuIL4URTf8fNIRQToOFLZze@vger.kernel.org, AJvYcCWVLPm6555B+T/hADtv7j4XLVqQTl6xQbi2RXsQJKF4Bnp8o7BbUQ/Zcxdg6xk+7eXqWwXfbz1tfPyUAEE=@vger.kernel.org, AJvYcCXd0znXo0+3gkXJgkX2lG1Xtww1i46EZw16imMQi9K0f2rnFVW2C5ua13AqRB+K85Z00KABcysxM7g2oiI9w4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfM5Z1X+htSeD1X9mrflK2EKRbIBlorUHVmotmsyzU14ExrIJQ
	UAk0Xs8gUTAKykx6tCc9ExZPlDbQeExDDHl4cG4Xzds507t4sldY
X-Gm-Gg: ASbGnctp8AZLq1QZT8AQbX7tUyfNKlgextH+UO/BGT3tRnuY87VS2DYlBpAC9U3seDU
	OvoqZRwn/f+RJoaZ9HNug/08cI13ukhM3dyAR/H2xRAHV3fEDuiqJ4Iepn8T2fC6+UsiiGVju1A
	A5+fzoyyqYDr4s3384mlp3mlWlBIq9eD3kdl0sFquN7TdGd0pUpS0ptdgLXPayrRtescvopZ9nl
	8vQUQuVxKeBZiEmtn4Qh2Q6Xw3HFaYYlogFoVyskKjBfoXHsBdEjNxIbbF/pA==
X-Google-Smtp-Source: AGHT+IG+km/QL0Pe+BNHWNbVelLIghkleOd/E0M1x76SXS7aTN8uT44z74I0BU6BYVLEPU0STgH0yg==
X-Received: by 2002:a05:6512:12d1:b0:540:1abe:d6d2 with SMTP id 2adb3069b0e04-54229560310mr16906829e87.35.1735945056465;
        Fri, 03 Jan 2025 14:57:36 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223832002sm4296857e87.264.2025.01.03.14.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 14:57:35 -0800 (PST)
Date: Sat, 4 Jan 2025 01:57:35 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	Fiona Klute <fiona.klute@gmx.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
Message-ID: <Z3hrX7I1z7zo9g5t@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	Fiona Klute <fiona.klute@gmx.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20250103075107.1337533-1-anarsoul@gmail.com>
 <Z3g0MLOJlLsPnF1m@skv.local>
 <CA+E=qVcmHzLkH9eijPqw0_o-pOZEhXpWoPGmRmzLRFGaZiNnwA@mail.gmail.com>
 <Z3hGZLKQUvT5-8Al@skv.local>
 <CA+E=qVf2ig48M4o8zotq7fsRvPsw_aPo0niTMVNs9Dx92hsp-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+E=qVf2ig48M4o8zotq7fsRvPsw_aPo0niTMVNs9Dx92hsp-g@mail.gmail.com>

On 25-01-03 12:53, Vasily Khoruzhick wrote:
> On Fri, Jan 3, 2025 at 12:19 PM Andrey Skvortsov
> <andrej.skvortzov@gmail.com> wrote:
> 
> > Here are more detailed testing results:
> 
> I was able to reproduce it with an AP located 2 floors away.
> Basically, in perfect conditions rtw88 is able to match vendor driver
> performance, however when signal strength is low, rtw88 is ~2x slower

In my case AP was one meter away from the device. Maybe PinePhone's
antenna isn't well designed as for PineBook.

-- 
Best regards,
Andrey Skvortsov

