Return-Path: <linux-wireless+bounces-34381-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEf8LY//02lypAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34381-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 20:46:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 717B63A6593
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 20:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 629603025A44
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 18:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3AB396B9A;
	Mon,  6 Apr 2026 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX5kmYEd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809F3542CF
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501178; cv=none; b=LQVRAYW5Vezm3Iwx3+ekkEEE83vpiuMBcCapO6TthYFanPEsTymgd98EjGpzTHx7U79vqXEobt9W4Mq4d2EgRsHeKZtN9HeFPB9dclmxkh7TLZ6FmzlFkLiijfLqlDM6CUS0Eq+KHWqSH6dufRjQUz7r1Fl98lrTEF7ME4bzuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501178; c=relaxed/simple;
	bh=ZdefbzutkFBt/dtGFD2higdSGarS/PWyJySxoH0PB0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JycP4vc+qDA6j7vM397LfdT1vQ4nkX1OLKF5tK4u2UKIn3/oCcowK4G3Jkd9OPBLXQe8WRwHftd9lJvzAEpDrAIlF7rsDIs6ARPwlocjoZfBg+R3qlbYX7OCvs7nfR4QARm9uJ8eu56k9Q/pOGjhY9pbR769lVO3/Oi2QDACMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CX5kmYEd; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79d991c7b6aso36762037b3.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775501176; x=1776105976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IEu+K66muOe6p5SNvD+q0gXGFioTV+3uz6FputpAJ4=;
        b=CX5kmYEddQia+xPukq2MSdwqaj144cfb77CPXpnwa/98jgo1ixD/Esa9qpsu3QNr/G
         TWuzGmZlyvfyIdB4JvXqJOTZiJzAdPeY2tfSLbFHr3rn1YyQ9Cr3/ntuIzI/fOeFve1M
         yuhHF3WMQBFSk1CmEgdXqm+Q7mfTwM+fZSnYWh0QfbmEWPS48wlQRth63ZZ4lX72Ayqi
         ndbhEEJXcuIEtgs07m4oI5cg3peEbtzVfWUHxyBWvPE0DUii72XPnu8OFF0GNHrBn1WA
         Tdz1lietf6uUPmHkSEfZVtArWMduUbWueCsI3Q4qwCACrZKDSqeDagBLgkkBuTm8nxUz
         8rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501176; x=1776105976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7IEu+K66muOe6p5SNvD+q0gXGFioTV+3uz6FputpAJ4=;
        b=jxfmY8MTvFnBa+/0VY+CXrWnDjxF5P9DMbOwrU78WQGk1c1ZcdKWi6etwIRRo7UD/L
         wZz2YW+R0cKXjvJ7v4LS4zCb29hnfoac/Ga6+voIHRvl6dWMdVv3KLJIwI7F4f8fjGue
         dJ+axxd3/pB2QpTYoKfy79karPQPsNoUer9BRD28bPY//EH0Sci1L4J5dsiWYVK0t26s
         AS/qMx/bcciIHiKGGCbmVztZnpi0Jug8nWcyNdapx8TJfdU6uhfz+5qaVYGdGs8c2vHF
         BCHCwUSg0RveBAba+JTzmrNYN5jKPNCYPa+y+bZPP1q2MX+fqoc74eTOhNWo8S0uNWQv
         /+wg==
X-Forwarded-Encrypted: i=1; AJvYcCVOTQQ/3yoz1s+1QbEXNo+y5mmnDzjo6mE3RIhfueNp61olcGFDTEl8nRkdu7E06wWoUo/uoCU7ARIVAeCYgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/loKW65/TK3UNCPm7IT7ndpgsQQYmsxgYeAB7E94o8GmsHcVA
	nBo0qHsL5Zv0OjmJ6gSWMovD8ZuN0InDPqowHuqHRvQyf1aE5mh++cqw
X-Gm-Gg: AeBDiesnmW+ri9VCGZqHDBewScPqLl4h3Qadzq9GzK2sDQIXAgnV5MjlzRrDLltClKp
	7Q5rox8JMK44yBi3PsuYIGbMx/GKxsM79GADcyUVz3g9USIZlZz7zdjJ0v2PNlxFlZCocMoZBhS
	reEmcfaV+Llz4zqbfMKMrM7M5wnTRM1YynN26WSU/59b3WpcHcT6jXby8s+eUMH4zzypGwM8oG2
	i3lYBPNbq2sYxrHyHwmGoFqRE95PkQE00O5LkCXkyJ1uuRO0SUTDRVtiiXoVcUITmN/Uaavbhcz
	gD9rYwGRvEUZd4g0FFZiXGLGnEOCKAyO4NO4kStsF2ixgwvjDTUfAQJUd+9wN5WUmou3NMvudGh
	ACQF3BfEr+RokIUj8WsK22qcURTDfnIFEZr5mA2lx5WzYgrjky8jx1hXdqVwiHJjkcpiwIhAVUt
	an5aWXknRwKx9ry6LY6RDDnEyOwKUN/bZYdX7gavawcEfatzMtMZ9QkqZn/ZrX
X-Received: by 2002:a05:690c:5604:b0:7a4:e4e5:3908 with SMTP id 00721157ae682-7a4e4e54078mr106668847b3.38.1775501175700;
        Mon, 06 Apr 2026 11:46:15 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e8343d3sm56288377b3.16.2026.04.06.11.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:46:15 -0700 (PDT)
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
Subject: [PATCH 1/3] wifi: mt76: mt7615: fix DMA read beyond mapped length
Date: Mon,  6 Apr 2026 14:45:54 -0400
Message-ID: <20260406184556.8245-2-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406184556.8245-1-joshuaklinesmith@gmail.com>
References: <20260406184556.8245-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34381-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 717B63A6593
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tx_prepare_skb() overrides buf[1].len to MT_CT_PARSE_LEN (72)
for firmware header parsing, but dma_map_single() only maps
skb_headlen(skb) bytes. When the SKB is shorter than 72 bytes,
the hardware reads past the DMA-mapped region, causing SMMU
translation faults on IOMMU-enabled systems.

Cap the firmware parse length to the actual DMA-mapped length.

Fixes: e90354e0452d ("mt76: mt7615: move core shared code in mt7615-common module")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 53cb1eed1e4f..dc7128c46a72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -35,7 +35,7 @@ mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 
 	/* pass partial skb header to fw */
 	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
-	tx_info->buf[1].len = MT_CT_PARSE_LEN;
+	tx_info->buf[1].len = min_t(u32, MT_CT_PARSE_LEN, tx_info->buf[1].len);
 	tx_info->buf[1].skip_unmap = true;
 	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
 
-- 
2.43.0


