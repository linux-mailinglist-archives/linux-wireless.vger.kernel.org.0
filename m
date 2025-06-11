Return-Path: <linux-wireless+bounces-24018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A6AD6332
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 00:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999733A255D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 22:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDBD2BEC53;
	Wed, 11 Jun 2025 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ji1VIkVs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DB42DECAE
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682066; cv=none; b=D9PDQnSIeTT8bzMiXb5NpWxcEiT0sVqUqRP4uFj1iRftmMFu6SAiZ7qLfNjw7GFTGzl2ISFx5WwPxHfRKXpqkwy7kR96gSc8J8+Wegep4JGZ/KqMAhYBXmO6IeRxj3/2DAhNFuUQvU8/Slhv65bCxEuj0xSTmLaIf0nC2Oqp35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682066; c=relaxed/simple;
	bh=i3uXg88GrmDL02Ipc0Qdy2wwCTXE7sOzhUrq+EghysA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSwQo2pEfKRQfU31r3QBDPwgF7z8pounRX+dJK8dRayysw3GdAbh8PWL1PCyj4z0y0AtByWTi+pRr2q9d8MRPUgFqpTRDzK5be2DOKEvmG+qhP236Y+3CPaL5iH32TDuLhEMiVeVaF0Yb+h5EIbpymRMUqnaMIL35XIP7p9zPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ji1VIkVs; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c4476d381so324747a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 15:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749682064; x=1750286864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtvuCkqBFYEZRyjG1H+yUqFCaACnLIwx9nH+82roXwU=;
        b=Ji1VIkVsSKn91hMtWjBeRs69fVlC/81M9b0VkJt2obusM2t5WlIhJwST8Fxp9qFiM1
         S51OhNCdia0Lep6POMXp5ozFYUqs6H4EBdax4VjslLbeX4mZzRVq2fcRW+JItQEbCaNN
         MEJ1uPLoiJHHXomsP9hUaa2Nq5ki3iwwmWuzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682064; x=1750286864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtvuCkqBFYEZRyjG1H+yUqFCaACnLIwx9nH+82roXwU=;
        b=ZTJAKPTQsfQzgYhqzy4+QXa/r3CDzJT5K5PUACypgHwyrubo9mMO7+1DUuuMMAgd9x
         JC2J4sUsVM4sluFQfUtb6W1s7yRNaO6mK5OUe0Q+FFnuyRhxwFeQkcsj3IpOeCiydqyv
         wGCEHRlLyb6avkBhEjm3px3FO4pM4+czQH/JoxtfbKty2K5RXh1F3CZjjDaRZkvHZX97
         0/4DkXR9c5thwTsK0/F7xC9p7+zhHLr0mJRLQ0YEAK7a7q2h7Ao9WnoBT7dLEtFEDjWd
         yFMyLDKwnR733uw2THKLuaEhaDty/txbcVNKhCPp7rWT8/dj7+S8rTBYMvLDi+E6UqfW
         zZFg==
X-Forwarded-Encrypted: i=1; AJvYcCXu7s87bZf8mL7RHm4ZcUUjXSaJgZiBpPXWEPU4IOD8ZUqWYLS9KhLEe8fJO3BRtgDrXXZSzuv4K+JQhD/Qgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT+Ty0mrW1KoziPQbgJKUg6hJQS+CYFwR6onJUsdMevSM6pY6S
	7opGROP87gOBASllk4VG6whSPYm6WdSNYbf+9E5XD6y3cifUtxzNijqxJZeNADAuoQ==
X-Gm-Gg: ASbGncuGRDug0Noklyef9SYFwNQq6v3tEG98BO0tu9Hy6G9mHAHxN0GDFjdT7+Jy/Ze
	Pm1/ZOy9DAGj1c1g+P3DpfQDj1TN8ycpxYDPYafuoP/luH98ThfuyxSkea2PEUo8reDb+BsiRU7
	1/Msdyzn1nabTXUoq6KJLWln7+QgbmLqCAWJ5FzLqd5PP3aTx3CpFuewV7nW4demJnveUGQPYQd
	GitMgiBsdW8QsLa9xbRKTBAOXZGeuYNANT44iJKee/cvjkCucP35USkDPW26NQKab1EBEsPYNeD
	0IzC5etvH5dMt1iuAQ3tdkbxqwJbj1Q6yxuKa6ODkI+yuB9u1277nQ8vsvQeHFjtKwZ+QwDIruj
	Vu5WK7c4z/1+Sp4mYWfyWrW4m
X-Google-Smtp-Source: AGHT+IFHrwkXqx2Z3BILANYYSOX7LZROue9EeXw+W5JfDdbWlJ4+YUXrdt9TxJMVZXgYYIXDGyUMfA==
X-Received: by 2002:a17:90a:d406:b0:2fa:1e56:5d82 with SMTP id 98e67ed59e1d1-313bfdcc12emr1461708a91.17.1749682064115;
        Wed, 11 Jun 2025 15:47:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e790:5956:5b47:d0a7])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-313c1bca4c7sm113244a91.3.2025.06.11.15.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 15:47:43 -0700 (PDT)
Date: Wed, 11 Jun 2025 15:47:42 -0700
From: Brian Norris <briannorris@chromium.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Chen <jeff.chen_1@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH wireless v2] Revert "wifi: mwifiex: Fix HT40 bandwidth
 issue."
Message-ID: <aEoHjudwZKs4YMls@google.com>
References: <20250605130302.55555-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605130302.55555-1-francesco@dolcini.it>

On Thu, Jun 05, 2025 at 03:03:02PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This reverts commit 4fcfcbe457349267fe048524078e8970807c1a5b.
> 
> That commit introduces a regression, when HT40 mode is enabled,
> received packets are lost, this was experience with W8997 with both
> SDIO-UART and SDIO-SDIO variants. From an initial investigation the
> issue solves on its own after some time, but it's not clear what is
> the reason. Given that this was just a performance optimization, let's
> revert it till we have a better understanding of the issue and a proper
> fix.
> 
> Cc: Jeff Chen <jeff.chen_1@nxp.com>
> Cc: stable@vger.kernel.org
> Fixes: 4fcfcbe45734 ("wifi: mwifiex: Fix HT40 bandwidth issue.")
> Closes: https://lore.kernel.org/all/20250603203337.GA109929@francesco-nb/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Johannes seems to have applied this already, but FWIW:

Acked-by: Brian Norris <briannorris@chromium.org>

