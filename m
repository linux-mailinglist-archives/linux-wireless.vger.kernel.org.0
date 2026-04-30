Return-Path: <linux-wireless+bounces-35665-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBOVE/Th8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35665-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:00:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 744E049D720
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B853F30187AD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D1636C0AC;
	Thu, 30 Apr 2026 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="bzVw1NdE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94E370D6C
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525092; cv=none; b=XDKJ3Cnp9GG1A841m/qg/AmokfGPW9HUqGKUSk4P7r8Zj4cxqlLn2fkbHj6XiCH+Z/QDNvGn6/3fwR6h0bKm9M0SaU5k4ui/nD+7X34Q6j0nLTtz5mMIjwatvKhl8OYv7UVlljxjQ3KBeAE9gA7IyCExNC4nD9fzfCH47exH9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525092; c=relaxed/simple;
	bh=nuhV7G9k48wFpNm+5liMHSJSyBJiTnsYHoDl1J5mlho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsbJZSRQbFB+vcUgBLzgIrRoRIfLgVdeGNp7LVc1eyktDLuzRgG/gwQMwRhyulH6xeQk+RrgYtezGAb93qb6W+GGKZTvkVJY4EPnyQJBJ+GjeS76CHAbfkUROA0/wKFz5V/sM4Yo4rBSqpigRIwLneHz8raoPzeTLkVyYLTm0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=bzVw1NdE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8296d553142so310727b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525090; x=1778129890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3KgrWPZFMN9mgEMGsi8eNgrt9xQ0X0w9ehukBMUwHU=;
        b=bzVw1NdEalNPZQfj9kDWHFrEiJFlMgDZUvphq2o7gHX3Lzoa6bGdeeHkRXuCqwk50K
         /t1OS0XxmK/cn8l6U8W52B+EV5Gso5PRfuLH4g1hWTzyZFwq8c678E506awHqOGZ9sM7
         O3uiJOEt3YI2O2XClMjanXeQZZpsmUfZR/mH+qL2QsMsd7c+vF3JsrnrcoWhrsZpZ6X3
         gos2sAK7opw4HkVU12xF3NMkPpU/xwDzgluhKZIZQePB6OxRzvR+2LAzgb87CZAlB+9C
         uzNGT65M9ysGzG+Jc2OTumDT6Sgwqf3S5wyTHmgpSSFE+V80ydXC/Lt3WOVXFE9YenCj
         MvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525090; x=1778129890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3KgrWPZFMN9mgEMGsi8eNgrt9xQ0X0w9ehukBMUwHU=;
        b=ZNLf5qJCsHiMW3xjrvP/Jtl1sYkXZ+gPdVk+CBCeKLC3PBLr2CHZ9a56CDeODBgLRG
         EZIl5b//o8/KUH/3YQO3AluWHWGn1BdDYnQK1vVl6zbnXfADAFSKJDh0rOrC6McTXx3C
         aDtzQi9lOAkNB78xppdEUt/9wi337wTQEiox9nSlhk90boA6FQfJtpuZJw7immrfzhSR
         gPhKIZeqe9sWEOguYxn7t0RnBbMyvDep4rTi79D5xC953UcbGdSUjyoB8lxs27e27mle
         wV4d+0tJKuGL4QsNvRlN7ZH7k3Q2d2BmTVDeKgBkx34KS4oyEOttrtfLwd2ls+PDBqgT
         7Fqg==
X-Forwarded-Encrypted: i=1; AFNElJ+cQTp9+/mwEDKJG/8tMEhsYI9oMrFOdKQMeNjMEzUaKG91Ivunk+65YU4Wgmu+FTlTYxAMw3QaaFnLa2MRKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jDac55fbE64zhWGo79TsQGLiRhKRJQyr9OUkZyRcTk8rjX7C
	mIixOR15ChdDgDbtW6yVSHtPuPDb+Myhb+UJ9qgL6mGAJruaoXoTuKekL1cnnEe+8Vk=
X-Gm-Gg: AeBDietZjOR8kI3rWoi9jdoOwn6G9dzpmi7zImgCR6B32PzYYgzk8wVOjoGkk+uOIN3
	ZucfMkO14vEeN2yhtAVQ09hAriqAR+2cJQDu6KqUfx0V1B9rxYF/jzCLjrLWfVCSW38LrnuCd9C
	DBTRsQxG4eGs+0D2bat8X95M+uNs5S8PTcM6mnMXtMC3/2SrMnRKI3N2zGgCCVBBRw9glDEIsSJ
	wk84s2bSE1vPgcDTRUSyTVyw/miPA8kCUm7TCd27GgOXmWJ411wQEPVBDZcXC0B3OU6/T0niOTN
	k7fUG9Ec/NirY5HqI2xql2hUcjCdvhXnSJfUaTRSPVKrAGm3RAheyTtPZH/rN1s2VHe4ecsRsHg
	FQLfdfpdSKerTnjZlgRYwlgJdCUFD2/TzChhGnQY4ZyLpjKvQrQaDrLlT+RkQk1RTTtWQ8Yeka/
	OXNEurBajUBAUAthoNYbamJUisu0oKBW8TZZIY69qs/XSXFhXs6QQwMplmlUkh91pdgcUbSgrzg
	P8athQwgxFBzYRB7g/Lj9HuLUQVq3p83nY/o/sDWFqBi0BDuKP2
