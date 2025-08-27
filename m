Return-Path: <linux-wireless+bounces-26720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E51B38B0B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 22:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75B818925CB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 20:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135FE2D877F;
	Wed, 27 Aug 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEC5xu31"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620A27A92D;
	Wed, 27 Aug 2025 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327136; cv=none; b=kqqX3KV8vMgprNadRIWXhXNE03Akht90FiEzcu03HECssiTj3nsWxS7KhyDGfde66nOWLGZ6ZVrxKjPxBHQmYbZJvw7sIddQ3ljqWiW2Bm4b7xa6dLcAln5AqM3dZtgm8dLXtNMHckxVa4EUJglRcmC8J8DcQmzpCe2b0Ht0sxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327136; c=relaxed/simple;
	bh=g3vUD8LgLz8xosHWcuASjycEENaFn9WsWMleiuh0mwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmDbVrRTutLh3dLi9cydL4EJuzv0kne27Q4E9CHXLqMbkEI2p8zOTKKLEcsP7PO/7EKmiQkW7UirwjPQlA8J9+ALzvCil78+gAsnFpYC5mqyErNP5ETuD9zwCcDAEX8OI2ePZ+zxu/ohos2GSOVwCxvjtOMNbyImrMY2XOdmC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEC5xu31; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7720f231174so276445b3a.1;
        Wed, 27 Aug 2025 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756327134; x=1756931934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=252oT4Hha69glxkP3l/gBHkZ/1EONz03+KC5CcMvNa0=;
        b=lEC5xu31iWCpNur4KGiuavH0DlRsB7p4sByZ7+MgBA3hHdiZWSXO4VkBe9GQIWfBXU
         3tQqBDoLO/SWFBIKwWrvZAMyZvg37Jq7nJcVx+S6JYEbcuj9/MCHu+38U3mOpQ0P+9/t
         z5O9XGtDuoSs8KRYN6Pam3ESc79XkAq8w6IHhB1x1sHqHnJ5zyMM2HwgjjlvlcQKWT1k
         JvD6ckNxHtaGseikTOp97/qU30BD7BfMRKTAefYLRkvC+UauW6YoRyUEjP+MqzpyGNC7
         /7U0tIFHiojueBZ5pM8Hg5FkDjsRCd/wOGGEohzxaWD1BDry6TtkMyMFRU8L7YegOyXs
         1YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756327134; x=1756931934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=252oT4Hha69glxkP3l/gBHkZ/1EONz03+KC5CcMvNa0=;
        b=rfgN8RCUA7R19KNuTqYi5DoIveATXEJd5XXBfCQfEBHpEb6jqaIuXnxeFRv47/1uCi
         fL+B/A5JaK5Rpg9646HDbClTr4cJ3Lx+vdNxrOuTmIJJwwn+WAm5YdtETB93yhankO5v
         82+St4BOSOLcccD3PA95eS6qizCF1ARzLiCcwHUJkcPtjlJpJLrHv0yX9wgXraWfRWoX
         1RVO4+p4Z/FiVouEUoVuqQw+N+kgPzhu2y+6qg4ruNZauBArweVaD7oNMBu8qXFcBf5M
         L8l3Arf0VqpkSsWlcVQMNIHVFtvok4hade4HspQFQqQcc5almSDnj6z3+UGrv8TUzh+k
         BdGA==
X-Forwarded-Encrypted: i=1; AJvYcCU5t3kXNLLctvA/ERIWYtLyc+6hbvxMddzVyczeTEJd7pjSwNZJqdN0phOpDmZ2i8UQnNDQk9sz+reI0VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzlKmRr7Ute3s6aasr9Tpr7aD2WMIfYnwFJfVvtZLcOv7KYoC
	2ahOz7Ytpc8tlGe6VrKgpB244c8x9qFM18svAGgyEJAWQ826ZorFzwY47bIE5Q==
X-Gm-Gg: ASbGncuzMWS3XoTRHR3vUzuSAHPjP7gY1Y4Xk7xx95kUPASToIOXNz7CsUFOcL2fgAP
	UkuPm5O0VgeAbDdRl2wsrzLmFuOKmhQBTDAFIBtfZU6WPMWOoiD7rRYC0L5iPeazfh6oDtYx22S
	uthI7ai3Hrx2KS9ERXOYDPWokZ1RjQPLTD27eFJeFSJR8Cn89BwH0nv2Lxm4sT+4yoz8p4J3vIh
	4YPEzuc3K0NUhAMl7aEYBPqoAIeRtzWOAUaL8Fhc5TYGkVIIOaQvkbTt1xozaoW1rXaaLO5hYwc
	DZ/bZkezMme+izk3mhsn7szQ0pnsVZ5iSHhZlUtrXIYnHU0L5bcVtYWk3sHP+OyEtmSyYlyX5dE
	DNYapu5Y4gKsWCTxSM3bgIK6qn8RMyRZKpNHB6/mnLdfzZjgFrHyteNxg+/+FukGKxg==
X-Google-Smtp-Source: AGHT+IF76jF27JYYyP/4B25nnu5OjijebrPt3nphOQyIKm79HURBtHuWwXY2bqBXwU8nN9mXaGGHLQ==
X-Received: by 2002:a05:6a00:b52:b0:772:114c:bcbb with SMTP id d2e1a72fcca58-772114cc0d7mr2575723b3a.4.1756327133677;
        Wed, 27 Aug 2025 13:38:53 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e6535272sm8578355b3a.24.2025.08.27.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 13:38:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	miquel.raynal@bootlin.com,
	vasanthakumar.thiagarajan@oss.qualcomm.com,
	ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 ath-next] wifi: ath11k: switch to of_get_mac_address
Date: Wed, 27 Aug 2025 13:38:52 -0700
Message-ID: <20250827203852.8586-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed to support nvmem defined MAC addresses in DTS.

In addition, check if the probe should be deferred as nvmem can load
after ath11k.

For brevity, ACPI is not a factor here. ath11k is too new for that.
Except for ath10k, all other users of device_get_mac_address are old
drivers with explicit ACPI support.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: remove wrong EPROBE_DEFER handling.
 drivers/net/wireless/ath/ath11k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1fadf5faafb8..2a55c5ab2f2d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9,6 +9,7 @@
 #include <linux/etherdevice.h>
 #include <linux/bitfield.h>
 #include <linux/inetdevice.h>
+#include <linux/of_net.h>
 #include <net/if_inet6.h>
 #include <net/ipv6.h>
 
@@ -10434,7 +10435,7 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	if (ret)
 		return ret;
 
-	device_get_mac_address(ab->dev, mac_addr);
+	of_get_mac_address(ab->dev->of_node, mac_addr);
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
-- 
2.51.0


