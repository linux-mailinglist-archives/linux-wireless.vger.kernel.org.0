Return-Path: <linux-wireless+bounces-21639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87671A91DB1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33ACC7AFD93
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC123E22B;
	Thu, 17 Apr 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MeOblCg/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZHCL3HKn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA82376E6;
	Thu, 17 Apr 2025 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896140; cv=none; b=moVbkS4EgN8PViuF9OCHTYdVhcSSRRvZiTxXs+HSWrOIoCcGh3ucbaKJTrPj32ZoHs+N7hltyMNaZSqxRAloD5TGxuqkpFrrPb8RvyzPbYkA7SmGbv6AhGwENKc8xGUNfwI4vaeYEgnDk4KcYfnT+dg35+BVWGu9KC9L5J1JJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896140; c=relaxed/simple;
	bh=ik4yyhcU8jgswd+NtfzGVUXGJUNQisUDoA4lQE9/eno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JzG34WHkjCeKYlB6M7oI9xnGK9gjEOUhDRiuHzBmahRjdBcRYXiyQsMM9uSAyMDa6lU5+kOpQwH9wr4/3AklqIQWk96/12c/pLpbeTkxK2ih6tQQUVCSh5dbhQVmjGYygH8TCsUL3fcHD5uiG4tIN9qLyfv/SbjuX7HfK71I5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MeOblCg/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZHCL3HKn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744896137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LL3Om1CQV7/B9h3iAO3+lpGzVzoHmKfBTyBvybZrEYo=;
	b=MeOblCg/RNRK11gQcdDVTxWd2Xn2Q3u3wG+CQj86SDs8fByW3TkGZvnQlJ8Gepmvn0FyR+
	kQrxQjXXkW/4eG5P7gKOXxxH6AcFINz+58itRC3IItpWPrcujqQmWa7no85MYoX5t1L5EM
	RpoyNKGW4z2zvyasoxum/WL9YZttEEW9hMRoc4Qkfyg0BtlmgW/RuXKa+5KgXxupicTtBK
	eSVEUdaZiT0zZ2fUlOqj2GMrSUTHIVCW4qV2W3efP9+chyDEmYc1K+gAS7oB3EW2PTJKHz
	ZaoTiRhVGAD7WLU0BE3B/+FYO/SduFfAX91tgR9yJEXDm/jcef0g3LGdVTogLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744896137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LL3Om1CQV7/B9h3iAO3+lpGzVzoHmKfBTyBvybZrEYo=;
	b=ZHCL3HKno7ya0Efm59ULAjGN59waN3eS+WTKRJK/OezcqJmiLegK5j4BkV7dAeFYYdsEp4
	49gACDe4VDg12FDg==
Date: Thu, 17 Apr 2025 15:21:54 +0200
Subject: [PATCH wireless-next] wifi: mwifiex: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250417-restricted-pointers-wifi-v1-1-b79cdaae5579@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHEAAWgC/x3MwQqDMBBF0V+RWXdAg63QXyldSPLSPihRZkIVx
 H9v6PIs7j3EYYTLvTvE8KVzKQ3DpZP4nssLytQsoQ/XfhwmNXg1xoqk68JSYa4bMzVMc5zHfEs
 xQFq+GjL3//ohGw0fuGvBXuV5nj8fVTRYeQAAAA==
X-Change-ID: 20250417-restricted-pointers-wifi-27aca4f6dc2e
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744896137; l=1819;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ik4yyhcU8jgswd+NtfzGVUXGJUNQisUDoA4lQE9/eno=;
 b=FSHEuH9ei3I4nUx1dSzL2AxG0vO2/VuXuOigPV+CjdMcXBA/6UeZFhuofn6Wt0IDGFC1hhEUO
 6cvosipEIEACw153QAx6AKEtQoPfwdzaXqijuRZEdjd2xJutB0wI57l
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
This was originally part of
https://lore.kernel.org/lkml/20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de/
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index dd2a42e732f2398892915e1a3ac88b7d3fb4ed3f..a760de191fce7340040b1bc74efb35cf52ce8368 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2971,7 +2971,7 @@ static int mwifiex_init_pcie(struct mwifiex_adapter *adapter)
 		goto err_iomap2;
 	}
 
-	pr_notice("PCI memory map Virt0: %pK PCI memory map Virt2: %pK\n",
+	pr_notice("PCI memory map Virt0: %p PCI memory map Virt2: %p\n",
 		  card->pci_mmap, card->pci_mmap1);
 
 	ret = mwifiex_pcie_alloc_buffers(adapter);

---
base-commit: cfb2e2c57aef75a414c0f18445c7441df5bc13be
change-id: 20250417-restricted-pointers-wifi-27aca4f6dc2e

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


