Return-Path: <linux-wireless+bounces-26020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C44B11F50
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 15:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC9B1C84C3B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BBC2ED85A;
	Fri, 25 Jul 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="eWcaqN9M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896CD246780
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449772; cv=none; b=Lk8+v4EHUMczK94rfbGGzTQuYYRqD4SrJRJ+W6urBAGOu2naRxchxGWUWUHs3d4LQUV5ewUZJOhd2kErXM3DsTcb4qdZ2z6uQvD4KjJJ/5gHwvi88g8Brw82D23DjOrWJLQDNih50v2E/9sfEAEbONi36jdumZRaK6tJBz6+cSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449772; c=relaxed/simple;
	bh=oXuoab356xc8TJr+FqL6t+JnosFKXD3Iq+TGPDMyzl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stvlkEr49sNJxRaAaUEObDujfWULmp78QNu7jLatGtCw6p4fwQhbKFDc5o7giojWpKTeJzFnJuCCs49joBc2B0h2xXeWrPt24xP2fkwMhZixIC4NiZUKYjZJYemVKRFa+JF0fVVHVLA0a9Nho+G0ovyHB2VVL7SOgBCP65tclmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=eWcaqN9M; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1550943a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753449770; x=1754054570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Sl0pMDzBXIZD9MTsrYB0VFNPtGZEEUjQ0WKfsO19GE=;
        b=eWcaqN9MKbCJvpanH9La6w0C20uVrmmOHvBVy6HdrSu26JdLaTFH9+MYJs6qYOXp8B
         iLVAKUK4GlQIDHXK2C/LZHd5XCMR8bomDaGvjDr5Fz4WInUX7xl2RHuN8gpdi5LgOosh
         WdPLzoZ34dpUTEHzAS9qXPYk3FqXRZ9yWcqtmQWbAZwM9dAgd/rqCOvhX7HHO6Lg7mtq
         a4Tw4nJ2eFn9/UdZlqbT+wsy45qmh8zbfIv3LukiQ1ISpJITPxJmdQq+NDyeU+Swb9t6
         4AfxLS/9myWcngYpTYQRJnQa2NRPOZ7Ay34vDErcZ3m1ol6OccE2yL07aS/j8DbbZfMs
         fq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753449770; x=1754054570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Sl0pMDzBXIZD9MTsrYB0VFNPtGZEEUjQ0WKfsO19GE=;
        b=TLhlOiwxW5blgQe0QLaMi2CNGGegr4P4O3dcpQSvH+hAxgiKnzLCnYgZwZ6USvfGto
         rhLmN2F5dBt3Gs2ayZwnBaLEU/9zQFjh5stNcNnVzMt1mHrIkMFFcNKpPVNCJ/Auve7c
         t7Gdg9yPcwNXCKYOIRZ9GSg5Qm7ttKKQ8+fKqDc6l49JyKkdpXDxqswpBxq9iy1wc4Rk
         igHVMFgUt1hSjwQ0caq5IUA1NZ01ZWdbEbaP5yvnN3ZTCRJTpoX/F0rZ33L2OQff+srl
         6Fph6Yj8BgeQ28N5/hT99z8xg5fJ2uRat+9UL8QFoUOUCvjpFLKYQL/w07xbkTL3u6Lf
         dJWQ==
X-Gm-Message-State: AOJu0YzyInkp5Fd1x3mIIYirwWTmTFbVr246jva7Ptf1CtU9CoTcMLny
	PjoslBt7EfDBzI5vWZPisLV5MsjqLe9ma1uqaMxYdOvuYeKqYFaqITNc7wL5TrX63AY=
X-Gm-Gg: ASbGncuFjLJZFDJXzzF76Okv7P3nYguCKR4PSWWrdlZxsnxB9tghs5QglfGc2h7ZmKE
	B3lVZocqOZrn0+xsXGc74jI9+kMDYkFkmTegTFekpQgbYFoGQXJN/nbmuMet83gakMZeEyrmvDH
	EgRkoC4d0sTf8b/3BQ9B5m3EIkCUw0SpRgUYjPVKxwdgd31rJohUhP2JbKJIeD1oxrgiSv2pTqR
	HKRAyh3hDPKssUG8kZAaxUn5+kc6n6Cvq1pQt7t+vx4h7hU3UEH/X5i6wlWUezsYo1Ch8jYTGzf
	vMyZ4uvlYOfyo4NVZ/DY7AvbqJ33ag+lHlqwTTBGAQUubqwaylL2FdndgI+hpZjo+W93YpH8XnO
	tHxI2QzGzJhE96d01QVtivDCRaKXuGElPguDf+EquSOMNX+i/Hg==
