Return-Path: <linux-wireless+bounces-19026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39BFA377F1
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 22:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EFB7A43D9
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 21:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987751A317B;
	Sun, 16 Feb 2025 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrvEEF1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5AB19E7F7
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742926; cv=none; b=qqp95TvY+b54OLrnt2czilsnjadpJrJ4AJmIc/fGXXMniOTzJpF3uLVbdYHD7fi2tt4J6d8F4zy3aDBaNXCnMj+bwrAbGkrWlJlf9iZ64oUWax/8PrAfG3Mq30KoqHI/HPMizgrNSeW5YZRVboUjp3ILNmykOo/1eZim6HiJoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742926; c=relaxed/simple;
	bh=Wq1x9u3zKAFJRxm3EbHsnhDVjv5XquPjYUZzF1H0h3Y=;
	h=From:Message-ID:Date:MIME-Version:To:Subject:Content-Type; b=tLJV16PfK+2HAkR/QCKA4cqh4JB2Tt7dnGsO08iQaDW/WN+TbJuH/Dti2VwmqGNdACzlKTNyFto/7pfWkU8q4WiI/tkm/3Eb8NkWREIdfeTJfG5C9MDZei4n02JcWKjz77NtnyT63/xybQBdDAR7FtYQleSZKTcZsnJecjDxJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrvEEF1K; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f3eade4116so793834b6e.0
        for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739742924; x=1740347724; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bOCqQai7w7ffJji44Q2FJcJLgc5qsRnhua0tCMwIew=;
        b=GrvEEF1Kg1p7VN8Fgy3+5UMI8HyFfp7AikEInQgd1BkyhDd+0HW0ZWFZOg+sZyA1Pw
         gqCG/RoWhmSBIXvTxxvdJL76eGYKg0RbdwnvMYv6Ye+9VaPvKh2C+sWXOnsNi8Xfyrir
         +OnbQHBP7vHXSvcfBsUWNVlaXz27EwI+2bHDQ+C11011ate2pB3vdpZ5FZpjOItsgnXL
         Nvk7wbFlKA9Ty62HIYYXJkcfz33DRijhcjC8xCU9droW4ULTq+C8eujZEuLh4HR06WO4
         H1OJf6p/nZjYse+bj+0VvWSjwR18Vpm4Nv4CJAMg5KaoSLLm5FQw/kUwf8rqzNOwZ3GV
         19Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739742924; x=1740347724;
        h=content-transfer-encoding:subject:to:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bOCqQai7w7ffJji44Q2FJcJLgc5qsRnhua0tCMwIew=;
        b=A+J1No7bFzR+fVGyyxKV+ncKYLYGpP5u4ttrbWvYjNLLAoy6a+cdxwE4Dw+r25zxSF
         XpISMo6+Az/CjZVdrmxVO4cLqGKdaDxuhTqhbjLxV+deBglKRLI3AaUXz+O5/p+yekBU
         1kS3ycexK+c8twm+mMGxtpDcerJ/PDnjgkeDitROtgU46uyv40BhLi3htdPh3h3O7CkD
         uaN+ZGYX3pDib08pbpgi5XRFZ9KEkr27GtRAQG5Ypd9dzXOrYAaf7xnof8b7Q2gKhknZ
         DVOoelj4NAf+RHHYA4XkvFZgaVuBdOywWbj8BIWhIOjfq6pYdY1zMhJlllI/AWa2DVED
         SBrQ==
X-Gm-Message-State: AOJu0Yy7wyN2quKs88wIWFAMZLOYUUWnX0QV4lSa8uKuTNFP6mv8P9+j
	1ocW5NnVFsaEbri8rUf0PRzDPArGLzPEIxGRg3w746aANQ6K758MJJAKem4C
X-Gm-Gg: ASbGnctKjecOCP4HKlP/R78HHif3CpZewJ59KbzUDRod905Ol2tFTCEZO2/18D2PASz
	cMmg6/LldzQQ9ScNlf3cXXZHs2NuN38PcKQDI9wuXye17ON70WrNaa1iQPraaZ5z7zCnYMdfw6z
	fchcyHz2SNMgbO0eE6ZWnSATdLi1mwuHDd8pajlixTLaE0mdJVY9sYqK6EFLcH4bibJ2LIcjY9v
	a60uFdpjpHb3z16A811sKlow8T33KfYns9DVnXx67X0SCixSL2hiSOSLUIXuSdy2dqCMpHJWEr+
	czNPA79eaD3sfkb09w1V/gs=
X-Google-Smtp-Source: AGHT+IGwz58YrJ6wdmggz24eviixJ1hZILZAoEcU1jyLV965pglR2la/wJB+9kbcHqcBarEvW/saXA==
X-Received: by 2002:a05:6808:3096:b0:3f3:e267:6264 with SMTP id 5614622812f47-3f3eb0b483fmr4721659b6e.17.1739742923628;
        Sun, 16 Feb 2025 13:55:23 -0800 (PST)
Received: from ?IPV6:2600:8804:8c40:76::94c? ([2600:8804:8c40:76::94c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3da92b7easm2857583b6e.7.2025.02.16.13.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:55:23 -0800 (PST)
From: Nick Morrow <usbwifi2024@gmail.com>
X-Google-Original-From: Nick Morrow <USBWiFi2024@gmail.com>
Message-ID: <41eaf1f2-ea82-47a5-8586-60e3337f49bf@gmail.com>
Date: Sun, 16 Feb 2025 15:55:22 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>,
 MingMing Yen Hsieh <mingyen.hsieh@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
 Sasha Levin <sashal@kernel.org>
Subject: [Regression] wifi: mt76: mt7925: Update mt792x_rx_get_wcid for
 per-link STA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Last week I started seeing problem reports from users with kernel 6.12.13. When users moved back to 6.12.12, the problem went away. Bisection appears to indicate the following patch is the cause:

3fe7acc6f4b42ccb1056c5847f18f8eb2fec0834 is the first bad commit
commit 3fe7acc6f4b42ccb1056c5847f18f8eb2fec0834
Author: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Date:   Tue Dec 10 17:19:20 2024 -0800

     wifi: mt76: mt7925: Update mt792x_rx_get_wcid for per-link STA
     
     [ Upstream commit 90c10286b176421068b136da51ed83059a68e322 ]
     
     Update mt792x_rx_get_wcid to support per-link STA.
     
     Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
     Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
     Signed-off-by: Sean Wang <sean.wang@mediatek.com>
     Link: https://patch.msgid.link/20241211011926.5002-11-sean.wang@kernel.org
     Signed-off-by: Felix Fietkau <nbd@nbd.name>
     Signed-off-by: Sasha Levin <sashal@kernel.org>

  drivers/net/wireless/mediatek/mt76/mt792x_mac.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

Here is a link to one of the reports that show log results:

https://github.com/morrownr/USB-WiFi/issues/577#issuecomment-2661586464


