Return-Path: <linux-wireless+bounces-22020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CB6A9B86C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 21:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19AF7A14C8
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CE9291169;
	Thu, 24 Apr 2025 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NJiKg2bo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC927FD77
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523799; cv=none; b=GMU5aqTOuYlLpvYpelJ8qTZeDvJSOvn1lFmx628J/oiCB+LD5pGe9Rcsc6FTAyZ6NPpqBEWEfE3RhqCTfxSYIxtRy1LkEraFVPB7omLbUj4H1F5W2zwLTqz6OWVSZzlfjNgcMjkw+FnRsdp/9ynxLfLsECSAQadRkjtWqXKOoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523799; c=relaxed/simple;
	bh=ErYSPwOz6O1h3Xq7EONqPMLC/tP5M2SYPzNTnwZrGZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnBwOFrrJFmgG0GtBIwAamM2dsVRTdnahsG0Gm6N6K+HJLgc44AfGLrAw+LGTkYNRO4DiV+RBvC+syIylyLuNpJq+A5+gPcdumXn8FekI263BX27OarCATPpGctMoWoiCBTML0POm96SEjNg4cOuka9GbSDn5x1P4VDYjQHhDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NJiKg2bo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so1313828b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745523796; x=1746128596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=09Nc3tIrHFo1lVvdAoNoDKUuFY4GjCcbKUCXS9iSSak=;
        b=NJiKg2bo/P9RqZpmRoTclBPPZMmpShDAylJqejsZFtuobJWtMyuqB3MQ0aYEBNJ1bY
         kq2+dxxJXXErHIj9Rw+ljONclQP/3BkIw0W347Rzv4Sr6JEhy159oMaaB/hIgz75w8kc
         oQrJRednoH5kBx4HFHS0S9w5I/atoPXHeXoIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745523796; x=1746128596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09Nc3tIrHFo1lVvdAoNoDKUuFY4GjCcbKUCXS9iSSak=;
        b=oMcbEXZfMlBzeVpkdDIjWRdAq+4iHDcZqGCM3uI62OKsIRrkEvEfnjT3Of28d5WK3+
         Dl+HFdvq5GOSUhvC/pMoERoikiUVLKyU7glrJH3O/ySzTku+cSUrAILOpEDBqJsPksUQ
         X0aANCpkhg+C41Hb05WTWiT5pdyr1m1gKHXOe9YEBuwSNpfY1TcmBRAS6vNUtolUAMbC
         o0zqzAUqW8GdcKee29IX5p/CZ2Eay9N1i1MCTEjDgFJBn62KMIz6b8L+Il9oNuG1mVDG
         4wEPVTxXSshjC75Q3QosZubT4096lo8Xp8CmALBkzx7v7tCHr0suGGFMfuG1aXGA5qEs
         NRyQ==
X-Gm-Message-State: AOJu0YxV5hLYn9BGKusOMJHzDPcQJTZK+cwcGd4SynEH4BgGvmZEuOTd
	MMp+ZKpfUYkkEHinsNB556Jyx3wjPrB3KFhMcYgG9vPBUNQKfxwq7tqyL6VQnmbjb/OKiFDyJw2
	6ow==
X-Gm-Gg: ASbGncvpA0N0YVzocaA6CdjeZIpHvaFlfrAqfSRQDVMdXIgQG0JgXnMrc9+ppW1R1PT
	RMkI22HCviE/lKNalVexRiBIFmgzCO0MEA64rTS024U0eai03K8YuCq00PMlxxA5jH4gTZBJ0qm
	+3PvqIyeSFQ84Vezat8QK4KavOhLLb+3bd/j9GWTcJFvl3mbv06Fn4fU2KdeAlH9jLmBNEn5xKa
	2HJooKD+EghgDbmZ0bx3v4Jvq/5kuD7V6uJ+5RdEX/U1PRj3UY0N2al2mXxDZn3WPABg42KdM4O
	y+ZZnmC3RNWfSwUoPWs3+pPYL8HHwRE5xx0ec1z53UGVtX13HjXUYM2EE7KjOOnhS+dI+TbUP1F
	fezJiCMNwd+G5hYXgFHPk
X-Google-Smtp-Source: AGHT+IFZ1fuNTtCsgLtZ8ahNt7OEXZnO7lMzp+NeH6ehKDBIiSJeErS3Cujn6shcO9NGgPkP+iuxIg==
X-Received: by 2002:a05:6a00:8087:b0:736:a540:c9ad with SMTP id d2e1a72fcca58-73e24afd361mr5470215b3a.20.1745523796474;
        Thu, 24 Apr 2025 12:43:16 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6aa52sm1863494b3a.94.2025.04.24.12.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:43:15 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next 0/4] wifi: brcmfmac: external auth support for Infineon devices
Date: Thu, 24 Apr 2025 21:42:35 +0200
Message-ID: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Infineon chips support external authentication in station mode when
firmware advertises it. The feature that must be present in firmware is
sae_ext. This has been ported from Infineon repository and makes use of
the per-vendor framework. It showcases how things can be organized per
vendor to provide the functionality.

Unfortunately, I have no Infineon device and firmware that makes use of
external auth. This series was submitted earlier as RFT and it was tested
successfully by James Prestwood with iwd after adding a fourth patch to
the series. I would not mind if more testing is done with this series
like using wpa_supplicant instead of iwd.

Arend van Spriel (3):
  wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware
    events
  wifi: brcmfmac: make per-vendor event map const
  wifi: brcmfmac: cyw: support external SAE authentication in station
    mode

Ting-Ying Li (1):
  wifi: brcmfmac: Fix structure size for WPA3 external SAE

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  44 ++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  25 ++
 .../broadcom/brcm80211/brcmfmac/common.c      |   1 +
 .../broadcom/brcm80211/brcmfmac/core.c        |   2 +
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 308 ++++++++++++++++++
 .../brcm80211/brcmfmac/cyw/fwil_types.h       |  85 +++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
 .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
 .../broadcom/brcm80211/brcmfmac/fweh.c        |   7 +-
 .../broadcom/brcm80211/brcmfmac/fweh.h        |   8 +-
 .../broadcom/brcm80211/brcmfmac/fwvid.h       |  29 ++
 11 files changed, 493 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h


base-commit: f600832794c91d7021d7337104734246b02a2b86
--
2.43.5


