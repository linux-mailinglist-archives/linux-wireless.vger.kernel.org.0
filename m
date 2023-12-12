Return-Path: <linux-wireless+bounces-708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21B280F42C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 18:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AB11F213C1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102F7B3C8;
	Tue, 12 Dec 2023 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceS2iLLs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2EC7A221;
	Tue, 12 Dec 2023 17:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9B9C433C9;
	Tue, 12 Dec 2023 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702401274;
	bh=0is0y5MIjJZL1a2nJQ3+WOieM1cLmm0UpcX5nHtvags=;
	h=Date:From:To:Cc:Subject:From;
	b=ceS2iLLsFyMbhxsaoD2DWiCS35QLZHUdW8HSs9hsJJ7x4jreQ+qE68G0AIYt+5Yrx
	 KVwiwF0imPXk+dfes9RjhYBpvOfvxUwpumb9Cg0e2HCGl5z2+fgG8LHoGGvoDEYPYx
	 DxaqKSg5k3KJV8Jx8gd8XLg8hv4TYMghrMPKWINvNmHGNQliZOf9aAL2UmIHVwmEZC
	 oZw+rhk7ZBVdcEmiWIqL1z+71o5h4SByhC0ROCQJ86Usqzj9kdVIAawGkTsGMhfsxX
	 t46aDHMMzUfL2H4T7c46I0zHcX2osq5XL7ND93jhmAgu9J8aTVSJNb/2/mIY+tNec0
	 S+gFCOZ1tefuA==
Date: Tue, 12 Dec 2023 11:14:29 -0600
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
Subject: [PATCH v2][wireless-next/for-next] wifi: mt76: mt7996: Use
 DECLARE_FLEX_ARRAY() and fix -Warray-bounds warnings
Message-ID: <ZXiU9ayVCslt3qiI@work>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Transform zero-length arrays `rate`, `adm_stat` and `msdu_cnt` into
proper flexible-array members in anonymous union in `struct
mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
helper; and fix multiple -Warray-bounds warnings:

drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:544:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:551:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:553:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:530:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:538:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:540:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:520:57: warning: array subscript <unknown> is outside array bounds of 'struct all_sta_trx_rate[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:526:76: warning: array subscript <unknown> is outside array bounds of 'struct all_sta_trx_rate[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:526:76: warning: array subscript <unknown> is outside array bounds of 'struct all_sta_trx_rate[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:526:76: warning: array subscript <unknown> is outside array bounds of 'struct all_sta_trx_rate[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:526:76: warning: array subscript <unknown> is outside array bounds of 'struct all_sta_trx_rate[0]' [-Warray-bounds=]

This results in no differences in binary output, helps with the ongoing
efforts to globally enable -Warray-bounds.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Add Kees' RB tag.
 - Transform zero-length array `rate` into flex-array member.
 - Address five more -Warray-bounds warnings introduced by fake
   flexible array `rate`

 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 3e013b20ee5e..36cacc495c75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -206,20 +206,20 @@ struct mt7996_mcu_all_sta_info_event {
 	u8 rsv3[4];
 
 	union {
-		struct all_sta_trx_rate rate[0];
-		struct {
+		DECLARE_FLEX_ARRAY(struct all_sta_trx_rate, rate);
+		DECLARE_FLEX_ARRAY(struct {
 			__le16 wlan_idx;
 			u8 rsv[2];
 			__le32 tx_bytes[IEEE80211_NUM_ACS];
 			__le32 rx_bytes[IEEE80211_NUM_ACS];
-		} adm_stat[0] __packed;
+		} __packed, adm_stat);
 
-		struct {
+		DECLARE_FLEX_ARRAY(struct {
 			__le16 wlan_idx;
 			u8 rsv[2];
 			__le32 tx_msdu_cnt;
 			__le32 rx_msdu_cnt;
-		} msdu_cnt[0] __packed;
+		} __packed, msdu_cnt);
 	} __packed;
 } __packed;
 
-- 
2.34.1


