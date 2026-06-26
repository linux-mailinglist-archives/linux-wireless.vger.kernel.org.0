Return-Path: <linux-wireless+bounces-38131-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EqBINEcePmosAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38131-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:37:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46D6CAB14
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:37:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=MRjN45Gf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38131-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38131-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C166B3062C7D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E5A3DB65A;
	Fri, 26 Jun 2026 06:32:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E13D7D9B
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:32:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455555; cv=none; b=h/3/vhXBS1cOck2S1b60ePU9E8rirXZ5d/PCoPLWJbCKsVErnoT1eB3bof9VJm4plAK79yHNOtbEkGj2RCeJbxZqJ87dP8NTzGLYsOJNahOg1KhIVgTZXGXTrvpX+hn5fAxjrKn6HUW7CqLif1NbUQai88DYB0JR6RLpu8NHrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455555; c=relaxed/simple;
	bh=nuhV7G9k48wFpNm+5liMHSJSyBJiTnsYHoDl1J5mlho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgJ1S+TmPr3tpd/GrCG/VA3R1Vh2DQJV5cjAwl3fHH0LgukJ2gIg5QEUaVVsaLbs11G01CuQMqkWp7BqctpBjfNoJVyoZCVIvSWe/JoxOAISt/olYex+dbFd2IlpAOUSstai5xiZ0yUSPIKwdbNjM0h/EPux/IraniLv0UWYyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=MRjN45Gf; arc=none smtp.client-ip=74.125.82.47
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1390f75d8bbso410969c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455553; x=1783060353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3KgrWPZFMN9mgEMGsi8eNgrt9xQ0X0w9ehukBMUwHU=;
        b=MRjN45Gf+xbujh+MO5xO4RduozQE863KAs+cm/lVLuqcbQn+vZqi8vaXOds8/zTfOA
         UG+3gUd8YVYB5MYdpbrbTuY5tq4UEML9UCU9BLyoBpAZv2aUxbEHDZ3TfVKlYUrcADR9
         YPkXn00c63lxjQ1KrNGb8OkLy7dlXztcmAbO3M/uU4IANF59BFfjXsAAPPZpF/HYxpPR
         43pvi87PIGulK81vU67evgNOn+T4T3A/PokRWPrd75ZZIeOUX7oHM8qfswZ9wU4b7Soy
         Vf0LgJFcnv3/RT8KVmp6Fe+zoEQf79Udj/lkv6HzXFdAL1K2f9i0+7bZrr4G/wkkIGqu
         3E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455553; x=1783060353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3KgrWPZFMN9mgEMGsi8eNgrt9xQ0X0w9ehukBMUwHU=;
        b=TJt3pLw0vdqc2JM1qubYaKTQiV6yfyaTS+IDlxNsprDwUtsVxeK88DUXmChbMPIsFF
         0SVVxE/4BTDbmeairZHIENboJpJTeMUOgGK2GLwqSJOlhaXs47MN9q7RxQvedvh6I4Sb
         Bi8YUE+LIaes+qRByqarLWyIl3D162Yl08j62zQRjyX11k52J9nwJ+0P97ld5//Cy652
         qv/FuW7SliCzBm88IYRxnUYuK1u3c+rIcwrQfjcITnEXP/VZZNIgscS+Csuke7cMtyp3
         nndxz8W15oFkEoGHo0n9j4LeQjohkZ/aASYIRcadnb7y5TLTy/irkKgX+vLhxo9cmbZy
         mygw==
X-Forwarded-Encrypted: i=1; AFNElJ8mXwn8z0zkf6IC0rzL9uWMAXzskaQ5wudmkYYFuz4Bq4rv1CRN12qBiiA7on3kOVRIxZvYtuw+ZIYou9Na7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDjDeKmRi+dZcAD/D6kPm8WV/O+ge2kbHsaie3C5cYCevcomTm
	RMH2hZaTSxuaI6euTgx10tZ3UK6PM31hXOaJqu3aa0hwWsN9f7Fcxrsb1IRKfbNSXhY=
X-Gm-Gg: AfdE7cmAZCoySsbBKtyCOO24aeWPJG8UFql1+9kxGD70505D1YRgmmJzJhvxkP0XKsD
	xJRPN8D138tb0yqM7z1Y7pFQUv4IARdxEZ95G0mEZeRy60lRbpyK1id4Fi4fd8F6fTYdbq7e9Be
	qsez5eoyBy3XocAANAjyxcmsISVTZfqsrwhVr0A8UyQ+1qsAr7N8VxyoFOkPfzjxG4I9QEeVbf6
	Njl3z0J06lXzRx02PFZIidtBsAiFenkpCNNHiTyz98Bjwc12bH8yqK2cJiKgxjudrs38fKUpdnO
	iYTc06tqjenoKEy++oq/VMtdQ1Mnaz71IJC4AEERaqjKDcweEV0M7ZkhNlWUnDmm4HcCfgWymOT
	5jVFln0TKsLymuwjIUp9FbzxwYiYrG+61ZqzKLVtXrYn/zEssdOlPbhVZspejVKAtd66KaZ/ydJ
	BRp+QHFSG/R+CWn07qxPsTGVOFUmKtE92a0xMTBQUudKxsX6SSz+EopZ3XR+cmiVRVMoKQqQHsI
	R5/JhTnWRuj1PCJNDg0
X-Received: by 2002:a05:7022:e15:b0:138:576:fd with SMTP id a92af1059eb24-139dbabb07emr5067709c88.2.1782455552577;
        Thu, 25 Jun 2026 23:32:32 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:32:32 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 20/33] wifi: mm81x: add rate_code.h
Date: Fri, 26 Jun 2026 16:29:16 +1000
Message-ID: <20260626063014.1275235-21-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38131-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC46D6CAB14

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


