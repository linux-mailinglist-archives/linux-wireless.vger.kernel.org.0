Return-Path: <linux-wireless+bounces-9813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3587991EF72
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 08:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD991F239AF
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 06:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B53E12C460;
	Tue,  2 Jul 2024 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBfOfYZE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1252E12F596
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903080; cv=none; b=LR74Oq8VkpGpII4BOkGr5TiBHLAWumkKP/AN6gRcKfEL1FUuleKsfQxuHKzVyeOmrkyFgIop+OI7YD6NXOi0pKb+kVVh46eGDCHIu2St6Yb+2khS+z0qOWH/+JKKNOdrwwuDjFMK56d32sUH6Oggyw6RfvdFB15R3cgpoE4ZsOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903080; c=relaxed/simple;
	bh=puBziNhbzQOW39EeaC+l8nd6JRq1y0oNoGJhgS/2XXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hkUhy+GFM5wD+MVKUyNg+krNlBEkqTPV3BbrthBDMojGyHefeQjyxbxWSMkFm4+ffsdolDjQKx5fsgDJU0WCdVjp2oP98yO/DLeGi7rk6xkLIFPXprv11mWIa66gzly8CkyliFMTJheAguUgRaaO4etDJEUYHXHKK7vlCOe+bCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBfOfYZE; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2175635a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 23:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719903078; x=1720507878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnY6SHlNr6YyXsCCbcv0R5fR1tjeOjIhybsxrKsZmZY=;
        b=XBfOfYZELPAZa3gsDixHeus2/82T1JxbTSWD4fWOFbPjOKLwVstQ8IYx8XZUbJn/IC
         4o4OKuyti+ciotp0NxCzIvQD+Gv1BKMkbaCcufUQv6qOBOjvcbxgZ2Yu/Az50/BWHMuY
         96pt5ma2aZyb1y858HKzqprENlzixqjC/6eaF+2OV4EcVto7NaiI79WpEV660Sc/vRcn
         9tG8qn+yenn/Q8QDWWag0MRD0xj0tVAXqIV4ilidrcaR+3trS0HJRay6Uhg89KO48uAD
         RDuZ0FMHAyN3Rp9yI7+WeyQjR7AIvUHmgKc3B2X59UgndGTAADZNUZGaQUnmr2GAVx6c
         UUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903078; x=1720507878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnY6SHlNr6YyXsCCbcv0R5fR1tjeOjIhybsxrKsZmZY=;
        b=S3t8vJL7ZgN4ZdS3XRDeQkmtI51YXS370IoKyq//E9UNJhzzN/4JBFEyYVBNAoKChx
         LkJ3m4HAgzacCiyCuVZ+cem/SvEODKatX4YOQcas5YOMsEATuehgSujU4k7Q+ZruUOPH
         obvW/fG0qYzOdi4lMlQGrsxi4Un5fDgvDzpE7cDMHi13l4n5rR4isZg6gfPuZGVNtq1g
         rI1+dpUzh76YXflQIDwJKxNyzDqbJXWvw6tlVcKVWfdefYjpcnGwdiyxpB8MT2BLU1Mu
         tJyMjZweNH5fUjrWjacqo6AZ8Dgs91l0ajvHmDRWj3wHEfLNqxLlXXNuA87VFD+E06pM
         1/OQ==
X-Gm-Message-State: AOJu0Yz6ViNcKBxl5vwT3wMWG+PNydHu7vcnWlptwpbcXX5kgat3zoXP
	AbjHEuh+Ooj3Es9Qf5zaZckAmFsqjknk3Iq62RgEv3sGW0cJLZ0P6uZ2IVF+
X-Google-Smtp-Source: AGHT+IGyD8q6cQo0GlqRYvffb/TtfJ/i1ukneq1nbzKyMgKAlmWFePNjcrApxI2BLuO5copwgmZp7w==
X-Received: by 2002:a05:6a20:7490:b0:1bd:91aa:79a6 with SMTP id adf61e73a8af0-1bef60e3eb2mr7961725637.9.1719903078181;
        Mon, 01 Jul 2024 23:51:18 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc5e7sm7976490a91.36.2024.07.01.23.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:51:17 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v3 2/3] wireless-regdb: Update regulatory info for Kenya (KE) for 2022
