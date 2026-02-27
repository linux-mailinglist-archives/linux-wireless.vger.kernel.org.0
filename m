Return-Path: <linux-wireless+bounces-32259-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ICdKQgboWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32259-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:18:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F7D1B2964
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 468113080D50
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF1E346E51;
	Fri, 27 Feb 2026 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="yuoam64T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D65345CB0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165634; cv=none; b=ct1oL7QJwP2wMU+XaHpLjeJSBFQCllTZ9o+2pgRzyYeRMAtc5FvzNaqYvWZZGuvHWqXb4ES4pdwQYjNJFY+/iK7U1rxpTCp5Q5vgnv1+vKnJmBd7rx780mSVmNuAbgHsDPh3r0/l8g2eXv4TueoUeMQyKvGxFKKDW0cT4hrW/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165634; c=relaxed/simple;
	bh=bnBsuEb8lcNZGAC4w52Jpl0Gp+eauM35nmPQhB/AKlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHswPEKfRRgmkDVWv22DwFt588NLe0tPcZhfFBFT2nvQ3mFhZfylZnRQ1zRlT7/RVQsmrHFL97mylmzaBGulDVqX4g1ahz/lJzUNLUjPU5SLHgNlDbBsqpIidec0E7AvPiFegFRqKdtHKyGXveeUQWul9HgAQuYgiyM//EpGB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=yuoam64T; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aadc18f230so10456955ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165633; x=1772770433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4HlubN+MNnCATTq9lczb8v/sKOUJWKivVWE32nYUqs=;
        b=yuoam64T6epQfzToyFZ1prUzBpwjbDYykhMlhvtlGd8XWTXZ9wrDWmNkGPBXYmPiqB
         8gkHxfHcBWyq1DrL9gnGBFE7aMlITr/+wjPnW9IOxP4/igmjNJo6cd3LzSNJvcqvB5iR
         UOAtLy768jumIe904uq+GfOH9wTOW7e5/sLUPTLDQXRBvHRzhe8uBDJj8+cc/b8DIaEg
         IZ8zevokd9RMBc8MHRzZ/kDhHLU2J2NqlbcGD7x0mC6Zvn6gJCbQ8vVSKzZLjkpRF9CK
         xUNt1Z+QUmuLVHoip8aG7eYNZZ20m4eIQUmZppmf79ExQJRhQadNmU88QfumYgex9f7B
         8l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165633; x=1772770433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4HlubN+MNnCATTq9lczb8v/sKOUJWKivVWE32nYUqs=;
        b=KrKsMvltP4Zx7g4P2/Er40qs2gziFMttQrDFIdv43nxIUIrrktJGdN77lY55m40dOs
         7wcP4UhrL2GqE0BQu3Ri5QbuJqtrUaY4c0Xxcptg9Ghlnd9JRa6HP4TN5GEtYI5ImAdm
         01yz6t/UpvB/jgeia6gXx6niSIMqUuqNIcggJIUyM0aKsqciYMwexeeF1l9L/Tx3m1sF
         Tk6fUAPAQMcFHIhSuWNiRuH6Bg3aYW9jQST6YXRRBG/s4lbBWteIfzNHlAH0doqBMvpk
         4RQ/M3hA/maHri1U97L4tktkg0HodxgKdvmz2HV6xGLuBPJrz+sJUW52rN0JbZaoAyxc
         BNXw==
X-Forwarded-Encrypted: i=1; AJvYcCWmAgdAZ1ZTqrL4SfzzzMo6BgcHnCx1h9t8TZFwEx4XtIisr+IIwUgqa6g0yHcNvTkd9RSwtechhQv1RZV/vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPmNBYV2aHsjJJKcT6uZIAih408Hcw9ZYsHqyzkwQKxABKM/S
	lTjY45q7MD6luvtgGczNBFO8GsHFWZpV6Enja84/GvQjR4Cos4rE+qrbPyFhJSW3ahSPKBPHFvz
	Nz7sY
X-Gm-Gg: ATEYQzzNx+8Yg2ozM/dIveTUoR+e80LvBhfvTZSzoy6jPFprZ/Np69H6UNz1iZOUfAg
	/5KXDsByTMgaUMWmeFOpEsgmfJRRKBWlBlHC7buAm+NpW1Haf7rT/h4tWrgsBcJd8HaCTjwhIOH
	cKO2wIax41AAVSORWzDQThI0+Y+E27+yjgX02i9baMIqmREEZVpbY8mbQ9d3HqPj14qeSyDkl6u
	K+QDISdzs/LafoH3Thz3hT8M1hRf6V72kioQPaqadXcMGGO253AuMz68e2XwqzSLQ2NJbMu74fE
	OYnyBe3FjDpW76yCjgvrDQRfh1nuKWTjwVfmPFwSHtX3KvmMdB9DabQHJ0wOCQlzyrKLKLxlPmd
	w4Ay0pdEqZLCfO7bqtD1y5e36PiREzap9u598ZtIntkuHYgCtbdpROgfixjRG7fUxlOLj5TRQIe
	ny8C0nv8RFKzUSCNRrqCF5POHGD8YDPCpIZ2TOV4ZolYp56NaSLuwzvuk4o0zn3kKSym3lkHssx
	wXYoALA0stfhErS6TFJMlRCE6D5ShUxXhdjYiJ56A==
X-Received: by 2002:a17:903:2ad0:b0:2ad:b97b:be88 with SMTP id d9443c01a7336-2ae2e46bd32mr15427355ad.32.1772165633082;
        Thu, 26 Feb 2026 20:13:53 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:13:52 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 20/35] wifi: mm81x: add rate_code.h
Date: Fri, 27 Feb 2026 15:10:30 +1100
Message-ID: <20260227041108.66508-21-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32259-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D2F7D1B2964
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
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


