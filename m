Return-Path: <linux-wireless+bounces-29080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C8C67EED
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 08:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 43A612A0DE
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 07:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E6026B75C;
	Tue, 18 Nov 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="9l6AP6L5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53B26FA4E;
	Tue, 18 Nov 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450863; cv=none; b=l1FQ5k2n6Fc9RXIw16+9dP05b01dC0EHXctZtt3+edgqDkxXrTjiFvXXXqu81x/A9M3iBkDXDBrHjIyzGQM8hEDY2OHbNjak7VpbD/hMLTtX6x4oZ2nAynlaldXcNCLQEfH31OmbbHoYxvnLAvWjc7L2wADGagMC7bCM/Ve8Csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450863; c=relaxed/simple;
	bh=kfdUWwMVdCt8v+xix914qHO0JwCuom/SCwwjXK/0dl4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NuAZyctN7Q5OCYCUQk+HCTve2ZZJt2yuLurUgVg6TG5NqLqE2FlmZQLv7lNxqT3r3TWJtQ4RSquQu1+icfCcPby9B8nXkMIG3+Ji6EWOxTumFe7niu0vPmRjRE6YXDDFXvVqR+oPrVuBrR8p25R7K84d4yZmdpXr+K6DQtVDHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=9l6AP6L5; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=QyjtY4t8aFYtS2xu/rSUjq+Q4C16yLey9yYnSrlAjN8=; b=9l6AP6L5OQr92Wl73ipb4U/G9R
	/F463q5RRAtyqLtxkQgRSUVhovtiHIw8M2w0+L3V6X4NewbB4EfXGUs67i+22vvyhFApOy/W1O8TR
	AUfgmblJhIQSK+kiYGiNlbcOs6sRyWsbHGA9FhaH+V0PzcEHmFQps3bBdoo8kz2AhUoWpX3VpVD4w
	Xp/kLUqi3FuMZJL8n4oYxbhK7p1+JGhOv1Te+JES4FAOaRFM7J+n5T+R+1udGC0hf46m0BI+dDJyL
	WvY9UwdGYzwn2VN513GSgvoWyUKOccRWP0dKgapa6HkpgtjT/jcwLAdWzyAy5d77aCzXa5fbrQhld
	oBS2Fo8Q==;
From: Andreas Kemnade <andreas@kemnade.info>
To: briannorris@chromium.org,
	francesco@dolcini.it,
	christophe.jaillet@wanadoo.fr,
	johannes.berg@intel.com,
	rafael.beims@toradex.com,
	andreas@kemnade.info,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s.hauer@pengutronix.de
Subject: [RFC PATCH] wifi: mwifiex: try to fix some races with rmmod/modprobe
Date: Tue, 18 Nov 2025 08:25:26 +0100
Message-ID: <20251118072527.174375-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To debug some stability issues, some torture was done with the driver:
Doing rmmod mwifiex_sdio  and modprobe mwifiex_sdio in a loop

this oops appeared:

