Return-Path: <linux-wireless+bounces-30421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30864CFC494
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 08:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F001D300FE31
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 07:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E973225A3B;
	Wed,  7 Jan 2026 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJZnQrn9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E71F63CD
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769821; cv=none; b=thsjvp6zet5COiCZikuBDIbUbdUBlCyXni3cBouX9mMBuYzmW9LjD7BtMIaPAAut6/GX25v0HdDH5FMa7Ed0lDflMD0qlbWzh4YeIZ8K4ObcL0htmXGo0wvkNLxjpSpdG1Ev1+iC17SgeYHp9J0jKodVRNj7wFBWtYZMxN95ltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769821; c=relaxed/simple;
	bh=LU2Voa03VkzUwZX9vOFZxVmW18w/dzJM2emLQZVtjvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bez8YjRP/l0U1tt4Eow3QB+e27N7cr+D39JmCwKFvMD2Gv5EkiDGDod9zFEqILEkc1aRKhlVKAlmYzkZSQkIyqGon9oZqZKde/BkFeI2yXbgF7Wv8PFFme65a2Jarn7T1DL4Xtcj7+HondhTTff1Wye1+rTAw7/0IRRjOoictJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJZnQrn9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so1109113b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 23:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767769819; x=1768374619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UY8e66H6OsSyRkR5Mv0ekoBF1txUXmREvLtVHZOR7r8=;
        b=AJZnQrn9pbfTOiJPNPMz238oPoDaoF21fTfDknpc7dH5cdlbxXISxQhtX9Ux4Czz8I
         X3VSAQGQEU1jKNIoyhlwqAGEuoNWqRQmKLvMkgGsoebFcK/oiglnk1X/+AiAMONK78X8
         D9gAXvUifYe9RNxsHSoKO1Nlz8BrOrPVpcDjAXs6+mteVT9FtxYEyjfzXQstKTWVsfN6
         IZpQCZYvBwRJf65iPR1aInTJyBY/eVZ32avRg3HZFDMUqTLBm1g+RXb4w/RpZIWAnw5t
         jCFkz4xR8hW3h1lxjBXW94ysmnjJf/FT1azVRolKoN5L5/HBlP6Oa1osMUzY6hR1OWk+
         ESxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767769819; x=1768374619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY8e66H6OsSyRkR5Mv0ekoBF1txUXmREvLtVHZOR7r8=;
        b=M7H6cgyCY9e1W/oSNCekE3ci2iWOKGZxOv143fakJpwbIup3mG1VPtR9wKE8F+U2+R
         0+dUMpRK7kj/35ZpfcIfIPkr8vY0yvEH5sm0VhSNDLs+MjhQhj6ctBvwpPyfZzq+3XNv
         r6LjNv8ZxGPdeUfGkxxgSI+sTwHGTyopg6GmCTSjH9hhHLZEtUI4BARdQUVvbx8IUftg
         45boFQa73PG06DlGfIrmZl5PaSytwSD+n3eI/gUWLG9iYIwARzWb8c/34tA9OQzjr44z
         V7Pk/nZvzRM5bs35Zm+1NnTg4Y2L37PShJBksM5dErh0h75NdlhrZ00QWvY8uZ278/GE
         rI/g==
X-Gm-Message-State: AOJu0YxElb8k+Ik9RYzreyWDjKc0h/C5tQp/yNZzo/Fq0rZL0o8w0Wd7
	YI8Kvlgi3MpzsMk3cguhA0e2ztY0pTuKkTfZzF4uQBU2PWi+5jiSQA/u
X-Gm-Gg: AY/fxX4jMGM+dm4Dj4w+4oTxqhXu2gGMZY7DlWSfS6jnEgMoYtBvhN/Rhkg7RJVlrIX
	zDwInEWtvB3wYmveNk28uwy+ieEnyPcXbWAaHxYrfm+GDXXD+vVxq3G4bNEJOx/E55A52QpHxSx
	y9rGPALnIiJbBqmscjLrfPp68FuFfqRaFn7WMU6bMA+nHe2CeA70MFgn3Y1+cUDJH+AnpGym/6u
	xE6SGN/XKazbOjL0dxjq+5HdPFE2/cEQSAVDFlFneZ2Lgk59zjsS40hahfqgAWeTR2S+wlXSakH
	BvWp5voL5NgEjzzvLfJhAXs3YHAoZsqgbzHXdJ2BLACBOlXojfcXKY8KQW1J8KTKHyT0fxlKv0Z
	Vnsb1a0nW8X6KUO5U3yz9g3Cp/LB11URIxPChBdNJURKAmS5P1ExfCqFZbN6zLwUKD9qctP8=
X-Google-Smtp-Source: AGHT+IG5ItTnNq4tILfoyom2Ei5YIEcdCIqNrLivJ5YAUKkolU35Bm2FigETroRO01as2j1PQQKrEw==
X-Received: by 2002:a05:6300:210c:b0:342:1265:158f with SMTP id adf61e73a8af0-3898f99b23bmr1376081637.51.1767769819069;
        Tue, 06 Jan 2026 23:10:19 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:0:a77:18ea])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f8952sm3973858b3a.39.2026.01.06.23.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:10:18 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: stf_xl@wp.pl
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] iwlegacy: 3945-rs: fix possible null-pointer dereferences in il3945_rs_get_rate()
Date: Wed,  7 Jan 2026 15:10:01 +0800
Message-ID: <20260107071001.172132-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this function, il_sta is assigned to rs_sta, and rs_sta is dereferenced
at several points. If il_sta is NULL, this can lead to null-pointer
dereferences. To fix this issue, add an early check for il_sta and return
if it is NULL, consistent with the handling in il3945_rs_tx_status().

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/net/wireless/intel/iwlegacy/3945-rs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
index 1826c37c090c..c13268093a6e 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
@@ -626,8 +626,13 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
 
 	D_RATE("enter\n");
 
+	if (!il_sta) {
+		D_RATE("leave: No STA il data available!\n");
+		return;
+	}
+
 	/* Treat uninitialized rate scaling data same as non-existing. */
-	if (rs_sta && !rs_sta->il) {
+	if (!rs_sta->il) {
 		D_RATE("Rate scaling information not initialized yet.\n");
 		il_sta = NULL;
 	}
-- 
2.43.0


