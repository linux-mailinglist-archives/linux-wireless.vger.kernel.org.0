Return-Path: <linux-wireless+bounces-26408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33291B29279
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 11:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB697B0E8B
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1365C2248B0;
	Sun, 17 Aug 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WKxxMhxC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717151ADC83
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423677; cv=none; b=Pvw0xTQRnX6GMP6DHgqzPm2/gTYzH2P6cORBbyt/vfywtVkCJUf22BelUOo05kuyf06t6PAYtVYz435R1ed+cUNKkBAhyHo+nh8WuebwnieOhGaJZpi4YY4bNDp/VQodDGfVjx+hdJOBVd18x1FQ86cHhiVzwLYrDx/sgnOWeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423677; c=relaxed/simple;
	bh=tYVHe9Aemop4I8tQPMkluI1puokuZbTfjk2Bink7Slc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ri+UqyZZF+A5m5wInCoa0Wdd6JorynZTgHK93N729lIrGSjXk7MYSqdTSHNJepWL/+pitAlVJM/kkUXDW5/1DEchIz/ENgIxpBg2di9nu9whmV1l8NZs+8xvzRfCKMYkhDlRrRZzQKFCpRw62HSmW5O08/Z/LJktGfoxPjiqRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WKxxMhxC; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70a88dd062eso30126306d6.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 02:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755423674; x=1756028474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOf6nM9z/FNgdzr+RRXAWsT29ZV2aI9xwsVeixOlN4U=;
        b=WKxxMhxCzm40gprSCL0W5hj2zfNkiP83h/mjklk9TEeRoNvaIv5ZTXd1G6wAZ7j35y
         efTQlc0fXMMc7h5Zt3Ebha2/ldrgq5EjxQyrsasYKxITjhicThuNYNlmem7lwHVoHkOE
         O+HGTB09Q4EN+r7OxoJtet0wQjC1UmEgAEYfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755423674; x=1756028474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOf6nM9z/FNgdzr+RRXAWsT29ZV2aI9xwsVeixOlN4U=;
        b=pXdzI03vB2ZPchOcIkF1PZ2ddkmJuSL+RbVQqTe3XHgn386AJn2nSSLoQmL5wz9t06
         nmS+IqL1v1gzfwvreuT3AxHu2PwQ7gi093ls7U+ouF6GpufHqzsws2mqGMKgmv9RWqAK
         /jUQlbmPO/Xcufby7TSvq/exZR74QsffR1VbwwumLvqXvsYaRn+65ae1u5eaVP4IGMQg
         dwfpZTXRAG8gpdfk+svQ1KpPHNHeaGMNmQGCWbHEJkCGiTq9NQurDmh/vjUXDfOgcH8m
         i1c1+e4Y2tmVqnZuWZZLwM8ivljuFowWX5r1dIfPiCcqVY1SE+f5SHy++6buDnP4II40
         2NFw==
X-Gm-Message-State: AOJu0YxKMT2qHIml5rARwgsoRSiS3rYTQaCcw382Yo6Ix5pyHdFramjY
	lJCI/nYI3aANh+IGmPFjfPwjfLcCe06Lthyl3M4cxdRttw8CRLS8MUr86CaNIxPh/Q==
X-Gm-Gg: ASbGncviugpkrRhsHBF9ddlVIl0HvVtsE+wleulNGhHcbsqtcNEa5zYNrVkMnePZVCf
	tbI2Ei++S8yJOoojcLWIc7UtTl+wUd2xi9EgoTS9o52JTqU+0AgaKecZfzWzywldL2nMbBLPzUH
	Zl86XSiVoVCKse809EgZqEQsSr6mx02nYb/FPcyVWtU/kNj9vFNs3KsrlhRYy92iJju4b7oqvcX
	IADaONKbjNcesNobFuATgEaVIlIeLZ3zBzVjznb8D2OmEqhkpo+KhJC/Yn+e8IKLmzlcEZlzz+H
	PMDJjcIzrPyYKFNBOAHusbIrMWU7kkiNsX5NoT+pDB/hXygEISg/1SlBcSbaT7cOAVHWSKAFGki
	8eWpXeuLx060h3wMQXdVtT0MMnXQTXFQ6RqJVlVquuCgty4YFq5OlBBM1vf3B0Ln3Ir1rWG4Mnk
	pGYNs1XA==
X-Google-Smtp-Source: AGHT+IE4FSCfSlwTloizbtYnAgm9CSWMGk5sSYOkkx4tW7xHYf656/W6IVjSDrkvU4sbTajRgcQChw==
X-Received: by 2002:a05:6214:3003:b0:704:9239:bdf3 with SMTP id 6a1803df08f44-70ba7c8446bmr88003936d6.40.1755423674285;
        Sun, 17 Aug 2025 02:41:14 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f819sm35706346d6.9.2025.08.17.02.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 02:41:13 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wl-next 0/4] wifi: changes for NL80211_CMD_SET_BSS support
Date: Sun, 17 Aug 2025 11:40:59 +0200
Message-ID: <20250817094103.941090-1-arend.vanspriel@broadcom.com>
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
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 24 +++++
 .../wireless/microchip/wilc1000/cfg80211.c    |  9 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  8 --
 include/net/cfg80211.h                        | 29 ++++++
 include/uapi/linux/nl80211.h                  |  7 ++
 net/mac80211/main.c                           |  8 ++
 net/wireless/core.c                           |  9 ++
 net/wireless/nl80211.c                        | 91 +++++++++++++++++--
 9 files changed, 160 insertions(+), 26 deletions(-)


base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.43.5


