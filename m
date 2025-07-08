Return-Path: <linux-wireless+bounces-24960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAFFAFD13E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 18:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A904E1C2203D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FA421773D;
	Tue,  8 Jul 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EaPgOhmh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD552E5402
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992354; cv=none; b=PcnDOfFDd1Xv8fgsFGAzyDeWfomAaZhcwDu2pJQKo7FHTe9/3eO5CyjGOibmve7CIJxWY9B02ktI4aINfd1Lfy6ZOsPyjqv8MBkD+7zd670y1GMtdf8JYs1vtiW6yuMjne96kTPQfDrrvZUqH2YKT3giFoKPHfrn373+DpTYS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992354; c=relaxed/simple;
	bh=LTzyrlVRC2NuGEvU6komTwWkbLgRafPqLsS/yPoZMsw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iv6Ok8wkk5YH4XfvD4Kj78izlBsmYJmko1NirZD3WVgQxAxpSGyjZ7BpVvwvJUUfySNY6N+vEKuiqeKDpZPpcy3STlrkRc3bYy//kuD+5XmjtGudLyBhaaHcjrkGi0CrB7YYJFJ8p2DTb1L4oeu5vKV3ZkSuEe2idgVwyGRqo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EaPgOhmh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso7117122a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751992351; x=1752597151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MJ4iLePVOAeT1UDeQoqVaF2Z5OTuK43UIvQovAJU0w=;
        b=EaPgOhmhd8zOP+RXaxJuqC019XH0c+073FxSFMXslInU6bkD9+09dJOq/Hf5t2ipCl
         vhx7mIk/Xo6KDKomth42fuUTOF+StXRNl9M6YowhEtstB440GITfSeCHLiHXjoxV7vl+
         YR7e1dvOOFJT9t5TOjkRmeFAGQZUCq1SOMagg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751992351; x=1752597151;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MJ4iLePVOAeT1UDeQoqVaF2Z5OTuK43UIvQovAJU0w=;
        b=SB0W+u6iq0CEhdaF85sZZt7RflT/8BjiW6oNsPj81EKHnN0bC9esg+Fybb/0NWrV8n
         jem/kdUq4bErOfA3Wbw43a3Bt9qHQCa4WGz0GN1fuCQBQmxmi3RyVm1lOxqnFkTr+OwZ
         ULUdrQOQEyn5ezaXUqLeEeWmKffQ9SjtKPVMM3eh7mdmpx9CW6kuQKGsMu6gfqZjx9uP
         H4PZ7ZCDaG+30py3WcFxH4ZIFtGX4WPeR40kkvN6OKRx4ugbj01n7KQZWjDt/eeAAm0y
         SwnxL4kXZ2KKbgMpm78g9kP6PDHZMZyj5vh1NKHnlMUpKelxWbIPg2jA+vTyaY+efsEU
         OS+g==
X-Forwarded-Encrypted: i=1; AJvYcCXdrdvLVj1E+Vq0fxhLe+zY6DmN4/ASi7xsxe/tubzIBEZQR04vZ+Mg+UcpuPoMmEY2j1Lniz2rsiulYaqy8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFLWkkOWhufcfNVXL5ARs97q55wfxR3FNf7Jaaf9J3PVlCxrW
	3LPmRo+rJV3w9pvNtij6chODSqBIGe04AobybC82hjtxp3lU6wKIntY0VpJq891ESA==
X-Gm-Gg: ASbGnctl3/lhy2Y3BsRq/fcWvb+VBn+h3rHwGcT5I8kjalBrr1I4qn7RlTTDoeWPb5t
	MeWvtQuulJbMdsI+W3hP/viNj6ixmX7IfWKwjf+tnXRBFkjKzmp1pxP41Xga3xAKNp+6li2orZx
	imLpXJaMuWistruRtj0QrrlgIpiE53E0T4+mHSd3X+e9CDRI+0gAnWC8QglEEGhVYYYO16dyXvi
	J7WTgpe5wWy19b0KWk3W3uvjJ5oKSOQLX2rKg52pzfPiNTpIaQ7pFK6ak+m7OXdoRLbRrjromTD
	eWkp63oYb8aaiPQ7BVBBu/85Mwlf3lxEeXaA+oL7NVZgRbOf7nyB5Z3nV/2ZGWCKDgzBbwgqj5m
	P0bbvWrbByPwmDxdiUj+6bm7ATg2p1tP7WVE=
X-Google-Smtp-Source: AGHT+IFEYr46G/HdRQO/5D6woNuXQArSAZCNsPSloKDWTMd6bfLMS9lxuXY+ppM4SjF5LiwwebEeJA==
X-Received: by 2002:a17:906:dc8f:b0:aca:95e7:9977 with SMTP id a640c23a62f3a-ae3fe7af792mr1598262066b.28.1751992350979;
        Tue, 08 Jul 2025 09:32:30 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac45easm914442666b.100.2025.07.08.09.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:32:30 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Rouven Czerwinski <rouven@czerwinskis.de>
CC: <kernel@pengutronix.de>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Tue, 08 Jul 2025 18:32:28 +0200
Message-ID: <197eae1ad60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250621112912.180436-1-rouven@czerwinskis.de>
References: <20250621112912.180436-1-rouven@czerwinskis.de>
User-Agent: AquaMail/1.55.2 (build: 105502562)
Subject: Re: [PATCH 1/2] brcmfmac: remove unreachable poll mode for sdio
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 21, 2025 1:29:17 PM Rouven Czerwinski <rouven@czerwinskis.de> wrote:

> The sdio interface implements an unreachable poll mode. Remove it since
> the code can't be reached, if the poll mode needs to be implemented it
> can simply be resurrected using the usual git means.

Thanks, Rouven

This functionality has been/can be useful so instead of ripping it out I 
would prefer to have a proper knob for it in debugfs.

Regards,
Arend

> Signed-off-by: Rouven Czerwinski <rouven@czerwinskis.de>
> ---
> .../broadcom/brcm80211/brcmfmac/sdio.c        | 48 +------------------
> 1 file changed, 2 insertions(+), 46 deletions(-)



