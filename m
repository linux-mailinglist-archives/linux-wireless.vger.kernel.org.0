Return-Path: <linux-wireless+bounces-29676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94298CB6768
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 17:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26E5A305BC7F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C1F315D5B;
	Thu, 11 Dec 2025 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQdJk9TM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B69C315D52
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469960; cv=none; b=euqVatiFc7dug1+X5XcAvoU8as7Me3s/HT7H/92L5VdE5mzg/8gx++xvjalJsPPrjSRRCEH8LU9GNdiCDRdqAkCnOnAh06h2eD9+TgRcdLb2NJGaHnVLAr0arnZ2VVfGlW3GmDX5+AHJa4T7KRBCCl9YKS9ew7vbZQpGBxPe3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469960; c=relaxed/simple;
	bh=sZgLw6bfaZGgwO+/AxrKBU3bn4lXt/90J4RH7Djb9Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I/Q9sZ8p5DinM41X9tSluz03I0tf+QQ8lbrmZ8714ejMY5CBQ47vJPBfzv43hW5rc2oaL5z8v+YrcdSPWQrzfUsmvgrEtg6OwcwR2oTB3jcml7Yj7/lQg8lo9l14+EoGIb2551FJy5bNyLeZ8PP+Q86SfKtSgj4sDbXjvN1SNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQdJk9TM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so299724b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 08:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765469958; x=1766074758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWO4U6IurcDJDkXrfm8HGKR7LJ/D3nW8qPowmNKRLJg=;
        b=CQdJk9TMqut5+mewq7n/xh7T7IZB/msdo5tUlARC4Jr6qZBB3my+lw9qHDWiYmK7Dc
         H2dcLsxcBU6HJ3r/tsrJvP6fSR8DpevKRM265dgjiqDMNQaTA4p5go1JO2+rJKlNq2x/
         zKg8O+aPDHLZsO2zKtada3iCso/DyE/nfKpnoFbkEljLeNixD8JxLsApoU0oLPv4aPJ9
         tCFcEoU4e6K/SChH5rdca+DFVp3EK1MdEvlnW2TR1O4IRyXuBVoLIUWgaMlvc3y2841W
         7FPgUcXVznWE7L109IDly8vIM7SqR5jYOwBWei4eWui5uKsP9mwMc2AhyOrzt+/9BLTY
         4Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765469958; x=1766074758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWO4U6IurcDJDkXrfm8HGKR7LJ/D3nW8qPowmNKRLJg=;
        b=jA5nT2k0MHdrXHTw6gXXAbgmD+5qIDUX4tqSlQyPNgRalK92WqiucF02qBjnbjt6+8
         1IOk3f/2zNB01fCYzD3Dp4tgw9L+5aruP+SWuqarTcuMNr1Fau3Q7QOlK/+SD2L8sRSV
         38rZZ2fsgJJEVfrWkXjcJ0krT+x+L/02Rhx7c+ZYwhzGZRnHEB+873FIqK48RR/FLE5w
         cjxSrdnpa2T6WqhT0g1r2f4lk46TC2oc55QfzRYlXnyr1/2hbyWZvn6/1mXM4MqwuI+P
         K52O3icS8SdCiARJOKNLws2PR/ZwCjCdD/YnYBYG796JtDKQhqAkXYX5hEOzhbY92FDR
         mAlw==
X-Gm-Message-State: AOJu0YxunHw9ihc8fLwAJhENv3E8C35Mliq0F9c+tMBkjxnFhLRuiGnJ
	7qetIebbz6xnYTY6K0dXAD1aNQc7STIiXqhCWuaQ5TOLvUcYxck5VoiCUl2FG8NG
X-Gm-Gg: AY/fxX41u2GVBIL66x1RmgCtcKnpjKuH8gnNqPir/URZ1mloXL91MRhG2w7U5Q8H1iI
	kVfDcBafwiCE5HcXt5V8wrhYDeQjNB42S7gkR1Ltkd6rt89shJuRGZz27e6ZHxpqyNjYKX6Mx8h
	jNTPzsyi79cn/Ce3tWtaa9BAHadfhfygq9LP+HtMBmZXmGZSqhHp3ydWrdTxBnwfV0aK9IYRQ0m
	XlMyPev6hD5N2CehPRUsLBBI28OwRJV3SFNcz1p0gh2Rho0SdLswJPOs9G9c6N0zLUi3Q/2YBGm
	OJ80tsm/7T7dmNmjuJM95vZo17IR4MB3jZLD1jJx+HSzx8ES1+txPcu0UNLqaCfMJzIUMuBR0pC
	uxMM/VAN69L+MTYnVjhylHACmoOkuXYz/Cxq3FU2tN0ESHntv8WYOUFXUpXFoov9oAxZxKmirPd
	9R8umZU+KYprZnTI3gHlmIOkXghlcVQpXAr7o6RGl0Q7Y0ksw=
X-Google-Smtp-Source: AGHT+IGdR7xEu9fDV/+Rs1YZNjhkK7Hw4IVfaZOgGspvMKlvcL5C+2GVqX3q4rOt8P5z1m6MhaeZTA==
X-Received: by 2002:aa7:888b:0:b0:7e8:450c:61c7 with SMTP id d2e1a72fcca58-7f2303b2269mr6396098b3a.55.1765469958182;
        Thu, 11 Dec 2025 08:19:18 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1cc4:1fe3:da4a:fc56:de9f:a856])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c22848a7sm2961196b3a.3.2025.12.11.08.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 08:19:17 -0800 (PST)
From: chourasiarohit27@gmail.com
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rohit Chourasia <chourasiarohit27@gmail.com>
Subject: [PATCH] =?UTF-8?q?rtlwifi:=20fix=20typo=20in=20comment=20(recieve?= =?UTF-8?q?d=20=E2=86=92=20received)?=
Date: Thu, 11 Dec 2025 21:49:11 +0530
Message-Id: <20251211161911.30611-1-chourasiarohit27@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rohit Chourasia <chourasiarohit27@gmail.com>

Signed-off-by: Rohit Chourasia <chourasiarohit27@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/regd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/regd.c b/drivers/net/wireless/realtek/rtlwifi/regd.c
index 0bc4afa4fda3..fd967006b3e1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/regd.c
+++ b/drivers/net/wireless/realtek/rtlwifi/regd.c
@@ -206,7 +206,7 @@ static void _rtl_reg_apply_active_scan_flags(struct wiphy *wiphy,
 	}
 
 	/*
-	 *If a country IE has been recieved check its rule for this
+	 *If a country IE has been received check its rule for this
 	 *channel first before enabling active scan. The passive scan
 	 *would have been enforced by the initial processing of our
 	 *custom regulatory domain.
-- 
2.25.1


