Return-Path: <linux-wireless+bounces-14242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998F69A5C53
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 09:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F81F22D63
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 07:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D511D14E5;
	Mon, 21 Oct 2024 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqPgmzUs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253C1D1310
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494925; cv=none; b=sjbzCySy0iO+ATqBbn089I8Vb0QIIO0JawLRoH0lvbIAt7c/q4Hgv5g3jlUq8/gL3XdqSxepkBmPLuKlgW+XCwYxWnacMuNQHEKDv0MZ3BBc/zcboyxOOeFeWQsA7/WAPPk9xXSTdtwk9pwnEa7iWgGptn1CSfpx2XkOn/83iEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494925; c=relaxed/simple;
	bh=g6PPTxJfZU+9A6ObiJcEMuDBUKJ0+PDS+0+qjPxH4i0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LoMrK3rUG+baw1OVVHbTIcaclRUl0nDpq1aLl6yo7saPyefviM8iNb2NHXxGx2nJdCAn8E8pH2fFS0D9nrBOhrWuLQL7P9F+klrOyZfMtKBFL2eND3igakcZUh5EQX2Hqj1ApbdQd68cHksH9AuRVKQwyibEbxEHJxTw/YlzHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqPgmzUs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20e6981ca77so24106045ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 00:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729494923; x=1730099723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkeOc7cfVOIbP+Run4GnrPC5KIhzOGmW2fBCzCngoXE=;
        b=dqPgmzUs+Uw4a9V+/5XBUfTjF10KDFcmK1hmB7hmK6yPK2szqXva7PUsjhzIlldyQH
         0ocSl3p5FzSQgJuXZDuvA8x6yqxdITfdL+1XYWjL1c4IC8tblx0X3NZ1oU4zZwF2MvEK
         M5WJrHrwrZMT6rVBd2rZu7lUoEBZdwbK2Cb8SSUXgdnpb8XExaUzb40PRk6BEHq2dy4+
         aiR9c5WAHey614WfuWVIebcsgy9pVPNRhB6g/VK9NbYRp0aaqlmb7/DbuEIQwe0Co2iu
         cXKKkjLJkNUZdhCR4yQa1SP3523UcwpKW3K08vllX0ripRK6X9bEjyebynSxEVCx1M5o
         fxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729494923; x=1730099723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkeOc7cfVOIbP+Run4GnrPC5KIhzOGmW2fBCzCngoXE=;
        b=WcgJu5vC0Z+JxqHLyPhzIrk0m47AFeyj44b5XMdhCTS2BJclN58jYFdRZi5KNNR/jg
         NxQZOkHakpF9oSDQADkc6Kf19ngVfpx8jdycoVxGVxvE2pjGUu/i1tw2zl1HrnT3CnHT
         ++1WkVZlyrnnYdcAosSUhtW5l62IPnjYAZv1Z2KwppZpnGXxVxNa6p/unD/smQ+iq3Za
         wRfqpSI8xOTgXwQaUEpzSP/Gkc1WU3QQ3/UjJRuUk9Vi7RhyJp86mTLQtXXzZeFWgxBZ
         Ic1qKBy5/uZcbtb2kOLkYhTJ/QXRMBntqs7eqey7dIocVsoY08/WB9HzxOLfo+cx6s6h
         IX9A==
X-Gm-Message-State: AOJu0Yz2kbJN9x2Tktu8+qztpNfhuIQLtmk7J5ecsCkgI565i28r18v7
	3FF57oSI5VUFMq4OkrknZ/aqT8TY1kg+Rvjk4CltPqC3BdJ6NeTbOSKHuaHU
X-Google-Smtp-Source: AGHT+IGFHU4wYoQlhJAvvlVJDQvCiFCQfB26WJQ7/VeCuSx9oH7SYqIlsO9VgEATYBiLrynWGS/zew==
X-Received: by 2002:a17:902:ce0f:b0:20c:f261:2516 with SMTP id d9443c01a7336-20e5a70d0b1mr171296365ad.8.1729494922856;
        Mon, 21 Oct 2024 00:15:22 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e7f0d9a7esm19550805ad.182.2024.10.21.00.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:15:22 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Oman (OM)
Date: Mon, 21 Oct 2024 15:15:06 +0800
Message-Id: <20241021071506.24320-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Sultanate of Oman, Telecommunications Regulatory Authority released
Technical Specifications for Wideband and Broadband Data Transmission
Systems [1].

* 2400-2483.5 MHz
  - 100 mW max. mean EIRP
  - indoor use only
* 5150-5250 MHz
  - 200 mW max. mean EIRP
* 5250-5350 MHz
  - 200 mW max. mean EIRP
  - TPC: if TPC is not used, then the maximum permitted mean EIRP and the
         corresponding mean EIRP density limits shall be reduced by 3 dB.
         (20 dBm is adopted)
  - DFS
* 5470-5725 MHz
  - 1 W max. mean EIRP
  - TPC: if TPC is not used, then the maximum permitted mean EIRP and the
         corresponding mean EIRP density limits shall be reduced by 3 dB.
         (27 dBm is adopted)
  - DFS
* 5725-5850 MHz
  - 2 W max. mean EIRP
  - TPC: FWA systems operating in frequency band 5725-5850 MHz shall
         employ TPC with a range of at least 5 dB.
         (28 dBm Is adopted)
  - Outdoor use only
    (Since NO-INDOOR flag is not supported by current format, don't add
     this entry.)
  - DFS
* 5925-6425 MHz
  - 200 mW max. mean EIRP
  - Indoor use only
* 57-66 GHz
  - 40 dBm max. mean EIRP
  - Indoor use only

[1] https://tra.gov.om/DownloadFile.jsp?type=DocumentList&code=474

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index a9a9ba48f42d..32b533e800f5 100644
--- a/db.txt
+++ b/db.txt
@@ -1463,10 +1463,12 @@ country NZ: DFS-ETSI
 	(57000 - 71000 @ 2160), (40)
 
 country OM: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
-	(5490 - 5710 @ 160), (27), DFS
+	(2400 - 2483.5 @ 40), (100 mW), NO-OUTDOOR
+	(5170 - 5250 @ 80), (200 mW), AUTO-BW
+	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
+	(5490 - 5725 @ 160), (27), DFS
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
+	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
 # Source:
 # http://www.asep.gob.pa/images/telecomunicaciones/Anexos/PNAF-dic2015.pdf
-- 
2.25.1


