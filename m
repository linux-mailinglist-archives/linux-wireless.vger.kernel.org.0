Return-Path: <linux-wireless+bounces-1654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6478296AB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 10:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844C11C2180C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4C3EA9D;
	Wed, 10 Jan 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L3rJUk2F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D60E552
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 54150544af9e11eea2298b7352fd921d-20240110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=T39FyNEwI6F/HZ7nRpTpZVn4jqVCtPlIlNVn7jkEgME=;
	b=L3rJUk2F6vqgZu3dmzKcUFAf9JmfBPF0X/c0kDsXh+125CYKj71TBsroVjD9mBe9L11t9ZAZzqDw57fksRm+excK6MIrHSaljpamkluD22SfHF4RAR1jV+NfwHUvVJFyiNDBpRoMcsdcH6gYLgWvzdxj8O/OTS8AHD0FBrBeNDM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b96c7f4e-cbfd-4eb0-9924-1290eecb3476,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:8c53032f-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 54150544af9e11eea2298b7352fd921d-20240110
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 368039636; Wed, 10 Jan 2024 17:55:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jan 2024 17:55:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jan 2024 17:55:02 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH v3] wifi: mt76: mt7925: fix the wrong data type for scan command
Date: Wed, 10 Jan 2024 17:54:57 +0800
Message-ID: <20240110095457.11951-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.277500-8.000000
X-TMASE-MatchedRID: dHqkmzbglWZIQkQ+2Oh2tcAmcZEx8XHJMVx/3ZYby79b6PBUqmq+UlO4
	BD7nLMxns8CcQmOfNJ/cFPFR1xoqQh8TzIzimOwP0C1sQRfQzEHEQdG7H66TyN+E/XGDLHcMTcV
	YJ/W0+IfQwa+VkK70gBRfQH7W22PyeFJEhPOce+XHT0feGj9sxPyVjEKMi9OXNlo6G1fYocNl75
	UwE60dAf2Zr4ZzVe8ZjofsMjQaxVwyYjbiqIQ3CsykhtyXcigD6rVdgBjDT2oh1j2M6LiVMg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.277500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A135D5F670C88D2A372A26A7F1C56D4384ACC8B9DB37747C26561D84A13ACF642000:8

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

For the member of 'struct scan_req_tlv', replace data type of
func_mask_ext from 'u8' to '__le32'.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
 change the data type from 'u32' to '__le32'.
v3:
 remove redundant "Change-Id tag" in commit message.
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 3c41e21303b1..98cb705e7423 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -208,7 +208,7 @@ struct scan_req_tlv {
 	__le16 channel_dwell_time; /* channel Dwell interval */
 	__le16 timeout_value;
 	__le16 probe_delay_time;
-	u8 func_mask_ext;
+	__le32 func_mask_ext;
 };
 
 struct scan_ssid_tlv {
-- 
2.18.0


