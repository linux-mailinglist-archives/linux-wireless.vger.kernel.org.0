Return-Path: <linux-wireless+bounces-25630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E6B09A0D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 05:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB1A1887159
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 03:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FAA1922DD;
	Fri, 18 Jul 2025 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDhxMjt5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6F1400C
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808113; cv=none; b=AUYz/zhufDLDgmaA554h6CZ10m9mJ3jSR3PIje0vD7GZ87nFbUAvwb/voZxxOds918oVvBmrDCWDVSAt1mynhMOhxX3xT/DaNHN0n2YZeKrgKg0cIHp7cen/dV1qtr8KrAVgXOcZJwRyuQKZgZTiXrWAm6DYTkxiUJ+6aXPaKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808113; c=relaxed/simple;
	bh=WUfAiSF/LCEDyu7OfivuwVYxvv0QYooHRTbgEo++nYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ugA96F237hbPN0yGbhFNAfqGDi7h9xmUQh+0FdeTuXA0Np0AyVqXsMFbbn4oNYAKCwNlDmS89apiqSJdvpbZt95yDcCzrm+hvxf6USV9yFznX9MQ/uYzi+v/uwACD5DPoltoR0cWMPp9ky0+tWj/NPVoWl5ijhT7JevdkGYwXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDhxMjt5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so1413191a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 20:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752808111; x=1753412911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZhWe6L6AhfJrwGhwFLKFNsEK6ObzckPkOzEe3ygmyQ=;
        b=kDhxMjt5etk76KwxFiC/D1o+/jBfaYBKzOHNOTnNirnhLrsxA/5pTpgv8ALEtHZhnr
         f3Rf2ZoIDFU8ncm+Dme3xnQRYkbYHr8Dd5k1K+IvgqhmRF+QfmO7XibmaKBL9vsYyjSf
         GAOyCei4jPAesLBESJefLfKpN8nW1mtxhExB1Cy0hZgWGzM21lkYHQfTBQap8NAstXPq
         Ia9W+4INYHH+4T/4DLcKStlMCEiY/nHn1gT+OAaBjC8M+sgZNtz9DqpzP3wewRyG7LxL
         Zw/Y2JHVGp9YCRBh2vMxHDtowQmkKPL+/HqGAXGaW9x/XWxZxxh0rACgENLT3fI8wJqr
         avGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752808111; x=1753412911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZhWe6L6AhfJrwGhwFLKFNsEK6ObzckPkOzEe3ygmyQ=;
        b=VHxyn5UJY/YFg30KjOUyMN0ybMAjwWxhM/yb1uQiUsj/PyJf/JwXZ8IeOPXxVn7d4r
         UjCXBSjxa8YvOY8kJfGJfqCH4/DV+yw4CSz9wx4NHRkgCoE1WY0oqmZzFCDAyaqWjxVc
         Al94i0gkuWqXgStWOsbi6RZYq9T0MsQrsCYYYJlnhDO5OCbhFcmJn0CsWtTJKv7xUdGg
         uJdWVQ/88oXn1fJeHnI+EhSJmm0jWD3e6O4S0jWIJdZOpCgJYF76vyDZrISUe5ryV0rC
         45ghn4AobW7ImjtDgADECO2z5NLvpLSpzMODdZbFAcNz32tTfSoWxvdnfhuKCDLb1ac0
         lOFg==
X-Gm-Message-State: AOJu0Yx2k9MT6SAjM7o90vvG4NCk9eijs14bVWuJGJ1Qdp413kvvE6yt
	GVLltzwcTNlyAVGwP5rul0KlJylMkUsbMhh7M3W6KZIyLmk9CKZy0XbSbC97ow==
X-Gm-Gg: ASbGncspypx5PsVFFEgBlD88vtowTug1VmrBg0I3rTgXQ8gcqugdmMEb1OGCC+eFc+S
	HwB8sh1S851FbYv9ZdDT+F6tz4/GScznlMZtLuiwrWxRKx1VunjUbMgNi9jAfJPmft8JjL0XmGE
	LGJEvuyT05ZA4QrtLMTBeeAoeeE86jKezasvba9XjLX/Z2SXj5YdOuMRc3IEPl1qk4g4eRRutbR
	gXL5UoDH4vi7ZWcMH90CVGV7YHx5jXToSde2d+ywewAiROym18R/N2DWEx+bOZAixW7Y+ozKQwQ
	vQQANRKNv7uV2oaT9UnBjok1ZQ7J5NX94qk6RiseqI0gHA5siIQMSq6DFPnEFqN6TUFnrRp9Xb+
	vkWFcALcLfXg251Y9yuNnnWELAS05+W2Z2TpoIiMU8HsXmlVrPIlOP+4gd34z9vOKEZbhRzgWf8
	Y=
X-Google-Smtp-Source: AGHT+IE32zSesFR5yx8CzcP6NzH5hPVNwTYxDFRCPAfFDhbRLtF1Fyo91AOzuSP8ptQXZu4TzpJFXQ==
X-Received: by 2002:a17:902:d64e:b0:237:e753:1808 with SMTP id d9443c01a7336-23e38f8edadmr20795005ad.20.1752808111047;
        Thu, 17 Jul 2025 20:08:31 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31cc3e5b46csm275324a91.11.2025.07.17.20.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 20:08:30 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 1/2] wireless-regdb: update regulatory rules for Botswana (BW) for 2022
Date: Fri, 18 Jul 2025 11:08:09 +0800
Message-Id: <20250718030810.17213-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Guidelines On The Use Of Short-Range Devices (SRDs) In Botswana released
on February 2022 [1]. The pages 20-21 describe:

* 2400 - 2483.5 MHz
  - 100 mW e.i.r.p.
  - EN 300 328
* 5150 - 5350 MHz
  - 200 mW mean e.i.r.p
  - EN 301 893
    * DFS: 5250 - 5350 MHz
    * for devices without TPC, the limit is lowered 3 dBm
      (reduce 5250 - 5350 MHz to 20 dBm)
* 5470 - 5725 MHz
  - 250 mW e.i.r.p
  - EN 301 893
    * DFS: 5470 - 5725 MHz
    * for devices without TPC, the limit is lowered 3 dBm
      - Not required for devices that operate at a maximum mean e.i.r.p. of
        27 dBm when operating in 5470 MHz to 5725 MHz
        (keep 250 mW for 5470 MHz to 5725 MHz)
* 5725 - 5875 MHz
  - BFWA is limited to 5725 - 5850 MHz
  - PTP/PTMP: max mean e.i.r.p = 4 W
  - Mesh/AP-MP: max mean e.i.r.p = 2 W
  - EN 302 502
    * DFS: 5725 - 5850 MHz
    * The FWA device shall have the capability to reduce the operating mean
      EIRP level to a level not exceeding 24 dBm for ChS = 20 MHz

[1] https://www.bocra.org.bw/sites/default/files/documents/Annexure_3.3.2A_SRDs_Guidelines_Feb_2022.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/db.txt b/db.txt
index 81ff14ecaac3..d2414810442b 100644
--- a/db.txt
+++ b/db.txt
@@ -368,6 +368,15 @@ country BT: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# Source:
+# https://www.bocra.org.bw/sites/default/files/documents/Annexure_3.3.2A_SRDs_Guidelines_Feb_2022.pdf
+country BW: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), AUTO-BW
+	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
+	(5470 - 5725 @ 160), (250 mW), DFS
+	(5725 - 5850 @ 80), (24), DFS
+
 country BY: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (20), AUTO-BW
-- 
2.25.1


