Return-Path: <linux-wireless+bounces-31070-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIlFG38FcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31070-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 12:09:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 158F865BE2
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 965456AAA2E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBFF41323D;
	Thu, 22 Jan 2026 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgd6eg2T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9541324E
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078429; cv=none; b=cUqY4qGcl26CJiWiVHOmYLKz1+3QmUiGoWds28JXvI+SIgpv2A7z/Cg/fftzYUY55g3VCWdG5O+ZK8jgsHAFowVAyDjUVWX7Zk156nabplhTqr3GDEyYvauTTp7HXZA2tj9Stc/X2hLaALfxzqEnU2fHrreKiiodXFk5rWkCuCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078429; c=relaxed/simple;
	bh=RUrGnd/oLpqhYB1Jjs8ZU9qWFxLXGaSg3bs4Yc1rsns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsVm1cVE2eEqa5wINBQdDF5AE+WlaFxdje/5jgkrazbVhuPhcZKslfmFpeMZMX1i7MXQ9pAByP8p4mJhtR5mjlRV9nRmUTHO+xki6YbwwCSwCvLAP5Lj2bYpNjguXHgO+J/F3sMHMb8AIrxpi2Jui2Hl0tlUQCJfS9zVPMYxTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgd6eg2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADB4C16AAE;
	Thu, 22 Jan 2026 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078428;
	bh=RUrGnd/oLpqhYB1Jjs8ZU9qWFxLXGaSg3bs4Yc1rsns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jgd6eg2T6AKiQWI0V6D75zpNb8Bp+d2IiKAqRcbTXrDOJhUQL40ZafGUsUnGzlw2c
	 pksXkuBpWdJRHgFiZ7oLr8jXRqO0sBZpUACwwB7l1US9CzVLb+i7mAD8izW9pj2ts9
	 3jQ8XFUTJvKYk2VRDBHS8zX/n97H3jiP6RxjpOTDQm939VbVzEwFZ1Fc3lSNvLucKc
	 7Nt2+aMD7F5Q3Xg+h6xBJmr0qjL+IQxiGl/nwxOxIP2NYRMsaXEmfpBLiHkiVgze3k
	 9gEOIf3iPAOSye0yKoIwxn+5mWUVO5TO7KcGen+fl2GMp4HdNjjXkeOe5YBjUCpyoi
	 gzRDBmHgPBg1w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:53 +0100
Subject: [PATCH mt76 v2 09/17] wifi: mt76: mt7996: Integrate NPU in RRO
 session management
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-9-2374614c0de6@kernel.org>
References: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
In-Reply-To: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Kang Yang <kang.yang@airoha.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31070-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 158F865BE2
X-Rspamd-Action: no action

Add NPU integration in RRO 3.0 session management.
This is a preliminary patch to enable NPU offload for MT7996 (Eagle)
chipset.

Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        | 10 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 16 ++++++++++++-
 drivers/net/wireless/mediatek/mt76/npu.c         | 30 ++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d05e83ea1cacc43512f37743e1708390c3cb2f35..eefc3f555f8afea2af67517683d522b657e20b7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1649,6 +1649,9 @@ void mt76_npu_txdesc_cleanup(struct mt76_queue *q, int index);
 int mt76_npu_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct net_device *dev, enum tc_setup_type type,
 			  void *type_data);
+int mt76_npu_send_txrx_addr(struct mt76_dev *dev, int ifindex,
+			    u32 direction, u32 i_count_addr,
+			    u32 o_status_addr, u32 o_count_addr);
 #else
 static inline void mt76_npu_check_ppe(struct mt76_dev *dev,
 				      struct sk_buff *skb, u32 info)
@@ -1707,6 +1710,13 @@ static inline int mt76_npu_net_setup_tc(struct ieee80211_hw *hw,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int mt76_npu_send_txrx_addr(struct mt76_dev *dev, int ifindex,
+					  u32 direction, u32 i_count_addr,
+					  u32 o_status_addr, u32 o_count_addr)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_MT76_NPU */
 
 static inline bool mt76_npu_device_active(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 9fbe4235de0d0d42776d5661fa1c297e431b8d27..03c1ccb49ef02ebe9c2ae91db836593e680ee2c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -941,6 +941,12 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 			addr++;
 		}
 
+		if (is_mt7996(&dev->mt76) &&
+		    mt76_npu_device_active(&dev->mt76))
+			mt76_npu_send_txrx_addr(&dev->mt76, 0, i,
+					dev->wed_rro.addr_elem[i].phy_addr,
+					0, 0);
+
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
 		    mtk_wed_get_rx_capa(&dev->mt76.mmio.wed)) {
@@ -1001,6 +1007,10 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 		addr++;
 	}
 
+	if (is_mt7996(&dev->mt76) && mt76_npu_device_active(&dev->mt76))
+		mt76_npu_send_txrx_addr(&dev->mt76, 1, 0,
+					dev->wed_rro.session.phy_addr, 0, 0);
+
 	mt7996_rro_hw_init(dev);
 
 	return mt7996_dma_rro_init(dev);
@@ -1087,8 +1097,12 @@ static void mt7996_wed_rro_work(struct work_struct *work)
 				     list);
 		list_del_init(&e->list);
 
-		if (mt76_npu_device_active(&dev->mt76))
+		if (mt76_npu_device_active(&dev->mt76)) {
+			if (is_mt7996(&dev->mt76))
+				mt76_npu_send_txrx_addr(&dev->mt76, 3, e->id,
+							0, 0, 0);
 			goto reset_session;
+		}
 
 		for (i = 0; i < MT7996_RRO_WINDOW_MAX_LEN; i++) {
 			void *ptr = dev->wed_rro.session.ptr;
diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wireless/mediatek/mt76/npu.c
index 9679237f739842bd44497e0b1022a868cb3a0d6c..bc8f2012be9dbe2c7fc1fc885b6135d796d8c0d6 100644
--- a/drivers/net/wireless/mediatek/mt76/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -390,6 +390,36 @@ int mt76_npu_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_npu_net_setup_tc);
 
+int mt76_npu_send_txrx_addr(struct mt76_dev *dev, int ifindex,
+			    u32 direction, u32 i_count_addr,
+			    u32 o_status_addr, u32 o_count_addr)
+{
+	struct {
+		__le32 dir;
+		__le32 in_count_addr;
+		__le32 out_status_addr;
+		__le32 out_count_addr;
+	} info = {
+		.dir = cpu_to_le32(direction),
+		.in_count_addr = cpu_to_le32(i_count_addr),
+		.out_status_addr = cpu_to_le32(o_status_addr),
+		.out_count_addr = cpu_to_le32(o_count_addr),
+	};
+	struct airoha_npu *npu;
+	int err = -ENODEV;
+
+	rcu_read_lock();
+	npu = rcu_dereference(dev->mmio.npu);
+	if (npu)
+		err = airoha_npu_wlan_send_msg(npu, ifindex,
+				WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
+				&info, sizeof(info), GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt76_npu_send_txrx_addr);
+
 void mt76_npu_disable_irqs(struct mt76_dev *dev)
 {
 	struct airoha_npu *npu;

-- 
2.52.0


