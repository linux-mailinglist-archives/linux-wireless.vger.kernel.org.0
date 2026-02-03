Return-Path: <linux-wireless+bounces-31504-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN77OkkcgmmhPQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31504-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 17:03:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBCFDBA9C
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 17:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17AEE316881D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1D93BFE5B;
	Tue,  3 Feb 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E0ZIqoAX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3933BFE39
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134162; cv=none; b=UjTFE32IYygNJapWNVhYRBzZnakrmHc3mueubKw+r6jjeJ4s8/oZ9Ti4rmFC9ojLLEcQ/O7s1Uv/ngbjSI0kIeqE7O/RMqtSz3FDgRYQtYeP3b9QVmoT4WWhBqzJluZnlNhPl0BJo6z2OsSCxLx60/m7yq9t2dRP7PJq+LLyVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134162; c=relaxed/simple;
	bh=osG3glxXFR4CCsYUp8EJnc3rkNM1YMnsnsV6IkAKC8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHTU+LU6iSIsaq8UfO/gu6EECmwFEKWVTwl7cJ7nC7aox963IqyNr7//WrzrQMs+XQup3WgLuemeHbvrs7IcIoEFxUW6ODfkwKahh/Y8l0ewuC6XmjeJqPgp1KlBTQPUjkNLMA3/XZrOB8BPlFkQkJXtrtzZrpXmJUAoUMG8Pro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E0ZIqoAX; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ce6f48d6011811f185319dbc3099e8fb-20260203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ocAdPwmDzHKxnVSldZBqLpITOD8v7ybbeSfd2Tme2zo=;
	b=E0ZIqoAXcjAX1JYD6BnXHRCbQyg/hRhjqvoml8j7mO0Litpqun/nchz5kjQ+RXg2+DjfdgkamyZIfsgh/NYdZmdPzn+Wd6mk4q3/n8RgPEz6p7WMMvhKDpWQWATJ9qEOB9pDMph+3TbDPws2Uh8FO8oq+pWLpEggFzMVn/jbl28=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:890c6ca5-8aa3-4556-9f80-a73b29cc30e3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:ed57e25a-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ce6f48d6011811f185319dbc3099e8fb-20260203
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1908337350; Tue, 03 Feb 2026 23:55:47 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Feb 2026 23:55:46 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 3 Feb 2026 23:55:46 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 v2 3/4] wifi: mt76: avoid to set ACK for MCU command if wait_resp is not set
Date: Tue, 3 Feb 2026 23:55:31 +0800
Message-ID: <20260203155532.1098290-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260203155532.1098290-1-shayne.chen@mediatek.com>
References: <20260203155532.1098290-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-31504-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,mediatek.com:dkim,mediatek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CBCFDBA9C
X-Rspamd-Action: no action

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

When wait_resp is not set but the ACK option is enabled in the MCU TXD,
the ACK event is enqueued to the MCU event queue without being dequeued
by the original MCU command request.

Any orphaned ACK events will only be removed from the queue when another
MCU command requests a response. Due to sequence index mismatches, these
events are discarded one by one until a matching sequence index is found.

However, if several MCU commands that do not require a response continue
to fill up the event queue, there is a risk that when an MCU command with
wait_resp enabled is issued, it may dequeue the wrong event skb,
especially if the queue contains events with all possible sequence
indices.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mcu.c        |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 535c3d8a9cc0..cbfb3bbec503 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -98,7 +98,7 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 	/* orig skb might be needed for retry, mcu_skb_send_msg consumes it */
 	if (orig_skb)
 		skb_get(orig_skb);
-	ret = dev->mcu_ops->mcu_skb_send_msg(dev, skb, cmd, &seq);
+	ret = dev->mcu_ops->mcu_skb_send_msg(dev, skb, cmd, wait_resp ? &seq : NULL);
 	if (ret < 0)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 285cd83e7117..68d698033e43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -322,13 +322,12 @@ mt7996_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 		uni_txd->pkt_type = MCU_PKT_ID;
 		uni_txd->seq = seq;
 
-		if (cmd & __MCU_CMD_FIELD_QUERY)
-			uni_txd->option = MCU_CMD_UNI_QUERY_ACK;
-		else
-			uni_txd->option = MCU_CMD_UNI_EXT_ACK;
+		uni_txd->option = MCU_CMD_UNI;
+		if (!(cmd & __MCU_CMD_FIELD_QUERY))
+			uni_txd->option |= MCU_CMD_SET;
 
-		if (mcu_cmd == MCU_UNI_CMD_SDO)
-			uni_txd->option &= ~MCU_CMD_ACK;
+		if (wait_seq)
+			uni_txd->option |= MCU_CMD_ACK;
 
 		if ((cmd & __MCU_CMD_FIELD_WA) && (cmd & __MCU_CMD_FIELD_WM))
 			uni_txd->s2d_index = MCU_S2D_H2CN;
-- 
2.51.0


