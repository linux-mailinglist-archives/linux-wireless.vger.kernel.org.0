Return-Path: <linux-wireless+bounces-30964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEECD3AE0E
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 16:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A37203015D1F
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2324DCE2;
	Mon, 19 Jan 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF2tbxDF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932F236437
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834942; cv=none; b=YGqz3u4UoOThV+OvDQAtT79fc5pbyQFTHIqnW6tCcraBun320KvShrt2/YRpvGvSlytzRpAq7T1XAu2sLrsNI2EBbFSkIpzTLOY8dkHMAZCyFgSe1rpQvgnv5lM/MIcOjjVP7mZGPOrW+bKDvxDxSc3FJk/x0mepewtm+wG3dv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834942; c=relaxed/simple;
	bh=wrAT/lEhlnWwL8fYoCsLcee6O3Keh9ygy4iM5CbPKa8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pNgUGNQJefvdW6rjQivk1scJdRU6Z5p26CE9hnHywfBXDipPxb+4RfARBsaeqE7awCut7FlQJN4HIIwK87+2NaqXm9qV9IDGqziTeIG1UsFLQiZ/NAzF/RA5KrIeOALW9gZPKqjVcbe6yfAWvKinOlZdqjjgYgW1vLCHQxoE2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF2tbxDF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81f3c14027cso2439607b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 07:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768834940; x=1769439740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjWkkL0QqpjKgpegJJRn2GYbkZbwHPk+VOJTJw6SS9A=;
        b=QF2tbxDFhL+DcKFCas1naeqA+/kgSneP15wac+0yms5994jL15Kt0sCGnGfZbPCRJa
         h5fLO9+vzbZt5EIgoC2WcurG+7FGfcwGz8SoUiXtmMsngAkgKWJVpk0ZDCfDTnX3dsVf
         o4cgrZcIQqPHpPh+TN474oOzCI04GZXNjwZPPje81xuW6tdlucrba3qd3VqcKWkJQ+86
         GFGF1y7Zhtbkqf01RCFX7ldY1BBj8Iaia7IpAgq9M12qSbRhQJ8917KLsbujkm3MIAOT
         NVx5RiyUpVRWjA+TWtSDw8CEdJJuV9zIR9TAGyb/nVad7o7ctA8IifUEyiAThV/Ict0V
         qibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768834940; x=1769439740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjWkkL0QqpjKgpegJJRn2GYbkZbwHPk+VOJTJw6SS9A=;
        b=irrqpCBt/B42NjSHetYdR7DFb6foKGxuguQ3iGxCXWHHS2wZZdjOIv9uPhweL1P++a
         OxtK4FzzhBYUSdqlbJDLWNUYuSWhH12+i6kSiSeLIdiTY/xG3eTMKcUpRVHAwVWfBJXS
         lUvV0vpADjQRKgbQVXXsfTIkPyqVyhFSpd7VU6/hv2WP7T8gGxIa1jzjkTErQ7tCdYZb
         /+Wgezixkdk8WDwdOdDYpN2MAGTduwAqnzkE8FnNEkKGu34xJ41imxXRHuUaXTyb5WhM
         HJ/fG4HgT7DtFdQTpvINfm3nBf/tMLmol60ywXn8vGClgyA1P5eTHELVyg3M+ygB35xn
         On5Q==
X-Gm-Message-State: AOJu0Yw/Nvt/TFfhWPfx4xZvunu34hbrUnYU8e3bttY2dyDIBrQVNyTS
	4zYcD7Evlh7hvZdLcPLSSAJIV6j9HSuwC18BBsVtQO/p+FsQ8d9H555y
X-Gm-Gg: AY/fxX4ueEBGu5Mqvtv6BPhDhv5bCYWrG9JBf7M9r4nWOb9d+oZxo1wbx5E6qdyQYbl
	77GIWTWf3xnRxEBU2a9jaGrIYw3fWvUKYvt+evg6i3TN5VKt8DeKWOZ2H9+8kIqkktFFTcNJSvt
	Rsy8wEQtrEKDg69mHt7BgsFAUEsjVP1NxVq+q2xSMdNn6Qoo0wPIAiNmFknDDGRUelQkdZxdG7b
	0RSqpQJYSCN08agBHdGSQ2CHYBNJloqKCUiClQ9HqtUIR9RqW7HjIqhigQbkIarN7kEhzyQ9fB5
	+qrDxXsvQ0ne6Eryl3witMUVHOAJFtaHG+mO426A/q3HOf+0Ntg0IWe2vEgT/fpkQ1MAZZ8mxz0
	1WFuDrDYZmyTTN5NKVQfVKJRCBxuZStc8EEIPR9H3rj3IfNQvCn8mFY9vJB4Nhdkd14i8nMwCOd
	yr+4gcQc81WZ9o+q/2i//Eh/nLZqtAt/Fo/L0QVw==
X-Received: by 2002:a05:6a00:6b83:20b0:81f:b6bf:e6dd with SMTP id d2e1a72fcca58-81fb6bfebb1mr5103454b3a.13.1768834939956;
        Mon, 19 Jan 2026 07:02:19 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa129199dsm9503402b3a.51.2026.01.19.07.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 07:02:19 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	syzbot+81cd9dc1596563141d19@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] wifi: mac80211: fix NULL pointer dereference in ieee80211_mesh_build_beacon()
Date: Tue, 20 Jan 2026 00:00:31 +0900
Message-Id: <20260119150031.201832-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NULL pointer dereference bug occurs because ieee80211_mesh_build_beacon()
does not check the return value of ieee80211_get_sband().

Therefore, we need to add a return value check to prevent this.

Reported-by: syzbot+81cd9dc1596563141d19@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/696e34bf.a70a0220.34546f.04ad.GAE@google.com/
Fixes: 147ceae20534 ("wifi: mac80211: simplify adding supported rates")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/mac80211/mesh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 68901f1def0d..eb3a346226bd 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -964,6 +964,8 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	sdata = container_of(ifmsh, struct ieee80211_sub_if_data, u.mesh);
 
 	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
 
 	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata);
 	ie_len_eht_cap = ieee80211_ie_len_eht_cap(sdata);
--

