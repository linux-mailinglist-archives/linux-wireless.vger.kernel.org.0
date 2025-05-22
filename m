Return-Path: <linux-wireless+bounces-23318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3212DAC128F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471A8A415AD
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB540C03;
	Thu, 22 May 2025 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+1+cbXc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E56615ECD7
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935952; cv=none; b=ETX2vPx+DZ9bKgIiE+uLe9jAEx9F7wXbHCGtrf4wIFoM1rkd3lsocFwFHVYuE0cqjqF2YJ0J8vO9KO7ZorQyGrfMoH3zRc+VMY7sF9XR2TBK4xHV1+4jWtqamqeMPFPN90thIw+HZwXcnGqt1CMqMCZtaya/H8x9J73uM2j/6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935952; c=relaxed/simple;
	bh=eWR4JWiscnyqElgMk7uk+JmsOJxg08AXebRbWnv41/o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=oS06eqK28NCqrh5DowgILP7K9aI+1NIyKUo8hGyfW9uMZohfw+jMPjhiaVQTgkAc7DgEhGjcq2XOattov4MwQJ+addDKbptMHsk6NPpLZpxEWN2BrXPO+c0GtSHNy/9Z+BsDyV8139CjTpSzPIpe6XrJK/YJ65a8TQi710miocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+1+cbXc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73712952e1cso7627981b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747935950; x=1748540750; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxIJslS7fVMq6rKcTzr/1EggzCthpC8rBBOO/koOomg=;
        b=e+1+cbXcVCbjSQGnN4iQ1O1cTwtJUSeCEd5jjLAckWso7fQjpuWObPhJd9CeYHYI3L
         EZ4FIlP6YMpfWNNn+Nz1Fs2sfAvg7uCLVG/RDgsmEGjw6+6MWlrLUeC4DV5VUPp9qWDK
         8BNreUPfwexr7Y3jYTgIDhEuREmvFYNdZoULoJlmFAFJXnqRNopEycS/ecpF2Zoe/Mtb
         VpaFItmOeezStV4RoGMbSt18z0L3ww8jDXKS/fsrPGtWDUIWOBaCvCHdSNRfNAwS4Uwn
         AQB2BTyKPQj7blfcmq8JRelBXhXFY5YkEnzh0JrnGtTxzfZhJa44SR//iZs+kaHrVhWN
         nlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747935950; x=1748540750;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dxIJslS7fVMq6rKcTzr/1EggzCthpC8rBBOO/koOomg=;
        b=INZVlX5jJdgUT3FHd5dFviR70TBdcqRjkz3+MD3jz4W73/lLwG3v4UGrLSfoY2HWTP
         P4NlCelZQQlyxY1skclC1s65RJ/ksIoBJ1uMn+jFtH8thK4teO/1YkLoSpUdHDP019RA
         ryx6gmXT7rgNCl+uhvW+9NSdBHNgvPrYZe+EBOPkxNzwSiYr6sR+xm/hhoctibe44MF3
         9h3yX71lZyxsJBURvwZgRfLXt9mjHSkO3nn8YyX51yEO1mZLTcUw4PelNHa8GxQ3I9O5
         aBAr0rTVOMSOWw+O743Ewrsf5qIeiDQEEYWSrdJzJZKtU6esQBYzUbUuB4Fz1BlDkv5K
         XSbQ==
X-Gm-Message-State: AOJu0Yz7Y+Q3yfbAqBV8djHOnXAERtsEnGs08oDobLVTq4UgKqBl7dTS
	zWI0hlv6dt95g2BbnXN/Ki53N5JCV6qa6tE6GPnxg38vmwadTY2EXn4/oGCJ4A==
