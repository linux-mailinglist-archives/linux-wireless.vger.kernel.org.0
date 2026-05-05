Return-Path: <linux-wireless+bounces-35890-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDnPEsKF+Wmx9QIAu9opvQ
	(envelope-from <linux-wireless+bounces-35890-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 07:53:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F844C6F9A
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 07:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B32C43006B7B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 05:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2F3BE172;
	Tue,  5 May 2026 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Al1ZZamu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B53BD643
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960381; cv=none; b=I04H47JZEHN93rns8Kl1vksoygOo0DkVBDSve5tvDR3i8rBXehlAN28BRzYzvrOMwECzn9C7+xDJaoWBWQyiOpIzDHJ/kZ7BFvoBN4+mOlvxhziOlbsfjDY4n1c2cYBuuXOK4pkpJibE+5C+SZHoDDd9+gxd7EMnP0STuA10RqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960381; c=relaxed/simple;
	bh=26DwspiSfFIjlbSqv/LutwFSRN3GJxQhZbxGR1Jm3Ac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NJIlEWdSo+u+N+i58BY5dkjXIp68I9p/69ABgBvJaQU7xR4WY0uygSno6S14lGjkCNwMpGmN2LkhpHQz9nBvHec+sVl7Xr2vq7xLcBGnvOk8QdEtvpuW5WpHltIxddYtbUT1wt5rBfbCjWk9QqTVnH47XGs0eqwB6CdFO2BPsHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Al1ZZamu; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a93e0780484611f1b96f91537e34a508-20260505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZE4VB3odtA5SwhFGu6lkLTutzyz/UJ2uSkUrtsWrnts=;
	b=Al1ZZamuzh8e/h49EYAKmTLNZcqhhXiSkhkNTvvUtnKSxWcoBiGTgqU30NxXGZTnQfGDEKFlEGVbTjros+eZOn2FSWtuKg177hiEini5Fm1+SCzusm0C5xnboOgaPjf0ThNcGNmQ9azMmIU/DHtpYdFVlfKn4NuMT7T/8jhdCBM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:955021ba-0db3-48e7-9e04-bb8192ba5c60,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:3b7fe0be-65a8-4b41-ac18-3671578a914d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a93e0780484611f1b96f91537e34a508-20260505
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1978830796; Tue, 05 May 2026 13:52:54 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 5 May 2026 13:52:53 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 5 May 2026 13:52:53 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jeff.hsu@mediatek.com>, <jb.tsai@mediatek.com>,
	Jeff Hsu <Jeff.Hsu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: Add coredump callback in pci_driver
Date: Tue, 5 May 2026 13:52:52 +0800
Message-ID: <20260505055252.2558613-1-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MTK: N
X-Rspamd-Queue-Id: C3F844C6F9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35890-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:email,mediatek.com:dkim,mediatek.com:mid]

From: Jeff Hsu <Jeff.Hsu@mediatek.com>=0D

Register coredump callback(mt7925_coredump) in pci_driver,=0D
it can let platform can trigger core dump to collect the=0D
log and recover back after coredump complete without debugfs=0D
=0D
Some platform not have debugfs=0D
=0D
Signed-off-by: Jeff Hsu <Jeff.Hsu@mediatek.com>=0D
---=0D
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c |  1 +=0D
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 12 ++++++++++++=0D
 2 files changed, 13 insertions(+)=0D
=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/=
wireless/mediatek/mt76/mt7925/mcu.c=0D
index 37cdf3e8a067..cd502166a7f9 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c=0D
@@ -1014,6 +1014,7 @@ int mt7925_mcu_chip_config(struct mt792x_dev *dev, co=
nst char *cmd)=0D
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(CHIP_CONFIG),=0D
 				 &req, sizeof(req), false);=0D
 }=0D
+EXPORT_SYMBOL_GPL(mt7925_mcu_chip_config);=0D
 =0D
 int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable)=0D
 {=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/=
wireless/mediatek/mt76/mt7925/pci.c=0D
index c4161754c01d..5b3e62e5f157 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c=0D
@@ -610,6 +610,17 @@ static int mt7925_pci_restore(struct device *device)=0D
 	return _mt7925_pci_resume(device, true);=0D
 }=0D
 =0D
+static void mt7925_coredump(struct device *dev)=0D
+{=0D
+	struct pci_dev *pdev =3D to_pci_dev(device);=0D
+	struct mt76_dev *mdev =3D pci_get_drvdata(pdev);=0D
+	struct mt792x_dev *dev_792x =3D container_of(mdev, struct mt792x_dev, mt7=
6);=0D
+=0D
+	mt792x_mutex_acquire(dev_792x);=0D
+	mt7925_mcu_chip_config(dev_792x, "assert");=0D
+	mt792x_mutex_release(dev_792x);=0D
+}=0D
+=0D
 static const struct dev_pm_ops mt7925_pm_ops =3D {=0D
 	.suspend =3D pm_sleep_ptr(mt7925_pci_suspend),=0D
 	.resume  =3D pm_sleep_ptr(mt7925_pci_resume),=0D
@@ -626,6 +637,7 @@ static struct pci_driver mt7925_pci_driver =3D {=0D
 	.remove		=3D mt7925_pci_remove,=0D
 	.shutdown       =3D mt7925_pci_shutdown,=0D
 	.driver.pm	=3D pm_sleep_ptr(&mt7925_pm_ops),=0D
+	.driver.coredump =3D mt7925_coredump,=0D
 };=0D
 =0D
 module_pci_driver(mt7925_pci_driver);=0D
-- =0D
2.45.2=0D
=0D

