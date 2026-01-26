Return-Path: <linux-wireless+bounces-31169-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCRyHpc6d2mMdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31169-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 10:57:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0F864D6
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 10:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60E00304C95D
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E2D26ED25;
	Mon, 26 Jan 2026 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+7vhS3z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8832D451
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421183; cv=none; b=LkpHudaRzHSusqwboKA3x/edNk33OpPubxY6nIHiduRsZlGYr5U/KcKeI6jE9yQZEdb7CexuW6IY1KEorAqyAIumUAskojZ58lKlUDKXIFDxjq4UlHQxfIHNxb/5r10JZyvKXK/QH/I+030L/kFnJ1pvrMJ6G+VWJ0izXTv0KXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421183; c=relaxed/simple;
	bh=7jkiz1XK6DQ/f6VU3Vn0fldwq0mnYzTB1tU8GaC7TTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnIrWPmVOP9FoCC/hqMcxkVpYRX+KQacWliFhHlFT1U7CQdPJSGhDvws1HW9g7/9Pl8Hk0GDeMeCIrF/3y2y+ELTWhnrmzqfr2nhi5tr7ZtYijdNSflQhVShqDmLFGhXxuQTeEjiis71FqYMK8pcDSQmrvrTE10LddHaEVn48S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+7vhS3z; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so3040754a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769421181; x=1770025981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnaMaj6mLos6uYLWyXnb0MsnII4/SswrIv2Xu8MbfD0=;
        b=F+7vhS3zujU9pPKocV+T+6Cd7tCZ/Y3N0gfVCySiX1RUZQAE64jDrSuxFmArDCuEIx
         lgjJNWW+3oa8NjP628e+17ez/asBzCb6NGH7sB0zObMltPt83+vTiK0APBjNvStwwgp6
         Pq19Yn24HL7/bwA+nWoXNalI2NIs2fI+DK+yO10ZJcCucGiQkqllKXcY/g0yHN7NammA
         V4RZWbt3hB54fZPoCnJGyn+03cW1QNIqzqvxdlBZFBPRv8mckaQYw17CnLrmN++ZZ6S2
         jTs5Bq181U8Ef+KLbOm4zy/YI/ZggWwOCW7tFx+7MopPymeh19E8bWPUjR9PhKrc/4Ib
         rlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769421181; x=1770025981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnaMaj6mLos6uYLWyXnb0MsnII4/SswrIv2Xu8MbfD0=;
        b=WQoR/znNA2gnlepZ/P7yh4mc4kaR8NVz8tu+RIsfXDaXveYhWd2OAB7jm5ykrruJ5S
         lOLf8JaGAL/9hsiR3U7ZWCGgSvSVLMvaHt/YyV7StYOqdPehJx7zrWFIRDY0zgXSEgmu
         EOM1tpIL9A3bcoOIQQLedusYdzPcXYZ1hK86WLQBs5tlOOedQmdvr+anc47k+WDG7u9R
         d6WS7lka6LfYH3OGUQvLlzt/xCG/FlIYwN//FAd6RGkn+23dth+z4zcDJKvUGOcc63vq
         LJNo/aSxvhlQFaAXwkVXH8FgOYMR+Rm9tNcemEehel9p5mTC2cro4T6NT91Xff+0zjGc
         wZpg==
X-Gm-Message-State: AOJu0YzqsJ/O8dCjvHsYt+lzd66IwajDQlo+WMw/P9QWd9TsJ8svv9ir
	GO1oq+Rz3tltnjzz+PXSr4CPIkff333KeVdpocyIq2Mrh5ztDl/9fCbg
X-Gm-Gg: AZuq6aKWFJ8+gNwUqxdrIhKo/mcFgTlqoNftaBCju2sq8IV8+XkMe2OIvfpZp+Hk/M5
	NmIJIYU5deqhTbugXUA0qplXCx9HAGjIGmqLlx+qbeZmwdUNZKN4mnC+OryZsCGSzH+CID9CJry
	8StO3oQruwyOalhkDCvRfTIWTXam+XDATOmwhy4zAKi1IvXKpcPLO9zDM2aJ86abrYt25EhpiWU
	tFYw/Ye09agcQ2fIu/IZmZMaYursNZRPkwAABk9TR7j6E1vPEiGeOVhz/YDGv7i8qdTlh2ApFiU
	cu3FgpWiZgV+dr98xWfA5ko3MKlND4dUWwZS4LWEqs5yJNHuHgzMPHVGXIqAq1c4Uqm5DvKtzhe
	IOFUhEg2ANIx0CORB+ZHhzYUSxtwQ6adHyKlOj5Y1b89/StnutRKkqUeEwOPZg6XT30nR7TzUOS
	Xw+FR7o6k9z2qgFujavSJt1EBG+MXHGIqd1zQk
X-Received: by 2002:a17:90b:2fd0:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-353c41a6f3dmr3587832a91.35.1769421181044;
        Mon, 26 Jan 2026 01:53:01 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:1d59:cd47:36b6:dec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536f359950sm3187627a91.10.2026.01.26.01.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:53:00 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH v2 2/2] wifi: ath12k: Fix firmware stats leak when pdev list is empty
Date: Mon, 26 Jan 2026 15:22:44 +0530
Message-ID: <20260126095244.113301-3-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126095244.113301-1-bjsaikiran@gmail.com>
References: <20260126095244.113301-1-bjsaikiran@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31169-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3D0F864D6
X-Rspamd-Action: no action

The commits bd6ec8111e65 and 2977567b244f changed firmware stats handling
to be caller-driven, requiring explicit ath12k_fw_stats_reset() calls
after using ath12k_mac_get_fw_stats().

In ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats() succeeds
but the pdev stats list is empty, the function exits without calling
ath12k_fw_stats_reset(). Even though the pdev list is empty, the firmware
may have populated other stats lists (vdevs, beacons, etc.) in the
ar->fw_stats structure.

Without resetting the stats buffer, this data accumulates across multiple
calls, eventually causing the stats buffer to overflow and leading to
firmware communication failures (error -71/EPROTO) during subsequent
operations.

The issue manifests during 5GHz scanning which triggers multiple TX power
queries. Symptoms include:
- "failed to pull fw stats: -71" errors in dmesg
- 5GHz networks not detected despite hardware support
- 2.4GHz networks work normally

Fix by calling ath12k_fw_stats_reset() when the pdev list is empty,
ensuring the stats buffer is properly cleaned up even when only partial
stats data is received from firmware.

Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset caller-driven")
Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e0e49f782bf8..6e35c3ee9864 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5169,6 +5169,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
 					struct ath12k_fw_stats_pdev, list);
 	if (!pdev) {
 		spin_unlock_bh(&ar->data_lock);
+		ath12k_fw_stats_reset(ar);
 		goto err_fallback;
 	}
 
-- 
2.51.0


