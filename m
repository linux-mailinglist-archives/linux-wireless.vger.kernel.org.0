Return-Path: <linux-wireless+bounces-13520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EBA990F4A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 21:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7121F232FB
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 19:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771121EB9F7;
	Fri,  4 Oct 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUGGasi0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30EA1DAC82
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067621; cv=none; b=anYCz1LZRRYkFbM3jF/H0WnPWpH2N1f5G/fYbrWC7gaczoweuF1cEjsF/IUBcXcwDJRLQlYAp8u1b/WquJsVw5cPSt8+YYOrPdH/P69NG1zTxPUKdZh7uSdwUJWZKEMgKZwlBGChw9kGIp5ervExEwstmpFWo48enWKimrtPNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067621; c=relaxed/simple;
	bh=dJDOncwyPC6pcdwcZhbEsjUF17RXZs10TSMwufRSA4k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Wds3tKgKnQvLYahyEsVnUCObgebqdUiPsLDoeiz8/YFaQ9X/vqDHK/CFRI9bAammpXaDA390PHGvUUrAFJ6snuTvkeqb3tIh9Tn8BIrU6cUaMg9XzYhLJiUy6Eigmjpf81HPxlIhiSXJAxfig/u23sitCHXSz0r3NtIIuGTY3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUGGasi0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7ae6f8956baso118099085a.1
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2024 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728067617; x=1728672417; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTlO8u4SEvc+ukyFmrhTzrzHYiAD7mqkad8uygUfBik=;
        b=aUGGasi02DGjgG4VpJQpgvYP6EDkty2lfXND0fQ50dfk7gvUcCVB4i0+fQ5KO4vRJe
         yllKN5FBfDE7xD1HyiSHtPH0EU5kbaSAkibasauEMWpztPclR5Du34m9ErAGY7vdbe40
         n8owV3Edpe7AZnB3Uav6fswATCQ3b6V5bIVELJ0JmlytPUZgV49RLXtWAnpa6nJdkkri
         0OUSAaUIgVAJZEhy4SJYOijEIiE2OGUADuTLAatnFlq1rTb9BO3XTuMvM4xdLLKUUX+P
         z1270hipQO4bgM1dLvY8fhBwWi02/YO5sGxe6C2SEzkGOH+FSeaEKK+HGbHVwjFKKDU2
         WamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728067617; x=1728672417;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DTlO8u4SEvc+ukyFmrhTzrzHYiAD7mqkad8uygUfBik=;
        b=WF/qFrflkDBk6zq4BBHjwVzHLnZoJlgJT4C2pDE9a9sUbR1xsEuLOd4M9iLD2eN50L
         ADG6aOixpx+W7eAxEgWjwIN430ZBEJ32jclvg2uKHvTdzcaC8ZOB3er2EiXKa5g6Zlcy
         6BtrghizlCc4X7P5v5EfD4Hddm0pVZBsg68+tGwggZ+Xa89/FUd3JV2nzychUn4BTCP+
         tHvn0lYetBqCGYDuTxS5xn7leWWedOFZspau9JITiZk4E6LlkuNxdUwW6LrfC3HDsmd/
         vPwu+r2jOUFV4P7U4xwMhFbVxI2/Y/YTcxFslqlB5m7KG4EPH9Br8Mupm9N5R5AvR/g1
         J0Vg==
X-Gm-Message-State: AOJu0YxcnKIf8vkcw3loFzr0jPp2/Y1PssVmjBBYxBRMswNvx8AREvvH
	tRp7R1HdQQsEcjoERSip21t07q7D+44EszJh3A/Gkbra46x8JxgiizgmRg==
X-Google-Smtp-Source: AGHT+IEzfSwzQufxcJwvFUXmoKY5QYcdi8XL1Sx7wtH5g4iIFGIERTFZNS16Djx9Kl60oYRoB7sWZw==
X-Received: by 2002:a05:6214:568e:b0:6c5:517a:56dd with SMTP id 6a1803df08f44-6cb9a308e43mr48331246d6.16.1728067617317;
        Fri, 04 Oct 2024 11:46:57 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46cad28sm1657486d6.18.2024.10.04.11.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 11:46:57 -0700 (PDT)
Message-ID: <cfb00919-678f-408d-9fb9-83fc24fee197@gmail.com>
Date: Fri, 4 Oct 2024 11:46:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
From: James Prestwood <prestwoj@gmail.com>
Subject: Missing scan results with SCAN_FLAG_COLOCATED_6GHZ set
 (Ath11k/WCN6855)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've noticed that when setting the colocated flag much of the scan 
results are not appearing when they should be. This was seen in a large 
warehouse where our network/SSID was using only the 6ghz band. There 
were other networks on 2.4/5ghz though, which maybe is having some 
effect, but those networks are not broadcasting on 6ghz.

This first came to my attention when the majority of our clients were 
experiencing horrible signal quality. Upon looking at the logs and 
nl80211 messages to the kernel IWD was issuing both limited 6ghz scans 
as well as full spectrum scans and only showing a few 6ghz results, like 
1-2 BSS's which should not have been the case. I was able to scan 
manually using "iw scan" and I saw all the expected BSS's. I isolated it 
to the fact that IWD was setting the SCAN_FLAG_COLOCATED_6GHZ and 
removing that flag resulted in all the BSS's showing up in scan results. 
Note, that with or without the flag all the 2.4/5ghz BSS's were showing 
up without a problem, it seems completely isolated to the 6ghz band.

The NEW_SCAN_RESULTS event was indicating the kernel had scanned all the 
expected frequencies we were asking to scan, but the results were mostly 
empty for 6ghz. Only ever the connected BSS would show up and 
_sometimes_ another BSS, but generally not.

I'm trying to read through the code associated with the COLOCATED flag, 
but its not exactly intuitive (to me at least). I'm not sure if this is 
something with mac80211 or at the driver level. I really don't have 
anything to compare it to as ath11k is the only hardware available at 
this warehouse with many APs around.

I'm looking for some guidance on if this is expected behavior with the 
colocated flag, and if there is any concern with including it 
unconditionally on every scan. If it has unintended consequences like 
this, generally, across multiple drivers I'd like to re-think its use in 
IWD.

Thanks,

James


