Return-Path: <linux-wireless+bounces-9459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8894491362C
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 23:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC3BB2418B
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 21:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D66F06A;
	Sat, 22 Jun 2024 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaE8Wyam"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332575EE80;
	Sat, 22 Jun 2024 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093262; cv=none; b=k2Xy/pmizPX1rmlB1se9dvL3U9JYT2nHKY6zmIMobpSmuzGzvhAG/qi/DZDeOKE+9qMBMdsYOXyEduBIyc0FEQv/Tqf8voH2CMQwwpY5SUoM5wFctn6UgqlFkFPZAIpn+CtZ0I0f7hekOvisOsMjYabIm7qkdCrA5Lj4TirwiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093262; c=relaxed/simple;
	bh=XdLgw78vP983A+TrIdqPxl7VoHeX0riB0ZOsS3TwwGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeKl5ey2w3ORsO0YiurXuCNQPRmsA97G168aQZMXHOLe0zQtlkKxVZNuBLbvN972XDmM6cn9IZ4JITamYgdtO0kLGkASME+E0TzkEykA0nppVNNoBOYzwkP9IOy3RiZXuW+ktUYdirpbQejl1jhfLU3+hQFjdKivv0wiWEhm4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaE8Wyam; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so17879961fa.1;
        Sat, 22 Jun 2024 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719093259; x=1719698059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=psmXmpnFkPmw8m7RnDe0q4FMekfuWqvHUm1UB3CLbCg=;
        b=TaE8WyamUvpxuRgU/sc2/v6i+C0YHxNupWZ0UA5wF40lOP3D8Vl7QvoBLtfLy/jpm7
         4NVi+RTszUu8AUbzkmGzew/u92Afv/9SbTGx/kpwAdd+qAqVY13sg5XDAM3LSBvtfTrQ
         gHlSiu+7J8NnekHxzmtjGW1Zcjwfc1yg05Z22Mw6Yldw8lwmBWR3/XrT9MtweYP0uV40
         s9YDrLC1ZKyMWsygygXlM30/Lp97wScIc33iJ+d/YMtba2+0s64HEh/wy03waU13om+W
         wcv557ryco7+chQkVP33BkidhFLbiQdMs54ES/XW/S1Ebe6uX7bnEM0BEGGP9jCrKWSe
         VXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719093259; x=1719698059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psmXmpnFkPmw8m7RnDe0q4FMekfuWqvHUm1UB3CLbCg=;
        b=bpbgjlHktLU9kMNLEaGkUQBQowaQ2vtPvuXiSPm+JTzfExzobXXP3sJz3TicPvLgOQ
         w5G1fFFEkCDXnpNLQxpUumKmLn3PSv3MLTyaYo2m4Vn9kYdDh6RVCallYnCj6WpDQwtx
         BwpujR5OjrDemrwVxF8OBwaxEMkW6zd0S7gOZkY6DfHsXE6yAW8uycXIS67sB35N3unv
         8I05iG6Jht6RaXAJU79iTADJlzC1Ol9/VoJDLD6+idzlhxKkUHXw3TpUvfvNcxPdVHxU
         E3pISNlNiBxXkfp5Y9WwQwf0+mzNfx5JxIwXgbBZESwP+kakculFe7kWA9tTuRsH6RaQ
         OlHg==
X-Forwarded-Encrypted: i=1; AJvYcCUUDCsWpbWG+MTOEWSQ38qIBXJLCnI6ZN71djw4oVvWhva92jbuYeU5MPAaIbwam+bz+eVFNyggDiFxN1CX42iWQL0E0N4FnAwlKD7Hl66AAFeTm9gX8nn/+qhSdAn18YgoSdJouFsBLQU3Z9Q=
X-Gm-Message-State: AOJu0YzPwYxRgTbWO5oQ5dYQJP384owRlbbgMY4/ul202lulosYMOviG
	WKJhwZ5+uLmY5E+FMMmpUrvFsbd1GdDKRjDMQVVcTCsDL7VgXQw=
X-Google-Smtp-Source: AGHT+IEkOv7yLf6PDm6Vje2xrzSTTbJGzsmhV1y3d5JhLXiHTmWHaXhFLL6OuSN92I/QDJCY3Gz80g==
X-Received: by 2002:a2e:8191:0:b0:2ec:557b:f8a0 with SMTP id 38308e7fff4ca-2ec5b3d4abfmr3710991fa.38.1719093258554;
        Sat, 22 Jun 2024 14:54:18 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:108d:ce41:c0b8:26cd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3056301bsm2796288a12.89.2024.06.22.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 14:54:18 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2] wifi: brcmfmac: of: Support interrupts-extended
Date: Sat, 22 Jun 2024 23:54:16 +0200
Message-ID: <20240622215416.659208-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The currently existing of_property_present check for interrupts does not
cover all ways interrupts can be defined in a device tree, e.g.
"interrupts-extended".

In order to support all current and future ways that can be done, drop that
check and call of_irq_parse_one to figure out if an interrupt is defined
and irq_create_of_mapping for the actual mapping and let it be handled by
the interrupt subsystem.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
Link to v1:
https://lore.kernel.org/all/20240621225558.280462-1-knaerzche@gmail.com/

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index e406e11481a6..fe4f65756105 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -70,6 +70,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
+	struct of_phandle_args oirq;
 	const char *prop;
 	int irq;
 	int err;
@@ -129,10 +130,10 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		sdio->drive_strength = val;
 
 	/* make sure there are interrupts defined in the node */
-	if (!of_property_present(np, "interrupts"))
+	if (of_irq_parse_one(np, 0, &oirq))
 		return;
 
-	irq = irq_of_parse_and_map(np, 0);
+	irq = irq_create_of_mapping(&oirq);
 	if (!irq) {
 		brcmf_err("interrupt could not be mapped\n");
 		return;
-- 
2.45.2


