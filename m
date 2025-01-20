Return-Path: <linux-wireless+bounces-17752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611EEA16BC9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 12:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F52A1885381
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB801B6CFD;
	Mon, 20 Jan 2025 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="OhwTDRSU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9228E1B415B
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373596; cv=none; b=UyI6dDckZz3Z76rs0B03S0Po6hcNCc7lP34KJCCgqaVuCcHv7fHJeICXNQRvddaTurQY+iwyLknaOyxOS8JuD1hbyeDA1P4N3Qu04UFGEJ56D1+G/NSNjqoURVZPwDpLWSbt+LOvjBC1oIPnwEqh4EPyPCqrw2Z+7UYzJ6bFeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373596; c=relaxed/simple;
	bh=pG+HDtcsgyU6xgSCQA8xz475U/j+wc+IZJIFSZ/KSzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jaRdAT7V4893LIPyRkd8uZPHr7Y2ROTYH4sV4tsAdxb5PB0IyAtm3TLIRkCBNpoo7QRUl5emxfoovFK+gA6EDFAye+3nlwbwIVcCpIDd4C4u4CfJR2hPMPETXBgb7fFzMjKLd9S8vtTZGFiT1oZr9k8/J34X3eFgJt2oQZ/l80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=OhwTDRSU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2428005f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1737373590; x=1737978390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxM0rcA62aC8+/hITUBho7TKfQdjQMzeRokKZdsFDog=;
        b=OhwTDRSU+JYZM7R9FS3BTgcScURm+SM+OpIqwDKr4oVCQPXLEJYo9fqZH5DIG7Cyeb
         B11g87JP0vAQXTEXv2R75H9rhOhCTc6aRAmYGiG4vXPAVOgLh5bvOsg+Cyy5R5c/6wkw
         ueWXSVFNVm3iRlR23GAnpIKy7wb8heJH8Xb+FgwI/psXBjWkiPGLcZU7MA1Fig7dK4UO
         L0tHBVTeSGRbx2d2VzhNgEf7g0sYJ7fiuHSSFsVHVXytYYfxA2K5WromM4xNcpfNivAM
         wVakhPtDlOpR9+YXf0q46aUGK9rh8ax1zH/fkDplH4luKPvIg7JaiyZmmNPKStGO4hm2
         2eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737373590; x=1737978390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxM0rcA62aC8+/hITUBho7TKfQdjQMzeRokKZdsFDog=;
        b=XYz0qmc977QfZbS/vb9T8iVjCCqKIs+NpT7BzJZMdCYFkinvk1Npse+Uh6cr+Lr8h7
         laLh5PWDVFmFcWIgU7Ub/zZfbF47Noz5ZxmWMi/50gQvHK0j/LxisKsWa2FctnbPKZ6N
         H49w26K/KwxlVrlNnAYQMmfX53kAFKIxM/0LSQgO7aP62r9A1OlCv/gJmaWo3cVD4mdU
         03OqPL9ZqOmfl2AM7aQ/EfIjiB1qW2oSG5IQy1BKH+qZa3t9OMPaonm+GxyRsk6N3Kd4
         DDnrwcfs/1/S6G8k7EuZFwjXdw/cllOBDe1wQpq+FsW+QQkX4E04FYmtQ7BbdVK0iYTU
         vOiQ==
X-Gm-Message-State: AOJu0YzCo4VSBmj7hamRNQx8UQj05lqMAFThgSioupPO+l4/5X7gw94V
	R1ocLhK894VVqFDZgeWS8GSKzMvOPl7sY2ZIf90t71hjTXm80mED1AqZiH5DXdc=
X-Gm-Gg: ASbGncsuOXdkrKxmc3saiU+JkbsjL3YIa8zbWjbdtOdov9ZI17rTQQpUr2N46TH8CGQ
	KgjiG+vM1iQdQc9O5WNwwleFubYPLLxv1gi3IEGqKakiQLum+pbZabyYINZkBUEmmIwyixQVJiz
	s7Wgla7GIr415Ny//2O05fiHGJBwAK8Chk279xfeqBr0QSFd9RfHpEM+xQ0hAz1NrBF2515nta5
	vrmhlsxzrbbbYbmgbCT31ege0u+Lj7sq0tso+p0PpYfMdnYk3xA3pF24oGo8R98qDH7caXKPDUP
	XRqyvowOHPGVMcm7lVVUZrci5ZhAIUddYnkJxGGw/wD4xBtKztMO
X-Google-Smtp-Source: AGHT+IHgk4bUS9/iWQnwlQJDibRj+6zBuys6nSVdzv6Rf+rDgLsLBdgVff5GMh4QbofXMhvGv4489w==
X-Received: by 2002:a05:6000:1445:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38bf57c0546mr11188498f8f.53.1737373590609;
        Mon, 20 Jan 2025 03:46:30 -0800 (PST)
Received: from pablomg-ThinkStation-P620.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a934sm10002105f8f.42.2025.01.20.03.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:46:30 -0800 (PST)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH] ieee80211: fix interopt issue with MT7927 chipset
Date: Mon, 20 Jan 2025 12:45:51 +0100
Message-ID: <20250120114551.1542812-1-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mediatek's chipsets MT7927 and MT7925 with Windows driver 5.4.0.3044
(and earlier versions) set the IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G
bit in 5 & 6Ghz band, which is supposed to be reserved. Currently, the
kernel assumes a reserved bit to be set to 0 and uses the bit value to
deduce that the current band used is 2.4GHz.

This causes the kernel to miscalculate mcs_nss_size to 3 bytes,
resulting in incorrect rx/tx nss map, so the sta is believed to have
0 NSS for 160/320.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 include/linux/ieee80211.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 16741e542e81..2e813824d52a 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3196,14 +3196,17 @@ ieee80211_eht_mcs_nss_size(const struct ieee80211_he_cap_elem *he_cap,
 {
 	u8 count = 0;
 
-	/* on 2.4 GHz, if it supports 40 MHz, the result is 3 */
-	if (he_cap->phy_cap_info[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
-		return 3;
+	/* 20 MHz-only non-AP STA */
+	if (!from_ap && (he_cap->phy_cap_info[0] &
+	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0)
+		return 4;
 
-	/* on 2.4 GHz, these three bits are reserved, so should be 0 */
 	if (he_cap->phy_cap_info[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
+	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
+	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G))
 		count += 3;
 
 	if (he_cap->phy_cap_info[0] &
-- 
2.43.0


