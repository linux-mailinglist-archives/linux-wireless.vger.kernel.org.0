Return-Path: <linux-wireless+bounces-34377-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C66FC7/02lypAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34377-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 20:45:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D58BE3A6524
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 20:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D8E9301FCB3
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666039479F;
	Mon,  6 Apr 2026 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7dzpaTi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AF3914E1
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501093; cv=none; b=K/LfRs8C8EWNXvJEQ2CsU9RvH8Y7A6txAkWwi2ACjt3wd6knZ19JZLIGBJ+ouZextrog1pjcB3xTGkWlyMVIE0PwxXIhz6uXeElQnZ/SiqhT58GSRmCy/vADeM/APIdZs4/mdSvmbXGQVDZoLJlVCp468jKBPv4Jm7eXrkV9jK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501093; c=relaxed/simple;
	bh=WMU7EGs3jMkd5faIWQETGMP/EOvdf8l1T/tZgvHILm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3K1fcbNyybazlEk+ik1nyEY7Y69CXOC/4OojwZuUvVrWm1gHUV1cOesUtzO873KcAcRds5VmVhqb1xlfLCVL5RwrlSM8NA0qvJD6bT10TazXN2XzX5sIKKbXAs0iuN0oofLYb6WWObZRWtURq18BxCnZBqh296h2TDocUcDSEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7dzpaTi; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64f48a5c3d8so4287196d50.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775501091; x=1776105891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIDqed17Bi0ataxw+Ke35vc4r3g4dT4TF34U2d2sNnE=;
        b=I7dzpaTixqO2jj4Tb8YF/hW0L+tZTgQB5JG3Oq+aYkjsP6NByCHqdjl0+yR7LlzZy3
         srkwNT8nT30IXw6d73FdQzKxBLBqB8vgpXqBk9mMEXVyzwLNMpb/ByucZdU8g0zOp837
         VaR6VNl0xkDGYjfPaXbVgeK39NzBIiG32g1anBvGGWkmwoIs5c5sFFhMkwXi+I6XGIfh
         hzxk24jm4kyxMhOdxLWmX6GF3wiEnJLq0cK57TOrQjFyK18Fr/zymHH99A9VlEniF0zM
         pXtggvoNt7o12vwBa1OKoQODFOTtD/pVPjgcVroNzh1+aZNQ9audVr/DIH4Zy+EWGX+G
         ZB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501091; x=1776105891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iIDqed17Bi0ataxw+Ke35vc4r3g4dT4TF34U2d2sNnE=;
        b=NZ7RrCSMvjp0C0A2XJ/rCfg92cv5/V8IFXEdU6LaGGJdRF4u9UUYnNua48qPfy1Ao1
         PPMA8zXFNGFrlqD05zvNRPqkgEpZV4rhmO7O8/jrKMOc/7W8L+ezfCc5bEeR2R4cs/FA
         +GIjXpiCPDVy4QvDaWDeN6t5yGAk5QN+Z0Q6rGrIYG8TCoiyBgaxKIYyzNaQwYnCy4C7
         l3zfgjsDglcImAz7fh5Ov22ezvOe37rwqviRl57JV24yUu6GTwqJhUj+j1MGJbX7w3jN
         0iapHAgRelFh1p8vkFf7yA/gShk9tXzZCJ1tiDfSZ0vI1oKe+w4RBxwuX9wJhF0GArmW
         u5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJUZngjQTu+v7/aAhQtxOgLqQjOPVrI7L4diQkNqcUt9W9sEyonxySe4zqmlrr3P323VLyULNiF/4xajqBkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxTgm5hGeKsVDXO4UqyKG8kOxFSo0yJzKKisIyopzPNe9t/vAw
	9cdEAO3gO7rucg7/hSMTfDdzPt8vXafGhdoHcevlq5L3uqbCT9a12GGx
X-Gm-Gg: AeBDievxw3YbN8/O1F62m2mnjhvVh5fSjwTasGWRMCodFklx2O3lcN6H3mGA1C6B5D2
	RrBY9u5/J2R5qv+XLCrsrDNDqMVOBrI/HxAeorZUIoE7B/6mI0EyPCroa1HY5ilxOeCUt98ZieP
	00eJGktefyhmrKSggq0PBqYpK3XRjLby2+EUMFthX4SlZDds4m6Xgols8hVK7Ww72mEZ4JIrpW3
	r4gtnkZKwDxDUVS7beIZnBctJ6x5Cs3qhaD8WG68dQOFvQKwASUT9r5gTW71e5mRSeg8rvnh6rJ
	MHuh9BAAYTeTJ7GQDR+GKnTiaLUD3jAQrSbu52V7L3EXDNxXYjwsEpUjhC8Cu1ZscGqypa6e4H9
	i5HK8zU0ug0XTJ7Nt08nbYJErSxBb+BLzPAqinWm4sJb6q1cCBCcooQ4MfyyKgqovhXwVSTDoTJ
	esijV6X5KYGehV7ApRiIofNg9h7m2qIVaQ0GjFwDV3rDLJibPUfByzgScUicDk
X-Received: by 2002:a05:690e:1282:b0:650:516:5ea6 with SMTP id 956f58d0204a3-650488acc93mr13212718d50.65.1775501090808;
        Mon, 06 Apr 2026 11:44:50 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9a9271sm6342830d50.15.2026.04.06.11.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:44:50 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: mt76: mt7915: validate WCID index before WTBL lookup
Date: Mon,  6 Apr 2026 14:44:05 -0400
Message-ID: <20260406184406.8152-2-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406184406.8152-1-joshuaklinesmith@gmail.com>
References: <20260406184406.8152-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34377-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D58BE3A6524
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mt7915 driver does not validate WCID indices extracted from
hardware TX free events and TX status reports before using them
for WTBL MMIO register accesses. The hardware WCID field is 10
bits wide (max 1023) but actual WTBL capacity is only 288
(MT7915) or 544 (MT7916). An out-of-range index causes
mt7915_mac_wtbl_lmac_addr() to compute an invalid MMIO address,
leading to a kernel data abort:

  Unable to handle kernel paging request at virtual address
  ffffff88d5ab0010

The mt7615, mt7921, and mt7925 drivers already validate WCID
indices against their WTBL size before use. Add the same bounds
checks in mt7915_mac_tx_free() and mt7915_mac_add_txs().

Fixes: c17780e7b21e ("mt76: mt7915: add txfree event v3")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cec2c4208255..0acada48824f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -901,6 +901,9 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
+			if (idx >= mt7915_wtbl_size(dev))
+				continue;
+
 			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
@@ -992,6 +995,9 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	u8 pid;
 
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	if (wcidx >= mt7915_wtbl_size(dev))
+		return;
+
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
 	if (pid < MT_PACKET_ID_WED)
-- 
2.43.0


