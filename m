Return-Path: <linux-wireless+bounces-29216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C09C76F20
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 03:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7594E61C9
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 02:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2A52E0B77;
	Fri, 21 Nov 2025 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T+J6T4BB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC12DEA67
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690454; cv=none; b=Oo+GdOnMpPy0A2SWT00fy9mKHMpFuwtfNdSwqP3EXllvQrv2ccG/t6glyb01hpr6g4pkcCPc8BP4baYAUdqHhg3sXrRn1T8xoCawnCy9vxbY1fEE1AyO0LvQ5aJ0S/w5XIuWsxI7DMJ3BRD+F5vzXuqw3DjijAbt4ae0sQjCpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690454; c=relaxed/simple;
	bh=XHhGackeQZNLcCor96DwGxo3AqRJ51Bn6ZLuvQL8wF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dn34gf5P2PUXr5rz4ad77vEru2msnuayVoIdrHv0GPhfMFzA7XWWGnCHfEePjaL948+xIJYqGIKGSXVADIiyeg5AsrZ2SAceIVbvyLBttX06rwFNWOC/OLesFyU8sCqkM45FX15FcN/NLUsZZ8Fm4OQxrurO2CDfzq9VlkZhi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T+J6T4BB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7633027cb2so284301266b.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 18:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763690451; x=1764295251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XHhGackeQZNLcCor96DwGxo3AqRJ51Bn6ZLuvQL8wF8=;
        b=T+J6T4BBxXzQ62eWYU9hh6G7eWEngK3WhrvMEL7n1G2ZLa3Qv/Wjpg/DfGGa5pCI/D
         okDj0vASUUgbq1CZrUHaYw2xsV9r8nwKL42suRYkMyE0+UuzdE6mIAtiaQ+o+AiKG1Rj
         Co2rz0e2bBzcwd52W4sZsCXokH9EgZJNEp4go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763690451; x=1764295251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHhGackeQZNLcCor96DwGxo3AqRJ51Bn6ZLuvQL8wF8=;
        b=RVz4F5gXqyOZ5kx10QACb4KVelMSidVqpq73TzmRM4HuVBhyhMHEr/8NY+m5Vn8zWA
         uk5/eNHAfInzWJTtR3dBeFMVEOMFchc7FYT+7nGLWFQoXPmRQUBqrVsnpwqKSmKMBhlW
         qKQq5ApkSxOaByCUVdIZ14hmvSlDz/wCyi/NBqdCRoZd3s3kMBP49svTIIHKkly6FB3Z
         VODCgqp08WFPbJO8G3OfYP7LbqlRWvZC+9/CaBOXBcOBZD8qSqNVRWVIfetRRgPWMo42
         lIcjKx6B30q7TK//J1rRALouJhU+/9WBYULUFFFRjLtInn435G1Yr6BwTpSzJlU6t01A
         mm/w==
X-Forwarded-Encrypted: i=1; AJvYcCXRzHdjzet8D+qCOnpZPbce4+hl7MpS16wP+GShFaFsC2nFKII/7luN1URueLGreObY1kWDAUuxQVYBWJbADA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0+3KPAJGRRwXME0tEzVQZ4OAmIvS/BE4iDnNtXAd0kB8Um/p
	rzvFo9FeApJCbLKqoq7y6WHf3fZOMmXCbr6JWbsd7bw0DJBJeea6cllMqCke01l8uQQPgr60/dV
	gOuWAquc1
X-Gm-Gg: ASbGncsC52BZSLF4Ix8T1bC+T1ZlDHRf6HvwRT97x8GnSNU/BLsqk/qU/lLt93W+UBS
	61sJB0gjxnXp/ePGY4mZkCk1pEcyhGbsQSYkZb2u4MUkSvxK9nyKYVTixDhgdNlcNX75UyKstlI
	9bnp7TAjIJNgU4lm40ZAuhjuD2mNfzJ4+x+9Z4QwefKkptcuQzHlxKhx08vMmUAru6JeQDkU846
	2oVaLKlsW5I3fjS3KU5uykvZG72/tX5P59hjg4VgWzzHBAUtuKUMrDbqXwrEYKxda7wRYjp0TGN
	uIrOawkck9yhDMh8Kj4L7ZlmJv7+OIaDuZppPg/bj2dCT/EKWuQkj6fo8M9zs1/hp4Ff9mn07pt
	hw07EcN/KpE13Aakxr8WNVdBgWcGVQqv1WLSi+fDrWnO8dqlIVRkxRvHFtcDncfbVBKMLjKDryG
	MoXONRCqzQyv8nqlWBp4XXLgtwYEu/ZF3zGyN/7yOuzVMuKw==
X-Google-Smtp-Source: AGHT+IF8AE/nn2BQ2ka56fYvgZeP2jY15AYUHUYuB7ZYI3A5ImpxOK+TypYKGw28BdtZMJxM1oq+Iw==
X-Received: by 2002:a17:906:fe47:b0:b76:2667:7717 with SMTP id a640c23a62f3a-b76718ab19cmr45437066b.56.1763690450626;
        Thu, 20 Nov 2025 18:00:50 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7655029543sm340077266b.61.2025.11.20.18.00.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 18:00:49 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7370698a8eso195889366b.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 18:00:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjZZ7oT3PgvfU4+zGSKGZE2BkBRUkyR4UaRFJIJP0afQ0los54m7CBWlDXiVCitJSVtEdMDeZ4e/qhBzwgJg==@vger.kernel.org
X-Received: by 2002:a17:906:fe47:b0:b76:2667:7717 with SMTP id
 a640c23a62f3a-b76718ab19cmr45430066b.56.1763690448985; Thu, 20 Nov 2025
 18:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19ec8e4465142e774f17801025accd0ae2214092.1763465933.git.quan.zhou@mediatek.com>
In-Reply-To: <19ec8e4465142e774f17801025accd0ae2214092.1763465933.git.quan.zhou@mediatek.com>
From: David Ruth <druth@chromium.org>
Date: Thu, 20 Nov 2025 21:00:10 -0500
X-Gmail-Original-Message-ID: <CAKHmtrRHzPu86EChf26bjtS5MhBr43HMy0HZuz-CbxG9xnckLQ@mail.gmail.com>
X-Gm-Features: AWmQ_bldX_c3C0xpRYDcjXcT6aDbcuq45-EF31DVWmvsk1MZZXs7zq5Cuc5QVr0
Message-ID: <CAKHmtrRHzPu86EChf26bjtS5MhBr43HMy0HZuz-CbxG9xnckLQ@mail.gmail.com>
Subject: Re: [patch] wifi: mt76: fix wifi init fail by setting MCU_RUNNING
 state after CLC load
To: Quan Zhou <quan.zhou@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <Deren.Wu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Leon Yen <Leon.Yen@mediatek.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Allan Wang <allan.wang@mediatek.com>, 
	KM Lin <km.lin@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, 
	Shengxi Xu <shengxi.xu@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, 
	CH Yeh <ch.yeh@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, 
	linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Please add a FIXES tag. It's clear that this fixes a race condition,
and likely should be back ported to when the race condition was
introduced. I think the error was introduced in [v3] wifi: mt76:
mt7921: introduce Country Location Control support:
https://patchwork.kernel.org/project/linux-wireless/patch/5ee00f581cc108b606656a9e7cdfe32e47c0b6bb.1662549232.git.deren.wu@mediatek.com/.
Otherwise, LGTM.

Reviewed-by: druth@chromium.org

