Return-Path: <linux-wireless+bounces-21087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5841A79228
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFBE3A368A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B316F23814E;
	Wed,  2 Apr 2025 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIPrkcmJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5F2E3385
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607750; cv=none; b=Yp5B848QFDLchSCEATQkMcLi1cjAIoBjIA4ofYdKP1l2UzpCF+9fe0gIRcHGrIMHOcp/h7gNY5EngFHcstOspL+D3/iVd6MfKYMwXqHaNRbmyQ21o0rjcmWtw4JTxmQAiiJmUGCI1N8jhMzAFNR08dZSLHfbDs8RJQ3jUynz4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607750; c=relaxed/simple;
	bh=jzfadB6FjRGKB0ycFpyIvIJwS5obpieogN6n+cksUiI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hRrFQxzAK7E3kXSfKkOAAVHgDkhMzGpC2lnG2P2qsz7pfd5DVx8N0P69j0cSTvKWTeyICnTV+p7ZwPd+aR/0C24JZrgn2rMZZDvVolZyxGywrx+Qqjyv+8WY+APnjR5ieA2AUCt4cvjAeoVGNSsL3YJpeV98bdUIqLRTahpI984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIPrkcmJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so8495317a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743607747; x=1744212547; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvm2YPOgZV6SxEIRsisgEeLnYO7/oxdOdOaAy6MzmKU=;
        b=dIPrkcmJPnHPLK2BqJQfnRnAB5dnIOj9nQQANdggGpfk393HA1TOvoTzlNkeAJl0uY
         DzjVyJvL4PI45UgHqCX755h1fif7HDG6JLWAbyPsJp5C29xnd55e0Cfnxh/AHSQxJP/M
         gfMnKajHEGWDgmnqBYFxaQFxSYg1y8FJYcG2KeIn8UtGVvZ+RBCcczPXc6bK7aj8DMKD
         u1oYCzHz4drqqY42wC04xAa5zJeicTT4peyDrS3O2mfirVjOdCrK5K4tRAYRt/G5wUwv
         wu3uG3tPHd8ZhKHYYD0djOL63ySBLosyg1Lgco1SQk2+IQymQsLGA2jjAmiU1z33d5cP
         Aemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743607747; x=1744212547;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xvm2YPOgZV6SxEIRsisgEeLnYO7/oxdOdOaAy6MzmKU=;
        b=kY63p1XEXcKbN2pABliU6zNfEwbpp06HLeg/arjvCxyhisiSztjaY5N7xH3j2N1O6Q
         zYbUTRTJSwgLNoNk3Og/C0yOdfM3IYW9SlKAFOczQrPdsdc5mFLdJ5SFeVe2ucKIkT9y
         UQYjbkyyx0cqwyFM/F2Bw2UOW1+C2FvzFuGifXfCO3nWAPChA1Epz8drkanRZgygFyLw
         3Ul7zM9jJH5nS6HiHTeBJZz/JsTIntBUXGmKG/MEGL7ngOFZrYlmk5a3p8B0Wld2BV5q
         Bs0My/JuUC9NxG9yG5YNaF2lvXrjP2+GO4FFvi3Hs8V7lMyD9ETMTQ51VXjiDQWVmAgZ
         5P5A==
X-Gm-Message-State: AOJu0YwJ+pOwvHcx76bW6cSFFmUwPe3dXzLEbZjoBqj8Mieq2Qr3nf69
	CqkS1RnSusc8lflhjmivzmSn8yCJ7QLPlSiRubnXnbn593Rw+NhgjEgGnw==
X-Gm-Gg: ASbGnctVPK+6VTbDs3X90E6RmsAZF3cPXEAOZDY8Hi11KfToaiCoKDgItgwRRUot+Uo
	bU7e+/bkxUDU0koX4cNz3zlWOWrVTNKJaiZ7S5mLhLbzL/iAEhgR84xB+gGanKQ4vNwFYn1IIm6
	0uQqvE6V6J87rVWaKXk5upIWtlTSGVX73de5tzbvKoQpJmFv+vr+fx6nwNNQeTZtqIGQ7qdqweG
	MGdQ7FVzFnuNkYFpqcFsv6GZwS6DVoZ2rvJ03p7iEG7PmIJA3XQbRYPPtp2dsHtOyLvxxSvQ2jC
	tKhlogFlxJ1XNcfH4ApAD2prJEFBHVauWdLdzTnV5q19I8lelKsWBA==
X-Google-Smtp-Source: AGHT+IG50rJh83qeeGuN1ITO7cLjDiU4SxqzuhdztWMH5zascVGr6lkX3wJ/4j6qy9uI2+5SBPD5ug==
X-Received: by 2002:a17:907:a4d:b0:ac6:eaea:c0e3 with SMTP id a640c23a62f3a-ac782e9571amr710843166b.49.1743607747025;
        Wed, 02 Apr 2025 08:29:07 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196c8281sm942413166b.149.2025.04.02.08.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 08:29:06 -0700 (PDT)
Message-ID: <257632d8-4347-45bc-ab39-4e88d87cdb3b@gmail.com>
Date: Wed, 2 Apr 2025 18:29:03 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next v3 0/4] Improve RTL8814AU performance
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the last set of patches for RTL8814AU. They make it go faster.

Bitterblue Smith (4):
  wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3
  wifi: rtw88: usb: Enable RX aggregation for RTL8814AU
  wifi: rtw88: Set AMPDU factor to hardware for RTL8814A
  wifi: rtw88: Don't set SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU

 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 ++
 drivers/net/wireless/realtek/rtw88/main.c     | 35 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  4 +++
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8814a.c | 12 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.c |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  2 ++
 drivers/net/wireless/realtek/rtw88/usb.c      |  4 ++-
 12 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.49.0


