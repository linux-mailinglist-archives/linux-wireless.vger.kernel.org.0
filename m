Return-Path: <linux-wireless+bounces-23489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E16AC79E6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 09:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9FD188DA77
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF93B21772A;
	Thu, 29 May 2025 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+Gv9hMF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244921770B
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748504389; cv=none; b=rfee/rARS1XCr68G28M7kOBLivMw6/PtObAZhxcpAv6FKKdqD/UxsZBaRc6ZNBP1MlelgH0RVh3tmDQH1daahfaHaWt7/NHa8YDnD99yfYQeBQEzuJSqrVQI7i0SH3v0UIlS8qd+WWIyfPQ4iMTvztWVmekbTA9vlxpu59O3VfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748504389; c=relaxed/simple;
	bh=TK/YaAvIkRgbB3IN3HERp40cpeRfiMLNOT5drycno3w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TxPI3y8ARSWPESCHDvfUrt7VjkpKYbMtbaYI/fOCBrpl8goQbx+UygVDLwnAYvnJKEfl6P6i3CG4DuD8NrmmAl3fqmcXOzsBE1vwwnSIBK562BQYnjqybXKsOPCawAkdfHeAJfHFahvrnWy0KHtjpmI1EY/Qb7NXTJdMBD2krNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+Gv9hMF; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f2b04a6169so8786486d6.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 00:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748504387; x=1749109187; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TK/YaAvIkRgbB3IN3HERp40cpeRfiMLNOT5drycno3w=;
        b=K+Gv9hMFcG9HS4e7eV0qevGBHLPpDUTrYQz2dB0PDPNINMyK3WyXJ2mmEuA4BFbg4G
         FAj1CAikMAz0qU/bVVFZSs8nwwumUw5y8pd9r0JFJc/KRF392UjtlIshQlwyOHIohwkx
         qQNMqMya03FHeF5NG9KwQcJZOY48HCkqCzRyu4QjjANmBzfLhwBsDES0391kKu5ahm+h
         R4cacqlcmZF2oliOyfc2M20FeIIYlMVmQHvajPwuGwgEr2wTiExRx2npQ5HZceKAQmDw
         N++VDOphjKr+xns3LCZgM8r9gD0c67eXNdm+16Ii9SvTrmF/LWbXoTdVJ/Eiix7C5hoI
         pVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748504387; x=1749109187;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TK/YaAvIkRgbB3IN3HERp40cpeRfiMLNOT5drycno3w=;
        b=xKkq9MMmoJkgryZqBNzAjjf0FJtbK/wxYW8b0bOFDs2s4/+l5WUZaMilQI/V7Tjwic
         yv5dsvmyQILA9CRp+JT/PKCl0NF3WuQse4+f3kC5qDpw3rbYpykK0U8dxbphMC4XLRqL
         C3ijHLdAo++7d5ROZ1R+/UiHTtmrVR1xkS7RkUrZvWveijaJTFOF9qdbNvKFk0aIDtLr
         AOeyyZBm5NNEYPXyw7BWV/9mZjJLYqDleB7s3derYZjsl4d1LCIT8afuukapknPDGQAO
         Az5MvvUsq++dfUy4Y8zaDLBbHKxO436NLH78++0m6QV4MHJmO17EaLbeENlSiFmmuV7Y
         ScLw==
X-Gm-Message-State: AOJu0YzT40nVUTxRPpJUlc1lpdTmVvjlXY6latGj+tSZ/xdTtABpVyjM
	9ZiFp0xLy6paWyiT75gOw6K/dctJtVHFDqPlonWFjIwz7MqGfyuAfagQmwhBlLuhbYb4jGyCzmk
	XWp0fiN0feS81UVj8yYKpC12Q5iVPZQJ5Mt2yX9P4/x0/
X-Gm-Gg: ASbGncsSgwWBhhxInp5xYlZKHtT8G2t1wQjqmv7wpBqgdtDWbaGCSPCCeSKhH1Xwfpv
	pZ8okelc8tm7/aaR0/ON4BNPCpmsC/RS+iajDOyFGmpJOfaHu0qK5Fr8PfOPgad1WaBKO033uPQ
	AE3aaXAQ86nnw5juFHy6p9tU8Xw703uVMSxgXbUpaPOxjmw3reeoJIO+MbUL1b/CzG9w==
X-Google-Smtp-Source: AGHT+IEW6/AZhT5IWhzgfaTlWJThPlFpyWsptn2qcAJQxaF+oMLLvmcE9LtLD363pgKL6xG4YFSFwVzMks6pjZ2k8G8=
X-Received: by 2002:ac8:70c6:0:b0:4a2:719b:1238 with SMTP id
 d75a77b69052e-4a2719b12cemr133535371cf.12.1748504386915; Thu, 29 May 2025
 00:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nguyen Pham Khoi <nguyenphamkhoi1201@gmail.com>
Date: Thu, 29 May 2025 14:39:36 +0700
X-Gm-Features: AX0GCFsofduP8eOksGYBDkBvmdWXbz3RKf8WwodnNmfaNL4k65riKOMWdsp_0uA
Message-ID: <CACT29wqrkL72Cd=84hn3LqmN+QBWcVxwXJqm=8nUbZRp1x-gOg@mail.gmail.com>
Subject: rtw89_8852ce roaming issues, resulting in high jitter
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, when using my system I notice a high ping spike whenever a roam-scan occurs.
This is not the case when I try to use Ethernet/USB Tethering.

Running CachyOS with NetworkManager + iwd, this keeps appearing on my
journal: iwd[741]: event: roam-scan

I have tried to lock the BSSID but it still scans for some reason.

I have also tried to disable the power saving stuff, but it still doesn't work:
1. NetworkManager configuration (wifi.powersave = 2)
2. iw with an udev rule (ACTION=="add", SUBSYSTEM=="net",
KERNEL=="wl*", RUN+="/usr/bin/iw dev $name set power_save off")
3. Kernel parameters (rtw89_pci.disable_clkreq=y
rtw89_pci.disable_aspm_l1=y rtw89_pci.disable_aspm_l1ss=y)


Device info:
uname -r
6.15.0-2-cachyos

lspci | awk '/[Nn]et/ {print $1}' | xargs -i% lspci -ks %
09:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852CE
PCIe 802.11ax Wireless Network Controller (rev 01)
Subsystem: Realtek Semiconductor Co., Ltd. RTL8852CE PCIe 802.11ax
Wireless Network Controller
Kernel driver in use: rtw89_8852ce
Kernel modules: rtw89_8852ce





This has been bothering me for a while now, thank you in advance for your help!
Would be more than willing to provide more informations, I am still
new to Linux.

