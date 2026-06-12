Return-Path: <linux-wireless+bounces-37756-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S3iEHOloLGpCQgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37756-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 22:15:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D81A167C3F2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 22:15:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h+lSchtS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37756-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37756-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF74A30D5C9D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 20:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4DE35AC00;
	Fri, 12 Jun 2026 20:15:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B61D6BB;
	Fri, 12 Jun 2026 20:15:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295333; cv=none; b=UIJES+fTyuz6dS9mLwuw1VUBSCljFAMc99/T3qS+o5YjiDl10ujaZvbuWlIaIs9s/DzrvauUMdG1i+VN1CYVJQ6Y5a3imTFkpHywvptvwYRQRzahFKPEM0k84JQKdIAwwM1UGpi+39skZJ7Jk3fmHSq9JKXafq723ACDXCilVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295333; c=relaxed/simple;
	bh=9lsPaOAQQzgi9BEFCudf3/phOxp8fGkCLOaSD33Aexo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qD+KD8bG87wMOOWa+9U8OxMLsi6kwlC9jl/T6B+PHGvDFxZ3TRAdL6+ZthS939IfkfkDtvFpFMP7ChsCcM//ZI4DJh0YrH2xgDQbNkqdJoVfl0nf4VjnqwIqZe/pxBEqc6Y/mAj14xk3khVeVFkuSrHveukTnknbpVPe1YDJ7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+lSchtS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EE01F000E9;
	Fri, 12 Jun 2026 20:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781295331;
	bh=JFLLIafIg2RN3lK3a2syVcO/tejcNuhPUiFDic1ff7A=;
	h=From:To:Cc:Subject:Date;
	b=h+lSchtSegzbf7cESfcBDapSMYwPK1AzgV95HWmnL6iyWpNumaMAVTn/QfoUe89Jn
	 Xzrxic5EfnVQECpweIxMdCYGo6PCQpb7zWxJ4OiJmuLMnOJlab6dW9Ntc+m1O4kkDF
	 regR/kyq/TzphCLoXxyZZ8B/rT55vNFLLcYerPPCLAUZ/7NBpaCcBQOXnJMdsgWA3r
	 dsW0JV6mqyaRWB4bys9I4R6UupwC5AYISkHq2y6DxeR3f3wZHu+RUB5ALDrpml1Vfx
	 3w/pr9tVWgRcBr7Vqw2hqj+pCHxiZHsoSNiS8gweHT+EZipjbnb0d9VEldGIAycVKo
	 Np5pzxYT8XYgg==
From: Arnd Bergmann <arnd@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rex Lu <rex.lu@mediatek.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] [wireless-next v2] wifi: mt76: fix airoha_npu dependency tracking
Date: Fri, 12 Jun 2026 22:13:19 +0200
Message-Id: <20260612201519.4054683-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37756-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:angelogioacchino.delregno@collabora.com,m:arnd@arndb.de,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:rex.lu@mediatek.com,m:sujuan.chen@mediatek.com,m:benjamin-jw.lin@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,mediatek.com,gmail.com,vger.kernel.org,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D81A167C3F2

From: Arnd Bergmann <arnd@arndb.de>

There is a new build failure with MT7996E=m MT76_CORE=y and NET_AIROHA_NPU=m:

ld.lld: error: undefined symbol: airoha_npu_get
ld.lld: error: undefined symbol: airoha_npu_put
>>> referenced by npu.c
>>>               drivers/net/wireless/mediatek/mt76/npu.o:(mt76_npu_init) in archive vmlinux.a

Fix this by reworking the dependency for the MT7996_NPU to only
allow enabling that when mt76_core can link against the npu driver.

To make sure this gets caught more easily in the future when additional
mt76 variants need the same dependency, also turn CONFIG_MT76_NPU into
a tristate symbol that has the same dependency.

Fixes: 7fb554b1b623 ("wifi: mt76: Introduce the NPU generic layer")
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
v2: fix typo s/MT76/MT76_CORE/
---
 drivers/net/wireless/mediatek/mt76/Kconfig        | 4 ++--
 drivers/net/wireless/mediatek/mt76/Makefile       | 6 +++++-
 drivers/net/wireless/mediatek/mt76/mt76.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 502303622a53..2ca96e0527c0 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -38,8 +38,8 @@ config MT792x_USB
 	select MT76_USB
 
 config MT76_NPU
-	bool
-	depends on MT76_CORE
+	tristate
+	depends on NET_AIROHA_NPU=y || MT76_CORE=NET_AIROHA_NPU
 
 source "drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig"
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 1d42adfe8030..cacdd2b13d05 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -12,7 +12,11 @@ mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
 	tx.o agg-rx.o mcu.o wed.o scan.o channel.o
 
-mt76-$(CONFIG_MT76_NPU) += npu.o
+ifdef CONFIG_MT76_NPU
+# CONFIG_MT76_NPU is tristate to simplify dependency tracking,
+# but it behaves as a bool symbol here.
+mt76-y += npu.o
+endif
 mt76-$(CONFIG_PCI) += pci.o
 mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 07955555f84d..60bd155cc7d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1647,7 +1647,7 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
 int mt76_testmode_set_state(struct mt76_phy *phy, enum mt76_testmode_state state);
 int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len);
 
-#ifdef CONFIG_MT76_NPU
+#if IS_ENABLED(CONFIG_MT76_NPU)
 void mt76_npu_check_ppe(struct mt76_dev *dev, struct sk_buff *skb,
 			u32 info);
 int mt76_npu_dma_add_buf(struct mt76_phy *phy, struct mt76_queue *q,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
index 5503d03bf62c..5742bce12fbb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
@@ -16,6 +16,6 @@ config MT7996E
 config MT7996_NPU
 	bool "MT7996 (PCIe) NPU support"
 	depends on MT7996E
-	depends on NET_AIROHA_NPU=y || MT7996E=NET_AIROHA_NPU
+	depends on NET_AIROHA_NPU=y || MT76_CORE=NET_AIROHA_NPU
 	select MT76_NPU
 	default n
-- 
2.39.5


