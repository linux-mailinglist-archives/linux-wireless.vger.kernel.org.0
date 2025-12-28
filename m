Return-Path: <linux-wireless+bounces-30141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BFFCE5267
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Dec 2025 16:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC0683005E87
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Dec 2025 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B62D46B2;
	Sun, 28 Dec 2025 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4kIyy1O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2F185B48
	for <linux-wireless@vger.kernel.org>; Sun, 28 Dec 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937541; cv=none; b=tVvfFFpe2OW/rd2q4dEEUACjXdbQNBY3DJdrDiucbGRpZ/LE2KYSb1nPHY05VLt9X7Y5tWS+TsyAIrlFSnJixnaIp6u6UarslwquRECObtA81GkAq/MJ0Hz+3H7e4phLY+qzW5+vaLZEDukTHM+eBySwnCmeDhPv+0XWq8Z5emE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937541; c=relaxed/simple;
	bh=sOs+xxjOAth5SinqEDNTW5BavAEqES60CIzgUrc5z8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Es9Aqzpi4RmUegwXs4S134NBTMF7M7vDmR478/gYs3FYGvdEaSc74U3b3lsUa59EF/zN+XMAVz7oIc+nkxM0iW/9MGi9eMYCLCsP5+Ojmd+JAMRs0o14OsbEG0yHBCTKjXZiK0p+d4MFWUgcw2jj2pfAQQhldgqzPQnYP8v9244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4kIyy1O; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c75fc222c3so3933162a34.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Dec 2025 07:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766937539; x=1767542339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Apfn0KmQlrxsfwtcbU9O/5I4jLFTnnC953VYvTwKvak=;
        b=i4kIyy1O9q+xVPl+fM3ITmhjamjf0wx+V3wIF1BBRaMWkh2E/O4oqdmSJ03ROI9wD+
         e+oJ4fjLnHd7sMlU01taVK/EfNuuO6PYWWqv5pd9AL2U6IhN9Wigkwx5vG9c9qicFjXP
         8AmcErzFQrRdnrk6R893wotDi/c8bpoyJU3Bhh1gqmCuwnXxcPYpr/pLUkd7Az8WM0I1
         JJCesn/K595XG8NItMo61NFwcZU02FND9auOJDq+Jhsm7YBhu68pnGucCGh2vjnknSFj
         J3CiPAiGit0QXIPnT430eLqFv753VuzinlsmTEzTWSsAg6XbM68aiFC8lu2pKONeVLk+
         UAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766937539; x=1767542339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Apfn0KmQlrxsfwtcbU9O/5I4jLFTnnC953VYvTwKvak=;
        b=EG3jouGhDvxecRMOseOTAIO60lqYEa81DPtCgQeIsh59LY5Rt0ha/8IUr5nBegQZjW
         EMoqLUihyoK4d1dLoH+ATwS7yf+RPWe6cVbKlKM0RsZX+B/HnP1V35Ly44wbjxizy5e7
         OccMCP1Prt6bgbnYJZ/6Im7LBwOgTu3vW7iWP3cJLrwWrLHQNrs2IxAsEZDMDdYjvR/o
         WTJkXDZ38nvy/HV6mjaLYl+N/zIAYRmndLsQfQAJNA7Qu1UqYQFRXc9liU8yrvtcmM+m
         pt1E12oDEzvvjEl49o4XSq5Z2t8OY2YIB5Yn1YzpJZ+ZVjdzsgA69BYl1yEcelUlavyn
         H9BA==
X-Forwarded-Encrypted: i=1; AJvYcCWBvHKY8F3W6JrIaEnopqZlQ1FO9OeIEcxIL9bPSthjpKGRH885BN5z6isHE85cwBToC8JyMowGfY8/66dnrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZEyxDj4OS+QZfxeUh+QjWjjfsCN24ulO4EHSG1y+yt3dsR1sF
	N3F/wwYA5AiNVgZOq1RFZNAmzj99a5ERaXuPGxfUuEf+iCZbj8ZajSEn
X-Gm-Gg: AY/fxX7VGw60UZI7O4S/VzLIpB1WeyTrQt6oMVsuIeouaxLHMKIkRozObgMJJe1QCkG
	uVXjugrXIaxP2zsOY2pAhUryjH+lhOeV0gNi3v5r74GGz4gey2WoZlzV1el2sPYSkL9+1laQ3Ok
	OpgGgGHCB88PAHd2cpd1N7FTgawwKt2rOn66S7QvK4B+C4S8VDau7/82TLyRexhnAY2tejLmkIc
	r4Km6zbE4EpT98P+xEp527/mzSEpDus2SEHt34NSeSbQYt9IfPkrjooiL0cJC4MfL/LZv8qMuZW
	dT0byypJJfQafmgXI3U3K2G2wNqUjvoFUVcCAwlalBnuXrdM8GCFu0o3+ejzYQrdUx98DjiRaIl
	FkaCDWREAhck1Cgws1oEwxtLs5qXah8G3tob6ZNdn8HK/K0gTEqPWjXmiRRCKKq3JxMZkWERo0T
	+VD18xLX2NvldhBYcAwZQfDWTKUkkxQzzaPZTJQsdXa88znp1/j7pTU8fIe1v/oPx6WrU70ScVu
	ibe3Z9wArxw+JQFkBRbL44CwCRsoQx5aRbv/zo=
X-Google-Smtp-Source: AGHT+IEPnuAVgrQlyTcCck/1MSYHWZ1binnrypX4kIGAcjnHnqwbQcKWspQ2QoMzsrmBQt4uFsy7cw==
X-Received: by 2002:a9d:4798:0:b0:7ca:f4e0:9ca1 with SMTP id 46e09a7af769-7cc668e14bbmr12009180a34.14.1766937538664;
        Sun, 28 Dec 2025 07:58:58 -0800 (PST)
Received: from nukework.lan (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ecd6esm19004434a34.25.2025.12.28.07.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 07:58:58 -0800 (PST)
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
Subject: [PATCH 0/2] ath11k: support IPQ9574
Date: Sun, 28 Dec 2025 09:58:50 -0600
Message-ID: <20251228155855.2118792-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

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


[1] https://lore.kernel.org/ath11k/20251206175829.2573256-1-mr.nuke.me@gmail.com/
[2] https://lore.kernel.org/ath11k/20251228151408.2116108-1-mr.nuke.me@gmail.com/
[3] https://lore.kernel.org/linux-remoteproc/20251219043425.888585-1-mr.nuke.me@gmail.com/
[4] https://github.com/quic/upstream-wifi-fw

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


