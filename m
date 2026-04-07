Return-Path: <linux-wireless+bounces-34410-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJX3EO1y1GmSuAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34410-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 04:58:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398633A9481
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 04:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1979B30055E4
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 02:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A9372B57;
	Tue,  7 Apr 2026 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+WLjnqr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190EC2E2EF9
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530726; cv=none; b=ST2J8pjX/scAmQ11+gShxFWRfj7Fw4cmxPFi/0kz+2JM1tp2bQiQXPMSpqxt7V/yrm0kJaNH06iN5WQp4zHZBQSgObp7v+ZJRXaX5TOBRdIHmuTdmyG1UCMIvEXo7ZeE3deY7hqTKPrYYpF1sRoVDaP/hdtktvNVmMKvES+ibCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530726; c=relaxed/simple;
	bh=e2S2gkDzmMPoasMLyUWYBrDVBfrcl9T6zhTLzzf+C90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEXrbWE724qlKGDRIZQ1kgA0ANc2/XymChpy6rOXYd+xdmMwyxiFMB5Awk/08ru5cUrD0ZSCMZdcrd+tKK998U/gnikTaPUASoYAY2kx/F441S6GygZko4V5/R8+To+jfrfLkE6/uIOMiOoWcWvtDXMkO3RtwsspY+aamXGDJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+WLjnqr; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6501d242e2fso4215858d50.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 19:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775530724; x=1776135524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N2f8+Snof2dr0Uz7JdWnGhIzXz0lJVuKJAGdkoKg124=;
        b=O+WLjnqrUurJE0GGp87QpJuI10kKvmVKUbOCtgp9lc4yaB3toT99LdBXnlQ1DEkO9x
         Sfwd0ncL4K5ftm6K7L6zFh9WbR0/H5S9Sp2KyDHlOZ3F6AewGkV1ODgblk6ckv6jfjhc
         wNe7iHXtrcXjUiRDwMCYWBFKQU23Yry7365GR4YPlFYdnp5lvojxY9JyqTcv7o7T3aQz
         HAN1HuiZaMBuT5EEDp4GnkBWo33siPQpXv0jsJYidCPmsqrYWaz6mSiVyAAxhVi36WRR
         CTvLyg1+UtT6RAR8ATeutUCxT8Zc3RPlLLqVa4Cy5BCdgbddgggEEKNQqD5JhOk8+5kh
         7QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775530724; x=1776135524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2f8+Snof2dr0Uz7JdWnGhIzXz0lJVuKJAGdkoKg124=;
        b=Bzt0Nfel6l1peCzOee0WucyZMgs4gUn4cqF194jgMoxc3wJvj4Wu/5+CCjf5MuBNHv
         5+RU0d98NqKNlbieeZTPT+ga/zev2GCh2Ir5nVaghx3hutR0JMAfEyvR9TXAuEQHodIV
         O1/t7OmUwMwkmPTSynpC6rg/w8RAY/9KK6kA7/RWJeP6T4Wnfx5Ce9vZzm9aFynIpjz9
         1uA536T2Qc/uTFo880AkykdlwG2E7t4l0fTRguZCcv5cBYdudBiS7lOWwD1fj0qMwY+b
         4Z9WDnQHgyIFzUhquByj5JzIMupfV/yovyqBxS6Pzp2SsSmMtNnSDTbUx1l+NfdUKqFq
         szgA==
X-Gm-Message-State: AOJu0YyOP9+1WZE27N/YcKHfJJY0FkfeSFxXzG64KYG5MZMod36hkrNf
	bhObZpvYi3RD78DgFyzjz5W/6bIr6AZfuxlDxOfT5yIsUuDN6FYCyx1t4FMW82BA
X-Gm-Gg: AeBDieuNZupsl5sKMSAda4ALvGVfni07GUmS+gbb37Am5Jr8f+T4GNE3TdDmgXqH/md
	EDMK88hI78IM0Wa4L0rT29z+d4VfW5BykIfEncmdZ3QDuBukPuCSXuASRIfmEuMSE+WynID1Ac+
	WUUz4tCFZLKA1Ny2btSAwCWRl5UiVgxYvhvq6ofGq/JW3aScKP3EZstkk8Nseaswn+hKfMNkf8M
	W4O9cQObwlqHwDkpwYJtU2NA+KK5eIL/pah949r1LmIcftcYDXuYjg5A0dnz99CKgLLTiPJTcL0
	nBaIUgcO4mPIsRyOPqJqz19Fv1ZblWc0u/Z8qVekNLTrvjzPESjc0RIrXuorn+wTjo1U6/lsAVF
	ONykx0yqNk/HSBw3mZNWg+bIprsVGRNyWODxWA1PcI1udt0cRIu+QDbxWF2VQsB7pz7gMKA8XQd
	CUALesFlTqKmf4oiU45HJW6MlysB62Zh4mUMjaUQnSjPH/xRUxRjDpEFFI63gKb9D7qp9pISg=
X-Received: by 2002:a05:690e:1447:b0:64e:e53a:abb4 with SMTP id 956f58d0204a3-65048515d08mr15275058d50.0.1775530723865;
        Mon, 06 Apr 2026 19:58:43 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a824d30sm7075565d50.1.2026.04.06.19.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 19:58:43 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless v3] wifi: mt76: mt7915: set AMSDU parameters for WED v3
Date: Mon,  6 Apr 2026 22:58:37 -0400
Message-ID: <20260407025838.55455-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34410-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 398633A9481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On MT7988 (WED version 3), the WED hardware unconditionally enables the
AMSDU aggregation engine. The engine uses wlan.amsdu_max_subframes and
wlan.amsdu_max_len to configure aggregation limits. The mt7996 driver
sets these to 8 and 1536 respectively, but the mt7915 driver never sets
them, leaving both at zero.

With the AMSDU engine active and zero-valued limits, the TX path is
severely throttled, capping throughput at approximately 6 Mbps on MT7916
PCIe cards attached to MT7988 SoCs.

Set amsdu_max_subframes and amsdu_max_len to the same values used by the
mt7996 driver.

Fixes: b230812b9dda ("net: ethernet: mtk_wed: introduce partial AMSDU offload support for MT7988")
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 2708b1556f40..f5fa81d3b264 100644
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
-- 
2.43.0


