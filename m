Return-Path: <linux-wireless+bounces-537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B808086C6
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 12:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229BC284035
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A6937D25;
	Thu,  7 Dec 2023 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="birc9Fu0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B46D54
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 03:32:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so9021745e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Dec 2023 03:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701948720; x=1702553520; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=COxR7D9JBDQfjaGIgrluz654FKwgMvIAfWk795jULtQ=;
        b=birc9Fu0d9lZPDkPLH+IiGngpmBwwoe7RVFtQSyAGpbBwL0xPGZyPnUUedFaVsZB5L
         EEMrcUsEFspOMaDAtYeJPrsfTX+vvCdoR2UhTmJNM5IV2zp28UaZyn6Fvwq30GzcVV07
         S6llq2WazQkc7FIY0eFvt12/RNFiKZCY4YGKZ6/iMdCZwOwFPX29msAFP23UiAuRvi6K
         tiOOD/V3u05cVrmMZXFNdI/ShtHOzSkRBwfQbzPzzqrljsAVTTL729K2ivyJbLj1Osl2
         j2RiF+z5el1JIyBoIqoORSr398alUaFg7voTVTIj5jxBbCJjQy/pvp8YTSvlZ7wAIz/y
         5VKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701948720; x=1702553520;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COxR7D9JBDQfjaGIgrluz654FKwgMvIAfWk795jULtQ=;
        b=NnuedD3FYjjY5yQHhZdoI034bIZO5u0EcaMoxHVI9K0Ws/T4yaw3741WuP/NnbCOEq
         EdAAxZa1YLS33Gngnpgftk//1icFoK5gasiSYt95mvULBrXEhPmnHLt1hPJGk6Av0K9L
         dlgIkWoOlib1jCLEuptrNM+ga+x2docCHfexktD9BLu4pBsygd/lA6igtmxv5nCQLA+O
         PnmlV4LVplbfS6GO8adyLdveF5vPkF+Mh3ZaJcpVP+l7sErCzPh1ctlvMrrq9lY9RTN1
         B9uvGIv74eD+iUOFsXxKzmRmG16xOviCOqObPob6Pql7mocKkEfe6snx8gVBVm9efbFC
         DSEg==
X-Gm-Message-State: AOJu0Yz3hQPf33ZL6muFFsi42T1eSGvqk10TsBFpMQE5/qaq+z64gZ9e
	27opcZNYoHACbbVr65QGiHA=
X-Google-Smtp-Source: AGHT+IEn2CluXZPwftFj5NHPadeCRgvNatb+nR3NRhlPEO+cHyVnj1mvswmfchTndLm0Vvl/BQFaqw==
X-Received: by 2002:a05:600c:43d5:b0:40b:5e21:e275 with SMTP id f21-20020a05600c43d500b0040b5e21e275mr1666812wmn.98.1701948719771;
        Thu, 07 Dec 2023 03:31:59 -0800 (PST)
Received: from [192.168.1.24] (82-64-78-170.subs.proxad.net. [82.64.78.170])
        by smtp.gmail.com with ESMTPSA id fc12-20020a05600c524c00b00405c7591b09sm1627214wmb.35.2023.12.07.03.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 03:31:59 -0800 (PST)
Date: Thu, 07 Dec 2023 12:31:53 +0100
From: Paul Grandperrin <paul.grandperrin@gmail.com>
Subject: RE: Kernel oops in iwlwifi 6.6.3 with AX210 while scanning (looks
 like firmware bug)
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "Greenman, Gregory" <gregory.greenman@intel.com>,
	linux-wireless@vger.kernel.org
Message-Id: <51OA5S.GFY9YXXZJUYI@gmail.com>
In-Reply-To: <MW5PR11MB5810C544ACFD6CB471A1CF1DA38BA@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <LSU95S.IM9H1Z3FXUAS2@gmail.com>
	<MW5PR11MB5810C544ACFD6CB471A1CF1DA38BA@MW5PR11MB5810.namprd11.prod.outlook.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Sorry, last time I openned a bug there, there was no answers, only the 
mailing list was monitored.

I opened https://bugzilla.kernel.org/show_bug.cgi?id=218239

On Thu, Dec 7 2023 at 10:16:25 +00:00:00, "Korenblit, Miriam Rachel" 
<miriam.rachel.korenblit@intel.com> wrote:
> 
>>  -----Original Message-----
>>  From: Paul Grandperrin <paul.grandperrin@gmail.com>
>>  Sent: Thursday, December 07, 2023 03:00
>>  To: Greenman, Gregory <gregory.greenman@intel.com>
>>  Cc: linux-wireless@vger.kernel.org
>>  Subject: Kernel oops in iwlwifi 6.6.3 with AX210 while scanning 
>> (looks like
>>  firmware bug)
>> 
>>  Hi!
>> 
>>  My system was running fine, no errors in the logs, and then it 
>> started to happen,
>>  an infinite flow of oops in the kernel logs.
>> 
>>  The bug seems to happen in "__ieee80211_scan_completed" and it 
>> seems to
>>  involve the firmware: "Microcode SW error detected. Restarting",
>>  "ieee80211 phy0: Hardware restart was requested" and "iwlwifi
>>  0000:02:00.0: FW error in SYNC CMD SCAN_REQ_UMAC".
>> 
>>  Since then, the iwlwifi module oops all the time, even after 
>> unloading and
>>  reloading it.
>> 
>>  My system:
>>  NixOS 23.11
>>  Linux 6.6.3
>>  Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420 firmware version: 
>> 83.e8f84e98.0 ty-
>>  a0-gf-a0-83.ucode
>> 
>>  Here's the logs attached and more info about my system.
>> 
>>  I tried very hard to get decode_stacktrace.sh to works with module 
>> symbols but
>>  the NixOS file hierarchy makes things quite difficult.
>>  I can try again if needed.
>> 
>> 
>>  Sincerly,
>>  Paul Grandperrin
>> 
>> 
>> 
>> 
>> 
>> 
> 
> Hi Paul,
> 
> Can you please open a bug in Bugzilla, so we can handle it there?
> 
> Please attach there a sniffer capture and a trace-cmd log.
> This is how to: 
> https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging
> 
> Thanks,
> Miri
> 
> 



