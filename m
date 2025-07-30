Return-Path: <linux-wireless+bounces-26056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F81B15DB6
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 11:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D783A80EE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B4270ED4;
	Wed, 30 Jul 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHVZ+KXJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37FC26CE26;
	Wed, 30 Jul 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869436; cv=none; b=UOINjjqg/f8LCk70urbAtYS+PJT/yDmmGltm5x2qXjyb378OkgvZAfnodR4I0LvZvISfzhiDmVXng/JS1Fae2Z7lBq7dap6L145lncTcUoj49yB4jc5SgeCDUOy70HSrA4Zz/3GdjlqXQkpCiX98F2CN/9i43iJbavhwJvEHAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869436; c=relaxed/simple;
	bh=xh1m/Hq4fkECG93Bj452rNgMgVs6jUGNQGqYCe2awrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRzvI75jMAZ9dxb6lxpLhbsvVdPysoFXNe9mK8c93WBzHhN/q2SGHKBrZJEMLECYgTcZC+ma2i0sNwtsJyw34JDzmtYRvMUK7hKY6HvxPzFnjCJC7dnCBfhcK7ltcE3hBnxs+CrZsoDo/KwkQsOK0A8EFdVqYPAlz5OmuIF3q2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHVZ+KXJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-749068b9b63so485840b3a.0;
        Wed, 30 Jul 2025 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753869433; x=1754474233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qdjd+LcwTjcx8q1nuc0flVdauxRc2vZDyCofboY/WpI=;
        b=QHVZ+KXJ4zKAe47OSTL7aUvFtvHzoeE5AMk6G0XI+smU6g9oVSjLo9A4u9uugULurZ
         8J7C2qpxpmKC8oruWYs30QPVtTA0pNFxQMbXjZcYK7xuDXOqSkGIG7Tvslc1FJ19uZwV
         Sa63ATWQG9BHskoyd/RkPRe9IG6BLoWAUqoAnNYrS7W7SIEG8la7+zvJGbiFGhyYvA+J
         OOTByiJ1+cjrf5iJpVz5NtPqGnD1HG3Ari3BavOM/4qbuktz1dlk6UtwDf8Mzkj7qsOM
         w6Sle1jjQ9hQgZttrQPQo4uSJ3jAk+JYrvQWJcwJT5ZBeiLtvHQm8M994gQ+62nEmopL
         SWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753869433; x=1754474233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qdjd+LcwTjcx8q1nuc0flVdauxRc2vZDyCofboY/WpI=;
        b=N78kfROnGwcaqBYkhEuh1jsxfJoVdt/nepeBmUuCQ5+98FrC7A0lsfHhdh44V9Z6iP
         w5QZDg0ExKV0EiNzJCii2rOC33cv2ExrRySOsotmg5DMoaabX/OwgLrheLEfoY2OhZZd
         dbr9uL4XhRgKAk3ToM2BXHksahw3O05T7e3IfI/0o97pvFH4oGRgxDtEgxYzG091oLso
         mG+G2lDbcOMuyneeh9MkjWqWRBoV4tldpQ9xAhGdcEw2675g6DtHnLoEbzabw+fREgAB
         iReO4t1Mw3PXUCyxwENq+cCp/di36GnYsFN3HXBmC3k3luj0iP7Iq/OT+748L9N/HWdL
         A8nA==
X-Forwarded-Encrypted: i=1; AJvYcCW5stCM6bGU1YIY/G+XuXDw9TUG+sLakiQ+OQJPZhcFxeAwucJOVbd3MBKijt96v1tw0ir8aNO7h8Jefx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoMA9u6H1OzXT3Qcu3aUhzCGBRvXB50qur8XZMTQ87aDVm2/X
	gwIWOwltJvTimuHRkID0emISoKjIvYr7u3R9m4+YZqoz3BAavchzlzzi
X-Gm-Gg: ASbGncvFulJQmAHy9YUyD98+a3fWOuccIpItEfyqulyKlRWOFOJJwy5RjgCdPGFuD4Q
	fJLxTN59wFO4DOSq56+HNR2fjrGfhiWg7pmhnjv+ibg/8Rk8YINWs+Efc5id4dhOGhAZOaWw0Xp
	m9csLy/ylYo1/4Tv7zj8AL//cjSTlw5+rGU/7T8c03tGTEb4asPyzR3zn3sEW5nUUfR0W0V9Ybv
	NxceoeVA42sz2jKSqcn9GSfUzBOoyCwW5ixDpOulFiIKoE5Pn3WTRThu8YB/W5ZLUmJUx/FUOO8
	FKjlHr0LRTndoQbNDFYczOHbgNBv2lrTXif/zF20yQ9zZFoVuxGvq+OwRm97dhpK0BMdiuwPBWV
	sRPb6T4WiXFKiqfHmzV/4XGXztf+08bUbimM=
X-Google-Smtp-Source: AGHT+IESULsVlWgPsh82sFc5Fucb0jGIJewiHj1+YqmAGMb4oMd7gAWP8ZbVUhE6oH3uT8hVtmN4/Q==
X-Received: by 2002:a05:6a21:9994:b0:238:3f54:78f1 with SMTP id adf61e73a8af0-23dc0ed2c78mr4292061637.43.1753869432860;
        Wed, 30 Jul 2025 02:57:12 -0700 (PDT)
Received: from imran-device.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640881ee75sm10316350b3a.2.2025.07.30.02.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:57:12 -0700 (PDT)
From: Mande Imran Ahmed <immu.ahmed1905@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mande Imran Ahmed <immu.ahmed1905@gmail.com>
Subject: [PATCH] net/mac80211: replace scnprintf() with sysfs_emit() for sysfs output
Date: Wed, 30 Jul 2025 15:26:34 +0530
Message-ID: <20250730095634.3754-1-immu.ahmed1905@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace usage of scnprintf() with sysfs_emit() in the mac80211 module
to align with the guidelines outlined in
Documentation/filesystems/sysfs.rst

The scnprintf() function was previously used to format output for sysfs
files, but sysfs_emit() provides a cleaner and more efficient way to
emit data directly to sysfs attributes.

This change improves code readability and aligns with the recommended
practice for sysfs attribute output in the Linux kernel.

Tested functionality:
- Connection
- Fast ping
- iperf throughput tests

All tests passed successfully, confirming the stability and correctness
of the change.

