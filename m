Return-Path: <linux-wireless+bounces-21274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631FFA81400
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 19:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F081BC09AB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 17:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D77D184524;
	Tue,  8 Apr 2025 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOE887h2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06C17332C;
	Tue,  8 Apr 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134557; cv=none; b=CUpqxPHqykStHrRYUH7OT6e5D2TEQ5roI5gFlrBmr09jszlnzc4BeGQR+WjD0H7D6DMR9D0qf70sdbYUR0gfZr+8RapG+DthkKTI7BknCPRE1cDSXpLF4+peQ5hL1k78bOqsR/UZPGDVFtxvvOOwpQXUMdtgk8honZN1DK0Tbkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134557; c=relaxed/simple;
	bh=nYE/GPBKgV5rdH3Np+KQo5T8RRPSiFT/CZ2aYXPJSFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q/NdRagCdq1jtejEkcAjO53oAP+2+CZ0erNJfr0F0kbhQ0lkCPluW2xNPG1EBhP/6kJA1z6Bw72md6fPsMLd6LsBhI6BZRYe5TGEmzGOwjOYvq67zXzqYW2r53bMwhL9u7GnWTpU1h4XNclet/98Uq2jDglrlNFYbg0DBuGaGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOE887h2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso39953435e9.3;
        Tue, 08 Apr 2025 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744134554; x=1744739354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZR2UVpqmeFDPx4PfDo4Uk4g9Hsu2oDRhSNi1KzWe7k=;
        b=IOE887h2YwD20uA2b17zSIrZHaoR+e4aP88BrsMnEgjcG0nFD1Lq4zzjQ2BOt8IA3I
         uXuFiXnct5ljgKjxmz50rdx5MOwueZQQ8+NQVha75wtK7S4TGHJEqQu4XjfDClub0t41
         3ESrgXGBfujQvxIXbu3HbwSGTdOZQJ5WSi47W2SCM1FOsNO0UFzvn490fDXNtcisd8fo
         uCbJNhNMf8kxENPfEyQC/qrli2gzHFlVwOGq0hNoMDFj7cs9Yslnt/ebnBJ1Dm/+/uAT
         R0jB+dheKF92WDW5V2JDfKcfrkjdZk2SeIYTpS6dd9OcKjF0EmZalti47rx6qpzM2bn5
         ueGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744134554; x=1744739354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZR2UVpqmeFDPx4PfDo4Uk4g9Hsu2oDRhSNi1KzWe7k=;
        b=lTDjt7GcYMBvuZl5WyQDLl1GCNOP1BoPxY0HBfRS1SWKSabH4Eeu2CEkZ0P6PWGrPk
         D6RjEh0E/soxYoj6JTuVcVg7ISYLZYqiG2HS60IcG4bstEYLjFjLtralc4ECGoXWsyOk
         hhiE1C8A6cXLHzgKfiVBBwHED1VkTpeYgdB6MGPffKzLFjgSbqQNSy5negeY7QCapn1a
         YJQb6oTtZIa5AAotQveezdnUl7cCFR+APGF+pJ0oPRK5Y7Ak1YFRu3aIpHpABsEuIosB
         qC+SUHIx9ffyU/24HOHQHgQ3ZXFcualATly6bNxmlbceNe9gM0EQhN8dzBxZU8Ypqb2X
         P+jw==
X-Forwarded-Encrypted: i=1; AJvYcCU2erIU27GeF4HXwlcZCbGLX33m1DK08tK09yFri42aRPMoWs4hpvX8Hhgs8ORuCcIramf6zOZfcdyWzh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yunjuVeBaVP45k56B0rubYryDONSb6IcDih6VINN+yF1FjPH
	BQQixTmYlZPcYGAFmCGBH6kX1o+/JrX2zPv7ZaRgQ94D02WElxKh
X-Gm-Gg: ASbGncvU2Wfl/ggUJWsAqgrK4ZJsx1FNAXaAZ43W9XeLFKnwXzv6EUwf1LZlcDcyVxV
	ygvL/lhzoPMqp6bq+NBzOV6/sjWr7zONMPfP7WOGR+vKdB5s+sEXRDmL/fO+vcv7VKYs+2beneD
	bbqJr40wb/IrJ6FuQCstik7Jly2VleR77ILypUnSTIeD8547pEssBO/x75ZhblNIF6xWfZdv7U5
	XAZp5VvhQokQJPhGB/1dcIGNw57cwPhfXa8JHmCAMCQ9eLaCjlbnj/6e6sG2M5Cp/9QV0kmSNCK
	Ow/FetaSUqK5xfc6Um/waV/xqFZK/37txES60wn1voJi9A==
X-Google-Smtp-Source: AGHT+IEZ3U5D/EEyRNJJA0h121CkODT3waTKE0XhCx7gpizhS9Xryu5e5ySB2/sFUv+P+fwP9Vnchg==
X-Received: by 2002:a05:600c:1e20:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-43f1ed6727bmr189225e9.30.1744134553902;
        Tue, 08 Apr 2025 10:49:13 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:5b45:5642:beb0:688f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16a5776sm173535645e9.22.2025.04.08.10.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:49:13 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 RESEND] wifi: mt76: mt7996: prevent uninit return in mt7996_mac_sta_add_links
Date: Tue,  8 Apr 2025 18:48:58 +0100
Message-Id: <20250408174858.15847-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If link_conf_dereference_protected() or mt7996_vif_link()
or link_sta_dereference_protected() fail the code jumps to
the error_unlink label and returns ret which is uninitialised.

Fix this by setting err before jumping to error_unlink.
 
Fixes: c7e4fc362443 ("wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support")
Fixes: dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
v2:
- Added missing semi-colon as pointed out by Jonas Gorski

 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..70823bbb165c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			continue;
 
 		link_conf = link_conf_dereference_protected(vif, link_id);
-		if (!link_conf)
+		if (!link_conf) {
+			err = -EINVAL;
 			goto error_unlink;
+		}
 
 		link = mt7996_vif_link(dev, vif, link_id);
-		if (!link)
+		if (!link) {
+			err = -EINVAL;
 			goto error_unlink;
+		}
 
 		link_sta = link_sta_dereference_protected(sta, link_id);
-		if (!link_sta)
+		if (!link_sta) {
+			err = -EINVAL;
 			goto error_unlink;
+		}
 
 		err = mt7996_mac_sta_init_link(dev, link_conf, link_sta, link,
 					       link_id);
-- 
2.39.5


