Return-Path: <linux-wireless+bounces-14031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03839A0114
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982851F2548A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7E187855;
	Wed, 16 Oct 2024 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLezS3/R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31734156E4;
	Wed, 16 Oct 2024 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058871; cv=none; b=IMXVamC8jwjscgQQ3eXzm/Kc5SD1Bw4utf5taucv4ffK0ccS6JT2D5AR9krMajM8/vygfOBWWEyZsaUmrRo2O9UhmlD241iwVGDvc5Fos1CkJ+4+FNSkUCQQp/Ofe58iWkp+iRa5SXf2oyIP61WCjx8IuupjFz1ZMki9Wh3ZD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058871; c=relaxed/simple;
	bh=eqaoJ/sN14xErGT0OFr9MTImbR5eWWE+1HTzZKzOic0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyC1n/nJ86CJYRfdAhEYyQmIy95UO2sCh8nbxyrG/uFrO+k7+NJLIAQk30C6Q5o8vXwcl8WpOzjn9y/VEfgbj/pf/DI5nmJCu99a2YU4jaaryEie4KgvGY/Nc1Zex1EQaojaabotV+2tzjtGWQednH8kbgxW7lX8BsMjJM0ufCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLezS3/R; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e5b2814f6so2682006b3a.2;
        Tue, 15 Oct 2024 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729058869; x=1729663669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZhPZEqavsZlSS47YHvpXe0VTR/p4rWcAo8MO4IBwQk=;
        b=lLezS3/Ri9Yykg3lqPIrEuJbfjoEWyMx82K1WdddpxRIE1/qLVw8RUK9xTd3TYwseq
         Py+vtC/orWoAzxdwdStnvLKnCM7hWmHVvXw8E7R0+h3pJUR9JPZa5I8Mt04HECWWXgZD
         8XWil/ffsZ6/8MgNQ7EyCJe1u5wzWlUOd+GOrGmbEL10bSjj5bRiPuRiea7GCLfvLtF+
         28a/6yVWIz2hAUUZMe55iDTsXEhcpkbHj1JKl6PfYAJv16Zs9huSBUGEd8MbCbCCvHkr
         W4EhYnjKex7BAboKAXveQQTbZov1kCnxFwa8enSJNwxbSnrQ95WP5cT38OVOENFPovTN
         AtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729058869; x=1729663669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZhPZEqavsZlSS47YHvpXe0VTR/p4rWcAo8MO4IBwQk=;
        b=DINKj/nCWBad02zDRPGQGkulzl5qLmnELl9fDQ0eP6l2cYqoJHronFaLBoyycsD4A7
         79/8JjrIYUMyPqKXvdHMHRQnonSwe0teVCb7VTMQ6RypJ52IIz0II89ZPfEKgYiUJp90
         RFo/sDuwDmdT5AEE1oLiOEiL01DRuTPMLe2vVL9Y5yRkOvsZbqKginHv2kRgOoirdSWm
         Z/vm7RemGYDVzibqhlyDGoSkalZi0A3vuLZTKUqxyg11rDbGmDglXY+XL6KMuwQUUc7Z
         thFu8kukt+e81c5OVgsB44aMW5fWnG2NtOf7c5BPwTaYAfzx/yGqVZbs5OSxQMP7nhzS
         wnvg==
X-Forwarded-Encrypted: i=1; AJvYcCUforazMcdUQmprLeIJJDAwDBbOCyn+IR7Ra77nDeHt4ay9kdUkwyWM5zBU8mhD8Znm+3ewLoElAbfHDWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJsoXl4lQVsbDrGWNwGwFEfDaBJUj2L9Gl43k4oWqSPCbATGIw
	8ObKPbr2plLJHy0l3foRjYE6uDQrnMM2JHsvyqwgoRaIvo2wJIKVb+lEsSHo
X-Google-Smtp-Source: AGHT+IEZA09Lw2h/snYVQ4XAmyXwkQKiyakJy1MONzLph6ysXYSuUZqOmHLpzrakOmXT3EmNgN2pug==
X-Received: by 2002:a05:6a00:2282:b0:71e:8023:c718 with SMTP id d2e1a72fcca58-71e8023c9e2mr2690654b3a.8.1729058868805;
        Tue, 15 Oct 2024 23:07:48 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71e773b161esm2330614b3a.86.2024.10.15.23.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:07:48 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH] wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate
Date: Wed, 16 Oct 2024 11:36:05 +0530
Message-ID: <20241016060605.11359-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous implementation performs check for the band
in each iteration, which is unnecessary and further more
there is a else condition which will never get triggered,
since a check is done to see if the band is either 2G or
5G earlier and the band either be any of those 2. We can
refactor this by assigning a pointer to the appropriate
power offset array based on the band before the loop and
updating this.

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 37ef80c9091d..17d61f1d9257 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1465,15 +1465,14 @@ static void rtw_phy_store_tx_power_by_rate(struct rtw_dev *rtwdev,
 		    rate_num > RTW_RF_PATH_MAX))
 		return;
 
+	s8 (*tx_pwr_by_rate_offset) = (band == PHY_BANK_2G)
+						? hal->tx_pwr_by_rate_offset_2g[rfpath]
+						: hal->tx_pwr_by_rate_offset_5g[rfpath];
+
 	for (i = 0; i < rate_num; i++) {
 		offset = pwr_by_rate[i];
 		rate = rates[i];
-		if (band == PHY_BAND_2G)
-			hal->tx_pwr_by_rate_offset_2g[rfpath][rate] = offset;
-		else if (band == PHY_BAND_5G)
-			hal->tx_pwr_by_rate_offset_5g[rfpath][rate] = offset;
-		else
-			continue;
+		tx_pwr_by_rate_offset[rate] = offset;
 	}
 }
 
-- 
2.47.0


