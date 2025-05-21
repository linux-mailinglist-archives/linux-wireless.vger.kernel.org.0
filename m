Return-Path: <linux-wireless+bounces-23194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A4AABE9AC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 04:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017D4167B62
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 02:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E622DA18;
	Wed, 21 May 2025 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB8i55bw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C222D9E6;
	Wed, 21 May 2025 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793764; cv=none; b=ZD8/sMyW8gu1WteglJkot/nJY//Jb/KzjNO9o+Lj+46wyzc9M3iQGE5I1jtmzEd2XZrOOCcw+A5gsg40GaDiAg8GAhbxx6nwoUDjQc4q7YNS8gQ6Zc2boBuTekaNa65hzxwZRA68975eFiX2TvYjwPbMkzlGOFUacEYejGzdTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793764; c=relaxed/simple;
	bh=LAVh7geJL1PD75mFZMVsyKCNDPWBKX7Jf3cyBhahb+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOBalQ2qclRF7o9uVO4uMop+BlBpWGnJcC3cNBLmhjjpxmGXn9fAO69o7j6X8U6fuT+iBIqa8VMWPVcjk8FnJi7lE4ZnE6Il42kvANLrj/D2xT82Vyr1YOjrNdj1djYz3BdmOH824c0NhM/ArQQ522zoAYj9F9gmDBmgq0Yxk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB8i55bw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso5258940a91.3;
        Tue, 20 May 2025 19:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747793762; x=1748398562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nQsjeWRBpWxFf7RQtRpXio5qVfPNye6yh/BzrdVEeY=;
        b=bB8i55bwtvQh2zkkMs2cDbi6D8+hfenkduPxAmAND35JGeinSkvC9VHPFI2WAPt/b3
         SFQpgy6LZRaVH00p6p7D8WJchb32bnydVbG+SQrN4kQUXdIFFsLmk5tA17dT8qPpIAl1
         oWR4wCLJNiypaXE1iJqbZG5aUG7XXiuV4bn8EtNpGRsUHsoEE6Z8youWXDm/GLzDSEks
         PG5GW5SJm57dWpWWuoZxNlLXvjOfijCRwkzlRGnWNEPiq/4FEDYg8eHzug5GkwNOHU1Q
         dscNYkAX5jCrnwlCSFHo+UCDNIqOAsvHb+Pip8R1qQMnhxGSki7eakcsAeKZWlvzTBRQ
         vMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747793762; x=1748398562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nQsjeWRBpWxFf7RQtRpXio5qVfPNye6yh/BzrdVEeY=;
        b=wy3LfBZHSaemHXlhbHKGwK4b5tjNeDkyW9YOSBUlqghZVbV3SA9jrqJk2Md0FKKHmD
         pIjgWSKIiO14notqxBBW1cXDi4SbNkOkiXskXCt9Rka/Ucy1/DBm+7xH3LQABNzqTrIb
         VE4ZiuuZDD4EIGbbaWs+S4JMhV7P7X2e1IfSNsi5cuHLcwfb69bBZj0eVPgBi1+C5qa4
         pnwKlatMp+oq4Y9q43f4snRTneU5LyETrpv8WBc8GPBX1KyE1xhIFy2CitqspxlntXCR
         5syWOrkbjU2zunAONAOFW/i42kGUBAOhK5ouEmhTOUQzbA9Z80ocGJJb/rK+SiCuLRsm
         2h4A==
X-Forwarded-Encrypted: i=1; AJvYcCUC6IXlFL1eSfkEg04rMM97I0wooOIw7YyoxP1Optw9hYGgQYpoCZltQMRIv+BPfe36d5aLB1ThmVjsVODx@vger.kernel.org, AJvYcCVW0CiF4qUs4VJ2Nl9zja2XGtKiyz4G0Td5SbZEYU8/DC/6vci9MnJwknCEaekNC+2oEuvxH6CpKkpD@vger.kernel.org, AJvYcCWIdNj+qSIqtOgeAgL0xbV89rdSygWpN34YeVDYqLFhZ+Y0fP5FsEFTs/6wEtkTedul33mNynI4B1wmYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OutW2fycwrfDPNBIPSVlxMEsjTiqE5FumKFDXPF/PV+To8MP
	110LwjVOoLQbbaKgDyqGINDuYxAV2ckCZcT5H/FrEZzxrgGzHnyJF6S2hdC5Vg==
X-Gm-Gg: ASbGnct2R10lcf/OaymCHkSrW8lkYj6+XyNuZYWRwgafFlaEBrSG0gM3sh3glGrjP3G
	PstNe9DHjBDM6HkGFFQNMrq4AWy+hPLI2QMC4VPkxrtbUTxCGHKRqNXNLoFZyYgFolbptKZJZUX
	59umGppuSQF5EuGYgmaDA9kI2y2lTbWwAwQq0A56RbIY12oS291ClftoJvQdrWeKXxcMqEuIx8l
	72aB1hj+SWpUNIj9Yz/5p1Ev4iMdCfkezifHSeFx6FHbr0iDRbiCH6KlaBuSW+XqR13K2c37UwL
	1h5d4KSTjtHUOUN5JcRQ6nrQnjE=
X-Google-Smtp-Source: AGHT+IElCZyZb8mDA26WIYHn1tDtNGYhoQTnTEiTj47myYXay6XKrljlU2eR+5TJ8zDjpXwkTY5nHg==
X-Received: by 2002:a17:90b:35ca:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-30e83228de0mr24493467a91.31.1747793761262;
        Tue, 20 May 2025 19:16:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0843d1sm8758473a12.49.2025.05.20.19.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:16:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] wifi: ath9k: ahb: reorder declarations
Date: Tue, 20 May 2025 19:15:54 -0700
Message-ID: <20250521021557.666611-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521021557.666611-1-rosenp@gmail.com>
References: <20250521021557.666611-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Easier to look at. Follows netdev style.

Also remove ret assignment. Because of all of these devm conversions,
ret = 0 is a path that never gets hit. The first time it does it when
request_irq fails, but that ends up reassigning it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 49b7ab26c477..d2a97e74f451 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -71,14 +71,14 @@ static const struct ath_bus_ops ath_ahb_bus_ops  = {
 
 static int ath_ahb_probe(struct platform_device *pdev)
 {
-	void __iomem *mem;
-	struct ath_softc *sc;
-	struct ieee80211_hw *hw;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
-	int irq;
-	int ret = 0;
+	struct ieee80211_hw *hw;
+	struct ath_softc *sc;
 	struct ath_hw *ah;
+	void __iomem *mem;
 	char hw_name[64];
+	int irq;
+	int ret;
 
 	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform data specified\n");
-- 
2.49.0


