Return-Path: <linux-wireless+bounces-12138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122E5962281
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F931285902
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F61F161914;
	Wed, 28 Aug 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZJbX72p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607215E5A6
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834846; cv=none; b=B7HZnmC841qiWSedjvd9NaXt8UyargEtBiOTYlHbqgxaSSC3/DC57Xym4u35ntXzUfMCR7xAbC8ZIMvdSTjLCFqD0P0Jtxyh5rIFQttcMNtsYIw+m3/8f+mUM5TkcHmxXLcvfbq61TakpRGfhARtKJbUqgJaIyNDHkgxyiAf6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834846; c=relaxed/simple;
	bh=l7wVZkTZ4/VzmOkLMmzj+HCm5LOiBXMjEetjJxFNtJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tdy7hZvDO0iXJMP9pHyU2xRkpuBKJKJAdGBLuz3OMwxcOPybmZid00t/Zu+t8nQEMkTt7n4FltCfZ9cPcxAaMckUlVxuAYQmFqu9xtV4gonBdOgzCvJbKMmZ01g/+DRMvy9Mw5pGs74+dBeBhiWcwmeq+S1ARRPk5HgKEo+YWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZJbX72p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20223b5c1c0so59112395ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724834844; x=1725439644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2i2TO1l4qHvfPhTps6FYZzEF53OdrIJBdII1OVmJKw=;
        b=JZJbX72pMmjtEzF7rddJJF+R4FJCYGVAbcaLJjK95ecxj9HmYKcb1toRyviYS1QNuz
         u2a8pFMpGTHN39FOdTGNgNWyrrM35nbpqg56r0iSLBFfFgjcx10agML+gUwqHgMV2uXO
         n8NiuyNzQuxr8U8iTIW2rIMkKzsgy+3Y+QcoSqGWQ3s8ch9znnsuYRjRGnHF3dZka7eO
         ajBGTE8kb2+oqPwBi5g1FzkcCHplqbS0x1zlUAkwJToCALt8AalNjRjGNeUTTnVScnbJ
         VqxLSCKptm3/p3HcOIgpP28aEja8O+gja/L6NPZEvJdxT5xGCZdKXIJNAUyTBBiiXrK9
         ScGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724834844; x=1725439644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2i2TO1l4qHvfPhTps6FYZzEF53OdrIJBdII1OVmJKw=;
        b=MDJMpLfmZbCBSZ7Lidyh/P44Br0SE0wmKuqsRAkY6BHvLm1BSDT0bSwyejKQ0x94Jy
         cjQRPCSiBkn6d0CLR06KoNe3bvp7EtDKiLxN57fBLBmDlA9mCx/ahIeDwSRGV78qEvi7
         cqzInVywWYxebGdK59iMSNoLTqLngO7qOv70pKXuYavez23eRJrvZWdIle73u5/NuFsI
         TT1HKiX6jVHc+LZo/Z0ilP90cUN+kwtcLccH8UbuTc8FA6A37JtbgWggHWxmTLPs0nOD
         xOegj7JxApUvK4u6sbdoP3aVho7Sc4oAjKsjlO+E871a1918/WsGo/fuqkTZtW8Ku6hE
         UyKQ==
X-Gm-Message-State: AOJu0YwXK8VGiTGXy3NQvdPfKcEv/Bmgxip+kAtbSbx4rJ+hFwvg4ZGB
	mzyrbSdVtI2eUUnwMfKqy0dhf1psAQHO11qWGwRUNDk/yDHhbxJFl+OIvjOG
X-Google-Smtp-Source: AGHT+IENh45l9ewEQRLaQVkkr3GnzQnzqA9EyukXV3UbMzD4QNUPb7f1qAwi0F6P2RUEc6ImtNdXcw==
X-Received: by 2002:a17:902:e74d:b0:1fb:1cc3:6482 with SMTP id d9443c01a7336-204f9bf716dmr15145905ad.45.1724834844099;
        Wed, 28 Aug 2024 01:47:24 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855dbefbsm94652645ad.136.2024.08.28.01.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:47:23 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 4/4] wireless-regdb: Update regulatory info for Honduras (HN) for 2023
Date: Wed, 28 Aug 2024 16:47:06 +0800
Message-Id: <20240828084706.12257-4-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828084706.12257-1-pkshih@gmail.com>
References: <20240828084706.12257-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Honduras, Telecommunication Commission (CONATEL) modified national note
HND40A on 2023 [1], which Wireless Access System/Radio Local Area Network
(WAS/RLAN) have a general license to operate in frequency ranges:

 * 902 - 928 MHz
 * 2400 - 2483.5 MHz
 * 5150 - 5250 MHz
 * 5250 - 5350 MHz
 * 5470 - 5725 MHz
 * 5725 - 5850 MHz
 * 5925 - 6425 MHz (*)
 * 24.05 - 24.25 GHz
 * 57 - 71 GHz (*)

Article 5 of resolution NR006/23 [2] mentioned Recognition of Standards and
International Standards including FCC, which limits and ranges of FCC are
used due to lack of limits [1], but only newly add freqnecy ranges marked
by asterisk (*).

[1] https://www.conatel.gob.hn/doc/Regulacion/resoluciones/2023/NR05-23.pdf
[2] https://www.conatel.gob.hn/doc/Regulacion/resoluciones/2023/NR006-23.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/db.txt b/db.txt
index 0bc40db2d9b5..d4ca8d43a41d 100644
--- a/db.txt
+++ b/db.txt
@@ -819,12 +819,16 @@ country HK: DFS-ETSI
 	(5730 - 5850 @ 80), (36)
 	(5925 - 6425 @ 160), (14)
 
+# Source:
+# https://www.conatel.gob.hn/doc/Regulacion/resoluciones/2023/NR05-23.pdf
 country HN: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 6425 @ 320), (12), NO-OUTDOOR, NO-IR
+	(57240 - 71000 @ 2160), (40)
 
 country HR: DFS-ETSI
 # HR as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
-- 
2.25.1


