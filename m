Return-Path: <linux-wireless+bounces-26569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4C8B333AD
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 03:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A151673A1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 01:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1451F37DA;
	Mon, 25 Aug 2025 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bynNWUrj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311B1684B0
	for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 01:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756086494; cv=none; b=FsBf3gk8n5tX3pq9cegJsCO0Bs689/6OWYXfVIqgb0fusHoBUv3Dz3IgQ+yuHoQh9rMT33WrBTEwa5ZwaspJUse2HTCfNl2IIAr3Tmh18ZTTn6nENaE569nA5CdEAsEUAYKMSkYemOkRWNWEvAXcFUG5QYhurAtGElShUnTJ9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756086494; c=relaxed/simple;
	bh=xyt/DByFGw7AI6XJ3W9ZxGKagv9Tl5rvvpMEW5XuAyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jpCUnCtMyT4DLnltMbhalOzjXTfHT0If3i+qgYxBBQunFW8u2NzJPSpuahCJclYlTZT2T3LEDzDJNUaymcey7+lRmTtqNsPyAMfqFlkH9ZrYfkPWrFFdo3iWwHaw7JxKe1TZHg3s4Q9aNsQNH8sUSfJkJNAqAnyxXOI3myD0tNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bynNWUrj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3252589a4afso1866812a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 24 Aug 2025 18:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756086492; x=1756691292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKTKi30DzOZxoemkQY+g9NWqObH7qRITcl76FpX3784=;
        b=bynNWUrjGNuAjTm14mIrq1V26DBEBTYTNukoW2Bf5Rjv4WB9o8Tqt6A7MxDrLbBOZ5
         KyPbBwDslo92XfKYonG0G4Qzi9prxtrG6Sem8miS5RzkXru3f+KKlTjzxPEHftm06mfT
         5HE+nySx8hazS6gu2T/vUfjYmtEl/sklGTvWSVVvlLsPhqB3SAPV1M3Q4xMILA54swfI
         fK6tzRsSZ7UXw5FFRx1gh9UvGhpaLSuHYmBck/oZdYFsLC2pA8oDs5qaIzS6/uQMMPfN
         k3gMJcktTLv4fynE91NWONMrwDtPcAKNwBnCPvJcwxE4wcv2FZqQ42Byzgp3GfC+rPxv
         OKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756086492; x=1756691292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKTKi30DzOZxoemkQY+g9NWqObH7qRITcl76FpX3784=;
        b=J+9glPVb0tF4VxPIhgFcR+Hrvx4OkV3WDYdfJN16FW2x5GqE/khHjRbcVoPai411pl
         DNX+4C6SEV0eghdopWWyxCUbaDO7PwtdniAnzNU4NKwLRlC8TpGl2fpAwjRPC+m0VTDg
         y/dq7sgUEXjk3VDSTi5uBQqWeDMQ6UeYJDL1ATjwRActnWQYweWFpar9HrlOeC12J7wp
         D/b/mNv0g9aNvcSfXpR9h85KZtfhCHFpPAiALSCYYnYuKHCiMUGgK7txDuihB1Ej8nNO
         bDa56M7BcsjVC4oGLUh0A55OpLcbVJRymhbNBleI0pDDd/EzkDXONW7dIxgWrpT2uhYh
         Mn5g==
X-Gm-Message-State: AOJu0YwPO1Q/qKiQQTEPrnLXV8WrHWEEGRKQyVBdIYxPi+R3+B4XzD9C
	IayC01puG2EVuUHpvjUZZ0l79B+IZNJprDwIzbdpmHTcAQOX0LxKHohjINudbRzGpLk=
X-Gm-Gg: ASbGncvRbRgspmAwm0EpXO42cfEe+hapUl3VXF4SLwqb6QJWzRkGEIeE0wVhoeiL6pI
	Wd8wuqhVPk5K6WjIqh8XUFhzlg8YTlYHIF20CRUfHL12SuLxdf2aIpn9AtsJiE7LNZ22hCI/slg
	VKgyi96IhOIxS5Yx75ZdkfjsrP97lXnqbL4Yrvc5KMMnBXKEPcSnYD22IMPOZ8Bxm9Z2mOjE2I4
	qf8CBi2dh6qmGbWyKUTIX2FEiy+q2gsj1pz35JPce1T4yd1+mRruY7e26jP7Jzl79zVw7qjdSEM
	/18pMfaEPZ0/jqDMlYipQ3M/fQBrXqMrVra2dxbDX/J+0Nv8PVYDB3UpgcOup2AI5idWiY79obb
	QNeBClcY+jePmvJmMz5OQZVflDZ4UR2cx72lq5WHhfGqyW55l4cwjoNI4M9OIKdX/Aw1OU3Tyd3
	g=
X-Google-Smtp-Source: AGHT+IFb4fUzJWnsSa7UyXkT3dofO3Y9E3ucTpYZIFVhZwVbL1/ONgAto1/5K0FJSDJo5h88H65KHA==
X-Received: by 2002:a17:90b:3a8c:b0:311:df4b:4b7a with SMTP id 98e67ed59e1d1-32515ebff7emr14727424a91.29.1756086492159;
        Sun, 24 Aug 2025 18:48:12 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3254aa4f9e6sm5547282a91.16.2025.08.24.18.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 18:48:11 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	avalon.vargas.centeno@est.una.ac.cr
Subject: [PATCH] wireless-regdb: Update regulatory info including bandwidth for Costa Rica (CR) for 2023
Date: Mon, 25 Aug 2025 09:47:17 +0800
Message-Id: <20250825014717.6771-1-pkshih@gmail.com>
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

- 2400 to 2500
  36
- 5150 to 5350
  30
  DFS on 5250-5350
- 5470 to 5725
  30
  DFS on 5470-5730 (take 5MHz from next entry)
- 5725 to 5850
  36
- 5850 to 5895
  36
- 5895 to 5925
  30
- 5925 to 7125
  30, LPI, indoor only
  14, VLP, indoor and outdoor
- 57,000 to 71,000
  43

Avalon reported the bandwidth limitation of 20MHz causing lower throughput
than what he set country to US, and he reached PNAF about the bandwidth
limitation, resulting in no limitation currently [2].

[1] https://pgrweb.go.cr/scij/Busqueda/Normativa/Normas/nrm_texto_completo.aspx?param1=NRTC&nValor1=1&nValor2=99551&nValor3=144158&strTipM=TC
[2] https://lore.kernel.org/linux-wireless/7bfa8257d34642d7a1e35b3705720357@realtek.com/#t

Reported-by: Avalon Vargas Centeno <avalon.vargas.centeno@est.una.ac.cr>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
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