Signed-off-by: Mande Imran Ahmed <immu.ahmed1905@gmail.com>
---
 net/mac80211/debugfs.c        |  84 +++++++-------
 net/mac80211/debugfs_key.c    |  53 +++++----
 net/mac80211/debugfs_netdev.c |  70 ++++++------
 net/mac80211/debugfs_sta.c    | 199 +++++++++++++++++-----------------
 4 files changed, 201 insertions(+), 205 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 69e03630f64c..13872b0bab9b 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -84,8 +84,8 @@ static ssize_t aqm_read(struct file *file,
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
 
-	len = scnprintf(buf, sizeof(buf),
-			"access name value\n"
+	len = sysfs_emit(buf,
+			 "access name value\n"
 			"R fq_flows_cnt %u\n"
 			"R fq_backlog %u\n"
 			"R fq_overlimit %u\n"
@@ -152,16 +152,15 @@ static ssize_t airtime_flags_read(struct file *file,
 				  size_t count, loff_t *ppos)
 {
 	struct ieee80211_local *local = file->private_data;
-	char buf[128] = {}, *pos, *end;
+	char buf[128] = {}, *pos;
 
 	pos = buf;
-	end = pos + sizeof(buf) - 1;
 
 	if (local->airtime_flags & AIRTIME_USE_TX)
-		pos += scnprintf(pos, end - pos, "AIRTIME_TX\t(%lx)\n",
+		pos += sysfs_emit(pos, "AIRTIME_TX\t(%lx)\n",
 				 AIRTIME_USE_TX);
 	if (local->airtime_flags & AIRTIME_USE_RX)
-		pos += scnprintf(pos, end - pos, "AIRTIME_RX\t(%lx)\n",
+		pos += sysfs_emit(pos, "AIRTIME_RX\t(%lx)\n",
 				 AIRTIME_USE_RX);
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf,
@@ -206,18 +205,18 @@ static ssize_t aql_pending_read(struct file *file,
 	char buf[400];
 	int len = 0;
 
-	len = scnprintf(buf, sizeof(buf),
-			"AC     AQL pending\n"
-			"VO     %u us\n"
-			"VI     %u us\n"
-			"BE     %u us\n"
-			"BK     %u us\n"
-			"total  %u us\n",
-			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_VO]),
-			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_VI]),
-			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BE]),
-			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BK]),
-			atomic_read(&local->aql_total_pending_airtime));
+	len = sysfs_emit(buf,
+			 "AC     AQL pending\n"
+			 "VO     %u us\n"
+			 "VI     %u us\n"
+			 "BE     %u us\n"
+			 "BK     %u us\n"
+			 "total  %u us\n",
+			 atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_VO]),
+			 atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_VI]),
+			 atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BE]),
+			 atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BK]),
+			 atomic_read(&local->aql_total_pending_airtime));
 	return simple_read_from_buffer(user_buf, count, ppos,
 				       buf, len);
 }
@@ -236,20 +235,20 @@ static ssize_t aql_txq_limit_read(struct file *file,
 	char buf[400];
 	int len = 0;
 
-	len = scnprintf(buf, sizeof(buf),
-			"AC	AQL limit low	AQL limit high\n"
-			"VO	%u		%u\n"
-			"VI	%u		%u\n"
-			"BE	%u		%u\n"
-			"BK	%u		%u\n",
-			local->aql_txq_limit_low[IEEE80211_AC_VO],
-			local->aql_txq_limit_high[IEEE80211_AC_VO],
-			local->aql_txq_limit_low[IEEE80211_AC_VI],
-			local->aql_txq_limit_high[IEEE80211_AC_VI],
-			local->aql_txq_limit_low[IEEE80211_AC_BE],
-			local->aql_txq_limit_high[IEEE80211_AC_BE],
-			local->aql_txq_limit_low[IEEE80211_AC_BK],
-			local->aql_txq_limit_high[IEEE80211_AC_BK]);
+	len = sysfs_emit(buf,
+			 "AC	AQL limit low	AQL limit high\n"
+			 "VO	%u		%u\n"
+			 "VI	%u		%u\n"
+			 "BE	%u		%u\n"
+			 "BK	%u		%u\n",
+			 local->aql_txq_limit_low[IEEE80211_AC_VO],
+			 local->aql_txq_limit_high[IEEE80211_AC_VO],
+			 local->aql_txq_limit_low[IEEE80211_AC_VI],
+			 local->aql_txq_limit_high[IEEE80211_AC_VI],
+			 local->aql_txq_limit_low[IEEE80211_AC_BE],
+			 local->aql_txq_limit_high[IEEE80211_AC_BE],
+			 local->aql_txq_limit_low[IEEE80211_AC_BK],
+			 local->aql_txq_limit_high[IEEE80211_AC_BK]);
 	return simple_read_from_buffer(user_buf, count, ppos,
 				       buf, len);
 }
