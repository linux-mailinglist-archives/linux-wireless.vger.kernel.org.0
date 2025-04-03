Return-Path: <linux-wireless+bounces-21112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281EA79C3D
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 08:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2B5189461A
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 06:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089EB1A0BFE;
	Thu,  3 Apr 2025 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqxtM//E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83F2A8D0;
	Thu,  3 Apr 2025 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743662642; cv=none; b=GEbAD0HrqHy+6TCxchjCoubEApk4yV8ZtacJbMB2nx8Dk7t5kIJtN6DvRK6hmyf3X7dPElFXNVgcjQKruSriUnqBhGytkKEzbmV7wRmdbIL1UGlWuZdrFkCy3InBzByj5ItfCEirbhY4SRAMtRnC1z5vbdBNwreWHHvFAyTxDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743662642; c=relaxed/simple;
	bh=+cSf/YtAy1gyRMqPmUnYy9gMN47COfJ3Xv8rENEjeEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGa3xLPrGdEe+ROo/NxPxJoyRWpkb0H/onqRo0avRDxin7lIiAWnLvylW6gGDl7aBrqrb9gqpITu4307/lDGDevXy0PkvEnsGpafNV83LSn7BZ89wG3x9JQOLI4Nqk3eiY2wfaUTXT5gvJVcu1UiTdoGccJNceme3lL5bsDgXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqxtM//E; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-aee773df955so698350a12.1;
        Wed, 02 Apr 2025 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743662641; x=1744267441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ykrR7iAx9ez7r09+03/1ZkDbNGh2pKfyFPnmAhHSaXs=;
        b=bqxtM//Ed6rJyJOQT2Qb2POxpMtY/dJRVOTsr8Bh8RI0P1pfFiI09Cy5wfi4MzM4Rr
         aNobpbBTQ3hl1riQruo0/09ducV9/Py3W1DgjW98lOD/Fpb3+kKCFg36qh4U3UqJs7W3
         spmw9e8NLsqIJDj8khdIHUWrDQ98RC19nUWB+Kj7+LogWjWm2NedrtGwqM4wbWH708su
         fqCveylY/KfNCAahLG3G8CEa4OzC6IqDqBaVm6qMJiSTHev/fzuByLQ+3b2qkHx9VvtE
         0HOcvZT/6IjB7n6aQhiYakxMnGv2KodF5xP9ECCupjpSXZYjaLAohSpJf4DJNPEGwbqg
         zEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743662641; x=1744267441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykrR7iAx9ez7r09+03/1ZkDbNGh2pKfyFPnmAhHSaXs=;
        b=HJK3/GJlMlgs6ypK49fYs3pWsuUOywmklV3asTtNlIX5Bs7/aicNLtDIa4RhmX1dgh
         cKR3uD8Hu7BV6G7rHpIr8sal69LLIKc87i8nigve9WDfoSr+HmCDhe/vlEWbAy+Ndddx
         aLG/IlP2MhuWpj8ycYEjVIgPgrDZJoVQyjxap/2eUSxKz1tn8whz1ffz3EbRX9sumYbf
         iiavOTW0NXwHhcrLu3eNtarmJnpXD1DCZ4Lq8R7Tob0YjZixJ9KCBCkmakYlrSJ8sQSV
         xwetLHy231hRytyHRVOS/f4QUHZ+B05QWxAsDeqk8WHG64gEMZQ0fKF6Dj9mEleZdcfz
         vA6g==
X-Forwarded-Encrypted: i=1; AJvYcCWix12CES84ys3tf7A09BEBXxu/ljOo1CULWlQ+fwKxxl/k0q265Zhx8CYAzRtbWRX/HM+9hO+BG1LGhlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHIuKGHCySEcEh5O2oRtiAL5uPbQSKDb+7KINvPowhVXtLwjQ
	6sNtWOxAxElKuQ0UfcF3ya06K8kEoGK3qagh8xhU3dyqscxu6AgB
X-Gm-Gg: ASbGnctVcAE110V6ZAIjiYFTkh4Q1XhawuQcKPNjGOCGAvjV7crS2YswsWNkEYddGL8
	YjIMGlhqhGb5TiYlgC6OsKioLLFfj4UWDGlCAR8jtpkNXQZw7tZhLXcF0gAGkRT6eJlrcbjFjzO
	to6CQyL/j4a+kLiHa1DbHVPs+UuR//5fGpf+KV9hAiCqnXA9vg9dVRHB+jBmy38UpLM1AJDlsSJ
	9D57WPcYWBo/cPVkRIPOduoBGcH/4/t5wpsSrQ4pMI96dcOrncHTQxcwutdzJThEqeH7Ig+t457
	7B4c0F2m5gUWessOblTj8lRtRRdDBHIrlyhFh3yboaUEaBV6l+yDcEUK2r/TRjwMiOsDRao=
X-Google-Smtp-Source: AGHT+IG83pAigN0u9fFp1U+1mHdp8ie0G+EShwD4mUh/8O4s3BJGqBMlbGS+xQCeTPBm2I+l1DLKGA==
X-Received: by 2002:a17:903:3d04:b0:215:b1e3:c051 with SMTP id d9443c01a7336-229765eb309mr33330915ad.11.1743662640547;
        Wed, 02 Apr 2025 23:44:00 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c3819sm7055945ad.87.2025.04.02.23.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 23:44:00 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wiagn233@outlook.com,
	rex.lu@mediatek.com,
	chui-hao.chiu@mediatek.com,
	bsdhenrymartin@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1] wifi: mt76: mt7996: Fix null-ptr-deref in mt7996_mmio_wed_init()
Date: Thu,  3 Apr 2025 14:43:44 +0800
Message-Id: <20250403064344.64253-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_ioremap() returns NULL on error. Currently, mt7996_mmio_wed_init()
does not check for this case, which results in a NULL pointer
dereference.

Add NULL check after devm_ioremap() to prevent this issue.

Fixes: 83eafc9251d6 ("wifi: mt76: mt7996: add wed tx support")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 13b188e281bd..5bade83238bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -323,6 +323,8 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	wed->wlan.base = devm_ioremap(dev->mt76.dev,
 				      pci_resource_start(pci_dev, 0),
 				      pci_resource_len(pci_dev, 0));
+	if (!wed->wlan.base)
+		return -ENOMEM;
 	wed->wlan.phy_base = pci_resource_start(pci_dev, 0);
 
 	if (hif2) {
-- 
2.34.1