X-Google-Smtp-Source: AGHT+IFwG1r0MdSKbQivTzN58CRb/OBz23g73+8bzbRZjPzgcpJ0N4nKj/X/l21yTkJVv/T6nPEagg==
X-Received: by 2002:a17:903:19c5:b0:232:1daf:6f06 with SMTP id d9443c01a7336-23fb311e3d8mr30477455ad.47.1753449769486;
        Fri, 25 Jul 2025 06:22:49 -0700 (PDT)
Received: from mma-H9MHD44.lan ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bd625sm37117665ad.122.2025.07.25.06.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:22:49 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v2 3/3] wifi: mac80211: kunit: add kunit tests for S1G PVB decoding
Date: Fri, 25 Jul 2025 23:22:21 +1000
Message-ID: <20250725132221.258217-4-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
References: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for testing the 6 examples mentioned in IEEE80211-2024
Annex L. These tests cover the 3 mandatory decoding modes being
block bitmap, single AID and OLB alongside their equivalent
inverses.

Test output:

1..6
 s1g_tim_block_test: Block 0 (ENC=BLOCK, blk_off=0, inverse=0)
 s1g_tim_block_test:   octet  1 (ctrl)    : 00000000 (0x00)
 s1g_tim_block_test:   octet  2 (blk-map) : 00000101 (0x05)
 s1g_tim_block_test:   octet  3 (SB  0)   : 01000010 (0x42)
 s1g_tim_block_test:   octet  4 (SB  2)   : 10100000 (0xa0)
ok 1 s1g_tim_block_test
 s1g_tim_single_test: Block 0 (ENC=SINGLE, blk_off=0, inverse=0)
 s1g_tim_single_test:   octet  1 (ctrl)    : 00000001 (0x01)
 s1g_tim_single_test:   octet  2 (single)  : 00011111 (0x1f)
ok 2 s1g_tim_single_test
 s1g_tim_olb_test: Block 0 (ENC=OLB, blk_off=0, inverse=0)
 s1g_tim_olb_test:   octet  1 (ctrl)    : 00000010 (0x02)
 s1g_tim_olb_test:   octet  2 (len= 9)  : 00001001 (0x09)
 s1g_tim_olb_test:   octet  3 (SB  0)   : 01000010 (0x42)
 s1g_tim_olb_test:   octet  4 (SB  1)   : 10100000 (0xa0)
 s1g_tim_olb_test:   octet  5 (SB  2)   : 01000010 (0x42)
 s1g_tim_olb_test:   octet  6 (SB  3)   : 10100000 (0xa0)
 s1g_tim_olb_test:   octet  7 (SB  4)   : 01000010 (0x42)
 s1g_tim_olb_test:   octet  8 (SB  5)   : 10100000 (0xa0)
 s1g_tim_olb_test:   octet  9 (SB  6)   : 01000010 (0x42)
 s1g_tim_olb_test:   octet 10 (SB  7)   : 10100000 (0xa0)
 s1g_tim_olb_test:   octet 11 (SB  8)   : 01000010 (0x42)
ok 3 s1g_tim_olb_test
 s1g_tim_inverse_block_test: Block 0 (ENC=BLOCK, blk_off=0, inverse=1)
 s1g_tim_inverse_block_test:   octet  1 (ctrl)    : 00000100 (0x04)
 s1g_tim_inverse_block_test:   octet  2 (blk-map) : 00000101 (0x05)
 s1g_tim_inverse_block_test:   octet  3 (SB  0)   : 01000010 (0x42)
 s1g_tim_inverse_block_test:   octet  4 (SB  2)   : 10100000 (0xa0)
