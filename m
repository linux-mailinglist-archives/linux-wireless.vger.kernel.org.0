Return-Path: <linux-wireless+bounces-6915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28308B2FC0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 07:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E8F283E5E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 05:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6515F13A261;
	Fri, 26 Apr 2024 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N+OcpvxN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED61849
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109587; cv=none; b=rM/t0I5202ISpLEK3m9pIVGsQrzPUN4zWeegjt7ZcNaUnIrRjgd8TlhZdE7FSWLKK1/B2iujwUzCi21SpifT82oQYkr6FjMssjQMlfIqFix2lj81lCEPTAGcC6zajP4reozWBpvALiA9sNuzTdfuFp+YHd4u75liwXVeeQkGEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109587; c=relaxed/simple;
	bh=brClYu0FB9m2gvpJZRRvhoAWgOAcxGt2XhXXp5BDmy4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=epzr4cifTYX+WR70Y0nLgZ4hMhIhFY4S6yJWKdFFWdRzgt4CBYzTc+ZqpfYUcCLPT008nINumHqMBqoQiOtfhzkYvQS68pbrdGTpNeJew83b1WOsOIARAI0zNkcqoIsRMEFoZknkMHB0Boorw/R3RxM6al0GITcWNnVzX+huArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N+OcpvxN; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6e700fee038e11ef8065b7b53f7091ad-20240426
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4LCrjhDaL8ypFniNCchNygF9gHvRZ2+FyqZFGJS8hII=;
	b=N+OcpvxNTgr4xPnEBv2WNf/k+PR2HgQjBSOWovv/pKpmQIPsO9ly6HM0cidZoEsQwLKP/CG53AqO6b3zETm2Em1CeMjcPgrgTMcyQZBJAiuoogeektSgX0SAdiW9hSJYf/5t5eLq80aolrDd6vz9FxrqdoCSgOVKKT4X1kGnktg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a062eca0-66b9-41d9-b488-c27c48efbbcd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:a4e82283-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 6e700fee038e11ef8065b7b53f7091ad-20240426
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 959930615; Fri, 26 Apr 2024 13:32:54 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 Apr 2024 22:32:53 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 Apr 2024 13:32:53 +0800
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
Subject: [PATCH] wifi: mt76: mt7921: fix sparse warning for incorrect data type definition
Date: Fri, 26 Apr 2024 13:32:49 +0800
Message-ID: <20240426053249.7034-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Sparse warn:
drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:263:20: warning: cast to restricted __le32

For the member of 'struct mt76_connac_rssi_notify_event',
replace data type of rssi from 's32' to '__le32'

Fixes: f01224e61c74 ("wifi: mt76: mt7921: cqm rssi low/high event notify")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404251728.k3Q4OQ2V-lkp@intel.com/
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 340942fd6785..6873ce14d299 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1460,7 +1460,7 @@ struct mt76_connac_beacon_loss_event {
 } __packed;
 
 struct mt76_connac_rssi_notify_event {
-	s32 rssi[4];
+	__le32 rssi[4];
 } __packed;
 
 struct mt76_connac_mcu_bss_event {
-- 
2.18.0


