Return-Path: <linux-wireless+bounces-24481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F35AE8323
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2A33B12CA
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC4B2609E1;
	Wed, 25 Jun 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLWg0KCZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D725B30D;
	Wed, 25 Jun 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855753; cv=none; b=BCrKyuqUPQS1TNTLMdwPoMv3+WxqDPk99WqWINaX5j2FzXGhWRG5D00dyw+ANHtmUTOE3gtFdBPPb2U0Q7X86zMdEkLpuhqZOovL/Kuwr0Yq6ACOLdJ/F9TgvPrXOyHnlEwXenypG7jjy6GJy0dsmHUillftxRUnEUqlF4BLrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855753; c=relaxed/simple;
	bh=CzhJNdyIc0l6RqZC+4D1XzPonUW0mUl/CNzulyzSr7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXg3eAtnJOFb1zQUHhFB2Uk/bvS0Ya1LDuY+ziGfsebBPYeuTrh/0fC1TBl+6GX4OUcQo0pwVjL3mHCvGxbI3FNmPy5eaHBp2KN7T7pVfkLNdxY6aO4FXYgcz10ZiX+JRP2U+7z+IGPAWP0EuoL0M6g2Aa1jIMNGjrCRPyqf/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLWg0KCZ; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso7062678a91.3;
        Wed, 25 Jun 2025 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855751; x=1751460551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZHCaOLOu0qUkH+czAl5OFp72WAp6qbgZTYA1mrGPYU=;
        b=XLWg0KCZQqo6Gfxo7u5LO9uNrbhqcryDn1PdRouXG45+z7iE/MogiB2AniWaKaJnTW
         Y7AatIxhYOelepL0iR42SdVdHzARskns58IAAfjrYCIWoCvAkxiSvRwmywRgNYEkkVY2
         CCnGBDUuFjKYd3h0Kl6QYLk9eurw8v/trxyg5jB9wVncQm4xyL4wNHxdd1JjdGeaVr1e
         iYNgpqpb9+B8/E/+bVYLzzyrQmGYC3aO4fn8OBqarhg3jqQt1rC7lhCXOkRs46UihGTM
         UuVllT5pWft6/QUkL8dBX+MeD3hf7sxG+3ks2mm4Cyn/BTKaO+pU6I46yYtm95DTxzoX
         PnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855751; x=1751460551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZHCaOLOu0qUkH+czAl5OFp72WAp6qbgZTYA1mrGPYU=;
        b=YIM2063bjG1P6tcfDxtGQAAZo/BCbWjISZYiC1EgRutdMUULC8UET7kMrG+993bhlU
         7eZIbxB6TygQznOOnh3TLtgr/kCiba6L3Br385XCxgmT1hNvTRAsBSTlHSDWsGEXglto
         J3UKVhuZnlnXQYRK5KPr7NmLBpybkXhLUiRANfLtRit5p/bDVFtpXnJGtzsKAE+84rgG
         k122pmJOKy4HqqxRWSg00t5ezwHJNFA8Xo3Nem441Z3AXKMPVmaSwSiHphLzIJp5FTAB
         vAeogEzeIV7JkjZzb14aGjfLd/qWmCKxLJ1DWVSeZlHis4AFE8rTjO40L7cg5mWmdQCP
         FVow==
X-Forwarded-Encrypted: i=1; AJvYcCUeVc7H4LJMKhqBYLHsw0W4bZUjRol99JzPKgAeWNjJkMGPbk65u4uL3j8/arHM0Dw1G0Hbi2LiwWoI+OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2JkeR+S7yEtQRvDUf8LPzmXDV1C/bP7mnjJTc1lw3QCGir7Y
	+A7k8RGDba5sIz2oUYNZVg86kFRxn8w+eQIIibFfqp+6gjIPIjb9RMtqTTYvvtSt2UMHVw==
X-Gm-Gg: ASbGnct8siSTliY8p2o7S32OpUqf2WOrw6jAhDDe+0sb4w7HOF4eoGT4GkdLCUCAu9C
	x66FaAoKgwlhFohIv7uErbrT9+FB9CKDRohb7+/v+U9pcG6gVPT7lDsuAKH4LlFIaY8hrmfXO1Q
	sCV0++L9IuqgKjqaPt2qp4JQzC3OB+ajEMuBeUCWt/EKCOprUZV3K35LNqNdJp/InlOFcup0hjj
	nTQgepmMKCd0yir/C5v7OJgGq/pPA74mkZjt70YnGzzbdJbG4NDempiGuSlbWyYXz0t5uVeogpD
	ex6Puk8q/OZx77Paq0ox9d7B0RhhH/O5vZwBnCgv+ZJsiEfUO9XBO5t3OmrItBEpD5InXEwY8cX
	pvbrmn6viccgL6vFNt7YcSVMY
X-Google-Smtp-Source: AGHT+IFqaQmTqwNghE2Dq9nBvL+YbvMQvWNAHJ2xzUeJUDe3uctj5MwE11BX1968rl1xIYmMD9hj2w==
X-Received: by 2002:a17:90a:d888:b0:311:f2f6:44ff with SMTP id 98e67ed59e1d1-315f26965b3mr4877927a91.17.1750855751204;
        Wed, 25 Jun 2025 05:49:11 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5386edbsm1870741a91.6.2025.06.25.05.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:49:10 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
X-Google-Original-From: Henry Martin <bsdhenryma@tencent.com>
To: huntazhang@tencent.com,
	jitxie@tencent.com,
	landonsun@tencent.com,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenryma@tencent.com>
Subject: [PATCH v1] wifi: mt76: mt7925: Fix null-ptr-deref in mt7925_thermal_init()
Date: Wed, 25 Jun 2025 20:49:01 +0800
Message-ID: <20250625124901.1839832-1-bsdhenryma@tencent.com>
X-Mailer: git-send-email 2.41.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL on error. Currently, mt7925_thermal_init()
does not check for this case, which results in a NULL pointer
dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 396e41a74a88 ("wifi: mt76: mt7925: support temperature sensor")
Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 2a83ff59a968..4249bad83c93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -52,6 +52,8 @@ static int mt7925_thermal_init(struct mt792x_phy *phy)
 
 	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7925_%s",
 			      wiphy_name(wiphy));
+	if (!name)
+		return -ENOMEM;
 
 	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
 						       mt7925_hwmon_groups);
-- 
2.41.3


