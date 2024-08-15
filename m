Return-Path: <linux-wireless+bounces-11499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2E6953A36
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 20:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836D41F21457
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 18:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FB452F9B;
	Thu, 15 Aug 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n79Jc737"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21C3A8CB;
	Thu, 15 Aug 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746997; cv=none; b=d1MGn2bom8nB8wO07kZLKSb6uZyeUfxMKkvYbch1UbfNRMBT411P12ZZDxl5HABgLVohDdxq5B0LQC+VSlx7mXJshPx5OsQeHchL0w33pP8D1DX2PMCoG4Ps2N5Fgee6ZSvqUUQ+hxA4u13wZPIKPTGijUVhuP1XUDjR/zgui7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746997; c=relaxed/simple;
	bh=+jqHWnrAC2O9xkqoGcAs5UI8rRiAGafwD+uBErFpfQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dlAfLLdWKSYPGGU71nsv4RvGOtXJDAEqe46A50XIe68Rxnt1uytQXOwcllkYsiroiU3ZMtNO4SeINtfocjlgEwy7NsC+SeKIrlJDPCMZh3ZK4z7+dWXtqD69G08Lhj6vMU9nkPt0K/CXWdbgRRcTZU8RgiisbjfrdPuTNbjY0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n79Jc737; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3ABC32786;
	Thu, 15 Aug 2024 18:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723746997;
	bh=+jqHWnrAC2O9xkqoGcAs5UI8rRiAGafwD+uBErFpfQc=;
	h=Date:From:To:Cc:Subject:From;
	b=n79Jc737FXakegcozT8/VHwb/i3TUEX58hqd7ItVtzRsD2mnRK4HaUZEKTK4VQ3pS
	 /EYAAvNx9pUUG+pA8/O0HvYj8tDySrit+h16/ODNTRDLZqBgLY9scaEf0u3NET7o9F
	 lIEnsgwC/D4f3ZVIl/eHqzW8+bvrYcXvfwvPea/wbm1qyiqKCTb/tFEN0HBLohjM4Y
	 U8T7PAoXAIycnEFYyA1ws+pc4xEZosU2G7bOpMvArlObtZzbIMnXPynZ6cnYxTCZFj
	 MKrxy/78xynyXAMY94MyPa9wwgrFFiruuHA9fd9lzeYTJz53917DP9FQH2LAoQKvJI
	 hLlzeMQ04+RwA==
Date: Thu, 15 Aug 2024 12:36:33 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: mt76: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Zr5KsZugaEXrApQJ@elsanto>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of multiple other structs, we use the `struct_group_tagged()`
helper to create a new tagged `struct mt76_connac2_mcu_rxd_hdr`.
This structure groups together all the members of the flexible
`struct mt76_connac2_mcu_rxd` except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct members currently causing
trouble from `struct mt76_connac2_mcu_rxd` to `struct
mt76_connac2_mcu_rxd_hdr`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct mt76_connac2_mcu_rxd_hdr`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

So, with these changes, fix the following warnings:

drivers/net/wireless/mediatek/mt76/mt7915/mcu.h:32:37: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/mediatek/mt76/mt7915/mcu.h:40:37: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/mediatek/mt76/mt7915/mcu.h:49:37: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/mediatek/mt76/mt7915/mcu.h:58:37: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 25 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  8 +++---
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4242d436de26..16689aefa227 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -115,21 +115,26 @@ struct mt76_connac2_mcu_uni_txd {
 } __packed __aligned(4);
 
 struct mt76_connac2_mcu_rxd {
-	__le32 rxd[6];
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(mt76_connac2_mcu_rxd_hdr, hdr,
+		__le32 rxd[6];
 
-	__le16 len;
-	__le16 pkt_type_id;
+		__le16 len;
+		__le16 pkt_type_id;
 
-	u8 eid;
-	u8 seq;
-	u8 option;
-	u8 rsv;
-	u8 ext_eid;
-	u8 rsv1[2];
-	u8 s2d_index;
+		u8 eid;
+		u8 seq;
+		u8 option;
+		u8 rsv;
+		u8 ext_eid;
+		u8 rsv1[2];
+		u8 s2d_index;
+	);
 
 	u8 tlv[];
 };
+static_assert(offsetof(struct mt76_connac2_mcu_rxd, tlv) == sizeof(struct mt76_connac2_mcu_rxd_hdr),
+	      "struct member likely outside of struct_group_tagged()");
 
 struct mt76_connac2_patch_hdr {
 	char build_date[16];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index b41ac4aaced7..49476a4182fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -29,7 +29,7 @@ struct mt7915_mcu_thermal_ctrl {
 } __packed;
 
 struct mt7915_mcu_thermal_notify {
-	struct mt76_connac2_mcu_rxd rxd;
+	struct mt76_connac2_mcu_rxd_hdr rxd;
 
 	struct mt7915_mcu_thermal_ctrl ctrl;
 	__le32 temperature;
@@ -37,7 +37,7 @@ struct mt7915_mcu_thermal_notify {
 } __packed;
 
 struct mt7915_mcu_csa_notify {
-	struct mt76_connac2_mcu_rxd rxd;
+	struct mt76_connac2_mcu_rxd_hdr rxd;
 
 	u8 omac_idx;
 	u8 csa_count;
@@ -46,7 +46,7 @@ struct mt7915_mcu_csa_notify {
 } __packed;
 
 struct mt7915_mcu_bcc_notify {
-	struct mt76_connac2_mcu_rxd rxd;
+	struct mt76_connac2_mcu_rxd_hdr rxd;
 
 	u8 band_idx;
 	u8 omac_idx;
@@ -55,7 +55,7 @@ struct mt7915_mcu_bcc_notify {
 } __packed;
 
 struct mt7915_mcu_rdd_report {
-	struct mt76_connac2_mcu_rxd rxd;
+	struct mt76_connac2_mcu_rxd_hdr rxd;
 
 	u8 band_idx;
 	u8 long_detected;
-- 
2.34.1


