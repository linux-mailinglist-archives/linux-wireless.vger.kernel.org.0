Return-Path: <linux-wireless+bounces-13218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEDF986B80
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 05:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB561F237FF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 03:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D003171675;
	Thu, 26 Sep 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TAtsoqg7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162DE15921D
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 03:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727322491; cv=none; b=MM8fTxwrhamr2KVZCz3uTmLk19TdAg9qmgofQYdjT8K6esCK9RGmv2V4IYnTdrljPQB/UTofgLl0L3VJhVGf1wvvZtWUvt9JjIPdHB10XphizLH2He/tLFhdDxVOsPcIwPwL9vg9Kp9ui2KKRDm4NQcnoigd2wlIfCqZuIZ1TtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727322491; c=relaxed/simple;
	bh=70wiDrZR3Tn8zn+sRWHktfGRgCnOzI/zF+dCRoTwU8Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qr9pW5zqEQBVaHzedLwOE0GmGsr9Glxamr9tQV7kSDwpfNCLcZ9DJdVJJLH3Ql7hOfc7wIEEfKxu3tj1F8xaXpcXIttTiVXf5tvueDI0f9IK7laq+kRAjiRioSWf0+lwcVTf3gK4GoZjPp2oasfFJDaPAflRtigLbQPyEcxVGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TAtsoqg7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 21fc44127bba11ef8b96093e013ec31c-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Owe6JGbV57Hakcmg6rIXeMQVYrdTrF26LEqeVCxBhWM=;
	b=TAtsoqg7BeQ7ykZVfk3UuSJTBK0d2Fpb2Tkw2GHECcnr5jg/5qsL2mX3ZxbjDgX0xfDzMrhlVbrMHdPFRM8EOvPUzClyi+QiwUy92I2RXgSRNr9+fn++bwzgPiOxrPEolGqlO/TvXuiSrCPHG5pJp0OzcVK2YoLXNgjXvLG1aVM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:a12737de-cebc-43fe-bbba-193e189cdff0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:6,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:053f4518-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 21fc44127bba11ef8b96093e013ec31c-20240926
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1523962224; Thu, 26 Sep 2024 11:48:03 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 11:48:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 11:48:02 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: linux-firmware <linux-firmware@kernel.org>
CC: Felix Fietkau <nbd@nbd.name>, Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-wireless <linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Daniel Golle <daniel@makrotopia.org>
Subject: [PULL,linux-firmware] mt76 firmware 20240926
Date: Thu, 26 Sep 2024 11:48:02 +0800
Message-ID: <20240926034802.28294-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Hi,

Here's a pull request for adding WiFi firmware files for mt7996 and
mt7992 chipset variants.

Please let me know if there are any problems.

Shayne

The following changes since commit 8306534b8a7265bee2f4323b45fd2a22a7c8b9b6:

  Merge branch '8922a' into 'main' (2024-09-23 12:36:21 +0000)

are available in the Git repository at:

  https://github.com/csyuanc/linux-firmware.git mt76-20240926

for you to fetch changes up to 85ce6f7afdd3b63398990e53f67c653fc66ad271:

  mt76: mt7996: add firmware files for mt7992 chipset (2024-09-26 00:59:54 +0800)

----------------------------------------------------------------
Shayne Chen (2):
      mt76: mt7996: add firmware files for mt7996 chipset variants
      mt76: mt7996: add firmware files for mt7992 chipset

 WHENCE                                       |  43 ++++++++++++++++++++++++++++++++++++++++++-
 mediatek/mt7996/mt7992_dsp.bin               | Bin 0 -> 63536 bytes
 mediatek/mt7996/mt7992_dsp_23.bin            | Bin 0 -> 63536 bytes
 mediatek/mt7996/mt7992_eeprom.bin            | Bin 0 -> 7680 bytes
 mediatek/mt7996/mt7992_eeprom_23.bin         | Bin 0 -> 7680 bytes
 mediatek/mt7996/mt7992_eeprom_23_2i5i.bin    | Bin 0 -> 7680 bytes
 mediatek/mt7996/mt7992_eeprom_2i5e.bin       | Bin 0 -> 7680 bytes
 mediatek/mt7996/mt7992_eeprom_2i5i.bin       | Bin 0 -> 7680 bytes
 mediatek/mt7996/mt7992_rom_patch.bin         | Bin 0 -> 20640 bytes
 mediatek/mt7996/mt7992_rom_patch_23.bin      | Bin 0 -> 20640 bytes
 mediatek/mt7996/mt7992_wa.bin                | Bin 0 -> 536240 bytes
 mediatek/mt7996/mt7992_wa_23.bin             | Bin 0 -> 536240 bytes
 mediatek/mt7996/mt7992_wm.bin                | Bin 0 -> 1712336 bytes
 mediatek/mt7996/mt7992_wm_23.bin             | Bin 0 -> 1672256 bytes
 mediatek/mt7996/mt7996_eeprom_233.bin        | Bin 0 -> 7680 bytes
 mediatek/mt7996/mt7996_eeprom_233_2i5i6i.bin | Bin 0 -> 7680 bytes
 mediatek/mt7996/mt7996_eeprom_2i5i6i.bin     | Bin 0 -> 7680 bytes
 mediatek/mt7996/mt7996_rom_patch_233.bin     | Bin 0 -> 23968 bytes
 mediatek/mt7996/mt7996_wa_233.bin            | Bin 0 -> 516272 bytes
 mediatek/mt7996/mt7996_wm_233.bin            | Bin 0 -> 2620960 bytes
 20 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 mediatek/mt7996/mt7992_dsp.bin
 create mode 100644 mediatek/mt7996/mt7992_dsp_23.bin
 create mode 100644 mediatek/mt7996/mt7992_eeprom.bin
 create mode 100644 mediatek/mt7996/mt7992_eeprom_23.bin
 create mode 100644 mediatek/mt7996/mt7992_eeprom_23_2i5i.bin
 create mode 100644 mediatek/mt7996/mt7992_eeprom_2i5e.bin
 create mode 100644 mediatek/mt7996/mt7992_eeprom_2i5i.bin
 create mode 100644 mediatek/mt7996/mt7992_rom_patch.bin
 create mode 100644 mediatek/mt7996/mt7992_rom_patch_23.bin
 create mode 100644 mediatek/mt7996/mt7992_wa.bin
 create mode 100644 mediatek/mt7996/mt7992_wa_23.bin
 create mode 100644 mediatek/mt7996/mt7992_wm.bin
 create mode 100644 mediatek/mt7996/mt7992_wm_23.bin
 create mode 100644 mediatek/mt7996/mt7996_eeprom_233.bin
 create mode 100644 mediatek/mt7996/mt7996_eeprom_233_2i5i6i.bin
 create mode 100644 mediatek/mt7996/mt7996_eeprom_2i5i6i.bin
 create mode 100644 mediatek/mt7996/mt7996_rom_patch_233.bin
 create mode 100644 mediatek/mt7996/mt7996_wa_233.bin
 create mode 100644 mediatek/mt7996/mt7996_wm_233.bin

