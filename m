Return-Path: <linux-wireless+bounces-19088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94CA39112
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 04:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C303B3FE1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 03:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2606F187FE4;
	Tue, 18 Feb 2025 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="budYRuOg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8A15F330
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847639; cv=none; b=YxOj2EzvL3u+MAm70s8sfTscMTKwuPC4ZAOzoUt2tv+4Qbfmv7PJgor1kv13f21SFDX5eEVC2Ext5Dbbg5VrFNXsdUnERjKZCkyMD8sLjlxqpuysKqINr2sR0kbfFEDH9/u3WNeqJgN8LkNAikZiAE9BKcH4f9fJ8q7vhUTL0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847639; c=relaxed/simple;
	bh=H6cO+lblzbc8qwt+ypwOMf1gNDJIXM5Rzt0YAoT7SuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pC4g5su3wo3cF5AjoIWlc2lQ6/pd3fxdGBNzEU/CB4PttcxKOsfEyff6Fp2mmic+IRhDj8KTDQSXy/R1oC0Lr9T8Q69mL7Dq1iiTO3pK17yiKuM4lRrR6suNwD8DfdMMqo3wZ4nUAs1q5WnbeFWISIqMB7CRlK9aHNPaGHbOG6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=budYRuOg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220d39a5627so71442115ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 19:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739847636; x=1740452436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/RZwU+z3SNSHUk3UYG1BXd9tkrPxZ+j3jNP2H2IK7I=;
        b=budYRuOgrccOWZDaLKoPNiB4Tt8ldIZpdi7S5k2HHWg3aYIHnvwy0TtkDebZEqElMV
         S6myYLpWXJ9G4EEA4Nl3FKPiVwfSUNk+W74C27QPXALvSWYjmxuLpG5kvuhNc2Q/ZbLp
         Rahka3be1FyUw+uQB1QSYJMfQ923TY7ltiZPtTtMsxh/67n7PUFDMK7UDMi58PFpna6C
         Q4CFX3XdF0rhcPZDIsAI9qsThVyjONSniGZzSZgXXoRS75HB20OkF6hzfvT+Cqhz8uWj
         fSaBDK5Aamw1n+Gwy2SZnA4jmV9XodvjekpzPQp30D93+WGVVhEMSyQGj/2tyaSaDQkp
         babA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739847636; x=1740452436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/RZwU+z3SNSHUk3UYG1BXd9tkrPxZ+j3jNP2H2IK7I=;
        b=k0ypF2cApm2x7G/5zJ7kx9aauKr/JDnW1rnmleJdfxO85hzj4CAO7QLs5Iy/n7Fb7B
         xaG1bksbOzPmTCypRIy/Cw+slcO3qSqyNRV5YWg90hU6UoYdw9kTHP6Wj59/UC1Kh1Ge
         MogviZ1sqmyPlUopgrT2lUsjRMqvPLUAwe1aBMOQc8ilQIWeE7OJmzHCxs0iKLjAXoxj
         VdE/NaUPQuu8jMLkcOIl9ZsOMqH/mY3xj/bV6MrTKjNnhTs0bgvP12fAIWtn4MSC+2RW
         lwLRP7IhvAgCn0xoFrQFHsPd5XL6cP9zG0LSmkUOHlyCX1JoS6rOwHauYM7YDcfCU71j
         6kAQ==
X-Gm-Message-State: AOJu0Yw45BCgBOv2TVLxWgfjmcm22YmT/sZd8q4YjEEj9oUolSUIgUJX
	pDTjPC20UZqqdKLOcFVBON5ijKuiPRzGKSPWV0gSD1c3ndaPa4IB
X-Gm-Gg: ASbGnctR850i82d4OSh8aoARs3c7Jdv9TQ4vTtjpwWyXhqUAYAf4ZOPVn4E45vZAoNH
	WqgqFg+kLvT9PA+HsTM6k6rDbuQK/ns5HMLMPJaG5Y4yL59bKvhm8dB1jTfcScvDM5WDTIQr3E+
	WT16GgimO/z5M/6Yc8VGQgg3QYjtisLWHqavy0wYx9m0VTrw/i0o6DCyUHclvS1RtVYFeSNx6lQ
	guq1WOJZc12dK+SkAmNKAhtn9+FiyTqbpBy7P4joPK9z0uTTk4OA2rce18wKJFQ/1h7lihnn24R
	v+G7XN5OA81pQYWi4Fz7tCVEBZZxdRR0Fr8QXtAbBzRTagKRBUO+pp49Fg==
X-Google-Smtp-Source: AGHT+IFeWAFjwa1243Uan1+rWsmm0knBDC5D9g1kwyYIHepCSVWWJMcUxZf6j2wn39RAaJL+gFfbBg==
X-Received: by 2002:a17:902:f983:b0:21f:b6f:3f34 with SMTP id d9443c01a7336-22103f14b87mr139771525ad.15.1739847636105;
        Mon, 17 Feb 2025 19:00:36 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d5585fbfsm78628785ad.226.2025.02.17.19.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:00:35 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	mobin@mobintestserver.ir
Subject: [PATCH] wireless-regdb: Update regulatory rules for Iran (IR) on both 2.4 and 5Ghz for 2019
Date: Tue, 18 Feb 2025 10:59:57 +0800
Message-Id: <20250218025957.13818-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Decision No. 4004-01DEC-CRA, 8th Edition - February 2019,
Radiocommunications and Regulatory Organization.
General radio license for the use of parts of the frequency bands
2400-2483.5 MHz, 5150-5250 MHz, 5350-5250 MHz, 5470-5725 MHz, and
5850-5725 MHz in radio access networks. [1]

* 2400 - 2483.5
  - 100 mW e.i.r.p
  - 10dBm in every 1Mhz
* 5150 - 5250
  - 200 mW e.i.r.p
  - 10dBm/MHz per 1MHz bandwidth or -6dBm/25kHz per 25kHz bandwidth
* 5250 - 5350
  - 200 mW e.i.r.p
  - 10dBm/MHz per 1MHz bandwidth
  - DFS
* 5470 - 5725
  - 1000 mW e.i.r.p
  - 17dBm/MHz per 1MHz bandwidth
  - DFS
  - If TPC is not used, the maximum radiated e.i.r.p. must be reduced
    by 3dB.
  - Outdoor use only
    (Since NO-INDOOR flag is not supported by current format, don't add
     this entry.)
* 5725 - 5850
  - 4000 mW e.i.r.p
  - 36dBm in every 500 kHz
  - DFS
  - Outdoor use only
    (Since NO-INDOOR flag is not supported by current format, don't add
     this entry.)

These information is from [4], Mobin Aydinfar shared the official link [1]
(inaccessible from outside of Iran), a mirror version [2] and translated
version [3].

[1] https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-0050569b0899
[2] https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-doc.pdf
[3] https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-table.ods
[4] https://lore.kernel.org/linux-wireless/c9ccf5ba-c091-45c4-9283-970bfa4f1afe@mobintestserver.ir/T/#u

Cc: Mobin Aydinfar <mobin@mobintestserver.ir>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index d56ad32d31c9..0189355dff17 100644
--- a/db.txt
+++ b/db.txt
@@ -934,9 +934,12 @@ country IN:
 	(5470 - 5725 @ 160), (24), DFS
 	(5725 - 5875 @ 80), (30)
 
-country IR: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5735 - 5835 @ 80), (30)
+# Source:
+# https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-0050569b0899
+country IR: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW)
+	(5250 - 5350 @ 80), (200 mW), DFS
 
 # IS as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.25.1


