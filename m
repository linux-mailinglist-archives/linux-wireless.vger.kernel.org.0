Return-Path: <linux-wireless+bounces-15425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8B9D0778
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 02:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7756EB21234
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 01:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518E8BFF;
	Mon, 18 Nov 2024 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/DXbBbf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B351CABF
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892544; cv=none; b=eeTCXymR7jZfO9NxR2T4D+tFIZ6Q6tVMJOcpR+22E7CFbJd6fYGre2bZ6F6MqbOxc18iD6zJYOb/yEbiihcndMEG0TBlQ0UPe+ZOJZILkaMkLnO1rJg5/Ar/DqyZHdl/t2FyQYHDpI8Lj3KbCblYG89TCeeu+oiWa1VdlS3IB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892544; c=relaxed/simple;
	bh=XRXdkeG0R1Jb83ZotHhw5eNwxeq6QNkar4rG6tKPN3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W/EZXH2nRzqSnp8pQi4/E8KAldxKAqiim5FJhamsg4qBWVqZtu+bQFbsvFkZrn2bxYcjEzeEgImOgTDY9TTtcwzAcVGqr6PnwLrni9x58MfjBfxJ212bRe3Hu7As6hRL6dOo6A4nkfKAGiXWbFSPytjXO5kdzyDOdmFOGTFmi8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/DXbBbf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cdbe608b3so35348925ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 17 Nov 2024 17:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731892542; x=1732497342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPvbM/1Org5zA5PTJcwJfAFYw9QBO2dGb+35/MNO3qU=;
        b=V/DXbBbfpmwjooaaDzqktdnXfpVRhBMAD3+mo75sW2G4lxgVO+8Lg2ArViWK4/jLBf
         9gtjW5IOhopyxft7zAdaHR/AY/qFp4YNbB2rbprpdonfAga0Ux9F+rnq1MaGqB/HhjiB
         FSqGPIcQ05d7fOY9/P29DE9EGTB1w3p1y8/86brfj/xWR4IKCjqCSHX326++AD3F8I5j
         chzqt9F5O8UldmVP0x1A37o3LTPKsDvO/qdc9lVWHo9gAg+WSloEObdkzFypYjjcp6UT
         qNW+wq38VrTY4mLcbvar7qWuJ2ZnKYotnSzl3KMfmIhO3sCmsOhZ3VGT9A0WBcZk53vP
         ZqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731892542; x=1732497342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPvbM/1Org5zA5PTJcwJfAFYw9QBO2dGb+35/MNO3qU=;
        b=BQbzZdUEsIkxMiN1QgiXw55kK7PrxdAxDkfOXt1cYZ+23CEg73uLGXeXTgmt2pjkUP
         zMy1xh1sHDxf2PsM+qUZAtUKdCOtvR/EBl6V6iF6soodhvuVlgGmCPFZ/BsR/D4ZkfyM
         LlVDErnlUj9CU+165TLm3GVBPRV6GuBGLFVprQUEKU6N0zPvZ/GxzAVE8ZqXaqidSbpG
         Hzfz0x3bkwr6bcuEH83WKXhBfHFh0zrDaxbQyRM0fKuzB1DICn95Mpir75x4qPSvH1eb
         Ysy/o894WaUBD9yOFkOs7RbWucSutM9kZlS2aodOZmM5TeDqvD14QaCz+KHO4a5n8bXp
         rmqg==
X-Gm-Message-State: AOJu0YyXaZfuwxGxIbIa+elmZyr5f6YsqszXzOXHhWx0wcP5ld73fTZQ
	dJkCiN/+RnV/PjNhezhfl4bOZ3waqS/tRG3FFddg2FK6RU8LRtGOR+zCE41p
X-Google-Smtp-Source: AGHT+IEuVpkeX4oEwRAX+OaX4mD2P6edrPTrU79LAcwC8f/m86AhiZIeFOsWKnhDt+OhC5X1Iexjzg==
X-Received: by 2002:a17:902:f705:b0:212:fa3:f61e with SMTP id d9443c01a7336-2120fa3fb5bmr50342915ad.15.1731892542113;
        Sun, 17 Nov 2024 17:15:42 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-211d0f56f02sm45882145ad.272.2024.11.17.17.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 17:15:41 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	combuster@gmail.com
Subject: [PATCH v2] wireless-regdb: assert and correct maximum bandwidth within frequency difference
Date: Mon, 18 Nov 2024 09:15:03 +0800
Message-Id: <20241118011503.4694-1-pkshih@gmail.com>
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
v2:
  - error message in dbparse.py should be "... _larger_ ..." instead.
  - by the way, reporter tested v1 and got positive result
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
index 5f7e08200fa0..cc5012bc05bd 100755
--- a/dbparse.py
+++ b/dbparse.py
@@ -218,6 +218,9 @@ class DBParser(object):
                 self._syntax_error("Inverted freq range (%d - %d)" % (start, end))
             if start == end:
                 self._syntax_error("Start and end freqs are equal (%d)" % start)
+            if bw > end - start:
+                self._syntax_error("BW is larger than freq_diff (%d - %d) (%d)"
+                                      % (start, end, bw))
         except ValueError:
             self._syntax_error("band must have frequency range")
 
-- 
2.25.1