X-Received: by 2002:a05:6a00:ab09:b0:824:9bc5:e946 with SMTP id d2e1a72fcca58-834fdd113e1mr1757748b3a.46.1777525090600;
        Wed, 29 Apr 2026 21:58:10 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:58:10 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 18/31] wifi: mm81x: add rate_code.h
Date: Thu, 30 Apr 2026 14:55:44 +1000
Message-ID: <20260430045615.334669-19-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 744E049D720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35665-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 .../net/wireless/morsemicro/mm81x/rate_code.h | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rate_code.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/rate_code.h b/drivers/net/wireless/morsemicro/mm81x/rate_code.h
new file mode 100644
index 000000000000..c60fcb9447c4
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/rate_code.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_RATE_CODE_H_
+#define _MM81X_RATE_CODE_H_
+
+#include <linux/types.h>
+
+enum dot11_bandwidth {
+	DOT11_BANDWIDTH_1MHZ = 0,
+	DOT11_BANDWIDTH_2MHZ = 1,
+	DOT11_BANDWIDTH_4MHZ = 2,
+	DOT11_BANDWIDTH_8MHZ = 3,
+	DOT11_BANDWIDTH_16MHZ = 4,
+
+	DOT11_MAX_BANDWIDTH = DOT11_BANDWIDTH_16MHZ,
+	DOT11_INVALID_BANDWIDTH = 5
+};
+
+enum mm81x_rate_preamble {
+	/* S1G LONG format (with SIG-A and SIG-B) */
+	MM81X_RATE_PREAMBLE_S1G_LONG = 0,
+	/* This is the most common format used */
+	MM81X_RATE_PREAMBLE_S1G_SHORT = 1,
+	/* S1G 1M format */
+	MM81X_RATE_PREAMBLE_S1G_1M = 2,
+
+	MM81X_RATE_MAX_PREAMBLE = MM81X_RATE_PREAMBLE_S1G_1M,
+	MM81X_RATE_INVALID_PREAMBLE = 7
+};
+
+typedef __le32 mm81x_rate_code_t;
+
+#define MM81X_RATECODE_PREAMBLE (0x0000000F)
+#define MM81X_RATECODE_MCS_INDEX (0x000000F0)
+#define MM81X_RATECODE_NSS_INDEX (0x00000700)
+#define MM81X_RATECODE_BW_INDEX (0x00003800)
+#define MM81X_RATECODE_RTS_FLAG (0x00010000)
+#define MM81X_RATECODE_SHORT_GI_FLAG (0x00040000)
+#define MM81X_RATECODE_DUP_BW_INDEX (0x01C00000)
+
+static inline enum mm81x_rate_preamble
+mm81x_ratecode_preamble_get(mm81x_rate_code_t rc)
+{
+	return (enum mm81x_rate_preamble)(
+		le32_get_bits(rc, MM81X_RATECODE_PREAMBLE));
+}
+
+static inline u8 mm81x_ratecode_mcs_index_get(mm81x_rate_code_t rc)
+{
+	return le32_get_bits(rc, MM81X_RATECODE_MCS_INDEX);
+}
+
+static inline u8 mm81x_ratecode_nss_index_get(mm81x_rate_code_t rc)
+{
+	return le32_get_bits(rc, MM81X_RATECODE_NSS_INDEX);
+}
+
+static inline enum dot11_bandwidth
+mm81x_ratecode_bw_index_get(mm81x_rate_code_t rc)
+{
+	return (enum dot11_bandwidth)(
+		le32_get_bits(rc, MM81X_RATECODE_BW_INDEX));
+}
+
+static inline bool mm81x_ratecode_rts_get(mm81x_rate_code_t rc)
+{
+	return le32_get_bits(rc, MM81X_RATECODE_RTS_FLAG);
+}
+
+static inline bool mm81x_ratecode_sgi_get(mm81x_rate_code_t rc)
+{
+	return le32_get_bits(rc, MM81X_RATECODE_SHORT_GI_FLAG);
+}
+
+static inline enum dot11_bandwidth
+mm81x_ratecode_dup_bw_index_get(mm81x_rate_code_t rc)
+{
+	return (enum dot11_bandwidth)(
+		le32_get_bits(rc, MM81X_RATECODE_DUP_BW_INDEX));
+}
+
+#define MM81X_RATECODE_INIT(bw_idx, nss_idx, mcs_idx, preamble)  \
+	(le32_encode_bits((bw_idx), MM81X_RATECODE_BW_INDEX) |   \
+	 le32_encode_bits((nss_idx), MM81X_RATECODE_NSS_INDEX) | \
+	 le32_encode_bits((mcs_idx), MM81X_RATECODE_MCS_INDEX) | \
+	 le32_encode_bits((preamble), MM81X_RATECODE_PREAMBLE))
+
+static inline mm81x_rate_code_t
+mm81x_ratecode_init(enum dot11_bandwidth bw_index, u32 nss_index, u32 mcs_index,
+		    enum mm81x_rate_preamble preamble)
+{
+	return MM81X_RATECODE_INIT(bw_index, nss_index, mcs_index, preamble);
+}
+
+static inline void
+mm81x_ratecode_preamble_set(mm81x_rate_code_t *rc,
+			    enum mm81x_rate_preamble preamble)
+{
+	*rc = (*rc & cpu_to_le32(~MM81X_RATECODE_PREAMBLE)) |
+	      le32_encode_bits(preamble, MM81X_RATECODE_PREAMBLE);
+}
+
+static inline void mm81x_ratecode_mcs_index_set(mm81x_rate_code_t *rc,
+						u32 mcs_index)
+{
+	*rc = (*rc & cpu_to_le32(~MM81X_RATECODE_MCS_INDEX)) |
+	      le32_encode_bits(mcs_index, MM81X_RATECODE_MCS_INDEX);
+}
+
+static inline void mm81x_ratecode_nss_index_set(mm81x_rate_code_t *rc,
+						u32 nss_index)
+{
+	*rc = (*rc & cpu_to_le32(~MM81X_RATECODE_NSS_INDEX)) |
+	      le32_encode_bits(nss_index, MM81X_RATECODE_NSS_INDEX);
+}
+
+static inline void mm81x_ratecode_bw_index_set(mm81x_rate_code_t *rc,
+					       enum dot11_bandwidth bw_index)
+{
+	*rc = (*rc & cpu_to_le32(~MM81X_RATECODE_BW_INDEX)) |
+	      le32_encode_bits(bw_index, MM81X_RATECODE_BW_INDEX);
+}
+
+static inline void
+mm81x_ratecode_update_s1g_bw_preamble(mm81x_rate_code_t *rc,
+				      enum dot11_bandwidth bw_index)
+{
+	enum mm81x_rate_preamble pream = MM81X_RATE_PREAMBLE_S1G_SHORT;
+
+	if (bw_index == DOT11_BANDWIDTH_1MHZ)
+		pream = MM81X_RATE_PREAMBLE_S1G_1M;
+
+	mm81x_ratecode_preamble_set(rc, pream);
+	mm81x_ratecode_bw_index_set(rc, bw_index);
+}
+
+static inline void
+mm81x_ratecode_dup_bw_index_set(mm81x_rate_code_t *rc,
+				enum dot11_bandwidth dup_bw_index)
+{
+	*rc = (*rc & cpu_to_le32(~MM81X_RATECODE_DUP_BW_INDEX)) |
+	      le32_encode_bits(dup_bw_index, MM81X_RATECODE_DUP_BW_INDEX);
+}
+
+static inline void mm81x_ratecode_enable_rts(mm81x_rate_code_t *rc)
+{
+	*rc |= cpu_to_le32(MM81X_RATECODE_RTS_FLAG);
+}
+
+static inline void mm81x_ratecode_enable_sgi(mm81x_rate_code_t *rc)
+{
+	*rc |= cpu_to_le32(MM81X_RATECODE_SHORT_GI_FLAG);
+}
+
+static inline enum dot11_bandwidth mm81x_ratecode_bw_mhz_to_bw_index(u8 bw_mhz)
+{
+	return ((bw_mhz == 1) ? DOT11_BANDWIDTH_1MHZ :
+		(bw_mhz == 2) ? DOT11_BANDWIDTH_2MHZ :
+		(bw_mhz == 4) ? DOT11_BANDWIDTH_4MHZ :
+		(bw_mhz == 8) ? DOT11_BANDWIDTH_8MHZ :
+				DOT11_BANDWIDTH_2MHZ);
+}
+
+static inline u8
+mm81x_ratecode_bw_index_to_s1g_bw_mhz(enum dot11_bandwidth bw_idx)
+{
+	return ((bw_idx == DOT11_BANDWIDTH_1MHZ) ? 1 :
+		(bw_idx == DOT11_BANDWIDTH_2MHZ) ? 2 :
+		(bw_idx == DOT11_BANDWIDTH_4MHZ) ? 4 :
+		(bw_idx == DOT11_BANDWIDTH_8MHZ) ? 8 :
+						   2);
+}
+
+#endif
-- 
2.43.0


