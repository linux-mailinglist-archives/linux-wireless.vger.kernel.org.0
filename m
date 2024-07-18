Return-Path: <linux-wireless+bounces-10356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07204934D79
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 14:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF401F235C7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 12:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54313A407;
	Thu, 18 Jul 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd5vFCjw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723413C801
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307112; cv=none; b=QWZ6l4sZlnINrneYyNMK+ONVdde8/EMah4OjOCKiShYaBtGuwEF/1KDeDYj1jTPQGwdVanqdhaMppbftbi2IXxpFikrv6TPvea6UaDXZcZ2yY/2mV7dEvDL+/9a+PoTQc3qI+7fAaMoVpwrSuTDpFwifWrBUhfXcNnP7cKUfaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307112; c=relaxed/simple;
	bh=jMPkzPrEhq2aguHMT1+JNbcqIjq7jWCMHjs6fG7teqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LLIEzBTE537vE7dzG6TugU1F9i4R0lSH/8WZnSdxCB0z0E5LPufL+AAlpyq2cwiszbsv3zu6ubKKIblqlarn3q4sfmTYnwApbZwK92szTqlEM8yoZlW5XnlPLXCYMKWXaBsJ+tRR8MNqwuc4pTyYjXwvw7ICum1zECKg7DB9jv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd5vFCjw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a79a7d1a0dbso75538166b.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721307109; x=1721911909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9PXJLLtO6hPYFjFfa7Wg7CTmQsaMqBp7uuNXC2VTYU=;
        b=Qd5vFCjwTeXYs35rKWDQMqaenPaNJQ2KRNy1AFCyJtKrUZGuI9mzC5zkVNEaDhmmCi
         L4L+ts1zOj0hodeMJhRpPHn6b8GMkMhRinvnKGlmoOOwGNA9JIBuUyd+iHE3I8T3ZJdx
         vsSRtnYYWh1eHGKmDjsy7pNrMQ30wgKGAH4woBq1wcHHolBmbsQcWFuDy3DCr7wqqV4D
         6UA3JHn9a+tBkpwrpuXaAyXjEZnFt/LhRh/8XjJijNd/zj04YBVm7XhsooM5ux7hrjsT
         m62nDZ5gxrvsHG0MCmoeOh7fdqR5rhrVHS/+CHHZsjMuZYKpc15atpbOllRtaVKDTzcb
         +huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721307109; x=1721911909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9PXJLLtO6hPYFjFfa7Wg7CTmQsaMqBp7uuNXC2VTYU=;
        b=DVn+rV/cQ4s8u4P65DYTvq0+jnC8TkqyeLhDQgBd4I+XcpT2GLD6YuDlpzqchVjgmL
         H9t47/wrUPbyksxzE7hKdtmS4uAZdDIIPe0CcaibmYwt7M5BrJ1J1APRs+WXvsXPBwLb
         ZaZcFCnKoRgki8c63deGYD7Q6dwLuPebXbpcaKKk9HtB0bUhJAm89lx489jBxvwIfHxF
         /WG9RdkT3Ha0cB0sIVucntBT0x7Oc5bbImc95fiJRSeSCGUNoTb6is7P410CTmP0W7BP
         uCzQHeuUqaGVwtwSwO7iA/EmDvbeoAzXeQd2WGh492Pv166sIAA+ktLwg/tLikBvU/n5
         SIRA==
X-Forwarded-Encrypted: i=1; AJvYcCWSXZoHoR/hafhYT68D8DAY88NhpqdKWpz0mxJ12rZZmCboM+HNGhEK4FAicyWs5+04GueYlQIR6bb6TGkKStbSQ6Rc/pPu/E48IH68YSA=
X-Gm-Message-State: AOJu0YxpwXeDKfw1blUUxIMZHFE8Vu26kkm0Srq8nEU4DdDrnoMNss4Z
	O4IaVLXazcmx/ZLG1aQs/ymOZ9GllBxm9PLQq2FoJvjL0xpcS1g3VzcGzw==
X-Google-Smtp-Source: AGHT+IGcJ4BBEOg3kTbHxPrMD5lgO9SJHBIXJLkTTdITQrMTZ0NcKzdUU8mlCI3TZ9mYTpI7Rh1FHw==
X-Received: by 2002:a17:906:1cc6:b0:a72:9d25:8ad3 with SMTP id a640c23a62f3a-a7a011389e6mr346378166b.9.1721307108452;
        Thu, 18 Jul 2024 05:51:48 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3aa6sm558151366b.39.2024.07.18.05.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 05:51:48 -0700 (PDT)
Message-ID: <c08d5a23-1ee5-4d35-8c9f-c75c049abf55@gmail.com>
Date: Thu, 18 Jul 2024 15:51:46 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: debugfs: support multiple adapters debugging
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
References: <20240718064155.38955-1-pkshih@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20240718064155.38955-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2024 09:41, Ping-Ke Shih wrote:
> Originally in order to read partial registers from large area, we write
> a range value stored into a static variable and read registers according
> to the static variable.
> 
> However, if we install more than one adapters supported by this driver,
> the static variables will be overwritten by latter adapters. To resolve
> the problem, move the static variables to struct rtw_dev for each adapter.
> 
> With changes, smatch spends too much time to parse rtw_debugfs_init():
>     debug.c:1289 rtw_debugfs_init() parse error: turning off implications
>     after 60 seconds
> Move stuffs of adding debugfs entries to three rtw_debugfs_add_xxx()
> functions.
> 
> Reported-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/cd6a2acf3c2c36d938b40140b52a779516f446a9.camel@realtek.com/T/#m27662022c70d9f893ba96f6c6a8dd8fce2434dfe
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---


Thank you for fixing it so quickly! It works for me.

Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

