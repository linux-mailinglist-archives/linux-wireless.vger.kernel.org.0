Return-Path: <linux-wireless+bounces-24823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D42AF93A9
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 15:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17B918817C7
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF52D77E5;
	Fri,  4 Jul 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utiiFBeC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409938DDB
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634515; cv=none; b=Q8bznfv0LJo021HKR/GGiPPjge+l4i+D1+5l3WuUPud5zCLRkKsv9F3XYIdCLTkj0uAvl6EBm+vk/ks79mL3eSkFyXi1hyv3JvrTjZsmq6MPW0xM9giZLxpCMi0dmSjpooRyFFfeiJyBeZhBEvGFZLowxPw5Nuq0WahVl0H+pSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634515; c=relaxed/simple;
	bh=13s+yUJkFfS3KoiwPRRfaKBkp+syuO1jDT4DF9d14Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pkavk8AePDQb1pL9ydjoYQ/dhm9ywIZkBv8ZcCarcbQLo77KIFfT+CjYVtEmMcJgMxQ3/vwiho0HVHpwEv9VZMkLdU+9qJz/3zxXuczxHBK5o0hKH8YzObt7Q6Qx01VbojtqT3ucFUzOH34l7Ci6Z7hZB2+rnIynQKDBr+aqEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utiiFBeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E829C4CEE3;
	Fri,  4 Jul 2025 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634514;
	bh=13s+yUJkFfS3KoiwPRRfaKBkp+syuO1jDT4DF9d14Tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=utiiFBeC12pPXuC2G8rvmRsKlTB4bE8w5JKGI3ccQ8SCSpovT3aox5ZW16Zi6bPd3
	 DZ5di+LFJokeBXGySSgvwQU0dsHctEZU8tEMTOW5pZ5JKG5xFUyfMLGlHiMlcKkElm
	 gzVK7ga40TznMkN+4OFh2/2MlOmppja0xKxi/oZFZIpYGOQJlD0f9odZPkGSejTqw8
	 hLsNUfKCu8o59GnK5iShUocwuO9lrQASq9g/GCbH6lZMhI7MeBTM12S2n3MVEFJ/ud
	 OxDZSNezNHLIe2Rd59H1WT+rrxFC02tM9RnusghgC6BPv87o1OmNHFiSA8cvoPEoIR
	 MJlgDTaKKbqVw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Jul 2025 15:08:08 +0200
Subject: [PATCH mt76 4/9] wifi: mt76: mt7996: Do not set wcid.sta to 1 in
 mt7996_mac_sta_event()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-mt7996-mlo-fixes-v1-4-356456c73f43@kernel.org>
References: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
In-Reply-To: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

msta_link->wcid.sta is already set to 1 in mt7996_mac_sta_init_link
routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 5283aee619a9811f2e75fa4434ceced9185991f0..d1f90dea512bade652743611b7d062863a63ccfe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1119,7 +1119,6 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 				return err;
 
 			msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-			msta_link->wcid.sta = 1;
 			break;
 		case MT76_STA_EVENT_AUTHORIZE:
 			err = mt7996_mcu_add_sta(dev, link_conf, link_sta,

-- 
2.50.0


