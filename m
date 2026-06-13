Return-Path: <linux-wireless+bounces-37763-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 00UWHg6ULWq3hgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37763-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 19:31:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B95FF67F2DC
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 19:31:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GeZJToEl;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37763-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37763-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 812703016520
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC942264A9;
	Sat, 13 Jun 2026 17:31:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6AB1EEE6
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 17:31:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781371915; cv=none; b=l3GjG5QHG7a14BOJoTC9Wws2xzUnZAhyy+QmANKOtFbLbh1JVgl4sXMBx8gsrjhM0WrNSnkjByoLgHm9heZ6n3GBCZenfhtZMlpze4SPa8y+uR9yWQxr16BBhyV+i+yw1quqQ4WLSvDBtINbvYiTfESHM44Zupmpj+vJRZg/h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781371915; c=relaxed/simple;
	bh=2zFDhV0tB+pIA+2vxsSf0QAiuoRgzkHkHOJ/ZWsP3U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyA3Rh9HqMnE/4dtlAyon78yeFZ6Xn4y446W2DNJDqaIxN4kp+S/DUl+Ir+k/5s2vMAQrn/3nicWjjqNJXeGMeAx4T4fceCCRynFXkbrrn1cKdyV5whJce+0EDTi/p7L7RQNbZ1/Ol+/9HIMk5d1qqWipeiVAzWaKr9cDCAnKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeZJToEl; arc=none smtp.client-ip=74.125.82.180
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-307631dbfedso4402124eec.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781371913; x=1781976713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C17B2edKMqV+XF0ZSaOhZ1zqxpv8me/cpGMvVnK7YlE=;
        b=GeZJToElApxyTRvi24G9Bg57exB3u7rFLLIchHF0ejQEqBYRCJV1i78C6QnGAAQck4
         S/dDwg5ApiHlcNFTJvxE74kjvfwvSwNvWyh5JJWEM7lFwYK5qCx/f3zIAmNmu1BN3geY
         fKeom6iurrxDNKpJxRMb5kNEdTA2L8XR0jYXPgeJaY5+mQRWrGwF0KI6EyzRl5ruNf43
         lH76icG66FQ/ZVaJp8TKQKceD+tj2DG7eqydu+DWNZMoA3A3/uJqsVV3cUkixRULi/OK
         UolF2yRFLcSnM6SrHwXoRyh7DhgoO3kWaOr0eR8I0tg4m48aw/lfBJJsfMsg9hVBRYNd
         bVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781371913; x=1781976713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C17B2edKMqV+XF0ZSaOhZ1zqxpv8me/cpGMvVnK7YlE=;
        b=tTNPjINKyqtvfNL19dO/DxsH/GzRrj1jg4r4opBG8Vylm8yaYO+IUKgUaJwyRQc15e
         3QuzYZ6efbySPC/690jT771cx5M4ki288N+G92YEKNflChQ4quoSRBaqLnzT0btW9qxo
         plAR4JdSeNF58eJE8A6CTnLvI7nj7UDpmMRXUzfW+/iwDeyvxqftG9qsRE2r8kpGgX31
         JLIrz0qxNoZzg4K5SdTPTtwzy6T33PrUNh8aYNctW5tOAHzAz8FDsYoUUL7gtOiGFh4h
         nHymePuFUWZNiV0ed1SBxCpSNzfSPyKHa9oL4vde/vJI1nl8JV/NN+//y0qoi46f7+PE
         iBUw==
X-Forwarded-Encrypted: i=1; AFNElJ9JhYEvbfa2a0sVXVtqIN9ax1TRJCcF5w/Lx10/tAqwZg572IeSh9mGOasyZ3qwq0ueRfCxJ11/wct9HFn3Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9tFmDNjaBmsj1VjmMI5P6Vsn+zsFyBUcg/yTRrFGLzRV5TXl
	0f/VM8aOwHsZrVACJ0np2eV8+6ZrHVQDYC3JKd44toIrNr3/xhmbJZB1
X-Gm-Gg: Acq92OE92SxYF13bRqexX9uU73YLuH4F9b200cgvK5rea64fh8XuZz4sPNlY2fq5/gt
	ojjb3rn7MkyUKkmUWmdzYh2EeimeebxZoCegLm5REq2fW38IaTYVIm22ILtmkLmX7tErFKUyuWp
	V5UJYeKVCoijZC4SQt5fWil9KynpqbtDS/aqqnrh1Tn72p7o+Gjb8gWz0ocNEcljDf9s7U4MKgU
	7chFVAC1L7YQWf0bfVLG6B72IAMFWNGYEL3jVTnI0KJV5heGc7p4IE7+Qm6GAP7j+GvOlM2cWpr
	iHyyw/jipTo68o1/K491E/QfXP+ceUYeZPo6vX7NusQEFsJB1b0CpfUKG6jAIvphSmI7NjRptAv
	oJRLVVUxtWN1fWD04PCkkLOhFly/hYSGruq3lyna6IQGQuoj4SMmBj3kpjV7HpPGLPqrFXLfdi7
	OUbWmbEf494eHBooiycla56LIdKJCXZOOLZdnBPobKKdPrXit2WfCx4+lvYXgUj9UY
X-Received: by 2002:a05:7300:8185:b0:307:26a3:75d8 with SMTP id 5a478bee46e88-3081ff40831mr4575359eec.1.1781371913456;
        Sat, 13 Jun 2026 10:31:53 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4fe55sm8260862eec.25.2026.06.13.10.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 10:31:52 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [RFC,mt76] wifi: mt76: wed: fix kernel panic on single band MT7986
Date: Sun, 14 Jun 2026 01:31:09 +0800
Message-ID: <20260613173109.849-1-hujy652@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-37763-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: B95FF67F2DC

In mt76_wed_init_rx_buf, it's hardcoded to use MT_RXQ_MAIN.
But for single band MT7986 MT_RXQ_BAND1 is used for RX data queue which
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
Hi maintainers,

I am trying to fix WED on a MT7986 + MT7916 board.
With this patch applied, WED loads without kernel panic.
Client can connect but there's no traffic.

Maybe there's somewhere else that need to be configured for single band MT7986?

I can provide the rxinfo, txinfo dump from WED if requested.
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


