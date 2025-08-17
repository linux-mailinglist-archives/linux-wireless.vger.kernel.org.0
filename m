Return-Path: <linux-wireless+bounces-26416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711B4B294D4
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 21:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A77A4F64
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 19:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA214EC73;
	Sun, 17 Aug 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CTM1Ax6v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8520485B
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755457494; cv=none; b=CG87CtccRbFf2jc11jMuhxLMrQ6jf60Ps5dFnkVkdUa5yDCsAknrwH3rV5sAlK6FlHmu9m5SaPbECPNYZfWKLOfrFyO6/sSk2RswvZuYmC60+Egcwpyxkm0mQJ10To34jhaTDtxWlvMlcYGQv0Uzk3xE+r3gZClIzaQvZSnOuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755457494; c=relaxed/simple;
	bh=jwzphG+Az96Vdglwlj/nfJWwr5JXfZ64zxuJLYyJXzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDGSANdwfib9QGMKG+lWv4pTKpyz4RP4SYAbSarjq91UUUdyHKBBQCzQ01EGXweqZCVW9YB6L0YbepZX5ZqfwcTDAud33N4sWcU1zhTzyz/9mAReSJuvEMvOcaPrgtTBWEdR4plG6ttnjIAQcRgcH+DXPS9EBiGcEUqPJBWbdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CTM1Ax6v; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b134aa13f5so7930001cf.1
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755457492; x=1756062292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stkdniq3T479U2/HC4Jl2YCOaNORwWoeYv674Y4LHh8=;
        b=CTM1Ax6vkYZFsuHkQ+Eb4hiRYAvlTKtgqti+UghkVtdHdOPPHWDmp2sFKtEZ6h8ilQ
         246Zb6Of6kY3mA/JQQ4sSX/86Md03s1DzE2Lvczf6GUzn7xFpk7/VG+P4IteptovBLYy
         RO02DONgad9qTgvMOHK8vKZGEQajWj78Tj5+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755457492; x=1756062292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stkdniq3T479U2/HC4Jl2YCOaNORwWoeYv674Y4LHh8=;
        b=ZG6XSLG8nTtWT0zgzJobHkB5c41boxvsFEG36f2ycwxoWbhrm/wCT5lfgoL5llS2ZX
         MAjL5av6BTiOXKIoRo+G/H3TDLsmCgDCG1zhWiYH/W28QTGdT9AecZu2Sa0b0ok4nDQU
         A4ZsKpOX5QL3zDk+bS3TmVJ5Y+Qz/dj1FjtEb5iyYmGPLuuF5Cysx7UTalM/U2TTM2E6
         nlV8H0uvMHNRr2LwB2JCUtFBaorD7UzJyG43mdjHNVzA4LZocKHHYWJ+1MNPO8Wd48SF
         HTn1PPbkDzvp/2yFLfBOketjnbYSAt5YeIq0f5j24VGYBckognP/n2Pu75f1uMDp6frK
         nelg==
X-Gm-Message-State: AOJu0YztNyPSXNNMFgfMjGpuu+nTuQXyjA9xmj7TBeCOm+5v0Y+52mPq
	hw4U6GvhB9PR4SNeQ9SKlm3oyzmVOejXOHAOCWifvZrhAbKeOPU9yZyyiQYpeY5krg==
X-Gm-Gg: ASbGncu0w2CXvZ7DIsoS5B6viEv7b3l+o79G/9kyl1aFt9E/qlXxnXRs/03E0uG6zBP
	ST6wzbwIXzb9MwHZiczV4RWUBb7KcPyCCK0erHdeedzs8tUvf16lbiszyEB0bO9e9SU0t4RUGG/
	G8QU/9TtGc9yqS6wdfo7uezJfQRaBRWm74HLP7oxVTn9flqNraY+n9zT/G7MgXxvICmtbPWdF2D
	+eGcvpHf1X68DZ+0iJKP/NDc2dCcw4McWmsZN7dAgm78lpw2iqyKO2Ei8L8/kz1kEdf7UpQsaKb
	BEqLfxntHaRpfNiBx6p2AD1B/B2wgV6GUgqyJWwVKC+MDThbGV490Bx4jGe/dbo25xy5Aud54PA
	HNdI+dp/+95MrQLcfQ82mquEdFgKReAiwilkHMSSU6wCgXUPV+MbmV4dIsTo1CHo01iBvOJiuG9
	M8Xg==
X-Google-Smtp-Source: AGHT+IETavnthNhCzGCss+welECI8tYBDm3EH1B8GP392KksVfDAaovV7zH0zBxr19zj7pQPRNCruw==
X-Received: by 2002:ac8:5cd1:0:b0:4ab:4d30:564f with SMTP id d75a77b69052e-4b11e2c486amr161485611cf.47.1755457492133;
        Sun, 17 Aug 2025 12:04:52 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de50b31sm40382461cf.51.2025.08.17.12.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 12:04:51 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next v2 0/4] wifi: changes for NL80211_CMD_SET_BSS support
Date: Sun, 17 Aug 2025 21:04:31 +0200
Message-ID: <20250817190435.1495094-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here a series with my idea on how to solve the fact that drivers may not
support or handle all parameters contained in NL80211_CMD_SET_BSS message
as sent by user-space. The driver can announce in the wiphy info which
parameters it supports and user-space can indicate that the kernel may
enforce strict checking for the NL80211_CMD_SET_BSS.

Arend van Spriel (3):
  wifi: nl80211: allow drivers to support subset of NL80211_CMD_SET_BSS
  wifi: drivers; indicate support for attributes in NL80211_CMD_SET_BSS
  wifi: nl80211: strict checking attributes for NL80211_CMD_SET_BSS

Wright Feng (1):
  wifi: brcmfmac: support AP isolation to restrict reachability between
    stations

 drivers/net/wireless/ath/wil6210/cfg80211.c   |  1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 23 +++++
 .../wireless/microchip/wilc1000/cfg80211.c    |  7 --
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  8 --
 include/net/cfg80211.h                        | 29 ++++++
 include/uapi/linux/nl80211.h                  |  7 ++
 net/mac80211/main.c                           |  8 ++
 net/wireless/core.c                           |  9 ++
 net/wireless/nl80211.c                        | 89 +++++++++++++++++--
 9 files changed, 158 insertions(+), 23 deletions(-)


base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.43.5


