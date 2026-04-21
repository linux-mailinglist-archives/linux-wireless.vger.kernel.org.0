Return-Path: <linux-wireless+bounces-35156-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G8NMDiD52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35156-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:01:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0A343BB26
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE31A3074D09
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE83DA7D8;
	Tue, 21 Apr 2026 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3GZpOE8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578BE3DA5C9
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779390; cv=none; b=DZBWhsgdyqqTFLhOgDjXQEmz0Xgzd4VYCGPuqAWAA6e2fDj2Stj+67z9oT4+UGv5tYa6tT8A1WY4fO22+7vz2RuDCO0qvzOYJndhyYuq72ZRUerwugE5xNMSq1jANBAH0onYU0i97iYRPkzRKvqawYiCe4vQweY4X84RLtxcRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779390; c=relaxed/simple;
	bh=a5NBwQv5LMV+9Kb4W5G1y1GUXaJ6t690TRMAnkk0mVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqnKpFClt/bWniHpA7N9R/y/E3qJNdxzoWrveDcSPVjSX9Xk7j6prCPA06/DJvJLrCT7xhua5S7mbH3ZOOLhby8VMT9efAVzExW/TonNQAW/pr7ttxn7boVHqAbBunpSlR+BevUv3q06fYPAZ1kQ6m8b3LdWDWo75woJaBku5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3GZpOE8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891f625344so24052685e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779387; x=1777384187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1hC026h1vy1ZTTQW482Pu6t5gVmuKxAEh8/9v5mxEQ=;
        b=p3GZpOE82dqrrvenMpT/noTCJ+biVPk3nIfJnkQY1+DE6UaYGacr7j34u3dcpbFDXo
         A+CSskDu4mHGvAGyNIFJHYkAt80AkjdIK7mWGljMcildMM1cneHJJhV1Fdqzhjt463pB
         d3R3IPnD9qzmsd1sNlXvSBleJidMBXn5PBnaCNX5976ZXah3yepV9vqsSiBSRhVxSzKV
         fTAyL64XxgXOX1iHR+n6opPbAGIXUwK5jS6/uGKX8MSkPnlxEg/p1x5/5tiLAqCSb1Hf
         lDKupolV/E0WQEClQLetJfQzO44vWSd8wLwFCXdyyyuk0BKA6CsMeu1sWLB/pWhFQY22
         oQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779387; x=1777384187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K1hC026h1vy1ZTTQW482Pu6t5gVmuKxAEh8/9v5mxEQ=;
        b=MmnX0A6Llsk1ABiQt8NTpj2r5biFrOsNFXKbPXDM1aB/CnJ4oxGW+7ozS2qT0nSHHZ
         wzmIenHUZYpPwj1cyy7VB6HQ10BXJYlNX3YENdUxjVZxCzfvsgK+L0iuv5/CNtbBgJkh
         4legime6dLmSv95jrFHgikvOFHUVaT5eJOreeqwehyLQ+KL42QHlCpk9R69AAOMy4PPG
         1QvTDVtE2ZDk70eJQg+3VykAb1V8Y5rwwMGtxSKMq5YzTR7nx7gwSrgB/AMGqrf1oy7z
         mJ6P5O4IrQVj2826noyHo+ek6+ck/HFPge+bzvUr5wzIRXfOr04IAWtyB+3CR561hgrQ
         RzVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PiE7kkDjUVa/z9rTOSPTyLCPceLJP4xT8e8fvh9DBMw2hAMx1d5hFRycZRECzUlDRhe6ld6EQCzbfjoV6+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XFacK7I9+k+mQIbrEBNzNPEmifajBdn3K+juB6DRv6pXAQhG
	phzLy3Y1Z16TnGtizncRR8pJZIqWR++PNWr9TOHXy9/3Gw6rCXA7hMQ=
X-Gm-Gg: AeBDietNSjw1JvhowK5ctPQ67t5xX+RSkeMbv78zNAYNgglGmrAd8xOEIzJ6PnBLeh+
	OAWGBqcTJsR2/cUhSVMahGXT1RQIikhCwVw9ixpHq51V7W4RpjqFYUErwCr6+90bzVL0FbtKmhX
	RwFt/XrqhZpadBw/LVLPiJOVbj1r4RFQHmYTwG4XRrB1AhCrkicMraQUj20W+7d9iCWjgBN2EIq
	UNtNlX4D5N7+Z0tsmK2NnKGA7Squt3XmqL39RRNgRtIb8dG8mJk07wlqXjZEwbk6ZGvuqI6Me1/
	loWiePIiiq8Aiy/guKn32lrEhZDFv/N69GjnukzPu97ni6LXaXipJGdO3P0Q0foV+82PmlnPnAa
	6/PYgA1yNRGq3dnMaXtovDnrMkPNi6jDw2T6XierTvOaCYePQ6zZv/lKQ/uVabK4UD4qoU2n618
	+Aius=
X-Received: by 2002:a05:600c:870e:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488fb84ffb8mr248676515e9.0.1776779386728;
        Tue, 21 Apr 2026 06:49:46 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm176331185e9.5.2026.04.21.06.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:46 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 6/6] wifi: mwifiex: fix OOB read from inflated TLV length in IBSS peer event
Date: Tue, 21 Apr 2026 13:49:38 +0000
Message-ID: <20260421134938.331334-7-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134938.331334-1-tristmd@gmail.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35156-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 1C0A343BB26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The IBSS connected handler replaces the buffer-bounded evt_len with
the firmware-controlled TLV header length. An inflated value drives the
IE parsing loop past the event buffer into adjacent kernel heap memory.

Cap the TLV-derived length at the remaining event data size.

Fixes: 432da7d243da ("mwifiex: add HT aggregation support for adhoc mode")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/marvell/mwifiex/sta_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index 6b7e5b6a66a9e..62a879c09106e 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -45,6 +45,10 @@ static int mwifiex_check_ibss_peer_capabilities(struct mwifiex_private *priv,
 		 */
 		evt_len = le16_to_cpu(tlv_mgmt_frame->header.len);
 		curr += (sizeof(*tlv_mgmt_frame) + 12);
+		if (evt_len > event->len -
+		    (curr - event->data))
+			evt_len = event->len -
+				  (curr - event->data);
 	} else {
 		mwifiex_dbg(priv->adapter, MSG,
 			    "management frame tlv not found!\n");
-- 
2.47.3


