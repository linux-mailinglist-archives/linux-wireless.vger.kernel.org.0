Return-Path: <linux-wireless+bounces-20687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C29A6C403
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 21:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520D51898132
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DBD1EB5D0;
	Fri, 21 Mar 2025 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il5ZdnVp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61213774D
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742588056; cv=none; b=suiYgHj5cip3DTAv9PDO+lKiUXezS1H6Y/ApSkQQ97Nln8VvWpMGqYiDiqKs99mz7MGqldd2W+yLDcON0E0vmA5SnuG8j0o0+he2YScoTWif1xv9rnRxjcuvRviI4OTgvEjD3fNIVs1HWZzkk91/FpTfF6eOwhoQQoi6RXMUjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742588056; c=relaxed/simple;
	bh=SNx2pBcETZPbcBWlHA8yRHMKbo3TrG3WCxGjgcH7i9Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=S0lMMcpqv2s3TewAu3TSI4uZiUsqdP97m4PYJWE+sZSFdczHPZwt8iaDnbNh/oUTO3mk37wmTCi03K4qYFfzk2Rv1t4DoKVE9AjuxuYl7BJF92t4p5/bssdR41Rcr8Cbo3aqto8PSxbJHUFlVg4x6+awVus1B/Npdo4gQy0p2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il5ZdnVp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac25313ea37so184890166b.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742588053; x=1743192853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFGFol84ECn2/MRDngi4oZR82nBj3xjJFeNpmRr+fHM=;
        b=Il5ZdnVpPQi4Dmlib5AX6V3SQoE8ZbaOP63LIXVSdJ3XTpWi07wXXHqg4tFmON/NjH
         ZJ/UVgtlxypc6dgA/rNahn1pmcG/JcXAscpjdcX5VvWGhRPfzR2jRRzgq3Ba0NNgVYb2
         DPWy3L4MaRRcWiVZOQ9S1/cibkqrhJloJPVi24WKmnBhxjKE/ooBBCPUrmM7oXA6ZNs/
         x+VKkkVe+Z5mAwu0uWq4lgfo/gg1608XQXpo2VeS1p/p0SQPEXsvDNaN/Tzh1c7Imt+e
         HQ/2oXM8dsJkx7h+v7L/mIA28YBls5tjxlRsmQ3tMkdcJ+JgyPDzDU8Xby8VOiyDsyVZ
         EiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742588053; x=1743192853;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XFGFol84ECn2/MRDngi4oZR82nBj3xjJFeNpmRr+fHM=;
        b=Qs/hpdElLUs3cJQ9jV+rhz6REE8Fb1nkONytczItLB0MbtKJrErgFfPmIiF6mtOVa1
         LrHJvsbtKBVvILBVDj4KuA/5nHTY6LW1tGyxf93TJozndshHPwMhMcIf09TUYNu+zG2Y
         B9VeHl6XbLJhjni6zT7OVNXT+WAcnJlvQkSs19jHQIDw7RslvsEsZkU/RorPIcB6+ej7
         ENKeyfc56PxMyZXafsiZ9UmUWDomzOdHX+zUj8VofgqCOK+ekfICR/IAnQ6uY2kvrTsy
         PPEJWTjCqnfEseJG4qDTETbTbklAdhVDCn8nQugGkiCBwvcHBke1jrUHvN5vGgktD1Pb
         RO0Q==
X-Gm-Message-State: AOJu0Yz3wKFPQOKp0l+a57yKrxY3ElPUygOMBWTAOJ/eBgniNA9a+Eqd
	wo6CH1yw+orMW3HMLpNJcQyGKZRoDcj19h7Lw+XVFBBRErWp9i510O+b7A==
X-Gm-Gg: ASbGnctNUs7/11Z1o2cflfh2cjcLDl79gA0aBYYcBciDG+8JPxcuoSRVo0Evot7HkOB
	vwxL8GITlj0UDbCxQIQlxuIy+/WlFApjy9NUkn7xPf6V/YosmskzUyeWg8AsLdBQAK6OVutPFps
	flIixRk6JmG/tq+4GPblr2ikl3dREQK04wPo9QFM1b+dl4am0GGyRdqCLgdEjx+JuS0862ZeU9E
	rrWKKzGzGyyALX2KQmcNG9vZAeh1KVhiak836uNYztXjupVgNVRa0fAeZFs1ULuw7HG7DbVFrm/
	X5GC4nrvGRa39Bg6a2YkHHoM2/I5jq+0WLYd2E+r3snTaylkrMVBNtKLxWDjdJ1G
X-Google-Smtp-Source: AGHT+IHLi7XewY9Yedd2QUdVyLreWf5UORUhnGBXp1AxXz4Is+3q61t183moFMsAkDwfPV9LIctbKg==
X-Received: by 2002:a17:907:86a7:b0:ac2:b1e2:4b85 with SMTP id a640c23a62f3a-ac3f20bbdebmr512492266b.3.1742588052780;
        Fri, 21 Mar 2025 13:14:12 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3d15sm206971266b.46.2025.03.21.13.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:14:12 -0700 (PDT)
Message-ID: <b69f6496-dc12-4662-84ac-aa62d0ceac3f@gmail.com>
Date: Fri, 21 Mar 2025 22:14:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: rtw88: RTL8812BU TX FIFO corruption (?) in USB 3 mode
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I ran into a problem with the RTL8812BU. If I load it a bit in USB 3
mode, like with "iperf3 -c 192.168.0.1 -R -t 60" the connection often
stops working. It may take a few tries. It still receives beacons but
the AP can't be pinged anymore.

Looking at the registers with
"watch cat /sys/kernel/debug/ieee80211/phy*/rtw88/mac_2", I noticed
the high half of register 0x240 was steadily increasing.

Register 0x240 is called REG_FIFOPAGE_INFO_5. The driver writes the
number of pages allocated to the public queue into the low half.
The high half indicates the number of pages currently available.
The number of available pages was steadily increasing, beyond the
total number of pages:

00000240  072b070b    0003fa00    0003fe00    0003fa60    
00000240  0737070b    0003fa00    0003fe00    0003fa60    
00000240  073b070b    0003fa00    0003fe00    0003fa60    
00000240  0741070b    0003fa00    0003fe00    0003fa60    
00000240  0741070b    0003fa00    0003fe00    0003fa60    
00000240  074f070b    0003fa00    0003fe00    0003fa60    
00000240  075d070b    0003fa00    0003fe00    0003fa60    

Normal values when the device is functional (and idle):

00000240  070b070b    0003fa00    0003fe00    0003fa60

When register 0x240 has strange values, register 0x210
(REG_TXDMA_STATUS) has the value 5. Normally register 0x210 is 0.

All this only happens in USB 3 mode. Everything is fine in USB 2 mode.

I tried to disable USB RX and TX aggregation, SUPPORTS_AMSDU_IN_AMPDU,
and TX_AMSDU. None of that helped.

This problem happens also with this driver:
https://github.com/morrownr/88x2bu-20210702
and with v5.13.1.1-1-g6f2541ef2.20240507_COEX20220812-18317b7b. I see
the same strange values in register 0x240 in
/proc/net/rtl88x2bu/wlp3s0f3u4/mac_reg_dump.

My test device is TP-Link Archer T3U Plus, with USB ID 2357:0138.
My system is Lenovo Ideapad 3 15ADA6 with AMD Athlon Gold 3150U CPU. 

Can this be fixed somehow? I saw the other drivers have some code in
rtw_sreset.c to power off and on the device when register 0x210 is
non-zero, but that seems suboptimal.

