Return-Path: <linux-wireless+bounces-20026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E02A57A4C
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 13:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144E5188805C
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4121DFF0;
	Sat,  8 Mar 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1X9b4y2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90C8BFF
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741438718; cv=none; b=NvrvoHylb9WuM8JSu4QJ21Ck31AhGC5B+RjMzPUkcFf0dkR0zNP/Zu6JawnCwXYWr416DhoX/MEnN9oGnPBPdog53hENaTEfFaiSiCqCluYrv5IOptE1C1L4/N1SAKP3W3Ig6fOFALjIFsHkw249gCTd4PW2bOLIoQW0jPUYUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741438718; c=relaxed/simple;
	bh=W1VbBZ7ioeuM974zi/e3FY0nOH4s67kpRraOm7geFKg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=THW1PwGE4RI2k8/3rDFx79wDNgGkpMuMnXHoGwipdQgoQmOCnfdl0VVC0xKUHUkaBgWxBW/+IImN9jarrq5bLLIVY90DEXqS+XRuz3Le2x55fi5FgkzoZKB9PEWIzbpb9PN8/6O7jspCQcV4HUqCkjvPpEa0SnFTjzF7u/e9fNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1X9b4y2; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so2318887276.0
        for <linux-wireless@vger.kernel.org>; Sat, 08 Mar 2025 04:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741438716; x=1742043516; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1VbBZ7ioeuM974zi/e3FY0nOH4s67kpRraOm7geFKg=;
        b=M1X9b4y28BYup+PY+Hv2z/DJyBOor+xm3cLciNa1xWck38dPZOMAl/8RRNU4zMaKmQ
         pon+wUDtfUQpbECO0GDUblDafNOpDHjcvb0tYDjvjRimfzC32eJ5+2Vel3ARO6HFvNCe
         URdH1CfsQ5XnjiaeSc97rnTwFBlw8gaA4TNkZmXJ5vbQ8NUGkW0ajYvAseIdGpp74mnl
         e8P1G0YVol4rtwxCHBHiKXvcAC2iLBvdc6yVGeVqynFfVQ9PQyZMO45jABRVa2qeuAk+
         soXOhyfZ4RSsf8MYwr0S9UiKy/yMUoW/x04CvSjM9pB3vsxsG+DF4PP6ysG++PPKf3ZQ
         bwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741438716; x=1742043516;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1VbBZ7ioeuM974zi/e3FY0nOH4s67kpRraOm7geFKg=;
        b=Q9bSzhQZFKtMKGC1G/w+96bNKq7kuQZOgt5cn+dhGe7NkPNLat1F3PptmqTqdY9R38
         /gpLae50LT+bz5XFXRYiFNDpznvqblrRCJYjCC06esp3A9nqiWAoNZbBZpUSlDKsJjX1
         27Zbl3EsQ2qVwtM5KfZcS05KHQfc+Vnn4EW4keMUGLssk3fJVISLImAjFe/rFoOekUqx
         VkkeymL4JU2pnZOuzS/k/KtcAQclouE/BFCCI5jTnp966DjLDXPt8KY1jYLOU94n6nFD
         lZxpNsL5XjxmKr7jXJQuG9s7aTWw4Hu9JiZh+vmKHWqBGmJZ3QVxgaOL2zjhCcT9wVzd
         QVPQ==
X-Gm-Message-State: AOJu0Yyq9xzA68EG3c7sL7fVt7Qmg2hWdkntujHu+Oj6LNFOtuZkj/sD
	xt4/y5pucX6glTzTC/U7aSsnk77YTXEGtcz/T+1fsXyLH53wPMItFajlXxowLmu5px7cJ4RyTDx
	lnrQtq5Zt1venDneS2H3qA1r3ArBhQGxrtzoxEg==
X-Gm-Gg: ASbGncsMIx+aBtwtFy20rAdXRlmeYWRVWy82ij9qVBQk7HeN6FACEVG7dYtbEBIL2Gj
	71qzDWH1EsVtLhBKafxhpZgo8CUs34Xpzs1kKeCdROkvM0n4fM8+J2yGQLSNqvqaAtNpgfMuBzu
	oRJ/UInxAdJPHz0xAHdzvZb2/0
X-Google-Smtp-Source: AGHT+IGgskZfsyiNtqaytUmKOkh+8wMb4H5Tj4a2uOGfQw7lvzZtw6+KAmbpBl7VrNUu6cQryIrNS/XQYI+9TY9rn4E=
X-Received: by 2002:a05:6902:230f:b0:e63:6987:6e61 with SMTP id
 3f1490d57ef6-e636f58d4c0mr4873928276.10.1741438716186; Sat, 08 Mar 2025
 04:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?S3Jpc3TDs2YgTWljesOhaw==?= <kristofmiczak73@gmail.com>
Date: Sat, 8 Mar 2025 13:58:28 +0100
X-Gm-Features: AQ5f1JrELGGX7igyU-mpmJdO5eyrKoQLnGTJHscl7xMplVe-d4T0VC4Er68YiuQ
Message-ID: <CAFK2OG-NZxtagiLK7DEgPgNsct1gq7BUTQq=oVkWBgXV2iLFpg@mail.gmail.com>
Subject: Mediatek 7902
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Networking Team, My question would be, when will the Linux
Kernel support the Mediatek 7902 network card? It's a WIFI 6E card
that functions on the 802.11ax standard. I also checked different
devices on the same standard at linux hardware's website and it said
that other devices on the same standard like intel products work. So
again my two questions would be: WHen will the Linux Kernel support
this particular device?, And When will it be publically available?

Best Regards, Christoph Miczak.