ok 4 s1g_tim_inverse_block_test
 s1g_tim_inverse_single_test: Block 0 (ENC=SINGLE, blk_off=0, inverse=1)
 s1g_tim_inverse_single_test:   octet  1 (ctrl)    : 00000101 (0x05)
 s1g_tim_inverse_single_test:   octet  2 (single)  : 00011111 (0x1f)
ok 5 s1g_tim_inverse_single_test
 s1g_tim_inverse_olb_test: Block 0 (ENC=OLB, blk_off=0, inverse=1)
 s1g_tim_inverse_olb_test:   octet  1 (ctrl)    : 00000110 (0x06)
 s1g_tim_inverse_olb_test:   octet  2 (len= 9)  : 00001001 (0x09)
 s1g_tim_inverse_olb_test:   octet  3 (SB  0)   : 01000010 (0x42)
 s1g_tim_inverse_olb_test:   octet  4 (SB  1)   : 10100000 (0xa0)
 s1g_tim_inverse_olb_test:   octet  5 (SB  2)   : 01000010 (0x42)
 s1g_tim_inverse_olb_test:   octet  6 (SB  3)   : 10100000 (0xa0)
 s1g_tim_inverse_olb_test:   octet  7 (SB  4)   : 01000010 (0x42)
 s1g_tim_inverse_olb_test:   octet  8 (SB  5)   : 10100000 (0xa0)
 s1g_tim_inverse_olb_test:   octet  9 (SB  6)   : 01000010 (0x42)
 s1g_tim_inverse_olb_test:   octet 10 (SB  7)   : 10100000 (0xa0)
 s1g_tim_inverse_olb_test:   octet 11 (SB  8)   : 01000010 (0x42)
ok 6 s1g_tim_inverse_olb_test
 mac80211-s1g-tim: pass:6 fail:0 skip:0 total:6
 Totals: pass:6 fail:0 skip:0 total:6

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/tests/Makefile  |   2 +-
 net/mac80211/tests/s1g_tim.c | 357 +++++++++++++++++++++++++++++++++++
 2 files changed, 358 insertions(+), 1 deletion(-)
 create mode 100644 net/mac80211/tests/s1g_tim.c

diff --git a/net/mac80211/tests/Makefile b/net/mac80211/tests/Makefile
index 3b0c08356fc5..3c7f874e5c41 100644
--- a/net/mac80211/tests/Makefile
+++ b/net/mac80211/tests/Makefile
@@ -1,3 +1,3 @@
-mac80211-tests-y += module.o util.o elems.o mfp.o tpe.o chan-mode.o
+mac80211-tests-y += module.o util.o elems.o mfp.o tpe.o chan-mode.o s1g_tim.o
 
 obj-$(CONFIG_MAC80211_KUNIT_TEST) += mac80211-tests.o
