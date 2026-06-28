Return-Path: <linux-wireless+bounces-38214-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yqBCBRJqQGrQfQkAu9opvQ
	(envelope-from <linux-wireless+bounces-38214-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 02:25:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802DE6D2DF0
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 02:25:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Yy5/MvoO";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38214-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38214-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13CCF301586F
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F71531E8;
	Sun, 28 Jun 2026 00:25:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7CE49620
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 00:25:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782606347; cv=none; b=Yti4ZiSDYhUAO5uzIelw4dOhIqIufZsXd6E0cP88Jk3/sXYUnGcZDdWMETfEyu4S1AJF5k89EAN2Ggm57cQlaEYfdovu8Vph6HA9YUECbD1cXOOxsEjBRqnpBHwJWC4FJyr4jAfMqU+5qFB+vpPYYvwfMCM4M3HgnNCNgn4ct1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782606347; c=relaxed/simple;
	bh=Gp9heeZl8YOVXLS81sRHuvkbEUIKeicfYWTiUjTKSBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dzpmzr8939OPA/FrB8B1HfGI6CIgHztX/zzr+YJVr4dT/QygvDqnHLuZ3lKLVQyPmiqLyWamOZ0mP14epbFd8SjQmL3FqNs0kHqPC0QEGsHhltifnTLKLiXnQdZBzMrksdllSgZBmSaTR5WG2DbgRkgTe56g+iux5RAQAHcmh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy5/MvoO; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493a5392c60so1989295e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 17:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782606343; x=1783211143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+ggCHBmTIi4iroEDf3wYeBaqmZKkqX7ae5VYLvC2Dk=;
        b=Yy5/MvoOFUCHwQQi3KX9W+0IZlV5baCQ2HyMk8lARPWRP2fkJZsbAMDKPLnEJAb1s+
         O/JBp10mly4ZQR801vCxhpgstqA+uOys8Tz4rQQuFkuEojiNGsIYBnhnKF/JoYvP0BfM
         x9t1JlN/DeX8oXXdg2H4C6qyuJbXrfqfkWfJEEfIx2c+V6VgjWB7mmvoSziKXefekkue
         IcOFSJwJF2T1MpC7Ol8UFb3VSIwFI3ihxnE1ggSs5YB/YDDJ8n4c16ZUS+/5sv5LmBsz
         vAh8iu5MMKQVHEUDuRcjeiTmQ9yckZBbhDHYMSomD2Wq6/l/gZE0HBQjXSiwcNTtWe6m
         rNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782606343; x=1783211143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+ggCHBmTIi4iroEDf3wYeBaqmZKkqX7ae5VYLvC2Dk=;
        b=YeF5u2t4VWuX1GnVVzw0x2FPC+UNotiBNWSb6f5NcbehmuAzBFScGqb+Ztk4se09il
         wYFZbBn0UFZAF9Sh9Sj22Ig9RZUy2/wWG1RV+6WSWx8ehWFy8qAxTjpMdqeOnTL5tIio
         z1jLBO3ze3Q+U15yu2UAP3ZkLyYLDAYV9gkhS084QrCPkyLPk2r+2rNUFV/b9asbp9ZE
         AGEUopPyc0ky8PlDsOIck9UQya/sNDnmFisCvXZkb79VomEcG20CeIy7fJY6lSBc2u9B
         awZSzYs+6qi1duNXE0NERglQOptzWSvZFeagH/hL1b5xk+eN8vgEom/dn9ZhkJ/zTPFo
         eRNw==
X-Gm-Message-State: AOJu0Ywe5iIAJDan3yEBlQcTXL5GUTuqVVykrfQ1Ek553H/Xepd2DFZG
	M+FHzsOzp0ty2+kqO3ZEtTygdjm+rPZfWfVMh1kgwMY0z686R9y5Xqy7
X-Gm-Gg: AfdE7cnMK11LYh4Vf7H2+qzr/03BtzZbwTssq/korAB0RkG7HriB2FNchw1JfhtBqc8
	1F3Nla+an2OZ46Ib1TK9R2GVCyav6gPRaFTY7kQawawAjoKB5kmSUBIAhCaeGQSfwIIMDvUfrlo
	vdk5Ga3MlTPm/qUTdp3aaLR06QeLv5TMCFgoGoa5H+LeHYhN5mwTPXo7lg8LwRQGCTflUleyzUl
	28nE9u7r37OxThQNkWJiJ7AJn5SxFh9xumoYvARhy1WI68tbkuPscIDqtTAfz7W6PdyIvzb9+1Q
	1HfpYP0YISCvfQDAGdOnsC1+FbFy7zdu1Vxg9xCmASZOF30R2cshl2SWA/xMzi+bknOQHYJp0YV
	55V5i6HLrgr2r31CAnlm3ziuWTiJm7MlCE6mkyMvjEkZD7yXDpz/CpxF0OOCDvvie4r0esy/uHA
	wbJqCGc/FBr4I4W5mtg7earhxTfA==
X-Received: by 2002:a05:600c:6792:b0:492:7187:aa67 with SMTP id 5b1f17b1804b1-4927187aa7dmr68432665e9.30.1782606343532;
        Sat, 27 Jun 2026 17:25:43 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926f94f213sm145611055e9.12.2026.06.27.17.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:25:43 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	stable@vger.kernel.org,
	syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] wifi: mac80211_hwsim: avoid treating MCS as legacy rate index
