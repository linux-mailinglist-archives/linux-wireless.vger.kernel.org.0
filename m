Return-Path: <linux-wireless+bounces-20112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE17A59919
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 16:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C52166FBC
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932A822CBD3;
	Mon, 10 Mar 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpKjL7Rf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03FE1E49F
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619320; cv=none; b=qEQsQGNS+vrlWR3Sm1UO74u8K7BCTqMWiFM1py70/COV/GtUysnTy+wyGE+c27pd4zoUVb8VOycYmMTtHWY/uXsQQ9VD04Zjg2Nm/c/UAjXZFWHNgQw1OvHxNV5KEYDhEBZG1lcGJZrrYLTrSdenoY10x5AS/cx7vGRmkTxg4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619320; c=relaxed/simple;
	bh=zh1jjYmWpPLbz6UecdyegJZn/AfMAra9Wl8JYlocVp0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=FqTmuxxnDcaQJHo5enth7cHNWugOlQ8WDSkYRIIsI1Aez+jbuTTLfdv2WjwBeOpLugxzxaAEONTijAdoERFpr/YT4M242D4nvhiPsL99BtC3zOfsY3uU5lQweKu1SIDfm4qK5bkMbJnrATD71112o7dS5WJ1lqDpu2c7lc/tnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpKjL7Rf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so6690343a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741619317; x=1742224117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsREdrheF4owD9ZeSU8AcQHOXYiCs93mVMPqdX702Pc=;
        b=lpKjL7RfOgUbs5OhkJ+WeCL+tnZDr20RJ65vHCnq5/9T2kPsTjLvvc57WDvbWNpiLR
         TWCcqXTW+Us9XBsMbBqe5ykKRmPBGzh0uWkXOGvDOVaZ3S2PdM2uU4iEANoZOHA7ZmZ8
         I6PgTxC/b4BfkJOHiPlrbri20znENAgMaLMKQyUp66nm/oowKjApLN5CYYjaxgh9kIyy
         3GPQw3J/kcT9BbQFreH9fN8BvVCwHzoy3H8/oG+emvl8I13SN2/AaQhPZ7NfCTeNPkTf
         OfabKb5YH8tOzubA15elU2PdkWLwO/seFjUiPhciGYDYjIIDDMFseViNt1ytHccrcWm6
         r+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619317; x=1742224117;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsREdrheF4owD9ZeSU8AcQHOXYiCs93mVMPqdX702Pc=;
        b=FdAt7WxbtAQVX6tyyGebtm/bJ6IPW5VoM/NwGHrA50aolVNQ8dcmO1UHeaeMn95BRA
         3ZB/CWu2qnlN7B4hlG893F3Z7Dg0KvGqkxUpDmJXAH/GlC6/oFiK1AxB8a5+YUnJGMTN
         ITVAt6oDhJuh0PctchIc6zhrpUh85hJCqfUJ+YmGSrlRGZW9emN+iaEgmdqzbt/8Lk9E
         8SM9SlFnoB4J0Vj+B3xzBlNfiAklpFh6OXOiCH9FAK2CvUm+hUrAh7g3Tyi/l+8h7CjA
         f3OzJzNjSzyFxluQRtw397achOySkKJV8Tp3sungNp1bwbxrP8cNdl30By0hn85tiAib
         A89g==
X-Forwarded-Encrypted: i=1; AJvYcCX5dWliYMt1p7TigQlGKeMpxnt3B0cjQfbJKz7I9fk6IzcNgwZ+mfRfYsWMlXzabCpxZJ5yxwXFQAjpuPJD+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzseFZgPh+Xz420VL0FDoZp5UW9bhIY4jmML0dKWXxBCugORhT
	FGSs02UfmWv2Uhr3Oz71XOQHT3pnM4Oj1b7JgEBzz23tvo0J5whP
X-Gm-Gg: ASbGncsuf7OPwjCmWKdyI+tg+oIbMcht9dh0/rBBuaEOare7HGalmCWKG5TSIdzDrMo
	zo/tS4/+Z5G98xRMUg0gPy8eMocGGo5qR6uoXjvOOPMrQbRIvEimJmVtxdXxZ5PlWKFtuzm1H64
	RaV+V4AIcHzpqV+a5VPP85mKh4HyJixeMN5tJ1bTkylVKzpy85tq7XFS5ErryOkd0ANRhlQgvPA
	fniRpFBsmqp//B1Zorl8BUNeuyCzcuxWIUpA1kanu2Ip8eQXc0ngzOTTEDu4Q3cQZ9Mr/jVoOzb
	C9EpsigD8e/O9Nz1Ohna1akDZFFgeNLyBc7OCNXvWl604GSwH1CrNhFGdXy7CimI
X-Google-Smtp-Source: AGHT+IGe7yKk6yGaugXiTUVIKdzwgPNYszfcyQAugdN+sHtLADyWVV9SZEAwtY5dhHoAebZHx6TU7w==
X-Received: by 2002:a05:6402:518a:b0:5dc:c531:e5c0 with SMTP id 4fb4d7f45d1cf-5e5e24d3073mr15493708a12.27.1741619316468;
        Mon, 10 Mar 2025 08:08:36 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74aaff1sm7051579a12.47.2025.03.10.08.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 08:08:36 -0700 (PDT)
Message-ID: <1aa6bf2f-7a76-44f0-ad76-c9f0d757a95f@gmail.com>
Date: Mon, 10 Mar 2025 17:08:32 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: Mediatek 7902
To: =?UTF-8?Q?Krist=C3=B3f_Micz=C3=A1k?= <kristofmiczak73@gmail.com>,
 linux-wireless@vger.kernel.org
References: <CAFK2OG-NZxtagiLK7DEgPgNsct1gq7BUTQq=oVkWBgXV2iLFpg@mail.gmail.com>
Content-Language: en-US
Cc: Angelo Dureghello <adureghello@baylibre.com>, Felix Fietkau
 <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>
In-Reply-To: <CAFK2OG-NZxtagiLK7DEgPgNsct1gq7BUTQq=oVkWBgXV2iLFpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/03/2025 14:58, Kristóf Miczák wrote:
> Dear Linux Networking Team, My question would be, when will the Linux
> Kernel support the Mediatek 7902 network card? It's a WIFI 6E card
> that functions on the 802.11ax standard. I also checked different
> devices on the same standard at linux hardware's website and it said
> that other devices on the same standard like intel products work. So
> again my two questions would be: WHen will the Linux Kernel support
> this particular device?, And When will it be publically available?
> 
> Best Regards, Christoph Miczak.
> 

Christoph, it doesn't look good. There were these preliminary patches
in 2022:

https://lore.kernel.org/linux-wireless/?q=mt7902e

and apparently nothing more since then.

My guess is the plans to support this card were cancelled.

