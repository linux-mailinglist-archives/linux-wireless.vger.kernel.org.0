Return-Path: <linux-wireless+bounces-26601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4544B35075
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 02:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E674D1898E26
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 00:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA326E712;
	Tue, 26 Aug 2025 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ2peyw4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD026AA83
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169079; cv=none; b=jptZhOuDhDr73dY00Nq05aZcwqFyyghihjCrEupKP2TKs9OEwenlzgwP/vf4xGdGoQCPVz7M7gFb59i4gPdSO+PMMTehXW0LvbHkoqglAb+isaWtpn/akQ5XwQeVAR0KqR10xbXw53vFtzRPCbzKhKcLaG7NEnJie+/Vn5qwpx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169079; c=relaxed/simple;
	bh=DdKtdrsF35lC69OY5hugpNnV+Y0b2MXd2WEeMETdJiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JWhxxP3NF3EcPkAXKiFijuXBzRgOjhxXYalhEbKaAD631mbnL/vwC+cwUXYqeYjOCLET1bya9cSvSm/5tx9ntl9s7qy3ZycJ6iLtk137nKUH1L5/cZ2DQdKyRFjUYJGyqewh3ZOu+m1hVgBenuCa0yrgym700dwTgqn0s6KOsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ2peyw4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323266cdf64so3683525a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 17:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756169077; x=1756773877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfoEmh4Uuip6ADGAXS4EdiQ5FAWw3Abck/YKH3Nu1NU=;
        b=XJ2peyw4mLgiqK7cBgEwdYanat+8vzJVcRg8BcD1yD7LLdTUv7lfZ4Rdz4vuNvehui
         CqWhJN6qpH9o/VOXyNV0ZeUAs3GWDaM9dirSig+ns9MZy4oLRVAf4vfyjRQlhMP6qxPp
         +0jsDXFnl8lloXK1qVTfprvt4wsG9JAiEHZs85iNUvmhiKet3J4VJOb33t5fvww7bDJo
         K1l+bfY7Y6A9N3JdoI+AZETaLJpsQKawZ0Q6KvwG70dmlAHgWtXACUuoQAdfe5vIAHYD
         VMDq83Jv9+f5kGHwyNSkM5uk2Joo0pvXSJvGfvAl7PbrMTGGqnwMOvfkhVnXEQrHnAqZ
         E3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756169077; x=1756773877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfoEmh4Uuip6ADGAXS4EdiQ5FAWw3Abck/YKH3Nu1NU=;
        b=qxx/3dCKKDBE75dMGJC2RBpSk3k3Uux8VbEt3GAahXMuE3ch8hWUEUJeZElufzQ7XA
         eSCo7G7pYaLIuiOuPNnW0YHJCXSikxgzgY8pE3Lux/2XAD99ZshV0JZZZu48aJCqcRxI
         IJYoaUrhkmCeCjKDJJpMnwCJCvR5+PF1xGttkA03qrBIB6WFc0SRwbUQ31p+T3RseZQO
         Si+PfKJVxOwAMqVe1+Z1kY+sNTnlgjQ0vN5Q8LFi3xD+PPSXf33wadW1OyHrLRdqQTyN
         327R/pK8pqVKipCrVynFZtSK17LKjxbkZDcJKAEASpdkahgTZS1D8cZJo4kAPZBb43uX
         bl+w==
X-Gm-Message-State: AOJu0YxtYYlnoEAawvCjIyUhVlwn8yGyR8le5DHOUdTHaLP6X214IOhi
	QsHkYlfxsQvNmedktw1RMp3G4TVdtFg9GBBxR0Mlli97C30fFzLB4ic6l0ndMSl7/TM=
X-Gm-Gg: ASbGncvEVTaRe6GbnOFYcxgnYl8zRIX7DgoEHZmkEOpunOzb+ispdJ7wmevyUrUXXg7
	vmW9+z5Q/uKAPzrGqFJ13yNYr5fu4blqDaGtvZTnrg6Z3G5H8OHT3ZcUoGHXl8ZuKHfWjlpSbl3
	zTOBJDuEjU2WzKqWj4z/kt2tHAuonFH3r+hQYvLmsS6ihNAG2bA514x5uHz0kXWh2aadP970ZXy
	gq7jjYttfVSMEU5gEdko+Ja3M1+ko3zrhFe0fhgDF9mIlrhpwR/3609bm+t2Tw8YFPqpoL/5K1J
	yLr+VQL9lsWSRlTYXbyxBIxMgYBgdkqsuwq+ZdLld8DYY3NoXTdOex50g55rnESozM/Pfzo5qXR
	xsa6I0ebb06yPNiCsq9dUCXJC0/+LVYOChQ7MnLh4v4iu3f2iOjI2WiUN6LcJAKDJ
