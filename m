Return-Path: <linux-wireless+bounces-30589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA710D07291
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 05:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B269301618F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 04:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9C2E040E;
	Fri,  9 Jan 2026 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh/T7frS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6731F09AD
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 04:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767933903; cv=none; b=EknG8fwo1eN6yTuY5DBac7WMPsW6ojZ9ksdENKOo9FIduwc/JdDuCk9+7yuyzFh5Zk4ZMSEhZ6huFgOQ9v6oZp4nlqYoUCm9wf6hWY7RtTMzPd88TpkdvNStWE2pmnRPej1s7tBOBQP10bkJjN8DfP/MxNDwITLVYqXPEjFquUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767933903; c=relaxed/simple;
	bh=sEmA+zmXqbhJJcmwVsIgmjewBvkIvZr7JnLEOOkLFoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZ5aX/NTdKIjN1F4MCsGEocrkzr9X5jctd+bXg+vfe05k89dfERlu3g+nnf/EU8s5xSxPiYvvRaBGy+iuV2Dr1ToXgJoQrsqCLgMITnERVvs0Wp/z+vC3l9Sj+mmyDu4+4/2UOJCPfBnwAIrA95if85Ld9BJIIOXlobkZBdjb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh/T7frS; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4503ee5c160so2445134b6e.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 20:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767933901; x=1768538701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tZp+kfHUaolqheLYLg650A6pQ/r2SBSRElAC2RJMB0s=;
        b=hh/T7frSjeuRndrTwVW/2MyH/xjdCZdc3V81Q+6HiynrO/CYuQUgj5zn146lFSKzGh
         HF+iWt4fsuLqmn+JNYeep2yi1IP2/BChd2Sf2iZPxr9MglcvJPJiUGHY3R4kXS9B/utP
         rNx2FBmiKBioyLSZRvSLXe9UhJrScnH2d5eIMNnf+mjnDo2PJxCOFVOn7r9up1YViWyq
         KRt9Sx6OCNsu43PHRVGj8zQnxhPEUm1M59Poefe61lIE0YdRXArfy0MGsb2bt5TPjtLK
         XIQAkHY7vBlsK3hZ01Tr+YCRduN6hmBOxzAVipifmvAIb2dgyqUoyX5HmKO7OH7e2MgI
         4Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767933901; x=1768538701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZp+kfHUaolqheLYLg650A6pQ/r2SBSRElAC2RJMB0s=;
        b=NizVDha5K3O5BBYs0WS7h7pl8lEYpIXHZ9d68TwfSyxtIlU9Dwevshc/7IoCHbC01Y
         rNYTvmo8KWGpMMMr/+NbcrlFiAkJmwZNNos9UFekd8xehwbkxReS68BQpvjmvGpVQeed
         61YKHDxfZvh/LVgmd9ZBSYQCu5qjHOzme0km3/7lAlcWrg2zrNtPblq1Z1coK3GdJRD4
         zS16U5+kcS9TJ3EIIDsGY+RsW4bAlGJUyI36D26RWOkYpjxNcLJotzq1/1iC9lKltyeQ
         H4DbdI9sfFgAIvBjM4bcuVN96+2QH0lO0RQE+a/qXTdPGYuAFuLr5Tt13aC7XqvA8JyP
         GdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBHWA2m9Int19JXR8a8FN2Mxhql+Bu9Bm5jDMl72oFAMGTMTK0+p722D4mSypLN6NmUwzR0yqiRSTQo+gOGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKB/HrA432x3WNF6jthAXscLT+TegrAGnuceRL0UcHo3tFrGKn
	lNNHzCUL2GxQcD4FZV6CCVeo2PyK3mlhpfAnIQ/OEMkcK+rhm4Ide4FZ
