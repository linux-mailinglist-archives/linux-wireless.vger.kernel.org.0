Return-Path: <linux-wireless+bounces-21173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3D0A7D049
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 22:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D9E188C0D7
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 20:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32F2190485;
	Sun,  6 Apr 2025 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gj0AAlkC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974720DF4;
	Sun,  6 Apr 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743971454; cv=none; b=tjn82NsbKJBFxi2DRjZupKhd5mau/v9k7rfL865CkSBhkhAT0rfRzs9CBmGBDM3ImjWaUOuoIgTsAGGTyDNmkMAtl3GvhZpJKnEhO+RL6M7BntkWb3i/Bf48hM2TEv8nLIazhn1OiaI4FaJDcdcSUid+KbOrZexGjporYw0uce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743971454; c=relaxed/simple;
	bh=m9jlNqa4pAbX771RavgW558najkMJDIUT8wnRPRipqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4prXTggtlP6ZOud7EcnsHOJY5aQBC7p9k62rT3cP3P43HYSFuEHx0bAZlrZemmGICzBFujK6bQf8AiUQinx2uAM9j/lGLy45HfwcA843iaFwBVX3OnJ/hfsRfYJ9iYo1mLlfKSM0cY2Rza6UwMJJVo2mmTnfhKz4x2wQeA/Hwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gj0AAlkC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22401f4d35aso37732715ad.2;
        Sun, 06 Apr 2025 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743971452; x=1744576252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9jlNqa4pAbX771RavgW558najkMJDIUT8wnRPRipqA=;
        b=gj0AAlkCoBsPoRq4meU7spd6I8ioq1u1O1Y35RSgnQJfOWa99R5S+QX3ceHyxuf9sk
         yOj8k8MhDFqaFfaHVPopAd80etKphTWF1srgwPETCG/BdCFhbEz2fmwyvrGYD3TAheP2
         Ar5zXNOfko6LJBrXk8hM4BtKSj66Q6A9zhI9GONkwpoTZoRufkVrLRxt1vBUXlZDtjnK
         9VCJv+RNDnFqVIvr1b4IVZOWoSedsVFGo3+OJBWAE35Tne5MBJjg6L1zA6MkBx70crg6
         h4Yv41w7qEhScu6zl+aJpPQkSSaYOA7drz3GCzS5QyziBl4b/9fR1XRQC3ZDQf9bZxmb
         AWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743971452; x=1744576252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9jlNqa4pAbX771RavgW558najkMJDIUT8wnRPRipqA=;
        b=otOdUPWJttWLfn9sbIDz5b6gxKuk1o/yCa5I6zhvtmN34iow8joJRZCgfunNXucdSm
         CkWQRpnOVrkTYaV+L8PBwlCNFH0TqeVvtZkjI+fgNGhTWSdJvIJE7/QRKsrT+r4DLaQL
         eLFcK80S6rwEWCui9Zie8y9netSR6iUxrPIzt9S/2JSxFj22uWwo6gFid0LRqZUZ7FAQ
         m+NYrlU9pkoLPOr2SZ16YqTA4X55d14UBLkBRX2+hwG6JZl01DWDnAjZp4PgE3cprU+q
         bu9/L0eVSCd3YE6Bw8PO36lauAB89/k+MZBJYMUImF7EKQYGRibvs8IEfQl0JmrJArcf
         lvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+bqWLM28izm2A+8AQIkeqpZQSF2wsHhLraUi+VrdNxO2PukJldftv7GgpGRClWjmHOyqh5O6vBhTlCv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw9NERObdr9wrkeCq458BrIFxKcVjJ0Vh4mX7Kb8yJpnDOuFqj
	4rTfO6zYGu0GtEyZToN14RU2roGaVsTdgsOzVqBzfyCSzRpkhAPu0JuLG/8eSYRpsZQG1/TYvPq
	ysoHLZhcnC6caD1Z3Q2zVQHSy8aalktnf
X-Gm-Gg: ASbGnctc1H4Qpjxsujw7VdyB5+Fer3VY1ox6xpNNmh0XIVbzDwM4m/A6MlAAsmtkltT
	QeJEzMLhmmrOROSsYa1I/9S0m1ZDjdpQLVdEsZx5vhUe7V9luVCP7x3fARMnp/5y+zkkZEmLpJw
	GLwu78XRcGwtyvKXiE8uAL51WVGYMdl5Z6bvhLgjpExHvah+lBUaY=
X-Google-Smtp-Source: AGHT+IFbGjD+kG+2VL7A52zfUwyhT3JWz1j3NFbMcDaqVUuRctRUJ4n/cFKv7nCL2+eQNkMxWUXAEaI9vSECk10y7zY=
X-Received: by 2002:a17:902:f681:b0:223:525b:2a7 with SMTP id
 d9443c01a7336-22a9552aca3mr81441855ad.15.1743971452336; Sun, 06 Apr 2025
 13:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402160310.996141-1-zhen.xin@nokia-sbell.com>
In-Reply-To: <20250402160310.996141-1-zhen.xin@nokia-sbell.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 6 Apr 2025 22:30:41 +0200
X-Gm-Features: ATxdqUExSud6z-xJedyMrfC9F45Sr8s0vBA_9HEruEUXOZ8TMB_2Yt2yk_jsI8M
Message-ID: <CAFBinCC8FBn0mFO-bRCR26tytiYtvfS6jNcx9ypCnrjik1hRug@mail.gmail.com>
Subject: Re: [RFC -v1] wifi: rtw88: sdio: Tx status for management frames
To: Zhen XIN <zhen.xin@nokia-sbell.com>, pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

thank you for sending the patch!

On Wed, Apr 2, 2025 at 6:03=E2=80=AFPM Zhen XIN <zhen.xin@nokia-sbell.com> =
wrote:
>
> Rtl8732ds doesn't work in AP-Mode due to the missing tx status for manage=
ment frames
> This patch enables tx status report for all tx skbs
Ping-Ke, there's a bit more discussion at [0]
Do you have any suggestions regarding the approach used here?


Best regards,
Martin


[0] https://github.com/lwfinger/rtw88/issues/245#issuecomment-2765046681

