Return-Path: <linux-wireless+bounces-7384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D698C0D5B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 11:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09CDB21515
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438D14A4F0;
	Thu,  9 May 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFXtP5uW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E9126F09;
	Thu,  9 May 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246244; cv=none; b=mYC0RmZBq2gq4TjaOihTGRPf1MR/VkZbcj76HsXaX4I/0cgzHFmMOHhgjAILN17NWD0O75Epkr8lkvS4S/XVdiOOZBpJvr08aoxawTPTqkX7Cl5hMpSoLkL7Pb3eRYZYcRX1Qnqp73938O6a017REmM+g/8m18iDFs8NwYlv3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246244; c=relaxed/simple;
	bh=RcxOhT/V7KXIlWcQwuEx3ss/+vW9JjLBhRq3LZF7R+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmhXgboSpGeuI9J7pCNNfAskQ04kLoMCRa7Md85PaJQG16hJDuHLzc+1COi9VC5cgDdXLEeOfOMUdgb/QYyyiEbSnF2ExQbiDrJSDTh8ozY9N3Mv7xaE2Rulvw4Mebr+lO6jgFZWOjiTIquuexw2HogvO0Kkvo0AXyvl861XZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFXtP5uW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso696395b3a.0;
        Thu, 09 May 2024 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715246242; x=1715851042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tq5v84OomZlKxGDp0ZtPVfBntdt78gOntENcePWMnc=;
        b=EFXtP5uWLM+4S+GqsezpjauzdvFd3yxyABc4CDtDTmssUwdk1PUUEGAGDC9S+jcoyE
         oIgsibgI2+ZumjhCiFxfB1AClOj0Kw09FITdh+NfsrbSMVDq6BWcYZqOfJBUjqX6wt0B
         67JI5t2EZZ3WM+jev8cZZibJhBI7EMEFt135gaekGYqBteqSd6sKjIeA+TsiKnm/0IC2
         eDi/RZV1dBPPznqMecAUiIYCP1HSWyJlsp4eNoZV6pIrj+jPaiqq8HOPyqoDLW+FIN0e
         Ijs6NbyzRKO0+KoiXMxk4k4E+S/h3MM5DV4pHl9B17rFe05zky4UT9oQDsMGVqYChK0l
         BwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715246242; x=1715851042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tq5v84OomZlKxGDp0ZtPVfBntdt78gOntENcePWMnc=;
        b=eY53qHoUQ7mje3XSEu4zYV2ci1X/PCfI87I32VdgVD0WZXvzJJR5XXlFpWkLrnUc67
         Xuw3ncBJRPT8bAt/+m5S1jaJqym7ka/qhu3W/WxypngA43mqjZUDwrO4kUTnmh2Clpv+
         JHnZgvgNKfi1BpBJe3BRDS4ZEB/l4ct6Gdi6/BNULCks5xIMKFtWGQ91HHZB1z1DCwCL
         cji8d+qvlb8t+z6X8w7NPojUrriuDmR2bgp/6OCW1emnUDiHbKfgJWP1ickd+IElOLsX
         qEdHxD5/o2scfoZEEbBmjEZOgW2Vw9CrC0DNVejOleow5J2xojtBh5/NxUqdVE/Q1dAY
         BhXw==
X-Forwarded-Encrypted: i=1; AJvYcCVZP12NSQ6jDsG/+biXuxEJa4q6nbZAmZqEg6aHcTSzo6XbBy4ABDvDyWsHDaBxx0TUBvJ2VKiPhMcJ99eLKtmfgy39PBekyKJoQOEkCI8tywEUXXU/x/2H95JQh0BXh37TdbBEpT/zzA2gBy0Cf7wi3xX6/YeevsvBF4al8+RddkXMiHo=
X-Gm-Message-State: AOJu0YztR3mE8D9HH8+WZmwyXk00XhW+B1N31ILqYDBiPiFfad5t8YqB
	IVKwBSOfvi0JCC6oGn2AexxHe7htL+3i2ATraVvaXeNRdhJcuLic
X-Google-Smtp-Source: AGHT+IHz72VVvsp4Wvvreufo/JuMhKuZ85VBqCyJe4feD8NM0KM450tvljPetl4jwWZXhog8dnplDg==
X-Received: by 2002:a05:6a21:193:b0:1a7:3b4a:3e8 with SMTP id adf61e73a8af0-1afc8d05b2fmr6101404637.7.1715246241921;
        Thu, 09 May 2024 02:17:21 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b254cfsm868973b3a.200.2024.05.09.02.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 02:17:21 -0700 (PDT)
Message-ID: <7acbf5d9-975d-4005-92e3-fd78cc3a249c@gmail.com>
Date: Thu, 9 May 2024 16:17:12 +0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: UBSAN: array-index-out-of-bounds in net/wireless/nl80211.c
 and net/mac80211/scan.c
To: Johannes Berg <johannes@sipsolutions.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Wireless <linux-wireless@vger.kernel.org>
Cc: Jouni Malinen <jouni.malinen@atheros.com>,
 "John W. Linville" <linville@tuxdriver.com>, Kalle Valo <kvalo@kernel.org>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>
References: <ZjwTyGqcey0HXxTT@archie.me>
 <12b6ac611c1a44b4eadbb1316636b7268ab66a50.camel@sipsolutions.net>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <12b6ac611c1a44b4eadbb1316636b7268ab66a50.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 15:48, Johannes Berg wrote:
> On Thu, 2024-05-09 at 07:07 +0700, Bagas Sanjaya wrote:
>>> [  106.201036] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.8.9/work/linux-6.8/net/mac80211/scan.c:364:4
>>> [  106.201037] index 0 is out of range for type 'struct ieee80211_channel *[]'
> 
> No idea about that one. Send patches.
> 
> (Seriously. If you're running with bleeding edge toolchains that pretty
> much nobody has yet, send patches.)
> 

I'm not expert in networking (let alone wireless), so I ask BZ reporter.

FYI, when I asked the reporter to reproduce this bug on vanilla (kernel.org)
kernel, he said that he was already running that [1] despite that his
kernel is actually patched, distribution kernel [2] (the patches itself
are in [3]).

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218810#c2
[2]: https://gitweb.gentoo.org/repo/sync/gentoo.git/tree/sys-kernel/gentoo-kernel/gentoo-kernel-6.8.9.ebuild
[3]: https://gitweb.gentoo.org/proj/linux-patches.git/tree/?h=6.8-12

-- 
An old man doll... just what I always wanted! - Clara


