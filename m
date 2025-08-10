Return-Path: <linux-wireless+bounces-26233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EF3B1FAB8
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 17:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47447AB850
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FE205E3B;
	Sun, 10 Aug 2025 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/jbHh5X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720F1A314F
	for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754839332; cv=none; b=FE267nq4JTC0xZtw3cZT/UY7uiiIcCLbOaIIJDsB1EWQ/pxTiENP3/aDb+POFjMEQ8W5FAXv+Byv731k5iErDk6P3d84DsagtQk+QRza2PNjB3LdLo/BcBIzPL9nmLX6uErP6ST533zHK6WSqUSNm+GFFoFtkWyTCI8cbVE4UYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754839332; c=relaxed/simple;
	bh=8W2+3sXRai0m/G+QZY3uT/+3187z71vxN1yuhkzJSvI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pkdrl5eSnFavvhKDbXwOXHsLNZl0VhT/23845tJGYJqswmwBKbzKAnhGGNdv0BCQ45hIBUp7L+TMNXRt/CGxVj/PKKCNQ4C0h8AbDoUU8a77NB9cm3JLy33DhAW8aVyC1vljpuU8CqjoFiX5ZX0spGU9IJChuc9OZuAptng8j90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/jbHh5X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31f017262d9so2770827a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754839331; x=1755444131; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8W2+3sXRai0m/G+QZY3uT/+3187z71vxN1yuhkzJSvI=;
        b=J/jbHh5X3rz+zAAVeWhsG7tcDSQwHzR1pV6zPvHWFIkCxTsbCaEleL1arHDmK7eQQF
         NWer55dK94vp8b6nF16Q730GiEgCD1WbAcU5SuJjoUEYveSqMTsOQ4uEEkzb6UJ27tyP
         0VkZQnaPMwkncamrsGPHk/TIevwSq2RMt7hGGE4O6edDdWMGjdXjiOrPCAILQm/TCUA5
         HtaNiF3ToJpnKgZcVVkYnBbaarQcE15OpofdaSe4wsoP51d64SdX+Zh/G8DgPbrS6ATR
         gWV8CcpovszOb4YdFUMKXGLYMeaqMk2ffVCK8sw2MGTeVWHbWTZVjbpbz1T1v5y/+AjT
         eQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754839331; x=1755444131;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8W2+3sXRai0m/G+QZY3uT/+3187z71vxN1yuhkzJSvI=;
        b=U96p8aE4/dmMlegaxRIY2kb5cuP5x1y2PBvKFDr1MS+QcauQsDKDU+PYlfW07pbAxO
         W2gpj26DJhv+qLh3SxZn12ZWHTWLs306sF58pfWj3xe9RPnXgcWhfCQM/ZR0sCJHpHMc
         w2gJs0YrFYmw0ybnlFsvlcH0I0fUjCyAgEQbaHWxQsVXLPMf6g6+MGFsxCi+w35M9MJL
         G4C5WT9p3BJVNACyJ47/UGIihsReFqXQdMFdHGm77VTuNRXQfnLcR05xsrfeP82wX3Hk
         mgkvewnfjAigE/gG5x6y2DDjepROjupnpkQkebgOpjjlu1lweM/aVb2kZyr4yv0yZiqd
         tKfg==
X-Gm-Message-State: AOJu0Ywzi6C+wRhhJNXd0sh7Pg/5tiOTq7iItS0xmMufUqK6ZzT3MlGh
	t0t0peBIS17oSyxboEnJ1G0/IONMctsiDmYwx076Z0CwL01sYTgv1r+10nj69BUiUYcobUv4clD
	Ghn52JW7eMLlPu86BS2ZE4WA1p0gcXN2Qc3LReD8=
X-Gm-Gg: ASbGnctkBFo7u8R4sfhZJM3JfxGXmNG46+ZAgXWwuv9v/pEdVYj67szmNbbNBcUgXgv
	O8d7OCtAfUmjxHRh5mRWCCA+ePWMJuWIF7kVyRNYf8xqUyleSNRkYgrD3f6gaMTnJtnfZ0lyXdk
	6hhtDhXNp73MBzehim84nVkkUHBg8q0ew5AHtHZPms97f5hEGZ2Xw6J7i3eN3AuivfG+BFOp+CD
	dzc7VsCnkOLmy7a
X-Google-Smtp-Source: AGHT+IEz31ZTrJ6ErQJb4rG4IVX8VjRPFt8rWePM+cN2YiMdqd7toIr/ZJ4dxQE3Xfojgi6N1N4pak3POIbWLGyyIKU=
X-Received: by 2002:a17:90b:280e:b0:31f:30a6:56ff with SMTP id
 98e67ed59e1d1-32183b3f52dmr14594158a91.19.1754839330590; Sun, 10 Aug 2025
 08:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Marcin_W=C3=B3jcik?= <wojcikmarcin49@gmail.com>
Date: Sun, 10 Aug 2025 17:21:59 +0200
X-Gm-Features: Ac12FXwJsEENdIn-9vUirCBARWoR85ZGfvIrhA3P4wK3Jb0uVseieaApfUVgXNw
Message-ID: <CAE3x6Qi8Nku26B4aWE+jtJmHb=hO8C743_myNrrBzUAGyuUw9A@mail.gmail.com>
Subject: Suspending problem on fedora 42 with realtek wifi card
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good morning,
I was asked to email you about my problem with wifi card connectivity
after suspending:
https://github.com/morrownr/rtw89/issues/18#issuecomment-3083784268

I managed to solve that problem after writing 0 to
/sys/bus/pci/devices/0000:39:00.0/d3cold_allowed

That's my wifi card:
marcin@fedora:~$ lspci | grep Realtek
39:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE
PCIe 802.11ax Wireless Network Controller

Is there any chance to solve this problem without needing to write 0
to sys files?

All regards

