Return-Path: <linux-wireless+bounces-28157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C833DBF8D0D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 22:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A73E4F2C58
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 20:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11032848A0;
	Tue, 21 Oct 2025 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9vSORIG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD1284684
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079922; cv=none; b=DpxPCRLvlbarZNkbHd65NqrBAGSEMQ3SrSW6rbL9A8MKob3CNcA9cRu00wkLA9IZPQcC6cdmT5Rsjon84Uvbfy1hGvp4Hv/+4y0QrLw3AJUr2aixJkE85ta7E8HJE2jzK3GOLPX1EewoZ31R/41fM7K/96RQpDkU9axLAl8a+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079922; c=relaxed/simple;
	bh=R+QG6MhvXu3xq8dTeh0N6uuhjElL893RdNz/Ga4K0bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4qqnGZ2PDQAUJriF8DLYV4eWCP07G+w74HZl+892qASlTEStYsyOg0W5bE3/P4JDZSlCM2Nr5QNjrsH1dqnrM6YsFd8LqcfuQEEhdBxHD2g8zp9ksnL49lX2quE0GlLp0a5BEtPhkDEHzk2B7fUKziORx64XS+u2SkAj9KGNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9vSORIG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso5443605b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079919; x=1761684719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqLomk0XJ6mMJ0399FGLK0f1IEBoFk1TbnIiBF5Ifg0=;
        b=S9vSORIG6KWAvNGGjaQv47MOb8AzlufYcdNe+SBXZyMrsRlRgX9TV+WcridcAx2Tkb
         +KC+8eu19vVRCUKX9ZDQM12fsqF64JPu8PUXfHt44kSGOsrDdV8XSJnyIgbvwkqm8Gtq
         cJ6JuSaDo4jG1RoB81cUjbElKZL2+cLHIJycCNdE3nDrzY190Ex2DwdxyIzFXCIN5LGV
         U7+4bMuktT9f/wd4U4aNQAFS7oThvSjd5f7/2uU5SAShXMfmfIWp2BJwfObxYbqSnNFe
         k0XQuPndxoeL1LFbOSPW97V6ABI6HHKRq4GJBivGGKHU+GPu1HkeGtoOwVVyVy03Jk9+
         6LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079919; x=1761684719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqLomk0XJ6mMJ0399FGLK0f1IEBoFk1TbnIiBF5Ifg0=;
        b=crtpmxwa3u+zlM8NftjrM/UXHwd5RlvZ96RLuU3L0I799gYaCv7DLmbe6sG9BWAKRQ
         tFFRKS2jZVpogptU5RGfhm0+bKlZt12qc/8dTSihA5aZbcSAXUnViRxxI6zegAsekA8e
         bjjTdzYHb6Cl3tSnZd62Hm1R3qa+cbEFRwsaj3dbhiHwdmrUuPXAooXCOgYbnDJJ8STU
         3LATRlk+AL7Ei+vSRarYDc3vpB0/GXXdbK2M6vlPyc6gJdKqb9h99d33GfniMKPgxqNs
         zUAK5/BwIfXvrVU+/SqinSEfn5aD9mdtwyB33GxUoHJTWu9Z0W7tPPakyyve+1lBr26m
         HfTA==
X-Gm-Message-State: AOJu0YwBgMv8f8DHUwdwpvquYLiTfqRWzzcZROICeHqCFt7jSqud9vVY
	ueAFniZJ6ntzXAqyq1SAq9eLTK9rk47FLs6QZpcTEfCQk+i1waaO/6xQ
X-Gm-Gg: ASbGncswIDrOW80Kub9voGPu+lMzRIwVXmXNZ16j89FMXQU1IS1/+S91vqdkm6Awgsz
	V7NE3rgaKe4wqOJBQYJJo4/9Q6SWZHqOBEbFpEa2JpMMEy9Zwr1BM/47W3yP7HywHX0w0oN1zD+
	pURbygvvWiqZ4awEECN0giMRXEjQatnQ//c3EzeqzxK5VRbkSqyLY1IGihBIF+cP+bgPW/acQVZ
	VlkNzRl7NQbWu9AooGulSgfw47RyHLN3JTojtBr4qmBjYq5HQN01agu1o8kAZw9S07hsmtZs8ty
	eIaII8ZYLKF9EzNM9yZfwXwyBzysCS/r3BZEy6rdaKeCzBW01hiGwu6gj90yj/H7GAZuPKYoJ1c
	5LtFbCEBPR5j3oh/OOvA3tnFmDOb2MSf5z7J1TwDMLnkm3PpwgCIIbwfNDqimJXmH+jJYXgWs3b
	50FA==
X-Google-Smtp-Source: AGHT+IGXa3KYk/FMewSl8GbMydrsPyCOFz6qkCeh/qanJrM3SOqws99nYJilMQBpqw29e2CQHXEsvw==
X-Received: by 2002:a05:6a00:4099:b0:7a2:23cd:418c with SMTP id d2e1a72fcca58-7a223cd42b2mr19100009b3a.3.1761079919503;
        Tue, 21 Oct 2025 13:51:59 -0700 (PDT)
Received: from skylark ([171.50.223.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f3c38sm12267929b3a.37.2025.10.21.13.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:51:58 -0700 (PDT)
From: Amol Dhamale <amoldhamale1105@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sriram.g@kpit.com,
	Amol Dhamale <amoldhamale1105@gmail.com>
Subject: [PATCH 4/4] wifi: mac80211_hwsim: use more restrictive permissions on debugfs files
Date: Tue, 21 Oct 2025 20:50:26 +0000
Message-ID: <f0609c73741321798da9baf7016270374d8e20fb.1761078139.git.amoldhamale1105@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761078139.git.amoldhamale1105@gmail.com>
References: <cover.1761078139.git.amoldhamale1105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

ERROR: Exporting writable files is usually an error. Consider more restrictive permissions.

Signed-off-by: Amol Dhamale <amoldhamale1105@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index e62d4a98671f..7b206a4d57b6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5816,10 +5816,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	}
 
 	data->debugfs = debugfs_create_dir("hwsim", hw->wiphy->debugfsdir);
-	debugfs_create_file("ps", 0666, data->debugfs, data, &hwsim_fops_ps);
-	debugfs_create_file("group", 0666, data->debugfs, data,
+	debugfs_create_file("ps", 0644, data->debugfs, data, &hwsim_fops_ps);
+	debugfs_create_file("group", 0644, data->debugfs, data,
 			    &hwsim_fops_group);
-	debugfs_create_file("rx_rssi", 0666, data->debugfs, data,
+	debugfs_create_file("rx_rssi", 0644, data->debugfs, data,
 			    &hwsim_fops_rx_rssi);
 	if (!data->use_chanctx)
 		debugfs_create_file("dfs_simulate_radar", 0222,
-- 
2.43.0


