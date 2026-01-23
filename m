Return-Path: <linux-wireless+bounces-31119-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDieKXCbc2nNxQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31119-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 17:01:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11594781FF
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFEE0307842C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6960B1DD877;
	Fri, 23 Jan 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chy08Ofc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5F2FFF89
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183882; cv=none; b=Z2oxAsK3tlScyT8UN/E1onJcpBo5M+C3NI5QO8HcSoGkgfHmr+j4ZKwJ7FHWlce7RD/dZbLsBYXUF30/lAoPVf+YFUtlybhKWBgh4SURgw2FZ3vbwpgQgn2p4hY/cHXYGr1CEYnFApmzcea1R4CckDYJHlvcxzyNf6Dc2oWVEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183882; c=relaxed/simple;
	bh=Vxf3lWhNASCANDY5Q0y52cErLUJBZ2xKPJtIi+JJMqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tiz9dMBzCnVINMm2OvN+FP/l3X/XsupCsOL5K41INCLA4+m5tbqcgX/MpEjqy6WKifW6R01+FOMPO0k0dLpBKnjMicJz8k7Ys9Wne10+M0vYN4Z3JGZQ4shEurWTJPnYb7T7eumyOa4OLW1FFfocsAyRjziUEs91C+3e7Y2W5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Chy08Ofc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8231061d234so1758643b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769183880; x=1769788680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2XUvQ9fPlmnJTRW1nC83FwDh2lFtjD96GKLl3MPPGM=;
        b=Chy08OfcjLWwJH2YsVi7oP9aeFoF/sGGrCkCgWR/YGvER58MJFH95ev8I+QjPUGKJu
         CkNu22cDPJ8GryKjerRWwnqJAUMWA5QlGv3+UZEL4bAVPkvhuPhBj1W74z3e7ohr0Y+e
         MAu7vem5QJaYC+lBCq4yZ5xQxJZB0I1xBdcySk1ueeUfVZPiaFC8Zja8y5fpk5ErvDEy
         GtFe5NnPMEXKieHtAYWI4LaOf0hfQ8nf6jn4rUJ95yRvyJeXQUInsJ0hlC+ExAhBKiN5
         AR6l1hJgoPa8Dv0J+reeiFq0wjC1Y8uoJFdrqTcwkp7ir7XHPTzN14D4lwaYHvz203DC
         wlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769183880; x=1769788680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2XUvQ9fPlmnJTRW1nC83FwDh2lFtjD96GKLl3MPPGM=;
        b=exwHUtJIaJmENjncQhQoOl4mBeuHMw8UQ0n4wlzWWU6wCZvaiQYCTJzvfcqVgG7o7Q
         Vz5XyamV02oe1KM9zT/QxemxQF1E994g6szT3WYGlnAlSmuyR5Igts6mDZd7yufkTsGs
         BBTtJ+GZA7kIt2hRV6CoSX5rN9lZou/kwINkW9TjeCHQ2/92N0OM/VwYOQFYkKTyyjCq
         Wh73maqlkgt4U2yMvT5Zbth2UQ5AzTyLGoFuFiKyL+FIai6d74lI7ROHgztg7fa+6eTp
         WGEWKLi1DFj2bsutiWpxPZiQuBvJxU1U+NB8T0TNZeotmMMa2XvW0lFPu2y1cjEFKV6q
         dPiw==
X-Gm-Message-State: AOJu0YzePsel87c8psL7AyyPILR6mHqEHCa7sItypfyDVtth8JTpLxr+
	Y2LP5KgCnqqVACaRgNPdE/xIvgvWH7B9EB+6Hyd/jBeBLdm0XGqm/AR2
X-Gm-Gg: AZuq6aJYQgMR190sZ8jKC5vVJmJoNAmXovctjhAHKD6Xp4WELv56vrWEX8XZimXGimo
	40tEvazneoJRpSa3kOLfKce3JmtJ1rubF9YRNohqLyi8BiGabb2OUMeSR81qRc1TdHR/6d1Jn+q
	XnSU7mO6yJ0+yShTsSX2ukmVgvs6vT/6T3ANGtdWWahaM0+sq9y5EnR4DpG4XVcRgsjEnIHg60d
	WMgJ4dOnLcBiGYohJ34kSAI6sDh+9ksgWvy70YK8kG2SxyS4eViuSXneFPz1mcM/tLJ/ytDCB43
	TxBLoSziQm86P0hGcOraBkJoWo0YdlONR4ZBBuCDgPUR39GLD7WzlRfGcjePzG51BaM0ADUcmsa
	391DOdMJaDGrkh+eZf9/o0uIf+JPMEE0NyuqXBv8ekYyv63VSPD/tgqN8oCLNBh0Yyd7JsOgqyT
	N1G04IO9XugsKmllXyMquPVB9z1nVHXqXRS77I
X-Received: by 2002:a17:90a:e7d2:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-3536700d6d2mr2748627a91.8.1769183880193;
        Fri, 23 Jan 2026 07:58:00 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:dfb6:6b31:aa17:2446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35335206b23sm5489305a91.3.2026.01.23.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:57:59 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH] wifi: ath12k: Fix firmware stats leak on get_txpower error paths
Date: Fri, 23 Jan 2026 21:27:46 +0530
Message-ID: <20260123155750.6007-2-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123155750.6007-1-bjsaikiran@gmail.com>
References: <20260123155750.6007-1-bjsaikiran@gmail.com>
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31119-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,launchpad.net:url]
X-Rspamd-Queue-Id: 11594781FF
X-Rspamd-Action: no action

The commits bd6ec8111e65 and 2977567b244f changed firmware stats handling
to be caller-driven, requiring explicit ath12k_fw_stats_reset() calls
after using ath12k_mac_get_fw_stats().

However, in ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats()
succeeds but the pdev stats list is empty, or when the stats request
fails, the function exits via err_fallback without resetting the stats
buffer.

This causes the stats buffer to accumulate data, eventually leading to
firmware communication failures (error -71/EPROTO) during subsequent
operations, particularly during 5GHz scanning which requires additional
TX power queries.

Symptoms:
- "failed to pull fw stats: -71" errors in dmesg  - 5GHz networks not detected despite hardware support
- 2.4GHz networks work normally

Fix this by calling ath12k_fw_stats_reset() on all error paths after
ath12k_mac_get_fw_stats() is called, ensuring the stats buffer is
always freed regardless of the execution path.

Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset caller-driven")
Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)

Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f7a2a544bef2..4195364cb6e3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5161,6 +5161,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	ret = ath12k_mac_get_fw_stats(ar, &params);
 	if (ret) {
 		ath12k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
+		ath12k_fw_stats_reset(ar);
 		goto err_fallback;
 	}
 
@@ -5169,6 +5170,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
 					struct ath12k_fw_stats_pdev, list);
 	if (!pdev) {
 		spin_unlock_bh(&ar->data_lock);
+		ath12k_fw_stats_reset(ar);
 		goto err_fallback;
 	}
 
-- 
2.51.0


