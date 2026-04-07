Return-Path: <linux-wireless+bounces-34419-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJI8EPSB1GmVugcAu9opvQ
	(envelope-from <linux-wireless+bounces-34419-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 06:03:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E8C3A997D
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 06:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A051300DF47
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 04:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BF34F255;
	Tue,  7 Apr 2026 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbWQ2Fj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D6357735
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534569; cv=none; b=t7sJQq7bxOErSs5ZsKypyA7Y4LiR4WJNy0u2I7N0qqsZ58zOjKLYR93lyrrvlbwBup4V5prhbEP6njYeI7tJKm2BnQQqxVeWmroZxrIf/qoJe2jozWGrJgbwSTq5dAOo7TP/rVWQVJYaA9ssT9Sl1o9C3sopBlMg4hFt3lgRqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534569; c=relaxed/simple;
	bh=hwRDlb7YJ/vmDkdfuwwPMQ9GaMSjHl+xw+sbG/y/vsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnyzxbKNu4BUJQVvPdUSTsbVqTPTVktmow8QcwEC/WLiinAhV0Ykk/FHj75/pmpWsU2SgT3fx3ZmTTU0B/u1dxWIvkjxYjV9YcxvZeapIsNaqlqoSY+PvApjpXmNPiJk58kDcmc7oqiDQcNDTbmVtkpw+rYx99w1s08KrLiBqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbWQ2Fj9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7986e538decso46447047b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 21:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775534567; x=1776139367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLmZBDaXzARugQMiTHhvHFOxRfIZqlSstTFsVcMYWo4=;
        b=CbWQ2Fj9QRFSKwG73MqOYREBRaQNf9FG17T9VFp4i6tVgD2MTGwUKRezOj4+MQaoDU
         CeANbvrUynQVhcPTxHDkNFld4omyf1V3AKwrA08SUtj1XY/F8Rk72d7x/S2HLh5GrYJK
         elK/7Z8ThMz4TbKPIyTo4BW0an+qIyje0T2B52Int3l9zV0i1HK0g2wQIU8sGW2kZP1l
         omODNeuz8vwLE3pAWVWXDchpscWfZ8UQveZ+4fPUURlltqyXSmlnopipm9SFmux780Ph
         WsbxqFWCrKAethC+l6LqX6QL5oLZUpwElmbwtnUvkAcvKBR+qQqZHWMkRRvV6kN/UKDk
         jsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775534567; x=1776139367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLmZBDaXzARugQMiTHhvHFOxRfIZqlSstTFsVcMYWo4=;
        b=cCWdRaYiLpDs4/vHnroliOsR92rn4ifLd0r5n6PPZTru6pOgrmlZbmf9Y42xOSQIyw
         LEovEn+1osggBlibd4TKK7oIRMlSjhd07XiBYvuuFv1EpuSVeG4hpUf2rQozwTVSK/UY
         0J7F8azvHLg6mBhGeWoKU/HHutyr55l3zZS/yufQ0z397IU2yJM/Rjqa9TQsom4YHtKo
         jbnrZLXOBLz14o1j7m5raPsWi+A7ohtin7CO15ElYMz/EJ92a63IiX1BTMjcpAxb1qZf
         X1blNwxoFhRWUUveKFt8AxNTaiR7+/ZPZIZZbpwASYltfTLaNjkMcu2PbyTAZNG4hldv
         UJ+w==
X-Gm-Message-State: AOJu0YyKGQiml2hK+apxbUlpSjLAYve38+5ya2Jx/OPKuoOSWvbX33OU
	WwqJNLZ4kipLLyKent1w3txu8gt6zdPO1U78FmkV2Q8BkLZmqJaZz8Gk1kS5rf7t
X-Gm-Gg: AeBDiet4yYwRQzo3HWIBFZ0lFh0m0zWlhcpz95tw708rLcnyW8jhSA0pD95nWwX3ZUe
	LtIH7Zcv64cNq/3HZweLZrJAThJBZOPkg/mJbapxXHxTHSmC6fWarDwNl5ZD64yf8HTtGmYGbxy
	nfCYG1YhVY2Xbk2z6SJiRXflWhYlA3JPgjUPYFjDdAe5Rx3pHb5s0iZ5eUmm+cOXgUkjPGDW3i2
	x7MhNCLZg9G/jcXry8gICtBG2epMXfhUhr3a+6hwsaPh+vC7rZbrqcFSjc4pxmjhe8Q+S7S01Nq
	OQ6Fuye54z/xesJzqysNzaUPd7M6tvAkweyYN2qqVpLoArrcgbnCJuB1ZkV2eFKTka/4FDYCkeO
	gftUPRl6IMeJTu+pjaNQLyzrZh6AIa4EGxXSUu+xS1VwgHr9+Bkt45p8ZjJZza2Y6b9l+JG7K77
	8I9u3u2oaLVi2Jy3vrS5poKgpi9QozptvDI7XsqoKN2bN4PZJhCN821YqyztdW
X-Received: by 2002:a05:690c:c0d6:b0:79b:d341:56f5 with SMTP id 00721157ae682-7a4d68329d9mr131266127b3.14.1775534566856;
        Mon, 06 Apr 2026 21:02:46 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36ed2bb47sm64741807b3.21.2026.04.06.21.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:02:46 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless] wifi: mt76: mt7915: fix WED WCID for MT7986/MT7981 wmac
Date: Tue,  7 Apr 2026 00:02:38 -0400
Message-ID: <20260407040238.60629-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34419-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6E8C3A997D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The WED forward path sets the WCID to 0x3ff for all non-MT7915 chips,
relying on firmware DA lookup. This works for MT7916 PCIe cards where
the WED firmware can resolve the station by destination address, but
fails on MT7986/MT7981 wmac where WED requires the real station WCID.

As a result, WED hardware offload is completely non-functional on
MT7986-based devices (GL-MT6000, BPI-R3, etc.) and MT7981-based
devices (AX3000T, etc.) even when WED is enabled. The CPU handles
all TX traffic without any hardware acceleration.

Add is_mt798x() to the WCID check so MT7986/MT7981 wmac passes the
real station WCID, matching the behavior of the mt7996 driver which
unconditionally uses the real WCID.

Fixes: f68d67623dec ("mt76: mt7915: add Wireless Ethernet Dispatch support")
Link: https://github.com/openwrt/mt76/issues/815
Assisted-by: Claude:claude-opus-4-6 ghidra
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index a47b9cca3b46..116dff49c104 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1729,7 +1729,8 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 	path->dev = ctx->dev;
 	path->mtk_wdma.wdma_idx = wed->wdma_idx;
 	path->mtk_wdma.bss = mvif->mt76.idx;
-	path->mtk_wdma.wcid = is_mt7915(&dev->mt76) ? msta->wcid.idx : 0x3ff;
+	path->mtk_wdma.wcid = (is_mt7915(&dev->mt76) || is_mt798x(&dev->mt76)) ?
+			      msta->wcid.idx : 0x3ff;
 	path->mtk_wdma.queue = phy != &dev->phy;
 
 	ctx->dev = NULL;
-- 
2.43.0


