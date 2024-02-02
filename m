Return-Path: <linux-wireless+bounces-3065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D75847AC1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 21:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED15B1F26222
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 20:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE651804E;
	Fri,  2 Feb 2024 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="j2eSlkBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CD28F3;
	Fri,  2 Feb 2024 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907168; cv=none; b=XoSFvYt9hPbLoOTeoulZSLDLVTEYOStI3mLtVVlWZni2z7Vyog53/3rRKjQBEA2mNqp7QyRoVwAFJRySarCdw2rqcnHTX4Xyy7swqsNWWz/lXn9zKxNUDf8EI0XTCTZmY/9DbfOV51ezd7rQ0sBDU8i8F5teGJ+UDB1oHqpmAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907168; c=relaxed/simple;
	bh=6tBqlLoZdBObnyfg1BRLSUAhFH8O9/m+UBF8I4GPngg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUDeE+rqJraE2Y1ohgYfR8BIXiLO3EBm3Px9ZERxQbQ04NUuiyb5fzHoQ7q6dpIx/AOf+Qb9TFTEKYuJXCjsr9PTrMZRm1/K5n89QElLwL7VHtJpioe81OlX7CeedxBHoqdAAN88GXgHIjpRMWu7rRBM37FjwSULz7v+cD63wwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=j2eSlkBm; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0C5761C0075; Fri,  2 Feb 2024 21:52:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1706907163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTJ3heduEcWsZ9DzvyZbNDBooU5oUgRxNo55Fi0/WGs=;
	b=j2eSlkBmlNere4ikdzlNgssuoPqAI3kSgyWnFTH0g+uBWCyks+wDBcb0k4TCRvrZJ1bDEk
	nOsURCLbqNUqMYWGVJsge81Kzg6jip01vxkUgtGHTDtWreGIv3NKfIfQssYajADS3p2ZYs
	IcgF6E/LMM0kLaH7Iff9j/GNsW3w774=
Date: Fri, 2 Feb 2024 21:52:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org, Ond??ej Jirman <megi@xff.cz>
Subject: Re: [PATCH 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Message-ID: <Zb1WGafVyr5cLPiH@mobian>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202121050.977223-1-fiona.klute@gmx.de>

Hi!

> This patch set adds a driver for RTL8723CS, which is used in the
> Pinephone and a few other devices. It is a combined wifi/bluetooth
> device, the wifi part is called RTL8703B. There is already a mainline
> driver for the bluetooth part. RTL8703B is similar to the RTL8723D
> chip already supported by rtw88. I've been using the out-of-tree
> rtl8723cs driver as reference.

I tried compiling *23cs into kernel (not modular), but that one fails,
with "multiple definition of rtw8723x_iqk_backup_path_ctrl" and
similar. Sorry, can't cut&paste right now, but it should be easy to
reproduce and fix.

Best regards,
								Pavel

