Return-Path: <linux-wireless+bounces-20999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEFBA7645C
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 12:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D723AAC9F
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571D1E0DBA;
	Mon, 31 Mar 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS7+oUsc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD051DFDB9;
	Mon, 31 Mar 2025 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417378; cv=none; b=jsRx4YO57+sNN6yojKUE9qft3qC29BlN2xu9rhcG5w9Xk7gtZqDq02eiiaYmM4BJ6Y0j+D02P5xQeNu54HbFPCDoM9ebSiycWrpr8Ys3ErtYVbsY07H10Hw0/bKzTpTqnD9YDhLPHwUDLliucGC5H7cVoVM9c/powZtMyJlV+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417378; c=relaxed/simple;
	bh=6s6J2UuXf0fd6yPdiBPRy1K1INjkNRdNLX0Bedtvnqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MGJPPHqDd7X8D2FRuADJsYSkon5/4tGlyfWQl6Dt94+TF9cB8xlXuk1nQ/T5E3cUBswd7oQZIWzrkU8gjTdeEqNj4Sefp652vkxurzk3Qs0vQbXd9ttzoIkFeR1IK4K9ubq+7f1RyFk5zPx2e7JH0twAx7SEqsORZtPkj6ZKy5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dS7+oUsc; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-224341bbc1dso73361945ad.3;
        Mon, 31 Mar 2025 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743417376; x=1744022176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hC4q30f9UkZjMp/7IensIAT+0r2jKyVixXgW1Ksqww=;
        b=dS7+oUscaajc9UUGFa8+6VDvT/QkLhAn2RH+6EjvKx9gPcXuc2/U9bsc4NwEw+xx5r
         8FV/E6/8OnTf7m6+OD9r5lJCBKVOYNUVsWG2xXPlH97XHrjllFzNmeT7XQUFN4f+bnON
         dr4A0mzV3+DgR4gTE5BTzKytVu1MT84ekJypRKopA5VBbiFEY2X6YpmfSzGxc2eWKfIE
         BzGpi9ywKNqZjH9P4F4cvft3ria7TbscpwXiRcQxExc58THh72xlF3QGEmCdefU7EWdb
         DWbuk8Sf6+M1xC83vOv8BH2YV54N+p4kLoPFRfaMuIEY58aSnAVZWt4lpUCHbMARFIJ+
         Zgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743417376; x=1744022176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hC4q30f9UkZjMp/7IensIAT+0r2jKyVixXgW1Ksqww=;
        b=b3FDa5riiWZt/GuGe9vN95w+ZMA6Y5no9amI9QWS0kL9Sm3oXHv5ztzTLD9+1tuJHP
         nW1M9EtG73Yh4aMFU2Y0q6Y/5j9TeOZd/+8PMhwCorm52zbxjTNQjqNjqEFigB5NmqIe
         OXv9YPwpwMuzzBLBcyJjLyEIrkO1mZKwLq7qWqOziW3VqqUcwY9PafC1FjDIMoAhcWfb
         5tXF2YfjPj/ZotG6V7gEoa+b8QWj1V55ug1Y1d8seUtuXRyfaYMT9YePxi8e1XBp1w7N
         WZEc1HrIwHjm50s3U4JVTJ+wc+78G6Z6uiF3fr4NXgmgE+QSEyj8fal21C+MG4PlaAhc
         NIdg==
X-Forwarded-Encrypted: i=1; AJvYcCVaqMlaAfleAszyHt1S3+xoh2JRwn3tJft32yDImVRsWhgLsmwTohrxPFsnWftHznR6YX90bop1AQSvkuSjcl8=@vger.kernel.org, AJvYcCWpjOS+iGXw5J5S8ihqmdzQXH631wVUUIsVMJXmdHIvLLzoFpoZ7D3X1BwbJm9f2kvwF5EOFJtbNOOZfW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGHAYkxo85J2rym/61d76wskwF673kx/9KHVqjmSgMVhS3uAM
	xBamQDgAZf5sEwm6YGGMnoIal9qHHo67qLmj6d0U1W54OsdK6Z9h
X-Gm-Gg: ASbGncsEQ0+2caSMXBlhp6xcgeGt/UsHn+ACZDjAcl8A3pDkZtwEvqzoanbvbFSb3QW
	VJ6256bo7VOUB88CfC+JSUOW90H4Y38pFrrE/019SdmdcLmC9u8XgzVgDLXUjsFgszyqp2MxmVu
	PKf8m5PcQ5hXG1LPyMm999IbqKxunu01/SX6xb5qu0ER5G4YJvBNU4yfF+qcqeoeXXvombpCBlx
	DBfoI/gRQAiUFX2HmUtIzOB8OgJ0FKINCbzfDQmI42WSJ6zvnElnjmSSpHBwFUjsiSwYFKoKutZ
	jb2bsRSSaTMfQPziDLxDTWi3p3NJoXC1VoL5z7mg1kUYx923BiKcIYCZgodpLccCt7hytiyuX0E
	GFoFHIw==
X-Google-Smtp-Source: AGHT+IEI3i1AQFr0jMC8FT29Lzc8UGqmVmTq4ieOAqus6bXWPKmXMnFF1f9vgpgb+tXlgciOTA5wLg==
X-Received: by 2002:a17:902:ce0b:b0:220:ff3f:6cc0 with SMTP id d9443c01a7336-2292f9e62d6mr157774965ad.38.1743417376277;
        Mon, 31 Mar 2025 03:36:16 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f7dd8sm66104645ad.226.2025.03.31.03.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 03:36:15 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	howard-yh.hsu@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	chui-hao.chiu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] wifi: mt76: mt7996: Add NULL check in mt7996_thermal_init
Date: Mon, 31 Mar 2025 18:35:43 +0800
Message-Id: <20250331103543.9154-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When devm_kasprintf() fails, it returns a NULL pointer. However, this return value is not properly checked in the function mt7996_thermal_init.

A NULL check should be added after the devm_kasprintf() to prevent potential NULL pointer dereference error.

Fixes: 69d54ce7491d0 ("switch to single multi-radio wiphy")

Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 6b660424aedc..702447022f0e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -217,6 +217,8 @@ static int mt7996_thermal_init(struct mt7996_phy *phy)
 
 	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7996_%s.%d",
 			      wiphy_name(wiphy), phy->mt76->band_idx);
+	if (!name)
+		return -ENOMEM;
 	snprintf(cname, sizeof(cname), "cooling_device%d", phy->mt76->band_idx);
 
 	cdev = thermal_cooling_device_register(name, phy, &mt7996_thermal_ops);
-- 
2.34.1


