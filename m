Return-Path: <linux-wireless+bounces-6591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8C68ABA26
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 09:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A5CB20D34
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 07:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703707F;
	Sat, 20 Apr 2024 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PPcRwBi1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45CDDB3
	for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713599044; cv=none; b=KfBlFr1rsusG8lEF6o5iBttAPvRVz8JalSNImis59rOGrnl8GyPo76M5B59wLKNJ+e3kKXzRlqbVxrFJB1X707H86yVb6Lk1DCsuwT3ryzZO7abvzOlOHp8VZWYEIc96YcXLmDXsXkg6UWaY2IWU/HUeoYCdwgY+kHCzNBoVPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713599044; c=relaxed/simple;
	bh=J2rC3h4wGAtPFOIxp8nWHFgYQw3FiDKI6gBblGYfg3U=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=AdoTfH/aBe2GtXLAaLIlPeBy6/oXZw1WnXQyZoWr7LVfl+mX7qfyNZo7OMfX0uHhtpC8N9DlLfiEAJBFy4/F5noQPAVXF/KfCZ5xoVdVr9vjqLUC3f1c4UAAwViT9anhy+BkpU6qWTTLQeSYOS9lXNR9nl767t0EI6dP0tX7ruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PPcRwBi1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so2520968f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713599041; x=1714203841; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2IsmDpJ6ajxB87T2NoGne5nGkeR08Bs2mSWj9kATtk=;
        b=PPcRwBi1sKmDQ7c9Lsv7HGf3W+ul7zY4A9bys5HeAfrWiUuwItXVPp9RIqUjhQEIeE
         ricZrFBnOVuYOQsP0qLUzpjrFtv99tJh/gMRsMYD3XfXkAwwoGoRtEjFciBbafn4fJit
         EqoOClwlH/Zct3qFp4TUNkOxEIgWG+kb+yLnoqXJ4uwEbybmXRJPquyAEvrmRFCqXtV8
         hwe8z+PjcPO2Lh9/YLE/zPZUYSLubQ7hApjXmJY0k9xoKHlAITnRK3/WYfrlRi8sVd6M
         YJitP7izbbMELMlyC9Z4LD3BzsNlaZLYtEPFKR/45R7OOJpuLev6yRc7spq/i3LPTq5s
         4hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713599041; x=1714203841;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h2IsmDpJ6ajxB87T2NoGne5nGkeR08Bs2mSWj9kATtk=;
        b=stkgdSCab2kipmlE98VYxz5EaS+vKO4/i7PYI7F5qjyyfZRWLs7bDfKUv53DGuS9LN
         1HEUmgjcIgti6YbIrrF/duBlwQUsPgXpVZ5jld8mrmek7a46pjgS2xd7Exa8wu8iGQnA
         eCyBg8Z7sOD39MIHl9DS8gFVGL3KUPJGWmsMrKB2cAuuev9Q77qNyqW/ijIW/85jdGui
         eViWWHv+Uq4H57mR01DruWICAsd3IIAinhRKzE0ajQQi18m0iYFL98WtuRdlr4dYNSrh
         v10wcUHyp10xZuZqcV+JhGEkmtFIF532rYUndZVzyRA/2+FdsxY7DDz1GB4iViej0KHK
         tddw==
X-Gm-Message-State: AOJu0YyfwdTxf9ibVK43lnZv53Ba9VJ4XeGYv5Z8pM0Be0zO4HhY2+eQ
	RV6lr3ldhhFYAYJLpEXO2j0mi/DNAZ+7dP1DkKVyy1Saa5ogdH3+jRxMN4Eb
X-Google-Smtp-Source: AGHT+IHGDAVaHBeu0XqRaOgX1HMAS0MgrrZ7dYFYrkBJ3aQ3+peEtVrDmUciQMUYNXJnROjRgK5TUA==
X-Received: by 2002:a5d:4082:0:b0:34a:2c89:8517 with SMTP id o2-20020a5d4082000000b0034a2c898517mr2996433wrp.10.1713599040895;
        Sat, 20 Apr 2024 00:44:00 -0700 (PDT)
Received: from [192.168.200.7] (p3ee2b231.dip0.t-ipconnect.de. [62.226.178.49])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709065a9600b00a51b5282837sm3119444ejq.15.2024.04.20.00.44.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 00:44:00 -0700 (PDT)
Message-ID: <8c3f3a43-ac65-4bd1-9563-cb8d9192b0ce@message-id.googlemail.com>
Date: Sat, 20 Apr 2024 09:44:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Content-Language: en-US
To: linux-wireless@vger.kernel.org
Subject: 6.9 iwlwifi regression: Thinkpad 480 no Wifi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm running a Thinkpad T480, lspci reports
03:00.0 0280: 8086:24fd (rev 78)
Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
Subsystem: Intel Corporation Dual Band Wireless-AC 8265 [Windstorm Peak]

Using 6.8 kernels, everything is fine (the first kernel I ever used on 
this machine was 6.8.1 from openSUSE Tumbleweed).

Since 6.9-rc1 (using precompiled SUSE Kernel-of-the-day), wireless just 
does not work.

Nothing suspicious in dmesg, NetworkManager does nothing and a manual

mixi:~ # ip link set up dev wlp3s0
RTNETLINK answers: Invalid argument

The only thing I could think of was rfkill, but it looks good to me:
mixi:~ # rfkill
ID TYPE      DEVICE                   SOFT      HARD
  0 bluetooth tpacpi_bluetooth_sw   blocked unblocked
  1 wlan      phy0                unblocked unblocked

Rebooting into 6.8 makes everything work again.
I have absolutely no idea where to start debugging :-)

These are all the releated dmesg entries I could find (from 6.8, but 
there is no difference to 6.9-rc4):
iwlwifi 0000:03:00.0: Detected crf-id 0xbadcafe, cnv-id 0x10 wfpm id 
0x80000000
iwlwifi 0000:03:00.0: PCI dev 24fd/0010, rev=0x230, rfid=0xd55555d5
iwlwifi 0000:03:00.0: loaded firmware version 36.ca7b901d.0 
8265-36.ucode op_mode iwlmvm
iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band Wireless AC 8265, 
REV=0x230
iwlwifi 0000:03:00.0: base HW address: 38:ba:f8:f4:ed:63, OTP minor 
version: 0x4
ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
iwlwifi 0000:03:00.0 wlp3s0: renamed from wlan0
iwlwifi 0000:03:00.0: Registered PHC clock: iwlwifi-PTP, with index: 1

Best regards,
Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
  public relations, for nature cannot be fooled." -- Richard Feynman

