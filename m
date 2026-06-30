Return-Path: <linux-wireless+bounces-38395-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XgptOtDcQ2o8kgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38395-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 17:12:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5516E5C8D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 17:12:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j4g5JylX;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38395-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38395-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 290FF303FF37
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957912E7162;
	Tue, 30 Jun 2026 15:07:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2002C21F8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 15:07:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832027; cv=none; b=W4EGxkGkHITuBA4oe4RvUMn2rpm6RYuaxcduM876tZs6HBOipwjao3ONQXDbm6JMZPq7cWumjiffVT0SyKc5PtWTvoQn/UafCrKo5BfiK5CKncIJ6HFrqUNJsektiMMZFOwCzDYbVjUIxgXc+QOWu4Q0xjgpCtKE3sB0bUvPYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832027; c=relaxed/simple;
	bh=aXD072FEnIHgF4SWBIyM+PiPgjDGjjhs9Xm1MTgvbJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJQxSSdB7dq3hr3lAsaLJ8BD6Z5qCPKKZ4pkqD8SXv2xwABWXhms/PyjmMQ7WifmbiARvxZfoQrwltimEZ1OTuf32BdzXu0oEUHt0MUaly5fWUD4zm/86pPp2DGYfMf4aXAElOXWFXhDUYZngHlWPKLHg8jIhwOm0B5+97jrdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4g5JylX; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso1546416a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782832025; x=1783436825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQZZDFFxqTDdSnsRY8wqJD42CyjhcA/Zlppkdex9wbI=;
        b=j4g5JylXzx0FyjorKWFFKxwX0jEiHUy/DhM0bZ3X09lJFdXZCk8RbaaQ7TyUWEakd/
         5D2oqgigkmJX1uGS2EWOXw9CYfMjvbkNqcaFtb7HXLMSzI/TI93Lc0AjnAD5O18nt4RC
         FmFSN89BzY3xTxOU0TEve0Pf5nusncdya+oC2eg72NbnApHIGMFIs6hUXpzr7cJoBI9X
         /2zcbTxp8ZS1GVSTP8P2oTOGW7TbvXNdeY9NxYFzwXcBN4mkcqCTKuslGScWl61V1vnQ
         G3xoKop/Cyu2tvwXlc7gpVth+JQHq3WdCtS3sUsqzGSVobkCf+44nlhDCxF/HhzrvfYj
         f8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782832025; x=1783436825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQZZDFFxqTDdSnsRY8wqJD42CyjhcA/Zlppkdex9wbI=;
        b=FYo7QliXxBvMqu9pl7LbIDfoDXoa1eSjL3I0ncm6wsbz3/qFsYfKSlhDP2oH2RmXt8
         f+Nq132Vy7ECGPjpPBe6Lspb8bhapljF0U4ZjNk4IGA4UulMmYxacnuS67Q67yERwmUu
         durrJuMEhobkojPEzeN24GDQL08cqyuylvTGZPqAJYtnQ6gHF10sLVHdg0u+kJvtxiAF
         zmyb5jl8A/NB4PUq96ZD6U8VTqtowwgY4GQATsUnEFOxc7JY2VLGetSsHtEm+08kUrWc
         0SR7mKdvT7IB7rPRWC3U3qLx6NSLk4QYO5qM6ebXB8/1iP4NiHu/rwAkUaOxW/qFCCwv
         9evA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+AciBfDvyYb+YT0oNpSoubkzp7gYk/c1xbI6BMFazgcy4klfsidSEIghqaJ6Tal/dpkTBBeu4Tn0wDetV4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoqPleYONEI/Y8ceedn8EnxkeDjDxfx8827blpN3qsJ9MUz3oI
	dSccnjC4ad0DzQvjaYVAMMUduP29Cvq1+3cFTSNwLbediUSX/4VUxvna
X-Gm-Gg: AfdE7cngX2D3ZL+fza28pdUoxpY5YBnjdHoAKCf2KyeaHrWS77DgPPeq09HwkHp+Etv
	3g3vYp5tdTxEzdq5nJUnyCBL+XP8w/sV4rv59YGdU62cREglwEDZvmEfuEJOAXn6Wp0jwH3Xijw
	m2BMjLZTDsUNR5Wzq8zXu41AynbAD57kGiIYmP3dBlMSGt+yALiRbDqTWqFMK5lMAL/mQaXxWm8
	LoOwjZ86AOnJp6cN1m+d4bRI4bwvm/MULMr1G3pq4hBEnqE/up5XzpaccOXdA4z0WuANEnnhMvY
	032gtcE86LS1bgrbOmiecfRF1s37r2shul48EBjHjwBooxINoM+lWoBIQplMcNGjLHBjwsCqVl2
	kOWU0GVMBCXOdwHzoeyrTdPZPst8Eej9XhZw3dokTgA6AVePhqv6LwRrlYEK1fq9c0CkJdhRYIz
	rB8btV/TA2wjZtlgHAmsg7jOEkGAUn4i4xsC7XsrZy58SaOHe2YGcfgQ==
