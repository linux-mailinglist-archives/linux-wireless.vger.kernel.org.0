Return-Path: <linux-wireless+bounces-10147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A89D92D09D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 13:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B386283F99
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D494190473;
	Wed, 10 Jul 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVdwHw+q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C818C161;
	Wed, 10 Jul 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610578; cv=none; b=V9oHMlfFISSLO4m+hfKWZY29/F3O1CzY2Q2xgrEti9kVMWaj0ZRWTkXxpx1gpAWZgF8X9LZzNDiuP5TDm290TNjmLpBGaVqsNM9D6oli1GNYClE8zsOrczI2x1ZfALWRf9dkfoVqs1JrzDpJzDGCYjD1y6hl4xQG40sZ74zfiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610578; c=relaxed/simple;
	bh=+2lG3eONR6clr5oIGVEwoEoU8KiT5nobeApkSFqKMb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F6BxUuI1p866kJGFMoyP+ox41CZR6Uo7TE1GYsvxzVroGtbFD0mZVEw64k0y4Sfl9NIjJAMjIBoGYl90++3wOh/RMpfSfpm6bBbx6TB4E3s2T4lrWuyyQ3O1QeKEarhYcH+8WNzvqTdnu/9YZSJO9MWQO+j2pveCLfyKjDqRZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVdwHw+q; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367a9ab4d81so3103174f8f.1;
        Wed, 10 Jul 2024 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720610575; x=1721215375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5pSWEv/oTNW6NcIbQDcaGxWdOTM6qk7A0MwW/PmYxc=;
        b=VVdwHw+qpFWD/zDxNccyGPyU7Q6CHClU9oRreNYTG9kjlSFEv3EA7GIcQw50eBxHob
         THhGzc4sl0MEw+GBhchGsNHg/rZDyuEussnMUTvd08yKxBqM2qbyWlzKALQiuqdHKdpL
         cXeD83kxxsPUj0wNv9yAbc0J08I6GYE40XHIOhrVHpjr9I2aKyKEqnUrDjht7b47hcNz
         IzC9k+w2zfrpQgI6W+XE6O1yrtALoiCXj8ldN32/+2SdEGwRaqNh3j7fdUW6PsCu396/
         XIYTpY0HOclfDokj1wysBr00xk9miCHsvivOpQGfBGAexJRywViK8qk3Rimo2eY7vy8d
         Kvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720610575; x=1721215375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5pSWEv/oTNW6NcIbQDcaGxWdOTM6qk7A0MwW/PmYxc=;
        b=jAyLVgCc+Yly3x63LK/xjkxFIA4Qo/HWqDwI2Jb5hASQOGW4P9UDxEQ+wSE2whIE/Q
         76p5TxOTSIK6EOorPjEk2wQzyQsRtqG1nFAJbXFzbu7WhYzZsefiF8j7QXjljqmABhA/
         yr2rEzXYlTpsmJzG5Sam8c4IG8HuOEGI1yI/ZEc3Sw/QuxFmWdZBk+3JbinImaOg5oFW
         6OISkVSbTz4xCqd0sqTvUngKNVAKJRIiLihP8rEHtRgYRbFi7PfbjocYEzJZrRNm+vr6
         mMpoZWcqT3Ns90mcfDUBBYs12ONgMxJo4lyN5/vndt7s5n34fABat0lajYMq8Hwd88PW
         uF0A==
X-Forwarded-Encrypted: i=1; AJvYcCVr101atbLJsA0lj8bWkK+bkrdO+tP89QiOEPbTI1/NAPTzKWI7XorXCM1W2PDMIArBuhGrglHN31BBLwvq7kx8JSGmg/3FB7W9C+Ex4bRAv/7G8ThaPlq5ul+FEY99rfneATH0Gk49++gyISc=
X-Gm-Message-State: AOJu0YzMycHDNIysh7l7AnXfp2CssD/+fMumagEvOp9tcVy2cBDZ7ibD
	aP2Uc+lydHGLqYO3xQmykMplJt/R34CF4Oj9lzTco5k4cTV3LLWLItkINz4c
X-Google-Smtp-Source: AGHT+IGxvkA0FD/5EZ/WLWTb5skCt68JxrBOSHiF5I5G4EGu4EkYmc0RJXX+XWkeKTdsYZUs8gIf3g==
X-Received: by 2002:a5d:4fd1:0:b0:367:97b9:d5f3 with SMTP id ffacd0b85a97d-367cea4674emr3721820f8f.2.1720610575007;
        Wed, 10 Jul 2024 04:22:55 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab11csm5052022f8f.102.2024.07.10.04.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:22:54 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: rtw89: 8852bt: rfk: Fix spelling mistake "KIP_RESOTRE" -> "KIP_RESTORE"
Date: Wed, 10 Jul 2024 12:22:53 +0100
Message-Id: <20240710112253.228171-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index fa0e49d58112..5bdabb45e968 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -1863,7 +1863,7 @@ static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		    id == 0x14 ? "PWR_CAL" :
 		    id == 0x15 ? "DPK_RXAGC" :
 		    id == 0x16 ? "KIP_PRESET" :
-		    id == 0x17 ? "KIP_RESOTRE" :
+		    id == 0x17 ? "KIP_RESTORE" :
 		    "DPK_TXAGC", dpk_cmd);
 }
 
-- 
2.39.2