Date: Tue,  2 Jul 2024 14:50:59 +0800
Message-Id: <20240702065100.13644-2-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702065100.13644-1-pkshih@gmail.com>
References: <20240702065100.13644-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Communications of Authority of Kenya issued GUIDELINES ON THE USE OF
RADIOFREQUENCY SPECTRUM BY SHORT RANGE DEVICES on JUNE 2022 [1].
The section 5.8. covers frequency bands and technical parameters for
non-specific short range applications and wireless access systems.

 - 2400-2483.5 MHz: 2W e.i.r.p.
 - 5150-5350 MHz: 200mW; max e.i.r.p. density of 10mW/MHz
                  (ETSI [2]: 200mW (23dBm) -6 dBm to be 17 dBm;
                             5250-5350 DFS)
 - 5470-5725 MHz: 250mW; Max mean e.i.r.p. of 1W &
		  Max mean e.i.r.p. density of 50mW /MHz
                  (ETSI [2]: 1W (30dBm) -6 dBm to be 24 dBm)
 - 5725-5875 MHz: Mean e.i.r.p. spectral density of 23 dBm/MHz
                  Mean e.i.r.p. of 2W in any 10 MHz band
                  (ETSI [2]: 4W (36dBm) -6 dBm to be 30 dBm with TPC)
                  (ETSI [3]: The FWA device shall have the capability to
                   reduce the operating mean EIRP level to a level not
                   exceeding 24 dBm for ChS = 20 MHz and 21 dBm for
                   ChS = 10 MHz. 24 dBm is adopted)
 - 5925-6425 MHz:
   * LPI: 23 dBm (200 mW)
	  Mean e.i.r.p. density for in-band emissions 10 dBm/MHz
	  Indoor only
   * VLP: 14 dBm (25 mW)
	  Mean e.i.r.p. density for in-band emissions 1 dBm/MHz
	  Indoor and outdoor use

Reference ETSI EN 301 893 [2], for the 5 GHz and 5.8 GHz ranges, TPC is
required, being able to reduce TX power by up to 6 dB. ETSI EN 302 502 [3]
for TPC of 5.8 GHz. (Add this rule followed by [1] with annotation "ETSI:")

[1] https://www.ca.go.ke/sites/default/files/2023-06/Guidelines-on-the-Use-of-Radiofrequency-Spectrum-by-Short-Range-Devices-2022.pdf
[2] https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
[3] https://www.etsi.org/deliver/etsi_en/302500_302599/302502/02.01.01_60/en_302502v020101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3:
  - DFS-ETSI
  - split frequency 5250 - 5350 as an individual range for DFS
  - correct 5470 - 5725 to 24 dBm by e.i.r.p values.
  - correct 5725 - 5875 to 24 dBm by mean e.i.r.p. and ETSI EN 302 502, and
    more documentation.
v2:
  - align freq range of reference
  - use power unit as reference
  - -6dBm for 5 GHz and 5.8 GHz ranges
---
 db.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 4d2ebe46172d..c046e0269e67 100644
--- a/db.txt
+++ b/db.txt
@@ -985,11 +985,17 @@ country JP: DFS-JP
 	# ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v1_1.pdf
 	(57000 - 66000 @ 2160), (10 mW)
 
-country KE: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (23)
-	(5490 - 5570 @ 80), (30), DFS
-	(5735 - 5775 @ 40), (23)
+# Source:
+# https://www.ca.go.ke/sites/default/files/2023-06/Guidelines-on-the-Use-of-Radiofrequency-Spectrum-by-Short-Range-Devices-2022.pdf
+# ETSI EN 301 893: https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
+# ETSI EN 302 502: https://www.etsi.org/deliver/etsi_en/302500_302599/302502/02.01.01_60/en_302502v020101p.pdf
+country KE: DFS-ETSI
+	(2400 - 2483.5 @ 40), (2000 mW)
+	(5150 - 5250 @ 80), (17), AUTO-BW
+	(5250 - 5350 @ 80), (17), DFS, AUTO-BW
+	(5470 - 5725 @ 80), (24), DFS
+	(5725 - 5875 @ 40), (24), DFS
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
 
 country KH: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


