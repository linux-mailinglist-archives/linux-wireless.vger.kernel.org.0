Return-Path: <linux-wireless+bounces-34402-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ/VAM5N1GnvsgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34402-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:20:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF083A86C8
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34D69304AAE8
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 00:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04C719D093;
	Tue,  7 Apr 2026 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzoiIDHT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F815A86D
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520991; cv=none; b=cl5qgDBpc+5i/oSnBDCXM3oDSx58xzYfVvXfxjTmmrSxxsuQMaSgpkScE9gPpEPDv6Y4IsjEGe6ODBqf0YGAt5tIrERJmjZcu1wLIMXakBlQ6MLaFpDnwWgoQxucBUcwVjMMZ0bxBoREoFxroCf2rTzdxL6bPOfN5XGbbWDYXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520991; c=relaxed/simple;
	bh=YdNpKMvW96DZpgI70sjhYgdW0gDUDlCtRWS2mO/gUIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9J44ThGqSJPv6pDuTAREQJ1aWrQGUNfaSWvOvhq8DdBsoSnlL1QVF3Ov5BRtaq2CMiU1J4bOaTirYrz3ZBF9BK9kliUUIkgdw+IqQY3Y7ncxgDkGP8Sfz4bmWACjBZIfMxFSyiW1Z0Bv4lIB8wOGRFxjEH2K7CzY3LUHVrtMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzoiIDHT; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fc4425b6bso41366097b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520988; x=1776125788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aamfvEwNDfBJA4QCfzr1zRHkZtJULSH2RvB2rACm6sg=;
        b=pzoiIDHT5nNTjju+wNCpFsKJj7/KnpPbpbc9E+kQEQXX33Wq1EETkRvUEdQeSLcSn7
         Tmn2Tsf3hNnorVfiasvaKdJqXUsWDBijlYdAnTVlvyNPvW41Fl3j4ks+bQmyLtS2fNtn
         onkAjBluDPeZTBdlNBRazd74LqM23Rr3mP554rsSwzL5pzHdKMq7bP92FgqxXuZg43ez
         ruJSFRkQmREUjps6fJiAVWspP56NZWlBZ1NgIg/+klwZ5ThKK9Twla5Lf9QWmMtxZiTN
         FF2nyKy0bADJMPD2/PU57Gb4Da+6xiQbOmiqTZdIAxUwSEwn3aNqS4wbj+mvzHcVwZB0
         dLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520988; x=1776125788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aamfvEwNDfBJA4QCfzr1zRHkZtJULSH2RvB2rACm6sg=;
        b=qWR1p533xUK6zUJDQoGSz8n5IgQ8y+hnmuSHNJA2ayUMaZGQC0SNxB1Ij4xP8L5pUz
         tZzDFDvt8bM1tGOKEbvGRr7NpLGuUFYYLj+a35ZdNt1OxPOZuO8KxEyT0og9bST8pM7g
         YQdW04O0cGPLmXVGSkoecrs0yx5af9j+gDQS0jYNTHduY6qeeSvgLTo96Eq+chDtr8pZ
         5lY0OKC7F4mAgC6sbnsBwV8G+lK0DcOOeZH/Tmdc5nCPLBG+7ckzyX5OKZ5dvWLdSbbq
         SUnUfqjNk5EJSq5jHKDHnG9f3KzL4nJ/e1KdJhKfqzkUgcgEFZzb10l0NKVYJKrkAHB1
         /TrA==
X-Gm-Message-State: AOJu0YznWszV8NPFRLAXBm0K82/pv4wBpO+QBfTWwv+HLF4Q4qGgDCPx
	6TB+HOgsz4pBpPz6vIBIQfpPbabgokAJPzbh3zIjfs1N1ddCy7Luv3jUljpVUknU
X-Gm-Gg: AeBDieuUZwQeYidO+kB/9pPJBj/0gTc/cRWHBy3n3rQytJz9dWr3r6FMp64fesZnXl4
	u5/9yX3q4k1aesxUONwt3A4cEEQFnnDkl0IfpAkmsIQL6eRJld8XpkSWJRKSvYAlM6My3Nhemjc
	9WcE3AT0j8jqx6/RJgNEzgFMwYkOWCJdxa+JdmzsuQwST8DSh8D1U2a1Jnub9eiy3Jb6BWdxsId
	QTofb+p6Pyzo2jw1OumTUqMqZfejONb/JuycgJkN8gZhTjJlztLo0HPJPGZsgiIGTc+2Dzp7zr4
	ZWyIYiYyyPtTbswkd0QiAe8lkyTQCv4qYtm1xJwsf/HYYgQV1QoKf+UlQ4ekl2UvrjEXFTyq6KW
	nVTrckQTotGGBHLW2U23tgxCseVF6OgUp2RqJUW4QK7Wwq5wZ6o/CLtjKtBTi5bBsZA6R7NpWtO
	O+sPWWRAZRdnkKAA++ePxY+8kV/CXpjMrcDTCGfH9DJRq6/S+PXH+N96ryAZO7
X-Received: by 2002:a05:690c:6d81:b0:7a6:1a8d:3046 with SMTP id 00721157ae682-7a61a8d315fmr117836757b3.54.1775520988115;
        Mon, 06 Apr 2026 17:16:28 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36ea27d19sm60032537b3.20.2026.04.06.17.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:16:27 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless v2] wifi: mt76: mt7915: set AMSDU parameters for WED v3
Date: Mon,  6 Apr 2026 20:16:18 -0400
Message-ID: <20260407001618.31263-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34402-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AF083A86C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On MT7988 (WED version 3), the WED hardware unconditionally
enables the AMSDU aggregation engine. The engine uses
wlan.amsdu_max_subframes and wlan.amsdu_max_len to configure
aggregation limits. The mt7996 driver sets these to 8 and 1536
respectively, but the mt7915 driver never sets them, leaving
both at zero.

With the AMSDU engine active and zero-valued limits, the TX
path is severely throttled, capping throughput at approximately
6 Mbps on MT7916 PCIe cards attached to MT7988 SoCs.

Set amsdu_max_subframes and amsdu_max_len to the same values
used by the mt7996 driver.

Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 2708b1556f..f5fa81d3b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -719,6 +719,9 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	wed->wlan.reset = mt7915_mmio_wed_reset;
 	wed->wlan.reset_complete = mt76_wed_reset_complete;
 
+	wed->wlan.amsdu_max_subframes = 8;
+	wed->wlan.amsdu_max_len = 1536;
+
 	dev->mt76.rx_token_size = wed->wlan.rx_npkt;
 
 	if (mtk_wed_device_attach(wed))

base-commit: 6cb103122c802fbfc82d1e53cf78667bfc52eb9e
-- 
2.43.0


