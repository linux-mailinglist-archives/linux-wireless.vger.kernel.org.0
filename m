Return-Path: <linux-wireless+bounces-26485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E290EB2EBDA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 05:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E520A28681
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 03:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100AE2D29C6;
	Thu, 21 Aug 2025 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPCudEBk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A927280F;
	Thu, 21 Aug 2025 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755746298; cv=none; b=Nw2Sr+bi/nmpd2zVlVgMidQaMniJTb+vMfMKkOfS8fcwIx8HL2NygKTPfAuNnwWwWMqi002Y6FuPjMwnI43FLAgylGslXW8ndL3Rn02g0d6pi92v/OaPu7I6uEstMA60lJu+65uBVmPvm6rt4Lf+SXWNh9g3vyqsOFl3fmxfjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755746298; c=relaxed/simple;
	bh=2UR92VNRaMCtjMofh2FcvKU+LoMwMOhOdugn0qR8nME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qnp7iiSPffFrrPTT/WXO+jeRrAPV9Zq66vSXPdpApgDso9P1Gq+4+QkUVZ8IgTkWSA6tMTcmBW4ZGcqjWFua1nKtXKqgnv9g2EeGbLyXl/9f/Fqu0B6FWzf98tYl8JONNvrikvFqwk/q4g2Dssyx7Wd/z4vclL0lKvcZwijt9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPCudEBk; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b134f1c451so7779661cf.1;
        Wed, 20 Aug 2025 20:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755746293; x=1756351093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=norIsueGJ0euaeFc8RiefmZBp5cE2pqR9gRaAbo8bd4=;
        b=cPCudEBkQr5ZK3m26zswddD9d9BBDKoZYGZOCHnS+vvgIaefSRThUJ+jNt7txV82SG
         z21y+ObTnnwBDs/beZgDax/LcA85PlFvPUZ12j151HDKUvTn/9QAONnGlHc4IJcfbJOo
         hflt6yJxxdkXd18t+af2y0vGNjHx/ALN0uD4WYpZKdwxpDeWGQQbyDyKo4FQfHe3t6pA
         q9H7jh0K5kyD/SMHfqgkHjS/S1NrXmx5Kifvv7EvSrfJzCq6R4bF6Pnnd0RXhmVRgFHl
         2OshDfGcVtoc62x71gZqGe75Nacb64LkcMLduesn9VGwbtP0u81NYk6/XYmobOuLPZGC
         8v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755746293; x=1756351093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=norIsueGJ0euaeFc8RiefmZBp5cE2pqR9gRaAbo8bd4=;
        b=na3zv6okYZYsU4LRUobw2fjM0RXegeQYNKOLXnnugEqXcgGlOygwUkxN6GT8+n9C3+
         BJJJN/xfzJutLZAo4wkhxeDqkv0FaZL5yZLpQCeceKl1Qz1x6vVvRaH+xMvZ+QckYIKD
         SO5mDE5XiEJo+0uPQDdaTv9yupggNYPBsy4CRvLPBWyjsImZ3uMYM67dkvnKmKct5GUs
         +h6jok4lD7mOWy12u5k8kbwXxCnjNAE6cj1aFqv9Vi2PUnE/V+fnmB5xi4i3BNcGkKeC
         4rkYJp/hq7PWQJPI4eZ/NL9IOR+N/Mq8AfVNfsq5yofLCmL5feEPsOJvAUrCYTeRDX2V
         mzkw==
X-Forwarded-Encrypted: i=1; AJvYcCUq4N8qWgOJVaRNT1D0n30zf6/chnK4k9V/wWBqBCSbUGirJKfsCqpI6+0VoksmpM6vXLOY+V0MHRm7ACc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypb4dc+ANDl+ySGj95y+oZcAoJBr/uG8P+Lm3zmaYxeWJC8jVX
	g8z7OcTYbaQHvktWK7fIi4AISNYi+v6Sf+hLNZhep6UC5dLoa0Hg7P+vodCwvQ==
X-Gm-Gg: ASbGnct0wceloEWMPoywMjFev6ezo/fRg+tbdhujal1IsED64vxyjVRmxdG5nxGkJzV
	0052yhKPlcNfJb9BfsX3RNXGOBMXVyEe6HzYDklk+QkZ1q2igo0Xir3lOJqQApcsCLsP5Mlk/3Z
	ybBgkWrjMaz6n14DHWZeoRaToNfhosEf05U3U1zG9VTEYon7ubaTj3g4HvHHummDxjvKkhP6bjE
	TTc8iwqpRZBE5YQc2A4rrAhJyNDqUWpzPBzJyO7ZuzxpLW5GP+MpWSpVtBeR1G/m9ecEbBXeX3D
	b4AD9KxU/8Hn0hmKAqBNDDCRNg6NZz9xTGxbEQ9+GraSPeVpfcsuIdjOZ9gzw1xtwD0Bn/m7cVD
	CVRzY
X-Google-Smtp-Source: AGHT+IF4zWamBt8IcXrEUJ7Nb//GtcxX/b+1m2NqdTW3mh1LFJiCPvbzpcR/Ru+P/Uv4irtieW9oXw==
X-Received: by 2002:a05:622a:1995:b0:4af:157e:3823 with SMTP id d75a77b69052e-4b29ff99fbemr10384331cf.42.1755746293020;
        Wed, 20 Aug 2025 20:18:13 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc1aa56sm95904591cf.7.2025.08.20.20.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:18:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wireless: ath5k: set MAC address through OF
Date: Wed, 20 Aug 2025 20:18:09 -0700
Message-ID: <20250821031809.631727-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If defined in OF, set the MAC address. Allows avoiding having to do that
in userspace.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath5k/base.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index 4d88b02ffa79..22ca7e624b32 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -59,6 +59,7 @@
 #include <net/cfg80211.h>
 #include <net/ieee80211_radiotap.h>
 
+#include <linux/of_net.h>
 #include <linux/unaligned.h>
 
 #include <net/mac80211.h>
@@ -2570,6 +2571,19 @@ static const struct ieee80211_iface_combination if_comb = {
 	.num_different_channels = 1,
 };
 
+static int ath5k_of_init(struct ath5k_hw *ah)
+{
+	struct ath_common *common = ath5k_hw_common(ah);
+	struct device_node *np = ah->dev->of_node;
+	int ret;
+
+	ret = of_get_mac_address(np, common->macaddr);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+
+	return 0;
+}
+
 int
 ath5k_init_ah(struct ath5k_hw *ah, const struct ath_bus_ops *bus_ops)
 {
@@ -2638,6 +2652,10 @@ ath5k_init_ah(struct ath5k_hw *ah, const struct ath_bus_ops *bus_ops)
 	common->priv = ah;
 	common->clockrate = 40;
 
+	ret = ath5k_of_init(ah);
+	if (ret)
+		return ret;
+
 	/*
 	 * Cache line size is used to size and align various
 	 * structures used to communicate with the hardware.
-- 
2.50.1


