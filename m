Return-Path: <linux-wireless+bounces-24016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C4AD6025
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 22:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309973AA754
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1F1D5CDD;
	Wed, 11 Jun 2025 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHWXgxct"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DF1B0F19
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674172; cv=none; b=jmeAN8ACBakcVNXBqqDh8srWs0kXb7uDcBSWya4FbmLnqAX7qtfffk9fWQNeTIlmwpgJrIHDUN5PYNwu/AxCdfjyikeQ8L4pRIKyyZuG3uwjx/5JSFkfbhMdcKRjJf9D+TllMF5rHvWVBCGlxbzabP4uJYduabTKf/fDwd1AgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674172; c=relaxed/simple;
	bh=8YVzRNVNefnZdGLbu3IdCBeBJqHe/a9x0jSJ8v8xvt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7QMeI5egMJJOagNX1HGOjP4Dm6BohLOe+LMOa3/Uu2VylCIctls2Dy0ARIa6CRjtlzybCVM4l9P9ZauwO2bo/QcCWOZ8VLeo7rOpYGcmGEbWo+jhFvgGfF82WQKNqIwOorHExfJzXvSVKQ1BuLlu/47KPsOS7RvEgrelTuzmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHWXgxct; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d3f72391so2297075e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 13:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749674169; x=1750278969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mv45+F4z3iuOPDxD2sRgZzpQxyOiygP/LCgn+r8W77Y=;
        b=HHWXgxct4O9I6d8hzlV3C5QZtSpvlLm/ZnPZyhS2tAuhpLCHAt+0I+piSZYM836dLA
         Ks/rWmysAvLEaYItQo6bGfLlG+wd65l/WzTXtyBy6YjCAKPEkdEWIEKIEF8/zUPDXYNF
         e0cVflIUZVofo9qHdKL2eymlREPQcipeaqOB2qHoVtNtMcJAjka18Mgy2rR7i6oRA52Z
         dofl6eI51Ovt77imLywVKtu8nnMo+53/Prjvb8ZZhHEAOJ5DmYsBTTjDyttSuxyuYgXz
         fUCA002Gl7G4bBblaUx2TBUHn91DyONzFt/KWMLPE+qKVqXHtOToIQwI3sl85UCW7Uej
         CXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749674169; x=1750278969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv45+F4z3iuOPDxD2sRgZzpQxyOiygP/LCgn+r8W77Y=;
        b=ZV6CfMoDd5BcUE+bmHSPSP0dax+02+m9TlqgA0XS9IvQcHepyP5LW0BxNthI7f14sb
         3M17A26mvq97HdBffK3tlmxOUx5TKUhCoIClsHfT/bRqFviKbjSYZPa1EV9xCIHFuQ4Z
         RLXB64MqZZ3bdf7fWuKdIYMVA1BSRt+3hnY7qYtXMl2JQzZRrVEe5YN8teqTsoxat0PX
         RyoobjtjifGf7caAvaUr80N5B8QT7G/DlDkwvPncjKnTpyKqS7jYQzBixfPns/89rrvP
         qiIfR7Nn68eip5pTvuB4cuXmZ/WvOtipIeT89pBPjixmlTrFpRJPsGXGhG55vxE4oBs1
         j0oA==
X-Gm-Message-State: AOJu0YxUM/ZTQwTiPILNLfOnE48tnKkoc9Yj5KtDIy/cMfnaRozejsR9
	UWEvDiPanKJN2SIAOHiz59UywEqL8/7rOJKP83DssAfvF+giPAIV7sIv
X-Gm-Gg: ASbGncsSs1RwmNOxrb62JvUR+4mGjxEDhtFkI3SNDjozlZYQzNtMn6e9RsffLX/DAAD
	xA75XjE1hffIWOL22mqPWawar91xMqtlMBEV77f+uQjbTA6sNRjApqX/za5NJFrQXkaCUYtVLo3
	qkB5KUV7mow6iG7P+ufptVVleXhTxCWKP7LcqPbKD1KSb2J3Ht4YWBnUkKZ8KfsagTpom6YhmDR
	M2qOhzOlaPQZ8O/zqj6RiOZLYxJW8meOvS9uzf8wLXsdytG5CXPDYc1kWOxKhZr4KjwlxURU8a7
	HW1yT97qfvKAL2X4BVoJJ1aGu5ZGQc4/oPxxt7sqyujXk2zmrJj3xLwdsPOG3b3o506g8ezGOW0
	NLoeGQuJAzomzpQYFjizer8xfm03U07CG4lNKvoG2dJMmOT0+CNOZq3XC
X-Google-Smtp-Source: AGHT+IEGEosm88+Az1JBx5QNPzA+tj+OoC1EkahuTBzTdfzyq1i897EFaWg7bkjB/HwdhZa7elZkoA==
X-Received: by 2002:a05:600c:1c9e:b0:44d:a244:4983 with SMTP id 5b1f17b1804b1-4532b8c5c67mr13534635e9.3.1749674169109;
        Wed, 11 Jun 2025 13:36:09 -0700 (PDT)
Received: from shift (p200300d5ff34db0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff34:db00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de6c4d7sm419385e9.11.2025.06.11.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:36:08 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.98.2)
	(envelope-from <chunkeey@gmail.com>)
	id 1uPSB5-00000000A9V-0nDa;
	Wed, 11 Jun 2025 22:36:07 +0200
Message-ID: <12719f87-ce87-4614-a34e-5f05efd55121@gmail.com>
Date: Wed, 11 Jun 2025 22:36:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: do not ping device which has failed to
 load firmware
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250610100208.2282442-1-dmantipov@yandex.ru>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20250610100208.2282442-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 12:02 PM, Dmitry Antipov wrote:
> Syzkaller reports [1, 2] crashes caused by an attempts to ping
> the device which has failed to load firmware. Since such a device
> doesn't pass 'ieee80211_register_hw()', an internal workqueue
> managed by 'ieee80211_queue_work()' is not yet created and an
> attempt to queue work on it causes null-ptr-deref.
> 
> [1] https://syzkaller.appspot.com/bug?extid=9a4aec827829942045ff
hmm, the sample crash report didn't show any carl9170 involvement. But the
provided console log did have it:
<https://syzkaller.appspot.com/text?tag=CrashLog&x=12cf580c580000>

|[  144.671347][    C1] Call Trace:
|[  144.674634][    C1]  <TASK>
|[  144.677574][    C1]  ? do_raw_spin_unlock+0x122/0x240
|[  144.682819][    C1]  queue_work_on+0x181/0x270
|[  144.687414][    C1]  ? __pfx_queue_work_on+0x10/0x10
|[  144.692525][    C1]  ? carl9170_usb_submit_rx_urb+0x198/0x1d0
|[  144.698424][    C1]  ? carl9170_usb_rx_complete+0x207/0x280
|[  144.704149][    C1]  __usb_hcd_giveback_urb+0x41a/0x690
|[  144.709555][    C1]  ? usb_hcd_unlink_urb_from_ep+0x2c/0x110
|[  144.715455][    C1]  ? __pfx___usb_hcd_giveback_urb+0x10/0x10

> [2] https://syzkaller.appspot.com/bug?extid=0d8afba53e8fb2633217
> Fixes: e4a668c59080 ("carl9170: fix spurious restart due to high latency")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Christian Lamparter <chunkeey@gmail.com>
Cc: <stable@vger.kernel.org>

