Return-Path: <linux-wireless+bounces-29545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A2CA84B0
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 17:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAEAC30295C7
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF11326955;
	Fri,  5 Dec 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKWQKEM6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DEA320A04
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764949548; cv=none; b=ZLl+VpP5Tb+4zWUs39gn5xk/V27oaRAycCmtciecAKPZR44KI3WC6E0h09WRAs8ke6y2XbDRgTlS7UZf/WowguOvI4T8s1SgBJGAxERb8mdusLN30eTQtOU73dDC4NjmaDKMZVgsSIyExbfZJlmrUGJSPVtfXheCtBrfM9uhegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764949548; c=relaxed/simple;
	bh=+Uij/c+hhRUh7KNHXiyStM+eLLPbLJJe16gbEXkk+T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8QEi7MIL7TOerT548/dY0XVdoXdPvC5BJu8drnhSWyjOuaVs+A4FWBkPqgEQEg31oO3QMvCMwCFgctbOdlWCvh1xsQPTO8v3OPD1YR4FFMg8nwSACAZB62SgL535PhlnqlZBxKLzNQ+wLKrz5w1AkQ9BbZrCpcz0Qo+V0VwQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKWQKEM6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59578e38613so2577467e87.2
        for <linux-wireless@vger.kernel.org>; Fri, 05 Dec 2025 07:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764949537; x=1765554337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRu3vn/L5SRaR0SSwrxKoGLCPSzcYT0aQdaJ5FnQFyM=;
        b=gKWQKEM6j5UY2Q/0gu4oFV/7Kid1gMnllhrO89TqqTPW5T/6lbt+Ys1RexUx7Ck9r7
         M7yAtFTHw4x7LSEOM1in8LrwVDe3Z8TlSDzVCjSUDiIJWjViw0VCpVVTO+tPvDx1a5L4
         KIhDqPL/XTDXBU6A0NB5DNpKuaZycwb1Rgn7aByuVPBcH6QvbT3dfZRuKjiAnzO9f501
         /kIyxDAmWEi1qaCTR++wIkBbNGFaO2EPyxFJMKMiPXg4GSK8A7xaolgbqz3gLNQmQp42
         +eKBpNQXCel4Y/jxgWnFqeyllQ2o52XDSFrPLkk27t1N0dSTX+IwzVRMLYj1V5LkMNCm
         aT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764949537; x=1765554337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRu3vn/L5SRaR0SSwrxKoGLCPSzcYT0aQdaJ5FnQFyM=;
        b=sBh6dFV04fgesQra0Nw+dwQ9uCg/U9oC1RifC9E2vMJI06ndI4Gxxen95KYr3XhJ9w
         kN9eIKPWjrIDs9IQwf+s1P4o229+3wS/m2WnQTGsSNMStjtVSUd2iuMhVQKxU+trkIAD
         LzdaG2Cys3RzgC9lfcRJ1Swuudg6uA0YAQGaB329SgfXyD9FXxQmDjL3c1/g2Ld02zpc
         hnuSjSRTEyri8MG3B8Kx3qxuapePwt0Z8fYRE7Q+3C+UUdg69xVmya36igeXpPdSU9Ea
         /OW1cBpjmL/AxMPgwE3G+UDsrjKuQT15yqXH7kY7VLX9qKc3ZCz/rrBEGh+WyTCW6BLq
         CJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh8ockMc3B9APDdiOidVz5DdwcuAZT7zYe2+1NAKdHKIh8chSVw/EjUsuRbc956E5gIWwOGgzvDl/Q0SAzAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0z+mWioa+Rqgxgac6Sqz3TDGHG2Yh1mKjz0+TGJDXBVAoAsua
	LrNA7RuZ30QmsiMsxxp3Mqhgz9jnRcTj/mIEVqrhCfW1AgRW6htufMKD
X-Gm-Gg: ASbGnctjN/AnHpKD/eb6l5/HcnO3Qk1Zn+m3W7hQIbS5FKJmmbtA3JEpF8kP6UDaz1u
	yTfo0C+fvIbShKL39h7v5PFsFbZh/d6B4G0N0qIr+WVO6u+3GDL+eDY/KYCB+9whSzjWoPQ1WPC
	29t3i1VDSvPjOrV7TP/MPkso+kDgpUweXecTh0WtUCK5sQ/2ptQQak5ZyGehKOTJDW8czoLE0kv
	StdXwJLkiuzucoZFGoTA+Ss8jzrWfgjBaRQT8h6tPtOGHkb1zMf9UEY7YE4gasXQgNoi8OIt3t1
	92bMD9abVc2q3RdEnSG1um18SAyai5pgBC2AZTy0oFMFXotcBM+hF+4Yj6zSTsheK1C22PuATVZ
	KrOmpmLODF8AaeAyuOI7ZCEg2rBGMLT87V+P40lvIvKRDeLeJfevBLzvZlRT7SPacuyKPGo6HF6
	7FfBHMD/pNZ/NRkObku+5UaA==
X-Google-Smtp-Source: AGHT+IEuOdjJ6eVJfcxdzeuAE6q+1nDIVgt3bm5mPBvJGVsrRtI1D3I0YRQqf1Y/gNOXYRySnPP9ng==
X-Received: by 2002:a05:6512:3b9d:b0:594:55ab:5800 with SMTP id 2adb3069b0e04-597d66c8175mr2515414e87.30.1764949537099;
        Fri, 05 Dec 2025 07:45:37 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c2e93esm1624775e87.97.2025.12.05.07.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:45:35 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] [PATCH] wifi: mt76: Fix strscpy buffer overflow in mt76_connac2_load_patch
Date: Fri,  5 Dec 2025 20:45:32 +0500
Message-ID: <20251205154532.27704-1-mikhail.v.gavrilov@gmail.com>
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