X-Gm-Gg: AY/fxX76BRQWMvVFxDLT6+VJYrKJoASblyM8bmryEsYgSzO/CvqiJJwIh+NuNzZJsNw
	wG9vBaXuWvSGPBwf2/slVKM8uBnpxnOK/Lw5qUSLBYkp9S7AVsAlrLWzlZ38df5L21DNlfN24Tc
	8sSCrRm//ZUVcHbu6w5bc4wYSUcfl9p/d/io41Ufq/PFpy1qmp3c4gZ2ZtsYMWAj8c6WwLHNfNY
	0E/aw2EJEcL24VpIsHoL/xMLaHzw0XAV8S1WkbJ6GPVqhHCdFUAly52FSCFixnN9PD75X+VwjI+
	TqmfdFIsamP4Jbp+unVH4U37G+lUxqellycKj5v+9GyQr1+Xm0oF5Esy6ztoCv5X2drBZJyFDIW
	mi8xbGbOXhWZ8nbhhkuim8pIEWavdi2Yj9/tmJeQCxupjZKOSt/SGgonw3OUIXDRgwgI9qvDkvs
	bBlcJWyjCtBmk2NkadyQF/DSKE/TY2CyfVqivfBWf1o3gBLWv6PtRXKrmQK8I9RKyKrP/FsKE8s
	i/0OdjEj/oKnuXbWtN+bBmB9exX
X-Google-Smtp-Source: AGHT+IHedFIfG2wReSbPveqXV4uDnobziG+QJflWOiBLTxU7Ae0czMlXONHjUMHL2RQJtC6hSKZYTQ==
X-Received: by 2002:a05:6808:4482:b0:450:10b:a53a with SMTP id 5614622812f47-45a6bee7f84mr4029885b6e.65.1767933901142;
        Thu, 08 Jan 2026 20:45:01 -0800 (PST)
Received: from nukework.lan (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47802551sm6683515a34.1.2026.01.08.20.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 20:44:59 -0800 (PST)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jjohnson@kernel.org,
	ath11k@lists.infradead.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v2 0/2] ath11k: support IPQ9574
Date: Thu,  8 Jan 2026 22:44:52 -0600
Message-ID: <20260109044457.3074510-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is my attempt to make ath11k work on IPQ9574. IPQ9574 is intended
for wifi-7 devices, so it seems the exception rather than the rule to
pair it with a wifi-6 chip. That's exactly what my Archer BE550 does.

This consists of a wifi-6 (QCN5024) chip connected via PCIe to the
SoC, but exposed to the OS via AHB. The Q6 firmware [4] requires
remoteproc support introduced in a separate series [3]. The QMI
firmware interface is very similar to IPQ6018, such that almost no
new code is needed.

I am not including the wifi@c000000 devicetree node in this series, as
it depends on nodes from the remoteproc series [3].

I have been successfully doogfooding this for a few of weeks in AP mode.
There dependencies to this series. [2] is a compile-time dependency,
whereas [1] and [3] are needed for full functionality. I was adivsed to
leave [1] and [2] as separate patches and not add them to this series.
`

[1] https://lore.kernel.org/ath11k/20251206175829.2573256-1-mr.nuke.me@gmail.com/
[2] https://lore.kernel.org/ath11k/20251228151408.2116108-1-mr.nuke.me@gmail.com/
[3] https://lore.kernel.org/linux-remoteproc/20260109043352.3072933-1-mr.nuke.me@gmail.com/
[4] https://github.com/quic/upstream-wifi-fw

Changes since v1:
 - place compatible strings after instead of before ipq8074

Alexandru Gagniuc (2):
  dt: bindings: net: ath11k: add IPQ9574 compatible
  wifi: ath11k: support ipq9574

 .../bindings/net/wireless/qcom,ath11k.yaml    |  3 +
 drivers/net/wireless/ath/ath11k/ahb.c         |  4 +
 drivers/net/wireless/ath/ath11k/core.c        | 82 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h        |  1 +
 drivers/net/wireless/ath/ath11k/hw.c          | 51 ++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h          |  1 +
 6 files changed, 142 insertions(+)

--
2.45.1


