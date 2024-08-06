Return-Path: <linux-wireless+bounces-10984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C7A94870D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 03:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB071F21DC4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 01:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5AF3D7A;
	Tue,  6 Aug 2024 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVoP/heg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50B4685
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722908486; cv=none; b=eLSeZPCgrOrVAy1gikSBNstiwqztvxkU1f8HlPG4TKw1UYjV68TmKmXa++hqk+2tiBmW1H9E4x8IVdy1c56HP5kVYpBUJEqDidbILA2P8PZrEfQMLRLw5yqDlOI/6a1zJM65DZrnkcHBoQ1E8f+8YMjdJcK6PBTX0u7JYEXVT3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722908486; c=relaxed/simple;
	bh=hJKgg8CCu2igWkSUacDV7gmap9brjZNtT2H6wKLrVwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CwswTHXwCjkPOoC7qAdM958YuGMTTwlXLcF4OCC3RUlwywxpVWsVMlVkO83WnorZxUSgyrzhhb3+WzNuVWy3UN2WhTM05ojlvT1VkiskzIIudaYNOswi+ME9SD0z9WSQ49sq2yzaoGd/54G36JGNCrOvGbW9fWTjd7Hn8Af750o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVoP/heg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc587361b6so513805ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 Aug 2024 18:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722908485; x=1723513285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FFYqZlD61J1XKPI8ZI8UjX7kHI2kRP3uf64n1IZUVZ8=;
        b=EVoP/hegSaxnGcI9FUptYpxy07XP8yo9AGnrnObjWEvyJslzGM7T0uRHRiZZ7ZFKcJ
         ZV3pA+W3cxJHKf2t/x2LGdl3prPMzacZ/UeEkEAsN+iIYovTqmIE0jrFzDwyMEW3jtbE
         jKDoAQ9j0LkoCKAMJE7rYhP2tpgO3SMcFQibeoVLz3FaC2LmEhNEvH7RbenLsGt44icN
         +i3nQw1TUa5TLQv5G2Y5osdOMk76zJXrrVDqyMlMWncvJVocwzWVPz7pLkw1zQgsA4MM
         H3hkKA8I5Upj5la0QJKpWDWHTQS7KeqQTvwQ2vgwPo6kVijB9aLIFPKgWua5R+F2BMHL
         Qz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722908485; x=1723513285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFYqZlD61J1XKPI8ZI8UjX7kHI2kRP3uf64n1IZUVZ8=;
        b=V9XiXBr2vT3zsigG9xs7NdFhD17f0Rh/GamuVKS2pKnNMGGFfNZV0xtqF+hOG3fKJa
         mCV0CMwAVmA3VVVbD3FVk5pSx41Ir7KphwOYWiRTjk4Tba5onZyzJvGJoZFgzg6ZHXSY
         +ADtQI7nYUSZvk5JcWJUACdWSYvYWrDfWjimlm/OPOFgl5nSSA+XcCaTElDW5ANHCttd
         cxbj9X/bBMWgtcuQWOp77+G5e9WMXTMNbxrjEJepB4ILFGVHXf8FyGINw/mwpoA41Dp/
         lz8E8e574tC/u9pEAe2VjKoPkYp9Xfna/lWbJ6ci8ODcPUTMVotV2ZcN+dCi8Wu24/47
         zrIw==
X-Gm-Message-State: AOJu0Yzbj/8m1JmBzK0bHL9rITq0VWSVGw+iDZaTRCdmmu3/ngqGB175
	Syb+T2AiL7RgLPWXDCmo8ynXGztjH7/ZUBD1MFs8Pgrjb/GGTfTvw8DZL5UV
X-Google-Smtp-Source: AGHT+IE72hNPuekbGVd95RFLEjUrCmMZMGYrsr+qmcDGgp81iYD1k2cb9FLjsXG/jdZxWdhqj9OHlA==
X-Received: by 2002:a17:903:280e:b0:1fd:ac9f:4050 with SMTP id d9443c01a7336-1ff57387114mr98747515ad.35.1722908484694;
        Mon, 05 Aug 2024 18:41:24 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff58f556c8sm76004845ad.94.2024.08.05.18.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 18:41:24 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Bahrain (BH) for 2024
Date: Tue,  6 Aug 2024 09:41:09 +0800
Message-Id: <20240806014109.5258-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The Telecommunications Regulatory Authority of Bahrain (TRA) announces that
Internet users in the Kingdom will soon be able to benefit from faster and
more efficient Wi-Fi 6 technologies, allowing them to enjoy the full
capabilities of both fibre and 5G. This is in line with the Kingdom's
adoption of radio spectrum ranges 5470 - 5725 MHz and 5925 - 6425 MHz
for Wi-Fi 6 and Wi-Fi 6E applications [1].

Find "Technical Specifications - Requirements for Type Approval" [2] via
WEB page [3]:

- 2400 - 2483.5 MHz
  * 100 mW e.i.r.p
- 5150 - 5350 MHz
  * 200 mW e.i.r.p
  * indoor use only
  * Devices must use (TPC) and (DFS) mitigation techniques
    - EN 301 893: without TPC limit to 23 dBm
- 5470 - 5725 MHz
  * 500 mW e.i.r.p
  * Maximum mean e.i.r.p density for in-band emissions:
    50 mW/MHz in any 1 MHz band
  * Indoor & outdoor use
  * DFS and TPC is assumed to be implemented
    - EN 301 893: without TPC limit to 27 dBm
- 5725 - 5875 MHz
  * 2W e.i.r.p (10 MHz channel)
  * Indoor & outdoor use
  * DFS and TPC is assumed to be implemented
    - EN 302 502: The FWA device shall have the capability to reduce the
      operating mean EIRP level to a level not exceeding 24 dBm for
      ChS = 20 MHz and 21 dBm for ChS = 10 MHz.
- 5925 - 6425 MHz
  * LPI 200 mW e.i.r.p
    - Indoor use only
    - An adequate spectrum sharing mechanism shall be implemented
  * VLP 25 mW e.i.r.p
    - Indoor and outdoor use
    - An adequate spectrum sharing mechanism shall be implemented
- 57 - 66 GHz
  * 10 W (40 dBm) e.i.r.p
  * Adequate spectrum sharing mechanism shall be implemented.
  * Fixed outdoor installations are not allowed

[1] https://www.tra.org.bh/en/en/article/bahrain-approves-radio-spectrum-for-faster-wi-fi-6-technologies
[2] https://tra-website-prod-01.s3-me-south-1.amazonaws.com/Media/Documents/Publications/20240227160125242_dudbapc5_5dk.pdf
[3] https://www.tra.org.bh/en/category/apply-for-type-approval

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 4eaeaae616d8..e46beae64ca4 100644
--- a/db.txt
+++ b/db.txt
@@ -280,11 +280,16 @@ country BG: DFS-ETSI
 	# II.H03 of the List, BDS EN 302 567-2
 	(57000 - 66000 @ 2160), (40)
 
-country BH: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 20), (20)
-	(5250 - 5330 @ 20), (20), DFS
-	(5735 - 5835 @ 20), (20)
+# Source:
+# https://tra-website-prod-01.s3-me-south-1.amazonaws.com/Media/Documents/Publications/20240227160125242_dudbapc5_5dk.pdf
+# (via https://www.tra.org.bh/en/category/apply-for-type-approval)
+country BH: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5350 @ 80), (200 mW), DFS, NO-OUTDOOR
+	(5470 - 5725 @ 80), (27), DFS
+	(5725 - 5875 @ 80), (24), DFS
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
+	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
 country BL: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


