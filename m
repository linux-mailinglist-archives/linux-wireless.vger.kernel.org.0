Return-Path: <linux-wireless+bounces-13331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DF098ABA1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 20:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC851C21443
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E4F2AD1C;
	Mon, 30 Sep 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg9k+CCx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE158192D82
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719642; cv=none; b=myhn6qHAfVQ0ibPoumSUp7i26ndDmW2XZTj/ll4hwPN4QHVmR5b3vh6vF9PX6H+XJeDvPC8qVoCWAU1oyTctSK1fVK90cj85Hu+hNUF1/XYjKAYidv7xe2TjZBJR6PXMELJRuXQsy/5cS9ufE5jm92W/t5oCjC0T3BcKRHjPWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719642; c=relaxed/simple;
	bh=C/yivnfbX/rka0o35jCYT+qouKhKeDWdg5Gz0VoHq3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwJQ3dHaaHIaCMb1wq+Pf/C36Es47bLPkLY0p2kWZ3OIfs+/o8D1xN0YcFl8R9d+29Ws0ioRzAkMRtPWRLABdUHnxecQ8o4/xQSc7hVw5HUDOPPcAWKT4Gr69jZlWz0a6JSjnkNUOGzyHL5Z7nQhcqSYoMidkq5DuFFB/6W6ZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg9k+CCx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20aff65aa37so38106565ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719640; x=1728324440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YOFrI9pvtN852acX4TslSrLQwF00nXlYCTweaRDsZc=;
        b=Xg9k+CCx4P/Fw0BwwNExvRqBID4MY7wX2JRzwrkmyfOFaCsgFf1ZWRNsC/Rr4dWAjE
         X5Ik5u0axBZL8L8UT0KoF4j78uqzdx1H7npKBAVwRy2SzolyMuikG6kMN+l2zPRlwPg+
         H3qbmd62W8hTNvn+Nyykhmij1Qzx+RTOeqOPdYlD0OHuf/jpiWzusqpzcWpflGCHZ1nO
         raGbpFuvQxzFoWqGKajclfzRXDoJ/mPwB5SYx6uF6i84kfF7XfhueIw8f8MaVp7qkvPG
         aztVqugyvC5FdtNZT6RSMpdrSzTjpHPFuE4gy0Oa8fysFP6QmpTb9GUyyAp0Fhy9zvAG
         V1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719640; x=1728324440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YOFrI9pvtN852acX4TslSrLQwF00nXlYCTweaRDsZc=;
        b=RLyIgX3iM/wYqPVL5ZObnIArhe9GmlvdBjQUnNMDA9Wu7Gneyhx3tbq0TsrFvVa9L4
         3B4qOcBYq4txzC30WGcNesY2+dByNeQJRYjnYSpesSNx0Seeb8MTXuaVH/pSIvVo55A+
         OubKS17lvegbIr4/nCgP6lER02JLrVAex7fKFMAzrFsNpuwckRfKY44zKYF4LYzwsVVs
         ydGUvpTauOKQEqBkvnP2WnIDmbuaE7kyChO3iuVmNbOoH1qhxlnpCap/wSCdFxCVO/DQ
         LBJ8/dGd1Ki0PHqC4koa6ATmeia4Tuh9jnoaDzRECGNx0RxAr7wjqtquJKu3wMwpOlE+
         qhWw==
X-Gm-Message-State: AOJu0Yx8DwU0pV0u185OqnpFbMojBoa3Efd7YN9Z10OgqpZ9E1kopqI3
	9mGhOCGl1u6BCNp91yvLU8NnAQq+5eOrJHIw95V5NwgA1Ecou+MJpgeAytn5
X-Google-Smtp-Source: AGHT+IGzrLw5ciHHfzMKlD2c1bXSg/YkzFSW0lp6otb873KN+e5s3PTqBFQLwc56t1hW+IAhoJyX2Q==
X-Received: by 2002:a17:902:e802:b0:20b:6773:a00 with SMTP id d9443c01a7336-20b67730cb8mr118369965ad.32.1727719640013;
        Mon, 30 Sep 2024 11:07:20 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d9fe05sm57439295ad.93.2024.09.30.11.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:07:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com,
	hauke@hauke-m.de,
	jirislaby@kernel.org,
	mickflemm@gmail.com,
	mcgrof@kernel.org
Subject: [PATCH 1/2] wifi: ath5k: add PCI ID for SX76X
Date: Mon, 30 Sep 2024 11:07:15 -0700
Message-ID: <20240930180716.139894-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930180716.139894-1-rosenp@gmail.com>
References: <20240930180716.139894-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is in two devices made by Gigaset, SX762 and SX763.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath5k/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath5k/pci.c b/drivers/net/wireless/ath/ath5k/pci.c
index b51fce5ae260..b3137f60e879 100644
--- a/drivers/net/wireless/ath/ath5k/pci.c
+++ b/drivers/net/wireless/ath/ath5k/pci.c
@@ -46,6 +46,7 @@ static const struct pci_device_id ath5k_pci_id_table[] = {
 	{ PCI_VDEVICE(ATHEROS, 0x001b) }, /* 5413 Eagle */
 	{ PCI_VDEVICE(ATHEROS, 0x001c) }, /* PCI-E cards */
 	{ PCI_VDEVICE(ATHEROS, 0x001d) }, /* 2417 Nala */
+	{ PCI_VDEVICE(ATHEROS, 0xff16) }, /* Gigaset SX76[23] AR241[34]A */
 	{ PCI_VDEVICE(ATHEROS, 0xff1b) }, /* AR5BXB63 */
 	{ 0 }
 };
-- 
2.46.2


