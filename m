Return-Path: <linux-wireless+bounces-17660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484EDA15669
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D743AA498
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 18:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7A1A23A8;
	Fri, 17 Jan 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqTWyYwF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A01537AC
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137998; cv=none; b=LzfW2uOgzlDOM8HPVVJG6/vyAsxGK9wa+WATQC4TdzIIOGpqwK6CuZj4LQqlYHryqjk5Iv8oCjw2ykCgBY4oGRIytm7NDlBHNSVMeb+9i87KZFw0nPFNOyFvu553N1eWOBRxJuMYWIMZweuc+oRwAcz2kc/AO83v4t/oaH0ImLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137998; c=relaxed/simple;
	bh=YAqm3nNyjxW7mEKEBFDv8wxs9JUUr6E+JEIkRaqiGZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dhw4dT1vvdB3R9hNhfP2asQT0GzdV55qNJsyIZijb9xDck74kFnoMjjYwoItUAXmKOk+QjdqJJVRIVkdtQRiXH9y4TB6gPNcQj37PhrEUWIzy3dL4zjAQyn7vM+XBjX6h3ZxaO267sPbyz+3tyWE9dJuDweuXcZtBPyWGi7hwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqTWyYwF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436a39e4891so16480415e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 10:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737137995; x=1737742795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3PDbKZO2d8iac2bLYbqddv/S8yyo5fpqub3QNHLQdY=;
        b=OqTWyYwFNq3VWvvFlnFLc5NtN/8nQ5rIikST/Th/huNCLvcn8J56TZ8zrOldKDOnTC
         ll8QF1I+HqOXrp9Yg0/ARVa6o7eo5Fe+a+i5PcCOeUsE/i/KqAijIFOqaNZccI5f7wak
         hMCu00EGNU3f/mPAM4JjyChVClRMjjIBnAf1O6LeEeHepARtrgQJgrmnVavrzQrkKKqS
         ukFGDHGUNUDLWbuvNmGS8vpFmOsmjpYBaAqJD3+pSquZruNdX9q7EYzY3Msr36x/WZ39
         HqgJas4eGXgy5nOEyyv/7+wxXKNAUdTWNWaBM4lt1f+NgE7v06UF1EUWtJQzreARw3f4
         fX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737137995; x=1737742795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3PDbKZO2d8iac2bLYbqddv/S8yyo5fpqub3QNHLQdY=;
        b=jnI5CZvA0S4Dk68iPwqfeySDbKxK6oY0eKnyNQG9EA7Yaaz9U5XuMYs1NAQ8tkvzSz
         sF2w1LC7vdslIOY3bbBCzUpNi5bHLm3cZfGYCOKQoPmy+8Mg8ESQ6X1ltChb21p27O2O
         i1vgpKFZy/m+64Rx5RP1fObF/KhPTaM3YELApqyFhbE3dVGFkqrf8SzRGnsxotEHUftD
         +r31sduf8G4QOfi0htam92LE0LiJv8iQNHQLexJg/tNqr9iLmc5KFkVO6e+ezxNYHrJ4
         RaVfNFoNNPVSdQ/61sBidBJwScTCfbltZmFktiaXyYuelKMrA+lhn6rj80FOlQiaRA4S
         s9NA==
X-Gm-Message-State: AOJu0Ywx4zJIjEBFxcNtlVoIYd+tupueuQhIpWfpMoAcX2xl1rwzAnvL
	2DC/TzeAQVRClbR07Zxpl1FHQXfX1Becni+xazwM5iOoN4qX1SB3u1zA2w==
X-Gm-Gg: ASbGncsGOh5eyWWwA2bs+Cmx3698RcmF/fALC0lxWjp9yQrMHMUWpzliN9jyMlNVv+u
	EJXE8LSdSqe5mWYPwXFWheK2mazb70GHI0f8IAxy/ZNQ4TKpqFYvwkzRaMtvSieuJwJN7dWuKLf
	lhCSHvgdOmqW07Cs7eF7JRJjFh0Ck5KsrhICeZrfh2whG0PS3y3LFj8phgdaBH8G5tzGAxUGHhs
	ShQLdLitVdkAjepe/0sz2TuYmdF82CI8DydN7GYG7hPXWP2DdbPfQP65ony4dYjwwaU+uiDqLhx
	/IlnV+U72qmnVA==
X-Google-Smtp-Source: AGHT+IF3jWrhX7mBjcIuTnT9DshqYP+3K1MQpYxZmnywckA0wpGyMN/VQHbvuDFnHs2Zz4oi18mhBg==
X-Received: by 2002:a05:600c:450d:b0:436:840b:261c with SMTP id 5b1f17b1804b1-438914340afmr34506845e9.19.1737137994804;
        Fri, 17 Jan 2025 10:19:54 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753caf3sm99236025e9.38.2025.01.17.10.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 10:19:54 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath11k: remove peer extra rssi update
Date: Fri, 17 Jan 2025 19:19:53 +0100
Message-ID: <20250117181953.3375273-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b205ce4c266c (ath11k: support avg signal in station dump) added an
extra assignment of arsta->rssi_comb in ath11k_dp_rx_update_peer_stats
when it added the average rssi support. So lets keeps only one by removing
the legacy assignment so the two statements about rssi stay next to each
other. Compile tested only.

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 029ecf51c9efd..24774cba9823b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2831,8 +2831,6 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 	rx_stats->dcm_count += ppdu_info->dcm;
 	rx_stats->ru_alloc_cnt[ppdu_info->ru_alloc] += num_msdu;
 
-	arsta->rssi_comb = ppdu_info->rssi_comb;
-
 	BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
 			     ARRAY_SIZE(ppdu_info->rssi_chain_pri20));
 
-- 
2.48.0


