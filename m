Return-Path: <linux-wireless+bounces-10372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331A9372BC
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 05:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E810AB2153A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 03:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6FF9F8;
	Fri, 19 Jul 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICAVbFs4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096CBA39
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359445; cv=none; b=TqcQZuzScJOGclK0CikY+wSUzV/OHwnEI+07BLTxa3C71q8t/x3dyTpAU+Et7OYPtURRoovOBiz+uxJFmov8+LCM+ruSQEwXT0nrCc9GlYJCWdnDTz57J4K4XBi8VYtS053L2y/+afde/8ghJTgizisu0u+fLMzScTksm9jsyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359445; c=relaxed/simple;
	bh=JDkGd44csDSXOMViqo/a0znAC7bMWuqIUWxAkDExy2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JD+JTabrjqKrp0p8Eg6L+sMO6xK+WRQ97kqBouEmRVx8KGdn1SuecIA85hz6EgybLxe85EqIBuz0YE9zvC9Hb3i1/wEKFgkldwTxCppbVtftUwD5N+bxYAl2MSuS/W8uiT83i22BERWSdIK0ebsOiECQ/VmIIHlZ6PUx4Bx1V74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICAVbFs4; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70368b53cc0so722986a34.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 20:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721359442; x=1721964242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uED11ED2mXfSTYiB2mIkzYnievN+mUuQM5Q9Hs4d9Ig=;
        b=ICAVbFs4gmFqIo3Pr7ZvqgHRyS6VW1jRnO3SEoi1L/sHdV0d3CbKZ/Y9+ZoUSfatxm
         VG3cjmtrWW93CkxX2DJ5Ir+gBGjAsoqEgqy02u395mMpC1DvnWJsaiTxP/8i8jI5LGD/
         WONVqILe3LOYSGKjq2ah9MaC3Qm2a3fl0PIhW7jVHtGLpdMjGc+e63aEArbV4j1Y6p6V
         5u5VP5E6e6h7RNM9aWfqjLq++EEv7xEPFqfgMJgpfKzTaP8xY9jCXuXgTmTi6fTRwRjG
         Nbl50iJ2wM2/38/7mYEooAMoiD1+P/xYSdi1Avu3ve1Ryz+KgcLdz2STQ3jZMdLQNdoW
         Eajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721359442; x=1721964242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uED11ED2mXfSTYiB2mIkzYnievN+mUuQM5Q9Hs4d9Ig=;
        b=H+o7fnYTmIdjJY1/8KKHpNHpYioyaULWKZ4b1Htjgnsi3jrUSBz9UpRIw1Qtx5rKgo
         8vOp4vHFVxDDvXFhE72OvhfcwwhEuY7YY9pTOvfgRlxOyvelmY+AU3thcjM4c9SO/LXp
         5XRMU7wKq2ivZU+I+EtU79SNr2/444NHXIWO4MiWxVUUJdpM584HJKzKkCpaEHiOm+sz
         qgbiSEejra7ovz6/CL87kf9PC6YvIg2iOU+tP8G4lj1NW+GBUaQ3nwuM+LkwFRZIW/Ip
         Zm9M/BEN8GAYVkBBev7rEke1zjz16tf+peXR+Cq+GaL0+qQjRPzMgqf742HfEeGiRAT0
         B0Kw==
X-Gm-Message-State: AOJu0Ywe+CdJVHlLFk+OvBO0dCDunLpanhSY05SEMh68BVE1bAF7mM2R
	GQiRVH7//dBqoNhvRrnKqArRvqA4LMbkF2tFIxACOiTRc1SelectlT3c087I
X-Google-Smtp-Source: AGHT+IFdnppI0qNAmgNyDpCeaslxUwIhUGr720uca48IwwAq15fBgGeHU+cB7k4Y+ANVHp7sNEKLbg==
X-Received: by 2002:a05:6830:4181:b0:704:4d7e:380f with SMTP id 46e09a7af769-708e3787096mr8726901a34.1.1721359442069;
        Thu, 18 Jul 2024 20:24:02 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70cff59fd9csm279160b3a.173.2024.07.18.20.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 20:24:01 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2 4/5] wireless-regdb: Update regulatory info for Togo (TG) for 2022
Date: Fri, 19 Jul 2024 11:23:25 +0800
Message-Id: <20240719032326.7353-4-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719032326.7353-1-pkshih@gmail.com>
References: <20240719032326.7353-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Republic ToGolaise released Decision N 226/ARCEP/DG/22.

2400-2483.5 MHz
  - EIRP 100 mW and 10 mW/MHz density
5150-5350 MHz
  - EIRP 200 mW
  - If TPC is not used, must be reduced by 3 dB
5470-5850 MHz
  - EIRP 1W
  - If TPC is not used, must be reduced by 3 dB
5925-6425 MHz
  - LPI
    * EIRP 23 dBm (200 mW)
    * EIRP density 10 dBm/MHz
     (Reference [1] suggest this as -10 dBm/MHz, but this would be an error,
      becase PSD of LPI should not be lower than VLP.)
    * Use limited to indoor
  - VLP
    * EIRP 14 dBm (25 mW)
    * EIRP density -1 dBm/MHz
57-66 GHz
  - EIRP 40 dBm and 13 dBm/MHz density

[1] https://arcep.tg/wp-content/uploads/2022/12/Decision-226-22-Determinant-les-categories-et-conditions-techniques-dexploitation-des-appareils-de-faible-puissance-et-de-faible-portee.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - in commit message, describe typo that 5925-6425 LPI should be EIRP
    density 10 dBm/MHz. Otherwise, PSD for LPI is lower than VLP.
  - add DFS for all bands
  - not split 5150 - 5350 band, and set bandwidth to 80 MHz
  - set bandwidth 160 MHz for 5470 - 5850
---
 db.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 31a051f242e5..b5e40e038d77 100644
--- a/db.txt
+++ b/db.txt
@@ -1763,11 +1763,14 @@ country TD: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# Source:
+# https://arcep.tg/wp-content/uploads/2022/12/Decision-226-22-Determinant-les-categories-et-conditions-techniques-dexploitation-des-appareils-de-faible-puissance-et-de-faible-portee.pdf
 country TG: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 40), (20)
-	(5250 - 5330 @ 40), (20), DFS
-	(5490 - 5710 @ 40), (27), DFS
+	(2400 - 2483.5 @ 40), (100 mW), DFS
+	(5150 - 5350 @ 80), (20), DFS
+	(5470 - 5850 @ 160), (27), DFS
+	(5925 - 6425 @ 320), (23), DFS, NO-OUTDOOR
+	(57000 - 66000 @2160), (40), DFS
 
 # Source:
 # https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
-- 
2.25.1


