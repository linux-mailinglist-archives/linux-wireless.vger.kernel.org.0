Return-Path: <linux-wireless+bounces-28327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA0C12A21
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 03:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA2784F53CE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 02:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9D1A8412;
	Tue, 28 Oct 2025 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="H9mKiUVX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E792DF68
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 02:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617352; cv=none; b=g1KY7VtMy+x8jLMFuCPcMCYZUXZfYX8vBCJHYCmP67Vj0u4PeD842rqgx7/MyJ03xmXmH/Ifiw9+sGSXOxSAmOZjXOu7X87D/+tTnXOBjMSvbpLBr4qluI1Zdi/84NF7gMXe1OsxOjDAHcpiZsI5+Pgz33Al3rmprB/3VLDLcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617352; c=relaxed/simple;
	bh=HuGqISG12kqWjCddLMtiUSxCEruCMqJ/e11aDb1Zieg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYhoBPbpdf4GRufLrPNNWD7eIWE5jo7mMAI1Av3C3ZTmqRCJByKWWX0ZbWDTiH+DvRkvIvbk6Vtg6Pv32/0q0xmsttrm7jNwQFp0XG9P0UgXypWROFsO8Js9qddLOmCFcMkyKADFGAHHUdwylP2Bxf3QqWef7tFYFkgS86Omyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg; spf=pass smtp.mailfrom=ndoo.sg; dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b=H9mKiUVX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6cf214a3ceso516269a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 19:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1761617349; x=1762222149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDPjYGcXz413BMEtPr/eFLPA6/i78BGY36YiaTonr58=;
        b=H9mKiUVXMtzEKmBPcF3pYoAutLRXQLYstLRMH/jkh9o6VqKR2ytpP5w116yhKS0RjS
         0nf02p22iwxuy2f2fJkDVCPtXOzvAYr7ZV+G+M3kSBrOvUNT6vltLr1uIrYbRoKu6ZTd
         tc0Fw+7MbbBaAy1an4aykbfbrpTMmZ3By5Wyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761617349; x=1762222149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDPjYGcXz413BMEtPr/eFLPA6/i78BGY36YiaTonr58=;
        b=IspM30q8c2idrdR/Gt/JZwKT2102BGpK5MpUNGrP3wcl5YFE58pIx00NxhewW6IMs3
         EE4qJutQzO/NEWQvudVlsP/ErxrIIgilDEfzQpEFJRViMTuN9dFY9Sb+Od4TxTQUioIh
         7TNCoHgkzFH0Tu31ww42FmfgSlFVcXzU8Wtgis8d6WZTZJCDIeRSu7g5UG8o6auHfFCk
         prdF8551u0luhaP5sHHaE+eP16cR82aHtHC+wZU2fp1X54Rr1awWcdpLaV1iCy38bZ2W
         ZgIanBn9K6bXDESi2uaWctT/B4wnV6BDXdiLmU+Raw26+LzWgU2TaSJYpSdY2eZOCusF
         K+BQ==
X-Gm-Message-State: AOJu0YzKhB4+9fZhOMMQyNQLb6VjGJ+0e7aT9bbAdu2RkaZQe4mb9PFa
	YGlJwM34dT83BaGEm5dPBs0WHZHjehN3xVTNrasQIefh8d9Dr0+KIB/vPazWJct54YfdxcLEdkf
	v/TU=
X-Gm-Gg: ASbGncujM64QUmovVCbBFohXUC7zAj7eQ6F9W44xOQD6r0OnYzsdJYzSeweaa89Iibt
	Tc4qANmywLG7VwTxlnMqalh2yGWbAHXuzwHZLEL9htBbdCg84g4AYRzWfxcrFqLgoMmiQkoZd//
	O87z8O/yYwNXLVP3sPMQY2oxmFgXeG6I53feUxL+K4vtTWcR8OV3vRXUoSyxeYnXjUhn4R7ja3G
	3p+HNF+gyL1tHBQ2Dp4jeovlWfGVOZhLCZYp9NM/wv30t6TIZZj7rpdJzvo9fdwIO7GXcZboVab
	QeQZLPtAOD1lU0HLi7HJWwffxjBkrrSbBokk9RmjOVpEe7nacJ4+hA/2l/mlfDJ/9TQTR9Be/4l
	sveDjl0E22JoSe/D4nb5NK5PSfQrTKwnpEqilafvoLD0l6rPxIVWE6Dg9x2tDRaDSQEYQeMQATX
	fNlNKn8U3FQLItZRfkXgW5C+W9yBLvG+HkrMBuGdCobllETQ8zn7qHGNhg8KNM60aSdTAfTNzDb
	+lZrA==
X-Google-Smtp-Source: AGHT+IEESyFigmifFi+Rj8ugy24JBYOUq7NzGTqrrb9m5CTGP8BtwuDdoO+2b5FtujpZEayf74JllA==
X-Received: by 2002:a05:6a00:39a6:b0:7a2:6f23:91e1 with SMTP id d2e1a72fcca58-7a441b79347mr1164507b3a.1.1761617348773;
        Mon, 27 Oct 2025 19:09:08 -0700 (PDT)
Received: from localhost.localdomain ([121.120.74.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068cdcsm9865142b3a.47.2025.10.27.19.09.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 19:09:08 -0700 (PDT)
From: Andrew Yong <me@ndoo.sg>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Andrew Yong <me@ndoo.sg>
Subject: [PATCH] wireless-regdb: Update regulatory info for Malaysia (MY) for 2024
Date: Tue, 28 Oct 2025 10:09:01 +0800
Message-ID: <20251028020901.44906-1-me@ndoo.sg>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Malaysia Communications and Multimedia Commission announced CLASS ASSIGNMENT NO. 1 OF 2024[1], with the following changes to wireless SRD frequency class assignment(s):

5925-6425 MHz EIRP has increased from 2022 assignment[2] of 200 mW, to 250 mW; refer to page 10.
5150-5250 MHz EIRP of 1 W has changed from 2022 assignment[2] of indoor & outdoor, to indoor-only at 1 W; refer to page 20.
5250-5350 MHz EIRP of 1 W has changed from 2022 assignment[2] of indoor & outdoor, to indoor-only at 1 W; refer to page 20.

Update limits of existing entries accordingly.

[1] https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment-No-1-of-2024.pdf
[2] https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf

Signed-off-by: Andrew Yong <me@ndoo.sg>
---
 db.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 1d17271..a65910a 100644
--- a/db.txt
+++ b/db.txt
@@ -1450,14 +1450,14 @@ country MX: DFS-FCC
 	(5925 - 6425 @ 320), (12), NO-OUTDOOR
 
 # Source:
-# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf
+# https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment-No-1-of-2024.pdf
 country MY: DFS-FCC
 	(2402 - 2482 @ 40), (500 mW)
-	(5170 - 5250 @ 80), (1000 mW), AUTO-BW
-	(5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW
+	(5170 - 5250 @ 80), (1000 mW), AUTO-BW, NO-OUTDOOR
+	(5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW, NO-OUTDOOR
 	(5490 - 5650 @ 160), (1000 mW), DFS
 	(5735 - 5835 @ 80), (1000 mW)
-	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
+	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
 
 # Source:
 # https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
-- 
2.50.1 (Apple Git-155)