[ 3261.934299] mwifiex_sdio mmc1:0001:1: PREP_CMD: FW is in bad state
[ 3261.988412] mwifiex_sdio mmc1:0001:1: info: shutdown mwifiex...
[ 3261.990081] mwifiex_sdio mmc1:0001:1: PREP_CMD: card is removed
[ 3262.052407] mwifiex_sdio mmc1:0001:1: ===mwifiex driverinfo dump start===
[ 3262.052864] mwifiex_sdio mmc1:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (16.92.21.p119)
[ 3262.053252] mwifiex_sdio mmc1:0001:1: SDIO register dump start
[ 3262.084733] mwifiex_sdio mmc1:0001:1: SDIO Func0 (0x0-0x9): 43 03 02 02 00 00 00 02 03 00
[ 3262.085574] mwifiex_sdio mmc1:0001:1: SDIO Func1 (0x10-0x17): 00 00 00 00 ff ff ff ff
[ 3262.093544] mwifiex_sdio mmc1:0001:1: SDIO Func1: (0x8) 00 (0x58) 00 (0x5c) 88 (0x5d) 00 (0x60) 07 (0x61) 0c (0x62) 00 (0x64) 10 (0x65) 00 (0x66) 00 (0x68) 00 (0x69) 00 (0x6a) 00
[ 3262.103543] mwifiex_sdio mmc1:0001:1: SDIO Func1 (0xe8-0xf2): dc fe 54 00 b0 00 1f 2a 24 14 70
[ 3262.325352] mwifiex_sdio mmc1:0001:1: SDIO Func1 (0xe8-0xf2): dc fe 6d 00 c7 00 1f 2a 24 14 70
[ 3262.325843] mwifiex_sdio mmc1:0001:1: SDIO register dump end
[ 3262.326626] mwifiex_sdio mmc1:0001:1: ===mwifiex driverinfo dump end===
[ 3262.327096] mwifiex_sdio mmc1:0001:1: == mwifiex firmware dump start ==
[ 3291.379005] mwifiex_sdio mmc1:0001:1: == mwifiex firmware dump end ==
[ 3291.381143] mwifiex_sdio mmc1:0001:1: == mwifiex dump information to /sys/class/devcoredump start
[ 3291.382047] mwifiex_sdio mmc1:0001:1: == mwifiex dump information to /sys/class/devcoredump end
[ 3291.382148] 8<--- cut here ---
[ 3291.382210] Unable to handle kernel NULL pointer dereference at virtual address 00000064 when read
[ 3291.382265] [00000064] *pgd=00000000
[ 3291.382334] Internal error: Oops: 5 [#1] SMP ARM
[ 3291.426597] Modules linked in: mwifiex_sdio(-) netconsole mwifiex jd9930_regulator imx_sdma btnxpuart crc8 [last unloaded: mwifiex_sdio]
[ 3291.438980] CPU: 0 UID: 0 PID: 751 Comm: kworker/0:1 Not tainted 6.18.0-rc3-00003-g5a1efae8dc10-dirty #338 VOLUNTARY
[ 3291.449655] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
[ 3291.455829] Workqueue: events mwifiex_sdio_work [mwifiex_sdio]
[ 3291.461749] PC is at mwifiex_sdio_work+0x6d0/0x8ac [mwifiex_sdio]

card->adapter is NULL and therefore in mwifiex_sdio_card_reset_work
NULL pointer issues appear. The long execution time of the dumping
functions increases the probability that card->adapter changes
in mwifiex_sdio_card_work().

mwifiex_unregister_dev is the place to set card->adapter to NULL.
So add some NULL pointer checks to work around it a bit.
But this really smells like missing locking. So the proper solution
would be to add a mutex and locking. But it is a bit unclear
how to do that really.

This dirty fix seem to improve things when device is not touched.
But if it is used, there are other races:
- calling wiphy_unregister with invalid pointer
- rkill unregister issues
- module count going to -1

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index f039d6f19183..2808cff6fd56 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -947,6 +947,10 @@ static void mwifiex_sdio_coredump(struct device *dev)
 	struct sdio_mmc_card *card;
 
 	card = sdio_get_drvdata(func);
+	if (!card->adapter) {
+		dev_err(dev, "adapter is not valid, cannot coredump\n");
+		return;
+	}
 	if (!test_and_set_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP,
 			      &card->work_flags))
 		schedule_work(&card->work);
@@ -3019,9 +3023,19 @@ static void mwifiex_sdio_work(struct work_struct *work)
 	struct sdio_mmc_card *card =
 		container_of(work, struct sdio_mmc_card, work);
 
+	if (!card->adapter) {
+		pr_err("sdio_work: no adapter\n");
+		return;
+	}
+
 	if (test_and_clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP,
 			       &card->work_flags))
 		mwifiex_sdio_device_dump_work(card->adapter);
+
+	if (!card->adapter) {
+		pr_err("sdio_work: no adapter to reset\n");
+		return;
+	}
 	if (test_and_clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET,
 			       &card->work_flags))
 		mwifiex_sdio_card_reset_work(card->adapter);
-- 
2.47.3


