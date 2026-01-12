Return-Path: <linux-wireless+bounces-30671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 09542D10744
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 04:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 895DC301A324
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 03:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E430BF5C;
	Mon, 12 Jan 2026 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1D/6was"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9230B521
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768187997; cv=none; b=kO4Q7nhamnBjatmkRu73f2tMIBzAQeXokejkPuD5h5kzuSVKfh3f8ki6zO9ESD2tQh2jzjqw0vuLVPkY8IZhdUYVUB8VkMGYpiFyVJGFMdzkrhK3xvZilHgF9yRHYY3LA2N8cyLdIr3FMZSalPCDoD/cDBiR54YjqHAY/C1lwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768187997; c=relaxed/simple;
	bh=Yy86ZOwHP8tKFUQ4iASWQV1lG9OuTK8A73uqCISCa+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Apnn2XMLYJhNSBoHvXDi+sNibyXUzhFhbiKIn0UpWYHf0wwwICP6Wt0KuU+bTp9S/qC6zeBZHoMM0zgEQQCxDRvA9thif+yi+neBXQtaxuJtBvIeff0lDIqoGEuT1sy4CiLJECBCjuEsvcfcOrHnHd6eZB1aOu7s6u2fkq1TZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1D/6was; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f39438187so595572b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 19:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768187994; x=1768792794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkwZVaoD5+0zze2LhAa6KpS0108D55pwKILZunGiXdQ=;
        b=R1D/6wasIye/OrcGo0+n1QdJCZMXoxVsPmhkAeTUawOv9L9LHJylFf/7Ohta3V19ah
         I9oeaV+CPl9q2QI7HGJAf/EBy5uNhiKQ8Od+KNG9pmdV0aO0WvbcZYa2b9vIO9XcHQCn
         W10UiFgwApk+Gy1hgSYj+WosglFlaA+xZrlWYXxtlo4YawUn7ITfoR2wHEBUUeUEwB5B
         KSdgNyTNzDyynCfcKzRqigGjT+FxCoXlTcj5nEa92ZSKl4g/td0/pSbJnhk2etBKUceQ
         OVhAuONu9EmaoE1qYRzDTaqAUjXZpy2idWtFfHZAqY2kykB78bi6q2JoqxhiBqqA0tID
         2XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768187994; x=1768792794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NkwZVaoD5+0zze2LhAa6KpS0108D55pwKILZunGiXdQ=;
        b=SfaY+Q2RhiF3Z+QaQ0fVimsLwI8M4bEOPhPBTQEDTtGOa9ulVrYMJ7Xo7P4nfptxLr
         0bqBieYy4TBx8IK88P12g8ik2NYZxQmR6AfCcmKDx2df9pWfqZNPkdfO+vq3u2/MkuYn
         yDTFcC8Y5FoJ0SpKRJ5ersWoAIMMeraX5nCy7hf24eEguwvJLrcclQJsMsm1WXfIRyEw
         j5VFQhan9mmT+sBETZYdeYCgCV3S8FZYz3bWdk+rSVDnCNU0g6gpHa/2UTLc9V6n8aPS
         ZSwvLm3Ck5vX8meDwOiqDMFjgbYlbnj3ZzV4rCf6907JW6H6HpMFbbqcHoMfzY6P3nNP
         9gpw==
X-Gm-Message-State: AOJu0Ywq2FOqU+CVyLyQvTt8aL29JXdL3iKwtQLt6I0uj0/PVU8+s2QV
	Ek6AsD3TUhbTki6uLPFPbm5M3cArhQL6h98tChbMY51dGObxabGIOMC7IFlxEg==
X-Gm-Gg: AY/fxX7q4WJhrgKilGrI0cnyv8Amqbzc/E8bIpbivrix2ozKNdtN5DuZ1sedgGmVwjV
	ALxl5N7gHOqVIIUeZxEMrDjsDqZzqEpEqvO3/XE4VCDxRZjrM9Tf8Jcl/qhfm+89YeZUIwMabPm
	yYoCHeuGIUe910Tt7aFy7hQ3y9a80wXfQ2DZuDwRqSjvUI3P9T2Tb+XQdoTRTb+ORGxFBB6D7yy
	Xl1iw8N1rWM43pxYNVexbTniBiIS7l02/WFTOZwQsDeMrxYx3RCk5up3pnmPk5RDbJj/Gg5cM28
	xaxuFrONxH1Z2uODrVXJN99qyq+MiNr0XtL5kR5+I4Fjgb/XmvS2mTKzOUzVIylHxgEpDSWHo17
	j1IH1yaoRpHyyxPjqCH+OF0IvZRJKTOMSu206gszuCbFqEwKd2SWgtLzjAw==
X-Google-Smtp-Source: AGHT+IGhVYyJ4nE5HkZMAntl5wN21Pv6rFicCjaf03fPixlDv6t7n3azt/PY6PmZxxMLUGnLhuDSnQ==
X-Received: by 2002:a05:6a00:4acb:b0:7ff:97b3:59bb with SMTP id d2e1a72fcca58-81b7de5cf80mr14812302b3a.16.1768187994316;
        Sun, 11 Jan 2026 19:19:54 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81dd5a992f1sm8099649b3a.11.2026.01.11.19.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 19:19:53 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next 2/2] wifi: ath5k: set MAC address through OF
Date: Sun, 11 Jan 2026 19:19:34 -0800
Message-ID: <20260112031934.44839-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112031934.44839-1-rosenp@gmail.com>
References: <20260112031934.44839-1-rosenp@gmail.com>
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
2.52.0


