Return-Path: <linux-wireless+bounces-13337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D6698AC65
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 20:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326DB1F212A0
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 18:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DB8198850;
	Mon, 30 Sep 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmF8h6vb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F2192D7F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722305; cv=none; b=ThpqRcHWwrRfxrePQ1UCCHO4Ina0LNHi1T2hb6jaUTCUdSpfEVA5nBgZGDIi1IXgIEJAMq6aNMwP7zvWQp1frn/PbxzGOrbwEBH/NJ/e+8eESXDQgOdePuXlMopLBm0kR3ZiTXJcxcIiOoXxjT27qBmAITsUx2H28ULriDe9Dmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722305; c=relaxed/simple;
	bh=cUAi0qGFVGcvkKXox3GBAlzslHDn7OzV2Cz4Uo78FsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ECUPEEzNzvSSWxtBoGJroxB4y2LUUWOVLjfFlQ1t2Icr+T0aep6FwQpIcmwObzUmEcFeTbZ8myy0Xm8xy713PPDHIb6feb86Ykg+t8odQdREGx/QxkUi811Vz5tlMo21+6FP/aDv7qCh6DvaY30zLKk49/VmMij58CAlFT71yKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmF8h6vb; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-4a39f7c43a6so1136379137.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727722303; x=1728327103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0PaNusqGE2si3Oije7SU9i4UfymiLLT2bES5lFJf/k=;
        b=HmF8h6vb2Zm2NkR4qaG9kdjUxQSLAWY2VqCya8a+RloT8Mj1TKXlGszNcg2JlArTkJ
         U+bZKCG2t/FqmA2TkPGoZpiywZYNRyunL3kL/B0+qzmTLlwc+591oKFRi+A/WmSCAgUU
         9MA7wGZR3k2vo2FaX+TZsRxCXuOesmbNkg5riXjBp6LQKGUfsmL3x/tm1wg22lPjn7x0
         7hvNVWQeVA9JPyVI794yTB2gJebFImofnUHOOHlR+UKeIlv7NeMHYrKTMhfOsNW5fFp2
         6plfFmUx4SNxf18a8dW5hahk4KQlcRRQKtfe5ODZlP33MZJ6lxSrmwf9Q4E8PVQ9gwFL
         9yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722303; x=1728327103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0PaNusqGE2si3Oije7SU9i4UfymiLLT2bES5lFJf/k=;
        b=gl1qgtsSf39iZjKEIgxsCjPaSCZvVBdRMB3x/q4ko4hV2MOj5WtnnYAen1ovC7cIaO
         N9wjgo3dLfuklT6mdG3/kEkKdlXb//I/bl7M48wLA8Tyuvn1wXfhu4hQMja33hICyL7L
         xeCGsmEf19EwMRRQXH3Z6KL7rF6vfX7d9RWtEQQ25qXAqdE+qhSYYefJyw9fWpxZlqPc
         Rnot7pDkvs8/x2U7rr0xYwMo1qygnVS8bfGhb68GIxiZXcCyDFCZ+S9hyEGdIqoh1b26
         PE+wEEWGSzoWl3QmDoQXLHuV6AWyQPpF9uw0FLwTJHw2AgvxfmUAlHf1PwutQeK7fKCi
         NKcQ==
X-Gm-Message-State: AOJu0Yxvim4sq3vHBxFLoScHqAsNplZp1o12oSGzO5kUZKiEbatR2WvJ
	LW3ZS8NX2r2R6tZzSGUWia2LXH9uXqcpLXxyjlc4RSLztvzMAmWT
X-Google-Smtp-Source: AGHT+IGId7XNVJc7sViiSTjIxrYxUC12U3qepFT8bzCTMrqQ08yYNE8/Ft8iBGUof8oOt/sYIVQq+A==
X-Received: by 2002:a05:6102:441c:b0:4a3:b777:3613 with SMTP id ada2fe7eead31-4a3b7773654mr3147503137.27.1727722302826;
        Mon, 30 Sep 2024 11:51:42 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f3394aasm38337191cf.64.2024.09.30.11.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:51:42 -0700 (PDT)
From: Gax-c <zichenxie0106@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Gax-c <zichenxie0106@gmail.com>,
	Zijie Zhao <zzjas98@gmail.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] mt76: mt7925: main.c: Avoid possible NULL Pointer Dereference in mt7925_change_vif_links()
Date: Mon, 30 Sep 2024 13:51:04 -0500
Message-Id: <20240930185104.19107-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'mconf = devm_kzalloc()' and 'mlink = devm_kzalloc()' may return NULL.
NULL Pointer Dereference may be triggered in the statement 'mconf->link_id = link_id;' below.
Add a null check for the returned pointer.

Fixes: 69acd6d910b0 ("wifi: mt76: mt7925: add mt7925_change_vif_links")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Reported-by: Zichen Xie <zichenxie0106@gmail.com>
Reported-by: Zijie Zhao <zzjas98@gmail.com>
Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 791c8b00e112..ea635169497f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1948,6 +1948,12 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 					     GFP_KERNEL);
 		}
 
+		if (!mconf || !mlink) {
+			err = -ENOMEM;
+			goto free;
+		}
+
+
 		mconfs[link_id] = mconf;
 		mlinks[link_id] = mlink;
 		mconf->link_id = link_id;
-- 
2.25.1


