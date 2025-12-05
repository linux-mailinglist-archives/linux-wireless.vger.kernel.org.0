Return-Path: <linux-wireless+bounces-29546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 954CBCA853A
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25CE33013EAE
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73243396E6;
	Fri,  5 Dec 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkYB7uSh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464933B6C5
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764951151; cv=none; b=JYWXWy+0kUN1gdtGPGFq5Om/mCvcK4bWwh+M09KgtgGYJ1MRvAVd9K7HEDleFQxjSHXcpVS56mUpV+2WBE5oIvVnOzrU91Pj/OzcPYK4gW40Pqg5YItEpxbfbt3UrTPgarMg9M4zecaFvhcSwZeBWB302ok0zDqgbLZCZVsC9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764951151; c=relaxed/simple;
	bh=+Uij/c+hhRUh7KNHXiyStM+eLLPbLJJe16gbEXkk+T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuySPPpXPqKJOhskid6kZlvUBQ4sF91EIaJMGIk1mYjuBo0ci0rsWGAVrShUuWGXF8WNqZ6V8HNJsdJvcx/Mcd/WCPnLzfJPTrSQaMBMiJtxk3IscF8WAfWxrhB64OGW8+i1K6a0w/JuoiuXhnq77/C+dM7O6FauJWvYbg5TzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkYB7uSh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59581e32163so2933744e87.1
        for <linux-wireless@vger.kernel.org>; Fri, 05 Dec 2025 08:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764951146; x=1765555946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRu3vn/L5SRaR0SSwrxKoGLCPSzcYT0aQdaJ5FnQFyM=;
        b=IkYB7uShocAhmJ7P5qSUjQiXXB5V/BjB5XNHNdEd4ViMoYfPtXkeZznACaGotyTCPd
         fEo3I9f4SGuxLOI40RPCDf0Tvo0loW2XgT3scDlD6zo+r17OqrnUfVdZNwnrG1sd+w+b
         F64hcHCLfSjyQT+03ealjZj4fhYOxd1UF9iR09nhozM9lWSn3kjTP3Bppxixz5TpaZ47
         oF9XsclvOreCr6pSZEO+OKFOemO3ntu+HTm+7UFFTqDUm4qzQRrwILOOHan/oCs6LfYD
         IBtGr6phoV83IHD1xvgngCF/tdDLWw89bn38MnBw0NaWVE6XaUxfn2AZx8+g2q/wvUvG
         SrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764951146; x=1765555946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRu3vn/L5SRaR0SSwrxKoGLCPSzcYT0aQdaJ5FnQFyM=;
        b=XHyD5xlLVF+S5utGabY0l6fJfXQqMGgiCT5AbltCnDX3Y69GDxnHglMTW0RsEYfXv/
         mlcAIorPFVqg5r9a8gmb5RKFZTPWFAnSlpUlLTlFldNovSHBI6FbNP6TjhzQNUDY5d3V
         Eoz/z3XxFxbv7QY8GtPhJj3GgsN/IbbbhRib2YJ4l3kB3/XBKSpNKRzC5wrpx0F5Pww/
         Kz1IT/R4CsS6QXunbzEDZdzKQrCfqZr7zP4A+5X52lVD0wKKF0RDh383hYogifRhI06z
         rXdTyFgEg+ogpjw90WjqKJmdd+SL4pkNeBc0M4WooGnEVuKHRvIePLnF/9wld0FHFzRG
         +WHw==
X-Forwarded-Encrypted: i=1; AJvYcCX1M9u98830WYg8XAUO9J2y68t13cRXJ4TvneZN9LCCYd8SeSD9vf8LZsJlzyYUHQTOYZnlYE95XEMPZ3t9Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMxotmnQafL4Cd6n0RXYtvMcGUxzFpGK7B6eh80fmt4qsChmQC
	8Ie8gwnHo/trvZx0T5BC81D2w0j1mmgcvy8mqtnQ5G1sgs4G9w2FjIkw
X-Gm-Gg: ASbGncum5UsBJT5RkYx6KA8+/ZTAetpx1mVkBNsiVEVj2ea1bweDsGR0q4cylbyy34z
	8AE2Crdt7TCpnZ0cIZ/CvehPX2uBnOW1zIV/X9EyRsKNaqEOaWjomVsnLUg+x2/da6WePptilps
	ULPGE+rMGandbIr5HfrRjUBqphxAULac7kPxyiO/Xf6nFyDqB9Nyg001VOADGc2TFjsq8X6UA1v
	eoeTVdcvO4wtmxMEhPh0RKvhBInkIkdbwUVk2999tFKQcGtSy8gssw10HI9jlOhZiASPSMS0Svq
	ZAUOxRDmf8S8E4qNTuTFsh7m8yWVy+EuKSVDa0pcgS0PhEHAVMjaKCTIl99MlP65rNNBIrId5nT
	U2oYJaSV8jCph0BSxI6BwTKX2z2oLZWcK/9gt5OBnFT36tpx8aoSMkoGeWI3YUahHtVqYQhzgBP
	S1yVpBy+O+vmC8Q1mWJKBpLg==
X-Google-Smtp-Source: AGHT+IFIv8sNT85tAoTM0JCKoOGi4DeHIdsW4Qkp4uPPjvN5cusGwlRPEBYBIrgPH3hNnQEFUHZHvw==
X-Received: by 2002:a05:6512:39d2:b0:594:b2be:f3a with SMTP id 2adb3069b0e04-597d66c816amr2685904e87.25.1764951145521;
        Fri, 05 Dec 2025 08:12:25 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7b1a920sm1654026e87.12.2025.12.05.08.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 08:12:24 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] wifi: mt76: Fix strscpy buffer overflow in mt76_connac2_load_patch
Date: Fri,  5 Dec 2025 21:12:02 +0500
Message-ID: <20251205161202.48409-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com>
References: <CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f804a5895eba ("wifi: mt76: Strip whitespace from build ddate") introduced
a kernel panic/WARN on systems using MediaTek MT7921e (and potentially others
using mt76_connac_lib) due to an incorrect buffer size calculation.

The error logged is:
"strnlen: detected buffer overflow: 17 byte read of buffer size 16"

This occurs because the field 'hdr->build_date' is a fixed-size array of 16 bytes.
The patch allocated a 17-byte local buffer 'build_date' but used 'sizeof(build_date)'
(17) as the read limit for strscpy, causing Fortify Source to correctly detect
an attempt to read 17 bytes from the 16-byte source field.

To fix this, replace strscpy with memcpy, which is appropriate for raw data
copying, and explicitly use the size of the source field (sizeof(hdr->build_date) = 16)
to limit the read, followed by manual null termination.

Fixes: f804a5895eba ("wifi: mt76: Strip whitespace from build ddate")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ea99167765b0..d2c4c65ec464 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -3125,8 +3125,11 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 	}
 
 	hdr = (const void *)fw->data;
-	strscpy(build_date, hdr->build_date, sizeof(build_date));
-	build_date[16] = '\0';
+	/* hdr->build_date is 16 bytes. Copy exactly 16 bytes to the 17-byte buffer,
+	 * and then add the null terminator at index 16.
+	 */
+	memcpy(build_date, hdr->build_date, sizeof(hdr->build_date));
+	build_date[sizeof(hdr->build_date)] = '\0';
 	strim(build_date);
 	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
 		 be32_to_cpu(hdr->hw_sw_ver), build_date);
-- 
2.52.0


