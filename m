Return-Path: <linux-wireless+bounces-1042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CA8819355
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 23:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1667B286789
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5063B79F;
	Tue, 19 Dec 2023 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVBVhWhY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1945F845
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d2764c0f2so14858195e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 14:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703023409; x=1703628209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9uDpy/2nLwnSC2RClGNxo2n1PFKIGn6TD9XGZ4TUlg=;
        b=JVBVhWhYzC0fUVzX2AI+QUjXoO/jWp9ZOtKo9LQwJ9euHVYfGD5Oa/F2BQoHneiHvL
         YMldbYfNaDZBKVflLd3zKQFrkjH7+huLeWMYoIR3df64ckZJdUR8zOLRuQAB2rnQ5FOd
         GLDykTe94r2btXmtNgwR+Z1NzZ+1XTDuS1PF2ulcEqPPBtmQHWGyi5RuJxwGK5Cduhna
         ckV5JOKVj9OA5lbp3KZZRk/74i8zr4vUFwLXszKcDihYsQpZVsX6chhMtzCMbfxOkoQf
         oe6GjD3F9jxQ/VuejAFghM5fGTipcPZXyYSoZU7XO7Ci5sV9Af1XiXOr5MUZM5HTPgSr
         DImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703023409; x=1703628209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9uDpy/2nLwnSC2RClGNxo2n1PFKIGn6TD9XGZ4TUlg=;
        b=iKpFvuKTuBBH3HSGmFQtiRZ/y5MKxZzoZeCqWV/Tt/Jax/0GhqONGtVK9WjjJW0tL7
         6xE2HwQXgwA6oHJBU5TZ+ujRVoWeJKHVQ1zzxmbP1XAOn0HX306Zwvv3GiHcgTDa9m38
         eTVRYeQXPTBP54PRGB2Al1FjAqmDN4aBpFYcdL3C8sgDtykX7gWQlHPcX0b9GGRjZR1l
         pmRl1aZYA1OIGz2OQPu289s13aKImXi/uoAzh6yxWvSFI4QqnqZ3aYksk8MXCXn9enDA
         Yu3FYO02QO0STfjY4vffrN4MlJiSITdAsEYofEKdLr1TQt47Nk+nDi/YagUHvlY2FHUf
         0EvA==
X-Gm-Message-State: AOJu0Yyqt6eyxDMxMHkGzGUx7PixqeqYLQ7eWoYz4trEcAs0iTaW+LlD
	DUmzuMP3RzvG/FPXEZRcKLQ=
X-Google-Smtp-Source: AGHT+IFHByFyGleU+esgb7656t3eR3hrxbWWYODQoncDJQr/YdCtnlO6HhG9/n1SHwIquvAX6gnYIQ==
X-Received: by 2002:a05:600c:5192:b0:40b:5e21:bdb6 with SMTP id fa18-20020a05600c519200b0040b5e21bdb6mr8858977wmb.69.1703023409289;
        Tue, 19 Dec 2023 14:03:29 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b0040b45282f88sm4715124wmq.36.2023.12.19.14.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 14:03:28 -0800 (PST)
Message-ID: <4f347036-4456-48be-829a-b8c39d5091ff@gmail.com>
Date: Wed, 20 Dec 2023 00:03:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] wifi: rtl8xxxu: Add concurrent mode for 8188f
Content-Language: en-US
To: Martin Kaistra <martin.kaistra@linutronix.de>,
 linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2023 16:36, Martin Kaistra wrote:
> This series adds the possibility to use two virtual interfaces on the
> same channel. Supported combinations are STA+STA and STA+AP. The
> conversion of the driver to support multiple interfaces is split into
> individual patches to hopefully make it easier to understand what is
> going on.
> 
> Thanks,
>   Martin
> 

Nice work! I'm glad to see this driver get more features.

