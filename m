Return-Path: <linux-wireless+bounces-30586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BED07030
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 04:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CA0F301A196
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 03:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E024466C;
	Fri,  9 Jan 2026 03:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA2NHhqf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C623BF91
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767930034; cv=none; b=jiESZSdSEXvoNA15BqSj3BFhh8MNUdWWf/dqZzxHgfyA+B4i5NTHt2dlX+FQ/or6w1tyPsRU6iBSDg5ZASJfU+Q8zRVuTIo3Pip4X6c5Z4/gPfBJw83JjO6oIC74jSCYvCLL+M6dZ8fV8NQS6VH/U/MKXRHz608opA80xpGtE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767930034; c=relaxed/simple;
	bh=ZngBZOuyEiiYCDmUGPUbp507lvGhb4UKwkiVQ+s/3BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FY1Dsvdeo/TZX/AbeEKgYN13h6WOwRdoGIIkNycYbGpxMVIRlpV+yDdeVfRgrimcvRnmsuOCHUm6CFABIy1cro3rq+BNgoXRFl2Stl/+jjtupTQc6byNvBUwflm0KNlUtzLoHQAxt0ZOboT9v+ZWr7ecY9lYeFytAqQaOt/q3fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA2NHhqf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f30233d8aso28208785ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 19:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767930033; x=1768534833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6YIIoHMbWWMEgNdY0LTR9KPrDSBdoV9NydkT9nhfA8k=;
        b=ZA2NHhqfmnQ2e1jprkXQx3r+8pD9xoPyONWvVlJAk5zjl/SOJBiIQMZRZu+6Jdk4co
         S1oXKslWune1p5DbOQX8fT0qIwxKgUTaogUreOAO+PW8j//nWsoLRm3uVMvyMl6TroV+
         sKuegO5N7hMmmc0JUyW41gWbYWWo4eEA8Yxj0cYHlaCjvS8MuR8Cngqk52oOjbaGAwfq
         6I99x6jUCbjwTkSZW5XBUsTY6s/Pw0+T6XcSA6cgbHhW0Emn3/rqfv2wawLZbH0s3SoU
         Cb5VERgBHyUlolaNcX/Slr8bK09Jo1BdAj5gT5CTV4JTjRM+SwJYHxQh7KAxA0683Ioa
         VTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767930033; x=1768534833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YIIoHMbWWMEgNdY0LTR9KPrDSBdoV9NydkT9nhfA8k=;
        b=GCXxRaIe5bQv0V0SLnUGM9rkB4HOw7/VonxHZICfpW0mUBTKSGuh5RlpVaM85eOCrE
         37zforjU0smN+rWOkkbAc2VxioeoUmhnAK+d9ICt/NjUPBsvP1bLcgpkphtqOQY1o7+m
         Y4bz+WkQpJHtYC1A32nQ4i7iDnZciRBSikHHR+QyRZTMxgLbkshOF2HVi1breoLVnEZv
         osYPuSg6v3ydL5RZo93i382vORLXcc4HTgZSZF62MN1uRkwUqfIjA6KNyVeQ+xhlpg0U
         pxcOGC1s3LyGY/kgyzh6XmMgLUUfljHsnSe78FFa0bOi+f2NMhZMcJcrCi8CaDqMM2Rw
         BKRQ==
X-Gm-Message-State: AOJu0YzzzpSz6iQEESkLyJKX0qbjWlsmjfh5tPs8vTpa1o1YX+lduPAL
	PuyyJwQmBBcUlr3xLBPuYHFFlRhM4NzHx0zsFXFVg1weN/Lq4q3xfEspbHWsW+Pmf7I=
X-Gm-Gg: AY/fxX7XEq9zDCXuYWAjy4SzSFsXkGt8PkrjccmZppX/ZBB5e5Xt69Sw0YVm7FslvjY
	KeH3uRulSOvmD+f7esa7eyqARvECTQ485tvr9tubp77bMMRLJgPh152uAIvZJ/XQJQCuZUEmcFc
	HmgboqOaRooeqz+MakTw5Vt8rE/gS9S8fDwvz7nCRi8N+A+1+a0H6vskMX91aXnJ3+/H10up/YB
	8nNoE/+kICbL37NXgtWiOsb8S6zD9W4fsv7TqPbKZ9UY5xxKDP3Ol0DzozOK75AIfsPmaW6fih/
	1df0dsihr9fHrc46lRnNHEtawq/eldkoF2A/DwIPFsIgjNRMElVIovh4BdPRtuU3ILO/Z4g2rUz
	u8S+fOZK0AnHIl4vNIKtmKuz7e+ahIR4cAWPbYxTX/WLSOyDmeqx/vuiHXq95kAe4xYYLRmo=
X-Google-Smtp-Source: AGHT+IGccHsxtGGAaNFfQO5IjD+5zUxmXgt0wLSTK0XmhDfTjED7T5x5SGhShSFCeCHtkyUfMBlCoA==
X-Received: by 2002:a17:902:fc43:b0:2a0:ccdb:218d with SMTP id d9443c01a7336-2a3ee442824mr85400445ad.17.1767930032516;
        Thu, 08 Jan 2026 19:40:32 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:0:a77:18ea])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc02ecfccsm9116494a12.13.2026.01.08.19.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 19:40:32 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: stf_xl@wp.pl
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH v3] wifi: iwlegacy: 3945-rs: add a defensive WARN_ON_ONCE for il_sta in il3945_rs_get_rate()
Date: Fri,  9 Jan 2026 11:40:14 +0800
Message-ID: <20260109034014.187124-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this function, il_sta is not expected to be NULL. Add a defensive
WARN_ON_ONCE() to catch this unexpected condition and aid debugging.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
v3:
* Replace plain NULL check with WARN_ON_ONCE() and update subject to better
  reflect defensive nature of the check.
  Thanks to Johannes Berg and Stanislaw Gruszka for helpful advice.
v2:
* Return early for uninitialized STA il data and align D_RATE messages with
  il3945_rs_tx_status(). Add a wifi: prefix to the patch title.
  Thanks to Stanislaw Gruszka for the helpful advice.
---
 drivers/net/wireless/intel/iwlegacy/3945-rs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
index 1826c37c090c..463565ce14af 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
@@ -626,6 +626,9 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
 
 	D_RATE("enter\n");
 
+	if (WARN_ON_ONCE(!il_sta))
+		return;
+
 	/* Treat uninitialized rate scaling data same as non-existing. */
 	if (rs_sta && !rs_sta->il) {
 		D_RATE("Rate scaling information not initialized yet.\n");
-- 
2.43.0