diff --git a/net/mac80211/tests/s1g_tim.c b/net/mac80211/tests/s1g_tim.c
new file mode 100644
index 000000000000..d7352abdeb52
--- /dev/null
+++ b/net/mac80211/tests/s1g_tim.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for S1G TIM PVB decoding. This test suite covers
+ * IEEE80211-2024 Annex L figures 8, 9, 10, 12, 13, 14. ADE mode
+ * is not covered as it is an optional encoding format and is not
+ * currently supported by mac80211.
+ *
+ * Copyright (C) 2025 Morse Micro
+ */
+#include <linux/ieee80211.h>
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+
+#define MAX_AID 128
+
+#define BC(enc_mode, inverse, blk_off)                          \
+	((((blk_off) & 0x1f) << 3) | ((inverse) ? BIT(2) : 0) | \
+	 ((enc_mode) & 0x3))
+
+static void byte_to_bitstr(u8 v, char *out)
+{
+	for (int b = 7; b >= 0; b--)
+		*out++ = (v & BIT(b)) ? '1' : '0';
+	*out = '\0';
+}
+
+static void dump_tim_bits(struct kunit *test,
+			  const struct ieee80211_tim_ie *tim, u8 tim_len)
+{
+	const u8 *ptr = tim->virtual_map;
+	const u8 *end = (const u8 *)tim + tim_len;
+	unsigned int oct = 1;
+	unsigned int blk = 0;
+	char bits[9];
+
+	while (ptr < end) {
+		u8 ctrl = *ptr++;
+		u8 mode = ctrl & 0x03;
+		bool inverse = ctrl & BIT(2);
+		u8 blk_off = ctrl >> 3;
+
+		kunit_info(
+			test, "Block %u (ENC=%s, blk_off=%u, inverse=%u)", blk,
+			(mode == IEEE80211_S1G_TIM_ENC_MODE_BLOCK)  ? "BLOCK" :
+			(mode == IEEE80211_S1G_TIM_ENC_MODE_SINGLE) ? "SINGLE" :
+								      "OLB",
+			blk_off, inverse);
+
+		byte_to_bitstr(ctrl, bits);
+		kunit_info(test, "  octet %2u (ctrl)    : %s (0x%02x)", oct,
+			   bits, ctrl);
+		++oct;
+
+		switch (mode) {
+		case IEEE80211_S1G_TIM_ENC_MODE_BLOCK: {
+			u8 blkmap = *ptr++;
+
+			byte_to_bitstr(blkmap, bits);
+			kunit_info(test, "  octet %2u (blk-map) : %s (0x%02x)",
+				   oct, bits, blkmap);
+			++oct;
+
+			for (u8 sb = 0; sb < 8; sb++) {
+				if (!(blkmap & BIT(sb)))
+					continue;
+				u8 sub = *ptr++;
+
+				byte_to_bitstr(sub, bits);
+				kunit_info(
+					test,
+					"  octet %2u (SB %2u)   : %s (0x%02x)",
+					oct, sb, bits, sub);
+				++oct;
+			}
+			break;
+		}
+		case IEEE80211_S1G_TIM_ENC_MODE_SINGLE: {
+			u8 single = *ptr++;
+
+			byte_to_bitstr(single, bits);
+			kunit_info(test, "  octet %2u (single)  : %s (0x%02x)",
+				   oct, bits, single);
+			++oct;
+			break;
+		}
+		case IEEE80211_S1G_TIM_ENC_MODE_OLB: {
+			u8 len = *ptr++;
+
+			byte_to_bitstr(len, bits);
+			kunit_info(test, "  octet %2u (len=%2u)  : %s (0x%02x)",
+				   oct, len, bits, len);
+			++oct;
+
+			for (u8 i = 0; i < len && ptr < end; i++) {
+				u8 sub = *ptr++;
+
+				byte_to_bitstr(sub, bits);
+				kunit_info(
+					test,
+					"  octet %2u (SB %2u)   : %s (0x%02x)",
+					oct, i, bits, sub);
+				++oct;
+			}
+			break;
+		}
+		default:
+			kunit_info(test, "  ** unknown encoding 0x%x **", mode);
+			return;
+		}
+		blk++;
+	}
+}
+
+static inline u8 *tim_push(u8 **p, u8 v)
+{
+	*(*p)++ = v;
+	return *p;
+}
+
+static void tim_begin(struct ieee80211_tim_ie *tim, u8 **p)
+{
+	tim->dtim_count = 0;
+	tim->dtim_period = 1;
+	tim->bitmap_ctrl = 0;
+	*p = tim->virtual_map;
+}
+
+static u8 tim_end(struct ieee80211_tim_ie *tim, u8 *tail)
+{
+	return tail - (u8 *)tim;
+}
+
+static void pvb_add_block_bitmap(u8 **p, u8 blk_off, bool inverse, u8 blk_bmap,
+				 const u8 *subblocks)
+{
+	u8 enc = IEEE80211_S1G_TIM_ENC_MODE_BLOCK;
+	u8 n = hweight8(blk_bmap);
+
+	tim_push(p, BC(enc, inverse, blk_off));
+	tim_push(p, blk_bmap);
+
+	for (u8 i = 0; i < n; i++)
+		tim_push(p, subblocks[i]);
+}
+
+static void pvb_add_single_aid(u8 **p, u8 blk_off, bool inverse, u8 single6)
+{
+	u8 enc = IEEE80211_S1G_TIM_ENC_MODE_SINGLE;
+
+	tim_push(p, BC(enc, inverse, blk_off));
+	tim_push(p, single6 & GENMASK(5, 0));
+}
+
+static void pvb_add_olb(u8 **p, u8 blk_off, bool inverse, const u8 *subblocks,
+			u8 len)
+{
+	u8 enc = IEEE80211_S1G_TIM_ENC_MODE_OLB;
+
+	tim_push(p, BC(enc, inverse, blk_off));
+	tim_push(p, len);
+	for (u8 i = 0; i < len; i++)
+		tim_push(p, subblocks[i]);
+}
+
+static void check_all_aids(struct kunit *test,
+			   const struct ieee80211_tim_ie *tim, u8 tim_len,
+			   const unsigned long *expected)
+{
+	for (u16 aid = 1; aid <= MAX_AID; aid++) {
+		bool want = test_bit(aid, expected);
+		bool got = ieee80211_s1g_check_tim(tim, tim_len, aid);
+
+		KUNIT_ASSERT_EQ_MSG(test, got, want,
+				    "AID %u mismatch (got=%d want=%d)", aid,
+				    got, want);
+	}
+}
+
+static void fill_bitmap(unsigned long *bm, const u16 *list, size_t n)
+{
+	size_t i;
+
+	bitmap_zero(bm, MAX_AID + 1);
+	for (i = 0; i < n; i++)
+		__set_bit(list[i], bm);
+}
+
+static void fill_bitmap_inverse(unsigned long *bm, u16 max_aid,
+				const u16 *except, size_t n_except)
+{
+	bitmap_zero(bm, MAX_AID + 1);
+	for (u16 aid = 1; aid <= max_aid; aid++)
+		__set_bit(aid, bm);
+
+	for (size_t i = 0; i < n_except; i++)
+		if (except[i] <= max_aid)
+			__clear_bit(except[i], bm);
+}
+
+static void s1g_tim_block_test(struct kunit *test)
+{
+	u8 buf[256] = {};
+	struct ieee80211_tim_ie *tim = (void *)buf;
+	u8 *p, tim_len;
+	static const u8 subblocks[] = {
+		0x42, /* SB m=0: AIDs 1,6 */
+		0xA0, /* SB m=2: AIDs 21,23 */
+	};
+	u8 blk_bmap = 0x05; /* bits 0 and 2 set */
+	bool inverse = false;
+	static const u16 set_list[] = { 1, 6, 21, 23 };
+	DECLARE_BITMAP(exp, MAX_AID + 1);
+
+	tim_begin(tim, &p);
+	pvb_add_block_bitmap(&p, 0, inverse, blk_bmap, subblocks);
+	tim_len = tim_end(tim, p);
+
+	fill_bitmap(exp, set_list, ARRAY_SIZE(set_list));
+
+	dump_tim_bits(test, tim, tim_len);
+	check_all_aids(test, tim, tim_len, exp);
+}
+
+static void s1g_tim_single_test(struct kunit *test)
+{
+	u8 buf[256] = {};
+	struct ieee80211_tim_ie *tim = (void *)buf;
+	u8 *p, tim_len;
+	bool inverse = false;
+	u8 blk_off = 0;
+	u8 single6 = 0x1f; /* 31 */
+	static const u16 set_list[] = { 31 };
+	DECLARE_BITMAP(exp, MAX_AID + 1);
+
+	tim_begin(tim, &p);
+	pvb_add_single_aid(&p, blk_off, inverse, single6);
+	tim_len = tim_end(tim, p);
+
+	fill_bitmap(exp, set_list, ARRAY_SIZE(set_list));
+
+	dump_tim_bits(test, tim, tim_len);
+	check_all_aids(test, tim, tim_len, exp);
+}
+
+static void s1g_tim_olb_test(struct kunit *test)
+{
+	u8 buf[256] = {};
+	struct ieee80211_tim_ie *tim = (void *)buf;
+	u8 *p, tim_len;
+	bool inverse = false;
+	u8 blk_off = 0;
+	static const u16 set_list[] = { 1,  6,	13, 15, 17, 22, 29, 31, 33,
+					38, 45, 47, 49, 54, 61, 63, 65, 70 };
+	static const u8 subblocks[] = { 0x42, 0xA0, 0x42, 0xA0, 0x42,
+					0xA0, 0x42, 0xA0, 0x42 };
+	u8 len = ARRAY_SIZE(subblocks);
+	DECLARE_BITMAP(exp, MAX_AID + 1);
+
+	tim_begin(tim, &p);
+	pvb_add_olb(&p, blk_off, inverse, subblocks, len);
+	tim_len = tim_end(tim, p);
+
+	fill_bitmap(exp, set_list, ARRAY_SIZE(set_list));
+
+	dump_tim_bits(test, tim, tim_len);
+	check_all_aids(test, tim, tim_len, exp);
+}
+
+static void s1g_tim_inverse_block_test(struct kunit *test)
+{
+	u8 buf[256] = {};
+	struct ieee80211_tim_ie *tim = (void *)buf;
+	u8 *p, tim_len;
+	/* Same sub-block content as Figure L-8, but inverse = true */
+	static const u8 subblocks[] = {
+		0x42, /* SB m=0: AIDs 1,6 */
+		0xA0, /* SB m=2: AIDs 21,23 */
+	};
+	u8 blk_bmap = 0x05;
+	bool inverse = true;
+	/*  All AIDs except 1,6,21,23 are set */
+	static const u16 except[] = { 1, 6, 21, 23 };
+	DECLARE_BITMAP(exp, MAX_AID + 1);
+
+	tim_begin(tim, &p);
+	pvb_add_block_bitmap(&p, 0, inverse, blk_bmap, subblocks);
+	tim_len = tim_end(tim, p);
+
+	fill_bitmap_inverse(exp, 63, except, ARRAY_SIZE(except));
+
+	dump_tim_bits(test, tim, tim_len);
+	check_all_aids(test, tim, tim_len, exp);
+}
+
+static void s1g_tim_inverse_single_test(struct kunit *test)
+{
+	u8 buf[256] = {};
+	struct ieee80211_tim_ie *tim = (void *)buf;
+	u8 *p, tim_len;
+	bool inverse = true;
+	u8 blk_off = 0;
+	u8 single6 = 0x1f; /* 31 */
+	/*  All AIDs except 31 are set */
+	static const u16 except[] = { 31 };
+	DECLARE_BITMAP(exp, MAX_AID + 1);
+
+	tim_begin(tim, &p);
+	pvb_add_single_aid(&p, blk_off, inverse, single6);
+	tim_len = tim_end(tim, p);
+
+	fill_bitmap_inverse(exp, 63, except, ARRAY_SIZE(except));
+
+	dump_tim_bits(test, tim, tim_len);
+	check_all_aids(test, tim, tim_len, exp);
+}
+
+static void s1g_tim_inverse_olb_test(struct kunit *test)
+{
+	u8 buf[256] = {};
+	struct ieee80211_tim_ie *tim = (void *)buf;
+	u8 *p, tim_len;
+	bool inverse = true;
+	u8 blk_off = 0, len;
+	/*  All AIDs except the list below are set */
+	static const u16 except[] = { 1,  6,  13, 15, 17, 22, 29, 31, 33,
+				      38, 45, 47, 49, 54, 61, 63, 65, 70 };
+	static const u8 subblocks[] = { 0x42, 0xA0, 0x42, 0xA0, 0x42,
+					0xA0, 0x42, 0xA0, 0x42 };
+	len = ARRAY_SIZE(subblocks);
+	DECLARE_BITMAP(exp, MAX_AID + 1);
+
+	tim_begin(tim, &p);
+	pvb_add_olb(&p, blk_off, inverse, subblocks, len);
+	tim_len = tim_end(tim, p);
+
+	fill_bitmap_inverse(exp, 127, except, ARRAY_SIZE(except));
+
+	dump_tim_bits(test, tim, tim_len);
+	check_all_aids(test, tim, tim_len, exp);
+}
+
+static struct kunit_case s1g_tim_test_cases[] = {
+	KUNIT_CASE(s1g_tim_block_test),
+	KUNIT_CASE(s1g_tim_single_test),
+	KUNIT_CASE(s1g_tim_olb_test),
+	KUNIT_CASE(s1g_tim_inverse_block_test),
+	KUNIT_CASE(s1g_tim_inverse_single_test),
+	KUNIT_CASE(s1g_tim_inverse_olb_test),
+	{}
+};
+
+static struct kunit_suite s1g_tim = {
+	.name = "mac80211-s1g-tim",
+	.test_cases = s1g_tim_test_cases,
+};
+
+kunit_test_suite(s1g_tim);
-- 
2.43.0


