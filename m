Return-Path: <linux-wireless+bounces-15398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D769CFD51
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 09:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3026DB25776
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74688190685;
	Sat, 16 Nov 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIDkPDm9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10820DF4
	for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745499; cv=none; b=pp3vLRDaPekHaBCFkxEdsE2yCVvvemkek3Sl3DnjoqAQWgn10eMtB2YqjWr3PHknoJMynKn1I+IGIgFSszR2gXLsjOQknT/t+pgwmt0LtMHhSLrUeU2kztvRPLWmE50lJaJcW/cjhksv85Y5VyDZaMWA5ZfW2bKKnxbDD6CHtxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745499; c=relaxed/simple;
	bh=pmziwaDf1Oi+IljbdRn1EymZkWNpxgi0hn4gxMn4I6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sqky0zd40xKSkncss69hIh8IfJf8479/f8IzpUV6Z9X0IyHnp1YsVsQCeMDP2blHBIN3/i885b1270Ps2ZBWy3HybQSfC9fcGx0KFOF++G1x0lLlbcUgzHkXtwo70FMW3Yisxl7go1B/h4oP0LK+Ty4n2H2Hk3R9U4S5/owwXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIDkPDm9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72061bfec2dso314675b3a.2
        for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 00:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731745497; x=1732350297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wI5s4CZuvcmq2kH2NFj7Lf55gnF/3ikMJSmm8d1y6c=;
        b=bIDkPDm9dh+D4ty+xNM9CM6IzNMzKmnUFHtIdlUmaiHk52WAwgZH8A+lK3KVn6Rkye
         oJqzn2sLOHoG/3O52q1OXV2MhOSSfrJXBnC7XqmOdEIGkqDXxDE7YrROLF+AL3CxMRps
         hi0av3a+j05jHsBQeMXLTcGtVpec9lQj4Nc6TrYE1vPfhVT9EUH1yljvb5sJdEqqMFsy
         NnR6siTkEVz04/CoRLhp/39hh8z4xS3ygHZv+GlEbWT6wk3vZkzXlXeOIzgX6pVVYD5g
         Ld+x2LcTxfBVY/WJ/PbZ/XJ07N+042qWkIbNSy6w8mJQNVnavSHF3mXZn9lraJiItLyw
         vgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731745497; x=1732350297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wI5s4CZuvcmq2kH2NFj7Lf55gnF/3ikMJSmm8d1y6c=;
        b=Nk+Qn3znGr98sr74vQLspk6RKc7rALugaLni6nRtNpWXRdd/UdS8mfsBmbHEgGTOFH
         aZb1KCEG/0Ipo1URcn5/5RP0A8krq5kpjAg7286LL5tz36WTiPJDzFHUjxioo0g3XbuM
         LkFP/O1AB+fvs/FVZDsKMl5bBwXOY8V1rD3RjCwEA1jYLnSTxw40bre9Pj4k0EdB1eKu
         YJ3orXHKdrNvJvRqdBiE6+suoBgs2K3EiiojNsKz7PYbl4OccqNT59bJ+9SEEpTOKyDr
         yLeWkeDBSRtfxSjnagQKk8QWpz/Zhw755Bde75rbw3zurYTBSJ+jZvwlGh4cpM1sNh17
         pmtw==
X-Gm-Message-State: AOJu0YyLxZHGz4iKXHWvMJmyfD9z/noZvAEeWF2UhBlN+3UoSiYP8iJB
	oXyDzfJ68meLe3Gw6vTc9yfpNcHNodCQ6b0bIFxJcWRz/N2XiEDPOl2Idwcn
X-Google-Smtp-Source: AGHT+IFjjVdXIRE4mP/e67dY9BI8qNrx6Qx69NWuwuXYIMqxobLunMTVHIPdh/WdCy8fIWQOm7Xq5g==
X-Received: by 2002:a05:6a00:843:b0:71e:fb4:6c98 with SMTP id d2e1a72fcca58-7247709d088mr7996100b3a.23.1731745495652;
        Sat, 16 Nov 2024 00:24:55 -0800 (PST)
Received: from pkshih-B33E.realtek.com (125-231-72-119.dynamic-ip.hinet.net. [125.231.72.119])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-724770ee925sm2606801b3a.5.2024.11.16.00.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 00:24:55 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	combuster@gmail.com
Subject: [PATCH] wireless-regdb: assert and correct maximum bandwidth within frequency difference
Date: Sat, 16 Nov 2024 16:24:17 +0800
Message-Id: <20241116082417.8720-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Since kernel will reject max bandwidth being larger than freq_diff in
is_valid_reg_rule(), as well reject it ahead.

Closes: https://lore.kernel.org/linux-wireless/CAPGdDAmPp80VEZ0TG=cS3QAYKqELHfqChid0wYZ7eLAENFY86Q@mail.gmail.com/T/#u
Reported-by: Ivan Bulatovic <combuster@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt     | 8 ++++----
 dbparse.py | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 32b533e800f5..a12f931ef4b2 100644
--- a/db.txt
+++ b/db.txt
@@ -787,11 +787,11 @@ country GT:
 	(2400 - 2483.5 @ 40), (500 mW)
 	(5150 - 5350 @ 80), (200 mW), NO-OUTDOOR
 	(5470 - 5725 @ 160), (250 mW), NO-OUTDOOR
-	(5725 - 5850 @ 160), (500 mW), NO-OUTDOOR
+	(5725 - 5850 @ 80), (500 mW), NO-OUTDOOR
 	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR, AUTO-BW
-	(6425 - 6525 @ 320), (200 mW), NO-OUTDOOR, AUTO-BW
+	(6425 - 6525 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
 	(6525 - 6875 @ 320), (150 mW), NO-OUTDOOR, AUTO-BW
-	(6875 - 7125 @ 320), (150 mW), NO-OUTDOOR, AUTO-BW
+	(6875 - 7125 @ 160), (150 mW), NO-OUTDOOR, AUTO-BW
 	(57000 - 66000 @ 2160), (20 mW), NO-OUTDOOR
 
 country GU: DFS-FCC
@@ -1646,7 +1646,7 @@ country RS: DFS-ETSI
 	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
 	(5470 - 5725 @ 160), (27), DFS
 	(5725 - 5850 @ 80), (24), DFS, AUTO-BW
-	(5850 - 5875 @ 80), (24), AUTO-BW
+	(5850 - 5875 @ 20), (24), AUTO-BW
 	(5925 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
diff --git a/dbparse.py b/dbparse.py
index 5f7e08200fa0..b27690166427 100755
--- a/dbparse.py
+++ b/dbparse.py
@@ -218,6 +218,9 @@ class DBParser(object):
                 self._syntax_error("Inverted freq range (%d - %d)" % (start, end))
             if start == end:
                 self._syntax_error("Start and end freqs are equal (%d)" % start)
+            if bw > end - start:
+                self._syntax_error("BW is smaller than freq_diff (%d - %d) (%d)"
+                                      % (start, end, bw))
         except ValueError:
             self._syntax_error("band must have frequency range")
 
-- 
2.25.1


