Return-Path: <linux-wireless+bounces-19155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E8EA3CE22
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 01:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB0518909EC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 00:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D9146D53;
	Thu, 20 Feb 2025 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+ojc2c5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FDA3EA83
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011510; cv=none; b=dlk2lnMtEh8tc4ONgXgxgfpuGvIQQ2HyrDBUsuyS4T9aFt/Wl7EFk9rVhXuegbDb9LSTFxiIfaM2G6kXXELD+NntpBbsQItlaVz/Y0TZTnj17QBu6evJB8jJi9okbJOj4lEoNp4g1XrrxS0Vwit89gt8nCcB9mwwQEegkRGd/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011510; c=relaxed/simple;
	bh=DF24b2i0nbJB3WSzD0g0628kUp67N25QucnUIKzLXy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpFaG7UIFtoFamHWAIef2PPOD04wqURw8RFK1CbZSqnLMJxKssPEEv+ez4AV6xoio1XZ0ql6qBuvWKZUCa6y5iVyBuVaFr+TzdtmMKAwvpcoIyxoU0tJbkUQ+q4zsZfMEFKGH0VceHAlrSz1LTlFCUszcCda7bhcKHWNVHlkkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+ojc2c5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22128b7d587so5491205ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 16:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740011508; x=1740616308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzmAX8ik+1G+kMm2o8mIS74u1te8uRXDU0fxFrlfDlk=;
        b=P+ojc2c5V7mZ9H+xoAtp4M7UM+SeGRnlDlKd2b82JMNNVRt17PJz/pBhgDCd4lJU8Q
         oGB+P8zBvXuPvFrQL3RZQWXSMmUb1fD2r9rif1XK6WYdAdqhWuVYnsbm6BWbi5qkBByy
         JbopZsEiuha+aYkyB8xoozOD51Zx1gRMf3B28kUMND7DvWU2j43YUxsp6LKT4hmL7ptG
         GGzna189cnW7vNYv2prCO1A7zZIA/WVOVe6NqAn22+PhziWF25LwotQkDYXOuIInwLBV
         yNPTZTa+Oyz9lOgWr05SiXVmIu4zyddrPCEMqde1U0ltgTe497O5IBExhz0lhmJ2Nl3i
         tmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740011508; x=1740616308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzmAX8ik+1G+kMm2o8mIS74u1te8uRXDU0fxFrlfDlk=;
        b=NklZWmGEHhS49wUZZO5oX2O4sIv4yEpz8Melso3gE31sVhmU6M+0EZYe3IwtZ3HFjZ
         RsEIY2Dkqn8SUZQd2z7+jSzekIXn2FBA7tTu302ZMm7M5IkZCra6mbGJUP4VMm6Zcih8
         Eslsy4iIT6clxEuZAYhxV4paPNoIgQ8wvlrx0RSk9W1pA73pdChJxFcUj3N7eguR3/Xa
         pKhhEia2TYEqw2QvGIzYKC5wDwxXtP0sY+0qNNIQzBBefoCXr9oFSt0zOBGwgWXE22a1
         WQrvPSlJ3JuaXkWzNg8vM6GTsuSZm22bcWjPU8++Yd0fICBpQBWdRZWyGwMHjgLs/h22
         DUig==
X-Gm-Message-State: AOJu0YzgypMqHQIm3U8BOZLRmUYyV2ASriYCQnFN1Bepey8IjyyOFpPo
	ZVxLXm8KkTHikQ14NcrwtbflvzDugDf3dYLd1VjlkDTzbkiPRdpr
X-Gm-Gg: ASbGncsTqXbTP8J+OZIeXULSD68sbKqqTZ74eX154tv0OEsfeGMZBpa/9/ikDiB7t6j
	S/WmRxyMklE9EnV6Nbqob8m9RN1rMRsORrYc3xmecFDb5sym7gfD6lmD8r7RoYX+TW4EF7SoFgp
	i1hheLKTWK3GzQ1eZI29r4j2rtk0q3du2dEfYVi81IYI2iWG7uXp3fTlGk12igCkGCB6eDecNQ8
	F5/Wl8MdXYRWKtxvyrhVrwEI7MGXALsPhOv7rVgsxAFdqjDUwxCczF7HxUdNHJdlhIx0yE1OrUA
	adr5ibBdWOnuggmAQxx9v2lygSxn+1jP2c9OEOGtuIvoe6YfKSPiNWaKFA==
X-Google-Smtp-Source: AGHT+IFjx7hGMEtKAEk3wJ39EjfPjXJxrMU2iJHvfF6o1JBlUZKuweeBtJMCdj4SqoMXi2CTSuLSmw==
X-Received: by 2002:a17:903:189:b0:215:a434:b6ad with SMTP id d9443c01a7336-221711a70a7mr87121155ad.33.1740011508038;
        Wed, 19 Feb 2025 16:31:48 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d556d6d2sm108857895ad.177.2025.02.19.16.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 16:31:47 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	johannes@sipsolutions.net,
	mobin@mobintestserver.ir
Subject: [PATCH v4 3/3] wireless-regdb: Update frequency range with NO-INDOOR for Oman (OM)
Date: Thu, 20 Feb 2025 08:31:03 +0800
Message-Id: <20250220003103.4484-3-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220003103.4484-1-pkshih@gmail.com>
References: <20250220003103.4484-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The commit f67f40d00919 ("wireless-regdb: Update regulatory info for Oman (OM)")
describes the range 5725-5850 MHz is outdoor use only, and currently we
can use NO-INDOOR flag. Add the entry accordingly.

* 5725-5850 MHz
  - 2 W max. mean EIRP
  - TPC: FWA systems operating in frequency band 5725-5850 MHz shall
         employ TPC with a range of at least 5 dB.
         (28 dBm Is adopted)
  - Outdoor use only
  - DFS

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v4:
 - no change
v3:
 - new introduction by v3
---
 db.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/db.txt b/db.txt
index 7fe673111f62..803f1bc5405f 100644
--- a/db.txt
+++ b/db.txt
@@ -1480,6 +1480,7 @@ country OM: DFS-ETSI
 	(5170 - 5250 @ 80), (200 mW), AUTO-BW
 	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
 	(5470 - 5725 @ 160), (27), DFS
+	(5725 - 5850 @ 80), (28), DFS, NO-INDOOR
 	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
-- 
2.25.1


