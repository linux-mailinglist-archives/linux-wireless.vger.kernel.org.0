Return-Path: <linux-wireless+bounces-29053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D842DC64B0E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 15:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F02A1362F90
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7B25F98A;
	Mon, 17 Nov 2025 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Jvc2N0SS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4D286426
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390499; cv=none; b=UD/WJpUcBLT4eBwulghpsf9ixCjmj3mEaYH7UZxNxrPcGj1nHRy9fGTZ+KphhkE3b+oh8iAvjcKe1n9uAq3q+S1dEUaM/0M+ap2Kw952jAj/tuNTVZBCHyXvy8d2swKlRSKY7g08cWrHH5b7n7YqOt57sQoTsDN4UqixQZlcyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390499; c=relaxed/simple;
	bh=bR0QgViIAZRrLw1MOodcJJtEH7NOHouCxR7gxm5XmOY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UT1w5zBwTJMA3Ore3wdSrjVfc1Y6PZJlGjaoddUcTcGGt4lG0vqj9ZGwGTx0yU/g3mf6NY28dp0QPPtnoVmyWJVzYoJAOCDB8VHaeK6qUbkMragAl80Kb52XXcnlBwTSKh5zg4SUuItpOCDSk0ZD0othy0oIUTCuvXKwVei7P/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Jvc2N0SS; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 81e3bfb6c3c311f0b33aeb1e7f16c2b6-20251117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=paTh/uzV29JcO52gAfWUROJmLyr2vTU+CHmJgYMQkKY=;
	b=Jvc2N0SSigmNmJ2rv9s9LKJRzAjyZMjPR1oL2tJmLfpKQW5yH9ft9hv5GyF3McKjyr2wFtWyR1pYv4x1uNZy7dy9ooykK+YGYwi7ESxBiVnZaMa9G349VnbXwwVyW3ISaNROjn0kmeQg8ZCyw2/KtGvmH+Gokm8JVLPJxDzwZh0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d33dd7fb-d55c-4a7e-bb37-303a708b5361,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:18,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:18
X-CID-META: VersionHash:a9d874c,CLOUDID:c942fd57-17e4-43d2-bf73-55337eed999a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81e3bfb6c3c311f0b33aeb1e7f16c2b6-20251117
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1909800378; Mon, 17 Nov 2025 22:41:31 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 17 Nov 2025 22:41:30 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 17 Nov 2025 22:41:30 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: linux-firmware <linux-firmware@kernel.org>
CC: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>
Subject: pull-request: mt76 firmware 20251117
Date: Mon, 17 Nov 2025 22:41:30 +0800
Message-ID: <20251117144130.2214135-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Hi,

This contains the WiFi firmwares for MT7996, MT7992, and MT7990 chipsets.

Please let me know if there's any problem.

Thanks,
Shayne
---

The following changes since commit fb0dbcd3011839d85920d1e4aa956f6a84700caf:

  Merge branch 'amd-ucode' into 'main' (2025-11-13 22:26:11 +0000)

are available in the Git repository at:

  https://github.com/csyuanc/linux-firmware.git mt76-20251117

for you to fetch changes up to 05895b31008ae27cc8a8f9a44e014f09595a736c:

  mt76: add firmware for MT7990 (2025-11-17 22:08:46 +0800)

----------------------------------------------------------------
Shayne Chen (3):
      mt76: update firmware for MT7996
      mt76: update firmware for MT7992
      mt76: add firmware for MT7990

 WHENCE                                   |  41 +++++++++++++++++++------------
 mediatek/mt7996/mt7990_eeprom.bin        | Bin 0 -> 7680 bytes
 mediatek/mt7996/mt7990_eeprom_2i5i.bin   | Bin 0 -> 7680 bytes
 mediatek/mt7996/mt7990_rom_patch.bin     | Bin 0 -> 12832 bytes
 mediatek/mt7996/mt7990_wm.bin            | Bin 0 -> 1336664 bytes
 mediatek/mt7996/mt7992_dsp.bin           | Bin 63536 -> 63572 bytes
 mediatek/mt7996/mt7992_dsp_23.bin        | Bin 63536 -> 63536 bytes
 mediatek/mt7996/mt7992_rom_patch.bin     | Bin 20640 -> 20896 bytes
 mediatek/mt7996/mt7992_rom_patch_23.bin  | Bin 20640 -> 20896 bytes
 mediatek/mt7996/mt7992_wa.bin            | Bin 536240 -> 515184 bytes
 mediatek/mt7996/mt7992_wa_23.bin         | Bin 536240 -> 515184 bytes
 mediatek/mt7996/mt7992_wm.bin            | Bin 1712336 -> 1742052 bytes
 mediatek/mt7996/mt7992_wm_23.bin         | Bin 1672256 -> 1701216 bytes
 mediatek/mt7996/mt7996_dsp.bin           | Bin 191704 -> 191728 bytes
 mediatek/mt7996/mt7996_rom_patch.bin     | Bin 23968 -> 37216 bytes
 mediatek/mt7996/mt7996_rom_patch_233.bin | Bin 23968 -> 37216 bytes
 mediatek/mt7996/mt7996_wa.bin            | Bin 516272 -> 509232 bytes
 mediatek/mt7996/mt7996_wa_233.bin        | Bin 516272 -> 509232 bytes
 mediatek/mt7996/mt7996_wm.bin            | Bin 2622816 -> 2655416 bytes
 mediatek/mt7996/mt7996_wm_233.bin        | Bin 2620960 -> 2681656 bytes
 20 files changed, 25 insertions(+), 16 deletions(-)
 create mode 100644 mediatek/mt7996/mt7990_eeprom.bin
 create mode 100644 mediatek/mt7996/mt7990_eeprom_2i5i.bin
 create mode 100644 mediatek/mt7996/mt7990_rom_patch.bin
 create mode 100644 mediatek/mt7996/mt7990_wm.bin

