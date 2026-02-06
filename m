Return-Path: <linux-wireless+bounces-31625-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI6ECCo4hmmcLAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31625-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 19:51:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74256102431
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 19:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A2E3049941
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96F42FF172;
	Fri,  6 Feb 2026 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKaP7OoC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE5350A21
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403790; cv=none; b=VKM+F8VnBTvtgs3Qo7Im3ugVddR1Za0AZ5XwhfLAT5m5pzOoqcD0PM03m/1C/+E+JwSUgwU1/rJij4373TIAkSGdJ0zQZbv8/g+ERGYhmm57IiFFdHxJynLbGlmmDUFAToAPhNzEXtmwyo3Q4vl0TUm4LQTbIZm01udJPJ8P1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403790; c=relaxed/simple;
	bh=C02h060rnQCN546k0hiNRZqULpwNOVMw5ilwaPU7quc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYO2tPTOBDHLaOOSdv7QqLJo+dUJYbX6iMS+rTbS0RNUsXhrH1GP159Xl4atFK95BPI+JOPftWw0UMJbDWUXXIgJs9ha1aqMulntDl0l6Fvfc7/+/ZvTlYSc17OTYuOD6oMhY/nMFrcpeQqR45zMbYTMzjjJlS3cvb4GC3FVDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKaP7OoC; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4807068eacbso23115805e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 06 Feb 2026 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770403789; x=1771008589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPbWznIkUwjUswvnAk25MhgIW6wwd6f4YdTadQuIACg=;
        b=jKaP7OoCC+D49wDDoVyTYBDZVGgCC8YgleFhgF0w9bUeGaiv5MrSGA3zziycUBVLog
         x5+HbfEG/wzulEYQRZsT9szCY5ydx32hd/al+SjhE+t/imAIdlPQb5cYprgMEDnqJWUZ
         CbaWSlWWvW165HRWKSJzgDxUxbR4hVwgJJPHfmpGocOkH7MKFzrGeDDo/TjnB/OP1rjP
         u2sLYYdRO/A9RhcuKvWzp6BKDoWfBMLGDkbmkshtHAfE+O76da7/zd/Qihhe0c6uM76g
         JnUkI4Tj/6D/EwQY3pkrVUoRor/4W6HSQ0P9cziwUTgZlBtSyZ45wc06fYB72leyx3P8
         65Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770403789; x=1771008589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPbWznIkUwjUswvnAk25MhgIW6wwd6f4YdTadQuIACg=;
        b=ve7OCIF9XWo514xQdR8pbbY8lY0W8ldstLDhW6HQ3RWZ5/3ml0WiVcNmhkux33qVSX
         6XhLMU0PVWMHJVpqQnVovIj9ssJYXeQ2JwnHRMHjIYWwQ/NvcAx+Tm++9HOSbUbSGYSt
         8So3N4Rs5ghupjJuojKgJLQUJf5/b3U8RrQ3PPK0DhJfHbw3/2LZJt6rXTm7HMdkkO6G
         gb6wRUh2z/gF/Vw3nC25MYuGMMnb2B7/9mjLeZkVUkhOpqxOleCyDMRdPDIdVLMNgVlo
         IP2zGJsueq9Epf4qGyHCgYJw2D+1tSnlJ5jz/IZqq9bYtvKI9IT8iswf6Za7tfBYbKjU
         SRIA==
X-Gm-Message-State: AOJu0YwzeaHNlWa5xw4YX2BRJhb/qb1nCtu5dgd1k4KYVllYaIF85sFU
	zktlXSafgNdA3sS29UyOjVPIVD7Iw1sdIo6zJrGhl4v1GjYX+Qi1S7ImjNP4HndToeU=
X-Gm-Gg: AZuq6aJJ/stTxHD2HnVQHtIUOWalSo0KS2AqcLdykSoZOqlGH3F09ZNTOcEmySAs+2N
	OzzuLM81RlYJzzLvLFXIMGPgtnEINZn5hJCmUV0/WuVHWtneX15Sn7617AklHVMiFTXdF2wTkm9
	JDv4e1JhpKAGBCTYNQ1pmBcgoXsVqsL0UriwDBtmRPRz8/vA3tR+r7fPfM+7QT5YELdQh3kRGX3
	quytoQiauiZ5kQPXtMQebLUg4shmOAklnx2ftUytAPZ/dzZcmDT6KZA/YfJRS/NyY+7MYp1QKFY
	hWKUvA+p8L7zqL6UE3wruzr6A/0HFmcsysr2pgf4ze7NVsOKvUmPut9ssOG+fKKDJ6Y0zB9Djmm
	AaHBTLJf8TRAXS8+dvVEdAEnAR45FS//xxwPMYjMhsd3Vd+QLLKfcgsSrbTF0i0cu1ZqMRbebJq
	71V8jYWA==
X-Received: by 2002:a05:600c:4e48:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-483201e408dmr46919485e9.11.1770403788523;
        Fri, 06 Feb 2026 10:49:48 -0800 (PST)
Received: from localhost.localdomain ([2001:4bc9:80a:9b3b::4c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096c438sm41542205e9.3.2026.02.06.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 10:49:48 -0800 (PST)
From: Oleksandr Veselov <ltwod205@gmail.com>
To: Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oleksandr Veselov <ltwod205@gmail.com>
Subject: [PATCH] wireless: intel/ipw2200: switch printk(KERN_*) to pr_*()
Date: Fri,  6 Feb 2026 19:50:41 +0100
Message-ID: <20260206185041.47106-1-ltwod205@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-31625-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltwod205@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74256102431
X-Rspamd-Action: no action

Signed-off-by: Oleksandr Veselov <ltwod205@gmail.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.h b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
index 19310fd0d8eb..7f661c3272e7 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.h
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
@@ -1377,12 +1377,12 @@ BIT_ARG16(x)
 
 #define IPW_DEBUG(level, fmt, args...) \
 do { if (ipw_debug_level & (level)) \
-  printk(KERN_DEBUG DRV_NAME": %s " fmt, __func__ , ## args); } while (0)
+  pr_debug(DRV_NAME": %s " fmt, __func__ , ## args); } while (0)
 
 #ifdef CONFIG_IPW2200_DEBUG
 #define IPW_LL_DEBUG(level, fmt, args...) \
 do { if (ipw_debug_level & (level)) \
-  printk(KERN_DEBUG DRV_NAME": %s " fmt, __func__ , ## args); } while (0)
+  pr_debug(DRV_NAME": %s " fmt, __func__ , ## args); } while (0)
 #else
 #define IPW_LL_DEBUG(level, fmt, args...) do {} while (0)
 #endif				/* CONFIG_IPW2200_DEBUG */
@@ -1448,8 +1448,8 @@ do { if (ipw_debug_level & (level)) \
 #define IPW_DL_MERGE         (1<<30)
 #define IPW_DL_QOS           (1<<31)
 
-#define IPW_ERROR(f, a...) printk(KERN_ERR DRV_NAME ": " f, ## a)
-#define IPW_WARNING(f, a...) printk(KERN_WARNING DRV_NAME ": " f, ## a)
+#define IPW_ERROR(f, a...) pr_err(DRV_NAME ": " f, ## a)
+#define IPW_WARNING(f, a...) pr_warn(DRV_NAME ": " f, ## a)
 #define IPW_DEBUG_INFO(f, a...)    IPW_DEBUG(IPW_DL_INFO, f, ## a)
 
 #define IPW_DEBUG_WX(f, a...)     IPW_DEBUG(IPW_DL_WX, f, ## a)
-- 
2.52.0