X-Gm-Gg: ASbGncvdotnkrbnBJNzKv3xvbKs1MHOEt0mW/F7M25V8F7E3cUJslb/wvRAMCeqpSuP
	bsnVPyx0/AZ5xTO9EHeT6ZeqJeQgsuwZDaTMMx3Egs4QFNThWmIjSnTNEbOKgjcA6SvH0lDVSMN
	K5Ly0rZKRdRyiBhpvllYO/mqDq5rW3pKuB3mFr1pz0nJKlSK3xeeawLCUthHyqFcScWwC5jkNWB
	5KqQaZ7qSTaROxfHBMfX5vgyTFY5LaJF03dNp3BAxWb65eBMZ9wA/41W0Q4kx/Zg+i3VtJOJLCH
	c5vPyY9rrUNLB3SywVlvtMpXMxHW7fYiyekz92NwAtQvTMtv2ziIAiiVU+Xvh1GJNOF8Hkm5kCX
	Ti0Vo5f2Y8fSKLeqG0NMprFdwYCwU8nkA5PqJOdqu
X-Google-Smtp-Source: AGHT+IGvYRzYp88IMnXv4uswo6bDDUpvaTg6sJXNy/rnBXdTQbUqjtTA3fnD3dYysXyuaJlS4Umt5g==
X-Received: by 2002:a05:6a00:1305:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-742acd5096dmr28537010b3a.17.1747935950091;
        Thu, 22 May 2025 10:45:50 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9876dacsm11878987b3a.134.2025.05.22.10.45.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 10:45:49 -0700 (PDT)
Message-ID: <ba82ab00-ecf7-44fe-95db-355795c3520e@gmail.com>
Date: Thu, 22 May 2025 10:45:48 -0700
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
From: James Prestwood <prestwoj@gmail.com>
Subject: Association comeback delay behavior
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

After noticing this log "rejected association temporarily; comeback 
duration 1000 TU (1024 ms)" I started looking more into how the kernel 
handles this and noticed a few things:

1. The kernel takes the delay in the association response frame and 
waits, but has no sane bounds for how long the wait is. An AP could send 
0xffffffff and the kernel will just block for that entire duration.

2. The first issue would appear to be guarded by the fact that 
run_again() only reschedules if the new timeout is less than the current 
time remaining but only if there is an existing timer set.

Looking at the code, the association timer gets set when we begin an 
association so it _should_ be set when we hit this comeback delay case. 
But through testing I found that it is not. Hacking hostapd to use 10000 
TU's as the comeback delay I see this:

[    4.338185] wlan1: associate with 02:00:00:00:00:00 (try 1/3)
[    4.340023] wlan1: RX AssocResp from 02:00:00:00:00:00 (capab=0x411 
status=30 aid=0)
[    4.340409] wlan1: 02:00:00:00:00:00 rejected association 
temporarily; comeback duration 10000 TU (10240 ms)
[   14.654103] wlan1: associate with 02:00:00:00:00:00 (try 2/3)
[   14.657405] wlan1: RX AssocResp from 02:00:00:00:00:00 (capab=0x411 
status=30 aid=0)
[   14.658430] wlan1: 02:00:00:00:00:00 rejected association 
temporarily; comeback duration 10000 TU (10240 ms)
[   14.848706] wlan1: associate with 02:00:00:00:00:00 (try 3/3)
[   14.851596] wlan1: RX AssocResp from 02:00:00:00:00:00 (capab=0x411 
status=30 aid=0)
[   14.854269] wlan1: 02:00:00:00:00:00 rejected association 
temporarily; comeback duration 10000 TU (10240 ms)

So the first association attempt waited the full 10 seconds, then after 
that the timer was presumably set, and we only waited the default 200ms 
(ASSOC_TIMEOUT). So to me, this feels like either a bug or an oversight 
on how this should be handled:

  - If the timer should already be set, this is a bug as I see the 
kernel waiting excessively.

  - If the timer being unset is expected, the kernel should be limiting 
this wait to something reasonable.

I also realize that CMD_ASSOC_COMEBACK was added and userspace gets 
notified, but this feels excessive to handle in userspace when the 
kernel could instead enforce a sane timeout all on its own without 
requiring userspace disconnect/reconnect when the AP sends an absurd 
timeout.

My main concern here is a rouge AP scenario that can then DoS all your 
clients that try and connect to it.

Thanks,

James


