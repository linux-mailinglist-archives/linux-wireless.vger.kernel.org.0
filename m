Return-Path: <linux-wireless+bounces-664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 668C480CEA4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 15:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA681F21725
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E0495D0;
	Mon, 11 Dec 2023 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJGwsuVp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D3FC2;
	Mon, 11 Dec 2023 06:47:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so46914225e9.2;
        Mon, 11 Dec 2023 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702306067; x=1702910867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLQKNWG31bmCq0uh5A9lLXoIJmaU/L7EJU4AARQ0Ljs=;
        b=fJGwsuVp5Sv6bpHCpadVPE4hpLq0yHI0OJbkVzqclgJAa415ePRlfrKl6iRrLWkTht
         ypFHUgUItCj66qvBuJzTKW90UaYr+PZTDVYD1pO1naaZK/C70604yXjkI+/NAhQcPxlP
         75sVnOEBf1yBII+DDwF5fo/OTzMZaE+Qpc+JT61r99tMWjMyseBtJXCT7YKj98DdiuWN
         KEUIWNgQB/R8tFbzhJziGuXKU/w3KvWd9uTp6Cil5LCb3EuzOZwjwfsPzkvBJQepeDgo
         jFQrRPxA1gEsnFWyc6KkOVzG1PZGqsaRM7k+5PvB0wrUlJO8IemnhS2BUqcyDvgi7/kd
         yxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306067; x=1702910867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLQKNWG31bmCq0uh5A9lLXoIJmaU/L7EJU4AARQ0Ljs=;
        b=U6sNMtYtDDmGYgyA8gJYczyROFUoyXHh4UCS9ris31bvl+5/pXVFXAK7YkFT4yu1Vt
         0aLFTSLYqMXayfq1qmsvJ6GJCtrTYarD5xsxj3vsFNgdKvXToQ6wAjG4E8v8lWCZwL5c
         7vgKVSuDuFxmSWaLZYz7hMsEWUXAdOGOWRfpCHy7YI4HnqVjOLidk9z3wNme0bpaOHmm
         GSgQZMraVtNqLYtK6b7Xob0+F/h5Lo2zIbJ+D8hpQPCsUTbMF2RyF+l6W8UratkV5+NW
         qZfT2EuCmTnZIWFkQiEDTJeVtENmFUmhuOQpiQJDq2PudKS0A7YSJej0oQcVKzTPc1t9
         3Dmw==
X-Gm-Message-State: AOJu0YwKF17p7CWCAwlFvxAssitAjFR/fTu/SzIgu1T0JJRBP/IB/8zS
	wIlKrAOBHd9d4r+t10r7P9yKAGr7QRs=
X-Google-Smtp-Source: AGHT+IF1d0IaNijH6Bm1hFHuDUlx6lg2VgfOkfHQEI2ZtSYN4OIU6MwLG3o2uV10SPGBR9o7dLaMKw==
X-Received: by 2002:a7b:ce0f:0:b0:402:f501:447c with SMTP id m15-20020a7bce0f000000b00402f501447cmr2596452wmc.0.1702306066508;
        Mon, 11 Dec 2023 06:47:46 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id i6-20020a5d55c6000000b0033340aa3de2sm8711065wrw.14.2023.12.11.06.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 06:47:46 -0800 (PST)
Message-ID: <b2a4dfa9-e3ec-4c90-bb53-f2e6c70603b2@gmail.com>
Date: Mon, 11 Dec 2023 15:47:44 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi
 / amdgpu due for the v6.8 merge window
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 11.12.23 um 12:02 schrieb Hans de Goede:
> Hi Wifi and AMDGPU maintainers,
>
> Here is a pull-request for the platform-drivers-x86 parts of:
>
> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>
>  From my pov the pdx86 bits are ready and the platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge the wifi-subsys resp. the amdgpu driver changes on top.

The few comments I had for the amdgpu patches were addressed and I 
honestly don't have time to take a detailed look at the general framework.

So perfectly fine to merge that stuff from my side. Alex or Mario might 
have some additional comments, but I think they will give their go as well.

Regards,
Christian.

>
> This only adds kernel internal API, so if in the future the API needs work that can be done.
>
> I've not merged this branch into pdx86/for-next yet, since I see little use in merging it without any users. I'll merge it once either the wifi or amdgpu changes are also merged
> (and if some blocking issues get identified before either are merged I can prepare a new pull-request fixing the issues).
>
> Regards,
>
> Hans
>
>
>
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
>
>    Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-amd-wbrf-v6.8-1
>
> for you to fetch changes up to 58e82a62669da52e688f4a8b89922c1839bf1001:
>
>    platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature (2023-12-11 11:33:44 +0100)
>
> ----------------------------------------------------------------
> Immutable branch between pdx86 amd wbrf branch and wifi / amdgpu due for the v6.8 merge window
>
> platform-drivers-x86-amd-wbrf-v6.8-1: v6.7-rc1 + AMD WBRF support
> for merging into the wifi subsys and amdgpu driver for 6.8.
>
> ----------------------------------------------------------------
> Ma Jun (2):
>        Documentation/driver-api: Add document about WBRF mechanism
>        platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature
>
>   Documentation/driver-api/index.rst |   1 +
>   Documentation/driver-api/wbrf.rst  |  78 +++++++++
>   drivers/platform/x86/amd/Kconfig   |  14 ++
>   drivers/platform/x86/amd/Makefile  |   1 +
>   drivers/platform/x86/amd/wbrf.c    | 317 +++++++++++++++++++++++++++++++++++++
>   include/linux/acpi_amd_wbrf.h      |  91 +++++++++++
>   6 files changed, 502 insertions(+)
>   create mode 100644 Documentation/driver-api/wbrf.rst
>   create mode 100644 drivers/platform/x86/amd/wbrf.c
>   create mode 100644 include/linux/acpi_amd_wbrf.h
>


