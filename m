Return-Path: <linux-wireless+bounces-3421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A498509F4
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 16:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6AF6B20C05
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661DE1E507;
	Sun, 11 Feb 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fhe0IhPT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9265A11C
	for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664269; cv=none; b=rcwAnyse2PSLWU6PwOXBnIbRf6A2fGvhdjyhjzSAf7qm/i1Al+I6xudkGs1vfTQxOrcJZjj4GgAne5VQsQB8otkYsBcvhsvK4nBsbjfyrd3f1Uv8eAKWqOO4iciuvIFIafO9O2CLQXhqO7OYc6Qcm2E2EmQNad84x7K3+d3cftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664269; c=relaxed/simple;
	bh=wzUM8NwNNyIQtax7Poodq9Eft+NJ223T38x8M6UJUEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KV0k29IbZDgYmpF9rwHv7MtKxxrxsHt+KCcGjLd7BOYTidow429lGS54/nPzVDhq916Nb0xI5gEHqvhwH+XDuteON0UDN1GaijL+pkcmMW+u8q3PGzUDbE65td0PR2TYUqxPGmIg5OfZRDVaGmbagB1jrV1+qKh+qMi97WBvArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fhe0IhPT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41097f9a9a4so7424415e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 07:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707664266; x=1708269066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ereKpYdLrSaaOEa5xs7M1T2/tfEfvgSZWOY7DvZi9OI=;
        b=Fhe0IhPT0ZA0rtrKUYCWBNaiivaGwoujzrF86ImqEf87xz3uoDGWtTYM3NCWCNB5Zx
         noSITAg3UzTvziwXWcj0DyIXE5V5qW2QiIf9p8U4ANJoTw97//qukZWiVXaEpdZbsUvd
         xVQ3b093OR4agtE2fi3FFvthnRufPYs+prMdRv2xjx01LN6aRG4x+KNqPtey8NTlDEXZ
         562CNA/LHiisUBarZtsmqDBGvTk8aZex5AQrI6xYIJpQNDZ44vtj5P0poAh13e3MN/eW
         Oxj7VJhDYv5WpVsfIuiCP7fDU/C0j23J3GeHZT2fxc0AscFZd/e/QUgRRReLFIx9fgTP
         81+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707664266; x=1708269066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ereKpYdLrSaaOEa5xs7M1T2/tfEfvgSZWOY7DvZi9OI=;
        b=oREZBg/TNoZiICOqVswrnWQHv4UKWJt2wRrAz193OLFWSd5f7MZWjihHmBh8GTX/Hy
         TGR1YSu6T3R28H061gTak1KMgFA+v2BZ4CdZZoDdTwdEKY6JcBpFKGB5rNPAlj6P+Yu5
         hy9sDoiG6Lqx0Mgnx2thH3VflShrO+PYGC6FI6YiwQH6EVcRcPPjos+Zehe/ZnkHvwIN
         qPoqmYBY7vFKMezxi6/HTPaRn8s514gEJ3XDjW97qAn9LkX3zyze6wzalUhr1OjTUgZH
         9ifxnzamX+dkKWiBiGe8AiLbks6uK9kwPSHeDVv2Y2/tsRWIGs1rFI9VCTiXiRfzDL2N
         ZOeA==
X-Gm-Message-State: AOJu0YyGyULeD0LdaMWu2v6jHOFNG+cBEYzeycuVN/S6Lt5OZrYmCCUO
	bWbjPHPCtL3LF8t6nSx5YMulq//hkotrV/V7V0Ioppc8hSBJPR2W
X-Google-Smtp-Source: AGHT+IG4ENqfTMl/QDlO2wMczjF5TosO6T+Na4EuQRiiRB1auNm5e64Gu/ZjATk92+xSlqaBztqibQ==
X-Received: by 2002:a05:600c:4ed0:b0:410:c127:62fe with SMTP id g16-20020a05600c4ed000b00410c12762femr1176907wmq.1.1707664265701;
        Sun, 11 Feb 2024 07:11:05 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b00410d41f1d96sm384272wmb.34.2024.02.11.07.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:11:04 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: remove the unused scan_events from ath12k_wmi_scan_req_arg
Date: Sun, 11 Feb 2024 16:11:04 +0100
Message-ID: <20240211151104.1951418-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As done for ath11k, lets keep on cleaning up struct ath12k_wmi_scan_req_arg by
removing the unused scan_events. Also remove the underlying union & struct
construct as it isn't needed anymore. No functionnal changes.

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 31 +++++++++++----------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 892f21f95ee5..103462feb935 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3281,24 +3281,19 @@ struct ath12k_wmi_scan_req_arg {
 	u32 vdev_id;
 	u32 pdev_id;
 	enum wmi_scan_priority scan_priority;
-	union {
-		struct {
-			u32 scan_ev_started:1,
-			    scan_ev_completed:1,
-			    scan_ev_bss_chan:1,
-			    scan_ev_foreign_chan:1,
-			    scan_ev_dequeued:1,
-			    scan_ev_preempted:1,
-			    scan_ev_start_failed:1,
-			    scan_ev_restarted:1,
-			    scan_ev_foreign_chn_exit:1,
-			    scan_ev_invalid:1,
-			    scan_ev_gpio_timeout:1,
-			    scan_ev_suspended:1,
-			    scan_ev_resumed:1;
-		};
-		u32 scan_events;
-	};
+	u32 scan_ev_started:1,
+	    scan_ev_completed:1,
+	    scan_ev_bss_chan:1,
+	    scan_ev_foreign_chan:1,
+	    scan_ev_dequeued:1,
+	    scan_ev_preempted:1,
+	    scan_ev_start_failed:1,
+	    scan_ev_restarted:1,
+	    scan_ev_foreign_chn_exit:1,
+	    scan_ev_invalid:1,
+	    scan_ev_gpio_timeout:1,
+	    scan_ev_suspended:1,
+	    scan_ev_resumed:1;
 	u32 dwell_time_active;
 	u32 dwell_time_active_2g;
 	u32 dwell_time_passive;
-- 
2.43.0


