Return-Path: <linux-wireless+bounces-25089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA3AFE787
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 13:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A75A537A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F982BE04F;
	Wed,  9 Jul 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY0P3vf3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7928E59C;
	Wed,  9 Jul 2025 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060055; cv=none; b=C+SK0ymCtdtkpMSVjkGaNf+D2ZoPiAHTdO2CYrPQrx00zRSlm0ZCl0XWlITpOdyIUqRmBCnUEev7+sFDMI3Vz2tNeMifdoVyAswgb24xiuLyyIFDDHxikyuNXKTVKUeCji5wlXdk3sk3K2YvakRFK1Qh97itgPLwvyfWhrdZ4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060055; c=relaxed/simple;
	bh=wF33N6476zjoc3GDhU0+rMc9qgKkRh6q3xxgKSa5HrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ub1ebiFDVtdEHmUf7E7rBG0RFdCjJGs+k3q0pBqL8l94Yt10vLyFD62bDF4Fl6xH1WoDUsEM+CEslaT2oHwJ9E7r3nMtQch2rEqz6EYdV43NtQIeT8rb9gKz2CQebs5wdGw+ihsbPRWFvCl5PWoOs9+UnvxKmKgMQ7TQ3WiXGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY0P3vf3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4e575db1aso464642f8f.2;
        Wed, 09 Jul 2025 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752060052; x=1752664852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg8a0mSXpV/4S9UJhI49C/DP8Wn9m1I0imJMbY4qCrw=;
        b=OY0P3vf33umiXLKe+Po4DtcOAZC+32QWRuAG8dP2xhu1VpYQ7fwgEJ5+mD9hrxqiJT
         YIH9zsSA4i6+n0xS7WDlzHnPWaC7Jlr9WI9oCwxU4NYsyiQKIXceMNKXcaTOy7W9cL12
         itSZuHewG+mvVvD4sNJVfcN5/bnyW/MDgfbqtaTXLsVyOtT4F2mIQS5pE2FcoCpDtGr2
         1l7QSopiKJAxYgo4cN9aGVUir0Em0FbG7RTvfQK8zcW1SP8xoBr3YEQHU1onmTbvumig
         A+vNR1OoRgEkURXIH0DEqzOnntIXH8uLsU02u7q3zmV1Fyh5QdbvqWBgHTiH9ujco9Va
         jYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060052; x=1752664852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qg8a0mSXpV/4S9UJhI49C/DP8Wn9m1I0imJMbY4qCrw=;
        b=Ci1i+v9qSo5XN0KrNr3dxm47MOEjCIwx4OkK7qItawg7jPLAGonZZWBAFkw4lk8+4e
         fw+vFYN09JRMoisp9chgexVulvoTrvHauIRea6vL4jzV8Rpnj98+MWujC+GYhnoFFzU0
         oz3Y1jJkmst69mh6mrRzXIHocktdkvWl2VGqn9c2TWQ6IP037tdXganyi9LgU6JfaiAs
         //T36hB1sUXBeDfIgz3UNXmHcARFNObO+LPmjX/nKC7WaCaDx1sy4qY+3nIMGE01aAhH
         /mZHxB+ERCFsNCn2t4V06xEH5BZh9NQohveKPvnHvUbJGq5TowPzRrF5RqYOdIkm9bNL
         +MTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj2H4PH2Zn/Mas3Ls1y8F6fdbMu/0+TJa4FetSGExJvIXIfEkUqLByiTIijvVsXIzvNZbowdJ0vJj8EEnP7to=@vger.kernel.org, AJvYcCXJDj7D4jQan4MhOR+/7bc99lpDEa3wOQ6YqHr60CjFbhNd2ryY8WYSbkgCHprA7f7/UyYdexYOtMWS4/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvWmds1qv/WMfWb282hrkiZSMTyszH3Jm65nmkNW3lm8eyr2Mn
	PQ3yrmLqkGt3E/i3Qckl7Im2jW/Cpuhe/eI4Qi3q2++/hYrbo1M+qVqbxFv7uWJN
X-Gm-Gg: ASbGnct+ixiqkVc5RUKLJvGF2KH5DHJ/iJxqCwMW7dz9Rqf6VcqdS+s7PxJ7v6SusvN
	e4XHJu0ynMtDzr4XTE8NwceGpz3nyak7rN3hnTwTVF0PiZ7lh/18MZ6aIVlZ0jpqglwPS42CWTR
	zF0Yvh3bVeDQj215lXzccicLzqjRw3dgSa+ghgTIqzZkQA9zvagc1EJKFWl+6mJbDRrA5sCiOWF
	3aCe1n1hoB6yrYW6VZAUFM7htvFpFIQ12a7dB9/aPBqISQd8/PyezDZTQ23q9CSViPqWq5G3YkE
	pWLZ5pMYn8RQnPuG6yoFKgGC/r6YuZqULDw1wmgLbogH2gILhZrs3AAdazgnrs/Wscp6K+0K63q
	cZ/kC02Im6aA=
X-Google-Smtp-Source: AGHT+IGK7qZTLfAhKVIDjQIK1cAvcBRNX7B/SM5TCDKzRRMCmzbanSHk+gEINF3gre9vBnnWAI8DmQ==
X-Received: by 2002:a5d:64e7:0:b0:3a5:324a:89b5 with SMTP id ffacd0b85a97d-3b5e4517373mr522192f8f.8.1752060052179;
        Wed, 09 Jul 2025 04:20:52 -0700 (PDT)
Received: from thomas-precision3591.. ([2a0d:e487:313f:bd91:3d4b:795b:ac55:2b9d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b47285bdf8sm15354515f8f.87.2025.07.09.04.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:20:51 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] mwl8k: Add missing check after DMA map
Date: Wed,  9 Jul 2025 13:13:34 +0200
Message-ID: <20250709111339.25360-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.
If the mapping fails, unmap and return an error.

Fixes: 788838ebe8a4 ("mwl8k: use pci_unmap_addr{,set}() to keep track of unmap addresses on rx")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/marvell/mwl8k.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index bab9ef37a1ab..8bcb1d0dd618 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -1227,6 +1227,10 @@ static int rxq_refill(struct ieee80211_hw *hw, int index, int limit)
 
 		addr = dma_map_single(&priv->pdev->dev, skb->data,
 				      MWL8K_RX_MAXSZ, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&priv->pdev->dev, addr)) {
+			kfree_skb(skb);
+			break;
+		}
 
 		rxq->rxd_count++;
 		rx = rxq->tail++;
-- 
2.43.0