@@ -313,8 +312,8 @@ static ssize_t aql_enable_read(struct file *file, char __user *user_buf,
 	char buf[3];
 	int len;
 
-	len = scnprintf(buf, sizeof(buf), "%d\n",
-			!static_key_false(&aql_disable.key));
+	len = sysfs_emit(buf, "%d\n",
+			 !static_key_false(&aql_disable.key));
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
@@ -365,7 +364,7 @@ static ssize_t force_tx_status_read(struct file *file,
 	char buf[3];
 	int len = 0;
 
-	len = scnprintf(buf, sizeof(buf), "%d\n", (int)local->force_tx_status);
+	len = sysfs_emit(buf, "%d\n", (int)local->force_tx_status);
 
 	return simple_read_from_buffer(user_buf, count, ppos,
 				       buf, len);
@@ -502,7 +501,7 @@ static ssize_t hwflags_read(struct file *file, char __user *user_buf,
 	struct ieee80211_local *local = file->private_data;
 	size_t bufsz = 30 * NUM_IEEE80211_HW_FLAGS;
 	char *buf = kzalloc(bufsz, GFP_KERNEL);
-	char *pos = buf, *end = buf + bufsz - 1;
+	char *pos = buf;
 	ssize_t rv;
 	int i;
 
@@ -516,7 +515,7 @@ static ssize_t hwflags_read(struct file *file, char __user *user_buf,
 
 	for (i = 0; i < NUM_IEEE80211_HW_FLAGS; i++) {
 		if (test_bit(i, local->hw.flags))
-			pos += scnprintf(pos, end - pos, "%s\n",
+			pos += sysfs_emit(pos, "%s\n",
 					 hw_flag_names[i]);
 	}
 
@@ -572,7 +571,7 @@ static ssize_t misc_read(struct file *file, char __user *user_buf,
 	/* Max len of each line is 16 characters, plus 9 for 'pending:\n' */
 	size_t bufsz = IEEE80211_MAX_QUEUES * 16 + 9;
 	char *buf;
-	char *pos, *end;
+	int len;
 	ssize_t rv;
 	int i;
 	int ln;
@@ -581,14 +580,11 @@ static ssize_t misc_read(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	pos = buf;
-	end = buf + bufsz - 1;
-
-	pos += scnprintf(pos, end - pos, "pending:\n");
+	len = sysfs_emit(buf, "pending:\n");
 
 	for (i = 0; i < IEEE80211_MAX_QUEUES; i++) {
 		ln = skb_queue_len(&local->pending[i]);
-		pos += scnprintf(pos, end - pos, "[%i] %d\n",
+		len += sysfs_emit_at(buf, len, "[%i] %d\n",
 				 i, ln);
 	}
 
@@ -643,7 +639,7 @@ static ssize_t format_devstat_counter(struct ieee80211_local *local,
 static int print_devstats_##name(struct ieee80211_low_level_stats *stats,\
 				 char *buf, int buflen)			\
 {									\
-	return scnprintf(buf, buflen, "%u\n", stats->name);		\
+	return sysfs_emit(buf, "%u\n", stats->name);		\
 }									\
 static ssize_t stats_ ##name## _read(struct file *file,			\
 				     char __user *userbuf,		\
diff --git a/net/mac80211/debugfs_key.c b/net/mac80211/debugfs_key.c
index 117f58af5ff9..e610c1f24df7 100644
--- a/net/mac80211/debugfs_key.c
+++ b/net/mac80211/debugfs_key.c
@@ -123,13 +123,13 @@ static ssize_t key_tx_spec_read(struct file *file, char __user *userbuf,
 	switch (key->conf.cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104:
-		len = scnprintf(buf, sizeof(buf), "\n");
+		len = sysfs_emit(buf, "\n");
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 		pn = atomic64_read(&key->conf.tx_pn);
-		len = scnprintf(buf, sizeof(buf), "%08x %04x\n",
-				TKIP_PN_TO_IV32(pn),
-				TKIP_PN_TO_IV16(pn));
+		len = sysfs_emit(buf, "%08x %04x\n",
+				 TKIP_PN_TO_IV32(pn),
+				 TKIP_PN_TO_IV16(pn));
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
@@ -140,9 +140,9 @@ static ssize_t key_tx_spec_read(struct file *file, char __user *userbuf,
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
 		pn = atomic64_read(&key->conf.tx_pn);
-		len = scnprintf(buf, sizeof(buf), "%02x%02x%02x%02x%02x%02x\n",
-				(u8)(pn >> 40), (u8)(pn >> 32), (u8)(pn >> 24),
-				(u8)(pn >> 16), (u8)(pn >> 8), (u8)pn);
+		len = sysfs_emit(buf, "%02x%02x%02x%02x%02x%02x\n",
+				 (u8)(pn >> 40), (u8)(pn >> 32), (u8)(pn >> 24),
+				 (u8)(pn >> 16), (u8)(pn >> 8), (u8)pn);
 		break;
 	default:
 		return 0;
@@ -162,12 +162,11 @@ static ssize_t key_rx_spec_read(struct file *file, char __user *userbuf,
 	switch (key->conf.cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104:
-		len = scnprintf(buf, sizeof(buf), "\n");
+		len = sysfs_emit(buf, "\n");
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 		for (i = 0; i < IEEE80211_NUM_TIDS; i++)
-			p += scnprintf(p, sizeof(buf)+buf-p,
-				       "%08x %04x\n",
+			p += sysfs_emit(p, "%08x %04x\n",
 				       key->u.tkip.rx[i].iv32,
 				       key->u.tkip.rx[i].iv16);
 		len = p - buf;
@@ -176,7 +175,7 @@ static ssize_t key_rx_spec_read(struct file *file, char __user *userbuf,
 	case WLAN_CIPHER_SUITE_CCMP_256:
 		for (i = 0; i < IEEE80211_NUM_TIDS + 1; i++) {
 			rpn = key->u.ccmp.rx_pn[i];
-			p += scnprintf(p, sizeof(buf)+buf-p,
+			p += sysfs_emit(p,
 				       "%02x%02x%02x%02x%02x%02x\n",
 				       rpn[0], rpn[1], rpn[2],
 				       rpn[3], rpn[4], rpn[5]);
@@ -186,7 +185,7 @@ static ssize_t key_rx_spec_read(struct file *file, char __user *userbuf,
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
 		rpn = key->u.aes_cmac.rx_pn;
-		p += scnprintf(p, sizeof(buf)+buf-p,
+		p += sysfs_emit(p,
 			       "%02x%02x%02x%02x%02x%02x\n",
 			       rpn[0], rpn[1], rpn[2],
 			       rpn[3], rpn[4], rpn[5]);
@@ -195,7 +194,7 @@ static ssize_t key_rx_spec_read(struct file *file, char __user *userbuf,
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 		rpn = key->u.aes_gmac.rx_pn;
-		p += scnprintf(p, sizeof(buf)+buf-p,
+		p += sysfs_emit(p,
 			       "%02x%02x%02x%02x%02x%02x\n",
 			       rpn[0], rpn[1], rpn[2],
 			       rpn[3], rpn[4], rpn[5]);
@@ -205,7 +204,7 @@ static ssize_t key_rx_spec_read(struct file *file, char __user *userbuf,
 	case WLAN_CIPHER_SUITE_GCMP_256:
 		for (i = 0; i < IEEE80211_NUM_TIDS + 1; i++) {
 			rpn = key->u.gcmp.rx_pn[i];
-			p += scnprintf(p, sizeof(buf)+buf-p,
+			p += sysfs_emit(p,
 				       "%02x%02x%02x%02x%02x%02x\n",
 				       rpn[0], rpn[1], rpn[2],
 				       rpn[3], rpn[4], rpn[5]);
@@ -229,21 +228,21 @@ static ssize_t key_replays_read(struct file *file, char __user *userbuf,
 	switch (key->conf.cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
-		len = scnprintf(buf, sizeof(buf), "%u\n", key->u.ccmp.replays);
+		len = sysfs_emit(buf, "%u\n", key->u.ccmp.replays);
 		break;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-		len = scnprintf(buf, sizeof(buf), "%u\n",
-				key->u.aes_cmac.replays);
+		len = sysfs_emit(buf, "%u\n",
+				 key->u.aes_cmac.replays);
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		len = scnprintf(buf, sizeof(buf), "%u\n",
-				key->u.aes_gmac.replays);
+		len = sysfs_emit(buf, "%u\n",
+				 key->u.aes_gmac.replays);
 		break;
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		len = scnprintf(buf, sizeof(buf), "%u\n", key->u.gcmp.replays);
+		len = sysfs_emit(buf, "%u\n", key->u.gcmp.replays);
 		break;
 	default:
 		return 0;
@@ -262,13 +261,13 @@ static ssize_t key_icverrors_read(struct file *file, char __user *userbuf,
 	switch (key->conf.cipher) {
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-		len = scnprintf(buf, sizeof(buf), "%u\n",
-				key->u.aes_cmac.icverrors);
+		len = sysfs_emit(buf, "%u\n",
+				 key->u.aes_cmac.icverrors);
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		len = scnprintf(buf, sizeof(buf), "%u\n",
-				key->u.aes_gmac.icverrors);
+		len = sysfs_emit(buf, "%u\n",
+				 key->u.aes_gmac.icverrors);
 		break;
 	default:
 		return 0;
@@ -287,7 +286,7 @@ static ssize_t key_mic_failures_read(struct file *file, char __user *userbuf,
 	if (key->conf.cipher != WLAN_CIPHER_SUITE_TKIP)
 		return -EINVAL;
 
-	len = scnprintf(buf, sizeof(buf), "%u\n", key->u.tkip.mic_failures);
+	len = sysfs_emit(buf, "%u\n", key->u.tkip.mic_failures);
 
 	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
 }
@@ -306,8 +305,8 @@ static ssize_t key_key_read(struct file *file, char __user *userbuf,
 		return -ENOMEM;
 
 	for (i = 0; i < key->conf.keylen; i++)
-		p += scnprintf(p, bufsize + buf - p, "%02x", key->conf.key[i]);
-	p += scnprintf(p, bufsize+buf-p, "\n");
+		p += sysfs_emit(p, "%02x", key->conf.key[i]);
+	p += sysfs_emit(p, "\n");
 	res = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
 	kfree(buf);
 	return res;
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 54c479910d05..68000e9cb7ca 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -171,7 +171,7 @@ static ssize_t ieee80211_if_fmt_##name(					\
 	const type *data, char *buf,					\
 	int buflen)							\
 {									\
-	return scnprintf(buf, buflen, format_string, data->field);	\
+	return sysfs_emit(buf, format_string, data->field);		\
 }
 #define IEEE80211_IF_FMT_DEC(name, type, field)				\
 		IEEE80211_IF_FMT(name, type, field, "%d\n")
@@ -188,10 +188,9 @@ static ssize_t ieee80211_if_fmt_##name(					\
 	char *p = buf;							\
 	int i;								\
 	for (i = 0; i < sizeof(data->field); i++) {			\
-		p += scnprintf(p, buflen + buf - p, "%.2x ",		\
-				 data->field[i]);			\
+		p += sysfs_emit(p, "%.2x ", data->field[i]);		\
 	}								\
-	p += scnprintf(p, buflen + buf - p, "\n");			\
+	p += sysfs_emit(p, "\n");					\
 	return p - buf;							\
 }
 
@@ -200,7 +199,7 @@ static ssize_t ieee80211_if_fmt_##name(					\
 	const type *data,						\
 	char *buf, int buflen)						\
 {									\
-	return scnprintf(buf, buflen, "%d\n", atomic_read(&data->field));\
+	return sysfs_emit(buf, "%d\n", atomic_read(&data->field));\
 }
 
 #define IEEE80211_IF_FMT_MAC(name, type, field)				\
@@ -208,7 +207,7 @@ static ssize_t ieee80211_if_fmt_##name(					\
 	const type *data, char *buf,					\
 	int buflen)							\
 {									\
-	return scnprintf(buf, buflen, "%pM\n", data->field);		\
+	return sysfs_emit(buf, "%pM\n", data->field);			\
 }
 
 #define IEEE80211_IF_FMT_JIFFIES_TO_MS(name, type, field)		\
@@ -216,7 +215,7 @@ static ssize_t ieee80211_if_fmt_##name(					\
 	const type *data,						\
 	char *buf, int buflen)						\
 {									\
-	return scnprintf(buf, buflen, "%d\n",				\
+	return sysfs_emit(buf, "%d\n",					\
 			 jiffies_to_msecs(data->field));		\
 }
 
@@ -320,9 +319,10 @@ static ssize_t ieee80211_if_fmt_rc_rateidx_vht_mcs_mask_2ghz(
 	int i, len = 0;
 	const u16 *mask = sdata->rc_rateidx_vht_mcs_mask[NL80211_BAND_2GHZ];
 
-	for (i = 0; i < NL80211_VHT_NSS_MAX; i++)
-		len += scnprintf(buf + len, buflen - len, "%04x ", mask[i]);
-	len += scnprintf(buf + len, buflen - len, "\n");
+	len = sysfs_emit(buf, "%04x ", mask[0]);
+	for (i = 1; i < NL80211_VHT_NSS_MAX; i++)
+		len += sysfs_emit_at(buf, len, "%04x ", mask[i]);
+	len += sysfs_emit_at(buf, len, "\n");
 
 	return len;
 }
@@ -336,9 +336,10 @@ static ssize_t ieee80211_if_fmt_rc_rateidx_vht_mcs_mask_5ghz(
 	int i, len = 0;
 	const u16 *mask = sdata->rc_rateidx_vht_mcs_mask[NL80211_BAND_5GHZ];
 
-	for (i = 0; i < NL80211_VHT_NSS_MAX; i++)
-		len += scnprintf(buf + len, buflen - len, "%04x ", mask[i]);
-	len += scnprintf(buf + len, buflen - len, "\n");
+	len = sysfs_emit(buf, "%04x ", mask[0]);
+	for (i = 1; i < NL80211_VHT_NSS_MAX; i++)
+		len += sysfs_emit_at(buf, len, "%04x ", mask[i]);
+	len += sysfs_emit_at(buf, len, "\n");
 
 	return len;
 }
@@ -357,14 +358,14 @@ ieee80211_if_fmt_hw_queues(const struct ieee80211_sub_if_data *sdata,
 {
 	int len;
 
-	len = scnprintf(buf, buflen, "AC queues: VO:%d VI:%d BE:%d BK:%d\n",
-			sdata->vif.hw_queue[IEEE80211_AC_VO],
-			sdata->vif.hw_queue[IEEE80211_AC_VI],
-			sdata->vif.hw_queue[IEEE80211_AC_BE],
-			sdata->vif.hw_queue[IEEE80211_AC_BK]);
+	len = sysfs_emit(buf, "AC queues: VO:%d VI:%d BE:%d BK:%d\n",
+			 sdata->vif.hw_queue[IEEE80211_AC_VO],
+			 sdata->vif.hw_queue[IEEE80211_AC_VI],
+			 sdata->vif.hw_queue[IEEE80211_AC_BE],
+			 sdata->vif.hw_queue[IEEE80211_AC_BK]);
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
-		len += scnprintf(buf + len, buflen - len, "cab queue: %d\n",
+		len += sysfs_emit_at(buf, len, "cab queue: %d\n",
 				 sdata->vif.cab_queue);
 
 	return len;
@@ -607,7 +608,7 @@ IEEE80211_IF_FILE(num_mcast_sta_vlan, u.vlan.num_mcast_sta, ATOMIC);
 static ssize_t ieee80211_if_fmt_num_buffered_multicast(
 	const struct ieee80211_sub_if_data *sdata, char *buf, int buflen)
 {
-	return scnprintf(buf, buflen, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			 skb_queue_len(&sdata->u.ap.ps.bc_buf));
 }
 IEEE80211_IF_FILE_R(num_buffered_multicast);
@@ -627,20 +628,19 @@ static ssize_t ieee80211_if_fmt_aqm(
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
 
-	len = scnprintf(buf,
-			buflen,
-			"ac backlog-bytes backlog-packets new-flows drops marks overlimit collisions tx-bytes tx-packets\n"
-			"%u %u %u %u %u %u %u %u %u %u\n",
-			txqi->txq.ac,
-			txqi->tin.backlog_bytes,
-			txqi->tin.backlog_packets,
-			txqi->tin.flows,
-			txqi->cstats.drop_count,
-			txqi->cstats.ecn_mark,
-			txqi->tin.overlimit,
-			txqi->tin.collisions,
-			txqi->tin.tx_bytes,
-			txqi->tin.tx_packets);
+	len = sysfs_emit(buf,
+			 "ac backlog-bytes backlog-packets new-flows drops marks overlimit collisions tx-bytes tx-packets\n"
+			 "%u %u %u %u %u %u %u %u %u %u\n",
+			 txqi->txq.ac,
+			 txqi->tin.backlog_bytes,
+			 txqi->tin.backlog_packets,
+			 txqi->tin.flows,
+			 txqi->cstats.drop_count,
+			 txqi->cstats.ecn_mark,
+			 txqi->tin.overlimit,
+			 txqi->tin.collisions,
+			 txqi->tin.tx_bytes,
+			 txqi->tin.tx_packets);
 
 	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
@@ -660,7 +660,7 @@ static ssize_t ieee80211_if_fmt_tsf(
 
 	tsf = drv_get_tsf(local, (struct ieee80211_sub_if_data *)sdata);
 
-	return scnprintf(buf, buflen, "0x%016llx\n", (unsigned long long) tsf);
+	return sysfs_emit(buf, "0x%016llx\n", (unsigned long long)tsf);
 }
 
 static ssize_t ieee80211_if_parse_tsf(
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 49061bd4151b..31a795314636 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -85,7 +85,6 @@ static ssize_t sta_flags_read(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
 {
 	char buf[16 * NUM_WLAN_STA_FLAGS], *pos = buf;
-	char *end = buf + sizeof(buf) - 1;
 	struct sta_info *sta = file->private_data;
 	unsigned int flg;
 
@@ -93,7 +92,7 @@ static ssize_t sta_flags_read(struct file *file, char __user *userbuf,
 
 	for (flg = 0; flg < NUM_WLAN_STA_FLAGS; flg++) {
 		if (test_sta_flag(sta, flg))
-			pos += scnprintf(pos, end - pos, "%s\n",
+			pos += sysfs_emit(pos, "%s\n",
 					 sta_flag_names[flg]);
 	}
 
@@ -110,7 +109,7 @@ static ssize_t sta_num_ps_buf_frames_read(struct file *file,
 	int ac;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-		p += scnprintf(p, sizeof(buf)+buf-p, "AC%d: %d\n", ac,
+		p += sysfs_emit(p, "AC%d: %d\n", ac,
 			       skb_queue_len(&sta->ps_tx_buf[ac]) +
 			       skb_queue_len(&sta->tx_filtered[ac]));
 	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
@@ -124,9 +123,9 @@ static ssize_t sta_last_seq_ctrl_read(struct file *file, char __user *userbuf,
 	int i;
 	struct sta_info *sta = file->private_data;
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++)
-		p += scnprintf(p, sizeof(buf)+buf-p, "%x ",
+		p += sysfs_emit(p, "%x ",
 			       le16_to_cpu(sta->last_seq_ctrl[i]));
-	p += scnprintf(p, sizeof(buf)+buf-p, "\n");
+	p += sysfs_emit(p, "\n");
 	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
 }
 STA_OPS(last_seq_ctrl);
@@ -139,7 +138,8 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 	struct sta_info *sta = file->private_data;
 	struct ieee80211_local *local = sta->local;
 	size_t bufsz = AQM_TXQ_ENTRY_LEN * (IEEE80211_NUM_TIDS + 2);
-	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
+	char *buf = kzalloc(bufsz, GFP_KERNEL);
+	int len;
 	struct txq_info *txqi;
 	ssize_t rv;
 	int i;
@@ -150,15 +150,14 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
 
-	p += scnprintf(p,
-		       bufsz + buf - p,
-		       "tid ac backlog-bytes backlog-packets new-flows drops marks overlimit collisions tx-bytes tx-packets flags\n");
+	len = sysfs_emit(buf,
+			 "tid ac backlog-bytes backlog-packets new-flows drops marks overlimit collisions tx-bytes tx-packets flags\n");
 
 	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
 		if (!sta->sta.txq[i])
 			continue;
 		txqi = to_txq_info(sta->sta.txq[i]);
-		p += scnprintf(p, bufsz + buf - p,
+		len += sysfs_emit_at(buf, len,
 			       "%d %d %u %u %u %u %u %u %u %u %u 0x%lx(%s%s%s%s)\n",
 			       txqi->txq.tid,
 			       txqi->txq.ac,
@@ -181,7 +180,7 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
-	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	rv = simple_read_from_buffer(userbuf, count, ppos, buf, len);
 	kfree(buf);
 	return rv;
 }
@@ -193,7 +192,8 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 	struct sta_info *sta = file->private_data;
 	struct ieee80211_local *local = sta->sdata->local;
 	size_t bufsz = 400;
-	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
+	char *buf = kzalloc(bufsz, GFP_KERNEL);
+	int len;
 	u64 rx_airtime = 0, tx_airtime = 0;
 	s32 deficit[IEEE80211_NUM_ACS];
 	ssize_t rv;
@@ -210,13 +210,13 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 		spin_unlock_bh(&local->active_txq_lock[ac]);
 	}
 
-	p += scnprintf(p, bufsz + buf - p,
-		"RX: %llu us\nTX: %llu us\nWeight: %u\n"
-		"Deficit: VO: %d us VI: %d us BE: %d us BK: %d us\n",
-		rx_airtime, tx_airtime, sta->airtime_weight,
-		deficit[0], deficit[1], deficit[2], deficit[3]);
+	len = sysfs_emit(buf,
+			 "RX: %llu us\nTX: %llu us\nWeight: %u\n"
+			 "Deficit: VO: %d us VI: %d us BE: %d us BK: %d us\n",
+			 rx_airtime, tx_airtime, sta->airtime_weight,
+			 deficit[0], deficit[1], deficit[2], deficit[3]);
 
-	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	rv = simple_read_from_buffer(userbuf, count, ppos, buf, len);
 	kfree(buf);
 	return rv;
 }
@@ -246,7 +246,8 @@ static ssize_t sta_aql_read(struct file *file, char __user *userbuf,
 	struct sta_info *sta = file->private_data;
 	struct ieee80211_local *local = sta->sdata->local;
 	size_t bufsz = 400;
-	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
+	char *buf = kzalloc(bufsz, GFP_KERNEL);
+	int len;
 	u32 q_depth[IEEE80211_NUM_ACS];
 	u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
 	ssize_t rv;
@@ -263,14 +264,14 @@ static ssize_t sta_aql_read(struct file *file, char __user *userbuf,
 		q_depth[ac] = atomic_read(&sta->airtime[ac].aql_tx_pending);
 	}
 
-	p += scnprintf(p, bufsz + buf - p,
-		"Q depth: VO: %u us VI: %u us BE: %u us BK: %u us\n"
-		"Q limit[low/high]: VO: %u/%u VI: %u/%u BE: %u/%u BK: %u/%u\n",
-		q_depth[0], q_depth[1], q_depth[2], q_depth[3],
-		q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
-		q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]);
+	len = sysfs_emit(buf,
+			 "Q depth: VO: %u us VI: %u us BE: %u us BK: %u us\n"
+			 "Q limit[low/high]: VO: %u/%u VI: %u/%u BE: %u/%u BK: %u/%u\n",
+			 q_depth[0], q_depth[1], q_depth[2], q_depth[3],
+			 q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
+			 q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]);
 
-	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	rv = simple_read_from_buffer(userbuf, count, ppos, buf, len);
 	kfree(buf);
 	return rv;
 }
@@ -308,14 +309,14 @@ static ssize_t sta_agg_status_do_read(struct wiphy *wiphy, struct file *file,
 				      char *buf, size_t bufsz, void *data)
 {
 	struct sta_info *sta = data;
-	char *p = buf;
+	int len;
 	int i;
 	struct tid_ampdu_rx *tid_rx;
 	struct tid_ampdu_tx *tid_tx;
 
-	p += scnprintf(p, bufsz + buf - p, "next dialog_token: %#02x\n",
-			sta->ampdu_mlme.dialog_token_allocator + 1);
-	p += scnprintf(p, bufsz + buf - p,
+	len = sysfs_emit(buf, "next dialog_token: %#02x\n",
+			 sta->ampdu_mlme.dialog_token_allocator + 1);
+	len += sysfs_emit_at(buf, len,
 		       "TID\t\tRX\tDTKN\tSSN\t\tTX\tDTKN\tpending\n");
 
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
@@ -325,24 +326,24 @@ static ssize_t sta_agg_status_do_read(struct wiphy *wiphy, struct file *file,
 		tid_tx = wiphy_dereference(wiphy, sta->ampdu_mlme.tid_tx[i]);
 		tid_rx_valid = test_bit(i, sta->ampdu_mlme.agg_session_valid);
 
-		p += scnprintf(p, bufsz + buf - p, "%02d", i);
-		p += scnprintf(p, bufsz + buf - p, "\t\t%x",
+		len += sysfs_emit_at(buf, len, "%02d", i);
+		len += sysfs_emit_at(buf, len, "\t\t%x",
 			       tid_rx_valid);
-		p += scnprintf(p, bufsz + buf - p, "\t%#.2x",
+		len += sysfs_emit_at(buf, len, "\t%#.2x",
 			       tid_rx_valid ?
 					sta->ampdu_mlme.tid_rx_token[i] : 0);
-		p += scnprintf(p, bufsz + buf - p, "\t%#.3x",
+		len += sysfs_emit_at(buf, len, "\t%#.3x",
 				tid_rx ? tid_rx->ssn : 0);
 
-		p += scnprintf(p, bufsz + buf - p, "\t\t%x", !!tid_tx);
-		p += scnprintf(p, bufsz + buf - p, "\t%#.2x",
+		len += sysfs_emit_at(buf, len, "\t\t%x", !!tid_tx);
+		len += sysfs_emit_at(buf, len, "\t%#.2x",
 				tid_tx ? tid_tx->dialog_token : 0);
-		p += scnprintf(p, bufsz + buf - p, "\t%03d",
+		len += sysfs_emit_at(buf, len, "\t%03d",
 				tid_tx ? skb_queue_len(&tid_tx->pending) : 0);
-		p += scnprintf(p, bufsz + buf - p, "\n");
+		len += sysfs_emit_at(buf, len, "\n");
 	}
 
-	return p - buf;
+	return len;
 }
 
 static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
@@ -467,10 +468,11 @@ static ssize_t link_sta_ht_capa_read(struct file *file, char __user *userbuf,
 #define PRINT_HT_CAP(_cond, _str) \
 	do { \
 	if (_cond) \
-			p += scnprintf(p, bufsz + buf - p, "\t" _str "\n"); \
+		len += sysfs_emit_at(buf, len, "\t" _str "\n"); \
 	} while (0)
-	char *buf, *p;
+	char *buf;
 	int i;
+	int len;
 	ssize_t bufsz = 512;
 	struct link_sta_info *link_sta = file->private_data;
 	struct ieee80211_sta_ht_cap *htc = &link_sta->pub->ht_cap;
@@ -479,12 +481,11 @@ static ssize_t link_sta_ht_capa_read(struct file *file, char __user *userbuf,
 	buf = kzalloc(bufsz, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	p = buf;
 
-	p += scnprintf(p, bufsz + buf - p, "ht %ssupported\n",
-			htc->ht_supported ? "" : "not ");
+	len = sysfs_emit(buf, "ht %ssupported\n",
+			 htc->ht_supported ? "" : "not ");
 	if (htc->ht_supported) {
-		p += scnprintf(p, bufsz + buf - p, "cap: %#.4x\n", htc->cap);
+		len += sysfs_emit_at(buf, len, "cap: %#.4x\n", htc->cap);
 
 		PRINT_HT_CAP((htc->cap & BIT(0)), "RX LDPC");
 		PRINT_HT_CAP((htc->cap & BIT(1)), "HT20/HT40");
@@ -526,27 +527,27 @@ static ssize_t link_sta_ht_capa_read(struct file *file, char __user *userbuf,
 
 		PRINT_HT_CAP((htc->cap & BIT(15)), "L-SIG TXOP protection");
 
-		p += scnprintf(p, bufsz + buf - p, "ampdu factor/density: %d/%d\n",
+		len += sysfs_emit_at(buf, len, "ampdu factor/density: %d/%d\n",
 				htc->ampdu_factor, htc->ampdu_density);
-		p += scnprintf(p, bufsz + buf - p, "MCS mask:");
+		len += sysfs_emit_at(buf, len, "MCS mask:");
 
 		for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
-			p += scnprintf(p, bufsz + buf - p, " %.2x",
+			len += sysfs_emit_at(buf, len, " %.2x",
 					htc->mcs.rx_mask[i]);
-		p += scnprintf(p, bufsz + buf - p, "\n");
+		len += sysfs_emit_at(buf, len, "\n");
 
 		/* If not set this is meaningless */
 		if (le16_to_cpu(htc->mcs.rx_highest)) {
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "MCS rx highest: %d Mbps\n",
 				       le16_to_cpu(htc->mcs.rx_highest));
 		}
 
-		p += scnprintf(p, bufsz + buf - p, "MCS tx params: %x\n",
+		len += sysfs_emit_at(buf, len, "MCS tx params: %x\n",
 				htc->mcs.tx_params);
 	}
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_read_from_buffer(userbuf, count, ppos, buf, len);
 	kfree(buf);
 	return ret;
 }
@@ -555,61 +556,61 @@ LINK_STA_OPS(ht_capa);
 static ssize_t link_sta_vht_capa_read(struct file *file, char __user *userbuf,
 				      size_t count, loff_t *ppos)
 {
-	char *buf, *p;
+	char *buf;
 	struct link_sta_info *link_sta = file->private_data;
 	struct ieee80211_sta_vht_cap *vhtc = &link_sta->pub->vht_cap;
 	ssize_t ret;
 	ssize_t bufsz = 512;
+	int len;
 
 	buf = kzalloc(bufsz, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	p = buf;
 
-	p += scnprintf(p, bufsz + buf - p, "VHT %ssupported\n",
-			vhtc->vht_supported ? "" : "not ");
+	len = sysfs_emit(buf, "VHT %ssupported\n",
+			 vhtc->vht_supported ? "" : "not ");
 	if (vhtc->vht_supported) {
-		p += scnprintf(p, bufsz + buf - p, "cap: %#.8x\n",
+		len += sysfs_emit_at(buf, len, "cap: %#.8x\n",
 			       vhtc->cap);
 #define PFLAG(a, b)							\
 		do {							\
 			if (vhtc->cap & IEEE80211_VHT_CAP_ ## a)	\
-				p += scnprintf(p, bufsz + buf - p, \
+				len += sysfs_emit_at(buf, len,		\
 					       "\t\t%s\n", b);		\
 		} while (0)
 
 		switch (vhtc->cap & 0x3) {
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895:
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "\t\tMAX-MPDU-3895\n");
 			break;
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991:
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "\t\tMAX-MPDU-7991\n");
 			break;
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "\t\tMAX-MPDU-11454\n");
 			break;
 		default:
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "\t\tMAX-MPDU-UNKNOWN\n");
 		}
 		switch (vhtc->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
 		case 0:
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "\t\t80Mhz\n");
 			break;
 		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "\t\t160Mhz\n");
 			break;
 		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ:
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "\t\t80+80Mhz\n");
 			break;
 		default:
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "\t\tUNKNOWN-MHZ: 0x%x\n",
 				       (vhtc->cap >> 2) & 0x3);
 		}
@@ -617,15 +618,15 @@ static ssize_t link_sta_vht_capa_read(struct file *file, char __user *userbuf,
 		PFLAG(SHORT_GI_80, "SHORT-GI-80");
 		PFLAG(SHORT_GI_160, "SHORT-GI-160");
 		PFLAG(TXSTBC, "TXSTBC");
-		p += scnprintf(p, bufsz + buf - p,
+		len += sysfs_emit_at(buf, len,
 			       "\t\tRXSTBC_%d\n", (vhtc->cap >> 8) & 0x7);
 		PFLAG(SU_BEAMFORMER_CAPABLE, "SU-BEAMFORMER-CAPABLE");
 		PFLAG(SU_BEAMFORMEE_CAPABLE, "SU-BEAMFORMEE-CAPABLE");
-		p += scnprintf(p, bufsz + buf - p,
+		len += sysfs_emit_at(buf, len,
 			"\t\tBEAMFORMEE-STS: 0x%x\n",
 			(vhtc->cap & IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK) >>
 			IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
-		p += scnprintf(p, bufsz + buf - p,
+		len += sysfs_emit_at(buf, len,
 			"\t\tSOUNDING-DIMENSIONS: 0x%x\n",
 			(vhtc->cap & IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK)
 			>> IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT);
@@ -633,34 +634,34 @@ static ssize_t link_sta_vht_capa_read(struct file *file, char __user *userbuf,
 		PFLAG(MU_BEAMFORMEE_CAPABLE, "MU-BEAMFORMEE-CAPABLE");
 		PFLAG(VHT_TXOP_PS, "TXOP-PS");
 		PFLAG(HTC_VHT, "HTC-VHT");
-		p += scnprintf(p, bufsz + buf - p,
+		len += sysfs_emit_at(buf, len,
 			"\t\tMPDU-LENGTH-EXPONENT: 0x%x\n",
 			(vhtc->cap & IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK) >>
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT);
 		PFLAG(VHT_LINK_ADAPTATION_VHT_UNSOL_MFB,
 		      "LINK-ADAPTATION-VHT-UNSOL-MFB");
-		p += scnprintf(p, bufsz + buf - p,
+		len += sysfs_emit_at(buf, len,
 			"\t\tLINK-ADAPTATION-VHT-MRQ-MFB: 0x%x\n",
 			(vhtc->cap & IEEE80211_VHT_CAP_VHT_LINK_ADAPTATION_VHT_MRQ_MFB) >> 26);
 		PFLAG(RX_ANTENNA_PATTERN, "RX-ANTENNA-PATTERN");
 		PFLAG(TX_ANTENNA_PATTERN, "TX-ANTENNA-PATTERN");
 
-		p += scnprintf(p, bufsz + buf - p, "RX MCS: %.4x\n",
+		len += sysfs_emit_at(buf, len, "RX MCS: %.4x\n",
 			       le16_to_cpu(vhtc->vht_mcs.rx_mcs_map));
 		if (vhtc->vht_mcs.rx_highest)
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "MCS RX highest: %d Mbps\n",
 				       le16_to_cpu(vhtc->vht_mcs.rx_highest));
-		p += scnprintf(p, bufsz + buf - p, "TX MCS: %.4x\n",
+		len += sysfs_emit_at(buf, len, "TX MCS: %.4x\n",
 			       le16_to_cpu(vhtc->vht_mcs.tx_mcs_map));
 		if (vhtc->vht_mcs.tx_highest)
-			p += scnprintf(p, bufsz + buf - p,
+			len += sysfs_emit_at(buf, len,
 				       "MCS TX highest: %d Mbps\n",
 				       le16_to_cpu(vhtc->vht_mcs.tx_highest));
 #undef PFLAG
 	}
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_read_from_buffer(userbuf, count, ppos, buf, len);
 	kfree(buf);
 	return ret;
 }
@@ -669,7 +670,7 @@ LINK_STA_OPS(vht_capa);
 static ssize_t link_sta_he_capa_read(struct file *file, char __user *userbuf,
 				     size_t count, loff_t *ppos)
 {
-	char *buf, *p;
+	char *buf;
 	size_t buf_sz = PAGE_SIZE;
 	struct link_sta_info *link_sta = file->private_data;
 	struct ieee80211_sta_he_cap *hec = &link_sta->pub->he_cap;
@@ -677,25 +678,25 @@ static ssize_t link_sta_he_capa_read(struct file *file, char __user *userbuf,
 	u8 ppe_size;
 	u8 *cap;
 	int i;
+	int len;
 	ssize_t ret;
 
 	buf = kmalloc(buf_sz, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	p = buf;
 
-	p += scnprintf(p, buf_sz + buf - p, "HE %ssupported\n",
-		       hec->has_he ? "" : "not ");
+	len = sysfs_emit(buf, "HE %ssupported\n",
+			 hec->has_he ? "" : "not ");
 	if (!hec->has_he)
 		goto out;
 
 	cap = hec->he_cap_elem.mac_cap_info;
-	p += scnprintf(p, buf_sz + buf - p,
+	len += sysfs_emit_at(buf, len,
 		       "MAC-CAP: %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x\n",
 		       cap[0], cap[1], cap[2], cap[3], cap[4], cap[5]);
 
 #define PRINT(fmt, ...)							\
-	p += scnprintf(p, buf_sz + buf - p, "\t\t" fmt "\n",		\
+	len += sysfs_emit_at(buf, len, "\t\t" fmt "\n",		\
 		       ##__VA_ARGS__)
 
 #define PFLAG(t, n, a, b)						\
@@ -801,7 +802,7 @@ static ssize_t link_sta_he_capa_read(struct file *file, char __user *userbuf,
 	PFLAG(MAC, 5, HT_VHT_TRIG_FRAME_RX, "HT-VHT-TRIG-FRAME-RX");
 
 	cap = hec->he_cap_elem.phy_cap_info;
-	p += scnprintf(p, buf_sz + buf - p,
+	len += sysfs_emit_at(buf, len,
 		       "PHY CAP: %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x\n",
 		       cap[0], cap[1], cap[2], cap[3], cap[4], cap[5], cap[6],
 		       cap[7], cap[8], cap[9], cap[10]);
@@ -983,7 +984,7 @@ static ssize_t link_sta_he_capa_read(struct file *file, char __user *userbuf,
 	do {								\
 		int _i;							\
 		u16 v = le16_to_cpu(nss->f);				\
-		p += scnprintf(p, buf_sz + buf - p, n ": %#.4x\n", v);	\
+		len += sysfs_emit_at(buf, len, n ": %#.4x\n", v);	\
 		for (_i = 0; _i < 8; _i += 2) {				\
 			switch ((v >> _i) & 0x3) {			\
 			case 0:						\
@@ -1022,18 +1023,18 @@ static ssize_t link_sta_he_capa_read(struct file *file, char __user *userbuf,
 	if (!(cap[6] & IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT))
 		goto out;
 
-	p += scnprintf(p, buf_sz + buf - p, "PPE-THRESHOLDS: %#.2x",
-		       hec->ppe_thres[0]);
+	len += sysfs_emit_at(buf, len, "PPE-THRESHOLDS: %#.2x",
+			     hec->ppe_thres[0]);
 
 	ppe_size = ieee80211_he_ppe_size(hec->ppe_thres[0], cap);
 	for (i = 1; i < ppe_size; i++) {
-		p += scnprintf(p, buf_sz + buf - p, " %#.2x",
+		len += sysfs_emit_at(buf, len, " %#.2x",
 			       hec->ppe_thres[i]);
 	}
-	p += scnprintf(p, buf_sz + buf - p, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 
 out:
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_read_from_buffer(userbuf, count, ppos, buf, len);
 	kfree(buf);
 	return ret;
 }
@@ -1042,7 +1043,7 @@ LINK_STA_OPS(he_capa);
 static ssize_t link_sta_eht_capa_read(struct file *file, char __user *userbuf,
 				      size_t count, loff_t *ppos)
 {
-	char *buf, *p;
+	char *buf;
 	size_t buf_sz = PAGE_SIZE;
 	struct link_sta_info *link_sta = file->private_data;
 	struct ieee80211_sta_eht_cap *bec = &link_sta->pub->eht_cap;
@@ -1051,22 +1052,22 @@ static ssize_t link_sta_eht_capa_read(struct file *file, char __user *userbuf,
 	u8 *cap;
 	int i;
 	ssize_t ret;
+	int len;
 	static const char *mcs_desc[] = { "0-7", "8-9", "10-11", "12-13"};
 
 	buf = kmalloc(buf_sz, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	p = buf;
 
-	p += scnprintf(p, buf_sz + buf - p, "EHT %ssupported\n",
-		       bec->has_eht ? "" : "not ");
+	len = sysfs_emit(buf, "EHT %ssupported\n",
+			 bec->has_eht ? "" : "not ");
 	if (!bec->has_eht)
 		goto out;
 
-	p += scnprintf(p, buf_sz + buf - p,
+	len += sysfs_emit_at(buf, len,
 		       "MAC-CAP: %#.2x %#.2x\n",
 		       fixed->mac_cap_info[0], fixed->mac_cap_info[1]);
-	p += scnprintf(p, buf_sz + buf - p,
+	len += sysfs_emit_at(buf, len,
 		       "PHY-CAP: %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x\n",
 		       fixed->phy_cap_info[0], fixed->phy_cap_info[1],
 		       fixed->phy_cap_info[2], fixed->phy_cap_info[3],
@@ -1075,7 +1076,7 @@ static ssize_t link_sta_eht_capa_read(struct file *file, char __user *userbuf,
 		       fixed->phy_cap_info[8]);
 
 #define PRINT(fmt, ...)							\
-	p += scnprintf(p, buf_sz + buf - p, "\t\t" fmt "\n",		\
+	len += sysfs_emit_at(buf, len, "\t\t" fmt "\n",		\
 		       ##__VA_ARGS__)
 
 #define PFLAG(t, n, a, b)						\
@@ -1209,15 +1210,15 @@ static ssize_t link_sta_eht_capa_read(struct file *file, char __user *userbuf,
 	if (cap[5] & IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) {
 		u8 ppe_size = ieee80211_eht_ppe_size(bec->eht_ppe_thres[0], cap);
 
-		p += scnprintf(p, buf_sz + buf - p, "EHT PPE Thresholds: ");
+		len += sysfs_emit_at(buf, len, "EHT PPE Thresholds: ");
 		for (i = 0; i < ppe_size; i++)
-			p += scnprintf(p, buf_sz + buf - p, "0x%02x ",
+			len += sysfs_emit_at(buf, len, "0x%02x ",
 				       bec->eht_ppe_thres[i]);
 		PRINT(""); /* newline */
 	}
 
 out:
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_read_from_buffer(userbuf, count, ppos, buf, len);
 	kfree(buf);
 	return ret;
 }
-- 
2.43.0


