Return-Path: <linux-wireless+bounces-30137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD384CDFB67
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Dec 2025 13:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C743301D568
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Dec 2025 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA832F756;
	Sat, 27 Dec 2025 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYRPLJHC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531BC32F774
	for <linux-wireless@vger.kernel.org>; Sat, 27 Dec 2025 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766838351; cv=none; b=RHt1OiHzwBWs21BxE8IKWyQB3nhrRDMMuin9iz9CXuHot/te4ydSbfEs4Rs8YBScsc/1E1xCDtmPjzo6Wn3KiqxdQ7bUh1KJjYGDwUdEEX/eGskVyZOX7wOiyRhP0P620BXfnH/WSQ3mHRXCcTgDlqkXI/SLuPqaZrOXKqrFdR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766838351; c=relaxed/simple;
	bh=j6nXZg1hHhayzVTNsidFsvc7cVytqKMzlXVfg5DQz3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcZQ7x4iiGBkxcwsPdmVXYZiPjugzoe1+BQZqHt1dxgVlnRp3KpTDYby+nEzUGA3RWbTZfFW8sjYsYesSYUc0OGGFLIulCSpOqzeencIK8n2EJ/N1qtS0TTnxM8S6XfAjPGMye15frQav46L0zXp6+uTcn9P/ztysbY3malskFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYRPLJHC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so13360185e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 27 Dec 2025 04:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766838348; x=1767443148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kuPI2aNgLX/9o6inXHM98ejerk3xQ9ReMe7Mbvn14gY=;
        b=KYRPLJHC6xy6Suedx5II6OEqUG6bIxBJDop8VLKmSjOREUagHNo6xvOURESxGUb2nA
         cXEYMY4VehwKjfs4hcxjnUgM3WZSpLsBe8j1G4r5ZUXbaMq9yED4tqZuCdMdrm2NnLO8
         mVPHbXYgp0UMZvw6wZK5g7UP6zySmG0Z1Uy0YPCpfY1zt3T+d86RK+YMBtE0PvjbFFsw
         C48JhA/AVdWpEM1QlutzaqCLEd8kR/JhbDJSeEd/bczrONuoxFyOfoa30m4YykTDCvcQ
         EXSQ3yncVZs/fRBj8SNPYtS2cCLh68h7Qxp9/IWku5DTC7mIKpVSWVXoZE4rTymX96cA
         pL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766838348; x=1767443148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuPI2aNgLX/9o6inXHM98ejerk3xQ9ReMe7Mbvn14gY=;
        b=SxS0eIZXFLu+k+bdkvocB1LEsgn1zP5F1BXv8xxuYMXt6a/T+29IsF3qI6rKx+ONwJ
         Isum3Uo4d+PcMAlBApAruL3maz6SxaZduXCk9/Juo57X/QHU9hGcK0SQqu2rKwDGEzyH
         FBlUAwQ2RGfYV5CDDK9/gtr9cMfVZv7v/M1WR4F30RLQo7IwbVRLGkjbFDc+VEjBmbfh
         m3++o74XYFf8mzEnXsv2iazhT4satobD+PhGJjcHaSQc8SI5iQoWOBAfAwFh2KiH3Zr1
         OHe8bTOVWrNltxviBI0foZ5CJ6Viq1rtevYQnZlS6pSP7yufD8s5+K02Ye3FJ6Md0pYz
         cO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVM+uP3h7i7u9thWrh6u4GmSEd+wYOzybG11y9Yg0bjyZ4DgwGAxl5eLsyuvvDMVDecPBU4wvbgNliE/fD4gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCe0YAs4k6Az7SVHbfiV/AIpLMz9pWn8L+O6N9lvUiwNlZBttu
	AF4Eeoygjma0ol4+LCc8atWTfsg/wIbnTWYh20zF8zrmYnitjOH5zLal
X-Gm-Gg: AY/fxX5n/Wxnr5TCumwy5CIg4NApUY9Ss63bs0tkVY6/fNeFhsJPgUyeirV5WwaO/OY
	J5wlAs70KW9FwDHyB2HZ1S44n6MT0BHLwS8/1hSuRwcU/w/LjzZ++MBE1DpzmjpotEiN0uLcw82
	hI/bm8zhlClNY+gadu5W09Rp7By23tBC/i2e8/D+4tVOPefzCUvakaoyMMyeQ4CC/bFqh+3KM6I
	YW8t3oJBvQS9+lZcsl/vJ3AIgKesuVAfFHf3Od2RRjAKaAoI7UojqNNGlqlZ/tJ28AWj5Zc+2/y
	P4DWAcvb1ql81gt1LY9cp6tDwp4bibqi9TA1srHdnRtLvLYN48hKDsFc/jLn/DwKtFMVTEvbbbq
	PzLdKjzv4leaT5ZorGlv9ergFqBu2C7BHSAYgjArHzM5MWg8KwUXwpo3fSDLlR6BAEYgzfHMSY3
	O6Pc3y+Nzd+U5LcP5MkioW2+oqirV3PDt/8+1IFbD2Z038ZrcTgmv2b5B8Brc0luyDDuHomzU3y
	vOWF8vinos3Pw==
X-Google-Smtp-Source: AGHT+IEIguQB0uXGfKo4fm4DJC+yzPPu45X2Bza3OL/IGVtnEDjPWFUZwpWwFO9ZDFyXjEUZ4aLtXw==
X-Received: by 2002:a05:600c:1d0e:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-47d195a87b6mr305079455e9.33.1766838347448;
        Sat, 27 Dec 2025 04:25:47 -0800 (PST)
Received: from ivan-laptop.. (cpc92320-cmbg19-2-0-cust3144.5-4.cable.virginm.net. [82.13.76.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346d33sm451520315e9.3.2025.12.27.04.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:25:47 -0800 (PST)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: Fix strscpy usage in mt76_connac2_load_patch
Date: Sat, 27 Dec 2025 12:25:24 +0000
Message-ID: <20251227122525.5474-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since mt76_connac2_patch_hdr->build_date size is 16, copying at most 17
bytes into build_date from it causes a panic when CONFIG_FORTIFY_SOURCE
is enabled. So, make it 16 bytes instead to match the corresponding
field of mt76_connac2_patch_hdr.

Also, since strscpy always adds a null terminator, remove the line which
adds it explicitly at the end of the buffer.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ea99167765b0..01362b097a40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -3101,7 +3101,7 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 	int i, ret, sem, max_len = mt76_is_sdio(dev) ? 2048 : 4096;
 	const struct mt76_connac2_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
-	char build_date[17];
+	char build_date[16];
 
 	sem = mt76_connac_mcu_patch_sem_ctrl(dev, true);
 	switch (sem) {
@@ -3126,7 +3126,6 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 
 	hdr = (const void *)fw->data;
 	strscpy(build_date, hdr->build_date, sizeof(build_date));
-	build_date[16] = '\0';
 	strim(build_date);
 	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
 		 be32_to_cpu(hdr->hw_sw_ver), build_date);
-- 
2.43.0


