Return-Path: <linux-wireless+bounces-11586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F818955B9F
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 08:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B1D281E90
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 06:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171B12E5D;
	Sun, 18 Aug 2024 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNVQ2n3V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A41946B;
	Sun, 18 Aug 2024 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963753; cv=none; b=XQW49+3k8vzf0G4ZGu5RS4MfoeR/wXBDWiKKMsb6dKRlw+Jr5VCrfbA6bhPi394H8hDHBchPRDk+gOSZ+fBdDmopZJlFYj5Q4Qqkp4m3187J9miRAPF050UUjAw2mpdrr0cchh9xocOjrGEseP2nOisWE7GxkC829f9pnYhOH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963753; c=relaxed/simple;
	bh=TsoZbtD+UJ4g+rTeXmONHGisaCk2Ke4jnhSacbQFCj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QT8HgRQ/rH36yAMpin7JEb+UU3vEacKJgChtLHhPhAynN8JK7nVftRQCpgbulXhymzQ8V+x2MZ/ki8n0K21iGDrQtaa+fCtUl8HUvc3rKPetEXNI6VW5ygkcz4PDTORwDxJf51/DW5sSDGqaR3kT6uTmtBeI2t2D+MMPyd3m+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNVQ2n3V; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4f50d8ce6e0so1207794e0c.0;
        Sat, 17 Aug 2024 23:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723963751; x=1724568551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjjhyBOyh3jJmc5BOCT1TYFBSPVpqWAWwBC00AFnBN8=;
        b=LNVQ2n3V4FufjIoIyfqHm6XqaCS0nwK7SFyIo2dqGcHfxIBFsmkM8g1grpuoH5z0MB
         SOrNgp8mjyLl2SvF4ruzsVNjnOEfVedWExbvlDYz7QvxSLAOKYTVIvp6AUGBPUU9iue8
         59YKEum3tF9jxbtbCHuDUZ71Jya+jHYFSyTOXE5FFdRqwxrCeyB60E8mfljpReby7NIF
         bOdTt0P4qqtaQW99mImkJV0AsKgvFoiu3Gst1mo0HRRmKcZtTZN/BCtMnHUFzumfDT3x
         TOTs49xTNvGnVU76T6IqYVIxplRgAVktEYw5ii6XNfdSjOsnpgr9OTNdQcnbySpekl9n
         8fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963751; x=1724568551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjjhyBOyh3jJmc5BOCT1TYFBSPVpqWAWwBC00AFnBN8=;
        b=DoQcs+eRSU+cu0jPws85Pssk+y8JsT31jYQfPxAiHK4MZO++g2mTF4EKFnxow3wyuK
         ugVevMQdcTp6CGUo70uUcHfm6FZsR4Imae+C82SENrcIjNdCijkP1XPHG9t87BYp/KnK
         LVqAfM0wa3/ecbHpxxlC5sQVVHgs9xYRLCZ+fyd+mctlIugov9I45HQCj3skmw9cMmqW
         bOsP1IOIeZF2g9WP9Yc6O7arkqFTos+XDYXQziWPIZg1uk0P+CEnhJ2PaNb9OGz5KG3J
         R3QkfB/pxmnQB4N1LEoS8P/PhBbvb2cyRoZ9M6u3Q0tt5kAJY0T5wnHC8adCYx7b/Kwo
         KtGw==
X-Forwarded-Encrypted: i=1; AJvYcCXCcblNPCNKWtmwiWKBFd7XP9mQapYVf+aAiIsnKp+v+c4kMV5aTcrX4CVK+Jxs2lN60Onx8EuunIsry0WLC7fPdyFcP+T+mUEQ9I9D
X-Gm-Message-State: AOJu0Yyx5UL4AIwYIuftZ1gqTtTqEBYR7mbjxBIRL+/+HGnDz/OD4mJh
	qtzmm3/iDqh5I5bDmqFkm0sn1MQXium7DIulvC6VZZWs0AYcxp/Vowi6gnd+
X-Google-Smtp-Source: AGHT+IFAyuHL1qMvTWatQtld3iEmZYbHdgF8s+LfK3onXvQn2l61QkhoOhg+kv07kPc5NXvGAu2/7Q==
X-Received: by 2002:a05:6122:2502:b0:4f5:28e3:5a5a with SMTP id 71dfb90a1353d-4fc6c70bc26mr9099047e0c.4.1723963750928;
        Sat, 17 Aug 2024 23:49:10 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b8e30cfsm811032e0c.18.2024.08.17.23.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:49:10 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH 2/3] iwlwifi: mvm: Enclose multi-statement macro in a do while
Date: Sun, 18 Aug 2024 01:48:58 -0500
Message-ID: <959e76da152811a723415545a3cf6ab1d8e17fbc.1723963126.git.soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723963126.git.soyjuanarbol@gmail.com>
References: <cover.1723963126.git.soyjuanarbol@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch encloses the `CHECK_BW` macro inside a do while as
preferred by the guidelines.

This change is purely stylistic and do not affect the functionality
of the code.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 1a210d0c22b3..b7a12c52a95d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1043,10 +1043,13 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_SEC);
 
 #define CHECK_BW(bw) \
-	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_ ## bw ## MHZ != \
-		     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS); \
-	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_ ## bw ## MHZ != \
-		     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS)
+	do { \
+		BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_ ## bw ## MHZ != \
+			     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS); \
+		BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_ ## bw ## MHZ != \
+			     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS) \
+	while (0);
+
 	CHECK_BW(20);
 	CHECK_BW(40);
 	CHECK_BW(80);
-- 
2.46.0


