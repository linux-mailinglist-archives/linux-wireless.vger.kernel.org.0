Return-Path: <linux-wireless+bounces-28270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A228FC09C17
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EE7421665
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77208306B3C;
	Sat, 25 Oct 2025 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2bffbq4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3850306B0C
	for <linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410434; cv=none; b=hABIpmUB4Rk6lOQslS5nDZdC6t24xiQPTPe9pJYOnqNamehEMn/Ydr1s3DMmVrRBfD89OMvvhXlHo+f1le0p0Pm3C1iGbdLUUvwgURp6uuO9cSeNu+9uYnWcyML/Xnwdb4bPJmK7sKX55IuJ9XFxRgYwij2+B98/KJcqeQarNzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410434; c=relaxed/simple;
	bh=142ZarbauOc/OnyndUEIR7x0gLhU0Vf39KWkHIFGmYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtxa4WoXf6icwmdvmYZ8fVjCbXD6eBrTwXLTeKXHlFOPym/v3oejrU6HRIwGKq3I3w+4EKn7bLF5zkAkfK5I4uu7wzGx/2/qeZf2xYF7RwQllVGljm9HM6boUIyh5j6L2EKeDoEmkbeM6YGk+Flqq9SqjSAyy0v8RxgGX5jx5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2bffbq4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-89f4779fe03so75684085a.3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410431; x=1762015231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVD9Zxv6Y0ifC9xZiOG7Ki+TEfCe0ib+yy9r9fDGLQc=;
        b=E2bffbq4Ds02AQpl5Qu4A6vUW9DDnxFSCVuvwODdRYBO87m9APxmbbdz/OMSE3eYX0
         31KuLZR1HTiahp9XODbFezyTjr/+r0lHsBySNOlOhhLiORMTQ0wKRounf8UJdkYEIb/q
         PI3lzI7VG55iMAWHWZ2DsgAcJap1EzIGk3zpWWqw2TKrcQTSZPseqXx6ls0jb2I9sico
         g2wXlJcC0uCAGV+c/Y4Mt/1gP5qNHC+imvs+0X8U74QKspC9OUoCa+HOJUd9x+DZ+Frf
         S3+mjLQI74L6MYnws9eSSQcFt3eX5FWzPDmKcbHPO+l7vdzzUp62tRJp1Km8+EMA5Pgs
         MNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410431; x=1762015231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVD9Zxv6Y0ifC9xZiOG7Ki+TEfCe0ib+yy9r9fDGLQc=;
        b=SSDgxO6alzNWcz4R5ciw3wkQh4tPqrTyMjAVbG9pFMQSIT/y3nJp7vkWiVoMiUU69n
         QpFyL8ihZM0OrQugpZ59V3sgfHpnKG393BTgTXwUeAr0ztzH2H/QRNTRM5mykMUygSM3
         LM5i/g40IJDmqh5ua6WnSRZ2dr6mn4Ww+uFpxGwtir79Md+hGJZs9xO/l/RTKmSKoJkS
         6dVMimDfwf1YIEIWba2IeZdIKbdFVj3aXmNPZyH/qtq6IWEgoMO3bKVgEfDGvUjtblDY
         o1Utdsh0ylg+NAQ9/Bx2w7GTZvLDoGXm+qsyt4Zyu5Y7d2XvYoEIB8dE3OklkeVb0mko
         HcCA==
X-Forwarded-Encrypted: i=1; AJvYcCXEimdatzWQHcxjWUbUo9LfI+yatayvYRrUsZK2AapVrQKSo6X29vR8wW0OutbjXCPpG772Hj+XsWill4fk+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1KWrLwXcPvQp09k/Ga1Vx7Ny1dV+44NsQIKwhM4BL+twRC8SS
	WotbqJeJsr5IqlaATyJGjue5CV54VUDYW419vyrghWG68G4UZ+l9LG1m
X-Gm-Gg: ASbGncuus/xsrXQVQoOZe/5EiD3nt1mu92hEGxUONiOjjUEtoEnNMaYqdK6iT0hyTDe
	Yp3FyR4y4yh4Jo+9v/W+q+T8XbdtdtY9XZELrCEkAzNq/cSAhx/OFqRvLshu5e4PBJkDagRLZe1
	baS2xSA4tkNGnkmkMQ+ZwiVhcuCrdXWt54HKFek9IMFiN/WhvGz/uSCdMBG0d+uSC6GN16gJROB
	8m+miL/A0xUKmar2IbqlCN0NwhM6phOy8GRGc7SFBbj3TzF/NGITSA3RBTbc/OvkUCdVpsdn0GL
	9brGyFcwf3U8fVgKzpb+hIhp2RQslagCCnv8kY63wSbhXxciOQ3CMd58x6dMzImgCgJbSIboyjz
	hZ+SZxDlckn7mdCXjA5lDQDw1V+2w3wBmINZ184eBJHRcu0+63+4UePB5dg1XjT0mCcuAC98+
X-Google-Smtp-Source: AGHT+IHi0SzLVtyyhZwoQbQ1wMM4wPKEE+MJJFPaEhrXN5x+mdVgxlbnahirAfa9H7ObZoH6VLCARw==
X-Received: by 2002:a05:620a:2a06:b0:891:e26f:512d with SMTP id af79cd13be357-891e27ea1acmr3419884985a.59.1761410431571;
        Sat, 25 Oct 2025 09:40:31 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421f8b8sm175760385a.7.2025.10.25.09.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:31 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 02/21] iwlwifi: drop unused BITS()
Date: Sat, 25 Oct 2025 12:40:01 -0400
Message-ID: <20251025164023.308884-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BITS() is unused in iwlwifi. Drop it.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index ddc84430d895..b0d68b4c504b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -11,8 +11,6 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 
-#define BITS(nb) (BIT(nb) - 1)
-
 enum iwl_bt_coex_lut_type {
 	BT_COEX_TIGHT_LUT = 0,
 	BT_COEX_LOOSE_LUT,
-- 
2.43.0