X-Received: by 2002:a17:90b:3909:b0:37f:9ce2:3489 with SMTP id 98e67ed59e1d1-3808c0e0679mr706219a91.26.1782832025249;
        Tue, 30 Jun 2026 08:07:05 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095b684basm41811a91.1.2026.06.30.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:07:04 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH mt76 1/2] wifi: mt76: wed: fix kernel panic on non-DBDC MT7986
Date: Tue, 30 Jun 2026 23:06:48 +0800
Message-ID: <20260630150649.1629-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38395-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:hujy652@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hujy652@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hujy652@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B5516E5C8D

In mt76_wed_init_rx_buf, it's hardcoded to use MT_RXQ_MAIN.
But for non-DBDC MT7986 MT_RXQ_BAND1 is used for RX data queue which
leads to kernel panic when attaching WED.

Use the correct RX queue by checking WED version and band_idx.

v2 and band 1 -> MT_RXQ_BAND1
Others -> MT_RXQ_MAIN

Kernel panic:

Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
Internal error: Oops: 0000000096000005 [#1]  SMP
CPU: 1 UID: 0 PID: 925 Comm: kmodloader Tainted: G           O        6.18.26 #0 NONE
Tainted: [O]=OOT_MODULE
Hardware name: Acer Connect Vero W6m (DT)
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : page_pool_alloc_frag_netmem+0x1c/0x1bc
lr : page_pool_alloc_frag+0xc/0x34
sp : ffffffc081dab660
x29: ffffffc081dab660 x28: ffffffc081dabc60 x27: ffffff80091af040
x26: 0000008000000000 x25: ffffff80091a8898 x24: ffffff80091a5440
x23: 0000000000001000 x22: 0000000140000000 x21: ffffff80091a2040
x20: ffffff8003f1d780 x19: 0000000000000000 x18: 0000000000000020
x17: ffffffbfbf0ac000 x16: ffffffc080ee0000 x15: ffffff80049d47ca
x14: 000000000000037b x13: 000000000000037b x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffffff8003f1d7c0 x7 : 0000000000000000 x6 : ffffff8003f1d780
x5 : 0000000000000680 x4 : 0000000000000000 x3 : 0000000000002824
x2 : 0000000000000000 x1 : ffffffc081dab71c x0 : 0000000000000000
Call trace:
 page_pool_alloc_frag_netmem+0x1c/0x1bc (P)
 page_pool_alloc_frag+0xc/0x34
 mt76_wed_init_rx_buf+0xf8/0x2ac [mt76]
 mtk_wed_start+0x79c/0x12ac
 mt7915_dma_start+0x274/0x63c [mt7915e]
 mt7915_dma_start+0x5b4/0x63c [mt7915e]
 mt7915_dma_init+0x49c/0x81c [mt7915e]
 mt7915_register_device+0x24c/0x530 [mt7915e]
 mt7915_mmio_probe+0x91c/0x1980 [mt7915e]
 platform_probe+0x58/0xa0
 really_probe+0xb8/0x2a8
 __driver_probe_device+0x74/0x118
 driver_probe_device+0x3c/0xe0
 __driver_attach+0x88/0x154
 bus_for_each_dev+0x60/0xb0
 driver_attach+0x20/0x28
 bus_add_driver+0xdc/0x200
 driver_register+0x64/0x118
 __platform_driver_register+0x20/0x30
 init_module+0x74/0x1000 [mt7915e]
 do_one_initcall+0x4c/0x1f8
 do_init_module+0x50/0x210
 load_module+0x15f8/0x1b10
 __do_sys_init_module+0x1a8/0x260
 __arm64_sys_init_module+0x18/0x20
 invoke_syscall.constprop.0+0x4c/0xd0
 do_el0_svc+0x3c/0xd0
 el0_svc+0x18/0x60
 el0t_64_sync_handler+0x98/0xdc
 el0t_64_sync+0x158/0x15c
Code: aa0003f3 a9025bf5 a90363f7 d2820017 (b9400000)

Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
Changes since RFC
- Replace single band with non-DBDC
---
 drivers/net/wireless/mediatek/mt76/wed.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/wed.c b/drivers/net/wireless/mediatek/mt76/wed.c
index ed657d952de2..f210a0c57d81 100644
--- a/drivers/net/wireless/mediatek/mt76/wed.c
+++ b/drivers/net/wireless/mediatek/mt76/wed.c
@@ -33,10 +33,15 @@ u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 {
 	struct mtk_wed_bm_desc *desc = wed->rx_buf_ring.desc;
 	struct mt76_dev *dev = mt76_wed_to_dev(wed);
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
 	struct mt76_txwi_cache *t = NULL;
+	struct mt76_queue *q;
 	int i;
 
+	if (wed->version == 2 && dev->phy.band_idx)
+		q = &dev->q_rx[MT_RXQ_BAND1];
+	else
+		q = &dev->q_rx[MT_RXQ_MAIN];
+
 	for (i = 0; i < size; i++) {
 		dma_addr_t addr;
 		u32 offset;
-- 
2.47.3


