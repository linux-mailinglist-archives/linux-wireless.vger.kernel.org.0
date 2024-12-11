Return-Path: <linux-wireless+bounces-16213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1969EC169
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01819188A6C6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BB6A33B;
	Wed, 11 Dec 2024 01:19:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4F6A009
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879998; cv=none; b=hF4ZP9u9w87Y5+/Wza1rzGsQep9Zs27PdqtTs0holtcEHj9LXPi9l6YOiGaQVdcdZ2m9w7ihBoFR8AZ79NUIHZcRzE9xl/u4y87kHHY9qTqXvZN/5pAFJW+FB1cWldjWrvcLe9VUSzUMv+GEQSkZi22QgIgWL4QytZLYWP1XmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879998; c=relaxed/simple;
	bh=s/sA1uk+inbUfQVuXexas5TYATGj5+rmsBCQ+Vu/oYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REctl+oGlHmHdu7BPcBQmrH/z0UOiAoJccfT/SVXcjlFD6FtR3gD/FfadUdYu7kxDj8CEkJR3cPY2Kd7ZQuC/n7ALpUWkPu56h/ghmt1VHUI8S7zHKqbm01qeJUcchk/DrRxWXCRs81AmCSti9NLHrwSdW6CBBNaWWhsGi27WkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f2da12248fso107537eaf.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733879995; x=1734484795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp97iVt69yOBSqlfe/exljPV9iDu960ZlpwaBTRyHuE=;
        b=Rv/ianIgdQujhsZEsTH8BLU8FIbTFwS+GMxu3tQGOR8avFGU7jlU1kHy5UPVs8U1Te
         9x9gd6ayI+6MeDlUlT35ivIIiuQ9JJJGbOkiAzBu3d8Kstz202yeW8RGucSwAILdsd0h
         dXjBGnjt28VW6F8Ay/uUsK6JuyBSh2D28iTeTObRHojxVjZNFdZtKZTgQTfOpdhFX3AP
         31kK+6oh7EcA6s2e6e9bDoUJ0ayMF2OIqzadpAcJ/ggjsC3gZTClSOExAbUd/UoDRmxL
         +u4lrKW8AmjshEcZcPFSzPR6M3fZ6OvjxFo2vvCWq5FB/QTGwDGV/otBEqOHlBYO2zUl
         EMSA==
X-Forwarded-Encrypted: i=1; AJvYcCWgE9z26wxIkOCWk+9+iQH38IyuQ0FrwL9og3bjRkggNK/AHfhU6SXhZJXmCW8VKp0kwIlgirJwMnvq0vHT7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4aaqyxkpiRQg9GEqH1HbOqgkJV/vuzwtVYS8ku7ZjiE/m1wR
	fIKh1XbDcPzOXRUOwfd3vfTT6mR73ULwgTBGUMBZLE+5d/psKzUF
X-Gm-Gg: ASbGncvn2iN28kp4CPsD1xkHZzBEXZGPk+/iQ669aNVyhspDI8zZptJRsZX0XI9AwqI
	aDc4XzvFaljUGe/HffdbLGM/bOSTbmMcrxLTmsivEQYzzbJxtElqQdTn8x4gVp5HdRoeUyXb0iR
	0TK8FmO84EN4gd6AoqTFgqPxYO3iqu0zyMRRqbVLPLc78hMzVUkrmcj8umD0DRM5qPSmiGpqhTJ
	9DxAZ30yy7zezWtWqjvVjVDNQhgrbclTSZUKcneI9gA8chKg78ITUQW7efc8kOHA6BUY8M=
X-Google-Smtp-Source: AGHT+IGub+QpuAGxq89kxr8PhzQ0vEN2Is89Nr60V+LtDwDd1KSFdzv6E/56OxeohVB4H7GUerri1g==
X-Received: by 2002:a05:6871:5224:b0:29d:caa2:f0ef with SMTP id 586e51a60fabf-2a01537d059mr502351fac.6.1733879994868;
        Tue, 10 Dec 2024 17:19:54 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:19:53 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	"allan.wang" <allan.wang@mediatek.com>
Subject: [PATCH 05/17] wifi: mt76: mt7925: Fix incorrect WCID phy_idx assignment
Date: Tue, 10 Dec 2024 17:19:14 -0800
Message-Id: <20241211011926.5002-5-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211011926.5002-1-sean.wang@kernel.org>
References: <20241211011926.5002-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "allan.wang" <allan.wang@mediatek.com>

Fix incorrect WCID phy_idx assignment.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: allan.wang <allan.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 6823187f406b..97b48fda5595 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -384,7 +384,7 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 
 	INIT_LIST_HEAD(&mlink->wcid.poll_list);
 	mlink->wcid.idx = idx;
-	mlink->wcid.phy_idx = mconf->mt76.band_idx;
+	mlink->wcid.phy_idx = 0;
 	mlink->wcid.hw_key_idx = -1;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mt76_wcid_init(&mlink->wcid);
@@ -851,7 +851,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	INIT_LIST_HEAD(&mlink->wcid.poll_list);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
-	mlink->wcid.phy_idx = mconf->mt76.band_idx;
+	mlink->wcid.phy_idx = 0;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mlink->last_txs = jiffies;
 	mlink->wcid.link_id = link_sta->link_id;
-- 
2.25.1


