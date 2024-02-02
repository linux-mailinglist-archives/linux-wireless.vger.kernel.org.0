Return-Path: <linux-wireless+bounces-3067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A7847D68
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 00:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632D51C24076
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 23:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD512C7FB;
	Fri,  2 Feb 2024 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UzSf0zUS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28412C7EF
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918140; cv=none; b=iD5lnD0vD3Y7sBRplNokUtrlqFlRPRM9PdOXUEqtislifAm6Ynb2ETB2JP5qgo+6Qfs9pM6490MNnSY+QBy+ahdcGkxrC3htzAWqohnNjII/H2/29uCdGG04NdGLNB3eEwtjmumw2r26kapQ36aG2ofIUUSipup+dUqaLCU5VaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918140; c=relaxed/simple;
	bh=bEIqyEqvWVJFpGggJaB54kaxt5/+46xyfVBUfLcdq1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z0OCL+t2ydCPRXYmET0z3qn+PSAhpy1mCf1ehKhneLd7EKxxaRA0WBjYU1kPPKcB+vwNeGM72sve7yn9kLI9ah2LY8yVZzlfvLvUObMwNhk8sHtGGbG0yV6X+z25tNUxtxW/kmVZlVBvdkHMFp+95PAWrBBOsBEAQ2lvgovdOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UzSf0zUS; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8c1655fcc22611ee9e680517dc993faa-20240203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zQJoHtr6kZX//paLsJxCwe6f5rGwtDs/Iq1f5k3UhHw=;
	b=UzSf0zUSTQuNg+q/NdE1YuZ1mQ9P5HOG/ZPElKZiW3+xpn/3NltErVxWzuXnhvN5x1HlwURLl+j1ieFRo3Dj5tRyD4ZU3I2/irTe/DXmNgGHja/DaofakVSaKoSgW9QlKEU5yH5SGEeAHC5Y3yLrkx775IpT1R+SBevobiU5ycw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:84a8c1c4-4eb1-4a84-b1d6-2dc04a900e78,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:94af9083-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8c1655fcc22611ee9e680517dc993faa-20240203
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <sean.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1465572004; Sat, 03 Feb 2024 07:55:30 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 3 Feb 2024 07:55:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 3 Feb 2024 07:55:28 +0800
From: <sean.wang@mediatek.com>
To: <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC: <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<Deren.Wu@mediatek.com>, <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
	<Eddie.Chen@mediatek.com>, <jsiuda@google.com>, <frankgor@google.com>,
	<kuabhs@google.com>, <druth@google.com>, <abhishekpandit@google.com>,
	<shawnku@google.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH] Bluetooth: btusb: medaitek: fix double free of skb in coredump
Date: Sat, 3 Feb 2024 07:55:27 +0800
Message-ID: <ca2b3447d110874d90e93c6ddf972f4ad2bc70f9.1706917839.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.871400-8.000000
X-TMASE-MatchedRID: h1RQRfN38kBBHBd/Q+ztB836paW7ZnFojzwigoyOACRsXGlmkQWwsGlF
	7OhYLlctx2BEc3TqpBinpDsu3n08Ua6UR+fsf9oDt1AhvyEKdj7q0SQ1Mgx5CCow3ZvJGhxdo8W
	MkQWv6iXBcIE78YqRWvcUt5lc1lLgjMejjvPkBr7CXNRjgnxEVmvGYDAk6g5raficDAY9/J+ie5
	1PgmVSaHP9GvnbPYCDNvb1q9GK2gqwNIPqSKPc3GnBYxaf8hmnVv7SclLCXxZ5lSmbrC6fdtr/T
	o2FgNrjDLMIOOVTHz2nbLeYgH6K31Zca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.871400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8881B210406C035746BB32A16C81758E08B15855A9DE5098F836813435D2C0DC2000:8
X-MTK: N

From: Sean Wang <sean.wang@mediatek.com>

hci_devcd_append() would free the skb on error so the caller don't
have to free it again otherwise it would cause the double free of skb.

Fixes: 0b7015132878 ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
Reported-by : Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index aaabb732082c..e882613036a0 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -378,8 +378,10 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 	switch (data->cd_info.state) {
 	case HCI_DEVCOREDUMP_IDLE:
 		err = hci_devcd_init(hdev, MTK_COREDUMP_SIZE);
-		if (err < 0)
+		if (err < 0) {
+			kfree_skb(skb);
 			break;
+		}
 		data->cd_info.cnt = 0;
 
 		/* It is supposed coredump can be done within 5 seconds */
@@ -405,9 +407,6 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	}
 
-	if (err < 0)
-		kfree_skb(skb);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(btmtk_process_coredump);
-- 
2.25.1