Date: Sun, 28 Jun 2026 02:25:37 +0200
Message-ID: <20260628002537.23550-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38214-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:benjamin.berg@intel.com,m:stable@vger.kernel.org,m:syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,21629c14aa749636db9d];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 802DE6D2DF0

Injected HT and VHT rates store an MCS value in rates[0].idx rather
than an index into the legacy bitrate table. hwsim nevertheless passes
these rates to ieee80211_get_tx_rate() while generating monitor frames
and timestamps.

A crafted injected frame can therefore read beyond the bitrate table.
If the resulting bitrate is zero, mac80211_hwsim_write_tsf() also
divides by zero, as observed by syzbot.

Use ieee80211_get_tx_rate() only for legacy rates. The existing fallback
continues to supply a conservative bitrate where hwsim does not yet
calculate MCS rates.

Fixes: e75129031f1c ("wifi: mac80211_hwsim: move timestamp writing later in the datapath")
Reported-by: syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=21629c14aa749636db9d
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 .../net/wireless/virtual/mac80211_hwsim_main.c    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0dd8a6c85953..4a66272526f3 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1324,6 +1324,17 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 	}
 }
 
+static struct ieee80211_rate *
+mac80211_hwsim_get_tx_rate(struct ieee80211_hw *hw,
+			   struct ieee80211_tx_info *info)
+{
+	if (info->control.rates[0].flags &
+	    (IEEE80211_TX_RC_MCS | IEEE80211_TX_RC_VHT_MCS))
+		return NULL;
+
+	return ieee80211_get_tx_rate(hw, info);
+}
+
 static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
 				      struct sk_buff *tx_skb,
 				      struct ieee80211_channel *chan)
@@ -1333,7 +1344,7 @@ static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
 	struct hwsim_radiotap_hdr *hdr;
 	u16 flags, bitrate;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_skb);
-	struct ieee80211_rate *txrate = ieee80211_get_tx_rate(hw, info);
+	struct ieee80211_rate *txrate = mac80211_hwsim_get_tx_rate(hw, info);
 
 	if (!txrate)
 		bitrate = 0;
@@ -1603,7 +1614,7 @@ static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
 
 	spin_lock_bh(&data->tsf_offset_lock);
 
-	txrate = ieee80211_get_tx_rate(data->hw, info);
+	txrate = mac80211_hwsim_get_tx_rate(data->hw, info);
 	if (txrate)
 		bitrate = txrate->bitrate;
 
-- 
2.54.0