X-Google-Smtp-Source: AGHT+IEngbdobYXfg9n7+S7+eZStNJFF7/84NzqToW8wvN1e1HOQwGgY/5ULJOk+/J1zITuKLapwMA==
X-Received: by 2002:a17:90b:384c:b0:31e:d9f0:9b96 with SMTP id 98e67ed59e1d1-32515ef8acbmr18373192a91.14.1756169077177;
        Mon, 25 Aug 2025 17:44:37 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3254af4c347sm8131553a91.18.2025.08.25.17.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 17:44:36 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	avalon.vargas.centeno@est.una.ac.cr
Subject: [PATCH v2] wireless-regdb: Update regulatory info including bandwidth for Costa Rica (CR) for 2023
Date: Tue, 26 Aug 2025 08:43:42 +0800
Message-Id: <20250826004342.5363-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

THE PRESIDENT OF THE REPUBLIC AND THE MINISTER OF SCIENCE, INNOVATION,
TECHNOLOGY AND TELECOMMUNICATIONS released National Frequency Allocation
Plan (PNAF) No. 44010-MICITT [1], and effective date from 05/31/2023.
The table 22 shows maximum power permitted for the frequency bands:

- 2400 to 2500 MHz
  36 dBm
- 5150 to 5350 MHz
  30 dBm
  DFS on 5250-5350 MHz
- 5470 to 5725 MHz
  30 dBm
  DFS on 5470-5730 MHz (take 5MHz from next entry)
- 5725 to 5850 MHz
  36 dBm
- 5850 to 5895 MHz
  36 dBm
- 5895 to 5925 MHz
  30 dBm
- 5925 to 7125 MHz
  30 dBm, LPI, indoor only
  14 dBm, VLP, indoor and outdoor
- 57,000 to 71,000 MHz
  43 dBm

Avalon reported the bandwidth limitation of 20MHz causing lower throughput
than what he set country to US, and he reached PNAF about the bandwidth
limitation, resulting in no limitation currently [2].

[1] https://pgrweb.go.cr/scij/Busqueda/Normativa/Normas/nrm_texto_completo.aspx?param1=NRTC&nValor1=1&nValor2=99551&nValor3=144158&strTipM=TC
[2] https://lore.kernel.org/linux-wireless/7bfa8257d34642d7a1e35b3705720357@realtek.com/#t

Reported-by: Avalon Vargas Centeno <avalon.vargas.centeno@est.una.ac.cr>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - add units of MHz and dBm in commit message.
---
 db.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 2a2946f8d1bb..b29e719710f4 100644
--- a/db.txt
+++ b/db.txt
@@ -476,14 +476,17 @@ country CO: DFS-FCC
 
 # Source:
 # https://storage.googleapis.com/eleoscompliance1.appspot.com/public/PNAF%20modificaci%C3%B3n%20ALCA87_30_04_2021.pdf
+# https://pgrweb.go.cr/scij/Busqueda/Normativa/Normas/nrm_texto_completo.aspx?param1=NRTC&nValor1=1&nValor2=99551&nValor3=144158&strTipM=TC
 country CR: DFS-FCC
 	(2402 - 2482 @ 40), (36)
-	(5170 - 5250 @ 20), (30)
-	(5250 - 5330 @ 20), (30), DFS
-	(5490 - 5730 @ 20), (30), DFS
-	(5735 - 5835 @ 20), (36)
-	(5875 - 5925 @ 20), (30)
+	(5150 - 5250 @ 80), (30), AUTO-BW
+	(5250 - 5350 @ 80), (30), DFS, AUTO-BW
+	(5470 - 5730 @ 160), (30), DFS
+	(5730 - 5850 @ 80), (36), AUTO-BW
+	(5850 - 5895 @ 40), (36), AUTO-BW
+	(5895 - 5925 @ 20), (30), AUTO-BW
 	(5925 - 7125 @ 320), (30), NO-OUTDOOR
+	(57000 - 71000 @ 2160), (43)
 
 # Source:
 # https://www.mincom.gob.cu/es/marco-legal
-- 
2.25.1


