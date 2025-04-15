Return-Path: <linux-wireless+bounces-21564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC23AA8A808
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 21:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4358A026F
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 19:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82F12505CE;
	Tue, 15 Apr 2025 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JEjGCHIQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9C24EA91;
	Tue, 15 Apr 2025 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745519; cv=none; b=ADRcdhjZ1wj65LqYDOILMt+eFTUsOyD2KxDFPl1t7l3gfMFKnLwFJ+11UiOm2Z6QFwPeQCgK3sq1YjwcItVdYFAFmu39aJ9xcsowbzY9J+sXI15DHYG2KfW/nwXY0l+4Lqx68jiu5Zs4Wlqckmd8jVPg5QkcXA6CWuyQmDuykec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745519; c=relaxed/simple;
	bh=mOpxhN9Wa01RZ6UQSe37jwo9wf3A8jc/5M0C1mJiOO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBTp+v52VtwjLJrlisWmaew/pquO5+HYruySUFdonsL0hQ9Hj70+AedSTwciInCo9Zl3gx2U4iwjRB/vSJCnatz6WvMDBlDEKHIUIeiLtzeKJfuh2tdtyJdZYYHkWUIZNNxzFbJpSapIeQpat4knFqN9z/6VSc/KvWxS3PcQUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JEjGCHIQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af589091049so4129343a12.1;
        Tue, 15 Apr 2025 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744745514; x=1745350314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOpxhN9Wa01RZ6UQSe37jwo9wf3A8jc/5M0C1mJiOO8=;
        b=JEjGCHIQ3cCYrtlcf2MaDN0rR7FFI/i+vgd0R00TYKm+wRFtuLKFijpJlXDwn4MuvF
         SmfNTshp0AOXgMqFk86aa8evi8sfoew4fj63HK13sovj4DY2iIDdesbJ7VrJrKlD93JP
         VqwpTWGpGR6dqJ2LRRZpgYsLte8CA7wLOQ5v0ofC7QRe4JVO8xm6yNgZWsRCo87/thr3
         9tlXWnKmGM0Bmeys1V/JrQd2HqfpGgNs2qvx3ZSSXhcqHv3vJl4lW6pqDZDketXr4dAb
         JX87bvEVRhxFiPmchVAvja7KNJnh4VAz6VQB5wH0SfCU97cVpN+X9y8oRdvNQFR4Bg5u
         eJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745514; x=1745350314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOpxhN9Wa01RZ6UQSe37jwo9wf3A8jc/5M0C1mJiOO8=;
        b=dRf4EVzWg2zqnXd6Q7BOkQnXVFYs8s3VkjLI3dl218Qvqor1MqsvHnhePoDWpvFEbU
         5TVf3gWAipokucNBGzSE+lDZdW70Kd8mqIlu40e+89B9nU9LqPhcOUMcifnRIfDVDFNf
         A9t/iA6gO08lU5JW6IC9sKcRbMg3HI6HHxMY7pja/QIljMBjK09xIh/Y0O/8600HzaVg
         u89zP/z8Esod0AJIbgj3wpJC1uc4F1zLZHLQaxWUSmU+WVeD0ZdFjs20T7vpJ3GMi+F+
         BYfvqXz/qpxRB/+vaVKJeYvAvoBVwy0o3V64iBpjR3U8rN0s/osIKoZvlg7cv7f9nY29
         cFXA==
X-Forwarded-Encrypted: i=1; AJvYcCVxtZr65UzI4A9US3rBzNMyhvjqshZx0F8SO5HB7922yxCQ3MGHqCVtqkpQgqPGREl/Db9RShK2obgeczQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxuNzQ7Y/ME7hCLsZEvIfC+5ZHo1IoYqtzv8GQ450PpkJtYCXn
	wZfTgGCgUS5QM+p7QkTRXaCj44PZEX/UXzal72mY/uclJkhB6nI4fXfYfROwXH313EmCJRTEK11
	Epsjeo+ptajoggWYhF+9vddO7rZY=
X-Gm-Gg: ASbGnctUSvjWMexoV6OjInjs24NZZY6Z7aPD/LBShMUiueUci6NCVybz8YVRPXf8wlE
	gOBdvnRHYWTn5YtoTOfcATTaS3cPU5pYXBe3oqLNULv5LC3TziMltFNFqfgE/gOLeIRy27ea518
	16dvSZSSYSyNikLiz9PrTMNWwUgkjDf7hKpB4=
X-Google-Smtp-Source: AGHT+IFSop+cyYcIbwFQOxNrZBdMBOLnMx5E85d1sOcycf8gh99/SLu4lo2XjydoF6DzGmNnT8KuhA24YxfN7bY6v84=
X-Received: by 2002:a17:90a:e18e:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-3085eec064emr576057a91.14.1744745514215; Tue, 15 Apr 2025
 12:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com> <20250410154217.1849977-2-zhen.xin@nokia-sbell.com>
In-Reply-To: <20250410154217.1849977-2-zhen.xin@nokia-sbell.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 15 Apr 2025 21:31:43 +0200
X-Gm-Features: ATxdqUHsUS1PJ0mHDfMEuLyBL0wApJn76Px47ZMJ85f8VhKWInTsnkELleGEbKg
Message-ID: <CAFBinCBhr7M6ixQx99T9yZxzr=cy=3E8wsaAe9dtv-RWaHVHSA@mail.gmail.com>
Subject: Re: [PATCH -v2 1/2] wifi: rtw88: sdio: call rtw_sdio_indicate_tx_status
 unconditionally
To: Zhen XIN <zhen.xin@nokia-sbell.com>
Cc: linux-wireless@vger.kernel.org, pkshih@realtek.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 5:46=E2=80=AFPM Zhen XIN <zhen.xin@nokia-sbell.com>=
 wrote:
>
> Rtw88-sdio do not work in AP mode due to the lack of tx status report for
> management frames.
>
> Make the invocation of rtw_sdio_indicate_tx_status unconditional and cove=
r
> all packet queues
>
> Tested-on: rtl8723ds
>
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO =
based chipsets")
> Signed-off-by: Zhen XIN <zhen.xin@nokia-sbell.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

