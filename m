Return-Path: <linux-wireless+bounces-19140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B88AA3C6C1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 18:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DCB3B6A1E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 17:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6384B1F2B8B;
	Wed, 19 Feb 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="x6ajkrgR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF01B4F25
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987557; cv=none; b=R+Ty/iuLITzz4UrNPOrto7zT0QARxXAO0yvEXFynHx/RlOG4Gc2K+phMF0Um66jIZEfru6NefyFYJuuZLSBJMKHIr2JRKjaUY5Uvb9GxdTxU7ohiVtX4qu5EyUKM819prUKksG+dbn2e7pp4B9fs2QsKKsIpuNjWpBE5Zmf/o7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987557; c=relaxed/simple;
	bh=Y8mICJrgRbFs9N5pdl08Fsj6ijBCqRjuZSEphkP6Cf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6p8bJlb/6Kpea0VfHV2nzwI2esHoTgx1KJCoZfbpMV+nwm5H0wV2SCVqQmqa9viprN42qAFSrLNOlVYYXaye10/KZ19Q3OSX3aIJEH8ZHZliY3K9eoREIixbmNIRfFOnkP6m0gIniMxKxb6dqQwoOtvckSwGVaw/ck1TXSkK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=x6ajkrgR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439a2780b44so194635e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 09:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1739987552; x=1740592352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAVvY2CVQTlCJ2y/Z40c6jB+AaUNFamy5Zo5AUVxQpw=;
        b=x6ajkrgRgvgBjwBy9cDrawBapbOw8A0HwLEj6lB80ohbVk3ZM1CPm+sEEh7+qyRZ3Q
         GoZZYyDPff7K80N5xYX/y0SOhyns1UMPVpTyyPmJQLxTDaR1+yBqdH6pdNMfPcOwdVjw
         DOO70l7PJ8H9TJMCeFwx3mg1eEtxbUtvLcq+FGrOhH73QVeueik5n4Fp/i1MhyOTQCUT
         Kqw6GXsP7R1N+AZ5RG5n3DnAZB8uZjCEpQUbAWTdpONJB32EN7TP4zfuw7D+L642L6VX
         eo4efJlXyFwKgi5CyMGBblR38mj2X5bMOMUWGZtta7NjGNwHwcOz5CEL7SCv0XhNCLRb
         f7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739987552; x=1740592352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAVvY2CVQTlCJ2y/Z40c6jB+AaUNFamy5Zo5AUVxQpw=;
        b=ekWxIDYaZQjSVx42tpnW0y1jDKliGobVsBD0WizmHmSECWwokk6dfnlJOoHk5HnBhU
         eWGDudo6pnqYdfn+Y88C8TILIOnDiyjOFX6e9IxUattjc0Ti0XA6UmeOhzgKjoKQpSqV
         Of2rUnraz4WLcoEJZ2PdjJ+aBO9ea7wOhTSNe3X46JdqIt0V4vDi7jFsuXXRxVva36fE
         k5X4E6AqTcYGnhijgu4bw8fdEd3icyONxkXqBIGW/FgnwMx/Y4VFvKdH5Z565BK1+ceq
         vvgLUam2GOP+PILo5Fcql0srVynFCNaElnhnjknZQ5pOw8pMC3xeKqQipLXF36V0njAN
         n0Cg==
X-Gm-Message-State: AOJu0YyD1VgQufJTIK5i5SYtbKrZuMVAKI2dxJ8IBu9+d/xfMuvAgLTK
	drfV9pWnwNYn5Aff1UtYGFA+94UBNECWsQp+FkS43kBPezqojaheaaeHqTPiU1ez3FBIydxg82u
	97cA=
X-Gm-Gg: ASbGnctHNNLC77KXBNqQv6uZ4TMxuAZSshV7ZrCLcbSUzkMVqENNdjEm9fWdhEqcIM7
	sdF9Ej/HCLZuK4mEYfNSI7yGjIMPBBuBo94uO3mQptoxrn5aBC63Q6AXy3e8lsIqkUcaANfQla6
	fGTXyFQVjBe054VPxwDb93wqRGJaTqjZeH5WEAm0gNtm/+jHti2UvpYPikAaccmKgTkIocGHdRP
	Ik9vFuJTwge4c7gIuAm7eZradRQr1aA8+0cdFyTbgA3B4gnd9D9sCr+ytxK2AKE1IvMVGgh+IYd
	111oLKjA4nGB
X-Google-Smtp-Source: AGHT+IELQxZwHESCbUg9TPvRee9Fqdfy1Oj0CC19UYHzxnGrolqNi4+ZXM9ZwhmEBVn+8ypmQaSW8A==
X-Received: by 2002:a5d:4403:0:b0:38f:24f4:93b9 with SMTP id ffacd0b85a97d-38f587974dfmr3809594f8f.28.1739987551066;
        Wed, 19 Feb 2025 09:52:31 -0800 (PST)
Received: from fraxinus.easyland ([2001:1620:4675:0:25b:f7ee:9a39:7e51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43983264ef8sm99269695e9.4.2025.02.19.09.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:52:30 -0800 (PST)
From: Ezra Buehler <ezra@easyb.ch>
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Reto Schneider <reto.schneider@husqvarnagroup.com>,
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Subject: [PATCH v1 0/3] wifi: rtl8xxxu: AP mode fixes (for gen1 devices)
Date: Wed, 19 Feb 2025 18:52:25 +0100
Message-ID: <20250219175228.850583-1-ezra@easyb.ch>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

As mentioned in the previous patch [1], especially the transmit rate is
rather low in AP mode with gen1 devices like the RTL8192CU. The
following changes seem to fix the issue.

When looking at the patches introducing the initial AP support [2], I
noticed that rtl8xxxu_gen2_report_connect() was altered too. So, now I
am wondering if we need to use `macid` and `role` in
rtl8xxxu_gen1_report_connect() as well...

[1]: https://lore.kernel.org/all/20250122071512.10165-1-ezra@easyb.ch/
[2]: https://lore.kernel.org/all/20230428150833.218605-1-martin.kaistra@linutronix.de/


Ezra Buehler (3):
  wifi: rtl8xxxu: Use macid in rtl8xxxu_update_rate_mask()
  wifi: rtl8xxxu: Use macid in rtl8xxxu_fill_txdesc_v1()
  wifi: rtl8xxxu: Make sure TX rate is reported in AP mode

 drivers/net/wireless/realtek/rtl8xxxu/core.c  | 28 ++++++++++++++++++-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 +
 2 files changed, 28 insertions(+), 1 deletion(-)

--
2.43.0

