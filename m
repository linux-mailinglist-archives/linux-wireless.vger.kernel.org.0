Return-Path: <linux-wireless+bounces-20620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE1A6AF0E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 21:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B6B46622B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCB7207DE2;
	Thu, 20 Mar 2025 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPxA/42d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626CB2248BE;
	Thu, 20 Mar 2025 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501993; cv=none; b=PM/DIWVDE3+lB+ZG0lEPm/NUGlj5pS+dvW12FBkJ3ijV2lL3EjlL+0uAxDl5bfWHmzEOhxmKKocpec5/v/q/XlLNhrY0Q8qKr/CVQ5R0o3PuIXZbT6M0BWnnP+dbonAyu0LzjCluK9g5dCepKtlfRLibf0UGCWgSAIuBjdDxaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501993; c=relaxed/simple;
	bh=NCcf7Blmaus57gScMFkNJhhaDKWWFy/KV3mEnna1L1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWT3VRYWt9E3fWcr3xXt7HIiLsaweta8yXyP/C7qVFqVWoKmpQuwbedaNoVHy+l3MGu3iNr43V1PCoud0Ozze9n6uD4rlv8NlW6df3d2A/9rOSLg0FxNTKn6H+uFtxu0QmKDCMCSzOpMkRzGC4LYsLIaIzzPt9q7zpeWgGBB2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPxA/42d; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390f5f48eafso713834f8f.0;
        Thu, 20 Mar 2025 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742501989; x=1743106789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhyguxhy3QF6ssQ6N4HmtB46ru/Kl2lPpRXSHmaJ/rA=;
        b=BPxA/42dqYQcwDXwjSt/jgPEYDQ3/4RStpN+WDJr8D8O9NHLc/ouS91uHLORGcAtWc
         Pv5cY94u2ufeg+pu0i48HMIi4hQXvz0erbTI6688zhqWDHmSRXWjP0hnYRtmnpCTmA2m
         O8oR3/txqh1PFxmoe2Tya9NOyVM2P/3dsTZKfeVTj4WwLS0+Y6e7UvN5Ro3q2RTH9SRK
         vO+zgwZYVPOiMWLgxu9YDEHB7djUBsv+PcHfgftIt5NoT3EMeZ7LLg3DxnSLpAlPt4Er
         55D/a4moQY+64DiKBWRP4njD8dVyp0JFJ9xy9iYmQlBctgJTByHCkl8YnVHMySCTe2TX
         P3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742501989; x=1743106789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dhyguxhy3QF6ssQ6N4HmtB46ru/Kl2lPpRXSHmaJ/rA=;
        b=nkb/WuO7N5MoMzssCLNjEgPAOs2UlbT2MNQ71s0q6VpeEYTlRbFaqlBJeX/gJiG9zo
         Vt6t/+lyNhQSHK+KZXx+Gu1ILWrdjI68TH3DYexSP3Dx5paW09eO2aCpCKvVEDcX9stF
         hUA668oM10ywBXtrVd2Es+qWoABkjcZWop4ZmPanzWWc0gibN9lMDHNJ+6OZh5KfGv2L
         lD8U1FgDnPQI1k3OtDtLuR5MW/qmbLgN3EULT/WSrdLN3pjwzT0cBk1oj4tEPM5cQ9JF
         GJIBDThWzqiaUOHptV2++azatiVTCOzgcL5xgG448jHSmA9yPsBMNkh6mO8z+x4KZJ24
         Mw4w==
X-Forwarded-Encrypted: i=1; AJvYcCWqg3R3WzwcaOLbOBhuytMUTjpgD9xnNLGFXeYKqXDUCbIuaksospjEgWLllYI8DdrFsxW+8MpVZn17reY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7mn0oo6oj26lbFDEZZzEC9KUfplTkAqRQxJ6YsnYNjAUXpKiI
	xF+/dywRY1BF/vfY5y8mVCnOni+E5WMY4BqT4ErqLiB/ECv8JZm+
X-Gm-Gg: ASbGncvIUUlx4dWJnL2GDRbQkmYAxtKSSaz0NGkAdFrixW2XNYaBbitxUDxLutvg64X
	GFI1JGjThN8NkQbzwTnwx5gGXVnpoK8Hg9SsdbRwUBOl7a5D6wHBERZHuF9rgotFvUSIaZrLgCJ
	qXWOmgBy+bIbCqFgAPwOBH6QyQ+RlSEH8Fyut1y2YVAajA9A0aUTiIIuo8JZpd9or6vJC5A6piH
	1sirZize81Ikk0CD7yCCW4s7bwlJzmdfYZURQs8n6p97CyWHkp3lHFA2vvylRA7iYZxRTpNdMCu
	R8vgsYHJrDKAJujgJA4CAW7UhB5Tqv6IUn1PjO7lpKRXLw==
X-Google-Smtp-Source: AGHT+IE/btzueE8JU/eAqEkp1q9M1cbr7FO2mpWZMkpMLSmIZhDdqe7dSjJh7OehvrSNgBvLJbC84A==
X-Received: by 2002:a05:6000:1566:b0:38f:451b:653c with SMTP id ffacd0b85a97d-3997f8edadamr632159f8f.7.1742501989262;
        Thu, 20 Mar 2025 13:19:49 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:a534:f4c9:f77d:6a2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd1c7sm6948465e9.40.2025.03.20.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:19:48 -0700 (PDT)
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
	linux-mediatek@lists.infradead.org,
	Qasim Ijaz <qasdev00@gmail.com>
Subject: [PATCH] wifi: mt76: mt7996: prevent uninit return in mt7996_mac_sta_add_links
Date: Thu, 20 Mar 2025 20:19:14 +0000
Message-Id: <20250320201914.48159-1-qasdev00@gmail.com>
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
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..78f7f1fc867e 100644
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
+			err = -EINVAL
 			goto error_unlink;
+		}
 
 		err = mt7996_mac_sta_init_link(dev, link_conf, link_sta, link,
 					       link_id);
-- 
2.39.5


