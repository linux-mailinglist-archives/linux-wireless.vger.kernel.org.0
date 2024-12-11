Return-Path: <linux-wireless+bounces-16222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652129EC173
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78CB284F83
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D851178CC8;
	Wed, 11 Dec 2024 01:20:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F6175D29
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880028; cv=none; b=DA0ePB+Zeu0oIwOk6uenUxGLps+BKPsopK2mZyFKL8gFLfRwb3e3HjDY2iIrewqo7uDY7lbQuBBBNlnWY71D0KwEm+mJG86BKgLzhdqJLRWALeXeDvANXMRpSRVcU+8mzt+lRDJAnz8O2Sr3XykQFAIegHeGDmzob1PuAqx+TCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880028; c=relaxed/simple;
	bh=oAQXu85edx6ZFlDR0EZowb7+o9vXF2s/tU27/RQ9VFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fip43cTFYpR8m2jJFOBuGtG6VH8aGfQ19c9qvk32A6J1EJ9Dp46q/tAfqkKcDmq5Q3uS69tJjp4+Gk0KSrANKBGiHMdILR7IE5ZesIx5/KZGSRSK0IPVqrJRal7jDExaEBXp1MMvIy/FyJgCS45mX8lb522uG/1522WOJJexuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb569ec0d9so793608b6e.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880026; x=1734484826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sCOLPelO32qVuyU8xDyaBPcPYTcYPDXfN9EW5NAA6Y=;
        b=fDv2KJU88uYaXvoiI306aBZcNAad1DhWKOwoxJZb7LRcFanD0U5n/6R5SfFfq3VolO
         16ihc+fmOPlRpYGancsU4vmxAY8TmjQVH3AGQSpwg7VcWkg53GqVF/EQJvCa8vBLL8Vi
         ZQt4hGO02jCUcWGNGXoUOZ1B72E+IxMopJkyx1qE0XxUQe7/Rl7g4QdmLnOAgL06gT8G
         VwjECsTBFKUmzZRtMtwWE66TXUJ2fAFpVECTVZVx988DlxKV2hFsvJYZrs3u+0t1C4y1
         FEyPaTjkeZBca450w1jp0xRuACJc1cBLReGL1zNZ0mXJNDmi6y+Eu+Zq7yHLz9ZnAXFf
         +5WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsCWQp9ZYeZYC7bI+Sb5+MgPuqG9ImM7xTVnEKHjyUIsNmyD8n2FZImBV1wS5UQ8rS7+1Ri+PlzS0tYdhu1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yRCV/MmdkR4hHLGt2XCKiyCFsbNKUEi9do1Tb4kaaS/zQaDd
	M80V08xt8Chh7VcLmokaskPMbVqhcZBNWtJJ73jwlJ03rAebTyAH
X-Gm-Gg: ASbGncsTi03SJfoekflmrP1U47UP6tQ3hS+hmbuhgJQXA+ojqYQNINmnAR8N7J8F5Aw
	6LRW/txMHJtbhvjyXhkThGUIFXvZNO+gp0a8UeCnNOxGqjrVoeyGjw7lXJSva+zr9O01jxbyRzK
	MKVRY/ZK/oDP4+Dc+d6ROiWCv1GMEUIs00mby6hUTMUmvOf6O0ysOEIcAfgQr5s33yMSQJamFWT
	+5RpMMBJwFF6vJBqo5B8ZLD+JKcC3OW98VG83wZGET+o3VjUNqMungcipCuuzL9tBV+OM4=
X-Google-Smtp-Source: AGHT+IG8GhzuwchpKQMFJgrUxyXInhFmPd8FCXfE2Y/ubZ3c+ERwZS6Wcs+IRVz6tFSwIZGIH1lR/Q==
X-Received: by 2002:a05:6871:821:b0:29e:3132:5897 with SMTP id 586e51a60fabf-2a012d35af8mr656068fac.5.1733880026039;
        Tue, 10 Dec 2024 17:20:26 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:25 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 14/17] wifi: mt76: mt7925: Init secondary link PM state
Date: Tue, 10 Dec 2024 17:19:23 -0800
Message-Id: <20241211011926.5002-14-sean.wang@kernel.org>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Initialize secondary link PM state.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index f2a0159be9c1..6b2b91a0475e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1989,6 +1989,8 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			goto free;
 
 		if (mconf != &mvif->bss_conf) {
+			mt7925_mcu_set_bss_pm(dev, link_conf, true);
+
 			err = mt7925_set_mlo_roc(phy, &mvif->bss_conf,
 						 vif->active_links);
 			if (err < 0)
-- 
2.25.1


