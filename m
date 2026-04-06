Return-Path: <linux-wireless+bounces-34380-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHJGK33/02lypAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34380-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 20:46:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AB53A657C
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E7B3016D37
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2725538F247;
	Mon,  6 Apr 2026 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYNfZtLD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6F315D46
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501177; cv=none; b=kgFXenaBYalKzyOQ+kgJ/SwdiEvsEK49mL38dvon7cUeRjoS8ipQslwi2cqPaG4fROjPuUGXCsezPxprEtiQfeczFPoLM0iqlK8J6jlPgSvuamhfgadpluhQ9P2NDiCeGzB3TphEryTU8/4XH3I+GTi9rylFt3y+0nGDnv/cfrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501177; c=relaxed/simple;
	bh=oVzhNQ8iUQAvgW7nBUQ1sJuk/qdkORRUMTPxp9R/flE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhM2+dkTFiDINUlHTNS612yMxAsdRQdRp6VGmhw5lXebrXJIbNDYlrovy/Mnr5Hez8dHndIF5LMl/stNFMSGp1+AhFytd04wxow50h7Dac1XIZmAOu0vv5yi5jAaaGpj98OMf9AFG1CWK0vRJVloDOr7iW6YeCjbjbcMBux/PhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYNfZtLD; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79ab3e26cceso36083847b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775501175; x=1776105975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yscqaJgt4KtnbkPyG+m6kbyDy1nr/tDdA/l1zenQqiU=;
        b=bYNfZtLD4cbM+9nEz2ZXssBszvOQ47BwOnupCWE1EPWl3K0EKD4ws0vpawtuaeTpjR
         r4BdZfwVbeSqGXIySfcZgGY8t8pHGE/fHDhRzI7aPI2f/g0HBl1l79w5OKw52dGWpWlU
         OhNDh4J6H2uh9LFo+0TQrTxkJkhvnvkTho+OoHDeocC/qyTCimS6hctr7YFTLHCXUy86
         rjYPkDIM6OG1S2rKOiro3C4G6ED1dBXgPYfjUKVlXSZDx9RmerwhksUF9aQnavHbUG2T
         N+AWjZzX/dFmV3RGqLEUkesvYiAr0HIU9sPr5yvdhHxyLzkO/H/Q6R3qVnRL/yFp1Z6Q
         oamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501175; x=1776105975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yscqaJgt4KtnbkPyG+m6kbyDy1nr/tDdA/l1zenQqiU=;
        b=YW82N7eLCexiSKDaWUZMZpR2pHNsJLam2JbYVHla6IG32iKjSdIRp3hsFXp+kI1gaV
         qYLpr2bgxIMaOtGhaldhRj06upWOA/dRJ1vnKCy05cd0WyvSqEhn3g8vaQ7k9VFyhbJi
         di214Ufe4C+xEuOIXlMcLHQgPDW7TtfKKlv53A2QGSCXSnJie57kj9iW8HMLwZMNu2WJ
         l9rIMzbqbN27ilEkOMTUlSLSW075l29Zh4lMylNMWykOl6RCmWcq9i8YzE2K5x6t4Uws
         R79V4ourezUHCnUl1EtFucpdvEjlVzQ/rOEYo8AzRwUVxwEeFrUrCMwtta0mNRLieE7U
         Dyxg==
X-Forwarded-Encrypted: i=1; AJvYcCVYkFDEm3XbBde5U5NeOnI1kJHJL3N46mOkNe2HzowSuMq8q9SbF4XWHn94UsxKn5jcUnkRCl+x98u6rvANlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8uumSEb7R/RWF9Y9i5PT2RLnMUi3va9Vum75Mt+wyDfVxVM1
	L8t+3HqGVNebqcLFuKaefai1pguwhSZIh1MvPkShzamH7QPRRzLVc431
X-Gm-Gg: AeBDietHdtgEjW5MMYadUZNfGS24L2u6Eb9Ky5sl0GJRZBNqKNULDYCglkdV3rvN7Up
	qrhR1vAP0rhhnuOqe0BTRFM17tzsnVILbTlYVgMBfZR2TC96T4T35ZonFsusZaMuiAk/YkBUYDf
	G/02dDEuosi5g6x965uItt2scrCrp6xx+2keYOoEMtsQ3xsQzKvBI2tMfnitao/n+L8dU45Ud2p
	zK/4F9426/DWgwldQv3wtiFmUg0gxwMb+PReHE/z1WsQPEfJdBZ5v9w3DPrzl4/WmhZ5rT0BKfs
	YacMSYfNUH+H/P0zjYa+sfDH9VValqLz6MnHPymmnGxUW5Q0syxyjiRMUl3nb4IMy4epAgUO33H
	V1xPAh+dZAWDJmVa28wQLqc6U/Fr3gdR5NUbtwY0AJ0eCF3LwVPA13NIkZwhZDg9UNd/4LYcWV1
	tHZ6tgINFtVpqVo9t4bxSfCeQIE89fp1+SnIuWQUN0/DVy9ob/H3vLgqYiVUyK
X-Received: by 2002:a05:690c:e643:b0:79e:8d95:7ecc with SMTP id 00721157ae682-7a4d3bd7dccmr85544677b3.22.1775501174818;
        Mon, 06 Apr 2026 11:46:14 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e8343d3sm56288377b3.16.2026.04.06.11.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:46:14 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH 0/3] wifi: mt76: fix DMA read beyond mapped length
Date: Mon,  6 Apr 2026 14:45:53 -0400
Message-ID: <20260406184556.8245-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34380-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42AB53A657C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tx_prepare_skb() in mt7615, mt7915, and mt7996 overrides
buf[1].len to MT_CT_PARSE_LEN (72 bytes) for firmware header
parsing, but dma_map_single() in dma.c only maps
skb_headlen(skb) bytes. When the SKB is shorter than 72 bytes
(e.g. a 54-byte TCP SYN), the DMA descriptor tells the
hardware to read past the mapped region.

On systems without IOMMU this is silently ignored. On systems
with SMMU (e.g. NXP LS1028A), the read past the page boundary
triggers an SMMU translation fault.

Cap buf[1].len to min(MT_CT_PARSE_LEN, original_mapped_len)
in all three drivers.

Joshua Klinesmith (3):
  wifi: mt76: mt7615: fix DMA read beyond mapped length
  wifi: mt76: mt7915: fix DMA read beyond mapped length
  wifi: mt76: mt7996: fix DMA read beyond mapped length

 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

