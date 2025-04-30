Return-Path: <linux-wireless+bounces-22279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A7AA4E0C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 16:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31EA1BC7606
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C41DF25A;
	Wed, 30 Apr 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="SnN8H8RF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203CC189BAC
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021917; cv=none; b=i2RSuj/VMUdDqE7Ni98PKVTvQS6VRWbtVOD7gwSIwM9d7fyGh939WOVwT5F2Mj1/G8YUp+zEO8IkHACkOA7j2dtd8/zkhEEptxeKFAcyqXI2yJuODLsJcCtWIWoxjMwEsdFUH7lqsCWtsYmGAocYVQ+TLK2qAwdKe8KDsDJvXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021917; c=relaxed/simple;
	bh=40r8YS0tNhbSbcmaylfhwiHJx1/knWVNaM256Jn1uGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ7bLkXskOYVDhpHx4rD29LBGDGoptBt4EkwgEsyHa8jZsLcgM8MuPhiXywV9Bq9m2w7Z6Yz6YxXJHC4V87X2imn5WSSm6lnvk1DXW3TWfXsHvc1gWKvJkyPPc0GDUPFKU209t+1vlgq8WRJgGADFs5oEyNgJzMJVPcW88R6DOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=SnN8H8RF; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4c4eeb36d12so691664137.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1746021913; x=1746626713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I2OUPwf5IqiWZra1RWdEivTGb7UptE4RADk/sgo5a3g=;
        b=SnN8H8RFIKJjqe6NtcMDjScv/UwS4Ymxm3HGvY/lYca5uWKHNUBi6ZV7Li6kmdeqz4
         LWovX6inXlio1QEnGUZyRLNtJxLXg0rGoMw+xpoO6802WvVGN3tjd930TsJC7z0268yD
         5JnSoNkp79wuwLq/ptAaQm5P6jH+PmrBk4M+ZyM+gLPFTzj2YgNj70uZWNKmcmyEXRuP
         D93K2zmi6IUJXnB+YmyR0Qm9kp1g5V3HQ6RKtHB4XUq4iMYe3nxrRgLy9lHsVN/NEvRN
         R4bNLu5Ndza1Vyekx4wASjPPWV9K8FOuwFwVnjcTkPzYKfdYBTINVKasUyLMnxjOA7Ql
         ODUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746021913; x=1746626713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2OUPwf5IqiWZra1RWdEivTGb7UptE4RADk/sgo5a3g=;
        b=cXOS6bH36ih8H9KkQPX5r3DWNaF2IqoEo7SM4PJmY8j26xPGmmtW45aFWglNkDGUzF
         UO2fOecqspEzbEv4eyZo8aOKOpB6yZB/qgzrUFtwZW2YG7Qinnl0RH0zrIAUIidGl44Q
         gI+LmtBgFK0uLyKypqXwISa48PzbqUzhQhZw91LuwKWSSXPWqZ4IbHrkX3c6rT1vtTWj
         y0fPt4VGXTNXy4P/4VF3ua0zrz/0j+wa/H9wgWHvXxY1TytY1aa+ubfiWPLz5tfpyHm9
         HRPV10Lfr0QRvUCnqDLbph9yEg8/JgSOss6ng3quJj+t5XbYlKdZd+Yw85eydzP/YWXv
         VBMg==
X-Forwarded-Encrypted: i=1; AJvYcCWPof9o9GLUavMNiYOjvWUYa9DeEfyni1QekEgS1zndEBMUW13wEFP614djEPgAGcoeF7Kk1LI5wTB0Xib+dA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yypu/rFbTCJRJ5Tdkz5u530MM6ualY6hbuegXqneQGpyEhzb+9n
	3dmqw4aBqdGMRgrKa5urGxrAPugHc0YQaRsmUzr0sQreGc4+9FYunm4eGYHl6Cft/nMlevoJAwG
	FCIqvy1FwKPRLNoZtHGh6BdFX9l7SqJ7WFRanyg==
X-Gm-Gg: ASbGncvsgAb9JfA7mJNjjhxyXECTKz5VCmtAyWh7971uK4FXZa8P3nAS4aojUyvihi/
	hgww/cGMydahTw4R0oi9kNYJlbilhk1T9ejkQbppfMUdOEIEf0o464ihyiViFvfuDHTf53Qc9o2
	+Ok8Lb0U5H8O++nasdJANeU6Wa
X-Google-Smtp-Source: AGHT+IFox9j8ElbmmlmqmMXSXqVv6H1uivmvAtosMymiUPi0Qm8eVkYrV3yL16/ZGLs9JywFJsbveyAeuMmKzDepc8Q=
X-Received: by 2002:ac5:c389:0:b0:527:b804:ff78 with SMTP id
 71dfb90a1353d-52ace3b4332mr1525482e0c.1.1746021912610; Wed, 30 Apr 2025
 07:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com> <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
 <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
 <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com> <1d0682c0-ee5d-f2d4-199d-4ebc4e71f9ef@quicinc.com>
 <3660fcfb-be29-422b-a352-3996ad3fc41f@quicinc.com> <CAONkfw5-bfYRwHZ9iHhgJP2f8Zqyz5SZVbdL4n9EPhKU+=ONPg@mail.gmail.com>
 <CAONkfw7xjJjMAZSfHg5avEV=Bc5aJZqrRxMDvKWK4g14bLNjRQ@mail.gmail.com>
 <d4b01807-0770-439a-a77b-1e0f078687e3@quicinc.com> <07013bbc-296a-2403-a6ca-70de220495c5@quicinc.com>
 <fd6c118b-90ea-4d11-13d0-d8f49f9325e3@quicinc.com>
In-Reply-To: <fd6c118b-90ea-4d11-13d0-d8f49f9325e3@quicinc.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Wed, 30 Apr 2025 16:04:36 +0200
X-Gm-Features: ATxdqUFWDJWFx48KtZzaecKPXcltVvNxFNp3xxh-kcqEgh_N4UyHIqOkZlZR5x8
Message-ID: <CAONkfw7z3QZORCMxOJAnzF0bLNmsZKfV3rOYEhStAK628dpq+g@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, jjohnson@kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello again,
sorry for the delay.
i did further debugging and the i found out that in
"drivers/net/wireless/ath/ath11k/pci.c",
"static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)",
the "val = ath11k_pcic_read32" calls are causing the kernel crash.
by removing them the driver is working properly.
so to answer your questions :
@Baochen Qiang:
>is this instruction causing the synchronous external abort? which src line is it pointing to?
the src line is  "val = ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);"
and any "val = ath11k_pcic_read32" in "static void
ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)".
@Vasanthakumar Thiagarajan:
>i) Was this working before for you and broken recently or it has been
>    like this since you tried first?
the crash exists since began working on the project with the same hardware.
also earlier versions of openwrt has the same bug.
samething for Yocto kirkstone and scarthgap.
FYI, i use two different QCN9074 chps one from Compex and the other
from 8devices.
both chips behave the same device_id=0xFF and they both crash because
of this bug.
so had to load different board-2.bin (provided by comprex and
8devices) for each WLAN device to have 2.4GHz and 5GHz bands.
default board-2.bin (provided by linux-firmware) did not resolve the
kernel crash.
>ii) Running into same issue during rmmod of ath12k driver instead of
>     reboot?
both rmmod and reboot of the ath11k_pci driver cause the crash
>iii) Is it possible to attach the console log during reboot also?
rmmod and reboot are the same logs i already shared above

