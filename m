Return-Path: <linux-wireless+bounces-13569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9A0991F7F
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Oct 2024 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD51281F9C
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Oct 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C4E188593;
	Sun,  6 Oct 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxVoNtsw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B63187554
	for <linux-wireless@vger.kernel.org>; Sun,  6 Oct 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728229422; cv=none; b=gp9cALpqMpQEHKxIaOe5yz255sC4/ZLvWMBfak4HQgD8Dn5t3gxOBz26jHAUc3kmqRnJiE7+BPgnKR+6ey7mxqOvSiwM2gGofnrRreYUknr/PXSMAa0xN5zd8guxuZ50TktSnVqDWtRLCkuRaA0LoMRFXs+uLZo2oksw5uL0X7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728229422; c=relaxed/simple;
	bh=66fu3DeQjDChuj7yPTEg7fodKKesJm5tyVn6VGuEPRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=dhswxL9cGdgtNbUZcxSDiRUPFvhstqmpXDbdpNHo7tUep96Hutxhn9KKeaTmOoYCGQ7KyQKtdKuwzUkxbYeIEopYFlrokXR1+AJVHoK6DczN7177pj4x6eVroc0qFWFabPwZMmUqoQMtLGRhBkQvB8YkQv8w+K7/KX0QEJ3mMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxVoNtsw; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fabe5c8c26so31938131fa.2
        for <linux-wireless@vger.kernel.org>; Sun, 06 Oct 2024 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728229419; x=1728834219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66fu3DeQjDChuj7yPTEg7fodKKesJm5tyVn6VGuEPRE=;
        b=lxVoNtswrN3gjeyXSsAvIs1qIv/93x7DBIaS1sx0YFm/1iXYzno3RQnk6yQyiS3sWA
         3rq7OISxxsDMeBGfDnAD4MO7tizsPo2gHlKUHvgLNLgZZtm3pA1ysjZsLBkDO4SJWRcg
         4AKv1Cdp6ccamRsV/W6xxNnYzVKyPNq6B+Sb+NPenRBsKBf3mTvj9NBeOzaH/uLJQXqb
         APRoJ09KE+5sgVF8q7YOjrJK1wtr/mFZuEKCIVofYP1Fe+eUjY02WFsR5waUmlClKRLn
         mzkH+qjknsZcDo5rEVbfciudynHd4dnWWXb/WE0AuQOz8LBM8QMV3c9lYCnThlNoTHw5
         PCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728229419; x=1728834219;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66fu3DeQjDChuj7yPTEg7fodKKesJm5tyVn6VGuEPRE=;
        b=sTN9Bh+8rGKY5b4bCnIgEHcL+kIfhz5oyRe8tNpZw2PWt9+uH1gGGb6Y5r6HO3pyuH
         RNm8ilOhsUrh3JWbNC+RbgJM8Xjsu/n87k0CyARZ7LoPj0cs+12hAnqJEmCT4Qb9xhxj
         rgvwZ+470jnCATEli0FrKlgHKFq0BNwFP/CFj00fjB8Thohs/rPhOEFHzbltbJ+zQ/2B
         lTbm4joRPN4Z9frOflYthmg8DsDDP+MnDhcpijP0phoIxk/ZYIPZnWXNcpLmgqMslw/7
         PdTaAYA81DcCu3PVQ9cFqYpvXhX+KRR3kkvBx61U6KVHEdLsk4/29I7grs+tHp/TuBQN
         x0/Q==
X-Gm-Message-State: AOJu0YzGL4jpPYIWKumL56z2GiIRf38OT1ENf6s95+/BXkuEUeXHkB99
	HldcQvM7idDQdL4jX/Jc0tUpcgKoHekmM5BZcBUUW5RIbvRwrXgx
X-Google-Smtp-Source: AGHT+IHo9vtD9SaOFOoJUWhXw+l9MU3M6+jdKetE9gE4SGzYPMkAFgdyIho7hoXbYzd03bXkigvY3A==
X-Received: by 2002:a2e:d1a:0:b0:2fa:fc41:cf85 with SMTP id 38308e7fff4ca-2fafc41d302mr12577421fa.36.1728229418375;
        Sun, 06 Oct 2024 08:43:38 -0700 (PDT)
Received: from foxbook (bfk18.neoplus.adsl.tpnet.pl. [83.28.48.18])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9b24b0dsm5689251fa.74.2024.10.06.08.43.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 06 Oct 2024 08:43:36 -0700 (PDT)
Date: Sun, 6 Oct 2024 17:43:31 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org, pkshih@realtek.com, sha@pengutronix.de,
 Kalle Valo <kvalo@kernel.org>
Subject: Re: rtw88: alloc_skb(32768, GFP_ATOMIC) fails, driver gets stuck
Message-ID: <20241006174331.1c4e6640@foxbook>
In-Reply-To: <baca0d5d-072e-4003-ab4a-ecc524d6b89b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> I have this problem with RTL8811CU, RTL8723DU, RTL8811AU, RTL8812AU.

Does it mean there are working patches for 8811AU somewhere?
I have this damn thing, lying unused because unsupported.

> The host controller died when I unplugged another device

xhci not responding, assume dead?
Yuck. Maybe linux-usb should hear about it if it's reproducible.

> alloc_skb fails (silently) therefore the RX URB is not submitted
> ever again. There are only 4 RX URBs.

drivers/net/usb/usbnet.c::rx_submit() deals with it by queuing a work
to resubmit the URB later using blocking allocations.

Failure of usb_submit_urb() is handled same way. This too can return
-ENOMEM, on xhci for example.

Regards,
Michal

