Return-Path: <linux-wireless+bounces-32124-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFToCbDJnGkwKQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32124-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 22:42:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D517DADB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 22:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8402530AD4A0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 21:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2973793A2;
	Mon, 23 Feb 2026 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dexceh+i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31A378D97
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882824; cv=none; b=ZUyNIrV6fwJ0iGdEL2HKYdEIM/qMFy+QokyIgS1mgCgk27X8R+ZDN9XOhrKe4rPq1RUXnk9I7dztikoXBSoiD1caHiuLPDgkKBfm6ehCLBBpG6v+lzbcewRXJsaS+rH6spHhR/YqXG+B7MAhSJF0m3mwkYh9KWaz2Wm/n3C9nFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882824; c=relaxed/simple;
	bh=YQ4p28vSG2eIuSfd8rOZa9Iwka2o6ChY/lLMvZV015A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bV4jSJmM6w/uo3v01LSg1OQ3KpZjQHAlFaJr+s91pRK1Otimd2Zf/w/EA3nweZsTFyiXQkKTK7mplbP0BuavdwE49fIMlysTdNEmZIRKTbGkSKB0ZSG8bgVYEu43nQh8zgnQfTyBM6bk6tXeUqKT4vRR4oS7hqQZppanjyavZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dexceh+i; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c626bd75628so1712528a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771882822; x=1772487622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDV9xPVLh8nR5wsS4K0GgvhRgol9hQj6OE4qa9Kkvrs=;
        b=Dexceh+i6jvyooVy7oKGpwHQRNQmgVBCLepad3qxAIk6gqLhce4euPzAL3DJzrJNiP
         uJuToeTy6Sgd8rSIVsMXWYL5Q+Iyip627uEltOm1ue8f+ovClMmQzS1SgOuk32XrcpLB
         UNp5BdlibNSyS6Fn7y4dik99Hwqke2bDeEncV0AeuVoDhTtQoNd5d/LYJvzn1X8mvJV0
         bR8qI+pEMqmN3Dpo+q45N/EwHg0Ri2oMKKnp7LLqVl/mXuWIauNprelt8yXGT5GcxpQQ
         3we3zbGYw7EZkE9Qht6tA/xf+oP2e7Bl1S2nHCfyLn57axnermV3ZgnDRC3uMv1hLoZg
         OkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771882822; x=1772487622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDV9xPVLh8nR5wsS4K0GgvhRgol9hQj6OE4qa9Kkvrs=;
        b=vO6ia9yRmvvSAiqtIkwYs9ORIgPh3tf9S+AARzgF4Gk6XV3kbnEGCyYDrAhd9P/DoN
         +eXMlJHQUeG6Lhqw9QhO3e957u9Q+GdAVxarsBkeyrlLMhnS4S1Qjk7ylTKjUSTt6LNx
         tggjPEApjmlchWudLsI6uaDjF+AFqjRtjC72Fy05jpzhDn0kpKU6rMz8hQdJljthXuJG
         XEf+juY8EahBtN3kYsS/XfMax5c/BZwd0m4yc2mN6k0plhSqEVA4FXnJ2Byux0ZfMuaE
         0xl+0TyFMRaYeIGIclNkNaUMxTinl5rcQBVhfvVHbpU/O5gmUgPNfqagFMS9qddAtJTj
         VwJQ==
X-Gm-Message-State: AOJu0Yz56W85b5LiFjEtMXDXL9EbpOnGynyOxUr73AHTerpxfJWf/mQk
	Usr8sm07RIm49/ySC4gpRdZcLw+391A8Y5I+jgHgIwhU9IFt08RCGbIaoxX3DUxx
X-Gm-Gg: ATEYQzwLQ45WvzCTeJvRLTuzv+kwDsakoyGzMS2KPDK94tJ7En3C+vwJkSUlO68Si1Z
	tcH2wFdVWQaTK7IJ5u1LrxpSQEoSwfpaPQaVEBLy2+OXBSq1zxhYldbhLvKxz3RAI7ZfYMxE8e6
	iZrAgijf70cWahLK+DP4o2qrs0CQOcgBAnKCGk1BUYkKjaWVAblV+3uMP5tKkH8xuXaXeFA0u/b
	R8BwigxbEglNl9cOA3imV2MMgWrQv6gqrnDRFkTky9eDs62UtzCTFS91hayLjPpWBLXHYfJ6bqb
	LwOG2YH5OCoapKF/tlLPHIdSheykaDwH1NOE1DNdCouig1XaxEeAwK1uok+Jng55lR5vlmenie2
	rUVfQbikggUgecYZOXpfDVDAgvJ22UR7uP/RhYWGys5VrzVWdOrWg/g7as4XGh++d8Rm2/qnHte
	6Etx3NRh55OAsmWk0DQKOw7cD+joew20RBqyuxSwh+Ynu27zHwrA3QQA==
X-Received: by 2002:a17:90b:53c4:b0:356:22ef:57ba with SMTP id 98e67ed59e1d1-358ae7c50a6mr8715839a91.7.1771882822068;
        Mon, 23 Feb 2026 13:40:22 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af95863dsm8075574a91.17.2026.02.23.13.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:40:21 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 wireless-next] wifi: rt2x00: use generic nvmem_cell_get
Date: Mon, 23 Feb 2026 13:40:04 -0800
Message-ID: <20260223214004.19960-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	FREEMAIL_CC(0.00)[wp.pl,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32124-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E7D517DADB
X-Rspamd-Action: no action

The library doesn't necessarily depend on OF. This codepath is used by
both soc (OF only) and pci (no such requirement). After this, the only
of specific function is of_get_mac_address, which is needed for nvmem.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 65d0f805459c..93e4ce604171 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -10965,13 +10965,13 @@ EXPORT_SYMBOL_GPL(rt2800_read_eeprom_efuse);

 int rt2800_read_eeprom_nvmem(struct rt2x00_dev *rt2x00dev)
 {
-	struct device_node *np = rt2x00dev->dev->of_node;
+	struct device *dev = rt2x00dev->dev;
 	unsigned int len = rt2x00dev->ops->eeprom_size;
 	struct nvmem_cell *cell;
 	const void *data;
 	size_t retlen;

-	cell = of_nvmem_cell_get(np, "eeprom");
+	cell = nvmem_cell_get(dev, "eeprom");
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);

--
2.53.0


