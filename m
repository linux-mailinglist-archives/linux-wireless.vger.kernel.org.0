Return-Path: <linux-wireless+bounces-17249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A25A07D02
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 17:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D2188298C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF7A21A453;
	Thu,  9 Jan 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYLuaMhV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7C249E5
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439044; cv=none; b=oGBmYU3pMVHpAht7chnVrpuvpwKdCTKirJf1WeX83ddFjEqdP4jaZ8bStzNFdk5leqG8aof5uoW6DR+4rXMAz/ged+k715qfYTMRPp9ZJImuORjwdHkNxGJC8t69UldtUc9rLS26mRz4D8edqejtVq5NEYHslq8ebK1IHZVdhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439044; c=relaxed/simple;
	bh=RDhHniW/CXjanW0iT0xDqxd5JbTdEu/eQYU1ZNzk2fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lyz0pQHbloTTBLcFQguD+JOs1XvaNKnCqlmwKJpnwE6HO3k7dLjoYm6ebkwKmWKuAojFMAAt5kKsHBIlNqrsiYu4XJaucuG0KSsPaBZqiChKqpFp+H4eTssClPsyY0KYprk1DdX+7r3dnaJ8ELn6HgsSPzaJrHFu33XU9mZFzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYLuaMhV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a88ba968aso1031969f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 08:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736439041; x=1737043841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSvs1pDvXb7PmYj8N8p1SkM92km8+HLMTt2EExanCK4=;
        b=YYLuaMhVGk6Uwjicvk2dDIjzeSaVqI/0t36eToY+QVDbehkWBTD+uV3JjrGbeMwJDt
         wt+/uChg1esAaN3xAMhrbzL/NM5FIFyErm3R36LfzB1EN1CLE22wB7op4EE9senBMp6o
         WokEhxm9BZkAzvyLMrUT0G6uYJN1s28vV20F8/fTdiXQk6A8cfCpiY5A79lU986jR0/g
         qSMHPoqp/LnfiizFD76e4rS5Xg/J9JeiQe/Z+ngEjwB96leIPXfk2TMBmcgNggazV6To
         YlR04NBNbSsdrYScyPHkI0lWS/vsFOmVzlH2XIhI8w/nm42PyA1Rk3sgXZxFvGtLOLgV
         RhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736439041; x=1737043841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSvs1pDvXb7PmYj8N8p1SkM92km8+HLMTt2EExanCK4=;
        b=Ss6zJkH2pQiwG3uug6DgH5ZW3tm51cqDQ2B6Nq0Igdr88BJ8KtjoQm9iFwOYpQ+lnQ
         SLSYHcQtDdQXTNgfwQS13OpfeJDPYpDfIzT7huUVXexvZu2FmNVPON/iYTmbYBNw0Xk6
         ZydVfc62sGd8jCVyG9DXH1S2S/9la5AvOMwd70i4PnkPAsDTeA6EXohTYLAx7B8s7ABj
         TtUsqm+EDGAL/4fWEEbLODvWpc6eWj87SPqfKlNPZCeab7nfDOoEC5n3mBrsuGc8VTsm
         oeMLUU/FyX7G4kwwgwZa/kAAiUIhx6uZarUPGfws4bu4rLewUpEzuL5jyCUpTUwK0yZR
         1g0w==
X-Gm-Message-State: AOJu0Yy/FoWqsFGOd5e9t5J8ybUrvPqxhEP2FQKk8L0teYM+OfFnPpi+
	R6z3Q6XNTJGzQu7rLflDp/SEpQ55bloFImo5r8y5ExG0JKdOSh5JLcaIkg==
X-Gm-Gg: ASbGnct3BKH+1h6vIb9pY73dwmEnkCIRSJ9wUlFG5/eRyB6mz8v5PLFpIdPE8sxoRx+
	IgyKDvac0u7LoZgoK/5RpaCuFTXSPuW55VmD+K0Hl8is6ODniJq1sUEwi2eIy8Fmu7n7wYdg5oT
	b+ASIok27uR17d6AQHw2GhnMMsRBIha+UPYjsvicWLTSV8Zk5w4KaXhF1EoGnPI+TiIb/luhUTE
	u8+B5ghV0/lJpxFvZmb15mCTxYFweQiMD73zztQqZ1hDxcng1iXjd3oF/5j8xCfNEUDhiDcTTlZ
	6Y0c8/s0f+MI/A==
X-Google-Smtp-Source: AGHT+IGO+lZW2zaoqPc1DF1Air7fYBCwXW42HfOX2NYLUe+rDnKH8XAe1smMC92OJXdTX33F/WB8lQ==
X-Received: by 2002:a05:6000:470d:b0:382:4ab4:b3e5 with SMTP id ffacd0b85a97d-38a87087028mr7759697f8f.0.1736439041229;
        Thu, 09 Jan 2025 08:10:41 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b80besm2157970f8f.83.2025.01.09.08.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 08:10:40 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes.berg@intel.com,
	mbizon@freebox.fr
Subject: [PATCH] wifi: nl80211: fix nl80211_start_radar_detection return value
Date: Thu,  9 Jan 2025 17:10:40 +0100
Message-ID: <20250109161040.325742-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the wiphy_guard changes, rdev_start_radar_detection's return value
in nl80211_start_radar_detection is ignored and we always returned 0.

Fixes: f42d22d3f796 ("wifi: cfg80211: define and use wiphy guard")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 net/wireless/nl80211.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8789d8b73f0f..605433a1b0f0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10141,25 +10141,26 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 
 	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms,
 					 link_id);
-	if (!err) {
-		switch (wdev->iftype) {
-		case NL80211_IFTYPE_AP:
-		case NL80211_IFTYPE_P2P_GO:
-			wdev->links[0].ap.chandef = chandef;
-			break;
-		case NL80211_IFTYPE_ADHOC:
-			wdev->u.ibss.chandef = chandef;
-			break;
-		case NL80211_IFTYPE_MESH_POINT:
-			wdev->u.mesh.chandef = chandef;
-			break;
-		default:
-			break;
-		}
-		wdev->links[link_id].cac_started = true;
-		wdev->links[link_id].cac_start_time = jiffies;
-		wdev->links[link_id].cac_time_ms = cac_time_ms;
+	if (err)
+		return err;
+
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		wdev->links[0].ap.chandef = chandef;
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		wdev->u.ibss.chandef = chandef;
+		break;
+	case NL80211_IFTYPE_MESH_POINT:
+		wdev->u.mesh.chandef = chandef;
+		break;
+	default:
+		break;
 	}
+	wdev->links[link_id].cac_started = true;
+	wdev->links[link_id].cac_start_time = jiffies;
+	wdev->links[link_id].cac_time_ms = cac_time_ms;
 
 	return 0;
 }
-- 
2.47.1


