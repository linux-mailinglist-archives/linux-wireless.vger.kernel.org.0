Return-Path: <linux-wireless+bounces-21401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E489DA84AD2
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 19:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595AE17EDFC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392021876;
	Thu, 10 Apr 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn7fvw13"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1E1EB5F0
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305536; cv=none; b=eqt335iPZW8+f5JfW1Fc9LDL1mtsNR6ajWBh5Le4kyYruG06rSZsLqKmmvoZLucQ93u8t9zyZ/56zjE03pqa9LaiZDdH7rsuqL7fs6LPJ62l16iYLx2XNSJOzI9LT09wgRDiVa6eF1hcwc4Sydea+3fqTOhucFkAXX2CroFR1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305536; c=relaxed/simple;
	bh=CUSKcv01A3Z7tGqgIubF31pMfSqEYNOwMRKyLZqVFL4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cqoLkqUlwq26agSwsL3R96Zs9da8kK47/1H5JUrn49EERPgBVxooNqe/Arsrko0tPEUOAhxHGl7gp5d600/jRjPAoxPuo3Eil7gJKkSwkWE23TQWHyai1fv+ukFeLxfjkmlGk4aNS4Va1emGhfRto4XRc2D6mT7RpwY5Uknx0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn7fvw13; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso12519641fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744305532; x=1744910332; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wKZjCOUm/+E+VVdkTgN6jg9pP3FthH13Jp89MA20y8=;
        b=cn7fvw13PtLqP9kMW0CBcC7iBa6F+ZU49Q9FqIqXVFmfSV2iBe0tw/MSWNFjRzCcOm
         uuan7fJMthpoek202AiwlM4FFA4KnYun0BbrRCFwm6gcCoo7vpXgxS/s7qIabgpB1Nw8
         G99VEzW42tj6jekpl5D7reNPpEuU33qY/0sbv5F5CpAge1puN153sgWhZsZztM2PYomi
         zoB0WbdSWqWarPxjikheoYkpY9RDzFaZMQ7uwEHQBKAXerKX/sj1lZSb085JhVyTEqSl
         XNCjgYMzhvifcpwlq7XGcX4/j9d/P+G4WtBuVumcsvOI5dJwt1XZg5Q821UwHq9EYorG
         Vv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744305532; x=1744910332;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/wKZjCOUm/+E+VVdkTgN6jg9pP3FthH13Jp89MA20y8=;
        b=wFxckoEuCHH3m9iXOl+Y9USvK9iTNrRCala5+y/xI8ui+nwVnS0uaOKSvtJeZ9GDh2
         CWjV9nWo8EX4wQhObMUsJf82DCCde8qrDAilLFSyaLvNS9zmiR1F5jSg21Cj6rFCeyHp
         82UWha4cNaP5retKtmLu7Vtvrgv89aOs68s7gYz8hZ1VfgGm2rVLgYBR4u1LLUyUl0o9
         1Cmq1roqIBeZILdOCeetQIM06dXxVMSVeDgzVIDxc1c/4ZSRVYzkGs9BObQ9Nc/mLa6a
         Uxo9esG7IPv6glD4vPL0sYxz9OSnSZPuBwr5GKaV3HG/Se+1eN7WixLLYOYVBfVGKsY7
         tqjQ==
X-Gm-Message-State: AOJu0YwQfzIeW5UQR2t4YKgdZkcmJGO/HHlzInfN5ZdPL6pzwT2tkRKn
	680J7Gq7yNsh4NUXAx8AiAE/sAwahSMxgAocYb5pwTqtQI6o4vCQnMcmbAIR
X-Gm-Gg: ASbGncv2mRfpB7JQktgI59mxi7oOK2Bk/VdcOw3BusX1yFrqbaCwWTvSbjhcG9987pH
	QDMF9fSJnTM8NG/P6ILpYuMfo9/I9j/CwY5NF1kgQX8JNzUbLqKfeYmo4tK02lP54mXgI6q81qY
	RgToauD7FJzN4pQw/DQVD12yqCTEDFIx5zG2Uzk9cVM0SP8/58hPi4Qb/mV3KVqwHjCJB5BOTGw
	jSi10Fo21rSjMqNUcgo4+4eINnUEalM32eUrBqQ2Pl1zh8c5XaB3/3MgR3T0nIvJeUZZKO00VRL
	7b3uwjeeN/Ysp3f6OG/iypqCiXNzDcXRZiqKaEZtKrG5e4MoPq8UfiF0yBI/+BCzYXCorvdYGLm
	01iYrOUjzwqMGjb3G2inBQJBrg6a52Xtqk9CtK55p1alWX+i8umywB+hrNiXsXu/FuIDTsGqh2J
	PW5s/OnmQVGDgL3WnUiT69
X-Google-Smtp-Source: AGHT+IFKp2378vOb7HakoGS48OaC5ALxaLC8ME9nN6byoKfPO6QQdr4bkGBSpy/aS3+CD1fnUSjT6A==
X-Received: by 2002:a2e:91ca:0:b0:30b:fc3a:5c49 with SMTP id 38308e7fff4ca-310156a8dfbmr10051751fa.9.1744305532026;
        Thu, 10 Apr 2025 10:18:52 -0700 (PDT)
Received: from ?IPV6:2001:7d0:832a:e200:762a:78d0:56a8:7217? (7217-56a8-78d0-762a-e200-832a-07d0-2001.dyn.estpak.ee. [2001:7d0:832a:e200:762a:78d0:56a8:7217])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464ea274sm5563681fa.52.2025.04.10.10.18.50
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 10:18:51 -0700 (PDT)
Message-ID: <f85abad2-20eb-456b-9bd1-455a4a0f07b1@gmail.com>
Date: Thu, 10 Apr 2025 20:18:46 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
From: Avamander <avamander@gmail.com>
Subject: iwlwifi: bad HE/EHT 6 GHz operation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I was trying to connect my PC with an Intel AX210 card to an Aruba
AP-655 on the 6GHz band with 160MHz bandwidth. Unfortunately this
results in the following kernel log messages:

     wlp4s0: bad HE/EHT 6 GHz operation
     wlp4s0: AP appears to change mode (expected HE, found legacy),
     disconnect

I'm currently running 6.11.0 (-21-generic #21-Ubuntu), with matching
iwlwifi ("driverversion=6.11.0-21-generic firmware=89.202a2f7b.0
ty-a0-gf-a0-89.uc"). The network however seems to cause no issues for
macOS devices.

I've captured the beacon frame and it contains the following HE 6GHz
operation information:

     Control: 0x03
     Primary Channel: 69
     Channel Center Frequency Segment 0: 71
     Channel Center Frequency Segment 1: 79
     Minimum Rate: 1

There's a very similar (and singular) issue on BugZilla (219159) also
concerning operations with Aruba AP-s. But it seems that it's not
exactly the same. First and foremost, the CCFS0 and CCFS1 seem to be
correct in my case. 71 is a valid 80MHz channel, 79 is a valid 160MHz
channel. (As per 802.11ax-2021, CCFS1 must be greater than zero and the
absolute difference between CCFS0 and CCFS1 must equal to exactly 8,
which seems to be the case.)

Commit 91b193d546683558a8799ffb2e2f935d3800633e seems to be the most
recent one that directly adjusts this logic. Manually checking
all the channel/AP parameters against these new checks, everything seems
to be valid. But as this code does not log which exact check failed,
it's very difficult to say what's going wrong. (Given the relative
complexity of this I imagine more detailed logging would be handy for many.)

I would really appreciate any help debugging this.



Best Regards,
Avamander


