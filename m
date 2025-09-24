Return-Path: <linux-wireless+bounces-27627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B136FB98119
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 04:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE0219C62EF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 02:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525EC14EC73;
	Wed, 24 Sep 2025 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI/hoF+P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9F21C9F4
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758680533; cv=none; b=Rt0JqAwaJCHRs3ccGA7NCsw9A5rqNFtmwBOxR3NVaJJzXgn+V56ooEa99PZms/A7/aMvwwi+M9NA6NKV6pUKhYC7ki8fxLZe5qxJGoLPnaNZnxIbYEjLG0Smk+Ks+hSmwFJntIxANlFVGrz0djH8l1Y8ftMfpBRonORLKyH2/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758680533; c=relaxed/simple;
	bh=48xlJyPaecwpKtV3z+pocqEJAsGk+sm9bf9JDDUsfWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r/2G+/GCpTKcFzqMn3Xe0686fbVU1q71v0S04Rf/uDXhPcwQ+gyj8k/q/zyO3vBW12XimoR6xF5t7ivQOkHpKupfxPcKKED+7nVs0MBbENbVcEPQaKYI5XZTwSFNYA32/QAfYu+/kdbWQ09U4e23VGadTs6rkx4iIr14WDboLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI/hoF+P; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27c369f898fso21185165ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 19:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758680531; x=1759285331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYCq9wflhhzhnDUF8WvUDHhqgzzzk+PVslZPJmJZp6s=;
        b=AI/hoF+Pmi35BtIBj086eKEmLHqV8P1CdMXsItKKWKM0gxUKuhLKEn9f8vCMQqq2er
         GY3YIKIEXKXJ0C1MLLgePTuCQqmrpaou96NbB0oXje/4O4dZGcE5bump0CZp0ukW0mZ0
         BOcdjISwESbLNV/BEeWZRBAsWdnrJoTAsNgibP0K7lww0CCBXeAaTQiHVpm0WdiUn3T1
         iZGgvR/WNBRLVCOeqI0+9UqLyaB4WXLQPffvvUD83nTAnaocV+hF1h76hhL1DzdUBuJl
         +sLN2A1maBbII9Ny6au1g7og+JxU6XKfGAw6689GboT2a3ZGaWEehBPeOe7n9ONIgz+Z
         y15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758680531; x=1759285331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYCq9wflhhzhnDUF8WvUDHhqgzzzk+PVslZPJmJZp6s=;
        b=louaszE5aDH3VsDiRahfhMWgLdOE9t0LxfWpZq8lsFc2mTbep1BDWnslDb6CMWWVjU
         8vU50j4Xk3aymNJqIaltBD6ihxYdPdt8KrYpM3yia+4uiRaEVKdQGdp2K+BU4p8f8ASA
         4Rw7RH+2k/CwquEuKSDvKzKdqEo+VljDvFranUNVTOP5N1TAl05HAqqGsKat42V9Yg+V
         y1VQ0cTIi8sRQPObktP9yViGRj5rVhiuKp+gO55bwo9pnSL7QzrETmWTIPqxu8tMTZa2
         7fozvIyJoex69IAzlyYhusdPrAteTGvjzZtNRi/KTrwUTTbjLvY3BeU8JanYeCosQzGl
         peIg==
X-Gm-Message-State: AOJu0YxR7zSfT0PW8wIVK6gHkUOmgN6iQXSSV7Den6KcNYjwR8ctJ1DL
	RO++KCdvZePz18fhw3dKyaun/IGs0K19o3eBDzVEmkCcHamNsR9fFjkrcrNlEUOX
X-Gm-Gg: ASbGncsRUrsfaifAgBTKZ/ESp1SX0uaHGihxiOQZI2ExJ8tdF/LeR+TJu9vkjN/N6mu
	Xg5jGJ9X/JkaCkZHCnK8vxLzfAVIKWuYzo3oWpH8WLQ8xJ6xHE6IFxUa7JSDMVlYmiOjioCDrTx
	b0Hs8LkO3Wji56wZOw7jv+9klRgFM2Tvm/vYg35HkqOH6U9BtwoD4zTAF6xR6k3CwfosRb3UmKY
	DfiFzoICn/ojOFpO5lQirTYeydj4CgVXEH8rHx0IillyJsYJ7OBCmXJvZtSn78FBmuksZRV6Slw
	SpLKVd3GoKGBri6ERqqSN0H67LiseucPoVx3wBlVq5OToutxlK9HrH29TOdMgFMYxJd5mSmj+BT
	d3FfkXl4IBvLxP+Vi2CMzIqqwO+yJNHbMgLz1NjqznNpHqCbE2AhmjXNQpLsmKFlH
X-Google-Smtp-Source: AGHT+IElyxzh/2QhT5a1mWe21RdR37oS2gsLVOzYlLQhwv/S9x2JBSVjhYgKNEL59+NuHo6aRuZPAA==
X-Received: by 2002:a17:902:e946:b0:25c:d4b6:f117 with SMTP id d9443c01a7336-27cc580e150mr53616165ad.35.1758680530876;
        Tue, 23 Sep 2025 19:22:10 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2698019665esm175523975ad.62.2025.09.23.19.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:22:10 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info including bandwidth for Trinidad and Tobago (TT) for 2025
Date: Wed, 24 Sep 2025 10:21:56 +0800
Message-Id: <20250924022156.8435-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The Telecommunications Authority of Trinidad and Tobago [1] provides
Schedule of Devices Eligible for Use under a Class Licence [2]. The
type 1 (End-user devices or customer premise equipment) with Schedule B.1
and B.2 shows

 - 2400 - 2483.5 MHz
   * 30 dBm
 - 5150 - 5250 MHz
   * 24 dBm
 - 5250 - 5350 MHz
   * 24 dBm
 - 5470 - 5725 MHz
   * 24 dBm
   * extend 5 MHz to 5730 MHz for channel 144
 - 5725 - 5850 MHz
   * 30 dBm
 - 5925 - 6425 MHz
   * 24 dBm

[1] https://tatt.org.tt/licensing/class-license/
[2] https://tatt.org.tt/wp-content/uploads/2025/07/Schedule-B_Schedule-of-Devices-Eligible-for-Use-under-a-Class-Licence-25th-July-2025.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
Hints to find these entries: by searching "Wi-Fi" with type 1 in [2].
---
 db.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 6e1ad30222a4..90ffa4e0d5d7 100644
--- a/db.txt
+++ b/db.txt
@@ -1946,12 +1946,15 @@ country TR: DFS-ETSI
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
+# Source:
+# https://tatt.org.tt/wp-content/uploads/2025/07/Schedule-B_Schedule-of-Devices-Eligible-for-Use-under-a-Class-Licence-25th-July-2025.pdf
 country TT: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (17), AUTO-BW
-	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
-	(5490 - 5730 @ 160), (24), DFS
-	(5735 - 5835 @ 80), (30)
+	(2400 - 2483.5 @ 40), (30)
+	(5150 - 5250 @ 80), (24), AUTO-BW
+	(5250 - 5350 @ 80), (24), DFS, AUTO-BW
+	(5470 - 5730 @ 160), (24), DFS
+	(5730 - 5850 @ 80), (30)
+	(5925 - 6425 @ 320), (24)
 
 # Source:
 # Table of Frequency Allocations of Republic of China (Taiwan) / Feb 2017:
-- 
2.25.1


