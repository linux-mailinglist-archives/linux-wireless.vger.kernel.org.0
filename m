Return-Path: <linux-wireless+bounces-14267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D79A68E4
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 14:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AD21C209D2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C31F4FD1;
	Mon, 21 Oct 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="app+AzT4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D11D1F6F
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514666; cv=none; b=WcMVZgt+/8r9dzzA5ljS8+GM1FXf8fqAwYW+TmlXmQrv6iQxV6VLfemm9nCwIikTA2J5QugQggvh4+lm+vSlya8d3n4b0HPd/n6u7AUsdyJSJ/ufxoUO41Sk5OpqsZ8Lw2/CUSi/30FrdA6smuZz4KbgdY+C9PU7Bc4WHtuCWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514666; c=relaxed/simple;
	bh=4Pgi22eztgz4y0Di30DcnYRNUL497NnGl63oQpofdwk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=YexxtgCb5rvADb7C33+UI89x3NerW0+13jz2/A1cKzgrkSgmN0F9nVmARVZCPKJ6bwJNaFHD0zdE8j346GCxycz0FTS/LWcP5+l82nx0kG6tRgD19O8rhZ+Nnf58c7+SpEwoKMdLxHsyKgDzW3pwlrnBn3Kc4uGHpTNVxEo/dpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=app+AzT4; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cc03b649f2so31850106d6.3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 05:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514663; x=1730119463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wED9LSDXASYhZO+sUv6q/7sOBSvh2CkLZsLZVG3FmQA=;
        b=app+AzT4sftvxCJUczFmZH8OsmxK3Uh7fj/NCyfuRSPhcdK0y5cnG3T6qxXUq3C8lX
         N0iDzFPY7JbPxToXdwwuFvgMdeegxvr0XBhrpV1tENVqsGVF4UBOigTUhnbWA9SNHHkN
         pma5cnLYXOpAohwo+ZP4n5AZrDEDnSU3a+JVXfj2rjkG4D0b87MD4QTWzjA3k7a1AnCR
         JpXYhgLAWFLI6foM+Vx44tkQS036HpAlm2P2J8yaqB0g6wosI/3Xrc2quLVEFsGi8KbF
         W72I5MWFa3rX90hJsOFsED2aNzDchADVUxl79dJ5Eoxhr2CmdKcGV2Ypo5gc5Gil6Ehf
         RU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514663; x=1730119463;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wED9LSDXASYhZO+sUv6q/7sOBSvh2CkLZsLZVG3FmQA=;
        b=jyK56AMa+l83BdcsD2FWAAVEDUnLS0JGNmToS89vNSG+Y7ijrJqq5qcP3evVrE7O+7
         bRDHvBpywtteUcuWssVcl7I5VRhYa4F5UkrjYH79RL9fzJmna+nY25pBvsMUwrPo9FrU
         h2CuSh2DrN0YoC2EiYI0XP9dAIH+xvByyrQVvjs96rQqzPqTBFdj8mZ2ErRulqz8fl8A
         EsL3DY/0R4Ke2ECagWeUhdQIixN4CypLGvM2HsifFPN9AG+HE+8Jr8xsRRBONp7j/qA2
         rT3Eg3bS27WvNZOkjmkZbIYyxeO2NjL25O6zKX8EQrNXjNLr3/nYLm5aTOBv33KgX2zV
         9YHQ==
X-Gm-Message-State: AOJu0Yx6k18I2fED64V6ywHVPcpoevG3oBwgNbKoZr9HLpgrdgPNTT8V
	gjCHb2IF1k4DI9dK/NGzGENkXzTHWOWtwVfxuMc1AcVXA71HlzKgWPGliA==
X-Google-Smtp-Source: AGHT+IFiDd7L9cgqfIMEBrgrhebMSoGL7kU/QVrq6Uq6u8vBwVceq+qF9dmZvX9W5ZZVyor167oKUg==
X-Received: by 2002:a05:6214:3d0d:b0:6cb:e6b2:4a84 with SMTP id 6a1803df08f44-6cde14d1c48mr191595186d6.14.1729514662847;
        Mon, 21 Oct 2024 05:44:22 -0700 (PDT)
Received: from [10.175.241.120] ([72.46.116.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008f5ccdsm16909986d6.32.2024.10.21.05.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 05:44:22 -0700 (PDT)
Message-ID: <954ffcc6-18ac-4f4b-9730-ab12c4ca7cd8@gmail.com>
Date: Mon, 21 Oct 2024 05:44:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Prestwood <prestwoj@gmail.com>
Subject: ath10k/QCA6174 performance hit with multicast frame registration
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath10k@lists.infradead.org
Cc: Jouni Malinen <j@w1.fi>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

A patch I authored appears to have introduced a performance hit with 
ath10k/QCA6174 when userspace registers for frames and sets the 
multicast RX flag:

commit 63b896629353157e8ca77cabdfab340b5c69ca59
Author: James Prestwood <prestwoj@gmail.com>
Date:   Tue Dec 5 17:15:36 2023 +0200

     wifi: ath10k: add support to allow broadcast action frame RX

First off, the performance issues appear generally as packet loss. It 
only seems to happen when we get 10-15 or more clients all on the same 
channel in the same vicinity (all registering for multicast frames). 
This is somewhat uncommon even in our uses-cases which is why it took a 
while to notice any of this behavior. Based on some PCAPs taken about 
50-75% of the air traffic was retransmissions, many were ADDBA/Block ACK 
related. Reverting this patch OR forcing the supplicant to not register 
for multicast frames (thereby bypassing the configure_filter logic in 
the driver) resolved the issues entirely.

 From the supplicant side I am currently modifying IWD to only register 
for these multicast frames when it needs them (i.e. when DPP starts). 
Looking at wpa_supplicant it already does this afaict. So I think 
broadly, the impact of this is relatively low and should only effect 
users of IWD, running QCA6174's, in high client load environments. And 
an IWD fix/workaround is in progress which would then only effect those 
actively using DPP.

 From the kernel side I would obviously like to fix this rather than 
revert, but I'm hoping to get some guidance on what might be causing 
this. Is the driver getting bombarded with multicast frames causing 
drops? Is there some lower level filter I need to configure (like in the 
firmware)? When I wrote this patch I was following what ath9k did as its 
the only other driver (besides hwsim) that actually supports this. This 
is making me question if ath9k also has this problem, but it was just 
never noticed?

Jouni, you implemented the ath9k support, was anything like this noticed 
in testing? Based on what we saw this last week its unlikely since it 
requires so many clients, but I figured I'd ask.

Thanks,

James


